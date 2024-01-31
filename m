Return-Path: <linux-kernel+bounces-46190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92494843BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B77291B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D176EB65;
	Wed, 31 Jan 2024 10:15:16 +0000 (UTC)
Received: from smtp-usa2.onexmail.com (smtp-usa2.onexmail.com [35.173.142.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967B67A1A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.173.142.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696115; cv=none; b=nCjWB4/oMdwSeCklziSxW0D+VWVXWupOf5FMh/N+6SLqGrgG7tsbG9abXsFbidKLazIdeU8odZNW79uXtKfVN8XcR4oREedQpqS6U4bbLOUs8xA4kS4M6qQBjItoTSiZiLRbD+i/4n4+VeXxfF7UCKZmHpm/pZ6yxJ4X07lMiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696115; c=relaxed/simple;
	bh=ZuWksKgnPM9/EWhlJv2cLdjkzV9aP2Lu1YDdFIBiB5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=R27OHLKJT6WHTPsCh5GqM1uEueKPcmm4QGTmXKo+Y7CInVszrjPnY0J8RL/nv/jK2TZJNrMbfrbqTgVJRjEFSA52wvfpqQF4uD+Nhbn8J0/G9P7XB78jiCbd2vWnlaXPooV59zaFVLx2wGbtO+ANCu3nWnBqYD1ZCu5xaseNU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=35.173.142.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1706696038tzjfyvc9
X-QQ-Originating-IP: w6fWcWkYW85Jx9G2KRORDfxUpSZUN3GLMCfJXorQyMo=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 18:13:56 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: q+yjhizk/eIChGURKByS0HZJ5DLwCq/zOioB8VPfJzjmPhYS+gSHo5KokRlsh
	AoRTAXo8UeZop9qatigjClT5Ig2Ja9dwLnwb0y0XMLPbCMT4wRZmHM/XTlCrR0uVMBmH2nq
	j+qutgTS31cXFG1+S07ypa523XPA1F9HwNYrBqHzkBK9aAOWFQSiSaYO6BSs51l5npksKBW
	ckEXbpgP7Pf8QYfoiH/UsLIsCgeDw/i6eV8tBaqNDk3y5HgOOdvKP65fokFBm0VpYyyUj38
	seQAGchhxdgQKCKKcqJKC8p7konPTPuZr7dGsfPb2JAqbTuZ0IUaze3MUhZ5FglWVXKFc8s
	KEq5Zxwd0umInhrRPdl7E8+m4WIzPMuF6T2Fqij849SmH2fW26FVLP6F61g3gXKchgYz/qT
	/PlVLpXSKe708U74fFlSelJcQ45JxDmA
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16532494125759251601
Message-ID: <873A6CC450C1D0E6+75a39d6c-4fbf-4e30-8630-3226bd725901@shingroup.cn>
Date: Wed, 31 Jan 2024 18:13:56 +0800
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
References: <20240131065953.9634-1-jialong.yang@shingroup.cn>
 <e7bf16fc-b12d-47eb-9197-0694e6829ac8@linaro.org>
 <02B995F774AB7A9D+adfd0934-00cb-4dc3-8bf8-058b83dc2fbb@shingroup.cn>
 <ebbc9d73-9be2-49ae-98f3-0d71ce624ee4@linaro.org>
Cc: shenghui.qu@shingroup.cn, =?UTF-8?B?6LW15Y+v?= <ke.zhao@shingroup.cn>,
 zhijie.ren@shingroup.cn, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <ebbc9d73-9be2-49ae-98f3-0d71ce624ee4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/1/31 17:30, Krzysztof Kozlowski 写道:
> On 31/01/2024 10:26, Yang Jialong 杨佳龙 wrote:
>>
>>
>> 在 2024/1/31 15:49, Krzysztof Kozlowski 写道:
>>> On 31/01/2024 07:59, JiaLong.Yang wrote:
>>>> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU driver
>>>> for HX.
>>>>
>>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>>> ---
>>>> v1 --> v2:
>>>> 1. Submit dt-bindings file Seperately.
>>>
>>> Where is the driver?
>>>
>>> Please read:
>>> https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/submitting-patches.rst
>>> before posting.
>>>
> 
> Keep all discussions public.

Get.

> 
> 
>>>> +  pccs-id:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: Used to identify NIs in system which has more than
>>>> +      one NI.
>>>
>>> No, reg does it. Drop the property. Anyway you miss here vendor prefix
>>> and proper explanation.
>>>
>>
>> reg will tell phy address. Phy address is too long. I just want a id.
>> example: perf stat -a -e ni_pmu_${pccs-id}/cycles/
>> I will use it in user space. Not only in driver.
> 
> Custom vendor property is not for that purpose. Use for example IDR, DT
> aliases or something else.
> 
> 

I have considered TD aliases. It's not very easy. Two places...
IDR.. I have tested. But it chouldn't correspond to the HWs.
I need it to identify NIs.
DT aliases is reachable. But no very easy.

>>>
> 
> Best regards,
> Krzysztof
> 
> 


