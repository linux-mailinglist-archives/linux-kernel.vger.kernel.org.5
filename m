Return-Path: <linux-kernel+bounces-85997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47386BE46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD8C1C218C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786A2D61B;
	Thu, 29 Feb 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaSTRun/"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51612E5B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170433; cv=none; b=HpPAU2fFCrZQymJyryKtsL5h4KdCJdvBReSwRtuWQHTqFhyb2USLSjBazmbbeKkTYUEkGjb1I33c7pZaNDBhTybm662raq4ObuNMMZI3JAPUbWIBaIEvcIkaZiEeaa7IbeiPZaGv1lMtlBew0RWxKpncZqbeZEwMK645A2eVXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170433; c=relaxed/simple;
	bh=2MLNyAaMmKPQmxQIT7rP/cCcHiehXDbBfmh6a2IXhSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYdNGvUjyz42Q+Q6f141aXdkjPAqNH+jSQ9t2QpX/hLyFFUYJJobWlSXpvnl+onmnoVKRAvyL8jrB7XOU4sj5ei22EAt679uwxldxneqUQ+EX32oH59YmzIE0lmGreKBJ+02X5B/qHuEldX40/K+rvRbRg1g+LLnq3UBDYcZ4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaSTRun/; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d332d0db9cso80360e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709170430; x=1709775230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLYSx3phCLrW6DjF1IDFBmQIkWWNdBzi6bZC46PrVDQ=;
        b=NaSTRun/2tK7mivk5tSEBEUTvR9RZ9sMDEZKr7KZeXCDgsvRQUaSvYb8faDo7qnNKH
         sv6k1vzZFb991Cv6iV4t1ie4M3+L7sFbormpZaFWLLiPOXRIE7FoKd/hek/zqoF23MKr
         E0KqFr4waPGXxsty1DdZvbdNymzgq364Ib/P6YZd+jGBuhJbiOqlCto57v7xvm66z1ST
         OSQQbBldhJEukR7idi+yaAzRdMaDxvJLUomaHyWaJTDrEQSacrDc9pqYYlBEuizTV9Gb
         k45j4Rgwo9mpGTjHdk+FcRorKxnAs9mrct/LTUpIDpgU46ocLaEhh4JhAKWy6EVEexLd
         zI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170430; x=1709775230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLYSx3phCLrW6DjF1IDFBmQIkWWNdBzi6bZC46PrVDQ=;
        b=DFOkBel0aeMN8+YwtUCUl2m6ughCSANoIp/6dAxNPCJ5LWzgdzfykW2UivMDTnND5j
         o5DiwZg3+GX4D9TwseXtJKsTPtGdvUp9qXula7EsDO8oYLDwaE8x/MVABENrTRCyUDy9
         X5mAdPaSRbVHVqloYObdGMEZAmsyovWDO+hF/nEFuAVNQzRhTL1bxErrAx5Nt/ORUMbt
         tFTu5/mpFxL3Nn1vO04qw7gIYUM4q3htsutqPgEtjmhUeaZu0w7uS6bSzWI9HemOJAkU
         L3tzLWi5mp4tWVLhrhfFZJajdBZbD1cmPMLxz7L/ilS01W98FVComvSEnNFSpQETfOt/
         gt/w==
X-Forwarded-Encrypted: i=1; AJvYcCWndPWb5LdycCqrUHJ0V2fNOExvZ/aFLZd0GFWgnyBYShMlR0t4MtZ8UR5uizk9+yEQHRe4b8mlWmTXrLGgGPAlH4U0fv5OCEtDpoYn
X-Gm-Message-State: AOJu0YzGO8qz2tmT9BnvxeHpUohY4mWF6++FNMBs6f/XBnTXUejmPCMY
	Q08b017WED6kGQaOkXPmHXHn132ust2BcHtO6WQBZBfD0UQTOZMSpM9r9ro9gAi6ai4wbS5xCjA
	Lf8XrXT3vcSF1ByC6iFU1utFDe1Y=
X-Google-Smtp-Source: AGHT+IEfiVS1j/W6czzK/rI3j/StrrCUE/xhlh23zu9XRt4ZT2hWFqS4BXH74iLSO6xMePmpAnzQkVCmMWfjwSoHNPs=
X-Received: by 2002:a1f:ea82:0:b0:4cd:b718:4b08 with SMTP id
 i124-20020a1fea82000000b004cdb7184b08mr603758vkh.11.1709170430033; Wed, 28
 Feb 2024 17:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229003753.134193-1-21cnbao@gmail.com> <20240229003753.134193-5-21cnbao@gmail.com>
 <CAJD7tkYWvxeCLmDO83tGyde7e4wPDPMnNbQfnB+pyTJAoSHqbg@mail.gmail.com>
 <CAGsJ_4wSDZM4s6v8KmjwjbpWcoeF95R3-AkhUt2SthZ49MNNcw@mail.gmail.com> <CAJD7tkZi2g8HjwtchE46SkKgOHSE02ZTNLKFi-t0c4+hihUjYQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZi2g8HjwtchE46SkKgOHSE02ZTNLKFi-t0c4+hihUjYQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Feb 2024 14:33:38 +1300
Message-ID: <CAGsJ_4ydniOds7J0ObVw=VzenzB+zosD0rEF25T1=MX6qG1pDQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/5] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, shy828301@gmail.com, steven.price@arm.com, surenb@google.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, kasong@tencent.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-arm-kernel@lists.infradead.org, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Feb 28, 2024 at 4:59=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Thu, Feb 29, 2024 at 1:52=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 4:39=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") s=
upports
> > > > one entry only, to support large folio swap-in, we need to handle m=
ultiple
> > > > swap entries.
> > > >
> > > > Cc: Kairui Song <kasong@tencent.com>
> > > > Cc: "Huang, Ying" <ying.huang@intel.com>
> > > > Cc: Yu Zhao <yuzhao@google.com>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: Chris Li <chrisl@kernel.org>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Minchan Kim <minchan@kernel.org>
> > > > Cc: Yosry Ahmed <yosryahmed@google.com>
> > > > Cc: Yu Zhao <yuzhao@google.com>
> > > > Cc: SeongJae Park <sj@kernel.org>
> > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > ---
> > > >  include/linux/swap.h |   1 +
> > > >  mm/swap.h            |   1 +
> > > >  mm/swapfile.c        | 117 ++++++++++++++++++++++++++-------------=
----
> > > >  3 files changed, 72 insertions(+), 47 deletions(-)
> > > >
> > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > index b3581c976e5f..2691c739d9a4 100644
> > > > --- a/include/linux/swap.h
> > > > +++ b/include/linux/swap.h
> > > > @@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entr=
y_t, gfp_t);
> > > >  extern void swap_shmem_alloc(swp_entry_t);
> > > >  extern int swap_duplicate(swp_entry_t);
> > > >  extern int swapcache_prepare(swp_entry_t);
> > > > +extern int swapcache_prepare_nr(swp_entry_t, int nr);
> > > >  extern void swap_free(swp_entry_t);
> > > >  extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> > > >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > > > diff --git a/mm/swap.h b/mm/swap.h
> > > > index fc2f6ade7f80..1cec991efcda 100644
> > > > --- a/mm/swap.h
> > > > +++ b/mm/swap.h
> > > > @@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
> > > >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> > > >                                   unsigned long end);
> > > >  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entr=
y);
> > > > +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t e=
ntry, int nr);
> > > >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> > > >                 struct vm_area_struct *vma, unsigned long addr);
> > > >  struct folio *filemap_get_incore_folio(struct address_space *mappi=
ng,
> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index c0c058ee7b69..c8c8b6dbaeda 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -3308,7 +3308,7 @@ void si_swapinfo(struct sysinfo *val)
> > > >  }
> > > >
> > > >  /*
> > > > - * Verify that a swap entry is valid and increment its swap map co=
unt.
> > > > + * Verify that nr swap entries are valid and increment their swap =
map count.
> > > >   *
> > > >   * Returns error code in following case.
> > > >   * - success -> 0
> > > > @@ -3318,66 +3318,73 @@ void si_swapinfo(struct sysinfo *val)
> > > >   * - swap-cache reference is requested but the entry is not used. =
-> ENOENT
> > > >   * - swap-mapped reference requested but needs continued swap coun=
t. -> ENOMEM
> > > >   */
> > > > -static int __swap_duplicate(swp_entry_t entry, unsigned char usage=
)
> > > > +static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned=
 char usage)
> > > >  {
> > > >         struct swap_info_struct *p;
> > > >         struct swap_cluster_info *ci;
> > > >         unsigned long offset;
> > > > -       unsigned char count;
> > > > -       unsigned char has_cache;
> > > > -       int err;
> > > > +       unsigned char count[SWAPFILE_CLUSTER];
> > > > +       unsigned char has_cache[SWAPFILE_CLUSTER];
> > >
> >
> > Hi Yosry,
> >
> > Thanks for reviewing!
> >
> > > I am not closely following this series, but a couple of things caught=
 my eyes.
> > >
> > > Is this reasonable for stack usage?
> >
> > SWAPFILE_CLUSTER is not huge. typically 512 or 256.
>
> So that's 1K of stack usage out of 16K total on x86. I think this may
> be a lot for a single function to use, but perhaps others will
> disagree.
>
> >
> > #ifdef CONFIG_THP_SWAP
> > #define SWAPFILE_CLUSTER        HPAGE_PMD_NR
> >
> > #define swap_entry_size(size)   (size)
> > #else
> > #define SWAPFILE_CLUSTER        256
> >
> > If this is still a concern, I can move it to a bitmap.
> >
> > >
> > > > +       int err, i;
> > > >
> > > >         p =3D swp_swap_info(entry);
> > > >
> > > >         offset =3D swp_offset(entry);
> > > >         ci =3D lock_cluster_or_swap_info(p, offset);
> > > >
> > > > -       count =3D p->swap_map[offset];
> > > > -
> > > > -       /*
> > > > -        * swapin_readahead() doesn't check if a swap entry is vali=
d, so the
> > > > -        * swap entry could be SWAP_MAP_BAD. Check here with lock h=
eld.
> > > > -        */
> > > > -       if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> > > > -               err =3D -ENOENT;
> > > > -               goto unlock_out;
> > > > -       }
> > > > +       for (i =3D 0; i < nr; i++) {
> > > > +               count[i] =3D p->swap_map[offset + i];
> > > >
> > > > -       has_cache =3D count & SWAP_HAS_CACHE;
> > > > -       count &=3D ~SWAP_HAS_CACHE;
> > > > -       err =3D 0;
> > > > -
> > > > -       if (usage =3D=3D SWAP_HAS_CACHE) {
> > > > -
> > > > -               /* set SWAP_HAS_CACHE if there is no cache and entr=
y is used */
> > > > -               if (!has_cache && count)
> > > > -                       has_cache =3D SWAP_HAS_CACHE;
> > > > -               else if (has_cache)             /* someone else add=
ed cache */
> > > > -                       err =3D -EEXIST;
> > > > -               else                            /* no users remaini=
ng */
> > > > +               /*
> > > > +                * swapin_readahead() doesn't check if a swap entry=
 is valid, so the
> > > > +                * swap entry could be SWAP_MAP_BAD. Check here wit=
h lock held.
> > > > +                */
> > > > +               if (unlikely(swap_count(count[i]) =3D=3D SWAP_MAP_B=
AD)) {
> > > >                         err =3D -ENOENT;
> > > > +                       goto unlock_out;
> > > > +               }
> > >
> >
> >
> > > Here we immediately exit if there is an error, but we don't below, we
> > > just keep overwriting the error every iteration as far as I can tell.
> > > Also, it doesn't seem like we do any cleanups if we hit an error
> > > halfway through. Should we undo previously updated swap entries, or a=
m
> > > I missing something here?
> >
> > we are safely immediately exiting because we don't change swap_map
> > till we finish all checks. while all checks are done, we write  them by
> > WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]);
> > at the end.
>
> I see, but I think we may be overwriting the error from each iteration be=
low?

you are right, Yosry, i used to have the below to break. don't know
when I accidentally
dropped it  :-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c8c8b6dbaeda..091966056aec 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3369,6 +3369,9 @@ static int __swap_duplicate_nr(swp_entry_t
entry, int nr, unsigned char usage)
                                err =3D -ENOMEM;
                } else
                        err =3D -ENOENT;                  /* unused swap en=
try */
+
+               if (err)
+                       break;
        }

        if (!err) {

>
> >
> > >
> > > >
> > > > -       } else if (count || has_cache) {
> > > > -
> > > > -               if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> > > > -                       count +=3D usage;
> > > > -               else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> > > > -                       err =3D -EINVAL;
> > > > -               else if (swap_count_continued(p, offset, count))
> > > > -                       count =3D COUNT_CONTINUED;
> > > > -               else
> > > > -                       err =3D -ENOMEM;
> > > > -       } else
> > > > -               err =3D -ENOENT;                  /* unused swap en=
try */
> > > > -
> > > > -       if (!err)
> > > > -               WRITE_ONCE(p->swap_map[offset], count | has_cache);
> > > > +               has_cache[i] =3D count[i] & SWAP_HAS_CACHE;
> > > > +               count[i] &=3D ~SWAP_HAS_CACHE;
> > > > +               err =3D 0;
> > > > +
> > > > +               if (usage =3D=3D SWAP_HAS_CACHE) {
> > > > +
> > > > +                       /* set SWAP_HAS_CACHE if there is no cache =
and entry is used */
> > > > +                       if (!has_cache[i] && count[i])
> > > > +                               has_cache[i] =3D SWAP_HAS_CACHE;
> > > > +                       else if (has_cache[i])          /* someone =
else added cache */
> > > > +                               err =3D -EEXIST;
> > > > +                       else                            /* no users=
 remaining */
> > > > +                               err =3D -ENOENT;
> > > > +               } else if (count[i] || has_cache[i]) {
> > > > +
> > > > +                       if ((count[i] & ~COUNT_CONTINUED) < SWAP_MA=
P_MAX)
> > > > +                               count[i] +=3D usage;
> > > > +                       else if ((count[i] & ~COUNT_CONTINUED) > SW=
AP_MAP_MAX)
> > > > +                               err =3D -EINVAL;
> > > > +                       else if (swap_count_continued(p, offset + i=
, count[i]))
> > > > +                               count[i] =3D COUNT_CONTINUED;
> > > > +                       else
> > > > +                               err =3D -ENOMEM;
> > > > +               } else
> > > > +                       err =3D -ENOENT;                  /* unused=
 swap entry */
> > > > +       }
> > > >
> > > > +       if (!err) {
> > > > +               for (i =3D 0; i < nr; i++)
> > > > +                       WRITE_ONCE(p->swap_map[offset + i], count[i=
] | has_cache[i]);
> >
> > Here is the place where we really write data. Before that, we only
> > touched temp variables.
> >
> > > > +       }
> > > >  unlock_out:
> > > >         unlock_cluster_or_swap_info(p, ci);
> > > >         return err;
> > > >  }
> >
thanks
Barry

