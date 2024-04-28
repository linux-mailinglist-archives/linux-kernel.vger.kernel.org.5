Return-Path: <linux-kernel+bounces-161412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D578B4BA9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2DF1F21690
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE936A359;
	Sun, 28 Apr 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cq9fThlO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102369D3C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306384; cv=none; b=rYWTkAwae0+qmXFLlJlmmuXDUn9Sb2jBW9sOFRwM6O2k8TaZfGlhYm2WCOVlwyZ1HZAypthzbYjPn3VkjdnI0Wp9NbzxpLWKD1Id1qeTzp4jCBJ0suZenUPgc3/LNGfPdx2REmcEWlANusgpm1tTQD5aXe0h4I0iHBpzgZO5pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306384; c=relaxed/simple;
	bh=W/UgtUyxaHLsPcJ+ga9AeASOOdq1iI94EO3mRhaSb80=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEoGFyWbszLS8UW1OIvhtXoH7ebb4UwfiV6QiLBkeqormxN7+7zKHo2YRoNLGQ73koxueEvmwAL2C/2zs/BwuNJ9y63wnQmwgcnc58ZKNaZgF39VJ0KRETavqkbDYlANc99TiYK02cRhi1btHFM0cFyXjocRITa5t5sYPx7vhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cq9fThlO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714306381; x=1745842381;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W/UgtUyxaHLsPcJ+ga9AeASOOdq1iI94EO3mRhaSb80=;
  b=Cq9fThlO+iE3nE4L+DwqKWw/Gz9nZaWS1V1p34Day/NaWUg36I4DgUgE
   F1JjCygkuI30a/GU1yUxLH8npoKwGQ5bqG1/5k3f3MREyCQi/cJT1hbVR
   Ayr/KLxBZxu/+OqxvzCOPVL4oGQj+TQcu34+MrSKeA8mDICrld6x/dSHk
   UxeweEM7uy1ef3l0V1iYBoLF0/U74ZIEuUCor2+2NndyGJ+1m2clyOTYu
   5pQ9kOmUYkdQ9POiY21n8xxO5u62CWV1CoIt9xo2Aw9tTyCvFEaUq01YQ
   mZV9yUUyCZiiW0+aYqlRpcEghXmlK9K+fifBIwdyYmaN6iaVmyehwgTdE
   g==;
X-CSE-ConnectionGUID: buVl+stiSsSCQE0dj3xajA==
X-CSE-MsgGUID: qktxHShURd6p0OteEp3aHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="35373131"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="35373131"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 05:13:01 -0700
X-CSE-ConnectionGUID: CMutR6kmRP2Pa6mU08/a7w==
X-CSE-MsgGUID: EXspfr5dRjuBaLJJUBbVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="25872323"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 05:12:58 -0700
Message-ID: <850146ff-ce6f-44b3-9326-d44d29550b34@linux.intel.com>
Date: Sun, 28 Apr 2024 20:12:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Decouple igfx_off from graphic identity
 mapping
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
References: <20240428032020.214616-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276AF4C9A57C3B8D3A25E8E8C142@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276AF4C9A57C3B8D3A25E8E8C142@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/28 14:45, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, April 28, 2024 11:20 AM
>>
>> A kernel command called igfx_off was introduced in commit <ba39592764ed>
>> ("Intel IOMMU: Intel IOMMU driver"). This command allows the user to
>> disable the IOMMU dedicated to SOC-integrated graphic devices.
>>
>> Commit <9452618e7462> ("iommu/intel: disable DMAR for g4x integrated
>> gfx")
>> used this mechanism to disable the graphic-dedicated IOMMU for some
>> problematic devices. Later, more problematic graphic devices were added
>> to the list by commit <1f76249cc3beb> ("iommu/vt-d: Declare Broadwell igfx
>> dmar support snafu").
>>
>> On the other hand, commit <19943b0e30b05> ("intel-iommu: Unify
>> hardware
>> and software passthrough support") uses the identity domain for graphic
>> devices if CONFIG_DMAR_BROKEN_GFX_WA is selected.
>>
>> +       if (iommu_pass_through)
>> +               iommu_identity_mapping = 1;
>> +#ifdef CONFIG_DMAR_BROKEN_GFX_WA
>> +       else
>> +               iommu_identity_mapping = 2;
>> +#endif
>> ...
>>
>> static int iommu_should_identity_map(struct pci_dev *pdev, int startup)
>> {
>> +        if (iommu_identity_mapping == 2)
>> +                return IS_GFX_DEVICE(pdev);
>> ...
>>
>> In the following driver evolution, CONFIG_DMAR_BROKEN_GFX_WA and
>> quirk_iommu_igfx() are mixed together, causing confusion in the driver's
>> device_def_domain_type callback. On one hand, dmar_map_gfx is used to
>> turn
>> off the graphic-dedicated IOMMU as a workaround for some buggy
>> hardware;
>> on the other hand, for those graphic devices, IDENTITY mapping is required
>> for the IOMMU core.
>>
>> Commit <4b8d18c0c986> "iommu/vt-d: Remove
>> INTEL_IOMMU_BROKEN_GFX_WA" has
>> removed the CONFIG_DMAR_BROKEN_GFX_WA option, so the
>> IDENTITY_DOMAIN
>> requirement for graphic devices is no longer needed. Therefore, this
>> requirement can be removed from device_def_domain_type() and igfx_off
>> can
>> be made independent.
>>
>> Fixes: 4b8d18c0c986 ("iommu/vt-d: Remove
>> INTEL_IOMMU_BROKEN_GFX_WA")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index fbbf8fda22f3..57a986524502 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -217,12 +217,11 @@ int intel_iommu_sm =
>> IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
>>   int intel_iommu_enabled = 0;
>>   EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>>
>> -static int dmar_map_gfx = 1;
>>   static int intel_iommu_superpage = 1;
>>   static int iommu_identity_mapping;
>>   static int iommu_skip_te_disable;
>> +static int disable_igfx_dedicated_iommu;
>>
> what about 'no_igfx_iommu"? dedicated is implied for igfx
> so a shorter name might be slightly better.

I like disable_igfx_iommu more. :-)

Best regards,
baolu

