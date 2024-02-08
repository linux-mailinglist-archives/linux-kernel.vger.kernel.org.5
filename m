Return-Path: <linux-kernel+bounces-58605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26A84E8CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236FE2899A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225B374C4;
	Thu,  8 Feb 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nbawJt+I"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A67B37163
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419778; cv=none; b=LLXiHTymrq3CzJ8cWxywDXxNRdeeb/ewtwchirPcoTf/gqat4gBtIjz2UlYRB5dtTtDS+FiYohzpp0bpWCgSKYXg7SFXmYDQAt03Xdqqx68nsJ9317nbA1sidUxpYoL4H/itWB/Py+ffVKdeQYl4iMdnu3nqoevckrJv9XuuPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419778; c=relaxed/simple;
	bh=9UykkdzNYI0pXZaGCaLewlY8xeQZouarcxjnJfeH5Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UoQgdp6hqQyxSwGPs7Ub0eV0cGpIx9z/wwsC13FtbhXUY7DLdkm9RtNSuP060p66e6483yx9sAJYPqU9PA/TSoT/5BaRea7ay40DPYmcwjoQQg0MGMA3+OpxirRZAlApSpRgMi6IN6i6lROj1N15taBD0JCOw60ytKQRLIrLfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nbawJt+I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.216.206] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id E1F5A20B2000;
	Thu,  8 Feb 2024 11:16:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1F5A20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707419776;
	bh=i98ZLKDqEvufPmP0CP03uDP997ifl1JzFY8QJyEq9Os=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nbawJt+IKjHHu2ZEUdn88rrFMtw6DfFKq2Q/8J65HHXaLLL7e8Y9kPN6s75xn9yXD
	 5zepTl3VZrcQM8p27ntxH4VRGdArqqvcC7zkzEzF6HAlm+CtFQqbFfpYP6ovxLYMqH
	 L/TlX7/QsS9c7Hm/vZootksmDquirS/+NYZ7hW7A=
Message-ID: <7ef4b699-0b62-4610-bcd1-68c9d253959c@linux.microsoft.com>
Date: Thu, 8 Feb 2024 11:16:15 -0800
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
To: Anshuman Khandual <anshuman.khandual@arm.com>,
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
 <df731836-04ab-41b9-b317-434a1060ad61@arm.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <df731836-04ab-41b9-b317-434a1060ad61@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/2024 11:54 PM, Anshuman Khandual wrote:
> 
> On 2/7/24 01:28, Easwar Hariharan wrote:
>> Several workload optimizations and errata depend on validating that the
>> optimization or errata are applicable to the particular CPU by checking
>> the MIDR_EL1 system register value. With the Microsoft implementer ID
> 
> Which is how it should be done.
> 
>> for Azure Cobalt 100, the value doesn't match and ~20-25% performance
>> regression is seen in these workloads. Override the Azure Cobalt 100
>> value and replace it with the default ARM Neoverse N2 value that Azure
>> Cobalt 100 is based on.
> 
> Why cannot these MIDR values be classified as required and subscribed to
> the existing erratas that is affecting such implementations. Hence these
> work arounds will be triggered as and when applicable. Why then override
> MIDR value instead ?
>

Thanks for the feedback, I will go ahead and add the Azure Cobalt 100 MIDR
value to the range of MIDRs affected by the Neoverse N2 errata. This
patch was a proof of concept to have userspace apply the Neoverse N2
optimizations to Azure Cobalt 100 as well. As Mark mentioned in a sibling
response, this is not an acceptable way to accomplish this.

>>
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


