Return-Path: <linux-kernel+bounces-140564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6558A1641
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA5EB26B69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A414D6FF;
	Thu, 11 Apr 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAIkcmdA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0B14BF8D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843328; cv=none; b=SioNEkvsoadt4iVCFDHaZMHJkf9ZTr2LH+kkYTYBtAVBSCi3J5BAnx5sfX53rjAMETrNkzZ+1O6hrMmkrLLdcNlMlFeH7li9x27ARvPKawiRD4gaKoXolDYPUpEoRUfC3OYpnDuzo/N2vX5h1D46WwXTNiRw4ycfrqSMb4sXwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843328; c=relaxed/simple;
	bh=xGNplq0dGEVxNyyn6OExBbLtHPrjPVL/jcM69HeNAH0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hckoWSOB+SUmQkJqFAzm9nlZVENEpUuk6XaHu27mGF3wYPAyzldehH8iaYF1wKSQrF9WJxHCL58Uwadi9QF9tdQthtltRJ4vyOTLNKlOvBMx7/s5cqrTuweyaGxs2anX4rLWS92QhgREREUdtVAELQkUXMFcYFgX/iB2TKV7RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAIkcmdA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712843327; x=1744379327;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xGNplq0dGEVxNyyn6OExBbLtHPrjPVL/jcM69HeNAH0=;
  b=lAIkcmdA0ZKPczc9O2BZ0Nefd0Om1moAwX0ZTyD0ImWlLqaBpTawj5xO
   38nhKNyQ8uFxHCKmWpoXt+3cmhmFtYWq2aQr+D4d6wc4CYN+CNZL+zjyu
   pbhinKSM6GO58MAlbEvfAuM8ME3TKEeWfqJLOCI+ze0iMrb/XbkZ0timI
   aQwBBwZMrz6xIHhdRd+U3VeJb7H9Q8QkbWg31APSeB4rFxiJGuGdpCLJu
   al/z9cyURNE19SqH56C9xKXvu72A+UeRuQkabUeQ2rSoKELsPVjUtOKus
   plq+1aWqXRXOYBgmIkZaY1mSt0P3/l47+a2M2V2yzV/pjxDLy2p3js5qn
   g==;
X-CSE-ConnectionGUID: pgF9KKSASrq2Fq7BdMvfsA==
X-CSE-MsgGUID: zDkFV8/kRieWr+fiaXeC9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8127512"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8127512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:48:46 -0700
X-CSE-ConnectionGUID: 45GIl950TEyf3UET/I8gYQ==
X-CSE-MsgGUID: xZddPnEiSU2/81SAj/BNMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25373830"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:48:43 -0700
Message-ID: <57d2fe8c-b438-42ae-a1ff-0ba0ee226c37@linux.intel.com>
Date: Thu, 11 Apr 2024 21:48:41 +0800
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
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
 <51055d13-4a72-4000-9a22-b403d8c5b2ff@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <51055d13-4a72-4000-9a22-b403d8c5b2ff@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/11 21:13, Robin Murphy wrote:
> On 10/04/2024 6:58 am, Lu Baolu wrote:
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
>>
>> The removal of caching mode check in intel_flush_iotlb_all() doesn't
>> impact anything no matter the IOMMU is working in caching mode or not.
>> Commit <29b32839725f> ("iommu/vt-d: Do not use flush-queue when
>> caching-mode is on") has already disabled flush-queue for caching mode,
>> hence caching mode will never call intel_flush_iotlb_all().
> 
> Well, technically it might still, at domain creation via 
> iommu_create_device_direct_mappings(), but domain->has_iotlb_device 
> should definitely be false at that point 🙂

Oh! I overlooked that path. :-)

Yes. iommu_create_device_direct_mappings() is called before setting the
domain to device for intel iommu driver, hence in practice the
domain->has_iotlb_device is always false.

Best regards,
baolu

