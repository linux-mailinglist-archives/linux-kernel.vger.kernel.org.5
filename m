Return-Path: <linux-kernel+bounces-45922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FEC8437E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5245C28BCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A95102A;
	Wed, 31 Jan 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wx40emW4"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502A63129
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686036; cv=none; b=arw+AwRqPS/Pxhd3aOjaLOKngY+vMuwbQzoRb4A3pJx5Pr8YYHNipHKAj7hJh/alje9PLv6fnyVbYyA56EWTb5Fl0Kov0H6P6ASmqW3d4A74KKUAsSbkZHVqZuB9EjBlF1Wc+0eKXpJGfic3roLsGQW5E39PQM7+OMD5985WEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686036; c=relaxed/simple;
	bh=4r2VDZfFGwt2TTeImZzea4pC30mwij73r5f8doCrvkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLCmMmYMCCf4IY8/CWFPeJ3OTJLENq/X4DoH32k6+5jgSSZBicqPEkEu0taUh7uNRru6w3d99llYajugQp+fvWQBuTHsHn4UZpFLNEOJAgOxzvZXpEY475L3OGHiAlXXrFMA2UfuuDXVdcpG0aoe4NPk7u4UXO8Ctj1J5sGwW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wx40emW4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a366ad7ad45so47730566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686032; x=1707290832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pm3kKI1Sjq8pVVBtzibCw9/o9Mb+bK9ayp3QQ82I1U8=;
        b=wx40emW4vi4tqU/IL29PK+86/gmoDKa9DtRfWouuOZDYrsK4qTa9OW6Ob4qj5ydQYx
         YjIET8lIVwLAJvlKVsYw2scLwi0g8+aPw0hJFhh7zVhSFDITLg2ehlNWLWdYj08rk03e
         CFxrYqG/ojG/Adxg2/YLHbEHJ2Q6/FcrumxevF/LYBedMadQ5Y6hIbOT3mxl7NSf0QHS
         KGTXnAQWp157Tw8Jf6sUp8CRRP2UPh2UuesCKp3uDKDVlDoxIdCzataxjDJOP5fsiXjJ
         P49vJKsO2y/Ld2Y9lBd55mWZSqGFURHwf4F2PebPok5h9PoB2ukayDnrnREV7ApL80uK
         1m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686032; x=1707290832;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pm3kKI1Sjq8pVVBtzibCw9/o9Mb+bK9ayp3QQ82I1U8=;
        b=pyiMqeL32cBsD25ApxoKw3BKlHKpg6bB1xN7kx2NzywwhixZxBXd0xuSBzgxYBFOnZ
         aECkOgqn1PQ0SYlFZuq5TM6oCNFl9b3/1mBPWtoxtWO0K8GOZgZ/bsKttAStoSR+PuRp
         xhLmqatfiX3Rpj0h4hRjq3S0Oo7uCqWsdh6QQiT3LDQQVcUGeeXixZvTq4QzO/8FV6rm
         hNg4nPlcHR9h6pRaDsMh71gnegT5HCM7KthxCKzezsisIk2nWvGeyEVij3Mk4KxoKoXS
         sWDzhapunja9gJ55LiPqNarN6EqKvHjDqEUySl8e//MuqHDe0QgsDSVD8TqovrplVab9
         7zSw==
X-Gm-Message-State: AOJu0YxKkNld0LvRNFOqWB57aiW07qQ6FGWV8gGBfB27zlQrVBuUN2g/
	ADp3us3yn5aSokEm8olv2iwFPDTQsNF7uj/n4aOeK8x7Fa94kZpMWh8WVrNebQ60hI2idKdloCZ
	F
X-Google-Smtp-Source: AGHT+IGSELlGwD4uzQI2Obj7qkrsxkWcraACyjqhqU1mMJRiBIIw4eJXerIK15q8EYD705R2qH4I3g==
X-Received: by 2002:a17:906:d88:b0:a35:46d8:53ce with SMTP id m8-20020a1709060d8800b00a3546d853cemr513492eji.18.1706686032324;
        Tue, 30 Jan 2024 23:27:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIlXK0nQwSTdsliIRtBAJpdPGANTG3I2zYOH821Bh+E8njShjnP/O1jltbcAnzEBY8BZULQnhOIf2wD5U43mSSHGDl+glDsxKGQM8ZZWUGqcbWoWrZEKyXIHxjULLCQL32KyouYvPkHfZ6g1ZQU5FUSdQO+XTquDqKHvcfQMSOFrgmShYKphyN73NmzV2H8j+UrkMopHgQ5ok0iqj4y/fcWlSLW5kRJmfcGZkzyaxm0lOZiLO57BxQyXukMLxhtdsxQtiUmWIJM6E8OZmCG/r3cM2CBUEG/n2NEOobSqDzGHipISnF0+8IRagjpsOUAar7putgvlYuLhExP54OyImjXvPnc9Yq5SPYxJrW1fnKAYWQy/kTpJKdhwK2bYexp/kSB5aee8KbEX/sMF56J9P5PtBecbLJgsWAFZSGcYoKY4U=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a3682ad6354sm143169ejc.41.2024.01.30.23.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:27:11 -0800 (PST)
Message-ID: <b25ad717-8dc7-47ba-89c7-48ac5ea2ff95@linaro.org>
Date: Wed, 31 Jan 2024 08:27:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130081745.13750-1-jialong.yang@shingroup.cn>
 <40fe84af-1208-4aa4-b97a-368787a2c443@linaro.org>
 <279DAED08550A69A+3d025259-f011-4312-946d-6f7564a12898@shingroup.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <279DAED08550A69A+3d025259-f011-4312-946d-6f7564a12898@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 03:57, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/1/30 16:43, Krzysztof Kozlowski 写道:
>> On 30/01/2024 09:17, JiaLong.Yang wrote:
>>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>>> One ni-700 can have many clock domains. Each of them has only one PMU.
>>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>>> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
>>> be ni_pmu_N.
>>> Node interface event name will be xxni_N_eventname, such as asni_0_rdreq_any.
>>> There are many kinds of type of nodes in one clock domain. Also means that
>>> there are many kinds of that in one PMU. So we distinguish them by xxni string.
>>> Besides, maybe there are many nodes have same type. So we have number N in
>>> event name.
>>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>>> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>>
>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>> ---
>>> If I should send Doc*/bindings/perf/*.yaml seperately?
>>
>> Checkpatch tells you that, doesn't it?
> OK. I will send it seperately.
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
> OK.
>>
>>>
>>>   .../bindings/perf/hx,c2000-arm-ni.yaml        |   58 +
>>>   .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>>>   MAINTAINERS                                   |    6 +
>>>   drivers/perf/Kconfig                          |   10 +
>>>   drivers/perf/Makefile                         |    1 +
>>>   drivers/perf/hx_arm_ni.c                      | 1308 +++++++++++++++++
>>>   6 files changed, 1385 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>>>   create mode 100644 drivers/perf/hx_arm_ni.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>>> new file mode 100644
>>> index 000000000000..1b145ecbfa83
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>>> @@ -0,0 +1,58 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/perf/hx,c2000-arm-ni.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: HX-C2000 NI (Network-on_chip Interconnect) Performance Monitors
>>> +
>>> +maintainers:
>>> +  - Jialong Yang <jialong.yang@shingroup.cn>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - hx,c2000-arm-ni
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Physical address of the base (PERIPHBASE) and
>>> +          size of the whole NI configuration address space.
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>
>> Why?
> According to hw, one PMU has one interrupt line. So one NI maybe has 
> more than one. But actually it depends on hw implementation.
> And in C code, I will return error when there is no interrupt.

Different HW implementation would have different compatible, which is
not the case here. Your binding says there is only one implementation,
so how the same implementation can have different number of interrupts?

No, that does not look right.

>>
>>> +    items:
>>> +      - description: Overflow interrupt for clock domain 0
>>> +      - description: Overflow interrupt for clock domain 1
>>> +      - description: Overflow interrupt for clock domain 2
>>> +    description: Generally, one interrupt line for one PMU. But this also
>>> +      support one interrupt line for a NI if merged.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: hx,c2000-arm-ni
>>
>> Drop entire if. What is the point of it?
> This attribute is used to identify different NI in my company's product.
> But even if I don't give this attribute, nothing will be wrong in code.

What is the attribute? I don't understand.

> However if I do that, I will couldn't know the relation between sysfs 
> file and hardware NI.

sysfs does not matter for the bindings.

> 
> I will drop it. It will be as a normal way to identify NIs manually.
> If there is only one NI and not give pccs-id, no thing wrong will happen.

Your if just does not make sense. It's no-op.

>>
>>> +then:
>>> +  required:
>>> +    - pccs-id

No, move it to required properties.

..

>>> +static int ni_pmu_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret, cd_num, idx, irq_num, irq_idx;
>>> +	void __iomem *periphbase;
>>> +	struct global_ni *ni;
>>> +	struct device *dev = &pdev->dev;
>>> +	char *name;
>>> +	static int id;
>>> +	struct ni_pmu *ni_pmu;
>>> +
>>> +	BUILD_BUG_ON(sizeof(long) == 4);
>>
>> I am sorry, but what?
> I only want to ensure 64 bit environment. Maybe there are many other way.
> I will ensure that in Kconfig.

Kconfig, but then NAK. Your code must be buildable everywhere. This is
not 1990-ties.


Best regards,
Krzysztof


