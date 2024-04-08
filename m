Return-Path: <linux-kernel+bounces-135927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CA89CD27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81071F22BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ADA1474A4;
	Mon,  8 Apr 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC4fYGAo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3D1EB46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609942; cv=none; b=JdnZGhzYDmM6t4ruzM5QdN0vbdG/cAY7H3D2yKZnR7cHjbfw7PQMCQrExAwO/4vJ/35jRA5U0f2qLXM9NirwePI9Z1jn+Bi/PNE34VAgKbDVcAj7eOUtrZzU4uYmUBAih99evEuFXXJP4Gmh/4F4NihJataokzeOElVfg9GC5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609942; c=relaxed/simple;
	bh=Sp8ULhDiuUc9igWncb9vXY5dJILFO+9U0kIAbBLTpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kfz1weL5L3G2/fg3rZ62YC5B0cb02jDGWXtXvr/W1yRYapIkg7yW+8kXKOWx6kfbIEqa4IXG9NVka6X1grbM0Dopx1HX/V0+g3hE2i7scdPb29cyN1l6vNRN301ngwR9kToKfOhAldn7CSICpPCkJcXzkMNOFJk6JEsS0w3q7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC4fYGAo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712609941; x=1744145941;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sp8ULhDiuUc9igWncb9vXY5dJILFO+9U0kIAbBLTpnI=;
  b=CC4fYGAoUcsXwQ5Opdww9fsC4u6JsacTv1I9hHCkvMDIGtzvEb4AlTkT
   roY4ZYxMeIw6diMOPTdSeDKZMEpyE6xkOrFKF7CZNW8RuGeHgm8FxK8t7
   dfu97PWfVks3J8G8AxCQ6dCVt7/SOGWoOo1G2tNzybIFgnluF9MO8WUsK
   88cckYt+eAdCyBw+4+sOeXnqeKGDAbmB6U98zDomK3k1OCOUDBsH+XTJ5
   FPrgnLwDFqiYadlvqDdIygG5+VGI2GW2XXqtE4mSRQjsJzu/w46+r+kob
   vvhT6GXljqFUX8Oe2vGjqrUdGGoKEiwxGN2y/1AqLUfG08yL/yC4yjEGP
   w==;
X-CSE-ConnectionGUID: VB6vMlwtR0WMHeL8D7enjw==
X-CSE-MsgGUID: a5/gBSsHQayFCQyfQeaGwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19289633"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19289633"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:59:00 -0700
X-CSE-ConnectionGUID: yhOEEWpNTwC+KnlTevbKCQ==
X-CSE-MsgGUID: zYNBIbgvRQi+m5Cu9bJqdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20055284"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:59:00 -0700
Date: Mon, 8 Apr 2024 14:03:29 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Message-ID: <20240408140329.6290377f@jacob-builder>
In-Reply-To: <20240407144232.190355-2-baolu.lu@linux.intel.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Lu,

On Sun,  7 Apr 2024 22:42:32 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> unrelated to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
> 
> Before the scalable mode is introduced, caching mode is treated as
> an indication that the driver is running in a VM guest. This is just
> a software contract as shadow page table is the only way to implement
> a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
> the scalable mode is introduced, this doesn't stand for anymore, as
> caching mode is not relevant for the first-stage translation. A virtual
> IOMMU implementation is free to support first-stage translation only
> with caching mode cleared.
> 
> Remove the caching mode check before device TLB invalidation to ensure
> compatibility with the scalable mode use cases.
> 
I agree with the changes below, what about this CM check:

/* Notification for newly created mappings */
static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
				 unsigned long pfn, unsigned int pages)
{
	/*
	 * It's a non-present to present mapping. Only flush if caching mode
	 * and second level.
	 */
	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);

We are still tying devTLB flush to CM=1, no?

If we are running in the guest with second level page table (shadowed), can
we decide if devTLB flush is needed based on ATS enable just as the rest of
the cases?


> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
> default") Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 493b6a600394..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu, else
>  		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>  
> -	if (!cap_caching_mode(iommu->cap) && !map)
> +	if (!map)
>  		iommu_flush_dev_iotlb(domain, addr, mask);
>  }
>  
> @@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct
> iommu_domain *domain) iommu->flush.flush_iotlb(iommu, did, 0, 0,
>  						 DMA_TLB_DSI_FLUSH);
>  
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0,
> MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0,
> MAX_AGAW_PFN_WIDTH); }
>  
>  	if (dmar_domain->nested_parent)


Thanks,

Jacob

