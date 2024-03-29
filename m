Return-Path: <linux-kernel+bounces-124448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56789180C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D102A1C224E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529DB80609;
	Fri, 29 Mar 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwfdemLM"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099C80616
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712548; cv=none; b=aDWAyVnVBqWKseGrzxH6LEp7EZIPu0ZMcPYzPgQbt1E1334qtSZ5bhoJx+UUnq9a/bot5JDAcHDFkCgQTZQ9KUPFoXc4bxZQNyo0uZR1lUw4c6Qp+FrVa3p5hNZM+2TZamSYhKy0rjEmuVcGZK6uVqKoklwdddUmr6iiVuUjxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712548; c=relaxed/simple;
	bh=y/SaY+u1pEgNGCi6MUxKlTpmPE4APyW+ssQJ4Ciw8Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9FwDyolqjvlGfKa5dFLi3uMovKz7jamdreo+FSUzb+vYQeLJ3ROL0tzAdtB4oijZd7zqCSpndhF+6YQSdIY5scXwb2HmI8wvEY5Qk+3iuVnmcZ/4uqWhEpmjV/LtjIs4gt9l/bh97sZQhj0idU8PEYQ34Z20zFWXAa7+isFEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EwfdemLM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-341730bfc46so1301762f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711712545; x=1712317345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LUalL55AIOU3mZ2WBYhdqf1hXqkUUSaMPr9AFBYthp0=;
        b=EwfdemLMDLzqzGDrWRaPf4QQk4u/VP0ruKmbdnmzE0ndfDaMDpL8feAJU6FdrxkzrX
         iGA/VhNtW7h/OC+eGwWySDWalpbwrDK9UhJCSPivcR0ZU1VyuK307tpWBpas5IJ/lu/Q
         aKrsrNL0uQCicmpsk7weUvlFBouUfpHXME+C7Zu0EnOMRR6fSx7OhA6qMQI381J0FA81
         FFnSZn26fVuyiz2khw/g2c6/tRFxz3vAYx4jq2ko59z3iL2BlsuLIDGCBP/XfBpM2Ngl
         A3sr1law+wgYMN8IbKgwmjSKhkcHsLdiNr01iJryPVvkJh18jtPKpg9KoFOA0g1M6MNf
         ZDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712545; x=1712317345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUalL55AIOU3mZ2WBYhdqf1hXqkUUSaMPr9AFBYthp0=;
        b=UPB3Mg2yd1+hP8Pl0KO77iJVuk5Ae4V2M+MM8BliTWi2QiWAwPkYrKQDOuCcCu60ac
         LsKGRy+E2mS9gRMqToxG8WERn7Wr+QO/mKcosHoYtyaZSTYR+W6AEeYSDErj329bUmd1
         mVB7QpMsjaZ8Vw3nqBT8XDJsccad4fjv40Ilka8cmWI09x9En7EI6VuIeIDty0pW+eM8
         mC/cXS0FFIdCl9LaOg4e8i8W0e4nQDWplreQ1Uh36Ag3z2MfzzC7gIXA5HwSQj7ORIRE
         boK+OlP+NZtnoVu9yJoQiRuZgaqhJ9TKNUKnIxFhPVeXcEkBCjbjVDPllklUaBerNVND
         azHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm8kHyPj1QDZ4Cj6nZbDl9Kpdf7e9Xb5iqsruF/WNYf6s9Acx4LD73LhEHRUpZbleJygsxNW562VojTklQe9tt9J2LspG/duo1UuBG
X-Gm-Message-State: AOJu0Yy6P2RNQltRvdO1F8xZgSOA3QKkAwSzZLWD9wT6mNxG3jdAtkfU
	jNMxH4DOJ+XsqcJCO2NIOPnUKdamHZPQIIlk0yr1+uVyAGzxruP2Y/es2H+ZQeg=
X-Google-Smtp-Source: AGHT+IGiSqosCnBLAMcTvY/nyHiT3FMi0hle+9O+953imMzmRvuMPiWLGfCeGlXx9/PYkG8xxDuBMQ==
X-Received: by 2002:adf:e8c8:0:b0:342:37da:30ab with SMTP id k8-20020adfe8c8000000b0034237da30abmr1132186wrn.3.1711712544978;
        Fri, 29 Mar 2024 04:42:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id e1-20020adff341000000b0033dd2a7167fsm3992730wrp.29.2024.03.29.04.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:42:24 -0700 (PDT)
Message-ID: <7b4a35d0-6764-4c6a-9f1d-57481324c680@linaro.org>
Date: Fri, 29 Mar 2024 12:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDEvMl0gQVNvQzogZHQtYmluZGlu?=
 =?UTF-8?Q?gs=3A_Add_bindings_for_Cadence_I2S-MC_controller?=
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
 <NTZPR01MB0956230296D881F112F92D119F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <16f72b4a-2aa9-49d5-a4aa-ed94eea1f32a@linaro.org>
 <NTZPR01MB09563633F5C3B5FBC95D61289F3AA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <NTZPR01MB09563633F5C3B5FBC95D61289F3AA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 04:56, Xingyu Wu wrote:
>>> I want to keep the original IP compatible which can distinguish from the JH8100
>> SoC.
>>> Can I write it like this:
>>> compatible:
>>>    enum:
>>>           - starfive,jh8100-i2s
>>>    const: cdns,i2s-mc
>>>
>>> and I write this in the DTS:
>>> compatible = "starfive,jh8100-i2s", "cdns,i2s-mc";
>>
>> Can you provide any rationale for this? I asked "unless you have other
>> arguments", so where are the arguments?
>>
>> Nothing was explained in patch changelog. Nothing was provided in this email
>> thread.
> 
> I don't know if I understood what mark said[1]. Is it to keep the original IP and
> add other compatible?
> 
> [1] https://lore.kernel.org/all/27155281-573c-493d-96fe-1f28ebb0ce5e@sirena.org.uk/
> 

I stated and I keep my statement that such block is usually not usable
on its own and always needs some sort of quirks or SoC-specific
implementation. At least this is what I saw in other similar cases, but
not exactly I2S.

Therefore I think fallback is not usable here, thus please use only
starfive compatible. Drop the fallback. It could be added in the future
if I am proven wrong. If you think that fallback is usable alone, please
bring some real life case.

> Or should I only keep the compatible 'starfive,jh8110-i2s' and change the
> bindings name to same to this compatible?

Filename could be cdns,i2s-mc.yaml, assuming that's the name of original
IP block.

..

>>>>
>>>
>>> But this I2S can only use either DMA or interrupts.
>>
>> Just like many other components. DTS should reflect hardware. Hardware has
>> interrupts and DMA, right?
> 
> Yes. The hardware can use interrupts and provide the handshake interface of
> DMA to DMA controller. In software, we can choose only one between them.
> Do I keep them both in the bindings and provide the selection in the driver?

Yes.

Best regards,
Krzysztof


