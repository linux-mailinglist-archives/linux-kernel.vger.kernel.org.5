Return-Path: <linux-kernel+bounces-136174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C3A89D0C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86431F2503B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959B54BCA;
	Tue,  9 Apr 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdlTELSu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242A54BCB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632413; cv=none; b=GKXxdnDjuUx3/ONjp8OX/3Bi0LR1bZTNq3xuD0oQpDF3fFiHm7qGyG8e09hAzVvQdFpXP0O5vBZ45AGYsEgsSfrWchjmnb36ox3yRZUabvm6VuCUjbDPjs9TOQYZ+G5bbDf0aiTyXEHvrUs3mGiswDDS6nlvWB1jLgOIZ6gPx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632413; c=relaxed/simple;
	bh=1kaSOndBlWdCwwnNgxhFKJd0Bhrm4rCSDmsluZI84SA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XiBSsMkqlem3BYDV2efSxwGyMVKxbxrP7mA5fWNwD4ybYbR8XeTVyfFcsZU7IKQRovgNU9uy5TyMF3/kUFQsN4z0LJsPc75//nHn70VX/FinALmlbQfFHZPIYN6/xKNSwqix9C3+raXwdgPPM/RokMcQdiZCLmQaV9wQ6OSZ4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdlTELSu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632412; x=1744168412;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1kaSOndBlWdCwwnNgxhFKJd0Bhrm4rCSDmsluZI84SA=;
  b=TdlTELSuB3B3Op7j6XMPXFXrzqgrTEFRdVlJmZey3Xb50UneMd7uYWyu
   sbzo4ab2diRqiefzb3At4NJzvSS1+T5k45SoT2E3obj899DtZ8szjPQGO
   vCoBncxuJAnpG31Im53MYOEgl6qBSUBC1sE9R+BcPQ81Iiy3Dscyr8xtD
   qXyXTHsB0NGH1Yg3NZHTzuj9WRrzoAi1mG6G6SgPLvSv6ajwwq8hNGVYo
   89wKhPXyqmk8YJPDOMqJKIRKnZFYXG1b+mcOBC3g3I6nLQzrPKeS3Mz+G
   AHMW7WNlH0zQ+xhorxBGXdzDJM1MlFbGYQaF0uWxozLu/c2QASNOV9uQ0
   w==;
X-CSE-ConnectionGUID: 6Am8o/1WQQu6gdwBvCvA1Q==
X-CSE-MsgGUID: eQWUasGhTXSe2m3jA47HjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25435315"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25435315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:13:31 -0700
X-CSE-ConnectionGUID: GPF679Y3QhS8iAKBJWA5CA==
X-CSE-MsgGUID: wMtsLq4JRoy9HRUFM4lBEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24575021"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 08 Apr 2024 20:13:28 -0700
Message-ID: <aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
Date: Tue, 9 Apr 2024 11:12:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
 <20240408140329.6290377f@jacob-builder>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240408140329.6290377f@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 5:03 AM, Jacob Pan wrote:
> Hi Lu,

Hi Jacob,

> 
> On Sun,  7 Apr 2024 22:42:32 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
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
> I agree with the changes below, what about this CM check:
> 
> /* Notification for newly created mappings */
> static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
> 				 unsigned long pfn, unsigned int pages)
> {
> 	/*
> 	 * It's a non-present to present mapping. Only flush if caching mode
> 	 * and second level.
> 	 */
> 	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
> 		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
> 
> We are still tying devTLB flush to CM=1, no?

__mapping_notify_one() is called in the path where some PTEs are changed
from non-present to present.

In this scenario,

- if CM is set and first-stage translation is not used, the IOTLB caches
   are required to be explicitly flushed.
- else if hardware requires write buffer flushing, do it.
- Otherwise, no op.
- devtlb invalidation is irrelevant to this path.

The code after the fix appears to do the right thing. devTLB is not
invalidated in iommu_flush_iotlb_psi() since it's a map (map == 1).

Or perhaps I overlooked anything?

> 
> If we are running in the guest with second level page table (shadowed), can
> we decide if devTLB flush is needed based on ATS enable just as the rest of
> the cases?

I think the ATS check should be consistent. It's generic no matter how
the IOMMU is implemented (in hardware or emulated in software).

Best regards,
baolu

