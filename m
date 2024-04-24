Return-Path: <linux-kernel+bounces-156101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD78AFDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D7B21F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1C79F3;
	Wed, 24 Apr 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PY8/f3X0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD548748A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713923245; cv=none; b=g5iXGnIRbZoL+YBZbT4VfJZsoixBcvbThl2XB0Uo2ADRsnWaPGwEP67y2R/9MPTpxrF2pH5hjVJBh7fj0duCGAEI/PQb/RTqIVQrvfFO4ORVjSODra65+eHaeEFr0/hklXeOHUiCK9AECAjfaglkOpHP6HDovFCqZ1rPShqFA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713923245; c=relaxed/simple;
	bh=ng27yw5ZrSFvmSZy3oZulctMXmjAV6Heti6o2RBiDGQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NplODudnQnbZtrWS5B547VoyCOihs1x2YbK0mUaqeF5jTgdXzXEwNQkxx8fqHaik4roxKFeFaIvNiT2dk23hCLL5cK4dwTON0n1V6jCyGOmnaQcuPcItfkm9jqrctImz2IK5ISZ0bLQLpCu5pQALCypi1FvBRno3SJcGxhvVBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PY8/f3X0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713923243; x=1745459243;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ng27yw5ZrSFvmSZy3oZulctMXmjAV6Heti6o2RBiDGQ=;
  b=PY8/f3X0aYszp13mN7Np7Wab0ry+s1LR6rD0SxNdik8mHjoujVOPZJTm
   5rPFCff8XECn5WXWE2HzG16qZW6qt4gnKsoT59l9paNz6kMRd5IA6vt/2
   1P3J8bD3KP9AxqIiI+385NIgXYSlkcAKPWHftztOE4hvSOEnk3ftQz3mD
   OkdSvjSHTQIfkBduphX+q6sD/VjXcvpBfHpNWcXQA2VjQ0ioY7hmtvdwU
   PpQOE+AKUvRAGZ+aQB8+AgmPVyf1yMSa70h0RnzgrqaMHuUSwZy+Mk7/k
   OyWhmis6iaxcv1Rouy34HDU37Ve9BYg6o2EKwrn5AuoXGATBdS9bc7dmu
   A==;
X-CSE-ConnectionGUID: pgYPuh2dS1ypQN1s+om7lQ==
X-CSE-MsgGUID: nsAo+CljTBegwhhPitLLrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9402457"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9402457"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 18:47:22 -0700
X-CSE-ConnectionGUID: E6DC0E5XSWCxGfB5A4Pdxg==
X-CSE-MsgGUID: MKeA+Ex/TTuF+cgkG67zhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24590466"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 23 Apr 2024 18:47:20 -0700
Message-ID: <09cc401c-8dbb-4790-9d38-c94a8b1e4fd4@linux.intel.com>
Date: Wed, 24 Apr 2024 09:45:56 +0800
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
Subject: Re: [PATCH v3 02/12] iommu/vt-d: Add cache tag invalidation helpers
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-3-baolu.lu@linux.intel.com>
 <40c3b216-f3bb-4058-88a1-45de433432f3@linux.intel.com>
 <BN9PR11MB5276DE66A1052497BB3E215D8C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276DE66A1052497BB3E215D8C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 4:42 PM, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Monday, April 22, 2024 1:30 PM
>>
>> On 4/16/24 4:06 PM, Lu Baolu wrote:
>>> +		case CACHE_TAG_NESTING_DEVTLB:
>>> +			/*
>>> +			 * Address translation cache in device side caches the
>>> +			 * result of nested translation. There is no easy way
>>> +			 * to identify the exact set of nested translations
>>> +			 * affected by a change in S2. So just flush the entire
>>> +			 * device cache.
>>> +			 */
>>> +			addr = 0;
>>> +			mask = MAX_AGAW_PFN_WIDTH;
>>> +			fallthrough;
>> I realized that the logic above is not right. Setting both @addr and
>> @mask to 0 doesn't means flush all caches on the device. I will change
>> it like below:
> I didn't get. Above code doesn't set @mask to 0.

Oh!? I have no idea why I read that as "mask = 0" now. Perhaps my brain
was on vacation earlier. :-)

> 
>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
>> index e8418cdd8331..18debb82272a 100644
>> --- a/drivers/iommu/intel/cache.c
>> +++ b/drivers/iommu/intel/cache.c
>> @@ -302,9 +302,14 @@ void cache_tag_flush_range(struct dmar_domain
>> *domain, unsigned long start,
>>                            * affected by a change in S2. So just flush
>> the entire
>>                            * device cache.
>>                            */
>> -                       addr = 0;
>> -                       mask = MAX_AGAW_PFN_WIDTH;
>> -                       fallthrough;
>> +                       info = dev_iommu_priv_get(tag->dev);
>> +                       sid = PCI_DEVID(info->bus, info->devfn);
>> +
>> +                       qi_flush_dev_iotlb(iommu, sid, info->pfsid,
>> info->ats_qdep,
>> +                                          0, MAX_AGAW_PFN_WIDTH);
>> +                       quirk_extra_dev_tlb_flush(info, 0,
>> MAX_AGAW_PFN_WIDTH,
>> +                                                 IOMMU_NO_PASID,
>> info->ats_qdep);
>> +                       break;
> and I didn't get this change. It goes backward by ignoring tag->pasid.
> 
> what's the exact problem of the fallthrough logic in original code?

Sorry! Please ignore this.

Best regards,
baolu

