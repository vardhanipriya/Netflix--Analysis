create database netflix;
use netflix;
select * from netflix_titles;

/* 1. Count the number of Movies vs TV Shows*/
select 
count( case when type='Movie' then show_id else null end) as num_of_movies,
count( case when type='Tv Show' then show_id else null end) as num_of_tvshows
from netflix_titles;

/*2. Find the most common rating for movies and TV shows*/

select type, 
rating,
count(rating) num_of_ratings
from netflix_titles
group by 1,rating
order by 3 desc
;

/*3. List all movies released in a specific year (e.g., 2020)*/

select title
from netflix_titles
where type = 'Movie'
and release_year =2020;

/* 4. Find the top 5 countries with the most content on Netflix */

select country,
count(show_id) num_of_contents
from netflix_titles
where country != ''
group by 1
order by 2 desc
limit 5;

/* 5. Identify the longest movie */

select title,
max(left(duration,3) *1) as duration_length
from netflix_titles
where type = 'Movie'
group by 1
order by 2 desc
limit 1;

/*6. Find content added in the last 5 years*/

select title,
release_year
from netflix_titles
where  release_year >= 2020;

/*7. Find all the movies/TV shows by director 'Rajiv Chilaka'!*/

select title,
director
from netflix_titles
where  director = 'Rajiv Chilaka';

/*8. List all TV shows with more than 5 seasons*/

select title,
duration
from netflix_titles
where type = 'Tv Show'
and (left(duration,1)*1) > 5;

/*9. Count the number of content items in each genre*/

select listed_in as genre,
count(show_id) num_of_contents
from netflix_titles
group by 1
order by 2 desc;

fdbekjnvkjd-/*10.Find each year and the average numbers of content 
release in India on netflix. */

select release_year,
count(case when country = 'India' then show_id else null end)/
(count(show_id)) *100 as avg_percentage_of_content
from netflix_titles
group by 1
order by 2 desc
;

/*11. List all movies that are documentaries*/

select title,
listed_in
from netflix_titles
where type = 'Movie'
and listed_in like '%docu%';

/*12. Find all content without a director*/

select title,
director
from netflix_titles
where director = '';

/*13. Find how many movies actor 'Salman Khan' appeared in last 10 years!*/

select title,
cast
from netflix_titles
where cast like '%Salman Khan%'
and release_year > 2014;

/*14. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.*/

alter table
netflix_titles
add label varchar(15) as
(case 
when (description like '%kill%' or '%violence%') then 'Bad'
else 'good'
end);

select label,
count(show_id) as num_of_shows
from netflix_titles
group by 1;
