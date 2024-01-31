Return-Path: <linux-kernel+bounces-46199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E78843C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B666CB281EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A64E69977;
	Wed, 31 Jan 2024 10:18:38 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586386775E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696318; cv=none; b=D6M0H5gMN7TkcSbVTbA4d3M7oJA8zaSZHgx70aMoLJLS5M92qIakiwHkzat6xrdWJu92PeZCyhfZY2x/ACDQabVlFg7QXFC0VW8ADrUXb3Es0a6+xDTC3DzKUSGrlaQQZoUeGEjRwbX58mxT9EJFjRT93yGX2g2jbxtcxxQ0yoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696318; c=relaxed/simple;
	bh=ykZfkKoX7TOjRuI9YLjTyIXMIdhpZDwu6WP2/XZu0fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpA290pNwLQQ2FTRIxEd7OZP8FCdTAm4QSp0GEd1SjNYODyzFsX2bqDRgiU9NpcVYn/a0NhD8jLiLhUDTvSMKHSISiwMU+oHkDbYgN3JrCitybbt47YL+xKeUE1tU7HFS3GP1fxEx52baIubo+iYr5jFiWulphHl5bcEo1LnPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp70t1706696289tk9l24wz
X-QQ-Originating-IP: Ktt9i8CN95Xfql4e+hRGz/fWFMloBH13l1Px5P2wytg=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 18:18:07 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: 90EFqYDyPxCbs1f2TU2Vi8g7zUPEIDXMypu2mV8mS9KG91ynL9zStuL4gly0L
	7VSBIR7F1GHe5CujByBVBu002e9hsIParfK+kjF+1JB+oXZmy2/9VFXvfZCXuP4cLBfy6tL
	Lj4T6x9lEwR/mWDzLooumM2fet1y2am75xHY9ia6squ5x6cVvkIDiCU3QkEA74B54A9dxDN
	YA3fIh5TfShI/U/hbGmJeBtngGKB5eh9h04AUvcoHOzMzjL1h8YKYIKcV3rS2nqx6sO7L1a
	XGfHd2RvqNrPuUyUAGLAIEDUUXZOwvvlW2v3tUJjKaNei9mUBxJINPAaYX/X9nwnvu+Yji8
	5JT8lN3rXkJnsUewyPzrjSFROCk3LgGgKdMAlib8Q5+CCQtoKvQNfCz8B8G5AVIkhspiYkO
	yPcTKCISPEnynTvH4OamBwvdNfYe2TcpIF7cGJkdomA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6162895536767829948
Message-ID: <EC1445AF2C5DB6F4+64772ecd-5e7a-42bb-aaa8-bc2857b2ab8b@shingroup.cn>
Date: Wed, 31 Jan 2024 18:18:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bingdings: perf: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 will <will@kernel.org>, "mark.rutland" <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, =?UTF-8?B?6LW15Y+v?= <ke.zhao@shingroup.cn>,
 zhijie.ren@shingroup.cn, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20240131065953.9634-1-jialong.yang@shingroup.cn>
 <e7bf16fc-b12d-47eb-9197-0694e6829ac8@linaro.org>
 <02B995F774AB7A9D+adfd0934-00cb-4dc3-8bf8-058b83dc2fbb@shingroup.cn>
 <ebbc9d73-9be2-49ae-98f3-0d71ce624ee4@linaro.org>
 <873A6CC450C1D0E6+75a39d6c-4fbf-4e30-8630-3226bd725901@shingroup.cn>
 <b99efbd4-7c12-485d-8688-a4ec606f0cf5@linaro.org>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <b99efbd4-7c12-485d-8688-a4ec606f0cf5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/1/31 18:16, Krzysztof Kozlowski 写道:
> On 31/01/2024 11:13, Yang Jialong 杨佳龙 wrote:
>>
>>
>> 在 2024/1/31 17:30, Krzysztof Kozlowski 写道:
>>> On 31/01/2024 10:26, Yang Jialong 杨佳龙 wrote:
>>>>
>>>>
>>>> 在 2024/1/31 15:49, Krzysztof Kozlowski 写道:
>>>>> On 31/01/2024 07:59, JiaLong.Yang wrote:
>>>>>> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU driver
>>>>>> for HX.
>>>>>>
>>>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>>>> ---
>>>>>> v1 --> v2:
>>>>>> 1. Submit dt-bindings file Seperately.
>>>>>
>>>>> Where is the driver?
>>>>>
>>>>> Please read:
>>>>> https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/submitting-patches.rst
>>>>> before posting.
>>>>>
>>>
>>> Keep all discussions public.
>>
>> Get.
>>
>>>
>>>
>>>>>> +  pccs-id:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description: Used to identify NIs in system which has more than
>>>>>> +      one NI.
>>>>>
>>>>> No, reg does it. Drop the property. Anyway you miss here vendor prefix
>>>>> and proper explanation.
>>>>>
>>>>
>>>> reg will tell phy address. Phy address is too long. I just want a id.
>>>> example: perf stat -a -e ni_pmu_${pccs-id}/cycles/
>>>> I will use it in user space. Not only in driver.
>>>
>>> Custom vendor property is not for that purpose. Use for example IDR, DT
>>> aliases or something else.
>>>
>>>
>>
>> I have considered TD aliases. It's not very easy. Two places...
>> IDR.. I have tested. But it chouldn't correspond to the HWs.
>> I need it to identify NIs.
>> DT aliases is reachable. But no very easy.
> 
> Except that "you want" I did not see any rationale, any argument
> explaining why this is needed and why this has to be present.

OK. DT aliases it good.

> 
> Best regards,
> Krzysztof
> 
> 


