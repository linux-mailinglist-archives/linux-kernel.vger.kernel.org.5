Return-Path: <linux-kernel+bounces-55706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492AF84C093
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F419A28427B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5BA1C69A;
	Tue,  6 Feb 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJgW8y1C"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C191C29F;
	Tue,  6 Feb 2024 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260531; cv=none; b=rrz6TK6LE2xaVt2fUUvT3qiPyVjrKDze/IZtfO4gFI18qMonxcWgGfpRlMhkP+h5bC5txJqExrYrBQ70oL7oDEW8uwVmJpfWne1Oy/9CRul78HDdOI5nNn3peDymLxyl6bDBj3gXt4XHFZ0tK6uU7K0WermMVroM8js6C+CACew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260531; c=relaxed/simple;
	bh=DLxJCAAefpZO6ECJGu19NCyp4JaqTBkEytIQO5xdJvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRWzuFieMf57lAKNZe+P4iQ2zZfEPAPT3pvF6DX3z+OUTSYAZhOOOjJd2j1CMM1EO90Z3WMXkergz6KQMG9TEd9Qrw8uaWkkgZscEc1so5HS3pyvt4Bpk9xa3Fl+rKMWVuFOk4uyzkEXvhDYTd1PCWAmKN3uIgo8vYjPCVVwuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJgW8y1C; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e063dc2cfbso45339b3a.2;
        Tue, 06 Feb 2024 15:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707260529; x=1707865329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfB77vC+4atj07bEaB/PEOGtH0kMjPFp0jYbulqqEQs=;
        b=FJgW8y1Cek5A/OJ9XUmRGaiT//0fek87ZdAPSKnniznU/BAfs3YnaM8//a9tesa5JU
         a7mTLpSinRXOV0Maslt7uwSVrBfw+4yPZjs7SXbQh5OH9Im6lbtolyDr8Wk7t9G9SRB1
         6ECbTIKnK8KW9Ru4vDReHGgoxXt9hbwjammR6kyufRgxvAtItotUSV5veqBXoAkfs+iD
         9mR2zy/e+aXVPgBValETjsRSX5awcpHzvrv6Z09/JoyunUrnj5GxdLd0gtRL0SRCmjXy
         n/buG65ytAopbaxHlft1GcZ4zFu11HNbov8hwvn/JSBfsgEU3xSw2yBHKjGRpRfDmJu8
         uP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260529; x=1707865329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfB77vC+4atj07bEaB/PEOGtH0kMjPFp0jYbulqqEQs=;
        b=nzciqU7b8y1siyNSujHVB2uyN+WcnOrx3AUqkazPnlWjlmP3zhYbFEkFsVZuruHqZi
         /kR6e4RjNgVgTiHT+60g3fRsY3HaXHFsjJMtefVuvoYsbr3EXgOYnEvvtECBgMTNK1e6
         WzjdzSe7XU5OXDZ+F5+KvsJRpBdhUNMAH5P67s8bpxYtkYu3ZMn9oH7ci1YsuGrK8xP4
         dZo9NoMHK3Kv5dOV/19FbTy4YNF7KTLeMFqavwyXObXQ/70/FtRhQtszMh9Vr9B7HH9Y
         7W94EyLgPqx8EHFtNa5behZeIS+j4o7fnXOn2w+hSudl+VW8x02YJpwCxJ+WqaTedXHZ
         w42A==
X-Gm-Message-State: AOJu0Yx1s8ux+DonOy8CeiF0RJ/7yuL+/Iz33GG3TcZKCfz6jYSwd/vr
	4mTOKTJF949eUj6v8YyLtuW/ROUgvAZS4ovGx6q990XQ6HCftXjw
X-Google-Smtp-Source: AGHT+IG9sAQLbgCZ49HtvvjlKzpnRjY2k/ZxhsoMj7HykxM2KwYB8Rix26rWUa7GeoQmU7ekJD9VcA==
X-Received: by 2002:a05:6a20:5604:b0:19c:93b7:4a90 with SMTP id ir4-20020a056a20560400b0019c93b74a90mr2907659pzc.38.1707260529248;
        Tue, 06 Feb 2024 15:02:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJvrRRIoPsUmbKLAJEq6IyxnWrhlqJ7Mffj1snuJwfW+Lo0glumlocplCB5c0PdbAJgLdOjpkBGuSDP1QP9oLNL78WHf8UGTQY0XrIXi+tR3Ecd7q2Bldz/FFIRU1qZwgx/k99XmpZdF955tdJOmSnhrxcLUu1KXzTHtH7l13q2ePcF6B9EmheaOi2ykjRaT6UlA/fr3NFij47HOKW2biIs4ESz2wtZWEyzf+UXXbiPJ6GPCI+OOq/eJo11Gxa6OQBt7LpC2NhzlMh9pJLNkpSd+WC/HUuHgAKMs1KMcuXXvTgqO1ifVLqlAFZIQ1hwukoGSKlEKGKnph06pjOzjG9klT422ZcExVCV8dKefBwGF3MxP0u0SF3FzLGt5pk9lF8TbvBWvihFPAE0NMJXv3h6ZibVxXbJ3L/2+JEH6eKjgkfWmNmIhLJOTRW0JF+qOG+xyiVfMg=
Received: from google.com ([2620:0:1000:8411:af44:f774:c4ae:c82a])
        by smtp.gmail.com with ESMTPSA id z2-20020a62d102000000b006e0651ec052sm29048pfg.32.2024.02.06.15.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:02:08 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Tue, 6 Feb 2024 15:02:05 -0800
From: Minchan Kim <minchan@kernel.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Message-ID: <ZcK6bZpGEtgqBeZs@google.com>
References: <20240206182559.32264-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206182559.32264-1-ryncsn@gmail.com>

On Wed, Feb 07, 2024 at 02:25:59AM +0800, Kairui Song wrote:
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
> ...                                  set_pte_at()
>                                      swap_free() <- entry is free

                                       ^^^
nit: From the recent code, I see swap_free is called earlier than set_pte_at


>                                      <write to page B, now page A stalled>
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

Thanks for catching the issue, folks!

> 
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply busy wait since it's a rare
> and very short event.
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
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
> 
> ---
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
> 
>  include/linux/swap.h |  5 +++++
>  mm/memory.c          | 15 +++++++++++++++
>  mm/swap.h            |  5 +++++
>  mm/swapfile.c        | 13 +++++++++++++
>  4 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..8d28f6091a32 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>  	return 0;
>  }
>  
> +static inline int swapcache_prepare(swp_entry_t swp)
> +{
> +	return 0;
> +}
> +
>  static inline void swap_free(swp_entry_t swp)
>  {
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..1749c700823d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> +			/*
> +			 * Prevent parallel swapin from proceeding with
> +			 * the cache flag. Otherwise, another thread may
> +			 * finish swapin first, free the entry, and swapout
> +			 * reusing the same entry. It's undetectable as
> +			 * pte_same() returns true due to entry reuse.
> +			 */
> +			if (swapcache_prepare(entry))
> +				goto out;
> +
>  			/* skip swapcache */
>  			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>  						vma, vmf->address, false);
> @@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	/* Clear the swap cache pin for direct swapin after PTL unlock */
> +	if (folio && !swapcache)
> +		swapcache_clear(si, entry);
>  out:
>  	if (si)
>  		put_swap_device(si);
> @@ -4124,6 +4137,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> +	if (!swapcache)
> +		swapcache_clear(si, entry);
>  	folio_unlock(folio);
>  out_release:
>  	folio_put(folio);

What happens?

do_swap_page
  ..
  swapcache_prepare() <- tured the cache flag on
   
  folio = vma_alloc_folio <- failed to allocate the folio
  page = &foio->page; <- crash but it's out of scope from this patch

  ..
  if (!folio)
     goto unlock;

.
unlock:
  swapcache_clear(si, entry) <- it's skipped this time.
  

Can we simply introduce a boolean flag to state the special case and
clear the cache state based on the flag? 

if (swapcache_prepare())
  goto out;

need_clear_cache = true;

out_path:
   if (need_clear_cache)
      swapcache_clear



