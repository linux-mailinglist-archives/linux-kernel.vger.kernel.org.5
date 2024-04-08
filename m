Return-Path: <linux-kernel+bounces-134896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC47989B85B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198D91C21F17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493292554B;
	Mon,  8 Apr 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWZgFEKa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8129CEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561040; cv=none; b=RuTZAV9tkKihEleOBB9KpxC2xQMVcRJ6/7gMoYDAJjD0Q7RPxE4Ts7Wlz0V910DitB5BR0SrRlrfWtJc5EQRy4sbSYCAYFdPLjMIgRZo5ujwXycgonE0OP2dJz0wVQ4smXUzcbYJTorRzbgVuG2ONMHcOdsJQcxchRTiddWHYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561040; c=relaxed/simple;
	bh=IicImq3z2qvLmGQsgKhqWxik+ce2KS2cRSEMO+XvwdM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PBNV8/NYUeKb/RRe413D25iVYnD8UH5QjMPrRzaQSMwRxpXxGWuZZ29Ew4WE5n9G8OnEqxuTQzYWdum8jcBaN5K2pdlxp2B6oUtmiSCWuhGr8qAPCLmkuO6IYRaM/6HxC+oqp+Ax1e8+h+qPmYvoOZ3bVcuNqt97G8osfKAsCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWZgFEKa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712561039; x=1744097039;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IicImq3z2qvLmGQsgKhqWxik+ce2KS2cRSEMO+XvwdM=;
  b=fWZgFEKak040GgIP7TDiSrlh4D8oeN5LApxf0zqUXlPUAleL9Sy+Io+J
   5G32lajKpNnzhy5zEi7cReJyXM9jYjskh6su/wyBbNExqQl+1lnxIzM+p
   dyzcWBV8S5cZgFNqJsea+m2LRUU6fj36ruJ9WbjZ6vjMATioEvORj1kyQ
   BTU1YIWy8fcWQVVZPb/2jdnYE8S3TGwdZc0yF9JcXR3bcGunsM+x+pNf1
   0hDhFtiJPwwZ+lrc4UubM7b+5U5NO9QWy7c2zwlYeGSkaD4ezGeUQS8HB
   S/dd88Yn5Tg2G72r0ZTpzPz98JM+aXqMcyN6jIWcVVoZ/hqAEyO41zo0B
   A==;
X-CSE-ConnectionGUID: rJJlcCNiRXGxb27e289+ew==
X-CSE-MsgGUID: MwfbXIfwQauDqMmJ6K9iYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18966794"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18966794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:23:59 -0700
X-CSE-ConnectionGUID: pMFad0P1SXW8jnvMBD8EMQ==
X-CSE-MsgGUID: 6s7CIl2MSg+Q5TTXBs4laA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19851737"
Received: from penghuan-mobl.ccr.corp.intel.com (HELO [10.254.211.109]) ([10.254.211.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:23:56 -0700
Message-ID: <cf0804fe-5d2c-490c-b28f-b23cb3db4b84@linux.intel.com>
Date: Mon, 8 Apr 2024 15:23:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
 <d2440682-b5f7-47dd-af0b-6eadd3af6220@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d2440682-b5f7-47dd-af0b-6eadd3af6220@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/8 15:21, Ethan Zhao wrote:
> On 4/7/2024 10:42 PM, Lu Baolu wrote:
>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>> implementation caches not-present or erroneous translation-structure
>> entries except the first-stage translation. The caching mode is
>> unrelated to the device TLB , therefore there is no need to check
>> it before a device TLB invalidation operation.
>>
>> Before the scalable mode is introduced, caching mode is treated as
>> an indication that the driver is running in a VM guest. This is just
>> a software contract as shadow page table is the only way to implement
>> a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
>> the scalable mode is introduced, this doesn't stand for anymore, as
>> caching mode is not relevant for the first-stage translation. A virtual
>> IOMMU implementation is free to support first-stage translation only
>> with caching mode cleared.
>>
>> Remove the caching mode check before device TLB invalidation to ensure
>> compatibility with the scalable mode use cases.
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by 
>> default")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 493b6a600394..681789b1258d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct 
>> intel_iommu *iommu,
>>       else
>>           __iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>> -    if (!cap_caching_mode(iommu->cap) && !map)
>> +    if (!map)
> 
> My understanding, we don't need patch[1/2] at all, and customer is just 
> asking
> about the CM & tlb flushing, it is great to have this commit [2/2].

Actually they fix different problems.

Best regards,
baolu

