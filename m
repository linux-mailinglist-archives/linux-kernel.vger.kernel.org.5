Return-Path: <linux-kernel+bounces-26350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B485C82DEDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380421F22CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2218626;
	Mon, 15 Jan 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKAzJTOF"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA5182A1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557a3ce9942so9922169a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705341779; x=1705946579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqzAPvsOsW3WIKxe5N0hrRAxSr5WJEJ2bNXdcxOPEsM=;
        b=JKAzJTOFbMadqk027who7GKCl/PRsqUDk2SYqQrYkOc5ByJDKtnKdR/19KLot/4B88
         hyWGZSSapC24EK7FaktxVbAf7rn2qfozFn+XNohsD5ShlsW4/QWsy70+/emZLv8S9RSh
         uuo0lqC4STMxHqm9l3WsnReQ8IwI14MYcQ5Nf+IvFpcG4osj/P+HPt8WklewvoeTRMWW
         YihWdxUcApZuUS+gkLuM8YWJGw2onlHXCFAe1nhk++cVkFb7p99KZYm/Ii1oQVmrAynK
         A6QDX+BA1ffYikpRa+bxcnJZs1I+6svUXvm/Ga5sx9Smf8m2i4tWYFtdIG8n+3USAEKm
         8q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705341779; x=1705946579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqzAPvsOsW3WIKxe5N0hrRAxSr5WJEJ2bNXdcxOPEsM=;
        b=c7mmYozWhJtRWWKzXhuwcCrBXYmg6j8gDglsSMGONH1pcyDvJ7cBsdQckZEnb95K6I
         gp2k/0knZBKKJkIMwGhUp3tdCEWtGySBZcTNTOJaBbwb3VAscp/CevCVLlkdArgyg4bv
         eMboIPuIgFiDVeIRyViFJu1iUsTcaPrFcnSH4cgLTYt4UH+T58jCVvUGBShrxFtj0DjP
         Zz7elVgXsYUTMT8LbdQLcblwD2z0J2wFy8m1doSMXixdpaOLFXHuGgndWHAiAABJtahH
         GgcPt3+4Y3ktSKC2f4unxETbm0QdQaSiILpJIu+hBVEI6hyA6fUZ5tItn2UKpeGXkcYe
         Ndyw==
X-Gm-Message-State: AOJu0YwzZK5cwZHEK0QZROAzvjgdI9qCpP/n59qqN2yHYEV9yHZpDv+7
	Xf/hc2w7EvQ1/7+aOJFGTUYVr2nKsnM9lA==
X-Google-Smtp-Source: AGHT+IG9G1GkeAeA6ad1nzmDuCqRg+12HdfgfYRJSKGljcFZ2UgaPYxviAFXZFNSo3E0KreGWJJK1A==
X-Received: by 2002:aa7:c418:0:b0:555:13c9:5f88 with SMTP id j24-20020aa7c418000000b0055513c95f88mr2016362edq.118.1705341779560;
        Mon, 15 Jan 2024 10:02:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005592d70c31esm2241652edb.17.2024.01.15.10.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 10:02:59 -0800 (PST)
Message-ID: <7035daa6-e654-4e77-be55-60f8e8c6639f@linaro.org>
Date: Mon, 15 Jan 2024 19:02:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: w1: UART 1-Wire bus
Content-Language: en-US
To: Christoph Winklhofer <cj.winklhofer@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-1-7fe1378a8b3e@gmail.com>
 <20240113013917.GA3795949-robh@kernel.org> <ZaLQxGjjmA_iKOv2@cjw-notebook>
 <81c79939-56cc-4d78-9552-56568999df09@linaro.org>
 <ZaP0CoCYLQxrT3VD@cjw-notebook>
 <1b8cb3ba-6727-45ab-acaa-c727a0a7ad85@linaro.org>
 <ZaVtNmvRjPAn9bph@cjw-notebook>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZaVtNmvRjPAn9bph@cjw-notebook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 18:36, Christoph Winklhofer wrote:
> On Sun, Jan 14, 2024 at 04:55:42PM +0100, Krzysztof Kozlowski wrote:
>> On 14/01/2024 15:47, Christoph Winklhofer wrote:
>>> On Sun, Jan 14, 2024 at 11:54:48AM +0100, Krzysztof Kozlowski wrote:
>>>> On 13/01/2024 19:04, Christoph Winklhofer wrote:
>>>>> On Fri, Jan 12, 2024 at 07:39:17PM -0600, Rob Herring wrote:
>>>>>> On Sat, Jan 06, 2024 at 05:02:24PM +0100, Christoph Winklhofer wrote:
>>>>>>> Add device tree binding for UART 1-Wire bus.
>>>>>>>
>>>>>>> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/w1/w1-uart.yaml | 62 +++++++++++++++++++++++
>>>>>>>  1 file changed, 62 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..6b90693b2ca0
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
>>>>>>> @@ -0,0 +1,62 @@
>>>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> ...
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    const: w1-uart
>>>>>>> +
>>>>>>> +  reset-speed:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    default: 9600
>>>>>>> +    description: |
>>>>>>
>>>>>> Don't need '|' if no formatting
>>>>>>
>>>>>
>>>>> Ok.
>>>>>
>>>>>>> +      The baud rate for the 1-Wire reset and presence detect.
>>>>>>> +
>>>>>>> +  touch_0-speed:
>>>>>>
>>>>>> Don't use '_' in property names.
>>>>>>
>>>>>> I'm somewhat familar with 1-wire, but I don't get what 'touch' means 
>>>>>> here. I assume these are low and high times which are a function of the 
>>>>>> baudrate.
>>>>>>
>>>>>
>>>>> I change the name to 'write-0-speed' and 'write-1-speed'. The function
>>>>> in the w1-framework is named 'touch_bit' - therefore the previous
>>>>> naming. 
>>>>>
>>>>> It is the baud-rate used in the 1-Wire cycle to write a 0-Bit
>>>>> (write-0-speed) and to perform a 1-Wire cycle that writes a 1-Bit and
>>>>> reads a 0-Bit or 1-Bit (write-1-speed).
>>>>
>>>>
>>>> Then probably -bps:
>>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>>
>>> The serial.yaml uses prefix -speed for the baud rate but I can change it
>>> to -bps.
>>
>> Do you reference serial.yaml?
>>
> 
> No, serial.yaml is not referenced but 'onewire' will be a child-node of
> a serial-device which already defines baud rate related properties
> with -speed (e.g. max-speed although not used in w1-uart). Hence, I
> thought -speed is typically used for baud rates.

Ah, it defines max-speed for childre, so for onewire. Re-using that
property would make sense, but since you are defining completely new
properties, let's use proper (-bps) naming.

I still wonder, why would you use different baud rates for these three
different operations?

Best regards,
Krzysztof


