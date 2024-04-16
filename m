Return-Path: <linux-kernel+bounces-146138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAD8A613C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F5B2142F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D974134AB;
	Tue, 16 Apr 2024 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckdnkwWG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E6199BC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236307; cv=none; b=pJfhmLm+7bbwlI9PYawIHwm5FsUAdV8XC0VnmnUL22ZNqzFOPGsXlYTtBoQm6ewW0tv5XOCvfHMbXrFaqNzxhQYEOjhLM4rUoYw3EDd2F+f6FlqjLsuQBQHA28ZEKVdexavlejLXAlCa9qAP/Lq0VViYeGCEAAq/R0Ji77cxxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236307; c=relaxed/simple;
	bh=BnwpGwNp+5YU6aApL0zOgln6MzekW8/Pu06ULLBFAkQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fok4ENPxA7dLLfpvT3bimWGtaR+Q8tx9bI9LhoyUdpMYvDKeZSgqoi64E5/eDfbgJ660TxlRZ5E//7BQtj3yGGHslc4sYmTe27dxNMF2BvojzhNbNRMe0OjwoUII1AZmNvLn+9hHxIgmpeivI2g7zTfb3UEFOKwRWbfggIB9K4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckdnkwWG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713236305; x=1744772305;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BnwpGwNp+5YU6aApL0zOgln6MzekW8/Pu06ULLBFAkQ=;
  b=ckdnkwWGxSJax2RGwxXKgj5RJSer56qqoujEYwQsAYYUrhLPrhPWt3vG
   uwQujXNvYOULvGIcvnbrGS3U8RhuzPHxCMj9sCnUSD25Lq7xKxx5fEoK9
   AQr3ez2u9+ysScFPBxwdMyNEMKeGZI3iXWnmI36QvKFOiM+JT2VTqm4US
   iiiSU+3G/tixGT6QyyhzKaLn6vOHnLWB57CIo1x7AJI3z0XkQYCihL0b0
   RzaBHA2aQFu2kCes5jYJ+qEWHsglW50Tog6WCL/tfh3oPZSmNMdgOOwhh
   jS+QBq/CW5BUszoNvNFt778b4jaRUqRYhJOrE4AJi1GJzKRwRXhkvx+SK
   A==;
X-CSE-ConnectionGUID: wx6J60URTwC4yEqSO0euTQ==
X-CSE-MsgGUID: aMLkkFD6QGiewYU8x9fC/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19256858"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="19256858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:58:24 -0700
X-CSE-ConnectionGUID: Sa8bw42ATN+0hXTMrkACLA==
X-CSE-MsgGUID: DEVMaxGMSre/3Yd0zWhUZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26767880"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 15 Apr 2024 19:58:21 -0700
Message-ID: <da521760-c2d7-432e-8ace-8793d520ab09@linux.intel.com>
Date: Tue, 16 Apr 2024 10:57:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <9ba0b6a2-e6c1-46de-8d30-929567952c54@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9ba0b6a2-e6c1-46de-8d30-929567952c54@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/24 8:53 AM, Ethan Zhao wrote:
> On 4/15/2024 9:38 AM, Lu Baolu wrote:
>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>> implementation caches not-present or erroneous translation-structure
>> entries except for the first-stage translation. The caching mode is
>> irrelevant to the device TLB, therefore there is no need to check it
>> before a device TLB invalidation operation.
>>
>> Remove two caching mode checks before device TLB invalidation in the
>> driver. The removal of these checks doesn't change the driver's behavior
>> in critical map/unmap paths. Hence, there is no functionality or
>> performance impact, especially since commit <29b32839725f> ("iommu/vt-d:
>> Do not use flush-queue when caching-mode is on") has already disabled
>> flush-queue for caching mode. Therefore, caching mode will never call
>> intel_flush_iotlb_all().
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> Change log:
>> v3:
>>   - It turned out that the removals don't change the driver's behavior,
>>     hence change it from a fix patch to a cleanup one.
>>   - No functionality changes.
>> v2: 
>> https://lore.kernel.org/lkml/20240410055823.264501-1-baolu.lu@linux.intel.com/
>>   - Squash two patches into a single one.
>>   - No functionality changes.
>> v1: 
>> https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index a7ecd90303dc..f0a67e9d9faf 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct 
>> intel_iommu *iommu,
>>       else
>>           __iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>> -    /*
>> -     * In caching mode, changes of pages from non-present to present 
>> require
>> -     * flush. However, device IOTLB doesn't need to be flushed in 
>> this case.
>> -     */
>> -    if (!cap_caching_mode(iommu->cap) || !map)
>> +    if (!map)
>>           iommu_flush_dev_iotlb(domain, addr, mask);
>>   }
> 
> Given devTLB flushing is irrelavent to CM, put iommu_flush_dev_iotlb()
> in iommu_flush_iotlb_psi() and called with CM checking context is not
> reasonable. the logic is buggy.
> 
> static void __mapping_notify_one(struct intel_iommu *iommu, struct 
> dmar_domain *domain,
>                   unsigned long pfn, unsigned int pages)
> {
>      /*
>       * It's a non-present to present mapping. Only flush if caching mode
>       * and second level.
>       */
>      if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>          iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
>      else
>          iommu_flush_write_buffer(iommu);
> 
> 
> then how about fold all CM checking logic in iommu_flush_iotlb_psi()
> or speperate iommu_flush_dev_iotlb() from iommu_flush_iotlb_psi() ?

I am refactoring the code with a new series.

https://lore.kernel.org/linux-iommu/20240410020844.253535-1-baolu.lu@linux.intel.com/

Best regards,
baolu

