Return-Path: <linux-kernel+bounces-140436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B78A149F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CD31C21A75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980214C58E;
	Thu, 11 Apr 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpRBso6X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C413FD66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838558; cv=none; b=MJPsUTcOKpuMWkEeKeAY0oQJysGsbuNc/rhnP3JQY8ARBDyiI8XuT965i38P7GNYa9nMxGyCgd6w5sLxEk19tHCa43J7ZweQgAufsWTbpHp7CBr4FAd/y7irY43XLgaHv9cB4A+tVmXaedVOKQXoGR8Foyogo/EHxva4UX7blQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838558; c=relaxed/simple;
	bh=T0ns5dvXycLoFSs/ZW0S27KfnrJk+DvUNdebJc1uDsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYufBz8bm9pYe2OGVxG7zicObGpQ03ImtGvujfXfYIVle6EwMnTbrU9tZg2VAZYLVRUr9/zjomGAYneCFXPztnG73Xp766HE9C63NMMAVf1cw4dqmGg0gbRNAn/jK/h1AMptjvdCXKtlif1U1cMPrXGUMfGCAcpzeUKgbAQFE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpRBso6X; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712838557; x=1744374557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T0ns5dvXycLoFSs/ZW0S27KfnrJk+DvUNdebJc1uDsw=;
  b=MpRBso6XnJgZS+Rf3IakfCgG/PyI9pw4ZNL2mowHSWMXjpSEDVQnvjiy
   0m81R/sq3RSPUmc+RPPuwlrQfSKCwe8MhvIfHISDmho90pgIIV/6jgJpv
   UNJDgSh2sexEQlZmpHWQ3iuUOMEkK8o51Fxy0fwOqOqLKpL7aBCEwfebA
   uf6WjfMQNAx42LClGH9EvEkUWTYthAYYfCMN9qzlEpmJ7hk1rp99GY+aR
   0XCne4BFQXoJgVgPhQfaWN18NGDeFgR9ifHfb0qnp/vYUqS1PUIU3VKXx
   tAMAUQer7EORf7SMbxKxTXMmJeOPF9VlCqOxyzV1atoUgsqvt0i0/DYo7
   A==;
X-CSE-ConnectionGUID: 0LSPnLblQrKWBMRpMfBY0w==
X-CSE-MsgGUID: MnPwbCL8R66bAvfFSUyPtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19665149"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="19665149"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:29:17 -0700
X-CSE-ConnectionGUID: 63HJSZdjRS2Ac3+rV8u/TA==
X-CSE-MsgGUID: V8CFhsgbRxOeNFNtCoyL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20932733"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.237.254]) ([10.124.237.254])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:29:13 -0700
Message-ID: <1fa9f7f8-5bf7-4f4f-80f0-9f23e4653242@linux.intel.com>
Date: Thu, 11 Apr 2024 20:29:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240407011429.136282-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52760913F36DACBC612088668C002@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB52760913F36DACBC612088668C002@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2024 11:52 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 7, 2024 9:14 AM
>>
>> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
>> devices") adds all devices probed by the iommu driver in a rbtree
>> indexed by the source ID of each device. It assumes that each device
>> has a unique source ID. This assumption is incorrect and the VT-d
>> spec doesn't state this requirement either.
>>
>> The reason for using a rbtree to track devices is to look up the device
>> with PCI bus and devfunc in the paths of handling ATS invalidation time
>> out error and the PRI I/O page faults. Both are PCI ATS feature related.
>>
>> Only track the devices that have PCI ATS capabilities in the rbtree to
>> avoid unnecessary WARN_ON in the iommu probe path. Otherwise, on some
>> platforms below kernel splat will be displayed and the iommu probe results
>> in failure.
> Just be curious. What about two ATS capable devices putting behind
> a PCI-to-PCIe bridge?

No PCI-to-PCIe bridges such device AFAIK, ATS TLP couldn't be
routed via PCIe-to-PCI bridge unmodified. ATS is based on PCIe.

But the device-rbtree is possible holding mutiple device nodes behind
PCIe-to-PCI bridge indexed by the same requester-ID.

Thanks,
Ethan

>>   WARNING: CPU: 3 PID: 166 at drivers/iommu/intel/iommu.c:158
>> intel_iommu_probe_device+0x319/0xd90
>>   Call Trace:
>>    <TASK>
>>    ? __warn+0x7e/0x180
>>    ? intel_iommu_probe_device+0x319/0xd90
>>    ? report_bug+0x1f8/0x200
>>    ? handle_bug+0x3c/0x70
>>    ? exc_invalid_op+0x18/0x70
>>    ? asm_exc_invalid_op+0x1a/0x20
>>    ? intel_iommu_probe_device+0x319/0xd90
>>    ? debug_mutex_init+0x37/0x50
>>    __iommu_probe_device+0xf2/0x4f0
>>    iommu_probe_device+0x22/0x70
>>    iommu_bus_notifier+0x1e/0x40
>>    notifier_call_chain+0x46/0x150
>>    blocking_notifier_call_chain+0x42/0x60
>>    bus_notify+0x2f/0x50
>>    device_add+0x5ed/0x7e0
>>    platform_device_add+0xf5/0x240
>>    mfd_add_devices+0x3f9/0x500
>>    ? preempt_count_add+0x4c/0xa0
>>    ? up_write+0xa2/0x1b0
>>    ? __debugfs_create_file+0xe3/0x150
>>    intel_lpss_probe+0x49f/0x5b0
>>    ? pci_conf1_write+0xa3/0xf0
>>    intel_lpss_pci_probe+0xcf/0x110 [intel_lpss_pci]
>>    pci_device_probe+0x95/0x120
>>    really_probe+0xd9/0x370
>>    ? __pfx___driver_attach+0x10/0x10
>>    __driver_probe_device+0x73/0x150
>>    driver_probe_device+0x19/0xa0
>>    __driver_attach+0xb6/0x180
>>    ? __pfx___driver_attach+0x10/0x10
>>    bus_for_each_dev+0x77/0xd0
>>    bus_add_driver+0x114/0x210
>>    driver_register+0x5b/0x110
>>    ? __pfx_intel_lpss_pci_driver_init+0x10/0x10 [intel_lpss_pci]
>>    do_one_initcall+0x57/0x2b0
>>    ? kmalloc_trace+0x21e/0x280
>>    ? do_init_module+0x1e/0x210
>>    do_init_module+0x5f/0x210
>>    load_module+0x1d37/0x1fc0
>>    ? init_module_from_file+0x86/0xd0
>>    init_module_from_file+0x86/0xd0
>>    idempotent_init_module+0x17c/0x230
>>    __x64_sys_finit_module+0x56/0xb0
>>    do_syscall_64+0x6e/0x140
>>    entry_SYSCALL_64_after_hwframe+0x71/0x79
>>
>> Fixes: 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
>> devices")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 50eb9aed47cc..a7ecd90303dc 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4299,9 +4299,11 @@ static struct iommu_device
>> *intel_iommu_probe_device(struct device *dev)
>>   	}
>>
>>   	dev_iommu_priv_set(dev, info);
>> -	ret = device_rbtree_insert(iommu, info);
>> -	if (ret)
>> -		goto free;
>> +	if (pdev && pci_ats_supported(pdev)) {
>> +		ret = device_rbtree_insert(iommu, info);
>> +		if (ret)
>> +			goto free;
>> +	}
> probably replace device_rbtree with ats_rbtree?
>
>>   	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>   		ret = intel_pasid_alloc_table(dev);
>> @@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct
>> device *dev)
>>   	struct intel_iommu *iommu = info->iommu;
>>
>>   	mutex_lock(&iommu->iopf_lock);
>> -	device_rbtree_remove(info);
>> +	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
>> +		device_rbtree_remove(info);
>>   	mutex_unlock(&iommu->iopf_lock);
>>
>>   	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>> --
>> 2.34.1
>

