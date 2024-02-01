Return-Path: <linux-kernel+bounces-47696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B0845171
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B4294B50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A3157E7B;
	Thu,  1 Feb 2024 06:36:45 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF208141998
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769404; cv=none; b=ZfrDvI1BMp3mBJWEOt4i1+MhGJ+xRID1ImVoV/Qr9zF/KaXLBz3Cnh/kytgZ1Weqf//MhH+xQ33qPv8/c/1u9I562PoDXjO2DZFU7dHHDEgyfXHzfSQ+nIFIh4mgPlV6GPtClW8tllWNJiu1mTE4MaE820qQEQjuZyd5ajmqr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769404; c=relaxed/simple;
	bh=i5MSXSaMLBae+fF8XqEzWeeV65s59098xCl+b3aOpF8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sYWu5n83DFD1VaL1S2cuOKcAFt4RHHRyrCSLgoF2XbwCCMMP3xt/uGu8Qw4jPrwquV573yPAv0ZZbpX4mQ3GwwAXyxkX7EVQGKWmuXeNAMeInnXe/H+7IGi9Ykr/OcmJ+HqorlLaGwuFVdSt0QU/sZZX4uuwc7X/OYT1cDUNPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1706769344tulmhuuk
X-QQ-Originating-IP: KjVD9+aX2aZYMjcATJfslkoCIdDVohZOIl74GAItYuU=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Feb 2024 14:35:42 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: CQfe3icsPEi/sJ/cqrnfoco1YIfqgVP1kmCAjw6Sx6FzmEKq6FBYfgPS504h3
	Kv5cVDHuspbbC8dDaMbq5jK8kcq82KW5TJpthlNo+GRe/asZiG8c3lohdf3BSpEAOoAjNX0
	I0auOD9luogHkD3uEHX8nA2VJy9WAHSx0tsDPBabTKail/bqvdvvl4xzrFYwZ/h9V00upDE
	MfFSDA03IkoPveMFaN8odJRL1IoqNYzOvEDqgMoGRmIbZVDASDdPYzqFFW/N5z2ExxFdFxF
	hACBNNlPo1sSxXRavU9b5VNcUuYD1NC1wgFCPb/3G5Cqiu2un/PyfSU/tcb0PdYCJpd3Lzo
	xNtmJtbLVAwE8ywYHxwNYnfeqYPvvrHeTV9ji6OQhqhoVTKSiToMJvjQW6Y5b30oaH6K/Tg
	Ar5ZWQDq+jgdnUbB0PlvhrqQs34YxFNt
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3035629333089044456
Message-ID: <910819427166ACC0+fac3c73b-ed5b-4e53-b4b2-d636f5bdcca4@shingroup.cn>
Date: Thu, 1 Feb 2024 14:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
 <deb708e5-bbaf-4510-826b-17e14e69b475@kernel.org>
 <6D9001324476F76F+ee5f853d-7c69-4a99-857c-cc2b03e9eea1@shingroup.cn>
 <fef66164-1238-45e4-b70c-c565caa2cf75@kernel.org>
 <0C0EA95E5AC6D147+ff1001b7-d61b-4365-9a22-b3c4dfacbc53@shingroup.cn>
 <a399c8a5-5972-4e21-b3c0-9201f0f6b146@kernel.org>
 <cefbbefe-9b10-4ae4-9bb8-af6eb6916f6a@shingroup.cn>
In-Reply-To: <cefbbefe-9b10-4ae4-9bb8-af6eb6916f6a@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/2/1 11:00, Yang Jialong 杨佳龙 写道:
> 
> 
> 在 2024/1/31 18:36, Krzysztof Kozlowski 写道:
>> On 31/01/2024 11:07, Yang Jialong 杨佳龙 wrote:
>>>
>>>
>>> 在 2024/1/31 17:38, Krzysztof Kozlowski 写道:
>>>> On 31/01/2024 10:07, Yang Jialong 杨佳龙 wrote:
>>>>>
>>>>>
>>>>> 在 2024/1/31 15:59, Krzysztof Kozlowski 写道:
>>>>>> On 31/01/2024 08:08, JiaLong.Yang wrote:
>>>>>>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>>>>>>> One ni-700 can have many clock domains. Each of them has only one 
>>>>>>> PMU.
>>>>>>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>>>>>>> PMU name will be ni_pmu_N_M, which N means different NI-700s and 
>>>>>>> M means
>>>>>>> different PMU in one NI-700. If only one NI-700 found in NI-700, 
>>>>>>> name will
>>>>>>> be ni_pmu_N.
>>>>>>> Node interface event name will be xxni_N_eventname, such as
>>>>>>> asni_0_rdreq_any. There are many kinds of type of nodes in one clock
>>>>>>> domain. Also means that there are many kinds of that in one PMU. 
>>>>>>> So we
>>>>>>> distinguish them by xxni string. Besides, maybe there are many nodes
>>>>>>> have same type. So we have number N in event name.
>>>>>>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus 
>>>>>>> traffic.
>>>>>>> Example1: perf stat -a -e 
>>>>>>> ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>>>>>>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>>>>>>
>>>>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>>>>> ---
>>>>>>> v1 --> v2:
>>>>>>> 1. Submit MAINTANER Documentation/ files seperately.
>>>>>>
>>>>>> SEPARATE PATCHES, not patchsets. You have now checkpatch warnings
>>>>>> because of this...
>>>>>
>>>>> ...OK. But the MAINTANER file changing should be given in which one
>>>>> patches.
>>>>> I will submit patch v3 after talking and your permission.
>>>>>
>>>>>>
>>>>>>> 2. Delete some useless info printing.
>>>>>>> 3. Change print from pr_xxx to dev_xxx.
>>>>>>> 4. Fix more than 75 length log info.
>>>>>>> 5. Fix dts attribute pccs-id.
>>>>>>> 6. Fix generic name according to DT specification.
>>>>>>> 7. Some indentation.
>>>>>>> 8. Del of_match_ptr macro.
>>>>>>>
>>>>>>>     drivers/perf/Kconfig     |   11 +
>>>>>>>     drivers/perf/Makefile    |    1 +
>>>>>>>     drivers/perf/hx_arm_ni.c | 1284 
>>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>>     3 files changed, 1296 insertions(+)
>>>>>>>     create mode 100644 drivers/perf/hx_arm_ni.c
>>>>>>>
>>>>>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>>>>>> index ec6e0d9194a1..95ef8b13730f 100644
>>>>>>> --- a/drivers/perf/Kconfig
>>>>>>> +++ b/drivers/perf/Kconfig
>>>>>>> @@ -241,4 +241,15 @@ config CXL_PMU
>>>>>>>           If unsure say 'm'.
>>>>>>> +config HX_ARM_NI_PMU
>>>>>>> +       tristate "HX ARM NI-700 PMU"
>>>>>>> +       depends on PPC_HX_C2000 && 64BIT
>>>>>>
>>>>>> 1. There is no PPC_HX_C2000.
>>>>>
>>>>> I have been used to using this macro. However this macro is not 
>>>>> existed
>>>>> in mainline.
>>>>> I will replace it with ARM64. And del involved C code if OK.
>>>>>
>>>>> 64bit:
>>>>> __ffs(unsigned long) and __fls(unsigned long) will be wrong in 
>>>>> 32bit. I
>>>>> pass a u64 argument.
>>>>
>>>> One thing is where the code is supposed to run, second thing is compile
>>>> testing.
>>>>
>>>
>>> Now run on my company product, a 64bit PowerPC...
>>> But I think it's general for 64bit systems.
>>>
>>>> Why do you use __ffs, not __ffs64 which takes u64 if you really want
>>>> only 64bit argument? unsigned long != u64, so your code is not
>>>> architecture independent. You claim you wrote it on purpose as
>>>> non-architecture-independent, but then I claim it's a bug. We are
>>>> supposed to write code which is portable, as much as possible, assuming
>>>> it does not affect readability.
>>>>
>>>
>>> I write code in v5.18, there are __ffs64() and fls64(). Asymmetric.
>>
>> Sorry, that's a no go.
>>
>> That's some very, very old kernel. Do not develop on old kernels, but on
>> mainline. I also suspect that by basing your work on old kernel, you
>> duplicate a lot of issues already fixed.
>>
>>> There are some difference in return val between __ffs() and ffs64().
>>> __ffs(0) and ffs64(0) will give different value.
>>
>> __ffs64 calls __ffs, so why would results be different?
>>
>> Anyway, that's not really excuse.
>>
> 
> OK. Follow mainline.
> 
>>
>>>
>>> And I'm sure code run in 64bit. So I choose to use __ffs and __fls.
>>>
>>> Maybe it could be compatbile with 32bit. But I don't have a environment
>>> to test this.
>>>>
>>>>> struct ni_hw_perf_event will be big than limit.
>>>>> BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) > offsetof(struct
>>>>> hw_perf_event, target));
>>>>
>>>> And why do you need to use any of such code? Please open one of 
>>>> hundreds
>>>> of other drivers which work correctly on 32 and 64-bit platforms.
>>>>
>>>
>>> Code for 64bit.
>>> This code is to avoid struct ni_hw_perf_event is too big than struct
>>> hw_perf_event::target.
>>
>> 1. Why would that matter? target is task_struct. It's size does not
>> matter. Maybe its offset matters, but not size.
>>
> 
> Offset.
> 
>> 2. So you claim that on 32-bit system the structure will be bigger than
>> on 64-bit system?
> 
> The structure will exceed the offset in 32bit. Maybe because the latter 
> changed more.
> OK. Dont care please.
> 
>>
>>> I learn it from arm-cmn.c.
>>
>> Are you copying patterns because they are good patterns or just because
>> you decided to copy?
> 
> Maybe this way is not very good for event framework.
> OK. Not an official way.
> 

First, the struct hw_perf_event is originally used to record some 
general information about its event. Example, struct 
hw_perf_event::state is used to record status by driver developer.

Second, But there are some field I don't need to use. And instread I 
want to use another name, just like en_bit_mask or is_cc, depending on hw.

Finally, considering the lifetime keeping of struct ni_hw_perf_event, 
this way is very well. I don't need to keep an eye on it. And I just 
need to promise the size. So I choose BUILD_BUG_ON();

What do you think?

Dont care about 32, 64 or offset.

>>
>>> ni_hw_perf_event will replace hw_perf_event.
>>> I will put some useful information in it with less space and good field
>>> names.
>>> But I can't exceed a limit.
>>>
>>>>>
>>>>>> 2. Nothing justified dependency on 64bit. Drop or explain. Your 
>>>>>> previous
>>>>>> message did not provide real rationale.
>>>>>
>>>>> If ARM64, then drop.
>>>>
>>>> ...
>>>>
>>>> ...
>>>>
>>>>>>> +    /* Step2: Traverse all clock domains. */
>>>>>>> +    for (cd_idx = 0; cd_idx < ni->cd_num; cd_idx++) {
>>>>>>> +        cd = cd_arrays[cd_idx];
>>>>>>> +
>>>>>>> +        num = ni_child_number(cd);
>>>>>>> +        dev_dbg(dev, "The %dth clock domain has %d child 
>>>>>>> nodes:", cd_idx, num);
>>>>>>> +
>>>>>>> +        /* Omit pmu node */
>>>>>>> +        ni_pmu = devm_kzalloc(dev, struct_size(ni_pmu, 
>>>>>>> ev_src_nodes, num - 1),
>>>>>>> +                      GFP_KERNEL);
>>>>>>> +        ni_pmu->ev_src_num = num - 1;
>>>>>>> +
>>>>>>> +        if (!ni_pmu)
>>>>>>> +            return -ENOMEM;
>>>>>>> +
>>>>>>> +        num_idx = 0;
>>>>>>> +        for (nd_idx = 0; nd_idx < num; nd_idx++) {
>>>>>>> +            nd = ni_child_pointer(pbase, cd, nd_idx);
>>>>>>> +
>>>>>>> +            node.base = nd;
>>>>>>> +            node.node_type = ni_node_node_type(nd);
>>>>>>> +
>>>>>>> +            if (unlikely(ni_node_type(nd) == NI_PMU))
>>>>>>> +                ni_pmu->pmu_node = node;
>>>>>>> +            else
>>>>>>> +                ni_pmu->ev_src_nodes[num_idx++] = node;
>>>>>>> +            dev_dbg(dev, "  name: %s   id: %d", 
>>>>>>> ni_node_name[node.type], node.id);
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        ni_pmu->dev = dev;
>>>>>>> +        ni_pmu->ni = ni;
>>>>>>> +        ni->ni_pmus[cd_idx] = ni_pmu;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    devm_kfree(dev, cd_arrays);
>>>>>>
>>>>>> Why? If it is not device-lifetime then allocate with usual way.
>>>>>>
>>>>>
>>>>> No device-lifetime.
>>>>> Will allocate in stack.
>>>>
>>>> I was thinking about kzalloc. But if array is small, stack could be 
>>>> as well.
>>>>
>>>
>>> If I have to return before devm_kfree because of wrong, I will have 
>>> to use:
>>>
>>> goto out;
>>>
>>> out:
>>> kfree();
>>>
>>> But if I use devm_kzalloc, I will not be worried about that. Even if no
>>
>> devm* is not for that purpose. devm is for device-managed allocations.
>> Device does not manage your allocation.
>>
>>> device-lifetime.
>>> Isn't this a good way?
>>
>> Then you want cleanup.h and use proper __free().
> 
> Good NEW API. It does what I want.
> Learned more. Thanks.
> 
>>
>> Best regards,
>> Krzysztof
>>
>>

