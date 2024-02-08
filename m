Return-Path: <linux-kernel+bounces-58606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F184E8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C120B2DE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A8374EA;
	Thu,  8 Feb 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mVhRmfC8"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96D37167
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419779; cv=none; b=Eu4U0+XdJAJuF+DS2gyRfQ5a3nK/OahKKgmBEL4LM7QpfG8qJQ4QkrgqZqmU2jkzemuTvtxqohfkNZRicfXs2tFYcxehCYEBqwsAsObmt+97KzZH4BK52bHmh8+Tr66SjFAHbYVaWCLpOsmFndapDZkZM/OAMYbHXw6RhGbwI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419779; c=relaxed/simple;
	bh=b6c2t9B/pfloTiLl3QpaQz8LmLqZFIjOHYHcQTLOATY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODmthx2uahpy8beSCzveYpOBlpTWTi00whZMHOrFqFuqpUjhye5LNfG8rRkZulh+yOOCYt4kGr7L74v2NdM81vOmM+SIvxDpFjXD01cC6sYznWdrsZI7PSHuIz/QI6V5MYAbgW3GXoXawWaJi01ZC421TUFAG8Go7yR0sUB/1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mVhRmfC8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.216.206] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 03A0D207E718;
	Thu,  8 Feb 2024 11:16:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03A0D207E718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707419771;
	bh=u7Sr1GivyYQRssWu9Sxm5FwiQjNYTxwfTxEdxVnZrog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mVhRmfC8kQaVixsTdXy+xkNZpGrlA/MqXeC1o5PHI3bMWayHqbVhTVa+eNbHRSGKG
	 LnHztq2MuuhiV41949Vmm2cz5jd2l7OiC2Zygyt545g873v1mN3H59AWkn3C47z4lY
	 jeic5HaEFHEdLqFsoDO/GZe3uOKEnkkok1uiYnkY=
Message-ID: <ed6c25dc-d5c7-4f15-8fdc-f2adf209e638@linux.microsoft.com>
Date: Thu, 8 Feb 2024 11:16:10 -0800
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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
 <ZcNSI089xqia6lho@FVFF77S0Q05N.cambridge.arm.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <ZcNSI089xqia6lho@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/2024 1:49 AM, Mark Rutland wrote:
> On Tue, Feb 06, 2024 at 07:58:16PM +0000, Easwar Hariharan wrote:
>> Several workload optimizations and errata depend on validating that the
>> optimization or errata are applicable to the particular CPU by checking
>> the MIDR_EL1 system register value. With the Microsoft implementer ID
>> for Azure Cobalt 100, the value doesn't match and ~20-25% performance
>> regression is seen in these workloads. Override the Azure Cobalt 100
>> value and replace it with the default ARM Neoverse N2 value that Azure
>> Cobalt 100 is based on.
> 
> NAK to rewriting the MIDR in the kernel; we do not lie to userspace about the
> MIDR, and this is not a can of worms we're going to open.
> 
> If you desire some microarchitectural performance optimizations in particular
> projects, please submit patches to those projects to understand your MIDR
> value.

Understood.

> 
> Further, if Azure Cobalt 100 is based on ARM Neoverse N2, you presumably suffer
> from the same errata; can you comment on that at all? e.g. are there any
> changes in this part that *might* lead to differences in errata and/or
> workarounds? How do the MIDR_EL1.{Variant,Revision} values compare to that of
> Neoverse N2?
>

Yes, Azure Cobalt 100 suffers from the same errata as Neoverse N2. We had changes
in the implementation, but according to our hardware folks, the Neoverse N2 errata
we are affected by so far aren't affected by the changes made for Azure Cobalt 100.

> Mark.
> 
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  arch/arm64/include/asm/cputype.h   | 3 ++-
>>  arch/arm64/include/asm/el2_setup.h | 5 +++++
>>  arch/arm64/kvm/sys_regs.c          | 9 ++++++++-
>>  3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
>> index 7c7493cb571f..0450c6c32377 100644
>> --- a/arch/arm64/include/asm/cputype.h
>> +++ b/arch/arm64/include/asm/cputype.h
>> @@ -262,7 +262,8 @@ is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
>>   */
>>  static inline u32 __attribute_const__ read_cpuid_id(void)
>>  {
>> -	return read_cpuid(MIDR_EL1);
>> +	return (read_cpuid(MIDR_EL1) == 0x6D0FD490 ? 0x410FD490 :
>> +			read_cpuid(MIDR_EL1));
>>  }
>>  
>>  static inline u64 __attribute_const__ read_cpuid_mpidr(void)
>> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
>> index b7afaa026842..502a14e54a31 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -138,6 +138,11 @@
>>  .macro __init_el2_nvhe_idregs
>>  	mrs	x0, midr_el1
>>  	mrs	x1, mpidr_el1
>> +	ldr	x2, =0x6D0FD490
>> +	cmp	x0, x2
>> +	bne	.Loverride_cobalt100_\@
>> +	ldr	x0, =0x410FD490
>> +.Loverride_cobalt100_\@:
>>  	msr	vpidr_el2, x0
>>  	msr	vmpidr_el2, x1
>>  .endm
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 30253bd19917..8ea9c7fdabdb 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -3574,7 +3574,14 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
>>  		return ((struct sys_reg_desc *)r)->val;			\
>>  	}
>>  
>> -FUNCTION_INVARIANT(midr_el1)
>> +static u64 get_midr_el1(struct kvm_vcpu *v, const struct sys_reg_desc *r)
>> +{
>> +	((struct sys_reg_desc *)r)->val = read_sysreg(midr_el1);
>> +	if (((struct sys_reg_desc *)r)->val == 0x6D0FD490)
>> +		((struct sys_reg_desc *)r)->val == 0x410FD490;
>> +	return ((struct sys_reg_desc *)r)->val;
>> +}
>> +
>>  FUNCTION_INVARIANT(revidr_el1)
>>  FUNCTION_INVARIANT(aidr_el1)
>>  
>> -- 
>> 2.34.1
>>
>>


