Return-Path: <linux-kernel+bounces-82616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB486874E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD87E2849DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043516426;
	Tue, 27 Feb 2024 02:39:19 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B211CAF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001558; cv=none; b=NORHxGCTZrf7q9gnUwHgpoGIEi4c1tMdjOuI+Iocb5MAq4v2HV60ypVoq3irS3G1IJk/O1Rz6Kj430D3gKtCPD2FZnuZK2h636Bd/f1KqtDeF1o5r4nc7FdPXA6IlXgBBHdIn2lX44UeKw9OtQG9NCeYc1vgI4d3RUvylTZ1auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001558; c=relaxed/simple;
	bh=G5HJ+8Q+qiqhke3/ujDV446FzNXsiFd6+c20hMGpZjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvY9NddTmfPz/PvK1h0KhVMw92pZ/UIeaxSb8uB17BUiw00g0SxY7TqNipiy2N4WGg0mY+MlvF2oK3HFnRwZ9cdCPkh7XHFHfKyGWdrH6pSvhDEYg5xDfEM0LLkVqTVdkWO8q1u5eh3RVAfg81an6u3dBhk/7N0OyDqUCek+hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp70t1709001498txg9vpnh
X-QQ-Originating-IP: 32+HvuoH4RW7emLUT50viPliKaqlKjxqgw085RF72lg=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Feb 2024 10:38:16 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: xnbq7qFd8vpa4pHLM2FhnlVOrdscZyBAZOC6iim3Wx79lWb8AsTrJEVIFnFod
	ZV22LWhpmhYEgaXbXoEZXM+r0f5qI/uMQ8vgqd3B8PAAM3SB+Wcwu0VH7Z1xqjHEANvZL3e
	y15hZpU+Hxbaxaa1RUmoi/1C2g20D7kvWej/2xwdQxsWWZW8M23Zq6OB6h3wrjFQifHMCZg
	A6tk5zZC2IqH8WiJU+mVw8bEtmapv5sxp6eOiJVO+qAzAYnj6s+riRWGUkqlAz8SlSPA6Pr
	KFpAvnmq0ZTqOOKKnqd/Za39NZ1+0JO6TqPWxuCPkgyh8frzVwbE55g3CBhM9T/8b8+/6cj
	1UTpjkZsjTkR7xA6GMdBBUJgamLtP0qM2eqodOIDfNOYb1qQvmj8dfDlQpXlb4x6qkHUYH/
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13829295267337303823
Message-ID: <7103516EBC4633DF+c40c7100-c49a-460c-83ce-7a53a137ef57@shingroup.cn>
Date: Tue, 27 Feb 2024 10:38:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm_smmuv3: Omit the two judgements which done in
 framework
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, shenghui.qu@shingroup.cn,
 ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231221093802.20612-1-jialong.yang@shingroup.cn>
 <20240209160905.GA24565@willie-the-truck>
 <a455e5db-676a-4cf8-8669-8a10e900361c@arm.com>
 <840C2556C7DDB57C+c4575f04-5d1b-44a5-8f7b-3a2ba1fd61c4@shingroup.cn>
 <f50a219b-81da-4301-aea0-7a1e3e759c37@arm.com>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <f50a219b-81da-4301-aea0-7a1e3e759c37@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/2/27 2:57, Robin Murphy 写道:
> On 19/02/2024 6:37 am, Yang Jialong 杨佳龙 wrote:
>>
>>
>> 在 2024/2/10 0:32, Robin Murphy 写道:
>>> On 2024-02-09 4:09 pm, Will Deacon wrote:
>>>> On Thu, Dec 21, 2023 at 05:38:01PM +0800, JiaLong.Yang wrote:
>>>>> 'event->attr.type != event->pmu->type' has been done in
>>>>> core.c::perf_init_event() ,core.c::perf_event_modify_attr(), etc.
>>>>>
>>>>> This PMU is an uncore one. The core framework has disallowed
>>>>> uncore-task events. So the judgement to event->cpu < 0 is no mean.
>>>>
>>>> It would be great to refer to the changes which added those checks to
>>>> the perf core code. From reading the code myself, I can't convince 
>>>> myself
>>>> that perf_try_init_event() won't call into the driver.
>>>>
>>>>>
>>>>> The two judgements have been done in kernel/events/core.c
>>>>>
>>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>>> ---
>>>>>   drivers/perf/arm_smmuv3_pmu.c | 8 --------
>>>>>   1 file changed, 8 deletions(-)
>>>>
>>>> It looks like _many_ perf drivers have these checks, so if they really
>>>> aren't needed, we can clean this up bveyond SMMU. However, as I said
>>>> above, I'm not quite convinced we can drop them.
>>>
>>> Right, I think the logic prevents events with a specific PMU type 
>>> being offered to other PMUs, but as far as I'm aware doesn't apply 
>>> the other way round to stop generic events (PERF_TYPE_HARDWARE etc.) 
>>> being offered to all PMUs, so it's those that system PMUs need to 
>>> reject. >
>>> It's been on my wishlist for a long time to have a capability flag to 
>>> say "I don't handle generic events, please only ever give me events 
>>> of my exact type" so we *can* truly factor this into the core.
>>
>>
>> It's core framework's responsible to differ generic events and others, 
>> or uncore pmu and core pmu.
>> Here we have flag PERF_TYPE_HARDWARE, PERF_TYPE_HW_CACHE, 
>> PERF_PMU_CAP_EXTENDED_HW_TYPE doing this.
>>
>> again:
>>          rcu_read_lock();
>>          pmu = idr_find(&pmu_idr, type);
>>          rcu_read_unlock();
>>          if (pmu) {
>>                  if (event->attr.type != type && type != PERF_TYPE_RAW &&
>>                      !(pmu->capabilities & 
>> PERF_PMU_CAP_EXTENDED_HW_TYPE))
>>                          goto fail; /* generic event with no ability 
>> pmu */
>> This can avoid driver code (event->attr.type != event->pmu->type).
> 
> Now consider the other case below that, where "type" has not matched 
> anything registered, so "pmu" is NULL, and the event is then offered to 
> *every* registered PMU to see if anyone accepts it. Note that even CPU 
> PMUs don't always register as PERF_TYPE_RAW, and in particular arm_pmu 
> doesn't.
> 
arm_pmu has flag PERF_PMU_CAP_EXTENDED_HW_TYPE.

 From below command, we can say that generic events is related to the 
pmus with type PERF_TYPE_RAW.
~/real_kernel $ grep -nr "PERF_TYPE_HARDWARE" arch/ drivers/ |cut -d: 
-f1|xargs egrep -c "perf_pmu_register.*PERF_TYPE_RAW"
arch/alpha/kernel/perf_event.c:1
arch/alpha/kernel/perf_event.c:1
arch/arc/kernel/perf_event.c:1
arch/csky/kernel/perf_event.c:1
arch/loongarch/kernel/perf_event.c:1
arch/loongarch/kernel/perf_event.c:1
arch/mips/kernel/perf_event_mipsxx.c:1
arch/mips/kernel/perf_event_mipsxx.c:1
arch/powerpc/perf/8xx-pmu.c:1
arch/powerpc/perf/core-fsl-emb.c:1
arch/powerpc/perf/core-book3s.c:1
arch/riscv/kvm/vcpu_pmu.c:0
arch/s390/kernel/perf_cpum_sf.c:1
arch/s390/kernel/perf_cpum_cf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/sh/kernel/perf_event.c:1
arch/sh/kernel/perf_event.c:1
arch/sparc/kernel/perf_event.c:1
arch/x86/events/amd/ibs.c:0
arch/x86/events/intel/core.c:0
arch/x86/events/core.c:1
arch/xtensa/kernel/perf_event.c:1
drivers/perf/arm_pmu.c:0
drivers/perf/arm_pmu.c:0
drivers/perf/riscv_pmu.c:0
drivers/perf/riscv_pmu_legacy.c:1
drivers/perf/arm_pmuv3.c:0
drivers/perf/riscv_pmu_sbi.c:1

 From this, we can say that generic events is related to the pmus with 
capability PERF_PMU_CAP_EXTENDED_HW_TYPE.
~/real_kernel $ grep -nr "PERF_TYPE_HARDWARE" arch/ drivers/ |cut -d: 
-f1|xargs grep -c "PERF_PMU_CAP_EXTENDED_HW_TYPE"
arch/alpha/kernel/perf_event.c:0
arch/alpha/kernel/perf_event.c:0
arch/arc/kernel/perf_event.c:0
arch/csky/kernel/perf_event.c:0
arch/loongarch/kernel/perf_event.c:0
arch/loongarch/kernel/perf_event.c:0
arch/mips/kernel/perf_event_mipsxx.c:0
arch/mips/kernel/perf_event_mipsxx.c:0
arch/powerpc/perf/8xx-pmu.c:0
arch/powerpc/perf/core-fsl-emb.c:0
arch/powerpc/perf/core-book3s.c:0
arch/riscv/kvm/vcpu_pmu.c:0
arch/s390/kernel/perf_cpum_sf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/s390/kernel/perf_cpum_cf.c:0
arch/sh/kernel/perf_event.c:0
arch/sh/kernel/perf_event.c:0
arch/sparc/kernel/perf_event.c:0
arch/x86/events/amd/ibs.c:0
arch/x86/events/intel/core.c:0
arch/x86/events/core.c:1
arch/xtensa/kernel/perf_event.c:0
drivers/perf/arm_pmu.c:2
drivers/perf/arm_pmu.c:2
drivers/perf/riscv_pmu.c:0
drivers/perf/riscv_pmu_legacy.c:0
drivers/perf/arm_pmuv3.c:0
drivers/perf/riscv_pmu_sbi.c:0

****************************
Something bad belows:
~/real_kernel $ grep -nr "PERF_TYPE_HARDWARE" arch/ drivers/ |cut -d: 
-f1|xargs egrep -c "perf_pmu_register.*-1"
arch/alpha/kernel/perf_event.c:0
arch/alpha/kernel/perf_event.c:0
arch/arc/kernel/perf_event.c:0
arch/csky/kernel/perf_event.c:0
arch/loongarch/kernel/perf_event.c:0
arch/loongarch/kernel/perf_event.c:0
arch/mips/kernel/perf_event_mipsxx.c:0
arch/mips/kernel/perf_event_mipsxx.c:0
arch/powerpc/perf/8xx-pmu.c:0
arch/powerpc/perf/core-fsl-emb.c:0
arch/powerpc/perf/core-book3s.c:0
arch/riscv/kvm/vcpu_pmu.c:0
arch/s390/kernel/perf_cpum_sf.c:0
arch/s390/kernel/perf_cpum_cf.c:2
arch/s390/kernel/perf_cpum_cf.c:2
arch/s390/kernel/perf_cpum_cf.c:2
arch/s390/kernel/perf_cpum_cf.c:2
arch/sh/kernel/perf_event.c:0
arch/sh/kernel/perf_event.c:0
arch/sparc/kernel/perf_event.c:0
arch/x86/events/amd/ibs.c:1
arch/x86/events/intel/core.c:0
arch/x86/events/core.c:0
arch/xtensa/kernel/perf_event.c:0
drivers/perf/arm_pmu.c:1
drivers/perf/arm_pmu.c:1
drivers/perf/riscv_pmu.c:0
drivers/perf/riscv_pmu_legacy.c:0
drivers/perf/arm_pmuv3.c:0
drivers/perf/riscv_pmu_sbi.c:0
The pmus::event_init handled PERF_TYPE_HARDWARE, but they was registered 
with perf_pmu_register(*, *, -1) without CAP_EXTENDED_HW_TPYE.

Can we unify them with PERF_TYPE_RAW or CAP_EXTENDED_HW_TYPE? Maybe the 
latter is well. So we can assign idr PERF_TYPE_HARDWARE and 
PERF_TYPE_HW_CACHE a known pmu in perf_pmu_register just like:
if(is_support_generic(pmu)) {
	ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HARDWAR, PERF_TYPE_HARDWARE + 
1, GFP_KERNEL);
	if(ret < 0)
		goto free_pdc;
	ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HW_CACHE, PERF_TYPE_HW_CACHE + 
1, GFP_KERNEL);
	if(ret < 0)
		goto free_pdc;
}
We will has a easy and rational way to write code in 
core.c::perf_init_event and perf_try_init_event about generic events. We 
can judge cpu < 0 in perf_try_init_event for uncore pmus.
> Thanks,
> Robin.
> 


