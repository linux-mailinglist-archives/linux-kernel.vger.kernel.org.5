Return-Path: <linux-kernel+bounces-54247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F084ACCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8CF1F225EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616297319A;
	Tue,  6 Feb 2024 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5b+vtC8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4473188
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189733; cv=none; b=q0R9o+s2DEjJ5QJKrbGUyFngZIxlx3U1zj82eJS+xpxZ3T63pVyW48QFH/M9KlrWmqyglM8MDkLdMry2UQXNK1yj1lRe2Hry2NXm3U8HSxgKwZ8Hi2wWObabW6Te14iHgoxliZ2hl1AObOF1PSZMnL9v1SD8jPcB4igfnL8i9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189733; c=relaxed/simple;
	bh=2SOQ4rhL4rXyk8SgmeHXF3ovB/FXpEm/T4PiSf23Mbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQVmmtI5vHhcXvJHIRxchz79Hl2EuZnChM85N0iNVYu4PiJjxFThLy9zFlE55MKoNunSo5Ln3oqv8wmmQYh9et+iP/u4gT8GcmA2sMjHuV7U/hFT7kyfTc8m+9eAt8sfhzDUEsupZtxClP3y0MGVOflK+0/WEEYTUdi6Y9l9FQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5b+vtC8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51121637524so7772354e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707189729; x=1707794529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrdIhk8ATB609TluZLy9x7HB4Q7Va08Ieexvs7G06Tc=;
        b=H5b+vtC8Vs+b7sVkrL6hoH/4lmfceQFC3COnASrxd5B62bc7CphOgPtQip2BU8AvT9
         /kG0xVGRnZxt8ete7a74nrI9cYTmn4b7JPfSy1uBjFiCxWuP5q9Tp+qEngTWkns4sbNi
         FJqyrZuodIXv9via612BNCPffn4OaiGczh4PkbR4xDAxjac0EUj2sG/+H2Gpy3jSsB9p
         +IWf0OoKbEil9Q6L3lX5ar7iLJhCtpkZGHVDvyJqd0oYWp/uUGb36oIwLpSf9XtSiBbq
         0/SZX+dh/Ixq4ZfVZiDu1lqKSguLDcBDFyxMA9rreNlGgDyoEs/LHFcVmVho3v2ZLjX7
         qofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189729; x=1707794529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrdIhk8ATB609TluZLy9x7HB4Q7Va08Ieexvs7G06Tc=;
        b=HRGwhO22CulxXyl6EgMaNA74TFNu7/KC0H0ewsO9L7xAJzvCgN27v0z1crwNpDPFQY
         gGUg9776UFB4l62ArSIvtN+AOGtmaKt1GF+7X8PrSltKuKkzCaSDp8zzDe5941Ky0aLi
         3ylM/YuxRxkYviKrIJQ1ps/7Icu5HrCIXM/a6s0YuU7CpJgjTs9zxcMBRXpD6ZTXRTpl
         G3CL1k5WX+CR6rPhC92Q50y9dVANns95LDANe09KrYk9bVvmAX6mT/Lg7FUUh74cCFUY
         wbY3FBlb5okn4tduJS/NGFnFlS9rXWEiaoEutYs4CntQ+n1VSz0P5QRkxrffHa4ncC/W
         vh0A==
X-Gm-Message-State: AOJu0YzTnWeZi5SZODWxM+dbC4x1ueig6/FmE2d4Fs9fon6Ve+dH0feL
	+mOD2Rj82dfeIaoJjD3hN8ze57rH7QUpnzc7ucsar2HX1QqyZU6uJHmqYo7K7TaDCqrfoYlIiXD
	MkhXm+JeBII+ekfdbnhrWYfMv5Tc=
X-Google-Smtp-Source: AGHT+IEXXDk2KhXkTGg/n364JSzsq7BErLLprh4BWymFF7C72GAlInbn9sKI5+ewIssHRoUNFa1csYhmoWut4gsXMSs=
X-Received: by 2002:a2e:b54a:0:b0:2d0:9cc6:96fb with SMTP id
 a10-20020a2eb54a000000b002d09cc696fbmr583799ljn.44.1707189729009; Mon, 05 Feb
 2024 19:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205110959.4021-1-ryncsn@gmail.com> <871q9q1imi.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q9q1imi.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 6 Feb 2024 11:21:51 +0800
Message-ID: <CAMgjq7BC-GaZiTOBurCZRObtmqW46dt7fJW5OuQKHtvkgtztuw@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:35=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > In the direct swapin path, when two or more threads swapin the same ent=
ry
> > at the same time, they get different pages (A, B) because swap cache is
> > skipped. Before one thread (T0) finishes the swapin and installs page (=
A)
> > to the PTE, another thread (T1) could finish swapin of page (B),
> > swap_free the entry, then modify and swap-out the page again, using the
> > same entry. It break the pte_same check because PTE value is unchanged,
> > causing ABA problem. Then thread (T0) will then install the stalled pag=
e
> > (A) into the PTE so new data in page (B) is lost, one possible callstac=
k
> > is like this:
> >
> > CPU0                                CPU1
> > ----                                ----
> > do_swap_page()                      do_swap_page() with same entry
> > <direct swapin path>                <direct swapin path>
> > <alloc page A>                      <alloc page B>
> > swap_readpage() <- read to page A   swap_readpage() <- read to page B
> > <slow on later locks or interrupt>  <finished swapin first>
> > ...                                 set_pte_at()
> >                                     swap_free() <- Now the entry is fre=
ed.
> >                                     <write to page B, now page A stalle=
d>
> >                                     <swap out page B using same swap en=
try>
> > pte_same() <- Check pass, PTE seems
> >               unchanged, but page A
> >               is stalled!
> > swap_free() <- page B content lost!
> > set_pte_at() <- staled page A installed!
> >
> > To fix this, reuse swapcache_prepare which will pin the swap entry usin=
g
> > the cache flag, and allow only one thread to pin it. Release the pin
> > after PT unlocked. Racers will simply busy wait since it's a rare
> > and very short event.
> >
> > Other methods like increasing the swap count don't seem to be a good
> > idea after some tests, that will cause racers to fall back to the
> > cached swapin path, two swapin path being used at the same time
> > leads to a much more complex scenario.
> >
> > Reproducer:
> >
> > This race issue can be triggered easily using a well constructed
> > reproducer and patched brd (with a delay in read path) [1]:
> >
> > With latest 6.8 mainline, race caused data loss can be observed easily:
> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >   Polulating 32MB of memory region...
> >   Keep swapping out...
> >   Starting round 0...
> >   Spawning 65536 workers...
> >   32746 workers spawned, wait for done...
> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> >   Round 0 Failed, 15 data loss!
> >
> > This reproducer spawns multiple threads sharing the same memory region
> > using a small swap device. Every two threads updates mapped pages one b=
y
> > one in opposite direction trying to create a race, with one dedicated
> > thread keep swapping out the data out using madvise.
> >
> > The reproducer created a reproduce rate of about once every 5 minutes,
> > so the race should be totally possible in production.
> >
> > After this patch, I ran the reproducer for over a few hundred rounds
> > and no data loss observed.
> >
> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> > zram:
> >
> > Before:     10934698 us
> > After:      11157121 us
> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >
> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronou=
s device")
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Reported-by: "Huang, Ying" <ying.huang@intel.com>

Of course :), wasn't sure about how to add your credit, will add this to V2=
.

> > ---
> > Huge thanks to Huang Ying and Chris Li for help finding this issue!
> >
> >  mm/memory.c   | 19 +++++++++++++++++++
> >  mm/swap.h     |  5 +++++
> >  mm/swapfile.c | 16 ++++++++++++++++
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7e1f4849463a..fd7c55a292f1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3867,6 +3867,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > +                     /*
> > +                      * With swap count =3D=3D 1, after we read the en=
try,
> > +                      * other threads could finish swapin first, free
> > +                      * the entry, then swapout the modified page usin=
g
> > +                      * the same entry. Now the content we just read i=
s
> > +                      * stalled, and it's undetectable as pte_same()
> > +                      * returns true due to entry reuse.
> > +                      *
> > +                      * So pin the swap entry using the cache flag eve=
n
>
> "pin" doesn't sound intuitive here.  I know that the swap entry will not
> be freed with this.  But now, the parallel swap in will busy waiting.
> So, I suggest to say,
>
> Prevent parallel swapin from proceeding with the cache flag.  Otherwise,
> it may swapin first, free the entry, then swapout the modified page
> using the same entry ...

Good suggestion.

>
> > +                      * cache is not used.
> > +                      */
> > +                     if (swapcache_prepare(entry))
> > +                             goto out;
> > +
> >                       /* skip swapcache */
> >                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> >                                               vma, vmf->address, false)=
;
> > @@ -4116,6 +4130,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  unlock:
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +     /* Clear the swap cache pin for direct swapin after PTL unlock */
> > +     if (folio && !swapcache)
> > +             swapcache_clear(si, entry);
> >  out:
> >       if (si)
> >               put_swap_device(si);
> > @@ -4124,6 +4141,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out_page:
> > +     if (!swapcache)
> > +             swapcache_clear(si, entry);
> >       folio_unlock(folio);
> >  out_release:
> >       folio_put(folio);
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 758c46ca671e..fc2f6ade7f80 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
> >  void delete_from_swap_cache(struct folio *folio);
> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >                                 unsigned long end);
> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >               struct vm_area_struct *vma, unsigned long addr);
> >  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> > @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, str=
uct writeback_control *wbc)
> >       return 0;
> >  }
> >
> > +static inline void swapcache_clear(struct swap_info_struct *si, swp_en=
try_t entry)
> > +{
> > +}
> > +
> >  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> >               struct vm_area_struct *vma, unsigned long addr)
> >  {
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 556ff7347d5f..f7d4ad152a7f 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3365,6 +3365,22 @@ int swapcache_prepare(swp_entry_t entry)
> >       return __swap_duplicate(entry, SWAP_HAS_CACHE);
> >  }
> >
> > +/*
> > + * Clear the cache flag and release pinned entry.
>
> Even if we will keep "pin" in above comments, this is hard to be
> understood for reader.  Need a little more explanation like "release
> pinned entry for device with SWP_SYNCHRONOUS_IO.
>
> Or, just remove the comments.  We have comments in calling site already.

Then I prefer to remove this, there is only one caller, it should be
easy to understand.

> > + */
> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> > +{
> > +     struct swap_cluster_info *ci;
> > +     unsigned long offset =3D swp_offset(entry);
> > +     unsigned char usage;
> > +
> > +     ci =3D lock_cluster_or_swap_info(si, offset);
> > +     usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> > +     unlock_cluster_or_swap_info(si, ci);
> > +     if (!usage)
> > +             free_swap_slot(entry);
> > +}
> > +
> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> >  {
> >       return swap_type_to_swap_info(swp_type(entry));
>
> Otherwise it looks good for me, Thanks!
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks for the review.

