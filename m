Return-Path: <linux-kernel+bounces-16431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF4823E79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42091287405
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF820327;
	Thu,  4 Jan 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qt9KogoX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6B2031E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so392549a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704360067; x=1704964867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XEANleywHF7ij0aJmeMmRVUrjKcFO/lSqViFXf/Gds=;
        b=Qt9KogoX6OoG41AatNB1ubNjrrjg+5Sg+mVk+vjEimhJLF+C1RA7PCIYB4LHcLwnIF
         cLQGYs+L10UnKzNyN3IHQc0ldabjtpSXVF2M5t7HqJ2fQa0v7p7jgD85RnrVdOSX3bz0
         4TjpuZCcAtoMAZZ4WYysoDyAamk6nVzBfDk+Oev/pPP2DKuUwyAq2KvnHOwcqqJifjYY
         CWnaWCnN17/8iiMb3a/J6EAp3Ywc88RgHSfnzeXfO8QII93q8sWmwh+BFRBw6seA0Zad
         DxCOMUci85/O0SAn+mBZE6GbcxATRliXbXR+yJOxQzMWvvctWIZspxpRhWGd/DBtPhkY
         gAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360067; x=1704964867;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XEANleywHF7ij0aJmeMmRVUrjKcFO/lSqViFXf/Gds=;
        b=PsSagayvKk9R/7FDjnMFoKl7kNbtqm9KnNNdQWD6AeO22XUgZ5hxEfYoUHT4v8nyFe
         7Ni5mFZUik9tOUNGWOKNfnGZ2wcrg6WvwWxEpe2Fwjwr+Z3ezmcv0CoOsUen0JCLCfC1
         71YRqrI9bysheVWkNkpTZVIXkgx/K0G5j8uo34elw7XGXJ6xahVa9+c6am4inCKmmjgd
         V/Sq7gH5F/AiYYgQvROE06+SiEfh/A7l3wQTk/nTE3iTgHLuNQ6VfJwLMccTjCqUEZ+y
         0p68MTKvoWEQ5VqfHTauDPRU34K/HuqIhQrvvghuY3F1oar0E9C1AkYFVTqN4Rs8D5Ul
         ocXg==
X-Gm-Message-State: AOJu0YxkrmjSsXplKZ4SrsRQYRvla/XPbnVJiiSKhOcFqusUBls6QPQF
	HqJXY39uuOui1zeHXcp249pokQ3/uLSKwA==
X-Google-Smtp-Source: AGHT+IH6B5ZpaA8ZEocPwLfvw4TlkDdAyGwQpngPfxFmNZki1N5H1yUrg7KzYHib3cR9rUs71fQCcg==
X-Received: by 2002:a17:907:948e:b0:a26:9ec0:e35 with SMTP id dm14-20020a170907948e00b00a269ec00e35mr243732ejc.135.1704360067158;
        Thu, 04 Jan 2024 01:21:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id eb23-20020a170907281700b00a1f738318a5sm13598206ejc.155.2024.01.04.01.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 01:21:06 -0800 (PST)
Message-ID: <b8fdce9e-50d9-4b43-a018-c35350bcec0f@linaro.org>
Date: Thu, 4 Jan 2024 10:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: Add UMS9620 support
Content-Language: en-US
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20231229085156.1490233-1-chunyan.zhang@unisoc.com>
 <20231229085156.1490233-2-chunyan.zhang@unisoc.com>
 <3a290bf9-928d-4d21-9c93-0d1db59d6fff@linaro.org>
 <CAAfSe-stvoKSVynTnoy87CUK3NM+ZEwfTMazO0tfwcx5BXG0Og@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAAfSe-stvoKSVynTnoy87CUK3NM+ZEwfTMazO0tfwcx5BXG0Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 10:09, Chunyan Zhang wrote:
> Hi Krzysztof,
> 
> On Thu, 4 Jan 2024 at 16:46, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 29/12/2023 09:51, Chunyan Zhang wrote:
>>> Add UMS9620's clock compatible strings and descriptions for clock
>>> and clock-names for UMS9620.
>>>
>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>> ---
>>>  .../bindings/clock/sprd,ums512-clk.yaml       | 79 ++++++++++++++++---
>>>  1 file changed, 68 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>> index 43d2b6c31357..dcad41a1fea7 100644
>>> --- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
>>> @@ -30,25 +30,38 @@ properties:
>>>        - sprd,ums512-mm-clk
>>>        - sprd,ums512-mm-gate-clk
>>>        - sprd,ums512-apapb-gate
>>> +      - sprd,ums9620-pmu-gate
>>> +      - sprd,ums9620-g1-pll
>>> +      - sprd,ums9620-g5l-pll
>>> +      - sprd,ums9620-g5r-pll
>>> +      - sprd,ums9620-g8-pll
>>> +      - sprd,ums9620-g9-pll
>>> +      - sprd,ums9620-g10-pll
>>> +      - sprd,ums9620-apapb-gate
>>> +      - sprd,ums9620-ap-clk
>>> +      - sprd,ums9620-apahb-gate
>>> +      - sprd,ums9620-aon-gate
>>> +      - sprd,ums9620-aonapb-clk
>>> +      - sprd,ums9620-topdvfs-clk
>>> +      - sprd,ums9620-ipaapb-gate
>>> +      - sprd,ums9620-ipa-clk
>>> +      - sprd,ums9620-ipaglb-gate
>>> +      - sprd,ums9620-ipadispc-gate
>>> +      - sprd,ums9620-pcieapb-gate
>>> +      - sprd,ums9620-pcie-clk
>>> +      - sprd,ums9620-mm-gate
>>> +      - sprd,ums9620-mm-clk
>>> +      - sprd,ums9620-dpu-vsp-gate
>>> +      - sprd,ums9620-dpu-vsp-clk
>>>
>>>    "#clock-cells":
>>>      const: 1
>>>
>>>    clocks:
>>> -    minItems: 1
>>> -    maxItems: 4
>>
>> No, constraints stay here.
>>
>>>      description: |
>>>        The input parent clock(s) phandle for the clock, only list
>>>        fixed clocks which are declared in devicetree.
>>>
>>> -  clock-names:
>>
>> No, you cannot just drop properties. Widest constraints stay here.
>>
>>> -    minItems: 1
>>> -    items:
>>> -      - const: ext-26m
>>> -      - const: ext-32k
>>> -      - const: ext-4m
>>> -      - const: rco-100m
>>> -
>>>    reg:
>>>      maxItems: 1
>>>
>>> @@ -57,7 +70,43 @@ required:
>>>    - '#clock-cells'
>>>    - reg
>>>
>>> -additionalProperties: false
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            pattern: "^sprd,ums512-.*"
>>> +
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 1
>>> +          maxItems: 4
>>> +
>>> +        clock-names:
>>> +          minItems: 1
>>> +          items:
>>> +            - const: ext-26m
>>> +            - const: ext-32k
>>> +            - const: ext-4m
>>> +            - const: rco-100m
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            pattern: "^sprd,ums9620-.*"
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 1
>>> +          maxItems: 6
>>> +
>>> +        clock-names:
>>> +          minItems: 1
>>> +          maxItems: 6
>>
>> Missing names.
> 
> The names are fixed, but the order are not.

Order must be fixed.

> 
> For example:
> clk_a {
>     clocks = <&ext_26m>, <&ext_32k>;
>     clock-names = "ext-26m", "ext-32k";
> };
> 
> clk_b {
>     clocks = <&ext_26m>, <&ext_4m>;
>     clock-names = "ext-26m", "ext-4m";

And here the order is fixed...

> };
> 
> How to list the names for this kind of case? (Please forgive me for
> being lazy, didn't find a similar case after a fast search)

The same ums512 lists them or mentioned other bindings. You somehow cut
the quote...

Best regards,
Krzysztof


