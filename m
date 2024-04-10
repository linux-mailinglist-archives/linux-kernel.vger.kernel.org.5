Return-Path: <linux-kernel+bounces-138129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49E89ECF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B096B23A77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825113D2BA;
	Wed, 10 Apr 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7Y7/4ub"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218F13D293
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736155; cv=none; b=UICVldD7olZZdJvY3agmOwU5XQAifYOrl5QcajTR/VCjYuR3IM2GCWvLgAEILVpxk/TH9LUgjhlx6Ipgns07AXN6G0s1BXkzFTYmaeQp7aUms003h7BLzPkl3y80brsEadxaKO4V27BLQhy55B6OAdUUTH8uy8Zrjj4+uvEUY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736155; c=relaxed/simple;
	bh=ns5iFXaPS2mOe7i63bnwPeaQB9a+vK/75Dv/SXu4kPo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B9ZeF2FDOBmV5d+OV0Xjh99QYoaN0hNluLPg4t0ISXVFKxt0NnPDJ/L4X3OnPfduEt6bQu2eHqv4oU92ZlR3Zb2D2rZMvUyqOXOaMcjAJCwFO0okx6tcukp3RV157Z8Lml4shES9mTn6UNclKDgWc9tHP7pv86oZIlFkCRIKk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7Y7/4ub; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712736154; x=1744272154;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ns5iFXaPS2mOe7i63bnwPeaQB9a+vK/75Dv/SXu4kPo=;
  b=I7Y7/4ubG+sDu72IG62CBW5aQnTbAS+3xxKDUnRCHvptSlt0TTvnO4RG
   2fdttizQvh3An7L2hQ+a8cAzIPMR3kbpRXyQ6R7QgrT91Pyg1adv8Ir5r
   FvOidMiJaLObw4Yd7wN+bnCXdhNK7QYhIV06pviaYfIrXaBcKZQdoIASH
   zYtB6VR0hKd0qnObKSD0bI8lQH20Pp8yJ8QzNJpYXf06W7awNCAvsagDb
   vKxkj477XeDOfznvy/S/LLn+PBpM+TmQP5YYJX0NO8gAGiDgvWv0YHKQH
   Cn93rJHxGnh9X47CFIW3t3goqSMw7sLg70QCBqOyA/BlA8mUU4aAM8hvf
   Q==;
X-CSE-ConnectionGUID: 2UgSiUJCQW+6vCDGcCSmQQ==
X-CSE-MsgGUID: Z4snNm6/T7uXvEssBAR8og==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33488836"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33488836"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:02:29 -0700
X-CSE-ConnectionGUID: YatJKCZ1SROZ0ZlY2uIrig==
X-CSE-MsgGUID: b4Gf+aVbTmeChF1ZQ+xihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20365966"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:02:27 -0700
Message-ID: <0231631b-44ca-45ee-adf9-0a5c8852cc27@linux.intel.com>
Date: Wed, 10 Apr 2024 16:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
 <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/10 14:30, Yi Liu wrote:
> On 2024/4/10 13:58, Lu Baolu wrote:
>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>> implementation caches not-present or erroneous translation-structure
>> entries except the first-stage translation. The caching mode is
>> irrelevant to the device TLB , therefore there is no need to check
>> it before a device TLB invalidation operation.
>>
>> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
>> mode check before device TLB invalidation will cause device TLB
>> invalidation always issued if IOMMU is not running in caching mode.
>> This is wrong and causes unnecessary performance overhead.
> 
> I don't think the original code is wrong. As I replied before, if CM==0,
> the iommu_flush_iotlb_psi() is only called in unmap path, in which the
> @map is false. [1] The reason to make the change is to make the logic
> simpler. 🙂

Oh, I see. There is a magic

         if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
                 iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);

in __mapping_notify_one().

So if it's caching mode, then

  - iommu_flush_iotlb_psi() will be called with @map=1 from
    __mapping_notify_one(), "!cap_caching_mode(iommu->cap) || !map" is
    not true, and device TLB is not invalidated.
  - iommu_flush_iotlb_psi() will also be called with @map=0 from
    intel_iommu_tlb_sync(), device TLB is issued there.

That's the expected behavior for caching mode.

If it's not the caching mode, then

  - iommu_flush_iotlb_psi() will be called with @map=0 from
    intel_iommu_tlb_sync(), device TLB is issued there.

That's also the expected behavior.

So the existing code is correct but obscure and difficult to understand,
right? If so, we should make this patch as a cleanup rather than a fix.

Best regards,
baolu

