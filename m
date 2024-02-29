Return-Path: <linux-kernel+bounces-86044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CF386BEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD492B24074
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C936B00;
	Thu, 29 Feb 2024 02:23:40 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6F3613E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173420; cv=none; b=In/JZG+1dHoBSl0YLmr7p8Gqly0BoVEWsYieyT1en7RUb9iY5CXKAYQj6zL8Aa/kUjPKMP0BceiBtQw39KT+gr5qX5MaSxTL/KoKVZppZhNoKgRc7UE9rJmnKmTFoP1+x9BkaMRRc2NArCdLxMygxVmNhi6hMKnloSXomzHtxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173420; c=relaxed/simple;
	bh=+pngFm5dnLHfhdx03c9yhljFk/yn45ERTQuOmZoOVF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fF60io70NzhX1Gho2CAvnGgFwuzrMkrp+1iywAUQjRECUWmN4ujxxVQP66KF4H4RkomqAKfyNT204hp4/B6YwnvjRP4uOzDzJabcIEngUwiIhon7Dja2jH0nmY2gwEEW1tY7RWkBHptI2h1dxTGLqn2rzfTSAOlNv8tboEffMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1709173353tkzh1zrq
X-QQ-Originating-IP: uLYAUNIxTNxwdy+T1q1N6NYyqDLwHqPl6B9wtRt0oiA=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Feb 2024 10:22:32 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: CR3LFp2JE4mL/5mvuvva9dMAnSISHqNZb1uQ5lc4/1uAWKIky6H8Jnbby98P2
	qSyZMBwuI2mXziX9rU5UKG0MLvCUkXNumQjuZBQfNuL9fJZqF1qOdT4/B54Kxdb9DFJonN7
	LFwt8A+s1XBkmSMujj8aLBTk7yDq73B8AfdAmrP/iwMLdRL4Sd9xPBtgW0lziSz3jv3dS2x
	imAeueIP9+NBXxV8CUm3aaRNWF5xwhQLDueNMSc/aXBJsIpoJwgowgsqxBES0VSzwgaI47S
	+a/pK+9z+Q/j+3rIqZDW+LDs/K7YXliRJq3Zkzf+/qtohn+QywfzdZo4Zmxjskdjv3Z5FVk
	mMqKHp3JflMbWtF23d4K94tCkWuGTlvYFTs7bWaCEhECiX3sAX0etvJkKm9rk3N5ZRbhS4j
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 680634371040173557
Message-ID: <D104B809B4F8CA40+fb75eadf-c029-4da7-bda5-300b7d7f51c1@shingroup.cn>
Date: Thu, 29 Feb 2024 10:22:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
 <fe3e97c0-f641-48d6-9941-837e73ae3cfe@arm.com>
 <7C9733413A0F8F60+0214f04d-173d-4513-ac1e-681c2f2a8de4@shingroup.cn>
 <8daf740f-f16b-49af-8da9-7c7750092539@arm.com>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <8daf740f-f16b-49af-8da9-7c7750092539@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/2/3 4:11, Robin Murphy 写道:
> On 2024-02-01 2:40 am, Yang Jialong 杨佳龙 wrote:
>>
>>
>> 在 2024/2/1 0:50, Robin Murphy 写道:
>>> On 31/01/2024 7:08 am, JiaLong.Yang wrote:
>>>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>>>> One ni-700 can have many clock domains. Each of them has only one PMU.
>>>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>>>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M 
>>>> means
>>>> different PMU in one NI-700. If only one NI-700 found in NI-700, 
>>>> name will
>>>> be ni_pmu_N.
>>>> Node interface event name will be xxni_N_eventname, such as
>>>> asni_0_rdreq_any. There are many kinds of type of nodes in one clock
>>>> domain. Also means that there are many kinds of that in one PMU. So we
>>>> distinguish them by xxni string. Besides, maybe there are many nodes
>>>> have same type. So we have number N in event name.
>>>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>>>> Example1: perf stat -a -e 
>>>> ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>>>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>>
>>> Oh! I've had a driver for this thing sat around for ages waiting to 
>>> find someone with an interest in testing it. Given that from a quick 
>>> skim of this patch I'd also have several concerns with this 
>>> implementation, may I ask that you have a look at my branch and see 
>>> if it works for you?
>>
>> If permission I will test.
> 
> Thanks! I see you've also tried to support having the IRQs combined 
> together - does your platform need that right away? That's another thing 
> I've been anticipating but haven't got round to wiring up yet (it's a 
> bit more fiddly than just IRQF_SHARED since perf has some expectations 
> around affinity to event->cpu), but I can have a go at getting it done.
> 

I have not seen the expectations. I will study it.

>>>
>>> https://gitlab.arm.com/linux-arm/linux-rm/-/tree/ni-dev?ref_type=heads
>>>
>>> In particular, after the pain of maintaining event aliases in arm-cmn 
>>> I'd really like to get away from doing that again and instead move 
>>> over to jevents this time (especially now that system PMU support is 
>>> a bit more developed there) - I just haven't yet got round to hooking 
>>> up the identifier and writing the JSON files, since it hasn't seemed 
>>> like much of a priority before I know whether the code even works.
>>>
>>
>> It's a useful way.
>> Uncore PMU is increasing. Not only CPU event can be writen in jevents.
>> I have not considered it when writing code in a low version.
>>
>> Finally, I have opened a case in arm suppport for linux ni pmu driver.
>> They tell me no driver.
> 
> Oh dear, sorry about that - I'd have hoped that a question about a Linux 
> PMU driver might have found its way to our team, even if they weren't 
> aware that NI-700 has already been a specific item on our roadmap for 
> some time :(
> 
> Thanks,
> Robin.
> 

I have run the code and thanks to the support of shenghui.qu@shingroup.cn.
It's sorry for the late.

