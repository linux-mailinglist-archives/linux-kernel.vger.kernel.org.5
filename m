Return-Path: <linux-kernel+bounces-24704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FD82C113
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B592872E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B36D1C3;
	Fri, 12 Jan 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgd4Y5Y0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C756D1AA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e68d0dc2aso2381595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705067252; x=1705672052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8S/Lr494/8cBMSvBTtPnyFK/COnAgOFY4isS69HaUM=;
        b=pgd4Y5Y0vCXMLaJh3jowah/7ezwLrt9xHo8OCWGHkWEhp3o0cYuuer+mAXIjbyShdM
         qVB557pIDL5xNwigGsQOAKMZO84DO2ElSZnJ3JHxgI1THENb4REJkhsE1Q3AcvvMGK/F
         MDfx5mdx8L/J09TMpeYGODx7/5g6FoXes4HP0RmAEE4mg3QHL3G6+v/UIGL0F3UYyGbu
         5wVxFwLP3sRGy3YozNXjb9bVIOACAJtfsIy6YAKoPd3c2Hs27nnYnoSSaXFXmKQ48rUp
         HicRV88/9WQmdGArxkW1yeiX3T1LRb8ntf51WDAmiQExDP/v1ifEOgS+OXtXjNqA+V1S
         h93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705067252; x=1705672052;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8S/Lr494/8cBMSvBTtPnyFK/COnAgOFY4isS69HaUM=;
        b=OnEf1jZpHnktYdz1HRpFQROwrVtIjGBtfeSNiBrNNcbF2i/s1gVNCfiJmg4UjWe1iA
         SYs8ue3Y5tAP9wCwPeC4FVs5wzUjek21X18ByvHQZ4TTbdOJoajMUr6AE3fuWMXjdhJW
         mQ53OGBHuSE+r9AhzsiRby+oyjl55iuTtUcErwVAIEFvT0SQfqmMYJjHnaSEqwVJ3e2j
         NWWyj4HfAdFNjR96i/RC7FIpgnIkDzqzS0kkku2TEyj/9as09JBj6Hp+ETIMO1xuqqZk
         2U6g4DvLDY8qRq9u9gIMD5EI5l3QuKHO78tf7ENT5fsgCgPx98M5cVhmOsOKSd2hpVpm
         Jx1g==
X-Gm-Message-State: AOJu0YxqkX8O5UIAMZ86ZxaaeKgzqmLqkLnsWJL1gVTPMvk8DTystbDo
	Pn1ecS+quN6YZSc9WdFiwXg5y9iycYNsXA==
X-Google-Smtp-Source: AGHT+IHo5OWm3GRiX5x5BbOf7Y5jeeEM7OSxvdx/jV5iqT7+UaVwAxjdCgP2nBsT8Ai9XfZyMUJQHg==
X-Received: by 2002:a05:600c:d7:b0:40e:498d:91d2 with SMTP id u23-20020a05600c00d700b0040e498d91d2mr523753wmm.185.1705067252488;
        Fri, 12 Jan 2024 05:47:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b0040d604dea3bsm5703993wmb.4.2024.01.12.05.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 05:47:31 -0800 (PST)
Message-ID: <a8d9e78b-12ac-49df-91ff-09d066e8444a@linaro.org>
Date: Fri, 12 Jan 2024 14:47:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Content-Language: en-US
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
 <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
 <ZaAcvwWbNmSpw/xt@shell.armlinux.org.uk>
 <c5b4613a-261d-429b-b59c-c264bc53e315@leica-geosystems.com>
 <0da41018-eeae-4a15-a431-954da99261d0@linaro.org>
 <ca895fa2-df94-45f4-8472-336ff71e70f0@leica-geosystems.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ca895fa2-df94-45f4-8472-336ff71e70f0@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/01/2024 14:41, POPESCU Catalin wrote:
> On 11.01.24 18:21, Krzysztof Kozlowski wrote:
>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>
>>
>> On 11/01/2024 17:59, POPESCU Catalin wrote:
>>> On 11.01.24 17:52, Russell King (Oracle) wrote:
>>>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>>>
>>>>
>>>> On Thu, Jan 11, 2024 at 04:45:26PM +0000, POPESCU Catalin wrote:
>>>>> On 11.01.24 17:35, Andrew Lunn wrote:
>>>>>> [You don't often get email from andrew@lunn.ch. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>
>>>>>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>>>>>
>>>>>>
>>>>>> On Thu, Jan 11, 2024 at 05:19:25PM +0100, Catalin Popescu wrote:
>>>>>>> Add property ti,cfg-dac-minus to allow for voltage tuning
>>>>>>> of logical level -1 of the MLT-3 encoded data.
>>>>>>>
>>>>>>> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
>>>>>>> ---
>>>>>>>     Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
>>>>>>>     1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>>>>> index db74474207ed..2f010333be49 100644
>>>>>>> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
>>>>>>> @@ -62,6 +62,15 @@ properties:
>>>>>>>            for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
>>>>>>>            to transmit data.
>>>>>>>
>>>>>>> +  ti,cfg-dac-minus:
>>>>>>> +    description: |
>>>>>>> +       DP83826 PHY only.
>>>>>>> +       Sets the voltage ratio of the logical level -1 for the MLT-3 encoded data.
>>>>>>> +       0 = 50%, 1 = 56.25%, 2 = 62.50%, 3 = 68.75%, 4 = 75%, 5 = 81.25%, 6 = 87.50%,
>>>>>>> +       7 = 93.75%, 8 = 100%, 9 = 106.25%, 10 = 112.50%, 11 = 118.75%, 12 = 125%,
>>>>>>> +       13 = 131.25%, 14 = 137.50%, 15 = 143.75%, 16 = 150%.
>>>>>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
>>>>>> We try to avoid register values in DT. We use real units. This is a
>>>>>> voltage you are configuring, so can you change the unit to millivolts?
>>>>>> Have the driver do the conversion of volts to register value.
>>>>>>
>>>>>> Is it possible to configure any of the other logical levels?
>>>>> Hi Andrew,
>>>>> These are not raw register values and these are not voltage values but
>>>>> voltage ratios. I'm mapping the voltage ratios to enum values [0-16]
>>>>> which are converted to register raw values by the driver. I don't see a
>>>>> better way to do this.
>>>>           enum: [ 5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
>>>>                   10625, 11250, 11875, 12500 13125, 13750, 14375, 15000 ]
>>>>
>>>> ?
>>> I'm okay with that approach if there's no better one. I would need to
>>> remove the register raw values tables from the driver and use a switch
>>> statement to map those values to raw values.
>> You can also use -bp or -percent:
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> 
>    ti,cfg-dac-minus-percent:
>      description: |
>         DP83826 PHY only.
>         Sets the voltage ratio of the logical level -1 relative to the
> nominal level for the MLT-3 encoded TX data.
>      enum: [50, 56, 62, 68, 75, 81, 87, 93, 100, 106, 112, 118, 125,
> 131, 137, 143, 150]
>      default: 100

Yes, which would also solve your problem of binding errors. But does not
remove the need of testing it before sending to the lists.

Best regards,
Krzysztof


