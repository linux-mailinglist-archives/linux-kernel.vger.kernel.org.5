Return-Path: <linux-kernel+bounces-139666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114938A0624
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044221C22CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52C13B2AC;
	Thu, 11 Apr 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwVTHqVb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCA13B28D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803748; cv=none; b=VT6+2PCHHax+1TEG+ySHmy4+Bt/a5Eo2Q4yEEnjC+spzou9Wpx8FSpJX56kgIwhA1j6f/BHmQnZl2nGPKs1+eORhEnoWdmjz34OcFbdn6PugpKGHkKQlDhQy7AIgEyH4jmGzN9k0iKqBXq6Tpg8zurB8rJ0qZlXdUt80IfI1L/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803748; c=relaxed/simple;
	bh=QBganqf5PeBpPnU1OPM1lHFkiHOrahA+IAtZc2FToU0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sHBINu4wPTTNQ6WWlOk5K/TSbcoBONcdbjKcOvkv8+K/3L0QRdnoZnhcSHugBqFwrHZRWbyWQQf2zg8geAOqg+Udcs4Rx6DHVHpirYa/RSDZwvsOTvr3QD8C5X57z6HuaVc6tDZInxImGz8QCLssN00+qs2CZ0zWHUr813UkU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwVTHqVb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712803747; x=1744339747;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QBganqf5PeBpPnU1OPM1lHFkiHOrahA+IAtZc2FToU0=;
  b=NwVTHqVbMlZAuOm+ji3FQB6Vbc6PhZQzW50xauLquYjLm1XarUWxuAz6
   guj++FdnqXJq+WFF3nZYm68snBlM7dNeq38VVpY+qHUGZgv+HBVFvCfXj
   ynPJo5SlV0iWPu9RzbEoNCwR1CnXj+x+ukyNp2+Ermob3HNKEVAbT5aZE
   DrzO0OCLPSSDEwJk9FmB97pIaOtxw3trsDAgDVb11/mrkurUnrDEe6gXj
   dIeLmN7xNI6G96+FPA+b24K2OCqG4kEmMEU0a973r80ObZf05tmLWl87A
   be5w0cQC+9OXzdTvGaZHa5WRjczA5F/8/viEXiEjy1oahvP/PH0fLr0el
   A==;
X-CSE-ConnectionGUID: +8cX7q7CRt2dgmVLbDBXnQ==
X-CSE-MsgGUID: dF+vtun8RdivRkuQFD+07g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8060968"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8060968"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:49:06 -0700
X-CSE-ConnectionGUID: w+KWeaXvTxyJWeCBqNH7YQ==
X-CSE-MsgGUID: Se5Hclq0TYSDRJtf8hkLaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="21351158"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 19:49:04 -0700
Message-ID: <3674a075-d305-4cd7-be44-8d808f872249@linux.intel.com>
Date: Thu, 11 Apr 2024 10:47:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
To: iommu@lists.linux.dev
References: <20240407011429.136282-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240407011429.136282-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/24 9:14 AM, Lu Baolu wrote:
> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
> devices") adds all devices probed by the iommu driver in a rbtree
> indexed by the source ID of each device. It assumes that each device
> has a unique source ID. This assumption is incorrect and the VT-d
> spec doesn't state this requirement either.
> 
> The reason for using a rbtree to track devices is to look up the device
> with PCI bus and devfunc in the paths of handling ATS invalidation time
> out error and the PRI I/O page faults. Both are PCI ATS feature related.
> 
> Only track the devices that have PCI ATS capabilities in the rbtree to
> avoid unnecessary WARN_ON in the iommu probe path. Otherwise, on some
> platforms below kernel splat will be displayed and the iommu probe results
> in failure.
> 
>   WARNING: CPU: 3 PID: 166 at drivers/iommu/intel/iommu.c:158 intel_iommu_probe_device+0x319/0xd90
>   Call Trace:
>    <TASK>
>    ? __warn+0x7e/0x180
>    ? intel_iommu_probe_device+0x319/0xd90
>    ? report_bug+0x1f8/0x200
>    ? handle_bug+0x3c/0x70
>    ? exc_invalid_op+0x18/0x70
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? intel_iommu_probe_device+0x319/0xd90
>    ? debug_mutex_init+0x37/0x50
>    __iommu_probe_device+0xf2/0x4f0
>    iommu_probe_device+0x22/0x70
>    iommu_bus_notifier+0x1e/0x40
>    notifier_call_chain+0x46/0x150
>    blocking_notifier_call_chain+0x42/0x60
>    bus_notify+0x2f/0x50
>    device_add+0x5ed/0x7e0
>    platform_device_add+0xf5/0x240
>    mfd_add_devices+0x3f9/0x500
>    ? preempt_count_add+0x4c/0xa0
>    ? up_write+0xa2/0x1b0
>    ? __debugfs_create_file+0xe3/0x150
>    intel_lpss_probe+0x49f/0x5b0
>    ? pci_conf1_write+0xa3/0xf0
>    intel_lpss_pci_probe+0xcf/0x110 [intel_lpss_pci]
>    pci_device_probe+0x95/0x120
>    really_probe+0xd9/0x370
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x73/0x150
>    driver_probe_device+0x19/0xa0
>    __driver_attach+0xb6/0x180
>    ? __pfx___driver_attach+0x10/0x10
>    bus_for_each_dev+0x77/0xd0
>    bus_add_driver+0x114/0x210
>    driver_register+0x5b/0x110
>    ? __pfx_intel_lpss_pci_driver_init+0x10/0x10 [intel_lpss_pci]
>    do_one_initcall+0x57/0x2b0
>    ? kmalloc_trace+0x21e/0x280
>    ? do_init_module+0x1e/0x210
>    do_init_module+0x5f/0x210
>    load_module+0x1d37/0x1fc0
>    ? init_module_from_file+0x86/0xd0
>    init_module_from_file+0x86/0xd0
>    idempotent_init_module+0x17c/0x230
>    __x64_sys_finit_module+0x56/0xb0
>    do_syscall_64+0x6e/0x140
>    entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> Fixes: 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed devices")
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

This patch closes a boot bug described here.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10689

I will queue it for v6.9-rc if no objection.

Best regards,
baolu

