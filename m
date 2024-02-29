Return-Path: <linux-kernel+bounces-85966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0686BDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547E61F22C09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F8620;
	Thu, 29 Feb 2024 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTEvMDNI"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085C13D2FA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168351; cv=none; b=eRF4GwVC0QrjVk4kN4ks2MxlyOSvRZROnkGslVftpN6nSsOU698A7Y6Vz9TLkyQU5h57gPupZsY/AW2bszGIQ0Xhd1VXZsCZezcz7wMgRHBfsCm7nLDFked8E00WfQ753SZPaLdhmy0CR0DJsdhKs3jdy/N/MGlkVf9nYu/IwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168351; c=relaxed/simple;
	bh=5Xuor9uzn7Uscd8CZsjxKS6abyui3iAR763+joTQQiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soi8TfAOKWSiFu1Ju0qy6wst8dMxAIBhthlEJ0eu+0Q2/xUJrO8eOb01DQBFQe9wotIc2r4KcBHwZ6YCjqx2PqbmgJCCquzB0fdlHw5YsaiPi19h7HZB93a9Ys/UtTVBlVkPfv7sjDCTHuWB1div/diTwACLLRm6wgM8qQ19Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTEvMDNI; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4705082131bso94469137.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709168348; x=1709773148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv+KMrAQlYOZozl9mrP8VK8+7Pz7cjDfY39oHMS3ofY=;
        b=kTEvMDNIpTsrqlwfj6CeTtYttqDoCokKe7kQFHxcioIOWtLIV/sH3rQMRsnUJXQQWw
         jY5GOF2lOlR3+Ig1CRXe8b1800J2C89xuEKNwG9eUBEf3IP0YDlpkOkOKsFLzTNjR784
         ZcG4KZzH9sra5QHPF7TVdoMFHmpjjfJ8hnTqrd+rDz9ba18eBnzheq+lxbSlE7E7qV5/
         ajlxhXjEyLLY4vk8PKxiXo8xjm6e4lOtAycR6KdCYtIytog7DizN4Ssv0S2UT8raYE+I
         Fvi6zbScy6dqqopzyL5PhTRO5S8SVr/J5PbAyldyuiHK4SdqI8w4rwLSK7gsgGqFSEEh
         nR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168348; x=1709773148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv+KMrAQlYOZozl9mrP8VK8+7Pz7cjDfY39oHMS3ofY=;
        b=oJZKOobqQPBdMjzjsBgKXtA8x3kqQ8Mm1adCg7sfDCM7WaWTmigfb9/95oW+43Ne0J
         g8RPmV2xB120qi0Wqw/m3qBTEnf7voJRzesn/EF66DN+CI+h9mGJBKTjfWZvBFOHauVj
         4+IOg5AfxV12rVz4h1qIZKAlcV41BjWn/xp5uXqV6pORNYjin1yW4i4ZoaQvK7UjhJpk
         GBHc7Q00bW+sHGv0D/i4fYkQuEirnkSqknvk98N+ig7G4xi267q8ntVTJL++B+x27AWt
         BWc2l3ADygBK7X1Q85IYK5aij7iAq/RCXyZpd4tJql0PV+sIeCoxweJgg9BKW3kUPhYm
         IVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjtJrpQL2oaGEJJun28ND3VlCQoLj/H2KlXmlurKQwyvj6uT0cw15r1UYXqZ64qfjOrxsQmEGQylLdL989OJr2dMkwk9yJoiqWYWTS
X-Gm-Message-State: AOJu0YxfTdHMaPy4C3oOqBeSKGXQA+YOO82pQNKpGOiqo+r5NvCynaam
	R1MAIaicoNNKHpD4anWGBO+qH2okH3QsJftGrnHS3t6NGq6r1pjTsj8Lubjx5Xb2i7kjvsXKdiw
	b0Q4ghsLWGLTPdfVpxf0M3sg8qrE=
X-Google-Smtp-Source: AGHT+IHn0jtq8H+NDlrbKbvnqI/YW6xgiJtfwzojgOktMlfGLJN90CLVG9NBK1hOyE7w+li7Dbb3ZG9ewD33w6S+Cqo=
X-Received: by 2002:a05:6102:a48:b0:470:3a99:f3c with SMTP id
 i8-20020a0561020a4800b004703a990f3cmr556272vss.23.1709168348192; Wed, 28 Feb
 2024 16:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229003753.134193-1-21cnbao@gmail.com> <20240229003753.134193-5-21cnbao@gmail.com>
 <CAJD7tkYWvxeCLmDO83tGyde7e4wPDPMnNbQfnB+pyTJAoSHqbg@mail.gmail.com>
In-Reply-To: <CAJD7tkYWvxeCLmDO83tGyde7e4wPDPMnNbQfnB+pyTJAoSHqbg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Feb 2024 13:58:56 +1300
Message-ID: <CAGsJ_4wSDZM4s6v8KmjwjbpWcoeF95R3-AkhUt2SthZ49MNNcw@mail.gmail.com>
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

On Thu, Feb 29, 2024 at 1:52=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Feb 28, 2024 at 4:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") suppo=
rts
> > one entry only, to support large folio swap-in, we need to handle multi=
ple
> > swap entries.
> >
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/swap.h |   1 +
> >  mm/swap.h            |   1 +
> >  mm/swapfile.c        | 117 ++++++++++++++++++++++++++-----------------
> >  3 files changed, 72 insertions(+), 47 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index b3581c976e5f..2691c739d9a4 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_t,=
 gfp_t);
> >  extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> > +extern int swapcache_prepare_nr(swp_entry_t, int nr);
> >  extern void swap_free(swp_entry_t);
> >  extern void swap_nr_free(swp_entry_t entry, int nr_pages);
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index fc2f6ade7f80..1cec991efcda 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >                                   unsigned long end);
> >  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> > +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry=
, int nr);
> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >                 struct vm_area_struct *vma, unsigned long addr);
> >  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index c0c058ee7b69..c8c8b6dbaeda 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3308,7 +3308,7 @@ void si_swapinfo(struct sysinfo *val)
> >  }
> >
> >  /*
> > - * Verify that a swap entry is valid and increment its swap map count.
> > + * Verify that nr swap entries are valid and increment their swap map =
count.
> >   *
> >   * Returns error code in following case.
> >   * - success -> 0
> > @@ -3318,66 +3318,73 @@ void si_swapinfo(struct sysinfo *val)
> >   * - swap-cache reference is requested but the entry is not used. -> E=
NOENT
> >   * - swap-mapped reference requested but needs continued swap count. -=
> ENOMEM
> >   */
> > -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> > +static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned cha=
r usage)
> >  {
> >         struct swap_info_struct *p;
> >         struct swap_cluster_info *ci;
> >         unsigned long offset;
> > -       unsigned char count;
> > -       unsigned char has_cache;
> > -       int err;
> > +       unsigned char count[SWAPFILE_CLUSTER];
> > +       unsigned char has_cache[SWAPFILE_CLUSTER];
>

Hi Yosry,

Thanks for reviewing!

> I am not closely following this series, but a couple of things caught my =
eyes.
>
> Is this reasonable for stack usage?

SWAPFILE_CLUSTER is not huge. typically 512 or 256.

#ifdef CONFIG_THP_SWAP
#define SWAPFILE_CLUSTER        HPAGE_PMD_NR

#define swap_entry_size(size)   (size)
#else
#define SWAPFILE_CLUSTER        256

If this is still a concern, I can move it to a bitmap.

>
> > +       int err, i;
> >
> >         p =3D swp_swap_info(entry);
> >
> >         offset =3D swp_offset(entry);
> >         ci =3D lock_cluster_or_swap_info(p, offset);
> >
> > -       count =3D p->swap_map[offset];
> > -
> > -       /*
> > -        * swapin_readahead() doesn't check if a swap entry is valid, s=
o the
> > -        * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> > -        */
> > -       if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> > -               err =3D -ENOENT;
> > -               goto unlock_out;
> > -       }
> > +       for (i =3D 0; i < nr; i++) {
> > +               count[i] =3D p->swap_map[offset + i];
> >
> > -       has_cache =3D count & SWAP_HAS_CACHE;
> > -       count &=3D ~SWAP_HAS_CACHE;
> > -       err =3D 0;
> > -
> > -       if (usage =3D=3D SWAP_HAS_CACHE) {
> > -
> > -               /* set SWAP_HAS_CACHE if there is no cache and entry is=
 used */
> > -               if (!has_cache && count)
> > -                       has_cache =3D SWAP_HAS_CACHE;
> > -               else if (has_cache)             /* someone else added c=
ache */
> > -                       err =3D -EEXIST;
> > -               else                            /* no users remaining *=
/
> > +               /*
> > +                * swapin_readahead() doesn't check if a swap entry is =
valid, so the
> > +                * swap entry could be SWAP_MAP_BAD. Check here with lo=
ck held.
> > +                */
> > +               if (unlikely(swap_count(count[i]) =3D=3D SWAP_MAP_BAD))=
 {
> >                         err =3D -ENOENT;
> > +                       goto unlock_out;
> > +               }
>


> Here we immediately exit if there is an error, but we don't below, we
> just keep overwriting the error every iteration as far as I can tell.
> Also, it doesn't seem like we do any cleanups if we hit an error
> halfway through. Should we undo previously updated swap entries, or am
> I missing something here?

we are safely immediately exiting because we don't change swap_map
till we finish all checks. while all checks are done, we write  them by
WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]);
at the end.

>
> >
> > -       } else if (count || has_cache) {
> > -
> > -               if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> > -                       count +=3D usage;
> > -               else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> > -                       err =3D -EINVAL;
> > -               else if (swap_count_continued(p, offset, count))
> > -                       count =3D COUNT_CONTINUED;
> > -               else
> > -                       err =3D -ENOMEM;
> > -       } else
> > -               err =3D -ENOENT;                  /* unused swap entry =
*/
> > -
> > -       if (!err)
> > -               WRITE_ONCE(p->swap_map[offset], count | has_cache);
> > +               has_cache[i] =3D count[i] & SWAP_HAS_CACHE;
> > +               count[i] &=3D ~SWAP_HAS_CACHE;
> > +               err =3D 0;
> > +
> > +               if (usage =3D=3D SWAP_HAS_CACHE) {
> > +
> > +                       /* set SWAP_HAS_CACHE if there is no cache and =
entry is used */
> > +                       if (!has_cache[i] && count[i])
> > +                               has_cache[i] =3D SWAP_HAS_CACHE;
> > +                       else if (has_cache[i])          /* someone else=
 added cache */
> > +                               err =3D -EEXIST;
> > +                       else                            /* no users rem=
aining */
> > +                               err =3D -ENOENT;
> > +               } else if (count[i] || has_cache[i]) {
> > +
> > +                       if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MA=
X)
> > +                               count[i] +=3D usage;
> > +                       else if ((count[i] & ~COUNT_CONTINUED) > SWAP_M=
AP_MAX)
> > +                               err =3D -EINVAL;
> > +                       else if (swap_count_continued(p, offset + i, co=
unt[i]))
> > +                               count[i] =3D COUNT_CONTINUED;
> > +                       else
> > +                               err =3D -ENOMEM;
> > +               } else
> > +                       err =3D -ENOENT;                  /* unused swa=
p entry */
> > +       }
> >
> > +       if (!err) {
> > +               for (i =3D 0; i < nr; i++)
> > +                       WRITE_ONCE(p->swap_map[offset + i], count[i] | =
has_cache[i]);

Here is the place where we really write data. Before that, we only
touched temp variables.

> > +       }
> >  unlock_out:
> >         unlock_cluster_or_swap_info(p, ci);
> >         return err;
> >  }

thanks
Barry

