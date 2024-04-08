Return-Path: <linux-kernel+bounces-134736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C789B632
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81373B21454
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335A566A;
	Mon,  8 Apr 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyR7Itfy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D05231
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545124; cv=none; b=nldCe/fm+os0LFAIS5mhK1tdykgz3vG/1Hp3NohQFv2ayaH5/GHRBTrATHBVcrXOvfhIyx3iLnU0xFDT4OEtkJu0lNDM++LZbVN49CNmCHSp6PW+8kAbbJjr0rheqecQe+TZWWlw77peerXkuTwgIiqDf7ATBmtJK3RLk8dUsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545124; c=relaxed/simple;
	bh=xl/j7o+V5BucCAp6FHo9IXZh4tcH+rZvWOuMNyIo/ws=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c8pyHM6hpY6KB1vA/Wo6bGpxZ2DhOnAc+H69Y/1BRBRg4mjSXIxFXbqThu2F3+rhf7WrrH2EFChtTGSRJJ2vG73AcfO2IkJdC9SnPfUUnl8HBPFACGLcU2BCr+01SA/qEs8rnP1mS+0aVO9bwsXfAxHOvZoGKPUpLaOKSC1ytQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyR7Itfy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712545122; x=1744081122;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xl/j7o+V5BucCAp6FHo9IXZh4tcH+rZvWOuMNyIo/ws=;
  b=JyR7ItfybAMIh28rp9m+FWyYD2l4RXzR3go5dXLmMggdTTIoiRF5Exhk
   riiKxML2FoGjK7hr0+7aCZWiQmeiadUKFKauwrvutwC/Y934E9lrxTtjr
   4wki4GW20q+QtZfsVfeiWXZbtNJB/D6yQAD6c7DkOUeFOrZoNwkbB8QFg
   BEWqZ+jXJwYmFB2dvmvXxaTf/ASK881rVHPa4RsLRvz4/vIeVmev6kaWc
   kKgJLCKfCQqX725Pu+X0TnGX4tegHGoGgZnNaVXQFU1szERRJKqWVk3RR
   pgMvgAXkFuEJSLMKN7bjmCMPrAYeUatGFC2ToqUW12nKaVldQCg8X900D
   g==;
X-CSE-ConnectionGUID: 28Zx6k22Sy+t0TppxX+1hA==
X-CSE-MsgGUID: cx0cS+5YRGCKaSHcznpc5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="10776349"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="10776349"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:58:41 -0700
X-CSE-ConnectionGUID: mBtZUugcSZ6kCSMNJtO4qg==
X-CSE-MsgGUID: bVjn6STkQI6+bUSk8y+QdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19858932"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 07 Apr 2024 19:58:39 -0700
Message-ID: <2fd6f316-0a20-428e-9852-50ba7fb3dae4@linux.intel.com>
Date: Mon, 8 Apr 2024 10:57:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] iommu/vt-d: Use cache_tag_flush_cm_range() in
 iotlb_sync_map
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52766C4CA9A27F34419AEE258C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7657779b-bda0-4303-96c5-33949cf6457c@linux.intel.com>
 <BN9PR11MB5276FDB6B86B8E49959236008C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FDB6B86B8E49959236008C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 10:51 AM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Sunday, April 7, 2024 2:41 PM
>>
>> On 3/28/24 3:48 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Monday, March 25, 2024 10:17 AM
>>>>
>>>> The iotlb_sync_map callback is called by the iommu core after non-
>> present
>>>> to present mappings are created. The iommu driver uses this callback to
>>>> invalidate caches if IOMMU is working in caching mode and second-only
>>>> translation is used for the domain. Use cache_tag_flush_cm_range() in
>> this
>>>> callback.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 22 +---------------------
>>>>    1 file changed, 1 insertion(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index 1c03d2dafb9d..2dcab1e5cd4d 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -1504,20 +1504,6 @@ static void iommu_flush_iotlb_psi(struct
>>>> intel_iommu *iommu,
>>>>    		iommu_flush_dev_iotlb(domain, addr, mask);
>>>>    }
>>>>
>>>> -/* Notification for newly created mappings */
>>>> -static void __mapping_notify_one(struct intel_iommu *iommu, struct
>>>> dmar_domain *domain,
>>>> -				 unsigned long pfn, unsigned int pages)
>>>> -{
>>>> -	/*
>>>> -	 * It's a non-present to present mapping. Only flush if caching mode
>>>> -	 * and second level.
>>>> -	 */
>>>> -	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>>>> -		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
>>>> -	else
>>>> -		iommu_flush_write_buffer(iommu);
>>>> -}
>>> iommu_flush_write_buffer is for a quite different issue. it's clearer to
>>> keep it separated from the iotlb helpers.
>> The VT-d spec describes the write buffer flushing in section 6.8. It
>> states,
>>
>> 1. Write buffer flushing is required only for earlier VT-d hardware
>>      implementations. Newer hardware implementations are expected to NOT
>>      require this.
>> 2. Write buffer flushing is related to cache invalidation. The hardware
>>      performs an implicit write-buffer-flushing as a pre-condition to
>>      the invalidation operations.
>>
>> According to this, write buffer flushing is only required in the map
>> path when IOMMU is not in caching mode and the RWBF iommu capability is
>> set, which perfectly matches the case of cache_tag_flush_cm_range().
>>
>> By doing it in cache_tag_flush_cm_range(), the code will be simpler and
>> easier for maintenance.
>>
> but above applies actually when caching mode is false or when 1st
> stage is being used. this is the opposite of what flush_cm_range()
> implies.
> 
> if we do it through a general flush_range() helper which accepts
> a parameter to indicate the map path, then it's reasonable to move
> this special handling to that helper as that is another trick which
> the caller doesn't need to know.

This could be an option. How about my proposal in another reply?

Best regards,
baolu

