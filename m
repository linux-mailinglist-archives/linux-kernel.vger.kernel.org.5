Return-Path: <linux-kernel+bounces-60373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD1850427
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40A31F2240B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC03D0C5;
	Sat, 10 Feb 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsEQCbYx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688243A1CD;
	Sat, 10 Feb 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564479; cv=none; b=IC+k2Q83F6i67adBX1Zj/Lzz83LKZ2FXHIZlOPnb15UoiKH8CG7Cn1AqankaQZDKlPpJeaydmDo/u2EoFNODHJu9r9TIneX6PrABN2DaC0UpUVetFszpvA+jLSbevFbfR68YF7tVYoW31//x1KO12qyW8YsR/lh6wVZQpQAxIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564479; c=relaxed/simple;
	bh=4OyKZnmqJQZAOOTD2TG4WTVzLLJt8ZHseBX/iLb32yo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZX27Hqivv8S8qIWEr5+oEf2XNZZc3TbiWtyw+X8mE9iuIPAbUAFehIqHIwcbtrU2XeeuAZnHOgSI5D/7xLepjtLClM33nxcFdpP7RkpInUJ2v8PfhlEmQzgmYOrVJ4Q4XeOc6VZyMDnPf8NMRToNvMulwIH+/dQuEQ1JRjkcHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsEQCbYx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707564477; x=1739100477;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4OyKZnmqJQZAOOTD2TG4WTVzLLJt8ZHseBX/iLb32yo=;
  b=SsEQCbYx8LOOHOst4N5PRqVZ8yG0HM30QNABpNWdtKb5D3TlOUXyJcAi
   kSCnLi95cVE5u/78Wl+sl5QrtbGD7ZiyEqHxzP7Mk2ov8IvQDqM/AKOHW
   S1rqX8oIj0pmxMrZAOomt3ELxXc7uUhMiLUgQ5euO6bMWBsq+YBN7DNYg
   YBQjObw2J+mdiJEevlF1CBAdy1ZuidM4znJgtTGjZaoq45qWqUzesSy9n
   D7l9oLKnBKlbNpWEAQayyEiOnG8vpKp8Omsp8+Ayj0XN2qGj5IDlZmHK8
   VXjovVI/A/RnqxPkHkZAmGvWdXvpXooQxZs31Rki+WxXcQKk1kCjHNemv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19063354"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="19063354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 03:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6907193"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.152]) ([10.254.214.152])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 03:27:48 -0800
Message-ID: <2a86f3d0-4aa7-4c32-afb9-e5a908a65d10@linux.intel.com>
Date: Sat, 10 Feb 2024 19:27:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Robin Murphy <robin.murphy@arm.com>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/10 0:50, Robin Murphy wrote:
> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> which means there should be no harm in achieving the same order of
> operations by running it off the back of iommu_probe_device() itself.
> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> letting us pull it all into the main flow properly. As a bonus this lets
> us fold in and de-scope the PCI workaround setup as well.
> 
> At this point we can also then pull the call up inside the group mutex,
> and avoid having to think about whether iommu_group_store_type() could
> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> *before*  iommu_device_use_default_domain() claims it... Furthermore we
> replace one .probe_finalize call completely, since the only remaining
> implementations are now one which only needs to run once for the initial
> boot-time probe, and two which themselves render that path unreachable.
> 
> This leaves us a big step closer to realistically being able to unpick
> the variety of different things that iommu_setup_dma_ops() has been
> muddling together, and further streamline iommu-dma into core API flows
> in future.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---
> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
>      is covered as well, with bonus side-effects as above.
> v3:*Really*  do that, remembering the other two probe_finalize sites too.
> ---
>   arch/arm64/mm/dma-mapping.c  |  2 --
>   drivers/iommu/amd/iommu.c    |  8 --------
>   drivers/iommu/dma-iommu.c    | 18 ++++++------------
>   drivers/iommu/dma-iommu.h    | 14 ++++++--------
>   drivers/iommu/intel/iommu.c  |  7 -------
>   drivers/iommu/iommu.c        | 20 +++++++-------------
>   drivers/iommu/s390-iommu.c   |  6 ------
>   drivers/iommu/virtio-iommu.c | 10 ----------
>   include/linux/iommu.h        |  7 -------
>   9 files changed, 19 insertions(+), 73 deletions(-)

For changes in Intel IOMMU driver,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

