Return-Path: <linux-kernel+bounces-26297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF882DE36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C1728331E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446CD182C7;
	Mon, 15 Jan 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7G5hPfa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDA182B6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so110085051fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705338570; x=1705943370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUyjug53SUOdBCweTFhVwZTV/LHsFjaL8stVuqO2M34=;
        b=L7G5hPfak5Z3SfGKPXNqd4UEo6fuyz171Hannc0gNTISFHr151ZE9k8QyMYrQ/qbOS
         tAiipgI8IaEPe3QmrKTnW40i0voQpOSETloTXaMQ/em5idnu0kup29JbhvxiERFZ2dQG
         Y03bABUPTW7qwCHnjZ9Vrag9z91Q4OTmZ3YJZNn4xK+YzAIh8IfFoClU/TCoWJl5DVHF
         OyR6zsungqvgdALqEa8P/Ui46OStVvKSzrAZuHwGyV+h+g3YwuU2VVzuwhqgqSsRk0sf
         yXyeP9GXo9271kqXrq70CWABOIN9znXRpm8iLClTtuPPPXifSpGUCS2kmU0ivcrB83jx
         vdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338570; x=1705943370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUyjug53SUOdBCweTFhVwZTV/LHsFjaL8stVuqO2M34=;
        b=iu8IpBEhIGt8xH/cJA7Rhg8nbHgTvCFGmOdC4PrSFVfLqYyIVDTLL+xjhKhTq2TrtN
         UEnTkxnyiqkTHKO8Q4IqnUjIhPExBxgHZtl+Kf9AIpyN62o7yu9cL8GDPWPC1jeOCgyq
         lyY8tM5mQd7aRN7178UbEgv+bC653a/hIpbVQis2ani3BhPsd4sI9KDMlHu2RQTHyw//
         WvB5JhCqnEiARkEtXaD2N7e8Fg9uItUOOkRdGXgAzl0Whi1t/wiynGFZnOWjh+QlLwZj
         4t0ua/8334wYE2DuPqvE1oDEp5xtStJdpgkUOPg1HCfV6X9YuvdrvqvPbMILs7516k2O
         tHWw==
X-Gm-Message-State: AOJu0Yz4R3w8UI3bzyoSqRU2DALDIG8YsTBIrOgJytGBVhdivTjYBfef
	BxDATxCJf+NNJ/VbdSCiWJBS6vTClVrovV3ho4A=
X-Google-Smtp-Source: AGHT+IFe2NRM+hHXHiF4wk8AZYf/jWHdaj9ymwt/MrPanxf4hHsvye88hCGeN2pNg2NbjMs31r5gIy/XwqLI4xzRFD0=
X-Received: by 2002:a2e:8709:0:b0:2cd:9e6c:7f3f with SMTP id
 m9-20020a2e8709000000b002cd9e6c7f3fmr2247893lji.71.1705338569506; Mon, 15 Jan
 2024 09:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111183321.19984-1-ryncsn@gmail.com> <20240111183321.19984-2-ryncsn@gmail.com>
 <CAAPL-u8dMX11CiaUxQdx0bK-RDMuNV40JFDYyXBPJ+ex+Kx4rw@mail.gmail.com> <CAMgjq7Bv7L_J4pfbHnopsbOzrqZfgfqTYuJUMXo94Z6vp+74-Q@mail.gmail.com>
In-Reply-To: <CAMgjq7Bv7L_J4pfbHnopsbOzrqZfgfqTYuJUMXo94Z6vp+74-Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 16 Jan 2024 01:09:11 +0800
Message-ID: <CAMgjq7C01uT_wASNor+F-sNEupcc3_fYd6rpmfmzQh3rCqutyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, lru_gen: batch update counters on againg
To: Wei Xu <weixugc@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, Chris Li <chrisl@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=B8=80 01:42=E5=86=99=E9=81=93=EF=BC=9A
>
> Wei Xu <weixugc@google.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E5=85=AD 05:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jan 11, 2024 at 10:33=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > When lru_gen is aging, it will update mm counters page by page,
> > > which causes a higher overhead if age happens frequently or there
> > > are a lot of pages in one generation getting moved.
> > > Optimize this by doing the counter update in batch.
> > >
> > > Although most __mod_*_state has its own caches the overhead
> > > is still observable.
> > >
> > > Tested in a 4G memcg on a EPYC 7K62 with:
> > >
> > >   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
> > >     -a 0766 -t 16 -B binary &
> > >
> > >   memtier_benchmark -S /tmp/memcached.socket \
> > >     -P memcache_binary -n allkeys \
> > >     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
> > >     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
> > >
> > > Average result of 18 test runs:
> > >
> > > Before: 44017.78 Ops/sec
> > > After:  44687.08 Ops/sec (+1.5%)
> >
> > I see the same performance numbers get quoted in all the 3 patches.
> > How much performance improvements does this particular patch provide
> > (the same for the other 2 patches)? If as the cover letter says, the
> > most performance benefits come from patch 3 (prefetching), can we just
> > have that patch alone to avoid the extra complexities.
>
> Hi Wei,
>
> Indeed these are two different optimization technique, I can reorder
> the series, prefetch is the first one and should be more acceptable,
> other optimizations can come later. And add standalone info about
> improvement of batch operations.
>
> >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++------=
--
> > >  1 file changed, 55 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 4f9c854ce6cc..185d53607c7e 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -3113,9 +3113,47 @@ static int folio_update_gen(struct folio *foli=
o, int gen)
> > >         return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > >  }
> > >
> > > +/*
> > > + * Update LRU gen in batch for each lru_gen LRU list. The batch is l=
imited to
> > > + * each gen / type / zone level LRU. Batch is applied after finished=
 or aborted
> > > + * scanning one LRU list.
> > > + */
> > > +struct gen_update_batch {
> > > +       int delta[MAX_NR_GENS];
> > > +};
> > > +
> > > +static void lru_gen_update_batch(struct lruvec *lruvec, int type, in=
t zone,
> > > +                                struct gen_update_batch *batch)
> > > +{
> > > +       int gen;
> > > +       int promoted =3D 0;
> > > +       struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > > +       enum lru_list lru =3D type ? LRU_INACTIVE_FILE : LRU_INACTIVE=
_ANON;
> > > +
> > > +       for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
> > > +               int delta =3D batch->delta[gen];
> > > +
> > > +               if (!delta)
> > > +                       continue;
> > > +
> > > +               WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
> > > +                          lrugen->nr_pages[gen][type][zone] + delta)=
;
> > > +
> > > +               if (lru_gen_is_active(lruvec, gen))
> > > +                       promoted +=3D delta;
> > > +       }
> > > +
> > > +       if (promoted) {
> > > +               __update_lru_size(lruvec, lru, zone, -promoted);
> > > +               __update_lru_size(lruvec, lru + LRU_ACTIVE, zone, pro=
moted);
> > > +       }
> > > +}
> > > +
> > >  /* protect pages accessed multiple times through file descriptors */
> > > -static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio,=
 bool reclaiming)
> > > +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio,
> > > +                        bool reclaiming, struct gen_update_batch *ba=
tch)
> > >  {
> > > +       int delta =3D folio_nr_pages(folio);
> > >         int type =3D folio_is_file_lru(folio);
> > >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > >         int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[typ=
e]);
> > > @@ -3138,7 +3176,8 @@ static int folio_inc_gen(struct lruvec *lruvec,=
 struct folio *folio, bool reclai
> > >                         new_flags |=3D BIT(PG_reclaim);
> > >         } while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
> > >
> > > -       lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> > > +       batch->delta[old_gen] -=3D delta;
> > > +       batch->delta[new_gen] +=3D delta;
> > >
> > >         return new_gen;
> > >  }
> > > @@ -3672,6 +3711,7 @@ static bool inc_min_seq(struct lruvec *lruvec, =
int type, bool can_swap)
> > >  {
> > >         int zone;
> > >         int remaining =3D MAX_LRU_BATCH;
> > > +       struct gen_update_batch batch =3D { };
> >
> > Can this batch variable be moved away from the stack?  We (Google) use
> > a much larger value for MAX_NR_GENS internally. This large stack
> > allocation from "struct gen_update_batch batch" can significantly
> > increase the risk of stack overflow for our use cases.
> >
>
> Thanks for the info.
> Do you have any suggestion about where we should put the batch info? I
> though about merging it with lru_gen_mm_walk but that depend on
> kzalloc and not useable for slow allocation path, the overhead could
> be larger than benefit in many cases.
>
> Not sure if we can use some thing like a preallocated per-cpu cache
> here to avoid all the issues.

Hi Wei,

After second thought, the batch is mostly used together with
folio_inc_gen which means most pages are only being moved between two
gens (being protected/unreclaimable), so I think only one counter int
is needed in the batch, I'll update this patch and do some test based
on this.

