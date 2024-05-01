Return-Path: <linux-kernel+bounces-165140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DE38B8891
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2A8280F45
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940C53E12;
	Wed,  1 May 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUEORFNQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1B3A1A2;
	Wed,  1 May 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559190; cv=none; b=qeL5M7q0I91yoHDn2b1Ns09ADNATcgEHry4od9g5UDi5p9VHQ0fKEQY3uwqwn1xlzaK8t3JEC2tkIOso1IPDM0v7UvKUmmbXQrzoUHj91Q3BwO2kpyvw7OvqC45yO12ZKrm+g4YOe2qZdFsj37RzuJzPE2Fs5vBov3XcHqSLZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559190; c=relaxed/simple;
	bh=hRqr/qAUxYcdjP0X9isvAXR0Vq1bW+ytdwQxX41DL7c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oEsFA/G+cs/qCccV+gkf2aJ5UbfItmFaxrCNdWb2HGuFF84UVGJN1AM4lTPG0QjrhMAqLOoGmUUDkGiZXn2N+5kMi47t81qcULWc8Y1XoOeRErUdYO/pyatJq4JThLk9Au8BGpGoLkOPp6e9l3Y4xLfju9rF6smVfSlDwKCnT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUEORFNQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714559189; x=1746095189;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hRqr/qAUxYcdjP0X9isvAXR0Vq1bW+ytdwQxX41DL7c=;
  b=IUEORFNQsfUXf917b8hJuEDfzxmf9PqHSOExydX8pwq4a7UyU+pLie9B
   hrgYLZ3Ttk/YsZVnDjxBD4fE3TDDBdtN+y4V/DF0km6hic2B+r1zbI8Hj
   rCUyZN5itadlhu0YGQWAuIxCbQ6sb/RyAq30Ye/CILEcNluP02BNJBf+5
   qQ4a6H3tBn7lxV/P2bdCCVjM0DHljJG5F1ttBtn8Eeku6N12bqVrz2uN0
   w+69AtmQ9G76DP0xRlbtKPHGYsfeiSBW8Cf6/Etbkqs/u8w4r0390mK2b
   t6s6dc3DE1zMGmi37rTm18PIdNx08PcctUrdswjwczBQMGdRuwQ9Du8wl
   Q==;
X-CSE-ConnectionGUID: TPCpjxQDQF6FaDP0ZOEXYg==
X-CSE-MsgGUID: mgNFhteBQkqxqKJNMYh/EQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="35674164"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="35674164"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 03:26:28 -0700
X-CSE-ConnectionGUID: mM4xqKTwTRanVLvaULU3dg==
X-CSE-MsgGUID: 2a2bdGMyS6Sr14FLZPSgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="64237676"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.225.176]) ([10.124.225.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 03:26:23 -0700
Message-ID: <6b4a4dc0-ac9e-43cd-bd84-447df2370dde@linux.intel.com>
Date: Wed, 1 May 2024 18:26:20 +0800
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
Subject: Re: [PATCH v3 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <aa5592da66fe72acd4d4730f544882042e7b5293.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aa5592da66fe72acd4d4730f544882042e7b5293.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/1 4:01, Tomasz Jeznach wrote:
> +static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> +{
> +	u64 ddtp;
> +
> +	/*
> +	 * Make sure the IOMMU is switched off or in pass-through mode during regular
> +	 * boot flow and disable translation when we boot into a kexec kernel and the
> +	 * previous kernel left them enabled.
> +	 */
> +	ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> +	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> +		return -EBUSY;
> +
> +	if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IOMMU_DDTP_MODE_BARE) {
> +		if (!is_kdump_kernel())

Is kdump supported for RISC-V architectures?  If so, the documentation
in Documentation/admin-guide/kdump/kdump.rst might need an update.

There is a possibility of ongoing DMAs during the boot process of the
kdump capture kernel because there's a small chance of legacy DMA setups
targeting any memory location. Kdump typically allows these ongoing DMA
transfers to complete, assuming they were intended for valid memory
regions.

The IOMMU subsystem implements a default domain deferred attachment
mechanism for this. In the kdump capture kernel, the whole device
context tables are copied from the original kernel and will be
overridden once the device driver calls the kernel DMA interface for the
first time. This assumes that all old DMA transfers are completed after
the driver's takeover.

Will you consider this for RISC-V architecture as well?

> +			return -EBUSY;
> +		riscv_iommu_disable(iommu);
> +	}
> +
> +	/* Configure accesses to in-memory data structures for CPU-native byte order. */
> +	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) != !!(iommu->fctl & RISCV_IOMMU_FCTL_BE)) {
> +		if (!(iommu->caps & RISCV_IOMMU_CAP_END))
> +			return -EINVAL;
> +		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL,
> +				   iommu->fctl ^ RISCV_IOMMU_FCTL_BE);
> +		iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) != !!(iommu->fctl & RISCV_IOMMU_FCTL_BE))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Best regards,
baolu

