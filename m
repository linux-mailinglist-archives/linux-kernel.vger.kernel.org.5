Return-Path: <linux-kernel+bounces-56092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4F84C5D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508FB28A248
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5B200BD;
	Wed,  7 Feb 2024 07:55:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA1200A8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292501; cv=none; b=MkKljeQ8MLiCKqcjMJhm7yW8VbWihCfIjI9L02lCTMxL0idhmGi0GrD9bA50htm1B1jCh2vUWHVzyPy5fM9ecYGeJ8o15y6lh4o2dlFyIOFBQvL76Ue1ymgExM0BGjWFlwHGHwX3nHwlJlsfd/iCSqvVodOuLyuYW9C67HjQiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292501; c=relaxed/simple;
	bh=UVKMCTgNsvOUu0emV/e54Yr6GVPsmnUHrJmU0/IlzJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eTEo593ny0HkNqlX8pkiMvyTninRAhwqExlrnZ4PecY6bSyliH0Q6DQguyvhTCyamkjKual8B4PQIz/5W29MNajmITHyf53OU0XAqAxP9Q4cuahrk7Oe2x8M1lt6hXxKeeu1XcVsPjyHbgCdCIoDZKInw4+Y1+W3nD2Ur0cl+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADF1B1FB;
	Tue,  6 Feb 2024 23:55:39 -0800 (PST)
Received: from [10.162.40.23] (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA8F3F5A1;
	Tue,  6 Feb 2024 23:54:52 -0800 (PST)
Message-ID: <df731836-04ab-41b9-b317-434a1060ad61@arm.com>
Date: Wed, 7 Feb 2024 13:24:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: arm64: Override Microsoft Azure Cobalt 100 MIDR
 value with ARM Neoverse N2
Content-Language: en-US
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)"
 <kvmarm@lists.linux.dev>
References: <20240206195819.1146693-1-eahariha@linux.microsoft.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240206195819.1146693-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/7/24 01:28, Easwar Hariharan wrote:
> Several workload optimizations and errata depend on validating that the
> optimization or errata are applicable to the particular CPU by checking
> the MIDR_EL1 system register value. With the Microsoft implementer ID

Which is how it should be done.

> for Azure Cobalt 100, the value doesn't match and ~20-25% performance
> regression is seen in these workloads. Override the Azure Cobalt 100
> value and replace it with the default ARM Neoverse N2 value that Azure
> Cobalt 100 is based on.

Why cannot these MIDR values be classified as required and subscribed to
the existing erratas that is affecting such implementations. Hence these
work arounds will be triggered as and when applicable. Why then override
MIDR value instead ?

> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/cputype.h   | 3 ++-
>  arch/arm64/include/asm/el2_setup.h | 5 +++++
>  arch/arm64/kvm/sys_regs.c          | 9 ++++++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 7c7493cb571f..0450c6c32377 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -262,7 +262,8 @@ is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
>   */
>  static inline u32 __attribute_const__ read_cpuid_id(void)
>  {
> -	return read_cpuid(MIDR_EL1);
> +	return (read_cpuid(MIDR_EL1) == 0x6D0FD490 ? 0x410FD490 :
> +			read_cpuid(MIDR_EL1));
>  }
>  
>  static inline u64 __attribute_const__ read_cpuid_mpidr(void)
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842..502a14e54a31 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -138,6 +138,11 @@
>  .macro __init_el2_nvhe_idregs
>  	mrs	x0, midr_el1
>  	mrs	x1, mpidr_el1
> +	ldr	x2, =0x6D0FD490
> +	cmp	x0, x2
> +	bne	.Loverride_cobalt100_\@
> +	ldr	x0, =0x410FD490
> +.Loverride_cobalt100_\@:
>  	msr	vpidr_el2, x0
>  	msr	vmpidr_el2, x1
>  .endm
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 30253bd19917..8ea9c7fdabdb 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3574,7 +3574,14 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
>  		return ((struct sys_reg_desc *)r)->val;			\
>  	}
>  
> -FUNCTION_INVARIANT(midr_el1)
> +static u64 get_midr_el1(struct kvm_vcpu *v, const struct sys_reg_desc *r)
> +{
> +	((struct sys_reg_desc *)r)->val = read_sysreg(midr_el1);
> +	if (((struct sys_reg_desc *)r)->val == 0x6D0FD490)
> +		((struct sys_reg_desc *)r)->val == 0x410FD490;
> +	return ((struct sys_reg_desc *)r)->val;
> +}
> +
>  FUNCTION_INVARIANT(revidr_el1)
>  FUNCTION_INVARIANT(aidr_el1)
>  

