Return-Path: <linux-kernel+bounces-122832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5CC88FE1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1241F2647A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2CA7E763;
	Thu, 28 Mar 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MujHIGYJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935C4E1D1;
	Thu, 28 Mar 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625620; cv=none; b=LYkDJNBvgWhinHjiI8F89uriBlSitNtLevUgMwPVePW5MivL3+eC0tUSRWzxCPhv+DQKwS4x6AMGNsZcR4Jd+jTXsa6wnPkKCteydhAQZ0p6/TOKTE3EvTLunH/ZJT/XREBxfrEW0ENSoWoPXPPyUP8/0oRu0e8MPyrCew2V3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625620; c=relaxed/simple;
	bh=7fZE3G1lOu+XdO+WmKhirf4I/Hy+9Ns0NfZeXbyBk3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyqqsbHCUyOHEerK5V9OMDKoYIQdhhIU7taZr3DlINQ5c+4qdcOHrRzrPxdJ8tGkSQDw8VXEp0ZQQsw93zn48bMfh2t0kng1wjBnKv6YLCIHgAUJxyD3KoZXazC/aSkqG1vtgvwfwiaRcrtueJOq7JSaWpfKPPM9Dov/6hi3iRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MujHIGYJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so741840b3a.1;
        Thu, 28 Mar 2024 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711625618; x=1712230418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kLanRBlqX8HlhHJd1EuboE4CdfDSblPAQpGFR2UoHI=;
        b=MujHIGYJirYvQeXTasbWHbETsKxMrFoSKWtEuppJYmLlHCDKG8KVlPxcPZICK59Rir
         PmpCDt/hEDBC0ej35qF1O6a9mQzi2N5Ra1Pb1go0SWMRGKLB6YAUt0el8vRhLgQSF/YJ
         g+dtWspNtU4Gls7pnI3+1J3MAA9FGBM+klhcbJwvZQRA/L5xNLBtIhtvu7QQRmlG99ze
         AqbT7k9dX8I1HTkGHlJ6NlE1oXU0Q6/dMMuGHjZW72tmn5iRBepVwBgsqXuk+J1zWG2F
         5BjQts4InOlCUXLxTC/J4p4SJs7pgFuVUEstpuIobC47WNfgPysee2pOu0DfwRYbRcmM
         ORDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625618; x=1712230418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kLanRBlqX8HlhHJd1EuboE4CdfDSblPAQpGFR2UoHI=;
        b=DIG9u9zNs0Hg+kSy4qh2Boh6+S250qubMYwhg82XLmeuWveDqL+/tnqNoJ0Qj+7LnY
         Awg4CprI9an2y/LCTLviJ3HcvI3GJsopn+OIdyawZuyWBsqcwbal3Zp8BR0DFai7HhhC
         piRCyq7JEGXPglrJX8wF63RnisRdjMkwwvkKbEQjJYrTfenME3vwZraICGUnQsWr6zK/
         eZinyMOHinTrpVHljA3OEsOnXrv5knC51FHZk9NKVKmUG2WKC38QHJ27fVe+QvKKpYV2
         julkxCTsrkrR1swCmB/5Cq5h3FvYTos1eOSZyrktmR0vP8LUYSC8/+kG+ogmGYEy1tFZ
         0Heg==
X-Forwarded-Encrypted: i=1; AJvYcCV9UJtpLvDFK9fSMayfg7VPVxEBZKNl2euP7NeidnjrlDPmSU9k+PMGqzNea8OR5hkiItDK47sGDYhmpez0Atq21c2CWhrlbME1zzpAm4liOX4FDz5BWlshVkZX+wD+gBB3jFJGhwda5Wt8xCbJmZW/ShV1c1IYq6WynHmuzqegXscVKA==
X-Gm-Message-State: AOJu0Yx0MogRvxQ1BnE1YMQ8Y4BtTkLxviSZFMCDhzkyn0Zs1CJW1pKS
	r/hVnrjgenzP8NShR6hJS5qWEWgceIwfnMmFkiA2MHIz7ez6nnLU
X-Google-Smtp-Source: AGHT+IHuuhHhHTN8Vk2oFh7RQ5imuAXNENsjhoN5lsG/+ejPKPrgj43OHqKRbOUo9podhvM5NqfWTQ==
X-Received: by 2002:a17:90b:4c8a:b0:2a0:53cf:9bae with SMTP id my10-20020a17090b4c8a00b002a053cf9baemr2142394pjb.32.1711625617852;
        Thu, 28 Mar 2024 04:33:37 -0700 (PDT)
Received: from [192.168.29.219] ([49.37.251.254])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0029fbfb620cdsm1173744pjz.28.2024.03.28.04.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 04:33:37 -0700 (PDT)
Message-ID: <582c276c-ea2f-456c-9bf9-47e39289a0b6@gmail.com>
Date: Thu, 28 Mar 2024 17:03:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 patrick.rudolph@9elements.com, chiawei_wang@aspeedtech.com,
 ryan_chen@aspeedtech.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 jk@codeconstruct.com.au, openbmc@lists.ozlabs.org, broonie@kernel.org,
 linux-spi@vger.kernel.org
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
 <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
Content-Language: en-US
From: Manojkiran Eda <manojkiran.eda@gmail.com>
In-Reply-To: <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/03/24 8:14 pm, Krzysztof Kozlowski wrote:
> On 20/03/2024 10:59, Manojkiran Eda wrote:
>>
>> On 19/03/24 3:26 pm, Krzysztof Kozlowski wrote:
>>> On 19/03/2024 10:34, Manojkiran Eda wrote:
>>>> This commit adds the device tree bindings for aspeed eSPI
>>>> controller.
>>>>
>>>> Although aspeed eSPI hardware supports 4 different channels,
>>>> this commit only adds the support for flash channel, the
>>>> bindings for other channels could be upstreamed when the driver
>>>> support for those are added.
>>>>
>>>> Signed-off-by: Manojkiran Eda<manojkiran.eda@gmail.com>
>>>> ---
>>>>    .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
>>>>    1 file changed, 94 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>>> new file mode 100644
>>>> index 000000000000..3d3ad528e3b3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>> Why Rob's comments got ignored?
>>>
>>> This is not a soc component.
>> I did not mean to ignore, i have few reasons listed below that provides
>> information on why i felt this belongs into soc.
> 
> soc is dumping ground of things which are purely SoC specific, not
> covered by existing hardware structure in bindings. Maybe indeed this
> does not have any other place, but did you actually look?
> 

Yes, i did look at existing hardware bindings, and cannot seem to find 
out any other suitable place. I can definitely look again.

> Anyway, please CC SPI maintainers on future submission.

Sure, will add them.

> 
>>>
>>>> @@ -0,0 +1,94 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# # Copyright (c) 2024 IBM Corporation.
>>>> +# # Copyright (c) 2021 Aspeed Technology Inc.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id:http://devicetree.org/schemas/soc/aspeed/aspeed,espi.yaml#
>>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Aspeed eSPI Controller
>>>> +
>>>> +maintainers:
>>>> +  - Manojkiran Eda<manojkiran.eda@gmail.com>
>>>> +  - Patrick Rudolph<patrick.rudolph@9elements.com>
>>>> +  - Chia-Wei Wang<chiawei_wang@aspeedtech.com>
>>>> +  - Ryan Chen<ryan_chen@aspeedtech.com>
>>>> +
>>>> +description:
>>>> +  Aspeed eSPI controller implements a device side eSPI endpoint device
>>>> +  supporting the flash channel.
>>> Explain what is eSPI.
>> eSPI is a serial bus interface for client and server platforms that is
> 
> Explain in description of the hardware.

Sure, i will add this description in the binding document in the future 
submission.
> 
>> based on SPI,  using the same master and slave topology but operates
>> with a different protocol to meet new requirements. For instance, eSPI
>> uses I/O, or input/output, communication, instead of MOSI/MISO used in
>> SPI. It also includes a transaction layer on top of the SPI protocol,
>> defining packets such as command and response packets that allow both
>> the master and slave to initiate alert and reset signals. eSPI supports
>> communication between Embedded Controller (EC), Baseboard Management
>> Controller (BMC), Super-I/O (SIO) and Port-80 debug cards. I could add
>> this to the commit message as well in the next patchset.
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - aspeed,ast2500-espi
>>>> +          - aspeed,ast2600-espi
>>>> +      - const: simple-mfd
>>>
>>> That's not simple-mfd. You have driver for this. Drop.
>>>
>>>> +      - const: syscon
>>> That's not syscon. Why do you have ranges then? Where is any explanation
>>> of hardware which would justify such combination?
>>>
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 1
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 1
>>>> +
>>>> +  ranges: true
>>>> +
>>>> +patternProperties:
>>>> +  "^espi-ctrl@[0-9a-f]+$":
>>>> +    type: object
>>>> +
>>>> +    description: Controls the flash channel of eSPI hardware
>>> That explains nothing. Unless you wanted to use here MTD bindings.
>>>
>>> This binding did not improve much. I don't understand why this is not
>>> SPI (nothing in commit msg, nothing in description), what is eSPI,
>>
>> eSPI uses Peripheral, Virtual Wire, Out of Band, and Flash Access
>> channels to communicate different sets of data.
> 
> And what are these channels? What does it mean a "channel"? Is it just
> how you organize transfers and classes of devices? Or some sort of
> addressable instance on the bus?
> 

Yes, an espi channel provides a means to allow multiple independent 
flows of traffic to share the same physical bus. Each of the channels 
has its own dedicated resources such as queue and flow control.

> The channels feel like some sort of software or logical concept, not
> physical. Physical would be endpoint with peripheral. Or flash memory.

A channel is a logical communication pathway or interface between the 
chipset and peripheral devices. The concept of channels in the ESPI 
protocol helps organize and manage different types of communication 
between the chipset and peripherals. Each channel may have its own set 
of protocols, data transfer rates, and supported features, tailored to 
the requirements of the devices it serves.

> How do they fit here?

I am not sure I understand, can you please elaborate ?

>>
>>    * The *Peripheral* Channel is used for communication between eSPI host
>>      bridge located on the master side and eSPI endpoints located on the
>>      slave side. LPC Host and LPC Peripherals are an example of eSPI host
>>      bridge and eSPI endpoints respectively.
>>    * *Virtual Wire* Channel: The Virtual Wire channel is used to
>>      communicate the state of sideband pins or GPIO tunneled through eSPI
>>      as in-band messages. Serial IRQ interrupts are communicated through
>>      this channel as in-band messages.
>>    * *OOB* Channel: The SMBus packets are tunneled through eSPI as
>>      Out-Of-Band (OOB) messages. The whole SMBus packet is embedded
>>      inside the eSPI OOB message as data.
>>    * *Flash Access* Channel: The Flash Access channel provides a path
>>      allowing the flash components to be shared run-time between chipset
>>      and the eSPI slaves that require flash accesses such as EC (Embedded
>>      Controller) and BMC.
> 
> Please make binding complete, so define all of the channels.


I would like to inquire about the rationale behind this request. Based 
on previous feedback received from the upstream efforts 
[https://lore.kernel.org/openbmc/HK0PR06MB37798462D17443C697433D7191D09@HK0PR06MB3779.apcprd06.prod.outlook.com/], 
suggestions were made to model the flash channel by utilizing the mtd 
subsystem, the virtual wire channel by utilizing the GPIO subsystem, and 
to consider the OOB channel as a type of i2c device, thereby allowing it 
to be utilized by the existing in-kernel MCTP subsystem, among others. 
My intention was to prioritize upstreaming the flash channel binding, 
along with its driver code, before proceeding to address other channels. 
I am curious to understand if it is a strict requirement to have the 
complete binding upstreamed before addressing the device drivers code.

> 
>>
>> Although , eSPI reuses the timing and electrical specification of Serial
>> Peripheral Interface (SPI) but it runs an entirely different protocol to
>> meet a set of different requirements. Which is why i felt probably
>> placing this in soc was a better choice rather than spi. Do you think
>> otherwise ?
> 
> soc is dumping ground for things do not fit other places. Are there any
> other buses / IP blocks similar to this one?
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Manoj

