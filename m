Return-Path: <linux-kernel+bounces-152734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1198AC399
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82501F216BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1017C74;
	Mon, 22 Apr 2024 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5oXBsAR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB717548;
	Mon, 22 Apr 2024 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763358; cv=none; b=qm6HqEiU/idLfiTLl2WDdj/c0Xf0ohDUZJy6M8vx/xcleDMRRG6caKcJZvrs9h7jiwtpRhffQvNHh+c+pFbGB0FOEIfDsvGBLOYedEONmJGidj0yAo0RRv3UVwKg9E5KyFLdBkEVYOZ5PFMhjK+0EriQiJvxESV/5C1Hu9fgNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763358; c=relaxed/simple;
	bh=ZKqatucqlCT9kWZz8IX/UslCh9aEuPFTXZOmstfs/CU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQGcraHufh5PqR+Kdqv6HatDqNUqXDvRjf7IK1tYd9/PJQS6AuN6vCfbOf5S+/cqS7XJUdOTJNSQ9lisM+mCLNhCPok/LiMuuzjsbk6d47MaR2z1jYETEuvQ6ymC/lM/02V0BJw/cjP1nWfIpQ+JEAwY2cnN4nWPdT972qNTJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5oXBsAR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713763357; x=1745299357;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZKqatucqlCT9kWZz8IX/UslCh9aEuPFTXZOmstfs/CU=;
  b=H5oXBsAR9QjGCXpRC/qtURvS3IDrS/rGxYMgdylZkZziIGGuEjzHkmTh
   UW5f5IJXE+rxrpX4b++u1Opm/xLAkKE1bcBeyH75YOr7gl7MWX9jyTVow
   BCjk0xyCsqmvZ1+D18CqTxUijsZrNUnYZM7eLCY+vh127Wx2F5KRHfTIf
   vgSKthM3KebHdzy4PO8siUGdRkrwL5K7GiIQV3wx89m81Dh5Ww+n+HIT1
   /VD+TM3ET6xVvSUBa+DtBp5NuYhbIPKE2Ag/H8Rg5Rn39Ap8pCLDC4lD3
   GJwfGCgZjFUVE8+ubzg0M6QkGSw+f91AU2GJ8X75BEYygCXOnIuEcRWBD
   g==;
X-CSE-ConnectionGUID: yL6sR7+vTy2xT5qV2laMQw==
X-CSE-MsgGUID: //ZH+gZYRBK9PuTw4gJSmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="34683062"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="34683062"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 22:22:31 -0700
X-CSE-ConnectionGUID: 3AUe3Y+NQx2mxryv5T9TlQ==
X-CSE-MsgGUID: N7gOqtsFQ8W23/Oj5az/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="23952539"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 21 Apr 2024 22:22:26 -0700
Message-ID: <2f2750cd-a5bf-4486-8f50-c93d246f8b0c@linux.intel.com>
Date: Mon, 22 Apr 2024 13:21:05 +0800
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
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/19/24 12:32 AM, Tomasz Jeznach wrote:
> Introduce first-stage address translation support.
> 
> Page table configured by the IOMMU driver will use the same format
> as the CPU’s MMU, and will fallback to identity translation if the
> page table format configured for the MMU is not supported by the
> IOMMU hardware.
> 
> This change introduces IOTINVAL.VMA command, required to invalidate
> any cached IOATC entries after mapping is updated and/or removed from
> the paging domain. Invalidations for the non-leaf page entries will
> be added to the driver code in separate patch series, following spec
> update to clarify non-leaf cache invalidation command. With this patch,
> allowing only 4K mappings and keeping non-leaf page entries in memory
> this should be a reasonable simplification.
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/riscv/Kconfig |   1 +
>   drivers/iommu/riscv/iommu.c | 467 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 466 insertions(+), 2 deletions(-)
> 

[...]

> +
>   static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
>   				     struct device *dev,
>   				     struct iommu_domain *iommu_domain)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct riscv_iommu_domain *domain;
>   	struct riscv_iommu_dc *dc;
> +	struct riscv_iommu_bond *bond = NULL, *b;
> +	struct riscv_iommu_command cmd;
>   	u64 fsc, ta, tc;
>   	int i;
>   
> @@ -769,6 +838,20 @@ static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
>   		ta = 0;
>   		tc = RISCV_IOMMU_DC_TC_V;
>   		fsc = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FSC_MODE_BARE);
> +	} else if (iommu_domain->type & __IOMMU_DOMAIN_PAGING) {
> +		domain = iommu_domain_to_riscv(iommu_domain);
> +
> +		ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid);
> +		tc = RISCV_IOMMU_DC_TC_V;
> +		if (domain->amo_enabled)
> +			tc |= RISCV_IOMMU_DC_TC_SADE;
> +		fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
> +		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
> +
> +		bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +		if (!bond)
> +			return -ENOMEM;
> +		bond->dev = dev;
>   	} else {
>   		/* This should never happen. */
>   		return -ENODEV;
> @@ -787,12 +870,390 @@ static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
>   		xchg64(&dc->ta, ta);
>   		xchg64(&dc->tc, tc);
>   
> -		/* Device context invalidation will be required. Ignoring for now. */
> +		if (!(tc & RISCV_IOMMU_DC_TC_V))
> +			continue;
> +
> +		/* Invalidate device context cache */
> +		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> +		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +
> +		if (FIELD_GET(RISCV_IOMMU_PC_FSC_MODE, fsc) == RISCV_IOMMU_DC_FSC_MODE_BARE)
> +			continue;
> +
> +		/* Invalidate last valid PSCID */
> +		riscv_iommu_cmd_inval_vma(&cmd);
> +		riscv_iommu_cmd_inval_set_pscid(&cmd, FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, ta));
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +	}
> +
> +	/* Synchronize directory update */
> +	riscv_iommu_cmd_iofence(&cmd);
> +	riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> +
> +	/* Track domain to devices mapping. */
> +	if (bond)
> +		list_add_rcu(&bond->list, &domain->bonds);
> +
> +	/* Remove tracking from previous domain, if needed. */
> +	iommu_domain = iommu_get_domain_for_dev(dev);

Calling iommu_get_domain_for_dev() in the domain attaching path is very
fragile because it heavily depends on the order of calling the attach
callback and setting the domain pointer in the core.

Perhaps the driver can use dev_iommu_priv_set/get() to keep the active
domain in the per-device private data?

> +	if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING)) {
> +		domain = iommu_domain_to_riscv(iommu_domain);
> +		bond = NULL;
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(b, &domain->bonds, list) {
> +			if (b->dev == dev) {
> +				bond = b;
> +				break;
> +			}
> +		}
> +		rcu_read_unlock();
> +
> +		if (bond) {
> +			list_del_rcu(&bond->list);
> +			kfree_rcu(bond, rcu);
> +		}
> +	}
> +
> +	return 0;
> +}

Best regards,
baolu

