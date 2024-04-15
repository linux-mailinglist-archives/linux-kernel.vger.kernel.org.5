Return-Path: <linux-kernel+bounces-144643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C28A48BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8E01F23644
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728C20DC4;
	Mon, 15 Apr 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpFC+Udj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B1208C3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165186; cv=none; b=qA/tnrht6EmE2mv/kWa04KHr4G/R5eY3uX006o7i+sX0u8puN/cN07NwjaBDKQ+fB5uf3yKfhRbwGbYWoVR7yAgAODJsgbeEea91Pfy6BAivieZPJypv80loBNo3b9WuDjPJRd6IeRk3Bwket9k0J3quyTn7WWCsEwlxkIDZHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165186; c=relaxed/simple;
	bh=5T7wocrkGUkYtFWVtAOkskz3wHL2g03x530sd6SWxxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PK1m6FMCuBEBFv1VikGKKW2ec+mYkKv74hL/Hz7+NmPsG23VqH1/fxDL+Zy/kKYA2vMMDcolxfLZNQuqqLxzqNyM9Cb0mvV+etTYjCNZmLwSbSuaZ27lD+1kNQtiwU22XszI0X2sX5WJoGdsDrkYx8mrxPkGcqNVJaObeVFkpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpFC+Udj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713165184; x=1744701184;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5T7wocrkGUkYtFWVtAOkskz3wHL2g03x530sd6SWxxU=;
  b=fpFC+Udj/B7Q4y8pOLYWGJyXWXJQYh+e5XS+DhSyIV4IxC6cgCT4P8gs
   n1L7hFPIKoHXPeIBJyYJkRVb/yezEtDl38+IBcOR6uXjt38XZYXAmIN3o
   Har6ez2VrJD9rs9/Y9rbOnrchWvBZkj/+lk/AV9/iT8swMTiJzDMacW/k
   VWOXHFQeJLhKtwa9hKiT/KmOCRomL//1EyYmccVEDIrwAokPTjDXRxI2Q
   urMdjm5jbMJElfwqLBahLfxuN9661hTnZJ71Q8LAXAAAXu5K+2Nyaytc8
   L0/DgWp0UKOGwCONkonjzbEYu0JbqM3rJlONMVeiFBWxhQeJFrNv2qspR
   g==;
X-CSE-ConnectionGUID: nNAZoaVnTiWh+8/VHIYxYQ==
X-CSE-MsgGUID: aw3755zATx+NsYG8A4140w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19249369"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19249369"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:13:02 -0700
X-CSE-ConnectionGUID: QpR5hby4QoaRypCiFjF4PA==
X-CSE-MsgGUID: equk+3cmTVKn7MThfaDkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21818366"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:12:58 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm: swap: make should_try_to_free_swap() support
 large-folio
In-Reply-To: <20240409082631.187483-3-21cnbao@gmail.com> (Barry Song's message
	of "Tue, 9 Apr 2024 20:26:28 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-3-21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 15:11:03 +0800
Message-ID: <87o7ab2j94.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> The function should_try_to_free_swap() operates under the assumption that
> swap-in always occurs at the normal page granularity, i.e., folio_nr_pages
                                                              ~~~~~~~~~~~~~~

nits: folio_nr_pages() is better for understanding.

Otherwise, LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> = 1. However, in reality, for large folios, add_to_swap_cache() will
> invoke folio_ref_add(folio, nr). To accommodate large folio swap-in,
> this patch eliminates this assumption.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 78422d1c7381..2702d449880e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3856,7 +3856,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
>  	 * reference only in case it's likely that we'll be the exlusive user.
>  	 */
>  	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
> -		folio_ref_count(folio) == 2;
> +		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
>  }
>  
>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)

