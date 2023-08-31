create database Mond character set 'utf8mb4';
use MOND;
create table peyi(
id_peyi int not null auto_increment primary key,
non varchar(25),
popilasyon int,
sipefisi int
);
create table kontinan(
	id_kontinan   int not null auto_increment primary key,
	non varchar(25)
);
create table lang_peyi (
	id_lang int not null auto_increment primary key,
    lang varchar (30)
);
alter table peyi add column  id_kontinan int not null;
alter table peyi add column id_lang int not null ;
alter table peyi add constraint peyi_kontinan_fk  foreign key(id_kontinan) references kontinan (non);
alter table peyi add constraint peyi_lang_fk foreign key (id_lang) references language(lang);
insert into peyi (non,popilasyon,sipefisi) values
('Ayiti',11260000,27750),
('Kanada',37590000,9985000),
('Frans',67060000,643801),
('Potigal',10280000,92212),
('Ostrali',25360000,7692000),
('Nouvèl Zelann',4917000,268021),
('Kamewoun',25880000,475442),
('Nijerya',2010000,923768),
('Chin',1398000000,9597000),
('Vyetnam',96460000,331212);
insert into kontinan (non) values
('Amerik'),
('Ewop'),
('Oseyani'),
('Afrik');
insert into lang_peyi(lang) values
	('Fransè'),
    ('Kreyol'),
    ('Anglè'),
    ('Potigè'),
    ('Mandaren'),
    ('Vyetnamyen');

update peyi set id_kontinan=1 where non='kanada' or non ='Ayiti';
update peyi set id_kontinan=2 where non='Frans' or non='Potigal';
update peyi set id_kontinan=3 where non='Ostrali' or non='Nouvèl Zelann';
update peyi set id_kontinan=4 where non='Kamewoun' or non='Nijerya';
update peyi set id_kontinan=5 where non='Chin' or non='Vyetnam';
update peyi set id_lang=1 where non='Kanada' or non='Ayiti' or non='Frans' or non='Kamewoun';
update peyi set id_lang=2 where non='Ayiti';
update peyi set id_lang=3 where non='Kanada' or  non='Ostrali' or non='Kamewoun' or non='Nijerya' or non='Nouvèl Zelann';
update peyi set id_lang=4 where non='Potigal';
update peyi set id_lang=5 where non='Chin';
update peyi set id_lang=6 where non='Vyetnam';
alter table lang_peyi add Ofisyel char (1);
alter table lang_peyi add constraint check(Ofisyel in('O','N'));
create table entemedye_lang_peyi(id_peyi int not null,id_lang int not null);
insert into  entemedye_lang_peyi (id_peyi,id_lang) values (1,2),( 2,3),(3,1),(4,4),(5,3),(6,3),(7,3),(8,3),(9,5),(10,6),(1,1),(2,1),(7,1);

SELECT p.non
FROM Peyi p
JOIN entemedye_lang_peyi elp ON p.id_peyi = elp.id_peyi
GROUP BY p.non
HAVING COUNT(elp.id_lang) > 1;

SELECT p.non
FROM Peyi p
JOIN entemedye_lang_peyi elp ON p.id_peyi = elp.id_peyi
GROUP BY p.non
HAVING COUNT(elp.id_lang) = 1;

SELECT non FROM peyi  ORDER BY popilasyon desc limit 1;
SELECT p1.id_kontinan, p1.non AS kontinan, p2.non AS peyi, p2.sipefisi
FROM peyi p2
JOIN (
    SELECT id_kontinan, non
    FROM kontinan
) p1 ON p1.id_kontinan = p2.id_kontinan
ORDER BY p2.sipefisi DESC;
SELECT p.non AS peyi, k.non AS kontinan, GROUP_CONCAT(l.lang ORDER BY l.lang ASC) AS lang_peyi
FROM peyi p
JOIN kontinan k ON p.id_kontinan = k.id_kontinan
JOIN lang_peyi l ON p.id_peyi = l.id_lang
GROUP BY p.id_peyi, k.non;
UPDATE peyi SET non='frans' WHERE non='France';
ALTER TABLE kontinan RENAME TO continent;
SELECT k.non AS continent, SUM(p.popilasyon) AS total_popilasyon
FROM continent k
JOIN peyi p ON k.id_kontinan = p.id_kontinan
GROUP BY  k.id_kontinan, k.non
ORDER BY total_popilasyon DESC;
SELECT k.non AS continent, MAX(p.sipefisi) AS maksimòm_sipèfisi
FROM continent k
JOIN peyi p ON k.id_kontinan = p.id_kontinan
GROUP BY k.id_kontinan, k.non
ORDER BY maksimòm_sipèfisi DESC;
select * from peyi


