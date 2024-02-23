Return-Path: <linux-kernel+bounces-79238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB70861F60
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2701F246DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF814CAC5;
	Fri, 23 Feb 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6lx4zwv"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364D14C5B5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726186; cv=none; b=DA7ENUBJibr8J5gsb4xImrQCxYD99Ym/3lpaXVretLcG7VZIFVCSIz1h097kI/eFhG1+0RI13Ie+ymzZW5zTmv39JVQGSYAXU5hIrb+VMGeb0XHar33IANAYzCCcL6VzLhO+koJgxmep5Fg5+gLndScub+FLq4+5EK9sTy1RQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726186; c=relaxed/simple;
	bh=NfaUGlHI9XLsk1nlMEAR7M/7M17hVAq68eUm+2SFQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG8scCuFEOXhIcmDh7XrDhD9HCUbuIrW2Dq6SuulbcBzWP45RVfa2Sy3QY3jHWuLRs41SblDt6L/z92ZKlH2EpR/QZoqMnJN/BdYnLY6Oy97ZcFCFASc2UI363PqhA099jy9KrwMElk/0PepRHdhO95mJqsRYsglbfPX0M1RrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6lx4zwv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e4560664b5so1072321b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708726184; x=1709330984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDQUYGjK0gcC/i45nvgEKWYFzF6rZTJ86bsg/M9a66I=;
        b=J6lx4zwvTuHg3htV5KzjEq33zTT3XbqP2nlEJl0zZD/826fdnVdUkAbJG10QWRZhSh
         VqAqeM2h69WFOBrk4ZP0qXOEV07IDoJQRwHQLtt84my0dH/s5StF1X29/IAfquQh+xT3
         w+ilTJ1Q4geB/OD99XsV0P2NKe9GqbAUM+Eh40gjKfn2gLPUNrOt86W+aPzeen21K8mM
         QIM/bfZa98HS/TRk9np1rRhxEiEc5ZsVuuugcXKpIHCXzOn3Eul717KrUrUnpuNbhnB2
         ISegI370+s6tY6udeSAB4Z8RRT/rqHydSSzOX0366onFLGWr5rNGzbAGdwMupFeNtgFs
         Fz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726184; x=1709330984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDQUYGjK0gcC/i45nvgEKWYFzF6rZTJ86bsg/M9a66I=;
        b=V2gxM9+UM/SEfwHAVYoS0zt8PS4pQtE3DvXOPY0lVm1FdH4Ru/T7YPjyHjSjezk0AC
         SNCf3MuQwK6FBuXUbmBTgOHj5jnzNA78vxVPt0CXTS4QghbiE0z7MOhSVBGo7Fo0jeJE
         s7EM5mwYzWsRkdHedUmF4OTxZRbwBXlE2AteCwwen0BCulNESWYg+AJEnJf8ugDNrvRz
         mcVKAuLtskmXxCdCEUXlFV24mASvNYFWVcYCBFsp0VMmhxPyyu6NZ5kIn6W4jtdd6/xp
         3PXohHkIO1ivAZeRnDPQe1dCyfmwn3ADGmGP0v1rY3cSMNrkihfuSHOdjOQKyrrP5lNt
         daOw==
X-Forwarded-Encrypted: i=1; AJvYcCUmMsWDQyyLZqN0Eirp9ul6FSuA3j5/my2FvBeHD2zqkt3bZoaxG09ywDSfrOUlkPXEjXNgz/vBY9zN1F9S6jIqQ8tQ4Qx8/xdNq1os
X-Gm-Message-State: AOJu0YwQ4eouwHJ37aVqLjeEpPKFlcXGJOB1JH5IPIKP383mf8p2yeGB
	bqUN6CTjmsJVWAKOdULVOwZisUZ96dsrmZEArAaHpCC28dLuFaBwSoozNH0C
X-Google-Smtp-Source: AGHT+IG8ledTXUl0IDZBAqHjI2OfFBzfeL/4f3W2QpaICgJumHwDsuOA89YMgW/mABXln+9HXqbx5g==
X-Received: by 2002:a62:b505:0:b0:6e3:3bd7:6f23 with SMTP id y5-20020a62b505000000b006e33bd76f23mr960762pfe.8.1708726184168;
        Fri, 23 Feb 2024 14:09:44 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:6da7:9880:a81c:aee8])
        by smtp.gmail.com with ESMTPSA id a6-20020aa780c6000000b006e134c4d6b0sm13310100pfn.217.2024.02.23.14.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:09:43 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 23 Feb 2024 14:09:41 -0800
From: Minchan Kim <minchan@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
Message-ID: <ZdkXpcAB6xWj2geh@google.com>
References: <20240223041550.77157-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223041550.77157-1-21cnbao@gmail.com>

Hi Barry,

On Fri, Feb 23, 2024 at 05:15:50PM +1300, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> While doing MADV_PAGEOUT, the current code will clear PTE young
> so that vmscan won't read young flags to allow the reclamation
> of madvised folios to go ahead.

Isn't it good to accelerate reclaiming? vmscan checks whether the
page was accessed recenlty by the young bit from pte and if it is,
it doesn't reclaim the page. Since we have cleared the young bit
in pte in madvise_pageout, vmscan is likely to reclaim the page
since it wouldn't see the ferencecd_ptes from folio_check_references.

Could you clarify if I miss something here?


> It seems we can do it by directly ignoring references, thus we
> can remove tlb flush in madvise and rmap overhead in vmscan.
> 
> Regarding the side effect, in the original code, if a parallel
> thread runs side by side to access the madvised memory with the
> thread doing madvise, folios will get a chance to be re-activated
> by vmscan. But with the patch, they will still be reclaimed. But
> this behaviour doing PAGEOUT and doing access at the same time is
> quite silly like DoS. So probably, we don't need to care.
> 
> A microbench as below has shown 6% decrement on the latency of
> MADV_PAGEOUT,
> 
>  #define PGSIZE 4096
>  main()
>  {
>  	int i;
>  #define SIZE 512*1024*1024
>  	volatile long *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
>  	for (i = 0; i < SIZE/sizeof(long); i += PGSIZE / sizeof(long))
>  		p[i] =  0x11;
> 
>  	madvise(p, SIZE, MADV_PAGEOUT);
>  }
> 
> w/o patch                    w/ patch
> root@10:~# time ./a.out      root@10:~# time ./a.out
> real	0m49.634s            real   0m46.334s
> user	0m0.637s             user   0m0.648s
> sys	0m47.434s            sys    0m44.265s
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/damon/paddr.c |  2 +-
>  mm/internal.h    |  2 +-
>  mm/madvise.c     |  8 ++++----
>  mm/vmscan.c      | 12 +++++++-----
>  4 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 081e2a325778..5e6dc312072c 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  put_folio:
>  		folio_put(folio);
>  	}
> -	applied = reclaim_pages(&folio_list);
> +	applied = reclaim_pages(&folio_list, false);
>  	cond_resched();
>  	return applied * PAGE_SIZE;
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 93e229112045..36c11ea41f47 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -868,7 +868,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
>          unsigned long, unsigned long);
>  
>  extern void set_pageblock_order(void);
> -unsigned long reclaim_pages(struct list_head *folio_list);
> +unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references);
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *folio_list);
>  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index abde3edb04f0..44a498c94158 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -386,7 +386,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			return 0;
>  		}
>  
> -		if (pmd_young(orig_pmd)) {
> +		if (!pageout && pmd_young(orig_pmd)) {
>  			pmdp_invalidate(vma, addr, pmd);
>  			orig_pmd = pmd_mkold(orig_pmd);
>  
> @@ -410,7 +410,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  huge_unlock:
>  		spin_unlock(ptl);
>  		if (pageout)
> -			reclaim_pages(&folio_list);
> +			reclaim_pages(&folio_list, true);
>  		return 0;
>  	}
>  
> @@ -490,7 +490,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  
>  		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>  
> -		if (pte_young(ptent)) {
> +		if (!pageout && pte_young(ptent)) {
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			ptent = pte_mkold(ptent);
> @@ -524,7 +524,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		pte_unmap_unlock(start_pte, ptl);
>  	}
>  	if (pageout)
> -		reclaim_pages(&folio_list);
> +		reclaim_pages(&folio_list, true);
>  	cond_resched();
>  
>  	return 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 402c290fbf5a..ba2f37f46a73 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2102,7 +2102,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  }
>  
>  static unsigned int reclaim_folio_list(struct list_head *folio_list,
> -				      struct pglist_data *pgdat)
> +				      struct pglist_data *pgdat,
> +				      bool ignore_references)
>  {
>  	struct reclaim_stat dummy_stat;
>  	unsigned int nr_reclaimed;
> @@ -2115,7 +2116,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>  		.no_demotion = 1,
>  	};
>  
> -	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
> +	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
>  	while (!list_empty(folio_list)) {
>  		folio = lru_to_folio(folio_list);
>  		list_del(&folio->lru);
> @@ -2125,7 +2126,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>  	return nr_reclaimed;
>  }
>  
> -unsigned long reclaim_pages(struct list_head *folio_list)
> +unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references)
>  {
>  	int nid;
>  	unsigned int nr_reclaimed = 0;
> @@ -2147,11 +2148,12 @@ unsigned long reclaim_pages(struct list_head *folio_list)
>  			continue;
>  		}
>  
> -		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
> +		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
> +						   ignore_references);
>  		nid = folio_nid(lru_to_folio(folio_list));
>  	} while (!list_empty(folio_list));
>  
> -	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
> +	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), ignore_references);
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  
> -- 
> 2.34.1
> 

