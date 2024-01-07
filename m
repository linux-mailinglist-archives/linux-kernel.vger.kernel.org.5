Return-Path: <linux-kernel+bounces-18993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FAD826634
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A6F1C20D23
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDA911C88;
	Sun,  7 Jan 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NckFRp/n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264111725;
	Sun,  7 Jan 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d2376db79so12200495e9.0;
        Sun, 07 Jan 2024 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704664156; x=1705268956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5mdwjsu/PFOSh1W0Q3EjHNBZwj9Qa79+/3TGj0T76A=;
        b=NckFRp/nRL3h9UEVxd7+Xw/Q2bdvi8wwA1MLaMIvVd6d2trbpT4VkcGufqzHfrfW/7
         VUdBkiYYnpp94xwrFX3RTxRphtupp68m7sIlChbutpWrxfiGCpNGQ0rkyAezbuTStSJA
         Fh2vJxBCnGXFZQzVxlIKnQjEN+uKDNVuimJcLrpOhAbpJ3d4vVrjjJFoY0VycjLbzj4H
         1ri4GZAJxfqL4Wl3VvT7rPOWlEaiTyzRjnp8U+K5vZeQlkXI3zrlKphbAm5ta6Kirjlu
         waECbKujQ2+DeJTnd5/91COUpp1ygzkjC64BxOkcHs9K8fgSoe6qeJdFYcRqQcezd0rw
         6e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704664156; x=1705268956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5mdwjsu/PFOSh1W0Q3EjHNBZwj9Qa79+/3TGj0T76A=;
        b=vAPmQHW6eLKRqcFAE1KBDeQbRo4lX5M/QSehwDnpK3uwpq/poj+u+G7W68/Zicq6aJ
         pinUkII7UT1gc6kp+yi6ToJd7/iLfYO+dpRCadSzTqHjBe68Z4AONr4rhJg25TWC+d4h
         9NOoiICY+yNC9cHAVy4ZawXk6Yy7mcPgNA7x9+Y2/XhfhK9QDfJa2gy8NH5O6utkeBUY
         2v8mKtFPG3jiVMeYctwZAHmZh9v6yIAkAKF64PDs4vziWWgK3R6TGpdEw3PQoeI0iP92
         IfKX/zq/QLM0Vht81aKcnZ2RqbHNPnq4p0D6Q2oH0g275g2Ipy6mkeC5CUJOBUyO0cze
         cq2A==
X-Gm-Message-State: AOJu0YyI3Obmz/lZvXBi+Zi8xs/dWk1tINCQ/PeQpOSQzzNkCW7uTSKF
	Dtd93LhkjtrK0OafMXm7Rus=
X-Google-Smtp-Source: AGHT+IG3NImT7x1ZNWhqMkGZN8jVJ/SjUMmxQpvLwG5e6+xm5AJDc9F/U0vwnMz2PiFZJZbG0eILqg==
X-Received: by 2002:a05:600c:3103:b0:40e:3a66:57b5 with SMTP id g3-20020a05600c310300b0040e3a6657b5mr1626285wmo.77.1704664155631;
        Sun, 07 Jan 2024 13:49:15 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b0040d53588d94sm8775105wmb.46.2024.01.07.13.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 13:49:15 -0800 (PST)
Message-ID: <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>
Date: Sun, 7 Jan 2024 23:49:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Luo Jie <quic_luoj@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <659aedb1.df0a0220.35691.1853@mx.google.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <659aedb1.df0a0220.35691.1853@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 07.01.2024 20:30, Christian Marangi wrote:
> On Sun, Jan 07, 2024 at 08:00:33PM +0200, Sergey Ryazanov wrote:
>> On 26.11.2023 03:53, Christian Marangi wrote:
>>> Document ethernet PHY package nodes used to describe PHY shipped in
>>> bundle of 4-5 PHY. The special node describe a container of PHY that
>>> share common properties. This is a generic schema and PHY package
>>> should create specialized version with the required additional shared
>>> properties.
>>>
>>> Example are PHY package that have some regs only in one PHY of the
>>> package and will affect every other PHY in the package, for example
>>> related to PHY interface mode calibration or global PHY mode selection.
>>>
>>> The PHY package node MUST declare the base address used by the PHY driver
>>> for global configuration by calculating the offsets of the global PHY
>>> based on the base address of the PHY package and declare the
>>> "ethrnet-phy-package" compatible.
>>>
>>> Each reg of the PHY defined in the PHY package node is absolute and will
>>> reference the real address of the PHY on the bus.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
>>>    1 file changed, 75 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
>>> new file mode 100644
>>> index 000000000000..244d4bc29164
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Ethernet PHY Package Common Properties
>>> +
>>> +maintainers:
>>> +  - Christian Marangi <ansuelsmth@gmail.com>
>>> +
>>> +description:
>>> +  This schema describe PHY package as simple container for
>>> +  a bundle of PHYs that share the same properties and
>>> +  contains the PHYs of the package themself.
>>> +
>>> +  Each reg of the PHYs defined in the PHY package node is
>>> +  absolute and describe the real address of the PHY on the bus.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
>>> +
>>> +  compatible:
>>> +    const: ethernet-phy-package
>>> +
>>> +  reg:
>>> +    minimum: 0
>>> +    maximum: 31
>>> +    description:
>>> +      The base ID number for the PHY package.
>>> +      Commonly the ID of the first PHY in the PHY package.
>>> +
>>> +      Some PHY in the PHY package might be not defined but
>>> +      still exist on the device (just not attached to anything).
>>> +      The reg defined in the PHY package node might differ and
>>> +      the related PHY might be not defined.
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  ^ethernet-phy(@[a-f0-9]+)?$:
>>> +    $ref: ethernet-phy.yaml#
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +  - |
>>> +    mdio {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        ethernet-phy-package@16 {
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +            compatible = "ethernet-phy-package";
>>> +            reg = <0x16>;
>>> +
>>> +            ethernet-phy@16 {
>>> +              reg = <0x16>;
>>> +            };
>>> +
>>> +            phy4: ethernet-phy@1a {
>>> +              reg = <0x1a>;
>>> +            };
>>> +        };
>>> +    };
>>
>> So, we ended up on a design where we use the predefined compatible string
>> 'ethernet-phy-package' to recognize a phy package inside the
>> of_mdiobus_register() function. During the V1 discussion, Vladimir came up
>> with the idea of 'ranges' property usage [1]. Can we use 'ranges' to
>> recognize a phy package in of_mdiobus_register()? IMHO this will give us a
>> clear DT solution. I mean 'ranges' clearly indicates that child nodes are in
>> the same address range as the parent node. Also we can list all child
>> addresses in 'reg' to mark them occupied.
>>
>>    mdio {
>>      ...
>>
>>      ethernet-phy-package@16 {
>>        compatible = "qcom,qca8075";
>>        reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
>>        ranges;
>>        ...
>>
>>        ethernet-phy@16 {
>>          reg = <0x16>;
>>        };
>>
>>        ethernet-phy@1a {
>>          reg = <0x1a>;
>>        };
>>      };
>>    };
>>
>> Did you find some issues with the 'ranges' conception?
> 
> Nope it's ok but it might pose some confusion with the idea that the
> very first element MUST be THE STARTING ADDR of the PHY package. (people
> might think that it's just the list of the PHYs in the package and
> remove the hardware unconnected ones... but that would be fault of who
> write the DT anyway.)

Make sense. I do not insist on addresses listing. Mainly I'm thinking of 
a proper way to show that child nodes are accessible directly on the 
parent bus, and introducing the special compatibility string, while we 
already have the 'ranges' property.

But it's good to know Rob's opinion on whether it is conceptually right 
to use 'ranges' here.

>> And I would like to ask you about another issue raised by Vladimir [1].
>> These phy chips become SoC with all these built-in PHYs, PCSs, clocks,
>> interrupt controllers, etc. Should we address this now? Or should we go with
>> the proposed solution for now and postpone modeling of other peripherals
>> until we get a real hardware, as Andrew suggested?
> 
> Honestly I would postpone untile we have a clear idea of what is
> actually part of the PHY and what can be handled externally... Example
> setting the clock in gcc, writing a specific driver...
> 
> It's a random idea but maybe most of the stuff required for that PHY is
> just when it's connected to a switch... In that case it would all be
> handled in the switch driver (tobe extended qca8k) and all these extra
> stuff would be placed in that node instead of bloating phy nodes with
> all kind of clk and other stuff.
> 
> This series still require 2 more series (at803x splint and cleanup) to be
> actually proposed so we have some time to better define this.
> 
> What do you think?

Fair enough! Let's postpone until we really need it. I noticed this 
PHY-like-SoC discussion in the V1 comments, and it was not finished 
there neither addressed in the latest patch comment. So I asked just to 
be sure that we were finished with this. Thank you for the clarification.

--
Sergey


