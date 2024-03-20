Return-Path: <linux-kernel+bounces-109028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0518813A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D6D281B38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECD15E9C;
	Wed, 20 Mar 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz8VwvLW"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBE39AE3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945888; cv=none; b=kaHViZln4n61DIwSlJCg+bWd/zfc+AiNjvEH7WHEvsTXNhwPKlGDjrS4oukTwW2PA+IAMZ3lMnVaKSZnBT4jw3m4k1mrOFIs4dqTyPQOrOfxNekKYpQ7d++V2dIOq8dl6xDqmn2QW0I6NqwGz1dG48P/VZEw/1nJtNQpHf1e1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945888; c=relaxed/simple;
	bh=6xb6gVKr7wPUDB2zGan3g4bX3ctWUFn/dyS8hjRMZi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIMhKqIxz12cCkpglD602Il/v0RjOztnO3JFY3sCbcP1gQUu8gs98b95zKYtgxOZA0ZLiJig4rJem5PpOrt/huNXEpHNLWs74bBRpp9XPbdheF0rGe3l2GEBgMZHj56gjjHsC0eILqn5DV8rE97J4izC4cautNa3silq8lQomc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fz8VwvLW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51381021af1so10067054e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710945884; x=1711550684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CzqmL++fUqfU6oIFpMAQIx8Bvp+0IxoTywCrVdfLPSM=;
        b=Fz8VwvLWWCpO1yKFtDrgH4QaJW30syhLlIRLyXLGWUPzdxWjcUhVEfXyrOx2YofNpU
         907rhoVQaFHwTaYtUj+tyZt6cgC4l2aflHYDE1aWTeH5tC2Ec4gJT/mrymz5iUegtvTf
         5olEyH05L726GRK6pmvfMhtT8vG6pZ2N7y9z90nDW+fF4vJYIYxNR4JLYg1w0pQEaOmS
         +p7xuKaRIoMaOwQtoucU90hnBJsPTGUBebmYUzIOtJaS3/qD6iju+i8W7HRBFH19WpRO
         aIWbs5YJKw3Vv/g5Hrtdl3Q70PXKMhnTT/2Cylcg3UJiySLQDmU3mctAAsfBOJkWps7a
         jN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945884; x=1711550684;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzqmL++fUqfU6oIFpMAQIx8Bvp+0IxoTywCrVdfLPSM=;
        b=IuTJ6dX2B+nAHtnKnwpjHKxkRHDhPSmfd7q6hzmR45xQgq8qF6DyXuXM9qwDtd1kWN
         7LhXtDqeVAWnZ8l4ZZIlUwpUa+ie00/ylyjF6xYbsmtlu1oZip4ONpJrRpO7Zjon1uVA
         cM0X4YMz0GeT6tk4fSczG5aMmMST0E2RSjhriiFb9BmD1aG1RvbKexFW+Ep1GUIWRGUX
         E2Z9YGrjhBbxKqHnvg1aNPdCuOl54/uUxPsRt6tGRL6RvwIAK5DkgJ2nUUZaFmVTR1tz
         KVg1PxxeOLK96uSZGiULbqKvI5bxU6kFwQ30/DjG9vhohwx0h/UlBFRs5uPana9JpuzT
         r8/A==
X-Forwarded-Encrypted: i=1; AJvYcCWiRP8J/TntMRKEa8RC40cioWnmp9Te/F+iaRqJxK89M/+Me3Urh1kMHhk1/vQBljTy7aOlI55pwtHa1H9iSqJFc22SO+K8WYBQ7+2F
X-Gm-Message-State: AOJu0Yz14k3lqHf6WXiHG8cxlWaVrfey830JcQUNPboHwlt2i2qiN3zR
	Mi0rk7OuUOoSz2BC3fWF1zdscuPlal/CwwT9V4Z/wZP61ivooNXR5HUsRfMh/u0=
X-Google-Smtp-Source: AGHT+IHzutHEQ6OuS1sm2yMFdFZii/yPJp3PLhWghrwUWCnKphL7YvxA75jjvIVkr3KYXkNcVFUBDA==
X-Received: by 2002:a05:6512:3e1b:b0:513:e7a0:5aa5 with SMTP id i27-20020a0565123e1b00b00513e7a05aa5mr11345122lfv.51.1710945883925;
        Wed, 20 Mar 2024 07:44:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090670c200b00a46f08093fasm984066ejk.133.2024.03.20.07.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 07:44:43 -0700 (PDT)
Message-ID: <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
Date: Wed, 20 Mar 2024 15:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
To: Manojkiran Eda <manojkiran.eda@gmail.com>, patrick.rudolph@9elements.com,
 chiawei_wang@aspeedtech.com, ryan_chen@aspeedtech.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 jk@codeconstruct.com.au, openbmc@lists.ozlabs.org
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2024 10:59, Manojkiran Eda wrote:
> 
> On 19/03/24 3:26 pm, Krzysztof Kozlowski wrote:
>> On 19/03/2024 10:34, Manojkiran Eda wrote:
>>> This commit adds the device tree bindings for aspeed eSPI
>>> controller.
>>>
>>> Although aspeed eSPI hardware supports 4 different channels,
>>> this commit only adds the support for flash channel, the
>>> bindings for other channels could be upstreamed when the driver
>>> support for those are added.
>>>
>>> Signed-off-by: Manojkiran Eda<manojkiran.eda@gmail.com>
>>> ---
>>>   .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
>>>   1 file changed, 94 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>>> new file mode 100644
>>> index 000000000000..3d3ad528e3b3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
>> Why Rob's comments got ignored?
>>
>> This is not a soc component.
> I did not mean to ignore, i have few reasons listed below that provides 
> information on why i felt this belongs into soc.

soc is dumping ground of things which are purely SoC specific, not
covered by existing hardware structure in bindings. Maybe indeed this
does not have any other place, but did you actually look?

Anyway, please CC SPI maintainers on future submission.

>>
>>> @@ -0,0 +1,94 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# # Copyright (c) 2024 IBM Corporation.
>>> +# # Copyright (c) 2021 Aspeed Technology Inc.
>>> +%YAML 1.2
>>> +---
>>> +$id:http://devicetree.org/schemas/soc/aspeed/aspeed,espi.yaml#
>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Aspeed eSPI Controller
>>> +
>>> +maintainers:
>>> +  - Manojkiran Eda<manojkiran.eda@gmail.com>
>>> +  - Patrick Rudolph<patrick.rudolph@9elements.com>
>>> +  - Chia-Wei Wang<chiawei_wang@aspeedtech.com>
>>> +  - Ryan Chen<ryan_chen@aspeedtech.com>
>>> +
>>> +description:
>>> +  Aspeed eSPI controller implements a device side eSPI endpoint device
>>> +  supporting the flash channel.
>> Explain what is eSPI.
> eSPI is a serial bus interface for client and server platforms that is 

Explain in description of the hardware.

> based on SPI,  using the same master and slave topology but operates 
> with a different protocol to meet new requirements. For instance, eSPI 
> uses I/O, or input/output, communication, instead of MOSI/MISO used in 
> SPI. It also includes a transaction layer on top of the SPI protocol, 
> defining packets such as command and response packets that allow both 
> the master and slave to initiate alert and reset signals. eSPI supports 
> communication between Embedded Controller (EC), Baseboard Management 
> Controller (BMC), Super-I/O (SIO) and Port-80 debug cards. I could add 
> this to the commit message as well in the next patchset.
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - aspeed,ast2500-espi
>>> +          - aspeed,ast2600-espi
>>> +      - const: simple-mfd
>>
>> That's not simple-mfd. You have driver for this. Drop.
>>
>>> +      - const: syscon
>> That's not syscon. Why do you have ranges then? Where is any explanation
>> of hardware which would justify such combination?
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 1
>>> +
>>> +  ranges: true
>>> +
>>> +patternProperties:
>>> +  "^espi-ctrl@[0-9a-f]+$":
>>> +    type: object
>>> +
>>> +    description: Controls the flash channel of eSPI hardware
>> That explains nothing. Unless you wanted to use here MTD bindings.
>>
>> This binding did not improve much. I don't understand why this is not
>> SPI (nothing in commit msg, nothing in description), what is eSPI,
> 
> eSPI uses Peripheral, Virtual Wire, Out of Band, and Flash Access 
> channels to communicate different sets of data.

And what are these channels? What does it mean a "channel"? Is it just
how you organize transfers and classes of devices? Or some sort of
addressable instance on the bus?

The channels feel like some sort of software or logical concept, not
physical. Physical would be endpoint with peripheral. Or flash memory.
How do they fit here?
> 
>   * The *Peripheral* Channel is used for communication between eSPI host
>     bridge located on the master side and eSPI endpoints located on the
>     slave side. LPC Host and LPC Peripherals are an example of eSPI host
>     bridge and eSPI endpoints respectively.
>   * *Virtual Wire* Channel: The Virtual Wire channel is used to
>     communicate the state of sideband pins or GPIO tunneled through eSPI
>     as in-band messages. Serial IRQ interrupts are communicated through
>     this channel as in-band messages.
>   * *OOB* Channel: The SMBus packets are tunneled through eSPI as
>     Out-Of-Band (OOB) messages. The whole SMBus packet is embedded
>     inside the eSPI OOB message as data.
>   * *Flash Access* Channel: The Flash Access channel provides a path
>     allowing the flash components to be shared run-time between chipset
>     and the eSPI slaves that require flash accesses such as EC (Embedded
>     Controller) and BMC.

Please make binding complete, so define all of the channels.

> 
> Although , eSPI reuses the timing and electrical specification of Serial 
> Peripheral Interface (SPI) but it runs an entirely different protocol to 
> meet a set of different requirements. Which is why i felt probably 
> placing this in soc was a better choice rather than spi. Do you think 
> otherwise ?

soc is dumping ground for things do not fit other places. Are there any
other buses / IP blocks similar to this one?


Best regards,
Krzysztof


