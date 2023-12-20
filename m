Return-Path: <linux-kernel+bounces-6739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382F819CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D021A283BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE5200D3;
	Wed, 20 Dec 2023 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgyhDWqM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B0208A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c236624edso60062595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703067984; x=1703672784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pX13GgiaquuyyTjBBvzGeBqVX5oA1abtoRS201+TY+I=;
        b=FgyhDWqMh2A5tOoetgX8IwN3N4kNj8hbWkDn166Wn2nr3pHye+XND6FBRIDxDdwYbe
         0B097nAo6NWu/L5u2MK1oHaBVG8BxasupuCVdsUbCo5uHI7E6MVQ0SZwAh5B6/q4YSu/
         E210BnHtTs0wRJ9HiEytUFN2/GObwTrQQZBsQNfEPyMqVWtDOx8YGFjSqpY64Rwpp6eb
         FiOiel+Y5+1wRZUHlU1RKagB8i8ayzYgWWbyQdxTWh2yEbTlgiCULEFGup8F0OsTDJM7
         qoZ2E0e7sVgC1E5o26f9+mvW8CeyACW8raxdRRdwKOnKbWD+7J0+BS0NxeGHyqzgG1Di
         Uu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067984; x=1703672784;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX13GgiaquuyyTjBBvzGeBqVX5oA1abtoRS201+TY+I=;
        b=XZlm4Gu3CfKUUuon4fojsU1zm+BzEb35GvBzVm9YrJjDde4VrVm3XOMvC1JurAlUC1
         RMx9Ekq0EPtEzpaOAt6MHu7w4RbjWRzoSaV/pAnNYKnW3GeSHtlNT1sIOznT3XzLXwiZ
         8LSa0aB4QuJ9uedcHrT/DBMl0cWhUDyor/7Q5KcnMNF+ExLkdTD7IB/FpF7CMg8hrns/
         J+CNfluiV9LpPp97R3JWM9dc6WfTcarT8bGUkAPJhiIuXkXACvl/5hRCcfeMSURt9Iha
         4YLbwxK7OSYIrE5DUFoY2gbkvtgqoZjw6Qf5H0xCsFSACcuc6pAVB+BV8Q8dnA04YhNd
         c5Zg==
X-Gm-Message-State: AOJu0YzFetxXDx7rOyEcudREwsmsXgB3kxTO02yNfvOHOhRoSJ8Go/c5
	MqWghi6szGsSErIOHjBg+CLQdw==
X-Google-Smtp-Source: AGHT+IGwzJptxKxqWiAXYwXjXS5wabIdldCCRy6C5+KcotZFMsF7zVkbDvihSsOAJNGR83Mr4ItmLg==
X-Received: by 2002:a05:600c:4d0e:b0:40b:4476:cd31 with SMTP id u14-20020a05600c4d0e00b0040b4476cd31mr9706552wmp.13.1703067983796;
        Wed, 20 Dec 2023 02:26:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b0040b4fca8620sm6763964wmo.37.2023.12.20.02.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 02:26:23 -0800 (PST)
Message-ID: <a78c5ce7-bc89-44ad-8c8a-7c17ed8a7995@linaro.org>
Date: Wed, 20 Dec 2023 11:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
 <20231218-mbly-pinctrl-v1-1-2f7d366c2051@bootlin.com>
 <0f0c0d16-f736-419e-9ffc-c3dc507b815c@linaro.org>
 <CXT1TYH16JPB.2RY1IKI8NAUNE@bootlin.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CXT1TYH16JPB.2RY1IKI8NAUNE@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2023 10:21, Théo Lebrun wrote:
> Hello,
> 
> I've seen all your comments, thanks for that. I'll answer to some.
> 
> On Tue Dec 19, 2023 at 8:34 AM CET, Krzysztof Kozlowski wrote:
>> On 18/12/2023 18:19, Théo Lebrun wrote:
>>> Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 125 +++++++++++++++++++++
>>>  MAINTAINERS                                        |   1 +
>>>  2 files changed, 126 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..5faddebe2413
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
>>> @@ -0,0 +1,125 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mobileye EyeQ5 pinctrl (pinmux & pinconf) controller
>>
>> pinctrl means pin controller, so you basically wrote:
>> pin controller pinmux and pin configuration controller
>>
>> Just "pin controller"
>>
>>
>>> +
>>> +description:
>>> +  The EyeQ5 pin controller handles a pin bank. It is custom to this platform,
>>
>> Can part of SoC be not custom to given platform? I mean... describe the
>> hardware, not write essay.
>>
>>> +  its registers live in a shared region called OLB.
>>> +  There are two pin banks on the platform, each having a specific compatible.
>>
>> Instead of repeating something obvious - visible from the binding -
>> explain why. Say something different than the binding is saying.
>>
>>
>>> +  Pins and groups are bijective.
>>> +
>>> +maintainers:
>>> +  - Grégory Clement <gregory.clement@bootlin.com>
>>> +  - Théo Lebrun <theo.lebrun@bootlin.com>
>>> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^pinctrl([0-9]+)?$"
>>> +    description:
>>> +      We have no unique address, we rely on OLB; we therefore can't keep the
>>> +      standard pattern and cannot inherit from pinctrl.yaml.
>>
>> No, instead fix pinctrl.yaml
> 
> I've tried some things, but I'm unsure how to proceed. Options I see:
> 
>  - Modify pinctrl.yaml so that if reg/ranges is required, $nodename must
>    be the current value ("^(pinctrl|pinmux)(@[0-9a-f]+)?$"). Else,
>    $nodename should be "^(pinctrl|pinmux)(-[0-9a-f]+)?$".

Yes, but: "-[0-9]", these are not hex.

I don't understand what is the problem here. It's just a regex and there
are plenty of examples how this should look like.

> 
>    I've tried some things but nothing conclusive for the moment.
> 
>  - Leave pinctrl.yaml alone and override $nodename from our binding.
>    I've not found a way to do that though.
> 
>  - Use the current $nodename, ie with a unit address. With that approach
>    I get the "node has a unit name, but no reg or ranges property"
>    warning which, reading the code, I don't see a way of avoiding.
> 
> Were you thinking about option 1? Any advice on how to proceed would be
> helpful, I've not been able to get a working patch to use option 1.

Why?

> 
>>
>>> +
>>> +  compatible:
>>> +    enum:
>>> +      - mobileye,eyeq5-a-pinctrl
>>> +      - mobileye,eyeq5-b-pinctrl
>>
>> Why two compatibles? Description provided no rationale for this.
> 
> I'll add that info. The gist of it is to have one node per bank. Each
> pin has two function: GPIO or pin-dependent. So we must know which bank
> we are to know what each pin function can be.

OK

> 
> Both nodes are child to the same OLB. The compatible also tells us which
> registers to use.
> 
>>
>>> +
>>> +  "#pinctrl-cells":
>>> +    const: 1
>>> +
>>> +  mobileye,olb:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      A phandle to the OLB syscon. This is a fallback to using the parent as
>>> +      syscon node.
>>
>> So here is the explanation for missing unit address. If all registers,
>> as you claim in description, belong to OLB, then this should be part of
>> OLB. Drop the phandle.
> 
> The reason I provided both options was that I see four drivers that do
> this kind of fallback. I guess it was for legacy reasons. I'm dropping
> the phandle and keeping only the child option.
> 
> 	drivers/gpio/gpio-syscon.c
> 	drivers/phy/rockchip/phy-rockchip-usb.c
> 	drivers/phy/samsung/phy-exynos-dp-video.c
> 	drivers/soc/rockchip/io-domain.c
> 


Best regards,
Krzysztof


