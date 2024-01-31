Return-Path: <linux-kernel+bounces-46851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AD84456B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD01C20983
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA05F12BF1C;
	Wed, 31 Jan 2024 16:59:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449512AAD1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720351; cv=none; b=rLIzunYYnhh/QgvHmSSkK2yC3BR/nlBdhqVgA2OyHDknH0/WAAcy8IsGHOboCML7qD+/JTQE+klEz4V3wyPlZh0RrEv/zUO0MYmLTg4xbzngCXu51wXjattSzxzwqLlCZep2gv3L6YChrz0la/pwA2DjRzK0nDfCkHTkSkTsMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720351; c=relaxed/simple;
	bh=GjVWMfDZ6tvNQI5J0g8k01qf+gu5mZITKfSXLDmab8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndr4Mj5DsFaGTLJunxJbNjaCa/dEDehtu4paa64hf+YQyNI10dgkLTiHRF1zdrC30fUBuaXa0ZNfItDzN6wJua5vbh7q//cWkKr7mVZ92JNmjaVrVx5J+E5jFzw21SVQ6OSIY79x4G2HK3gFMiZz/U3JtN9BS0TxIfUC6v8of94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 098CFDA7;
	Wed, 31 Jan 2024 08:59:52 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 886B13F762;
	Wed, 31 Jan 2024 08:59:07 -0800 (PST)
Message-ID: <c68f8b00-c5df-45e1-b75a-f86ce128ddf0@arm.com>
Date: Wed, 31 Jan 2024 16:59:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bingdings: perf: Support uncore ARM NI-700 PMU
Content-Language: en-GB
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <EC1445AF2C5DB6F4+64772ecd-5e7a-42bb-aaa8-bc2857b2ab8b@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 10:18 am, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/1/31 18:16, Krzysztof Kozlowski 写道:
>> On 31/01/2024 11:13, Yang Jialong 杨佳龙 wrote:
>>>
>>>
>>> 在 2024/1/31 17:30, Krzysztof Kozlowski 写道:
>>>> On 31/01/2024 10:26, Yang Jialong 杨佳龙 wrote:
>>>>>
>>>>>
>>>>> 在 2024/1/31 15:49, Krzysztof Kozlowski 写道:
>>>>>> On 31/01/2024 07:59, JiaLong.Yang wrote:
>>>>>>> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU 
>>>>>>> driver
>>>>>>> for HX.
>>>>>>>
>>>>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>>>>> ---
>>>>>>> v1 --> v2:
>>>>>>> 1. Submit dt-bindings file Seperately.
>>>>>>
>>>>>> Where is the driver?
>>>>>>
>>>>>> Please read:
>>>>>> https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/submitting-patches.rst
>>>>>> before posting.
>>>>>>
>>>>
>>>> Keep all discussions public.
>>>
>>> Get.
>>>
>>>>
>>>>
>>>>>>> +  pccs-id:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    description: Used to identify NIs in system which has more than
>>>>>>> +      one NI.
>>>>>>
>>>>>> No, reg does it. Drop the property. Anyway you miss here vendor 
>>>>>> prefix
>>>>>> and proper explanation.
>>>>>>
>>>>>
>>>>> reg will tell phy address. Phy address is too long. I just want a id.
>>>>> example: perf stat -a -e ni_pmu_${pccs-id}/cycles/
>>>>> I will use it in user space. Not only in driver.
>>>>
>>>> Custom vendor property is not for that purpose. Use for example IDR, DT
>>>> aliases or something else.
>>>>
>>>>
>>>
>>> I have considered TD aliases. It's not very easy. Two places...
>>> IDR.. I have tested. But it chouldn't correspond to the HWs.
>>> I need it to identify NIs.
>>> DT aliases is reachable. But no very easy.
>>
>> Except that "you want" I did not see any rationale, any argument
>> explaining why this is needed and why this has to be present.
> 
> OK. DT aliases it good.

The real way to address that particular issue is to fix perf to properly 
associate the PMU device with the underlying hardware device. Jonathan 
had a series doing that[1], but I'm not sure what its status is now.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/20230404134225.13408-1-Jonathan.Cameron@huawei.com/

