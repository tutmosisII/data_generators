--################################################################################################################
--#                           Copyright [2017] [Universidad El Bosque]                                           #
--#                                                                                                              #
--# Licensed under the Apache License, Version 2.0 (the "License");                                              #
--# you may not use this file except in compliance with the License.                                             #
--# You may obtain a copy of the License at                                                                      #
--#                                                                                                              #
--#    http://www.apache.org/licenses/LICENSE-2.0                                                                #
--#                                                                                                              #
--# Unless required by applicable law or agreed to in writing, software                                          #
--# distributed under the License is distributed on an "AS IS" BASIS,                                            #
--# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                                     #
--# See the License for the specific language governing permissions and                                          #
--# limitations under the License.                                                                               #
--################################################################################################################
--#                Alejandro León, Universidad El Bosque, Programa Ingeniería de Sistemas                        #
--################################################################################################################
--################################################################################################################
--# Eliminando tabla por si existe
--################################################################################################################
drop table personas;
--################################################################################################################
--# Creando función para generar nombres
--################################################################################################################
CREATE OR REPLACE FUNCTION name() RETURNS VARCHAR AS $$
         select array_to_string(array (select substr('abcde fghijklmno pqrstuvwxyzABCDEFGHI JKLMNOPQRS TUVWXYZ',
   trunc(random() * 56)::integer + 1, 1) FROM   generate_series(1, 50)), '')       
$$ LANGUAGE SQL;
--################################################################################################################
--# Creando función para generar tipo de documentos
--################################################################################################################
CREATE OR REPLACE FUNCTION doc_type() RETURNS VARCHAR AS $$
         select case 
                 when doc.tipo=1 then 'cc'
                 when doc.tipo=2 then 'ti'
                 else 'ce'
                END
  from (select trunc(random()*3)+1 as tipo) doc
$$ LANGUAGE SQL;
--################################################################################################################
--# Creando función para generar tipo de sangre
--################################################################################################################
CREATE OR REPLACE FUNCTION rh_type() RETURNS VARCHAR AS $$
  select 
  case 
    when rh.tipo=1 then 'O-'
    when rh.tipo=2 then 'O+'
    when rh.tipo=3 then 'A-'
    when rh.tipo=4 then 'A+'
    when rh.tipo=5 then 'B-'
    when rh.tipo=6 then 'B+'            
    when rh.tipo=7 then 'AB-'
    when rh.tipo=8 then 'AB+'
   END
 from (select trunc(random()*8)+1 as tipo) rh         
$$ LANGUAGE SQL;
--################################################################################################################
--# Creando tabla y generando 10M de registros 
--################################################################################################################
create table personas as
select trunc((random() * 90))::smallint as edad,
       trunc((random() * 1000000000000) )::varchar as no_documento,
       name() as nombre,       
       doc_type() as tipo_documento,
       rh_type() as tipo_sangre
    from generate_series(1,10000000);
--################################################################################################################