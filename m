Return-Path: <linux-kernel+bounces-68428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ABF857A15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21A41F23C99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC91CAAF;
	Fri, 16 Feb 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzP1c+vc"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FC1C293;
	Fri, 16 Feb 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078492; cv=none; b=gsIVNB6+bgKpwk2i7Vjh3w+08QNF/343TjzGuV9M4fElznB6JxdOQYwXxP2OCqcZehc0PQ3KPwYzFfRI7AKYWE5cOK/N4UYiCc1en3pPSsNs7yXqLclbq+OpdUvtJqAGadfb4WzKgg9BMjU9VfR2RlpQ2KxLa/WgWiuD07diS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078492; c=relaxed/simple;
	bh=Q5+wxuyRmRCv42uLwWr9G6+u+rodM/d7qbV3WfA3J64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdsguX93WbSjJo7dr2Lkmkf3AvgO6XpMoherqM6W61h5wC0OlQsyaeo9yMybs1Bfu5UX00jiZxO1KQUQeklouez3Btv7oxKji35Jhr/SrCBf3MmIoZpN8ySg+pdhJXNpP67X8/LVXk4dEo8bKhZ6QX2Fuk9uQV3+hxjW8WBw7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzP1c+vc; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso1114211241.3;
        Fri, 16 Feb 2024 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708078490; x=1708683290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSYHXI66XwKTSc6WJlMFofSwyKlj48ODWraD8aKR9nI=;
        b=MzP1c+vcpdL7YeA+QqEEM69EBGY4igZ4MOp+n4u40MH0c86YPOYl9CnX49fWt6Hhnx
         oIF7bJfFsFv21JT+hXzcHNaMCbms3CNiTLcEuma75SP4Qfyq1NJ/QjdnjHDqPv/SOfl+
         sO0qpnntWMnwHaGwfgKC8wjUeCLfeJJGp+DvRfPSKDlJpmkMjIzy6wSrUAf4b9fNC/s+
         OLJOaBS+cmCbHef3M2PJmxyqZBIrpkhs7CjBPGqFZ0Ewf4BeGxptVl2dcND59RFJ6Obr
         K29XtHQlkBzPJ96aEZyAEvCNgrzMMGug9BSfoYI9a+eew9IT1FGJL8WQFjklASwJ9aL4
         ST2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078490; x=1708683290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSYHXI66XwKTSc6WJlMFofSwyKlj48ODWraD8aKR9nI=;
        b=r+6dnvHf1KW7G4NimzvaEOUI7RVIvU0K/iCjSanCocGy+UELDuQshRxxKlrftAuAb9
         GlyWsJ70mEfhYE2Rar3CW3/BM72280cBBhwtMf2rIUfAI5jCjAmZc5Rwi7XlAbj67FFg
         YEUNOqpzmX5lFCQy8vE49jAKxrvyKQn2pmLcB2nPtf+l0MGgUc7FX2172nmI2yu8X+Au
         ecbiJtGrGmTEv6cVjP3UY4WdFochUOIH1uksGGwur1ObK3X56P3J4LPHgi+HAUx50Ny4
         j2sjiH5mlTr532jXdogf3hRzf2WDr6cBduVw8B8m1w2lnBdn+yykSH5WMeOEjIfFvAJI
         A7cw==
X-Forwarded-Encrypted: i=1; AJvYcCXjLyXMnR38XCHdM/3AEP69PoxPZHmkqDY/5zVq18FfkeXli8NkyZz6Pog25M74RDf/N4hfZDzhdanrJg0MqXlqHgd3LENOkxD+hvx+zI7JfMPJeVMZOuYeXdDBVJXjqTk1ieRm
X-Gm-Message-State: AOJu0Ywg100sLCkCgdG8oC1LUINOwcWMw3ATF+Ru3z7oUeYfIyYy8LL8
	m5UT+y/dQ2nMC9bUT4dwXXJUTb6GPzEDWkdbftE0UmH4cVHXjSwWT88NyyQdNApVHhWydDxeqjq
	RsDLriSp1/XARYi5NJE0DkOI7WII=
X-Google-Smtp-Source: AGHT+IHNu7ysizze76oI0SjsrqhNLx5cve4rOLgIKmuQLl9AsgycB2dpKBhG6SkFifXfBjhrRIbLczFJsZDL6wyilpE=
X-Received: by 2002:a1f:4fc5:0:b0:4c0:1dae:c6a1 with SMTP id
 d188-20020a1f4fc5000000b004c01daec6a1mr4094014vkb.14.1708078489823; Fri, 16
 Feb 2024 02:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com>
In-Reply-To: <20240216095105.14502-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Feb 2024 23:14:38 +1300
Message-ID: <CAGsJ_4yJFtPdJapjboOxnmg=jdvatTGvTN50r_LKCRNoB0P0fA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:53=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> swapin the same entry at the same time, they get different pages (A, B).
> Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then swap out the possibly modified page
> reusing the same entry. It breaks the pte_same check in (T0) because
> PTE value is unchanged, causing ABA problem. Thread (T0) will
> install a stalled page (A) into the PTE and cause data corruption.
>
> One possible callstack is like this:
>
> CPU0                                 CPU1
> ----                                 ----
> do_swap_page()                       do_swap_page() with same entry
> <direct swapin path>                 <direct swapin path>
> <alloc page A>                       <alloc page B>
> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
> <slow on later locks or interrupt>   <finished swapin first>
> ..                                  set_pte_at()
>                                      swap_free() <- entry is free
>                                      <write to page B, now page A stalled=
>
>                                      <swap out page B to same swap entry>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> And besides, for ZRAM, swap_free() allows the swap device to discard
> the entry content, so even if page (B) is not modified, if
> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> it may also cause data loss.
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply wait since it's a rare and very
> short event. A schedule() call is added to avoid wasting too much CPU
> or adding too much noise to perf statistics
>
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to use the
> swap cache again. Parallel swapin using different methods leads to
> a much more complex scenario.
>
> Reproducer:
>
> This race issue can be triggered easily using a well constructed
> reproducer and patched brd (with a delay in read path) [1]:
>
> With latest 6.8 mainline, race caused data loss can be observed easily:
> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>   Polulating 32MB of memory region...
>   Keep swapping out...
>   Starting round 0...
>   Spawning 65536 workers...
>   32746 workers spawned, wait for done...
>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>   Round 0 Failed, 15 data loss!
>
> This reproducer spawns multiple threads sharing the same memory region
> using a small swap device. Every two threads updates mapped pages one by
> one in opposite direction trying to create a race, with one dedicated
> thread keep swapping out the data out using madvise.
>
> The reproducer created a reproduce rate of about once every 5 minutes,
> so the race should be totally possible in production.
>
> After this patch, I ran the reproducer for over a few hundred rounds
> and no data loss observed.
>
> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> zram:
>
> Before:     10934698 us
> After:      11157121 us
> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous =
device")
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-=
race [1]
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.=
corp.intel.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
>
> ---
> Update from V2:
> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>   and add noise to perf statistics.
> - Use a bool to state the special case instead of reusing existing
>   variables fixing error handling [Minchan Kim].
>
> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free =
so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae Park=
]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO inst=
ead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
>
> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>
>  include/linux/swap.h |  5 +++++
>  mm/memory.c          | 20 ++++++++++++++++++++
>  mm/swap.h            |  5 +++++
>  mm/swapfile.c        | 13 +++++++++++++
>  4 files changed, 43 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..8d28f6091a32 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>         return 0;
>  }
>
> +static inline int swapcache_prepare(swp_entry_t swp)
> +{
> +       return 0;
> +}
> +
>  static inline void swap_free(swp_entry_t swp)
>  {
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..7059230d0a54 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         struct page *page;
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
> +       bool need_clear_cache =3D false;
>         bool exclusive =3D false;
>         swp_entry_t entry;
>         pte_t pte;
> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> +                       /*
> +                        * Prevent parallel swapin from proceeding with
> +                        * the cache flag. Otherwise, another thread may
> +                        * finish swapin first, free the entry, and swapo=
ut
> +                        * reusing the same entry. It's undetectable as
> +                        * pte_same() returns true due to entry reuse.
> +                        */
> +                       if (swapcache_prepare(entry)) {
> +                               /* Relax a bit to prevent rapid repeated =
page faults */
> +                               schedule();
> +                               goto out;
> +                       }
> +                       need_clear_cache =3D true;

Hi Kairui,
i remember Ying had a suggestion to move swapcache_prepare after
swap_read_folio() to decrease race window. does that one even help
more to somehow "fix" the counting issue?


> +
>                         /* skip swapcache */
>                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
>                                                 vma, vmf->address, false)=
;
> @@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> +       /* Clear the swap cache pin for direct swapin after PTL unlock */
> +       if (need_clear_cache)
> +               swapcache_clear(si, entry);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_unlock(swapcache);
>                 folio_put(swapcache);
>         }
> +       if (need_clear_cache)
> +               swapcache_clear(si, entry);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> diff --git a/mm/swap.h b/mm/swap.h
> index 758c46ca671e..fc2f6ade7f80 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struc=
t writeback_control *wbc)
>         return 0;
>  }
>
> +static inline void swapcache_clear(struct swap_info_struct *si, swp_entr=
y_t entry)
> +{
> +}
> +
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr)
>  {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..746aa9da5302 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
>         return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +       struct swap_cluster_info *ci;
> +       unsigned long offset =3D swp_offset(entry);
> +       unsigned char usage;
> +
> +       ci =3D lock_cluster_or_swap_info(si, offset);
> +       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> +       unlock_cluster_or_swap_info(si, ci);
> +       if (!usage)
> +               free_swap_slot(entry);
> +}
> +
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  {
>         return swap_type_to_swap_info(swp_type(entry));
> --
> 2.43.0
>
>

Thanks
Barry

