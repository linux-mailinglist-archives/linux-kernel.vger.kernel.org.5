Return-Path: <linux-kernel+bounces-100079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD287917B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D30B222B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472E7828F;
	Tue, 12 Mar 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RhjP3V/S"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B678281;
	Tue, 12 Mar 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237227; cv=none; b=AlhAvdLQuERk3lXGyD7dwdQYeJZHTtauaXOxw7sIX4t+dHNZBctXgHAyLpymPh5FhcKpXU68P+YD2nvz97HFJHuniwnP9dUqfJwOxaE/oZ2Y0eptNwjRL6AHp0Scd953Iu3D8p2k7ebJIrOKEM+FJPUZuhO6GOBxt1o4OdTWEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237227; c=relaxed/simple;
	bh=sUamQysyu6qncLunL28VRaKzze+Y8PjsFwjFSAPvlns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRFEExAAst3WL/siHnB3J7BfIJkQeFgZztjE/KmAXv1Lcx8RI/MNQ9MZovxQ0tWA0Gc9ZSIGM8eGfKl2LVOrSHBNpKko0steTQQFFz6v81EV37MN9l8YE8ZUH2FzYhlNLVGVatAZs11rlUYsf/sdvW5ifE0Dmt9SpL1GWaTfgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RhjP3V/S; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710237222; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xQKHCh361SfWZRmqI7leh9Mlmi1eAF8yjLMSaUPV8LQ=;
	b=RhjP3V/SGYM7fOvnyYt9jX8IbgGwFmTS/z/eCVfZUku/n3h087JZHf1uytQQGWewBDMAuSvO/1yd1ASIVPuLGf3c77lure1LlWSllSe2ZCvtWphK+3JUGZYnMU0nPKqbXzRfpQz+9McDz74D67r1irSSHOzTu4EoRvBBMiTosMg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W2LY0LL_1710237220;
Received: from 30.221.132.227(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W2LY0LL_1710237220)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 17:53:41 +0800
Message-ID: <79d3441c-fb7e-4e02-a381-99e8d639ad1c@linux.alibaba.com>
Date: Tue, 12 Mar 2024 17:53:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
 guohanjun@huawei.com, sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tyler Baicar <baicar@os.amperecomputing.com>,
 Ruidong Tian <tianruidong@linux.alibaba.com>
References: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
 <20240304111517.33001-2-tianruidong@linux.alibaba.com>
 <86wmqi19pg.wl-maz@kernel.org>
 <aaad88c3-333d-4714-a9ca-3b66c8a5d9c8@linux.alibaba.com>
 <8734szr8y9.wl-maz@kernel.org>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <8734szr8y9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/9 18:33, Marc Zyngier 写道:
> On Fri, 08 Mar 2024 03:43:30 +0000,
> Ruidong Tian <tianruidong@linux.alibaba.com> wrote:
>>
>> 在 2024/3/4 20:07, Marc Zyngier 写道:
>>> On Mon, 04 Mar 2024 11:15:16 +0000,
>>> Ruidong Tian<tianruidong@linux.alibaba.com>  wrote:
>>>> diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
>>>> new file mode 100644
>>>> index 000000000000..2fb0d9741567
>>>> --- /dev/null
>>>> +++ b/arch/arm64/include/asm/ras.h
>>>> @@ -0,0 +1,38 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef __ASM_RAS_H
>>>> +#define __ASM_RAS_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <linux/bits.h>
>>>> +
>>>> +#define ERR_STATUS_AV		BIT(31)
>>>> +#define ERR_STATUS_V		BIT(30)
>>>> +#define ERR_STATUS_UE		BIT(29)
>>>> +#define ERR_STATUS_ER		BIT(28)
>>>> +#define ERR_STATUS_OF		BIT(27)
>>>> +#define ERR_STATUS_MV		BIT(26)
>>>> +#define ERR_STATUS_CE		(BIT(25) | BIT(24))
>>>> +#define ERR_STATUS_DE		BIT(23)
>>>> +#define ERR_STATUS_PN		BIT(22)
>>>> +#define ERR_STATUS_UET		(BIT(21) | BIT(20))
>>>> +#define ERR_STATUS_CI		BIT(19)
>>>> +#define ERR_STATUS_IERR 	GENMASK_ULL(15, 8)
>>>> +#define ERR_STATUS_SERR 	GENMASK_ULL(7, 0)
>>> All these bits need to be defined in arch/arm64/tools/sysreg as
>>> ERXSTATUS_EL1 fields.
>>
>> This file only describes the system register, but RAS MMIO registers
>> use these bits too. Would it be appropriate to define them in
>> arch/arm64/tools/sysreg?
> 
> You are using them for system registers, they need to be defined
> there. The fact that they are also used to MMIO is anecdotal.

There might have been some misunderstanding. AEST interface can be 
SR(processor) or MMIO(GIC, SMMU, Memory), All these two types of nodes 
have ERR<n>STATUS register, and AEST driver need to operate these filed 
both in SR and MMIO register.

> 
> [...]
> 
>>>> +#define CASE_READ_CLEAR(x, clear)					\
>>>> +	case (x): {							\
>>>> +		res = read_sysreg_s(SYS_##x##_EL1);			\
>>>> +		if (clear)						\
>>>> +			write_sysreg_s(0, SYS_##x##_EL1);		\
>>>> +		break;							\
>>>> +	}
>>> Please don't use macros with side effects. This is horrible to debug.
>>> Instead, *return* the value from the macro, or pass the variable you
>>> want to affect as a parameter.
>>
>> OK, I will pass **res** as a parameter like this:
>>
>>    #define CASE_READ_CLEAR(res, x, clear)			\
>> 	  case (x): {						\
>> 		  res = read_sysreg_s(SYS_##x##_EL1);		\
>> 		  if (clear)					\
>> 			  write_sysreg_s(0, SYS_##x##_EL1);	\
>> 		  break;					\
>> 	  }
>>
>>>
>>> Also, what ensures the synchronisation of this write? How is the W1TC
>>> aspect enforced?
>>
>> aest_proc is just call in irq context, one ras error is just routed to
>> one core, so it is thread safe. And this is a Write-After-Read (WAR)
>> Hazards with dependence，can i assume that pipeline would guarantee
>> the order of writing and reading?
> 
> You are missing the point. WAR hazarding doesn't mean that the write
> has taken effect, and can be delayed for as long as the CPU decides
> to, until the nest context synchronisation event.
> 
> The W1TC question still stands.

OK, i will add an ISB at the end of aest_proc to ensure all writes has 
taken effect.

> 
> [...] >
>>>> +static u64 aest_iomem_read_clear(u64 base, u32 offset, bool clear)
>>>> +{
>>>> +	u64 res;
>>>> +
>>>> +	res = readq((void *)(base + offset));
>>>> +	if (clear)
>>>> +		writeq(0, (void *)(base + offset));
>>> Do you need the explicit synchronisation? What ordering are you trying
>>> to guarantee?
>>
>> This read and write use the same address, pipeline would guarantee
>> the order of writing and reading.
> 
> You are missing the point again. Non-relaxed accessors come with a DMB
> that enforces ordering with younger reads and older writes. Why do you
> need those?
>

I get it. Relaxed accesses are still guaranteed to be ordered when 
operating MMIO address. I will use readq/writeq_relaxed in next version.

> [...]
	>
>>>> +static int __init aest_register_gsi(u32 gsi, int trigger, void *data,
>>>> +					irq_handler_t aest_irq_func)
>>>> +{
>>>> +	int cpu, irq;
>>>> +
>>>> +	irq = acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
>>>> +
>>>> +	if (irq == -EINVAL) {
>>>> +		pr_err("failed to map AEST GSI %d\n", gsi);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (gsi < 16) {
>>>> +		pr_err("invalid GSI %d\n", gsi);
>>>> +		return -EINVAL;
>>>> +	} else if (gsi < 32) {
>>>> +		if (ppi_idx >= AEST_MAX_PPI) {
>>>> +			pr_err("Unable to register PPI %d\n", gsi);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		ppi_irqs[ppi_idx] = irq;
>>>> +		enable_percpu_irq(irq, IRQ_TYPE_NONE);
>>> Enabling the PPI before requesting it? Looks... great. And how does
>>> this work on a system that supports EPPIs, which are in the
>>> [1119:1056] range?
>>
>> It is better to enable it after request it, i will fix it next version.
>> My machine do not use EPPI as RAS interrupt, i can not test it now. Can
>> we support EPPI in later patch?
> 
> No, because you shouldn't even have to care. Can you see a single
> driver in the tree that do this?

OK，I will fix it next version.

> 
>>
>>>
>>> Also, if you get a trigger as a parameter, why the IRQ_TYPE_NONE?
>>>
>> Sorry，I do not really understand this comment, should I use
>> (IRQ_LEVEL | IRQ_PER_CPU)?
> 
> You tell me. Either the trigger is relevant, or it isn't. But I assume
> it is passed as a parameter to the function for a good reason.


> 
>>
>>>> +		for_each_possible_cpu(cpu) {
>>>> +			memcpy(per_cpu_ptr(ppi_data[ppi_idx], cpu), data,
>>>> +			       sizeof(struct aest_node));
>>>> +		}
>>>> +		if (request_percpu_irq(irq, aest_irq_func, "AEST",
>>>> +				       ppi_data[ppi_idx++])) {
>>>> +			pr_err("failed to register AEST IRQ %d\n", irq);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	} else if (gsi < 1020) {
>>>> +		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
>>>> +				data)) {
>>> Why SHARED? Who would share a RAS interrupt?????
>>
>> Multi AEST nodes may use the same interrupt, for example, one DDRC with
>> a RAS interrupt has two sub channels, these two sub channel is described
>> as two AEST node in AEST table, so they share the same one. In another
>> case, SMMU has two RAS node, TCU and TBU, they may also share the same
>> interrupt.
> 
> I still find it odd, but hey, if that's the way people want to handle
> RAS, they might as well OR all of them and wire it to the RESET pin.
> 

It depends on HW designer especially for DDRC, and i think **SHARED** is 
more compatible. But in fact, I'm not sure if driver should assume that 
all RAS interruptions are no shared. If AEST driver set IRQ no shared, 
does it need to loop through all AEST node first to ensure no node 
sharing interrupt?

>>
>>>
>>>> +			pr_err("failed to register AEST IRQ %d\n", irq);
>>>> +			return -EINVAL;
>>> Same question about extended SPIs.
>>>
>>> All in all, this whole logic is totally useless. It isn't the driver's
>>> job to classify the GIC INTIDs...
>>
>> AEST use both PPI and SPI, it seems that AEST driver must recognize
>> INTID in order to request irq number with different function, do you
>> have better solution here?
> 
> Again, you should have to look at the INTID, ever. That's none of your
> business, and you don't even know what interrupt controller the system
> is presenting you anyway. The way to identify a per-CPU interrupt is
> to use the irq_is_percpu_devid() helper, and not to mess with
> pointless heuristics.

OK, it will be fixed in next version.
> 
> Thanks,
> 
> 	M.
> 

