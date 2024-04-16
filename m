Return-Path: <linux-kernel+bounces-146049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 772B98A5F77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45241C20FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F73D7A;
	Tue, 16 Apr 2024 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK7LQr/m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6981849
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228822; cv=none; b=H2RaITwly6oVVm6fxbVpI6OaMbpAt6RjQxNY0XOqqojmNjW7Gs0rCQ848oYR00I2MeooG3hlKx4XCbxp5oaCM7wf647AfC9IDlbC1dwZPd0RvEzVD9V0slZgY9XLHE2olODtLA4EyOOI2JvMRwhyan6VuSUIWCQyvr+8oKakK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228822; c=relaxed/simple;
	bh=4QEEm7R+LYFjuTsSjB6hxpehKVVeoexWojV1jUaHKdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDAI6TzYJnHOhsHxkeTxBBdq5OjI5yzFiHqM+NylKZYblaClq6KCKKWySXiDLmYX4aKpd7KvmIA9ES0jQXP4KFo6k6h2m6w37oxez8x4vTTnPdziJewOTVfUdSaRfnaSHiFhdnc4vheITNbWC7oXKQQghowmAb9sf/1sX95HcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fK7LQr/m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713228821; x=1744764821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4QEEm7R+LYFjuTsSjB6hxpehKVVeoexWojV1jUaHKdQ=;
  b=fK7LQr/m45q5tdwjmidyi0KASjkt1ysdeCbPlCWbsMdDKyCQ7Sd3jXGW
   wx0tWS+F0/i+OSryzO1c5aRA+po59ook6sBW7ewHEz+GjUGduktOly4LO
   gT6umZ9fAdsDvc9hviT7IuKchmIONOlwCjONNE7olUC5RGXivhYziAO7w
   kZlgnrX7wcQ72P0lFoMbluFXhxhTvp0PLcdhimk1NkzCImTVmwm/cbP3S
   4IP7V4/cj3+z/nR3rU2OhfMB4APe6KZBWthX3JdakqVFIDpR82W6D9h+L
   X1jR421omWdN5Z3wvS0nNg2etyRswhl5pFJM3DFwYlcM5N1zf2RTuhA/p
   A==;
X-CSE-ConnectionGUID: RTvwRkpISAyNx7dblc/eog==
X-CSE-MsgGUID: hmsLbK5mRFekqbwtbH8M4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="9198633"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="9198633"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 17:53:40 -0700
X-CSE-ConnectionGUID: e5Z5Dzc0ReiHkR+pNCIv2Q==
X-CSE-MsgGUID: sqFQzT/QQrC3UAw7i2A8Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22089851"
Received: from kzhong-mobl1.ccr.corp.intel.com (HELO [10.254.211.186]) ([10.254.211.186])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 17:53:37 -0700
Message-ID: <9ba0b6a2-e6c1-46de-8d30-929567952c54@linux.intel.com>
Date: Tue, 16 Apr 2024 08:53:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240415013835.9527-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/2024 9:38 AM, Lu Baolu wrote:
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except for the first-stage translation. The caching mode is
> irrelevant to the device TLB, therefore there is no need to check it
> before a device TLB invalidation operation.
>
> Remove two caching mode checks before device TLB invalidation in the
> driver. The removal of these checks doesn't change the driver's behavior
> in critical map/unmap paths. Hence, there is no functionality or
> performance impact, especially since commit <29b32839725f> ("iommu/vt-d:
> Do not use flush-queue when caching-mode is on") has already disabled
> flush-queue for caching mode. Therefore, caching mode will never call
> intel_flush_iotlb_all().
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> Change log:
> v3:
>   - It turned out that the removals don't change the driver's behavior,
>     hence change it from a fix patch to a cleanup one.
>   - No functionality changes.
> v2: https://lore.kernel.org/lkml/20240410055823.264501-1-baolu.lu@linux.intel.com/
>   - Squash two patches into a single one.
>   - No functionality changes.
> v1: https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a7ecd90303dc..f0a67e9d9faf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	/*
> -	 * In caching mode, changes of pages from non-present to present require
> -	 * flush. However, device IOTLB doesn't need to be flushed in this case.
> -	 */
> -	if (!cap_caching_mode(iommu->cap) || !map)
> +	if (!map)
>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }

Given devTLB flushing is irrelavent to CM, put iommu_flush_dev_iotlb()
in iommu_flush_iotlb_psi() and called with CM checking context is not
reasonable. the logic is buggy.

static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
				 unsigned long pfn, unsigned int pages)
{
	/*
	 * It's a non-present to present mapping. Only flush if caching mode
	 * and second level.
	 */
	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
	else
		iommu_flush_write_buffer(iommu);


then how about fold all CM checking logic in iommu_flush_iotlb_psi()
or speperate iommu_flush_dev_iotlb() from iommu_flush_iotlb_psi() ?


Thanks,
Ethan

>   
> @@ -1579,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>   						 DMA_TLB_DSI_FLUSH);
>   
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
>   	}
>   
>   	if (dmar_domain->nested_parent)

