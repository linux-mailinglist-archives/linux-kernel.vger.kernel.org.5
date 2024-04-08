Return-Path: <linux-kernel+bounces-134890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385589B84F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4CB282ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355A223772;
	Mon,  8 Apr 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb+502fg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20869224D1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560920; cv=none; b=P6LUDwbFYnlynig9xl2mHp5rZ78IgUAVATu/Azyfly9xU8gFxEbCVGkyy8cgEgWAKEKvXkdb9IfPxIkMAWZaOUIRxZkSoLXXJQysJkO4Ql4PJnM+HlKKEOxgctu73iITTspeHMKJnZQlmfcAadWvtgXiLjNzoc1ZwcNREMVqKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560920; c=relaxed/simple;
	bh=QzvuJZ26Utrh89RrEL1YM+Orrua8Q0ZuWTa2M7hWXFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wsavhx37+qrgS1bYUKQA7iz1+3BNOxQkwgxejOu76mMCBCfBvjDqJtpPBXsnJXAcK8zmJJm8leCfr8eDcY6xn5r8lme3wKpJ3L5B3Dt5955xd9aGbT8DXM3cg25BpvwqhWYTHW99K6gcaNNwTLjRpAWmGlurCrhhkl89TpfvYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb+502fg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712560919; x=1744096919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QzvuJZ26Utrh89RrEL1YM+Orrua8Q0ZuWTa2M7hWXFM=;
  b=Tb+502fgXZWAAVIrJr9ceG1QD2ZdjRGDyPGJ659EAwvAaSGvELFJozhN
   HaxvtM4E0NfdHoq3APN5e0ZCViV3apVLbfr9DEc3WQBLRNWoto+3YvOup
   eRZLiiVPB0ogthSfwrhWSuvjQU3RJrMsS2MNekHXghRmeLq+njaCs3pQQ
   QEOe0bziRXJq5Q69+94iavibiRta50jjawNNGpMIbcuMF1+U2nqLFnuXM
   cyFrLmG/7Y7z4/9bqBVmOzy1YAuvIcPsEZ+oss76Kyeec++TfwUBC7x58
   uIqS/59NyOkU+FF/lgzRrjWMerMwKLqpQuVzejG0YFurrb+pfNp0IYP0i
   A==;
X-CSE-ConnectionGUID: DYWdSktUSPKBPgstoNatUw==
X-CSE-MsgGUID: 0qrhPn2aTR6/WDDIINKMRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7681825"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7681825"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:21:58 -0700
X-CSE-ConnectionGUID: nEjqtacRTxi+f+SvFSb1rQ==
X-CSE-MsgGUID: KsPygrmLR2abQtPSTSWunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="57256962"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:21:55 -0700
Message-ID: <d2440682-b5f7-47dd-af0b-6eadd3af6220@linux.intel.com>
Date: Mon, 8 Apr 2024 15:21:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240407144232.190355-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2024 10:42 PM, Lu Baolu wrote:
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
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 493b6a600394..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	if (!cap_caching_mode(iommu->cap) && !map)
> +	if (!map)

My understanding, we don't need patch[1/2] at all, and customer is just asking
about the CM & tlb flushing, it is great to have this commit [2/2].


Thanks,
Ethan

>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }
>   
> @@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>   						 DMA_TLB_DSI_FLUSH);
>   
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
>   	}
>   
>   	if (dmar_domain->nested_parent)

