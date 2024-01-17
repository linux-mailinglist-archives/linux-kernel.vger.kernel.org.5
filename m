Return-Path: <linux-kernel+bounces-29371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA6830D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723D8B20B62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294FD24A0E;
	Wed, 17 Jan 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5RrOCHq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999024200;
	Wed, 17 Jan 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520373; cv=none; b=aBaaqjt7X2H/t9AzkP2bTzVnzwiJ/d87OhRt45Nc7MoFyeeUhZ0FpXgkKZnepAyk1qWMj32TFkqcnfXje9eP2+IRabnvSxJsRgUGukLbsmok3U/LbX8SENrR5FqCMIrHuMvUlO2fvcIwkJ4xZUSSCMazJlSeXya07ezp7UiRUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520373; c=relaxed/simple;
	bh=xUW41l+F6yt3WPTcJFmF0WlaMMfrGbYszW2gpGLTF7c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=MNLEzl73a6xofdvX88jOZW0OPQomJ+vwAoi/OnQw0YIwJHr2Rx3Sr1YEkZY7ItshZxRzqNCfw4rFHVAfCkiqYY2ZWFQkbw7WONwRfHIa9Jbe7ZdL2FCwhjgjAHgaYByWMKab4FThRbe0B8xC59gDG0e4SukC6NM54I50HgwP2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5RrOCHq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso20710575e9.2;
        Wed, 17 Jan 2024 11:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705520369; x=1706125169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeuTafQX40/bhE79jlyyxN484RLluokaSda2KNrJ6KI=;
        b=A5RrOCHqwbhK1AVWjGXTAZruAEXNsic6HA4NbDW9qbxr2arqlruaTzbYaf/HJFI5PW
         iazMMoxeUwYldJauBXtXSnapYe+Ha2G/8jxjyII9/EF4IoT/HOJXZI6/Lew5uIWqyLBK
         lI0njmR4Iv7RlfwH7NQi2UtWnAuR5WlrTTu5NLRw7GSUMut5xhtEk+z5RgbnSFtmEsDo
         gy1ri7SyF+Zb5HUV66KBmpEzU9BC91nZogtC/zpvsfRW97or0bI4nSlkkOH9LerrQPEW
         OM8eGw2+WvxEXeCEG8IBi7wbPOjB9k+FprT6kB03aUx5t+9oCLRTuhE4QSELxP8UaN9W
         qudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705520369; x=1706125169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeuTafQX40/bhE79jlyyxN484RLluokaSda2KNrJ6KI=;
        b=q6Kkt8vXWqpXSuBhRSzbxsfKCSGUPUg7NEnmxDzQpw4Jy549ljoeWOYqXlXveOvebM
         f9oMZ2Ts0v2f7fNI6MALVa+aQBA44UUGs/qh8e+G9AOYR0Dncm7sLeBwQCVvL5bkphXz
         SrFOnzncwfGMTlW9nxjbuk0G1qORxmA95YvwBT3s0YGq46GoiozFokwS8uwGuodniI3S
         x+Pb9Woybsx6OxJYE3tlYxpQI1A5IysHgaHySC0bG/ubJZSj45SLKVZ0TXwmfKOsrh+j
         zTWcqOly4+9PAV+G0i63++Zyv8q1Qby+//uhBBZOay/by4IBoc7NwTuyihMM7fwLoTWS
         e11g==
X-Gm-Message-State: AOJu0YxmHi9K2HdAaYVylU85TAKoL4TEURo1GRLsYtNy0q1nLI0CBWmy
	OgUpuP/yhqVJRYQSva24MHc=
X-Google-Smtp-Source: AGHT+IGQ/vgsgMyVvJJZEFczZQRj1bkOBQgeDCIkSAsQdn9ihyhpR1zcD1iO3JBmHov+nZGsYZZC1Q==
X-Received: by 2002:a05:600c:1392:b0:40e:479d:ce47 with SMTP id u18-20020a05600c139200b0040e479dce47mr4893168wmf.181.1705520369096;
        Wed, 17 Jan 2024 11:39:29 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b00337af95c1d2sm2325448wrs.14.2024.01.17.11.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 11:39:28 -0800 (PST)
Message-ID: <c81af808-d836-4054-b596-4a53b05f4c78@gmail.com>
Date: Wed, 17 Jan 2024 21:39:25 +0200
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
 <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>
 <65a7210f.df0a0220.d10b2.1162@mx.google.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <65a7210f.df0a0220.d10b2.1162@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 17.01.2024 02:36, Christian Marangi wrote:
> On Sun, Jan 07, 2024 at 11:49:12PM +0200, Sergey Ryazanov wrote:
>> Hi Christian,
>>
>> On 07.01.2024 20:30, Christian Marangi wrote:
>>> On Sun, Jan 07, 2024 at 08:00:33PM +0200, Sergey Ryazanov wrote:
>>>> On 26.11.2023 03:53, Christian Marangi wrote:
>>>>> Document ethernet PHY package nodes used to describe PHY shipped in
>>>>> bundle of 4-5 PHY. The special node describe a container of PHY that
>>>>> share common properties. This is a generic schema and PHY package
>>>>> should create specialized version with the required additional shared
>>>>> properties.
>>>>>
>>>>> Example are PHY package that have some regs only in one PHY of the
>>>>> package and will affect every other PHY in the package, for example
>>>>> related to PHY interface mode calibration or global PHY mode selection.
>>>>>
>>>>> The PHY package node MUST declare the base address used by the PHY driver
>>>>> for global configuration by calculating the offsets of the global PHY
>>>>> based on the base address of the PHY package and declare the
>>>>> "ethrnet-phy-package" compatible.
>>>>>
>>>>> Each reg of the PHY defined in the PHY package node is absolute and will
>>>>> reference the real address of the PHY on the bus.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> ---
>>>>>     .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
>>>>>     1 file changed, 75 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..244d4bc29164
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
>>>>> @@ -0,0 +1,75 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Ethernet PHY Package Common Properties
>>>>> +
>>>>> +maintainers:
>>>>> +  - Christian Marangi <ansuelsmth@gmail.com>
>>>>> +
>>>>> +description:
>>>>> +  This schema describe PHY package as simple container for
>>>>> +  a bundle of PHYs that share the same properties and
>>>>> +  contains the PHYs of the package themself.
>>>>> +
>>>>> +  Each reg of the PHYs defined in the PHY package node is
>>>>> +  absolute and describe the real address of the PHY on the bus.
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
>>>>> +
>>>>> +  compatible:
>>>>> +    const: ethernet-phy-package
>>>>> +
>>>>> +  reg:
>>>>> +    minimum: 0
>>>>> +    maximum: 31
>>>>> +    description:
>>>>> +      The base ID number for the PHY package.
>>>>> +      Commonly the ID of the first PHY in the PHY package.
>>>>> +
>>>>> +      Some PHY in the PHY package might be not defined but
>>>>> +      still exist on the device (just not attached to anything).
>>>>> +      The reg defined in the PHY package node might differ and
>>>>> +      the related PHY might be not defined.
>>>>> +
>>>>> +  '#address-cells':
>>>>> +    const: 1
>>>>> +
>>>>> +  '#size-cells':
>>>>> +    const: 0
>>>>> +
>>>>> +patternProperties:
>>>>> +  ^ethernet-phy(@[a-f0-9]+)?$:
>>>>> +    $ref: ethernet-phy.yaml#
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +
>>>>> +additionalProperties: true
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    mdio {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        ethernet-phy-package@16 {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +            compatible = "ethernet-phy-package";
>>>>> +            reg = <0x16>;
>>>>> +
>>>>> +            ethernet-phy@16 {
>>>>> +              reg = <0x16>;
>>>>> +            };
>>>>> +
>>>>> +            phy4: ethernet-phy@1a {
>>>>> +              reg = <0x1a>;
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>
>>>> So, we ended up on a design where we use the predefined compatible string
>>>> 'ethernet-phy-package' to recognize a phy package inside the
>>>> of_mdiobus_register() function. During the V1 discussion, Vladimir came up
>>>> with the idea of 'ranges' property usage [1]. Can we use 'ranges' to
>>>> recognize a phy package in of_mdiobus_register()? IMHO this will give us a
>>>> clear DT solution. I mean 'ranges' clearly indicates that child nodes are in
>>>> the same address range as the parent node. Also we can list all child
>>>> addresses in 'reg' to mark them occupied.
>>>>
>>>>     mdio {
>>>>       ...
>>>>
>>>>       ethernet-phy-package@16 {
>>>>         compatible = "qcom,qca8075";
>>>>         reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
>>>>         ranges;
>>>>         ...
>>>>
>>>>         ethernet-phy@16 {
>>>>           reg = <0x16>;
>>>>         };
>>>>
>>>>         ethernet-phy@1a {
>>>>           reg = <0x1a>;
>>>>         };
>>>>       };
>>>>     };
>>>>
>>>> Did you find some issues with the 'ranges' conception?
>>>
>>> Nope it's ok but it might pose some confusion with the idea that the
>>> very first element MUST be THE STARTING ADDR of the PHY package. (people
>>> might think that it's just the list of the PHYs in the package and
>>> remove the hardware unconnected ones... but that would be fault of who
>>> write the DT anyway.)
>>
>> Make sense. I do not insist on addresses listing. Mainly I'm thinking of a
>> proper way to show that child nodes are accessible directly on the parent
>> bus, and introducing the special compatibility string, while we already have
>> the 'ranges' property.
>>
>> But it's good to know Rob's opinion on whether it is conceptually right to
>> use 'ranges' here.
>>
> 
> I wonder if something like this might make sense... Thing is that with
> the ranges property we would have the define the address in the PHY
> Package node as offsets...
> 
> An example would be
> 
>      mdio {
>          #address-cells = <1>;
>          #size-cells = <0>;
> 
>          ethernet-phy-package@10 {
>              #address-cells = <1>;
>              #size-cells = <0>;
>              compatible = "qcom,qca807x-package";
>              reg = <0x10>;
>              ranges = <0x0 0x10 0x5>;
> 
>              qcom,package-mode = "qsgmii";
> 
>              ethernet-phy@0 {
>                  reg = <0>;
> 
>                  leds {
> 
> 		...
> 
> With a PHY Package at 0x10, that span 5 address and the child starts at
> 0x0 offset.
> 
> This way we would be very precise on describing the amount of address
> used by the PHY Package without having to define the PHY not actually
> connected.
> 
> PHY needs to be at an offset to make sense of the ranges first element
> property (0x0). With a non offset way we would have to have something
> like
> 
> ranges = <0x10 0x10 0x5>;
> 
> With the child and tha parent always matching.
> 
> (this is easy to handle in the parsing and probe as we will just
> calculate the real address based on the base address of the PHY package
> + offset)

On one hand it makes sense and looks useful for software development. On 
another, it looks like a violation of the main DT designing rule, when 
DT should be used to describe that hardware properties, which can not be 
learnt from other sources.

As far as I understand this specific chip, each of embedded PHYs has its 
own MDIO bus address and not an offset from a main common address. 
Correct me please, if I am got it wrong.

> I hope Rob can give more feedback about this, is this what you were
> thinking with the usage of ranges property?
> 
> (this has also the bonus point of introducing some validation in the PHY
> core code to make sure the right amount of PHY are defined in the
> package by checking if the number of PHY doesn't exceed the value set in
> ranges.)

Yep, I am also would like to hear some clarification from Rob regarding 
acceptable 'range' property usage and may be some advice on how to 
specify the size of occupied addresses. Rob?

--
Sergey

