Return-Path: <linux-kernel+bounces-134182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3B89AEB8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F393D282EA2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27BE2599;
	Sun,  7 Apr 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMqMhEsL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885131C0DFB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712469462; cv=none; b=XDt1iQbv/q1XW6m2PUNeIUVVjGycQGiUjtXoD67LxKSV28nMscO9y6fXbxSgKQn7p+NmKhv+2sBBpYqOsZUE1ciMYnOcSeNsw3hs9fzyPQau2YEkfZiFwkPcsUR3vesZ5xmWuPcp8YgyRV9D8pZxTQXZMtV1MaBWjpQEA+xajz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712469462; c=relaxed/simple;
	bh=usnhH0DZ5udvhO6SlC0QrBBmTfCt/zDw+XLfv5wegGA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RmRHv68D0CqAvGtBQEp0DuaK15w6AmDUeqqHXxdeKYrajQl1rwYOicocGS9EYjMfHrZuQVM3qftpmtvFMYAUD24mBkDnQOEwchyBtDXhDxiWcyzRKh8vaeL4fdKoClFvJJuVJmsZeoA7xsv2leY7TCC9B5LJd3Vz+jITSmkzq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMqMhEsL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712469461; x=1744005461;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=usnhH0DZ5udvhO6SlC0QrBBmTfCt/zDw+XLfv5wegGA=;
  b=bMqMhEsL1nqHPMvYjOHAB8aIxeX2lL463gQg0sv22oqgVHLjYh3FZxFF
   3OR4hnnUZmFACnWzvVdPqG8TcwBrXwYzTDebK+/YlJg5NMYnsOYo3g+SM
   jd3JsKEU1rMOfwXsE8HkWlNXGkrm8n2g3rByxHycdKKXjcfvvcXbdc2hJ
   MwNVglJhJDzG/5ee/ZaYhm/C/e+vf8ffyrngwL23bkiKuk+0NN7zl+hLq
   x6lwQvVM1EJjEwps9eCQDuwj6fg42OYdCT49J8kppW7e+DefatUolFPSr
   bUht//xTXGetI60IQts2MOeqQpNi/YGkCAk3Xo7ZiK+LDSWyMqXEXsChC
   w==;
X-CSE-ConnectionGUID: EvFwOEQhSHqh/YXlaYxc1g==
X-CSE-MsgGUID: CO8+FukNRJ+zlyUYBohM5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18331566"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="18331566"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 22:57:40 -0700
X-CSE-ConnectionGUID: GO9L8XFIR1eAW4c6f438xQ==
X-CSE-MsgGUID: B1s9+5aoStWPY5roNix+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="24044702"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 06 Apr 2024 22:57:36 -0700
Message-ID: <75766e12-0797-462a-93d9-2d1095b5959c@linux.intel.com>
Date: Sun, 7 Apr 2024 13:56:31 +0800
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
Subject: Re: [PATCH 04/12] iommu/vt-d: Use cache_tag_flush_all() in
 flush_iotlb_all
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A9E7198B3C9E0A61A1A78C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A9E7198B3C9E0A61A1A78C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 3:47 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 25, 2024 10:17 AM
>>
>> The flush_iotlb_all callback is called by the iommu core to flush
>> all caches for the affected domain. Use cache_tag_flush_all() in
>> this callback.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 21 +--------------------
>>   1 file changed, 1 insertion(+), 20 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 93e4422c9b10..4ce98f23917c 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1560,26 +1560,7 @@ static void parent_domain_flush(struct
>> dmar_domain *domain,
>>
>>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
>>   {
>> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> -	struct iommu_domain_info *info;
>> -	unsigned long idx;
>> -
>> -	xa_for_each(&dmar_domain->iommu_array, idx, info) {
>> -		struct intel_iommu *iommu = info->iommu;
>> -		u16 did = domain_id_iommu(dmar_domain, iommu);
>> -
>> -		if (dmar_domain->use_first_level)
>> -			domain_flush_pasid_iotlb(iommu, dmar_domain, 0,
>> -1, 0);
>> -		else
>> -			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> -						 DMA_TLB_DSI_FLUSH);
>> -
>> -		if (!cap_caching_mode(iommu->cap))
>> -			iommu_flush_dev_iotlb(dmar_domain, 0,
>> MAX_AGAW_PFN_WIDTH);
>> -	}
>> -
>> -	if (dmar_domain->nested_parent)
>> -		parent_domain_flush(dmar_domain, 0, -1, 0);
>> +	cache_tag_flush_all(to_dmar_domain(domain));
>>   }
>>
> 
> this replacement causes a functional change. Now devtlb is always
> invalidated while old code doesn't do so for caching mode.

You are right.

As my understanding of the VT-d spec, caching mode has nothing to do
with the device TLB, hence we should remove all checks on caching mode
before a device TLB invalidation.

I understand that people are leveraging the cache mode to avoid the
unnecessary VMEXIT from the guest OS since the host iommu unmap() path
ensures that device TLB is also invalidated.

Our direction should be to use the batched queue invalidation requests.
As we are consolidating code to a common place, that becomes much
easier. :-)

> Probably you may want to first clean up all inconsistent devtlb
> invalidation policies for caching mode before going to this series...

Sure thing!

Best regards,
baolu

