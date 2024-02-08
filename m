Return-Path: <linux-kernel+bounces-58604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D37584E8CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED581F224E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320036B17;
	Thu,  8 Feb 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="geHfwa9B"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067136AF5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419774; cv=none; b=N033c45e3w1R9kq7lT4sJApoZusmUhoJvS+4SrJ43I4FZkSWLCso2wRcfoADPI4NuRD7XKVRuP2Qh+VsQRYFQFSGw+IOq3Oe0W913Y8vRFYjUYD70UTLqdOL5cxn++OTgdXh7UwC9UyB+EaIzg51GUQhI9DHgRnlbearqXCuy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419774; c=relaxed/simple;
	bh=eAlBG3F5We9GYEnpd8ZGWflzwz8JVxeSAkyDu+z1g0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMEuWznc26cg7+8coAHAp/40GAiuWg96eviw+Nbpt5A1+/n0vEO2o8wyfHtIWGAWdTcvBzcmhy5/PbVYUksc5GhKwHcjBk0xbUSsUq806NFEKdGtLKMPYXrAmbLE4FP7e2YFKzE7X8rJ9xvrA2gi++RFIIrnRlpGh/9krZC3f+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=geHfwa9B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.216.206] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4AF49207E717;
	Thu,  8 Feb 2024 11:16:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AF49207E717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707419767;
	bh=53VQ1wtJ3Bp3ZW1pWDvdrXvcvOq5kb+U1QAHuljf+Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=geHfwa9Bi304IDw5TFIdHLnslxTlMpaAbDY02K8ezt1SN6vO1huHrI4j2PNrcqNqx
	 h3IaJxy0EVDhJZ2xj2i4jP4eKF/7nNu0RSOdKPtO6FuL2GI5fh7YNzcwWcL4Rdvksj
	 ajoLDo5KRXT/M7OVhNpMhx75deLRwdGUXHofMeCY=
Message-ID: <7e6add2c-f519-4838-9dd9-57841c50e538@linux.microsoft.com>
Date: Thu, 8 Feb 2024 11:16:06 -0800
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
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andre Przywara <andre.przywara@arm.com>,
 Rob Herring <robh@kernel.org>, Fuad Tabba <tabba@google.com>,
 Joey Gouly <joey.gouly@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)"
 <kvmarm@lists.linux.dev>
References: <20240206195819.1146693-1-eahariha@linux.microsoft.com>
 <86r0ho61ta.wl-maz@kernel.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <86r0ho61ta.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/2024 1:50 AM, Marc Zyngier wrote:
> On Tue, 06 Feb 2024 19:58:16 +0000,
> Easwar Hariharan <eahariha@linux.microsoft.com> wrote:
>>
>> Several workload optimizations and errata depend on validating that the
>> optimization or errata are applicable to the particular CPU by checking
>> the MIDR_EL1 system register value. With the Microsoft implementer ID
>> for Azure Cobalt 100, the value doesn't match and ~20-25% performance
>> regression is seen in these workloads. Override the Azure Cobalt 100
>> value and replace it with the default ARM Neoverse N2 value that Azure
>> Cobalt 100 is based on.
> 
> Since you don't disclose *why* this particular value should have any
> impact on the behaviour of the kernel, the answer should be "Thanks,
> but no, thanks".
>

The optimizations mentioned in the commit message reside in userspace
and depend on the MIDR value exposed to userspace by the kernel. As
mentioned in my response to Anshuman, this patch was a proof of concept
to have userspace apply the Neoverse N2 optimizations to Azure Cobalt 100
as well.

> Whatever the reason is for doing so, you should make it plain what you
> are working around. Blindly overriding ID registers is not an option,
> and you should simply add your MIDR value to whatever errata list that
> actually matches your implementation.
>

Thank you, I will do that.

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
> 
> As pointed out to me by Joey, this line is really interesting, and
> shows that you didn't really test this patch.
>

That has clearly escaped my notice, but we did test the patch and
validate that the Neoverse N2 MIDR value showed up where we looked.
Being new to arch/arm64, it's very possible that I may have modified
this hunk without needing to.

> Thanks,
> 
> 	M.
> 


