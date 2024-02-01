Return-Path: <linux-kernel+bounces-47540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3A844F25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F13A1F2AA8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B31A29F;
	Thu,  1 Feb 2024 02:25:16 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C90210E0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754316; cv=none; b=sV3MiTJ8j1O8T5eTPpQ7jVg38HPpQU40N3r6yzgKvMQk6E9xLBkIBY5JjCpfU/G/dTLSbbjAgmih9Slbf1auBqQZI56CJuQAPnGSKn/P8mPXC/wpqN4jKAYWu8Ja740hbJHeJ+TwXC+QgNF5w1H9UBdrJSxkNokziqAlkcZFG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754316; c=relaxed/simple;
	bh=+vXisyTED3oYjSB3fpGPEFDtkBLUsa77LAHwLPrG0y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbcMaHDf9nK93AoefkCKeHww79T+bcYHBUuPbTjNVDVCZ7oSMOcGAkuKQX2QmfhTm7Ynr16/HOWmceelvn6+5ZThSj8qjo9MDtYFMsBtOm+rMKaN7rlK75hj/2uLuyAbrDAoiXMlqmPoYOsBFPYmVP+nxqFCvq935byNxb6hEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp75t1706754277tdnhvipn
X-QQ-Originating-IP: kbaL+n5H+N5CjyyZxgbzU94/3JnTA9cqlLwUkW78w1g=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Feb 2024 10:24:35 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: lm7sZZPcOdbLaBr9ejGiuJs25GZF8B5iemLB1NJcutsEeAisshX7xVdH2h/Lu
	/UpGw+iooGoYuuitGGU7W/Qqwam/v1MYsjqpzhOkiy20kDsw01DQGI8M2TVTsyROYvkIWMi
	/W/04hfBeofCwCI/bOS86BJkHE8QcSzW2aIbqlHovpSnv5yIjgnMGEpEW9LdXWDrW/p6Aal
	r06TPBG9sNtIwRvXUecpDPXh7SDwW0kQ3V1Ltcs9ug3OyQm/1HM4zUHVdr4YHYyXH+pw+Z5
	2PSJIRslnAHuTvdKzMGCVr3Y2D9NjxAufDhMwxQ525qoO1sXB5Ncy4ox+rKrLUmco8FoIW3
	oRJpmbHxq2kIr+Z3NrNuqMH0t1pL7VgV7mVUHiq7Xk6CEP+ckwZET5aRLBDCHbQvd3nTBTP
	o736OylHaHk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14490681971206590225
Message-ID: <D520CF9C25E9CB81+46dd0dde-cfea-4606-a227-45892ca762ac@shingroup.cn>
Date: Thu, 1 Feb 2024 10:24:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bingdings: perf: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, will
 <will@kernel.org>, "mark.rutland" <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, =?UTF-8?B?6LW15Y+v?= <ke.zhao@shingroup.cn>,
 zhijie.ren@shingroup.cn, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20240131065953.9634-1-jialong.yang@shingroup.cn>
 <e7bf16fc-b12d-47eb-9197-0694e6829ac8@linaro.org>
 <02B995F774AB7A9D+adfd0934-00cb-4dc3-8bf8-058b83dc2fbb@shingroup.cn>
 <ebbc9d73-9be2-49ae-98f3-0d71ce624ee4@linaro.org>
 <873A6CC450C1D0E6+75a39d6c-4fbf-4e30-8630-3226bd725901@shingroup.cn>
 <b99efbd4-7c12-485d-8688-a4ec606f0cf5@linaro.org>
 <EC1445AF2C5DB6F4+64772ecd-5e7a-42bb-aaa8-bc2857b2ab8b@shingroup.cn>
 <c68f8b00-c5df-45e1-b75a-f86ce128ddf0@arm.com>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <c68f8b00-c5df-45e1-b75a-f86ce128ddf0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/2/1 0:59, Robin Murphy 写道:
> On 31/01/2024 10:18 am, Yang Jialong 杨佳龙 wrote:
>>
>>
>> 在 2024/1/31 18:16, Krzysztof Kozlowski 写道:
>>> On 31/01/2024 11:13, Yang Jialong 杨佳龙 wrote:
>>>>
>>>>
>>>> 在 2024/1/31 17:30, Krzysztof Kozlowski 写道:
>>>>> On 31/01/2024 10:26, Yang Jialong 杨佳龙 wrote:
>>>>>>
>>>>>>
>>>>>> 在 2024/1/31 15:49, Krzysztof Kozlowski 写道:
>>>>>>> On 31/01/2024 07:59, JiaLong.Yang wrote:
>>>>>>>> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU 
>>>>>>>> driver
>>>>>>>> for HX.
>>>>>>>>
>>>>>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>>>>>> ---
>>>>>>>> v1 --> v2:
>>>>>>>> 1. Submit dt-bindings file Seperately.
>>>>>>>
>>>>>>> Where is the driver?
>>>>>>>
>>>>>>> Please read:
>>>>>>> https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/submitting-patches.rst
>>>>>>> before posting.
>>>>>>>
>>>>>
>>>>> Keep all discussions public.
>>>>
>>>> Get.
>>>>
>>>>>
>>>>>
>>>>>>>> +  pccs-id:
>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>> +    description: Used to identify NIs in system which has more 
>>>>>>>> than
>>>>>>>> +      one NI.
>>>>>>>
>>>>>>> No, reg does it. Drop the property. Anyway you miss here vendor 
>>>>>>> prefix
>>>>>>> and proper explanation.
>>>>>>>
>>>>>>
>>>>>> reg will tell phy address. Phy address is too long. I just want a id.
>>>>>> example: perf stat -a -e ni_pmu_${pccs-id}/cycles/
>>>>>> I will use it in user space. Not only in driver.
>>>>>
>>>>> Custom vendor property is not for that purpose. Use for example 
>>>>> IDR, DT
>>>>> aliases or something else.
>>>>>
>>>>>
>>>>
>>>> I have considered TD aliases. It's not very easy. Two places...
>>>> IDR.. I have tested. But it chouldn't correspond to the HWs.
>>>> I need it to identify NIs.
>>>> DT aliases is reachable. But no very easy.
>>>
>>> Except that "you want" I did not see any rationale, any argument
>>> explaining why this is needed and why this has to be present.
>>
>> OK. DT aliases it good.
> 
> The real way to address that particular issue is to fix perf to properly 
> associate the PMU device with the underlying hardware device. Jonathan 
> had a series doing that[1], but I'm not sure what its status is now.
> 

Good news.
In NI, we have to consider NIs and PMUs in one NI.

> Thanks,
> Robin.
> 
> [1] 
> https://lore.kernel.org/linux-arm-kernel/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
> 


