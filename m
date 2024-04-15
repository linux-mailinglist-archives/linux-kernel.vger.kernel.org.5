Return-Path: <linux-kernel+bounces-144577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3738A47FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF4A1C21B54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850A8F510;
	Mon, 15 Apr 2024 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWccoPHu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F4C138
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161980; cv=none; b=EjGJm+XzW9U2ZimBpivjjg2PcfEpqYooXZnFjjWEUdGfg+IgtjdrN4A/0JQkwnur4kM6RK1VAf2Qxa3T6WMUMLwOQ3KzT3xHcvfEws/rePgGr1RLDSxEVxAjMroq4CFYCa/mlnjzQAzg0M2BNdsGNncx/urMzFy8UB53l0CKX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161980; c=relaxed/simple;
	bh=lJQwJ8XaCikZrjdfNcnmhKxcehDi16qkdeUs/IIX7ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gauG9I/JYOFkvPEZwbPYyeCH58sUi9k5PJrAK7uWS+z4U2ITjFFzFU/Pig7uBiMeXAGAyioxvJcbFgzxyn90QZTIIXX8FX9PP4h7QqrIHIP404c/j8YviQMCNFSLDvwfcUCm9yanwILVmpzVKVDWBHc5ORGsYfxkJ3mf7Yg2v3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWccoPHu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713161979; x=1744697979;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lJQwJ8XaCikZrjdfNcnmhKxcehDi16qkdeUs/IIX7ic=;
  b=QWccoPHuySj4HzzDgHOT1rWSKhQ09xHBkIx8UMogtHFYoJFPhnU5IcyV
   FMddna+25pRN5XrbJD5sUDFn5vmkF+eIeT+I4GmKY/+oTmE+Y6Jh78E3C
   bGUbSHSl4Uk4AWMFq9zWah+FhxBK/llMFho7KYZf+57gVDi7a50zjIrYV
   vk5MULzBf4ntyz5Fb87xI5sIVOjwISkfdExWgj7SsoaqeIUwqCN4HgRBh
   eIFmQJNs9QWOOn7hvYn42/WFV1Skr0o4wIhOdCtKFNr6DPCTvPRcyexdW
   q0pLOolveEHYypcETUudzlkaCO7c+ZVocabiHgO8KayG1BR4hNnU7zokL
   Q==;
X-CSE-ConnectionGUID: glA7H2IRTQKHSG8lvOHlRw==
X-CSE-MsgGUID: 9MliN/AMS1y30qqHOTHi0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8390532"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8390532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:19:38 -0700
X-CSE-ConnectionGUID: 0Kd1SlWJS4yLJTSJSdTkVw==
X-CSE-MsgGUID: jMIJiqviSPGZpGr31tJ9ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="59251237"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:19:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched
 swap_free()
In-Reply-To: <20240409082631.187483-2-21cnbao@gmail.com> (Barry Song's message
	of "Tue, 9 Apr 2024 20:26:27 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-2-21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 14:17:40 +0800
Message-ID: <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> While swapping in a large folio, we need to free swaps related to the whole
> folio. To avoid frequently acquiring and releasing swap locks, it is better
> to introduce an API for batched free.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |  5 +++++
>  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..b7a107e983b8 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
> +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>  int swap_type_of(dev_t device, sector_t offset);
> @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>  
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 28642c188c93..f4c65aeb088d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
>  		__swap_entry_free(p, entry);
>  }
>  
> +/*
> + * Free up the maximum number of swap entries at once to limit the
> + * maximum kernel stack usage.
> + */
> +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER)
> +
> +/*
> + * Called after swapping in a large folio,

IMHO, it's not good to document the caller in the function definition.
Because this will discourage function reusing.

> batched free swap entries
> + * for this large folio, entry should be for the first subpage and
> + * its offset is aligned with nr_pages

Why do we need this?

> + */
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +	int i, j;
> +	struct swap_cluster_info *ci;
> +	struct swap_info_struct *p;
> +	unsigned int type = swp_type(entry);
> +	unsigned long offset = swp_offset(entry);
> +	int batch_nr, remain_nr;
> +	DECLARE_BITMAP(usage, SWAP_BATCH_NR) = { 0 };
> +
> +	/* all swap entries are within a cluster for mTHP */
> +	VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
> +
> +	if (nr_pages == 1) {
> +		swap_free(entry);
> +		return;
> +	}

Is it possible to unify swap_free() and swap_free_nr() into one function
with acceptable performance?  IIUC, the general rule in mTHP effort is
to avoid duplicate functions between mTHP and normal small folio.
Right?

> +
> +	remain_nr = nr_pages;
> +	p = _swap_info_get(entry);
> +	if (p) {
> +		for (i = 0; i < nr_pages; i += batch_nr) {
> +			batch_nr = min_t(int, SWAP_BATCH_NR, remain_nr);
> +
> +			ci = lock_cluster_or_swap_info(p, offset);
> +			for (j = 0; j < batch_nr; j++) {
> +				if (__swap_entry_free_locked(p, offset + i * SWAP_BATCH_NR + j, 1))
> +					__bitmap_set(usage, j, 1);
> +			}
> +			unlock_cluster_or_swap_info(p, ci);
> +
> +			for_each_clear_bit(j, usage, batch_nr)
> +				free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR + j));
> +
> +			bitmap_clear(usage, 0, SWAP_BATCH_NR);
> +			remain_nr -= batch_nr;
> +		}
> +	}
> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */

put_swap_folio() implements batching in another method.  Do you think
that it's good to use the batching method in that function here?  It
avoids to use bitmap operations and stack space.

--
Best Regards,
Huang, Ying

