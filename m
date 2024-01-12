Return-Path: <linux-kernel+bounces-25037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A5682C67E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C0D284A62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D67168D1;
	Fri, 12 Jan 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBZI31Sq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287B168C6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337874b8164so1761386f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705093291; x=1705698091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6mDOvkrYH5IHjeIiuUptZ8VUmTnxhma3SeigxuroLk=;
        b=kBZI31SqvOIFrTwQaC/6Y4A7C4zDJSi39WfFlTd52KmDY4xPQ0fBq2Zuz2VCcUxGaY
         XT12NzBgFfve3vy7e0NrRUgs0PQHTvuaIIGD2X0/NSYb5eEtzzZNj+JGqS2OHftna0Bh
         Q8DZ/iuXKkgLer7exnVKp4MFDQ9Yabwt8yB1d4tbpqVjNEDvm+++tSox31Gzbgl9kQsk
         f+eUOuuECtUN0ltlMhZz2ND2e5HM897jcdvD5A7pPf4UsKSuprGIHhiEUvn7Nuld30QD
         PRx7N0Vx9GJjM1EPU3pARVL1SQk2xjnTQh+6FYdFw5JUr6LP0PgE2kqvuDzLP7l17G0o
         a8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705093291; x=1705698091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6mDOvkrYH5IHjeIiuUptZ8VUmTnxhma3SeigxuroLk=;
        b=APGkpCIWL7DXwZd6/FYrQf0f6iqo6ok1C0TJ8QMm/52iT73P4akKMjGL9z8Sva5jFF
         t4aACI/Ch1qxsi436oT/cMtsmEjsZvyELh0ov1J0uo1gKZKW+e9ylN9t+QI/jGj0cOns
         WkF4RC49Ho52ouuDgq6+x/f+w6m50wIl82K232QCKxbfkQhKfnaHfw6QihF7aYpA7sMd
         ACJt825xwgGQqhhxELvYPX13P6CMhGdQuOodxaCp+p+knvgWxxzPKRY7f4NNtLLonnW0
         d7E88IYQJKgrmeW3xsW5NtJqV9U2R9U+ZmmGCyWxalLgWIFqjWTvHxsdp+Ame6pTr8vY
         oEsQ==
X-Gm-Message-State: AOJu0YwOEP0cYMU2PlYMD9UbKH5yrPsyhIctQVEOGL7Jygn0RsL1awRr
	OCi0YHITh5Y7h236KOru3gWCoGvEAUwtdbS+cTi5JToFGFWj
X-Google-Smtp-Source: AGHT+IF8XQVt6frk4w04aZS1wB4BwDw687DxAExgBNH6SU/JDHiVvFCLjdBx4vpkw95aHir98rQzBVNapJCOx4mhc4E=
X-Received: by 2002:a05:6000:45:b0:337:8bc6:dd4 with SMTP id
 k5-20020a056000004500b003378bc60dd4mr1009510wrx.88.1705093291481; Fri, 12 Jan
 2024 13:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111183321.19984-1-ryncsn@gmail.com> <20240111183321.19984-2-ryncsn@gmail.com>
In-Reply-To: <20240111183321.19984-2-ryncsn@gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Fri, 12 Jan 2024 13:01:19 -0800
Message-ID: <CAAPL-u8dMX11CiaUxQdx0bK-RDMuNV40JFDYyXBPJ+ex+Kx4rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, lru_gen: batch update counters on againg
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, Chris Li <chrisl@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:33=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> When lru_gen is aging, it will update mm counters page by page,
> which causes a higher overhead if age happens frequently or there
> are a lot of pages in one generation getting moved.
> Optimize this by doing the counter update in batch.
>
> Although most __mod_*_state has its own caches the overhead
> is still observable.
>
> Tested in a 4G memcg on a EPYC 7K62 with:
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
>     -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys \
>     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
>     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
>
> Average result of 18 test runs:
>
> Before: 44017.78 Ops/sec
> After:  44687.08 Ops/sec (+1.5%)

I see the same performance numbers get quoted in all the 3 patches.
How much performance improvements does this particular patch provide
(the same for the other 2 patches)? If as the cover letter says, the
most performance benefits come from patch 3 (prefetching), can we just
have that patch alone to avoid the extra complexities.

> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..185d53607c7e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3113,9 +3113,47 @@ static int folio_update_gen(struct folio *folio, i=
nt gen)
>         return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
>  }
>
> +/*
> + * Update LRU gen in batch for each lru_gen LRU list. The batch is limit=
ed to
> + * each gen / type / zone level LRU. Batch is applied after finished or =
aborted
> + * scanning one LRU list.
> + */
> +struct gen_update_batch {
> +       int delta[MAX_NR_GENS];
> +};
> +
> +static void lru_gen_update_batch(struct lruvec *lruvec, int type, int zo=
ne,
> +                                struct gen_update_batch *batch)
> +{
> +       int gen;
> +       int promoted =3D 0;
> +       struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> +       enum lru_list lru =3D type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANO=
N;
> +
> +       for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
> +               int delta =3D batch->delta[gen];
> +
> +               if (!delta)
> +                       continue;
> +
> +               WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
> +                          lrugen->nr_pages[gen][type][zone] + delta);
> +
> +               if (lru_gen_is_active(lruvec, gen))
> +                       promoted +=3D delta;
> +       }
> +
> +       if (promoted) {
> +               __update_lru_size(lruvec, lru, zone, -promoted);
> +               __update_lru_size(lruvec, lru + LRU_ACTIVE, zone, promote=
d);
> +       }
> +}
> +
>  /* protect pages accessed multiple times through file descriptors */
> -static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, boo=
l reclaiming)
> +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio,
> +                        bool reclaiming, struct gen_update_batch *batch)
>  {
> +       int delta =3D folio_nr_pages(folio);
>         int type =3D folio_is_file_lru(folio);
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
> @@ -3138,7 +3176,8 @@ static int folio_inc_gen(struct lruvec *lruvec, str=
uct folio *folio, bool reclai
>                         new_flags |=3D BIT(PG_reclaim);
>         } while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
>
> -       lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +       batch->delta[old_gen] -=3D delta;
> +       batch->delta[new_gen] +=3D delta;
>
>         return new_gen;
>  }
> @@ -3672,6 +3711,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int =
type, bool can_swap)
>  {
>         int zone;
>         int remaining =3D MAX_LRU_BATCH;
> +       struct gen_update_batch batch =3D { };

Can this batch variable be moved away from the stack?  We (Google) use
a much larger value for MAX_NR_GENS internally. This large stack
allocation from "struct gen_update_batch batch" can significantly
increase the risk of stack overflow for our use cases.

>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
>
> @@ -3690,12 +3730,15 @@ static bool inc_min_seq(struct lruvec *lruvec, in=
t type, bool can_swap)
>                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type, folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
> -                       new_gen =3D folio_inc_gen(lruvec, folio, false);
> +                       new_gen =3D folio_inc_gen(lruvec, folio, false, &=
batch);
>                         list_move_tail(&folio->lru, &lrugen->folios[new_g=
en][type][zone]);
>
> -                       if (!--remaining)
> +                       if (!--remaining) {
> +                               lru_gen_update_batch(lruvec, type, zone, =
&batch);
>                                 return false;
> +                       }
>                 }
> +               lru_gen_update_batch(lruvec, type, zone, &batch);
>         }
>  done:
>         reset_ctrl_pos(lruvec, type, true);
> @@ -4215,7 +4258,7 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg,=
 int nid)
>   ***********************************************************************=
*******/
>
>  static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struc=
t scan_control *sc,
> -                      int tier_idx)
> +                      int tier_idx, struct gen_update_batch *batch)
>  {
>         bool success;
>         int gen =3D folio_lru_gen(folio);
> @@ -4257,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         if (tier > tier_idx || refs =3D=3D BIT(LRU_REFS_WIDTH)) {
>                 int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
>
> -               gen =3D folio_inc_gen(lruvec, folio, false);
> +               gen =3D folio_inc_gen(lruvec, folio, false, batch);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>
>                 WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
> @@ -4267,7 +4310,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>
>         /* ineligible */
>         if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> -               gen =3D folio_inc_gen(lruvec, folio, false);
> +               gen =3D folio_inc_gen(lruvec, folio, false, batch);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>                 return true;
>         }
> @@ -4275,7 +4318,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         /* waiting for writeback */
>         if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>             (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> -               gen =3D folio_inc_gen(lruvec, folio, true);
> +               gen =3D folio_inc_gen(lruvec, folio, true, batch);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
>         }
> @@ -4341,6 +4384,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         for (i =3D MAX_NR_ZONES; i > 0; i--) {
>                 LIST_HEAD(moved);
>                 int skipped_zone =3D 0;
> +               struct gen_update_batch batch =3D { };
>                 int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
>
> @@ -4355,7 +4399,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>
>                         scanned +=3D delta;
>
> -                       if (sort_folio(lruvec, folio, sc, tier))
> +                       if (sort_folio(lruvec, folio, sc, tier, &batch))
>                                 sorted +=3D delta;
>                         else if (isolate_folio(lruvec, folio, sc)) {
>                                 list_add(&folio->lru, list);
> @@ -4375,6 +4419,8 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>                         skipped +=3D skipped_zone;
>                 }
>
> +               lru_gen_update_batch(lruvec, type, zone, &batch);
> +
>                 if (!remaining || isolated >=3D MIN_LRU_BATCH)
>                         break;
>         }
> --
> 2.43.0
>
>

