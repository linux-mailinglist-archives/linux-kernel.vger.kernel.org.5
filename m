Return-Path: <linux-kernel+bounces-152732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC38AC392
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A4F1C20C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CD179AA;
	Mon, 22 Apr 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRBFJ4j8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07881758B;
	Mon, 22 Apr 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713762802; cv=none; b=o4uj4XM4J/J9hkgYIHktwAW+NO10glJbquZNEeglmrqVEuWBPIvDs7caF+734Zt+g7Jhx9SnHOUMUVNMI3dKqfb9FWd52klYA8nPdFAU87m7c75R0tfcyoC2UVQRCFm/dK/Qg52QI49YoQl0gPVR4aDO5odE64/qpJJXifF6q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713762802; c=relaxed/simple;
	bh=DKjA0dK037dChvDf0JvnAQW0/y9B6MEd698fmMfs8IE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rA0NC0mmcq3WUd+p0udS1hhatHevj2baus0jSzO2Ls7kvzVgp8Hfaa66CzgNm99x0Kdpk8bnn0s9U914SqI0TBIJ6Vz4VbBjNvMhnr80MIHdDa9FS6JZhLfXc+n/oFZRbl4ITbS+YByKlcn29XRkJqxmBJFF5GVbtIrpks2+Nck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRBFJ4j8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713762800; x=1745298800;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DKjA0dK037dChvDf0JvnAQW0/y9B6MEd698fmMfs8IE=;
  b=KRBFJ4j8h9E7Dmcm4/NEsG4zJOy64JzJD+S6HGmKYTzLJQQ/eYYTzaLv
   hk/M1hM4KRioxQOmA7k0xpv1rlkKfT/88Heq2I00Han2l2EzQUwUV81jJ
   P4gHANs+vnRoJoPKpGrnEkxyyMRJcYxwLAhevlx3icqmodsKxz/MRR0fg
   C+iAT26jx6frZIOzBKy7ah51S9QL/r2rLP4h9JP1e1PQQlP88Owwmsbi8
   qlRyR+hlQhgPr3aiBeVzHN6ib9aQyk58sQiDt1MWTQN7sN+Hr7CoSi+98
   GIA9kQsleiex1jVP4B1f8xvF5AN0I+N/LUWFR2YAlxGpWY42HGQwUFYYS
   g==;
X-CSE-ConnectionGUID: RV4nBu4QQuuDWp3dn7ciUg==
X-CSE-MsgGUID: 4BlSyxiRQ1KY5kS7Kza98A==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9148166"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="9148166"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 22:13:19 -0700
X-CSE-ConnectionGUID: gCCWIIMWTq+J3iew0YRR0A==
X-CSE-MsgGUID: CVejsV1ORxqcz60ioG20Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="61338676"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 21 Apr 2024 22:13:13 -0700
Message-ID: <964db2aa-6535-4243-9b3f-e72bff9b6297@linux.intel.com>
Date: Mon, 22 Apr 2024 13:11:52 +0800
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
Subject: Re: [PATCH v2 5/7] iommu/riscv: Device directory management.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <232b2824d5dfd9b8dcb3553bfd506444273c3305.1713456598.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <232b2824d5dfd9b8dcb3553bfd506444273c3305.1713456598.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/24 12:32 AM, Tomasz Jeznach wrote:
> Introduce device context allocation and device directory tree
> management including capabilities discovery sequence, as described
> in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.
> 
> Device directory mode will be auto detected using DDTP WARL property,
> using highest mode supported by the driver and hardware. If none
> supported can be configured, driver will fall back to global pass-through.
> 
> First level DDTP page can be located in I/O (detected using DDTP WARL)
> and system memory.
> 
> Only identity protection domain is supported by this implementation.
> 
> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/riscv/iommu.c | 369 +++++++++++++++++++++++++++++++++++-
>   drivers/iommu/riscv/iommu.h |   5 +
>   2 files changed, 365 insertions(+), 9 deletions(-)

[ ... ]

> +
> +/*
> + * Discover supported DDT modes starting from requested value,
> + * configure DDTP register with accepted mode and root DDT address.
> + * Accepted iommu->ddt_mode is updated on success.
> + */
> +static int riscv_iommu_set_ddtp_mode(struct riscv_iommu_device *iommu,
> +				     unsigned int ddtp_mode)
> +{
> +	struct device *dev = iommu->dev;
> +	u64 ddtp, rq_ddtp;
> +	unsigned int mode, rq_mode = ddtp_mode;
> +	int rc;
> +
> +	rc = readq_relaxed_poll_timeout(iommu->reg + RISCV_IOMMU_REG_DDTP,
> +					ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
> +					10, RISCV_IOMMU_DDTP_TIMEOUT);
> +	if (rc < 0)
> +		return -EBUSY;
> +
> +	/* Disallow state transition from xLVL to xLVL. */
> +	switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
> +	case RISCV_IOMMU_DDTP_MODE_BARE:
> +	case RISCV_IOMMU_DDTP_MODE_OFF:
> +		break;
> +	default:
> +		if (rq_mode != RISCV_IOMMU_DDTP_MODE_BARE &&
> +		    rq_mode != RISCV_IOMMU_DDTP_MODE_OFF)
> +			return -EINVAL;

Is this check duplicate? It appears that it's always true in the default
branch.

> +		break;
> +	}
> +
> +	do {
> +		rq_ddtp = FIELD_PREP(RISCV_IOMMU_DDTP_MODE, rq_mode);
> +		if (rq_mode > RISCV_IOMMU_DDTP_MODE_BARE)
> +			rq_ddtp |= phys_to_ppn(iommu->ddt_phys);
> +
> +		riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, rq_ddtp);
> +
> +		rc = readq_relaxed_poll_timeout(iommu->reg + RISCV_IOMMU_REG_DDTP,
> +						ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
> +						10, RISCV_IOMMU_DDTP_TIMEOUT);
> +		if (rc < 0) {
> +			dev_warn(dev, "timeout when setting ddtp (ddt mode: %u, read: %llx)\n",
> +				 rq_mode, ddtp);
> +			return -EBUSY;
> +		}
> +
> +		/* Verify IOMMU hardware accepts new DDTP config. */
> +		mode = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
> +
> +		if (rq_mode == mode)
> +			break;
> +
> +		/* Hardware mandatory DDTP mode has not been accepted. */
> +		if (rq_mode < RISCV_IOMMU_DDTP_MODE_1LVL && rq_ddtp != ddtp) {
> +			dev_warn(dev, "DDTP update failed hw: %llx vs %llx\n", ddtp, rq_ddtp);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Mode field is WARL, an IOMMU may support a subset of
> +		 * directory table levels in which case if we tried to set
> +		 * an unsupported number of levels we'll readback either
> +		 * a valid xLVL or off/bare. If we got off/bare, try again
> +		 * with a smaller xLVL.
> +		 */
> +		if (mode < RISCV_IOMMU_DDTP_MODE_1LVL &&
> +		    rq_mode > RISCV_IOMMU_DDTP_MODE_1LVL) {
> +			dev_dbg(dev, "DDTP hw mode %u vs %u\n", mode, rq_mode);
> +			rq_mode--;
> +			continue;
> +		}
> +
> +		/*
> +		 * We tried all supported modes and IOMMU hardware failed to
> +		 * accept new settings, something went very wrong since off/bare
> +		 * and at least one xLVL must be supported.
> +		 */
> +		dev_warn(dev, "DDTP hw mode %u, failed to set %u\n", mode, ddtp_mode);
> +		return -EINVAL;
> +	} while (1);
> +
> +	iommu->ddt_mode = mode;
> +	if (mode != ddtp_mode)
> +		dev_warn(dev, "DDTP failover to %u mode, requested %u\n",
> +			 mode, ddtp_mode);
> +
> +	return 0;
> +}
> +

[ ... ]

> +
> +static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
> +				     struct device *dev,
> +				     struct iommu_domain *iommu_domain)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct riscv_iommu_dc *dc;
> +	u64 fsc, ta, tc;
> +	int i;
> +
> +	if (!iommu_domain) {
> +		ta = 0;
> +		tc = 0;
> +		fsc = 0;
> +	} else if (iommu_domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		ta = 0;
> +		tc = RISCV_IOMMU_DC_TC_V;
> +		fsc = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FSC_MODE_BARE);
> +	} else {
> +		/* This should never happen. */
> +		return -ENODEV;
> +	}

Move the domain->type check code to the domain-specific ops.

> +
> +	/* Update existing or allocate new entries in device directory */
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i], !iommu_domain);
> +		if (!dc && !iommu_domain)
> +			continue;
> +		if (!dc)
> +			return -ENODEV;
> +
> +		/* Swap device context, update TC valid bit as the last operation */
> +		xchg64(&dc->fsc, fsc);
> +		xchg64(&dc->ta, ta);
> +		xchg64(&dc->tc, tc);
> +
> +		/* Device context invalidation will be required. Ignoring for now. */
> +	}
> +
>   	return 0;
>   }
>   
> +static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
> +					      struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
> +	/* Global pass-through already enabled, do nothing. */
> +	if (iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_BARE)
> +		return 0;
> +
> +	return riscv_iommu_attach_domain(iommu, dev, iommu_domain);
> +}
> +
>   static struct iommu_domain riscv_iommu_identity_domain = {
>   	.type = IOMMU_DOMAIN_IDENTITY,
>   	.ops = &(const struct iommu_domain_ops) {
> @@ -82,6 +420,13 @@ static void riscv_iommu_probe_finalize(struct device *dev)
>   	iommu_setup_dma_ops(dev, 0, U64_MAX);
>   }
>   
> +static void riscv_iommu_release_device(struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
> +	riscv_iommu_attach_domain(iommu, dev, NULL);

Attaching a NULL domain to a device has already been removed. You can
use the iommu_ops->release_domain here.

> +}
> +
>   static const struct iommu_ops riscv_iommu_ops = {
>   	.owner = THIS_MODULE,
>   	.of_xlate = riscv_iommu_of_xlate,
> @@ -90,6 +435,7 @@ static const struct iommu_ops riscv_iommu_ops = {
>   	.device_group = riscv_iommu_device_group,
>   	.probe_device = riscv_iommu_probe_device,
>   	.probe_finalize = riscv_iommu_probe_finalize,

The probe_finalize op will be removed soon.

https://lore.kernel.org/linux-iommu/bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com/

> +	.release_device = riscv_iommu_release_device,
>   };
>   
>   static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> @@ -124,6 +470,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   {
>   	iommu_device_unregister(&iommu->iommu);
>   	iommu_device_sysfs_remove(&iommu->iommu);
> +	riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
>   }
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -133,12 +480,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	rc = riscv_iommu_init_check(iommu);
>   	if (rc)
>   		return dev_err_probe(iommu->dev, rc, "unexpected device state\n");
> -	/*
> -	 * Placeholder for a complete IOMMU device initialization.
> -	 * For now, only bare minimum: enable global identity mapping mode and register sysfs.
> -	 */
> -	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
> -			   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_DDTP_MODE_BARE));
> +
> +	rc = riscv_iommu_ddt_alloc(iommu);
> +	if (WARN(rc, "cannot allocate device directory\n"))
> +		goto err_init;
> +
> +	rc = riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
> +	if (WARN(rc, "cannot enable iommu device\n"))
> +		goto err_init;
>   
>   	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
>   				    dev_name(iommu->dev));
> @@ -154,5 +503,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   err_iommu:
>   	iommu_device_sysfs_remove(&iommu->iommu);
>   err_sysfs:
> +	riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +err_init:
>   	return rc;
>   }
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 700e33dc2446..f1696926582c 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -34,6 +34,11 @@ struct riscv_iommu_device {
>   	/* available interrupt numbers, MSI or WSI */
>   	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
>   	unsigned int irqs_count;
> +
> +	/* device directory */
> +	unsigned int ddt_mode;
> +	dma_addr_t ddt_phys;
> +	u64 *ddt_root;
>   };
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu);

Best regards,
baolu

