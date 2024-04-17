Return-Path: <linux-kernel+bounces-147809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F88A79F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549D4B2182F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66517C2;
	Wed, 17 Apr 2024 00:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvxxv8E6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45C7EC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314827; cv=none; b=FH8UImXtA4TuVVTZrVRQjUnDa2BcUdZZVQNhvKiA5iNZhpvJOv1lYUDq5obpmWk0mtaNa3N/a452pMYnLuGcTOp6dSdnEdarTADlrrxqzqhG49XWWBBNFtwYuuoXLILaDp82R3aOYqQRVhHOcftKVEoj6fOZcmL9Oa+WYEssWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314827; c=relaxed/simple;
	bh=5dvi4VPpgT1ZktQgmIBxXxoJVztUqyGPi0waqwUMCDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVARKXgUxItn6Bgo0Vi8xbyDV1uqUbVAXviZ5MWsWeQoDWpo+AhEe9xkWgeoGsuin8bEk8lYSsU+S7+4zDtSdAGhh0OvI9ClmhGafRUnY8SIzfyLe+UaAm82ErGsW4sGHaURqE77KbekLZeCqdeURDkCt2xbc8lT2Z/mfQaww4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvxxv8E6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713314826; x=1744850826;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5dvi4VPpgT1ZktQgmIBxXxoJVztUqyGPi0waqwUMCDQ=;
  b=jvxxv8E6fV64VrCdpCSWvKDlC76IrDXVCD8bq/XlRQ8LA7y8HXRbxcId
   3zRCWoBmLsvL0JiMvtmkkLp9CIvs/XEvnhxrHEYvxpJZHyDZxE7SU8o8+
   z1TVqtUl1kNnvPbtaxyOk7xalt8xPefCS224r5SEdpd0bbo0EwcPTMmAi
   sOJxM6KS5wK49Q3EkXQfVypsf90S4wQNgt3j9hl6iasaszpUKjShYZfMe
   qoCd7b0Ce1tQ1wmUMxx2bADiERokZ1GAg9IheZkhYOY1NapHcyu5Yf1Ls
   hglcChBQE7cs8Vsh5Vl7UGLOB5iDE4vt/T66c48A3EszQJgbjqko7pZJN
   g==;
X-CSE-ConnectionGUID: 5YxCcmU+SAqKSSuk1YXtIA==
X-CSE-MsgGUID: rJO7cSUTSIKQyOhRqLkyxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12573654"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12573654"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:47:05 -0700
X-CSE-ConnectionGUID: XyeW91dxRoKxySgyFn7ZSA==
X-CSE-MsgGUID: Zt0xu/AiSuCX1oRTrLwgkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22519708"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:47:00 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  ryan.roberts@arm.com,  surenb@google.com,
  v-songbaohua@oppo.com,  willy@infradead.org,  xiang@kernel.org,
  yosryahmed@google.com,  yuzhao@google.com,  ziy@nvidia.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
In-Reply-To: <20240409082631.187483-6-21cnbao@gmail.com> (Barry Song's message
	of "Tue, 9 Apr 2024 20:26:31 +1200")
References: <20240409082631.187483-1-21cnbao@gmail.com>
	<20240409082631.187483-6-21cnbao@gmail.com>
Date: Wed, 17 Apr 2024 08:45:07 +0800
Message-ID: <87frvk24x8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> Currently, we are handling the scenario where we've hit a
> large folio in the swapcache, and the reclaiming process
> for this large folio is still ongoing.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/huge_mm.h | 1 +
>  mm/huge_memory.c        | 2 ++
>  mm/memory.c             | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8256af83e33..b67294d5814f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -269,6 +269,7 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_ALLOC_FALLBACK,
>  	MTHP_STAT_ANON_SWPOUT,
>  	MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +	MTHP_STAT_ANON_SWPIN_REFAULT,

This is different from the refault concept used in other place in mm
subystem.  Please check the following code

	if (shadow)
		workingset_refault(folio, shadow);

in __read_swap_cache_async().

>  	__MTHP_STAT_COUNT
>  };

--
Best Regards,
Huang, Ying

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d8d2ed80b0bf..fb95345b0bde 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_alloc_attr.attr,
>  	&anon_alloc_fallback_attr.attr,
>  	&anon_swpout_attr.attr,
>  	&anon_swpout_fallback_attr.attr,
> +	&anon_swpin_refault_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 9818dc1893c8..acc023795a4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		nr_pages = nr;
>  		entry = folio->swap;
>  		page = &folio->page;
> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
>  	}
>  
>  check_pte:

