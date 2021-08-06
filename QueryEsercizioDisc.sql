CREATE DATABASE NegozioDischi

CREATE TABLE Band(
IDBand INT IDENTITY(1,1) CONSTRAINT PK_IDBand NOT NULL PRIMARY KEY(IDBand),
Nome VARCHAR(50),
NumeroComponenti INT
);


CREATE TABLE Brano(
IDBrano INT IDENTITY(1,1) CONSTRAINT PK_IDBrano NOT NULL PRIMARY KEY (IDBrano),
Titolo VARCHAR(50),
Durata int,
);

CREATE TABLE Album(
IDAlbum INT IDENTITY(1,1) CONSTRAINT PK_IDAlbum	 NOT NULL PRIMARY KEY (IDAlbum),
Titolo VARCHAR(50) unique,
Anno DATETIME unique,
CasaDiscografica VARCHAR(50) unique,
Genere VARCHAR(20) unique,
Distribuzione VARCHAR(20) unique,
IDBrano INT CONSTRAINT FK_IDBrano FOREIGN KEY(IDBrano) REFERENCES Brano(IDBrano),
IDBand INT CONSTRAINT FK_IDBand FOREIGN KEY(IDBand) REFERENCES Band(IDBand)
);

CREATE TABLE AlbumBrano(
IDAlbum INT CONSTRAINT FK_IDAlbum FOREIGN KEY(IDAlbum) REFERENCES Album(IDAlbum),
 );

  ALTER TABLE AlbumBrano
  ADD CONSTRAINT FK_IDBrano FOREIGN KEY(IDBrano) REFERENCES Band(IDBrano);
   

 INSERT INTO Band VALUES ('883','2');
 INSERT INTO Band VALUES ('Maneskin','4');
 INSERT INTO Band VALUES ('BTS','7');
 INSERT INTO Band VALUES ('Moneskin','4');
 INSERT INTO Band VALUES ('Beatles','4');
 INSERT INTO Band VALUES ('The Giornalisti','4');
 
 INSERT INTO Brano VALUES ('Hanno ucciso l-uomo ragno','182');
 INSERT INTO Brano VALUES ('Zitti e Buoni','200');
 INSERT INTO Brano VALUES ('Imagine','190'); 
 INSERT INTO Brano VALUES ('Completamente','210');
 INSERT INTO Brano VALUES ('Butter','210');

  INSERT INTO Album VALUES ('Greatest Hits','1997','Sony Music','Pop','CD');
  INSERT INTO Album VALUES ('Greatest Hits','1980','Sony Music','Pop','Vinile');
  INSERT INTO Album VALUES ('Completamente','2019','CasaDiscografica','Pop','Streaming');
  INSERT INTO Album VALUES ('Zitti e Buoni','2018','Sony Music','Rock','Streaming');


SELECT a.Titolo, b.Nome
FROM Album a join Band b on a.IDBand = b.IDBand
WHERE b.Nome='883'
ORDER BY a.Titolo;

SELECT *
FROM Album a
WHERE a.CasaDiscografica='Sony Music' and Anno BETWEEN '2020-01-01' AND '2020-12-31';

SELECT a.Titolo
FROM AlbumBrano ab join Album a on ab.IDAlbum=a.IDAlbum
join Band b on a.IDBand = b.IDBand
WHERE b.Nome='Maneskin' and a.Anno<=2019-12-31;

SELECT *
FROM Album a join AlbumBrano ab on a.IDAlbum = ab.IDAlbum
join Brano br on br.IDBrano = a.IDBrano
WHERE br.Titolo='Imagine'
GROUP BY br.Titolo;

 
 SELECT SUM(br.IDBrano) as [Totale Canzoni]
 FROM Brano br join Album a on br.IDBrano=a.IDBrano
 group by br.Titolo;

 SELECT COUNT(br.Durata) as [Durata Totale Canzoni]
 FROM Brano br join Album a on br.IDBrano=a.IDBrano
 group by br.Durata;


 SELECT DISTINCT br.Titolo
 FROM Album a join Band b on a.IDBand=b.IDBand 
 join Brano br on br.IDBrano=a.IDBrano
 WHERE (br.Durata>'180');

 
 SELECT b.Nome
 FROM Band b
 WHERE b.Nome like 'M%' 
 and b.Nome like '%N'
 GROUP BY b.Nome;

 SELECT a.Titolo,
 CASE  
 WHEN a.Anno<='1980' THEN 'Very Old'
 WHEN a.Anno='2021' THEN 'New Entry'
 WHEN a.Anno>='2010' and a.Anno<='2020' THEN 'Recente'
 ELSE 'Old'
 END AS [Album]
 FROM Album a;

 SELECT br.Titolo
 FROM Album a, Brano br
 WHERE NOT EXISTS 
 (SELECT br.IDBrano  
 FROM Brano br JOIN Album a JOIN AlbumBrano ab 
 ON ab.IDAlbum=a.IDAlbum and br.IDBrano=a.IDBrano )
 ORDER BY br.Titolo;
 