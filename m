Return-Path: <linux-kernel+bounces-146139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B78A613E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D211F2202B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75314A8F;
	Tue, 16 Apr 2024 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWb4i0I9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF160F513
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236509; cv=none; b=FgLQfYuO3o/tgHRM8jKV1pxazQ2OGBPryaWYwPihq+zATON5nMlTnoPIRkgF7GexSczkyDsTulmkqnEV6z+DmJdINxBf51MuyDzx8ZrIthnLrl7M+xfjMVig9TavLS2BlP7vIDn8sw3F8eqvoRx1LBOhwbVSzL+Rl4xmfBYOIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236509; c=relaxed/simple;
	bh=8JUzdboIrt3pdc4QfLv60odrfsdm5iNrrhsfKzN5TYQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YkplutkaGYcXnIR7pFsIg6Y5WrFm863ZUXPqlkXod8PWHseivwPYdhJMRRqO3nzfRnYpcSOyQXLEzhiRsRqNRYr7xUaZYtJU0IDEE36T1h6H4BukHIKIPAYS0O2qB95r6GWu1BKFVYj2K962ki1sB5C8g4JW4GozRe8Lm71Lo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWb4i0I9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713236508; x=1744772508;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8JUzdboIrt3pdc4QfLv60odrfsdm5iNrrhsfKzN5TYQ=;
  b=iWb4i0I9hUw3yic/EYGLXXE8IrOWEzeknhCNBUl2gcb6JMOkmtxXHgvf
   Kc4crEAOyQDv0HhTyjqv4HXaOXm4WAV68M12gqb7wSuDHcMAvSvHZ+toV
   8GxEk6Pe7kfQBRSrXc3QGpnfuR3o6TLvD/yLaO94i4HrDCdKqCp4Wy0zU
   Yxx4TdM0qhPQMjsA69957iWlzF03QrLhv3ZY8mOYjY83VHr6hTsjWjqqy
   KmadTYOxm5uvtAPKWF3oKvmNv94AcsUbDxDNoUCQOx6Ic7ot402QakdPv
   1a6QSG4lNzT+nkJutuIj6uTzt9S+0HUOvnUNMRilROxXvIN6js5YCyM1L
   A==;
X-CSE-ConnectionGUID: u/cjC8lORpCR4SS1Hx9qDA==
X-CSE-MsgGUID: tbRmqt7ySx2SKeYxP3l/zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="31132951"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="31132951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:01:47 -0700
X-CSE-ConnectionGUID: LCUBInzjSTiYDdLMfPzjpg==
X-CSE-MsgGUID: lKz5wfoMRVSJcPUvLEDsLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22186275"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 15 Apr 2024 20:01:36 -0700
Message-ID: <2b8a3145-1f34-48e4-9822-a95c27f60ba1@linux.intel.com>
Date: Tue, 16 Apr 2024 11:00:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Yi Liu <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
 <f3502244-5f37-4f44-94a5-39939ba20eec@intel.com>
 <a5c4b57b-c1f8-4f75-95e4-9a462f4673c9@linux.intel.com>
 <66c09ac9-0107-4b86-993b-70ab6907fc21@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <66c09ac9-0107-4b86-993b-70ab6907fc21@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 2:56 PM, Yi Liu wrote:
> On 2024/4/15 13:00, Baolu Lu wrote:
>> On 4/15/24 10:43 AM, Yi Liu wrote:
>>> On 2024/4/15 10:22, Zhang, Tina wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> Sent: Monday, April 15, 2024 9:39 AM
>>>>> To: iommu@lists.linux.dev
>>>>> Cc: Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L 
>>>>> <yi.l.liu@intel.com>; Jacob
>>>>> Pan <jacob.jun.pan@linux.intel.com>; Joerg Roedel 
>>>>> <joro@8bytes.org>; Will
>>>>> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
>>>>> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
>>>>> Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
>>>>> device TLB flush
>>>>>
>>>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>>>> implementation caches not-present or erroneous 
>>>>> translation-structure entries
>>>>> except for the first-stage translation. The caching mode is 
>>>>> irrelevant to the
>>>>> device TLB, therefore there is no need to check it before a device TLB
>>>>> invalidation operation.
>>>>>
>>>>> Remove two caching mode checks before device TLB invalidation in 
>>>>> the driver.
>>>>> The removal of these checks doesn't change the driver's behavior in 
>>>>> critical
>>>>> map/unmap paths. Hence, there is no functionality or performance 
>>>>> impact,
>>>>> especially since commit <29b32839725f> ("iommu/vt-d:
>>>>> Do not use flush-queue when caching-mode is on") has already disabled
>>>>> flush-queue for caching mode. Therefore, caching mode will never call
>>>>> intel_flush_iotlb_all().
>>>> The current logic is if the caching mode is being used and a domain 
>>>> isn't using first level I/O page table, then flush-queue won't be 
>>>> used. Otherwise, the flush-queue can be enabled.
>>>> See https://github.com/torvalds/linux/commit/257ec29074
>>>>
>>>> In other words, if the caching mode is being used and a domain is 
>>>> using first level I/O page table, the flush-queue can be used for 
>>>> this domain to flush iotlb. Could the code change in this patch 
>>>> bring any performance impact to this case?
>>>
>>> This seems to have performance deduction in the nested translation case.
>>> The iommufd nested support bas been merged in 6.8, while the Qemu side
>>> is wip. So this performance deduction does not happen until Qemu is
>>> done. Should this also be considered as a performance regression? TBH.
>>
>> Caching mode is irrelevant to first-stage and nesting translations. If
>> the QEMU implementation still relies on caching mode for nesting
>> support, it's already broken.
> 
> For first-stage, yes, caching mode is irrelevant. But for nesting, still
> be relevant. Because it relies on caching mode to capture the mofifications
> of the pasid entry. Without caching mode, vIOMMU device model within 
> QEMU will miss the newly setup pasid entries, hence no way to setup nested
> translation at all.

Okay, it's reasonable that nesting translation still uses second-stage.
But the removed checks in this patch don't impact the pasid table change
capture, right?

Best regards,
baolu

