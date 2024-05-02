Return-Path: <linux-kernel+bounces-165907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EFD8B9339
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334421F224A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08E171AD;
	Thu,  2 May 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6vwFJH7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995ED299;
	Thu,  2 May 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615162; cv=none; b=XRWBMV3JIgMUZeWN5i7HmtDuiHxzSx16QNYjszRZLyjdp4yITD+5X0y1IMhoasjWgdMT757Q41pwWyTEjpTN79iIXHQRTT6+VGhNY0TVeRmApTo8GKPn8K0GzLbcocR2jgNq+/RS2OoICRwkH8qun8R+6/IWKhG5rtx7+eiLdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615162; c=relaxed/simple;
	bh=zKP4feh47Akq95l05ylgljUzunXEWN+72fMuFIKrAxs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JJwFfyH5XiYzGbeHAm83J+c5c24lymVKmCMJ3txBfFcmb/O2jkosZgkRkUesXSakxMVloiMD49QEVcd+F16O+W2ng6GnuvdKzQgXqm+EuijCGSsLr29rODtd6JMk8Js/BerEgnSPTuYMHGK4T4lDGj0xqHWkdb8DvF5rW2boFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6vwFJH7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714615161; x=1746151161;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zKP4feh47Akq95l05ylgljUzunXEWN+72fMuFIKrAxs=;
  b=K6vwFJH7V8TdKS+6SQQlDkwHBmlVlGdMwRwycy0RJl1dYRBZVK78jnJT
   Z9/jLvyzRuJ27F8/OEjih9AgaWym0hx7ROUHR2atvZC8mWWnuQTMJy2Dw
   E2cSUav4apcpOfRfgBiYpTqbpnb+ekpIysj2mVl5ewKmGc7BwVXQL+9OK
   pEVCF/Bka48wodTIzD2CpfdbM5aihASfTEaVQoUR0dpNSj9GjaFppn891
   VEN6sdknWCLpOJrJ+zRHcOnRfTNf1sCIslctclEGjZudWlCD/16IjpYG3
   5CJA1Rz9MeFZ3Gs6EXACmSqcx9mMIaE6WbPiM6iP6qepoBluxQIDBdkik
   A==;
X-CSE-ConnectionGUID: +aznVMTiRoOz0Q2i3GNS0g==
X-CSE-MsgGUID: BWr2Hv5XTTeryibfOARyYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10536756"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10536756"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 18:59:20 -0700
X-CSE-ConnectionGUID: 5TEYAUJHQm6qKX56L2o3ug==
X-CSE-MsgGUID: BnZJQJRhTU2OMxt832m4uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31782767"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 May 2024 18:59:15 -0700
Message-ID: <ed0e7138-c5db-40fb-ac12-36df007d0b4f@linux.intel.com>
Date: Thu, 2 May 2024 09:57:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v3 5/7] iommu/riscv: Device directory management.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
 <104358de-ea86-4e25-8942-ba285d6f317b@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <104358de-ea86-4e25-8942-ba285d6f317b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/24 9:38 AM, Baolu Lu wrote:
> On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
>> @@ -128,6 +489,7 @@ void riscv_iommu_remove(struct riscv_iommu_device 
>> *iommu)
>>   {
>>       iommu_device_unregister(&iommu->iommu);
>>       iommu_device_sysfs_remove(&iommu->iommu);
>> +    riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
>>   }
>>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
>> @@ -138,12 +500,13 @@ int riscv_iommu_init(struct riscv_iommu_device 
>> *iommu)
>>       if (rc)
>>           return dev_err_probe(iommu->dev, rc, "unexpected device 
>> state\n");
>> -    /*
>> -     * Placeholder for a complete IOMMU device initialization.
>> -     * For now, only bare minimum: enable global identity mapping 
>> mode and register sysfs.
>> -     */
>> -    riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
>> -               FIELD_PREP(RISCV_IOMMU_DDTP_MODE, 
>> RISCV_IOMMU_DDTP_MODE_BARE));
>> +    rc = riscv_iommu_iodir_alloc(iommu);
>> +    if (rc)
>> +        goto err_init;
>> +
>> +    rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
>> +    if (rc)
>> +        goto err_init;
>>       rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, 
>> "riscv-iommu@%s",
>>                       dev_name(iommu->dev));
> 
> The device directory root page might be allocated in
> riscv_iommu_iodir_alloc(),
> 
> +    if (!iommu->ddt_root) {
> +        iommu->ddt_root = riscv_iommu_get_pages(iommu, 0);
> +        iommu->ddt_phys = __pa(iommu->ddt_root);
> +    }
> 
> But I didn't find any place to free it in the error paths. Did I
> overlook anything?

I found the answer by myself. devres_alloc() is used so the page memory
resources are managed by the driver core automatically. Please ignore
the above comment.

Not sure about the pages for paging domain. If all pages release is
deferred, it may cause big memory consumption. We have a trade-off here.
On one hand, this might speed up the domain mapping since all pages
might be preallocated; on the other hand, it will cost more memory.

Best regards,
baolu

