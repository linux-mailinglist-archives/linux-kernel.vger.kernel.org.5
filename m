Return-Path: <linux-kernel+bounces-10915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BDE81DEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71800B20E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F515B0;
	Mon, 25 Dec 2023 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwGhoFCp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210ED111B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so143245e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703487517; x=1704092317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XpnMDmsH50s0lvPTiOZRWTMXCRnNPpXm9QclJ7i9l8=;
        b=wwGhoFCpEvDvRzCz8nMonIFzIBveeD9G2ASmFuwxiaIzmp1p2+Sn8VsT4HiyEpbURr
         5MSXJtQALqVejpMvL0PuzDf7a90rwyrVdxe4Jd/KvWaXMJhaPS7noBCU3Z9KwFUW7Hst
         nqIzYd6m7QgI7+zKbVl1eCBD/kEpI6zclrfkTIRMyNos+pe0sojbGaCXChiTNoGS6cYa
         ncDnmDLGUbx37qOun9X7/hp6HrRg/NlcntovoWZfvB1PZ9l1nGJdMCYP7MMOYpcpKx1p
         yVq0A7yz/2iVB1QcI2QhUBJrcRE2hVTND4H3KCbm4Y86RSUYjRmH94IjM6lG6kZD9iTq
         EetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703487517; x=1704092317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XpnMDmsH50s0lvPTiOZRWTMXCRnNPpXm9QclJ7i9l8=;
        b=nhZFvbpW2ZiOjT58xSbWKMolvRUPt0FCdjAe3v4p06o+4o/ULZQ4RW7gwh1zazwOfm
         KCJhfWSmdzBDC0mzKQQzuFE9PYih6N3RtrAMLjEnUYv4VP1MyDIk1vjZb4IDWniN99SA
         CcB9tjLggKex7A32s0WLS6QR+IxTGYmb04gZX7rEircrRW6kzjM6/IPFoh5hMKCzucUo
         SmYEp3sPRa3G0dOmYzy4nh0DBIlVyAKv5gUtO91K1IrfKXx/T4jeEDsY6MtDB5MOVNPh
         xNF16ocVXE6V5EPIYWw8M2eDKagyRvYXa1semgSfEFvvoPypDn6dlFWyCRFVn6uGeO8C
         Gn2g==
X-Gm-Message-State: AOJu0YxEZc+egHx2cGZ8sst+dyL+cbwN9yU/r70RZJkXEuBCG0/zQu1c
	d67n3fqRypSoo2xLp9yOo2exGI4Osm7SDXxK0SbsOq8j2LCl
X-Google-Smtp-Source: AGHT+IHycYngDkHH5FBpbNfgus3DgvUjPd0CH9Lblf3/orXmT7bqv23O4ueiovKcuWCCutI9NeQ3EHMhEM8cGmDAPcw=
X-Received: by 2002:a05:600c:229a:b0:40d:400c:1b1f with SMTP id
 26-20020a05600c229a00b0040d400c1b1fmr341589wmf.5.1703487517174; Sun, 24 Dec
 2023 22:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-3-ryncsn@gmail.com>
In-Reply-To: <20231222102255.56993-3-ryncsn@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 24 Dec 2023 23:58:00 -0700
Message-ID: <CAOUHufYOA-_MtFL-GoQouH0-KwQOLkh1RZKJ+90ADrhBfFeQsg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, lru_gen: move pages in bulk when aging
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Another overhead of aging is page moving. Actually, in most cases,
> pages are being moved to the same gen after folio_inc_gen is called,
> especially the protected pages.  So it's better to move them in bulk.
>
> This also has a good effect on LRU ordering. Currently when MGLRU
> ages, it walks the LRU backward, and the protected pages are moved to
> the tail of newer gen one by one, which reverses the order of pages in
> LRU. Moving them in batches can help keep their order, only in a small
> scope though due to the scan limit of MAX_LRU_BATCH pages.
>
> After this commit, we can see a performance gain:
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
> Before:           44017.78 Ops/sec
> After patch 1-2:  44810.01 Ops/sec (+1.8%)

Was it tested with CONFIG_DEBUG_LIST=3Dy?

Also, the (44810.01-44687.08)/44687.08=3D0.0027 improvement also sounded
like a noise to me.

> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 84 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 71 insertions(+), 13 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e3b4797b9729..af1266129c1b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3102,9 +3102,46 @@ static int folio_update_gen(struct folio *folio, i=
nt gen)
>   */
>  struct gen_update_batch {
>         int delta[MAX_NR_GENS];
> +       struct folio *head, *tail;
>  };
>
> -static void lru_gen_update_batch(struct lruvec *lruvec, bool type, int z=
one,
> +static void inline lru_gen_inc_bulk_finish(struct lru_gen_folio *lrugen,
> +                                          int bulk_gen, bool type, int z=
one,
> +                                          struct gen_update_batch *batch=
)
> +{
> +       if (!batch->head)
> +               return;
> +
> +       list_bulk_move_tail(&lrugen->folios[bulk_gen][type][zone],
> +                           &batch->head->lru,
> +                           &batch->tail->lru);
> +
> +       batch->head =3D NULL;
> +}
> +
> +/*
> + * When aging, protected pages will go to the tail of the same higher
> + * gen, so the can be moved in batches. Besides reduced overhead, this
> + * also avoids changing their LRU order in a small scope.
> + */
> +static void inline lru_gen_try_inc_bulk(struct lru_gen_folio *lrugen, st=
ruct folio *folio,
> +                                       int bulk_gen, int gen, bool type,=
 int zone,
> +                                       struct gen_update_batch *batch)
> +{
> +       /*
> +        * If folio not moving to the bulk_gen, it's raced with promotion
> +        * so it need to go to the head of another LRU.
> +        */
> +       if (bulk_gen !=3D gen)
> +               list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> +
> +       if (!batch->head)
> +               batch->tail =3D folio;
> +
> +       batch->head =3D folio;
> +}
> +
> +static void lru_gen_update_batch(struct lruvec *lruvec, int bulk_gen, bo=
ol type, int zone,
>                                  struct gen_update_batch *batch)
>  {
>         int gen;
> @@ -3112,6 +3149,8 @@ static void lru_gen_update_batch(struct lruvec *lru=
vec, bool type, int zone,
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         enum lru_list lru =3D type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANO=
N;
>
> +       lru_gen_inc_bulk_finish(lrugen, bulk_gen, type, zone, batch);
> +
>         for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
>                 int delta =3D batch->delta[gen];
>
> @@ -3705,6 +3744,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int =
type, bool can_swap)
>         struct gen_update_batch batch =3D { };
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
> +       int bulk_gen =3D (old_gen + 1) % MAX_NR_GENS;
>
>         if (type =3D=3D LRU_GEN_ANON && !can_swap)
>                 goto done;
> @@ -3712,24 +3752,33 @@ static bool inc_min_seq(struct lruvec *lruvec, in=
t type, bool can_swap)
>         /* prevent cold/hot inversion if force_scan is true */
>         for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
>                 struct list_head *head =3D &lrugen->folios[old_gen][type]=
[zone];
> +               struct folio *prev =3D NULL;
>
> -               while (!list_empty(head)) {
> -                       struct folio *folio =3D lru_to_folio(head);
> +               if (!list_empty(head))
> +                       prev =3D lru_to_folio(head);
>
> +               while (prev) {
> +                       struct folio *folio =3D prev;
>                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(foli=
o), folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), f=
olio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type, folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
> +                       if (unlikely(list_is_first(&folio->lru, head)))
> +                               prev =3D NULL;
> +                       else
> +                               prev =3D lru_to_folio(&folio->lru);
> +
>                         new_gen =3D folio_inc_gen(lruvec, folio, false, &=
batch);
> -                       list_move_tail(&folio->lru, &lrugen->folios[new_g=
en][type][zone]);
> +                       lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, new=
_gen, type, zone, &batch);
>
>                         if (!--remaining) {
> -                               lru_gen_update_batch(lruvec, type, zone, =
&batch);
> +                               lru_gen_update_batch(lruvec, bulk_gen, ty=
pe, zone, &batch);
>                                 return false;
>                         }
>                 }
> -               lru_gen_update_batch(lruvec, type, zone, &batch);
> +
> +               lru_gen_update_batch(lruvec, bulk_gen, type, zone, &batch=
);
>         }
>  done:
>         reset_ctrl_pos(lruvec, type, true);
> @@ -4240,7 +4289,7 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
>   ***********************************************************************=
*******/
>
>  static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struc=
t scan_control *sc,
> -                      int tier_idx, struct gen_update_batch *batch)
> +                      int tier_idx, int bulk_gen, struct gen_update_batc=
h *batch)
>  {
>         bool success;
>         int gen =3D folio_lru_gen(folio);
> @@ -4283,7 +4332,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                 int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
>
>                 gen =3D folio_inc_gen(lruvec, folio, false, batch);
> -               list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
> +               lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, gen, type, =
zone, batch);
>
>                 WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
>                            lrugen->protected[hist][type][tier - 1] + delt=
a);
> @@ -4293,7 +4342,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         /* ineligible */
>         if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
>                 gen =3D folio_inc_gen(lruvec, folio, false, batch);
> -               list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
> +               lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, gen, type, =
zone, batch);
>                 return true;
>         }
>
> @@ -4367,11 +4416,16 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
>                 LIST_HEAD(moved);
>                 int skipped_zone =3D 0;
>                 struct gen_update_batch batch =3D { };
> +               int bulk_gen =3D (gen + 1) % MAX_NR_GENS;
>                 int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
> +               struct folio *prev =3D NULL;
>
> -               while (!list_empty(head)) {
> -                       struct folio *folio =3D lru_to_folio(head);
> +               if (!list_empty(head))
> +                       prev =3D lru_to_folio(head);
> +
> +               while (prev) {
> +                       struct folio *folio =3D prev;
>                         int delta =3D folio_nr_pages(folio);
>
>                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(foli=
o), folio);
> @@ -4380,8 +4434,12 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
>                         scanned +=3D delta;
> +                       if (unlikely(list_is_first(&folio->lru, head)))
> +                               prev =3D NULL;
> +                       else
> +                               prev =3D lru_to_folio(&folio->lru);
>
> -                       if (sort_folio(lruvec, folio, sc, tier, &batch))
> +                       if (sort_folio(lruvec, folio, sc, tier, bulk_gen,=
 &batch))
>                                 sorted +=3D delta;
>                         else if (isolate_folio(lruvec, folio, sc)) {
>                                 list_add(&folio->lru, list);
> @@ -4401,7 +4459,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>                         skipped +=3D skipped_zone;
>                 }
>
> -               lru_gen_update_batch(lruvec, type, zone, &batch);
> +               lru_gen_update_batch(lruvec, bulk_gen, type, zone, &batch=
);
>
>                 if (!remaining || isolated >=3D MIN_LRU_BATCH)
>                         break;
> --
> 2.43.0
>

