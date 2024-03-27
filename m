Return-Path: <linux-kernel+bounces-120324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B166B88D5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51A51C239F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8ABE572;
	Wed, 27 Mar 2024 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfODwxVA"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC4175AA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711516344; cv=none; b=APwOy/EaoszVfiFlshWus0rke2sYc/fCRPh0KYNx+xXRA4a4t4l4CU7ZlUVuf+baBZnrqtO5L2jii/RDZJkElEu3sO2nKTRrhPG+f3BCm3cYnYLdPcPbriWUalwJXXc4lFl6Stm+TW1ybd0AGOgLaFFUSBt9yeGMBbk4v/capuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711516344; c=relaxed/simple;
	bh=IJHWOnTINFpZXZ9g/2/P87Myf9jBqm+cXzXz94G2KlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KStyLu1G0fL8Ts3kkurj7+OOJOmcDoHsp3PH7id/qBrZbpyJQrSA6fxfoOqtWnAJLuV3oMNznHLy1ybamwHmcK/ar1FGda4T47y/C5/z5wuo2ywH8rEtg6PFzZmlxK2pfzruDwBK08+UmUGr1E5O8OHSAWvcFx9lkQ7h1+XK8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfODwxVA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45f257b81fso727149966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711516341; x=1712121141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwtti/peMihUTMyAzlCIGMLulrpmjqLQzU4QpF2mNKU=;
        b=bfODwxVA6gLQY/wRvXPxQwa9E0IzaOHTWuRX5OqVDBWTXaH+rr+xnko3IJ+KJaHnda
         L5AfneDqzz6q2NDenZ06x68xUpar3pZaYmE0oFnRWUgpH5SVU1y3YKKEJA4hLP7iA7dW
         tQM1s28LUDxSgTczcglAPprIqneGY70vXg5b4g3Cl+6wC8FXsJj9nW8vfXH7ocULLadT
         6kwJhhEDzW/VXkalS+YQv5R2UhBvIFmZRlUk7ovY+E53WddIs3ZLfyEjXRI2QVEffopK
         HWmIuXJuHP7i3MDYUDtdkcoDkbqQF7f5jheag/BiKgfZsHdgd3PUe+c1nGwWUyuSXrfF
         QFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711516341; x=1712121141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dwtti/peMihUTMyAzlCIGMLulrpmjqLQzU4QpF2mNKU=;
        b=TyHa9enUaCr1eOwE1uACs7hgmPkGPst6+7AeR2DHk5AEJcSMBNImx8quCaG93VWshp
         S73z3MKtYTmNha5ZkSwOkfblYPPzMxyMJYARUYyoTyJvwDmmBQsg0EmTwuBOoVKLBBfo
         V1lVukzUQ586vd/i7N5xaC/UI3zKZT+u3S7Ae4t8LjzPrMvkvOt9xbqv1kvy47i/KBRG
         xD8aoU7b53LWluhQKf4K9YgWE4MckctHaEbhJM4xxl6lEZTXb5MsOhFg/b+vf26rlvws
         oIvt3Y3w6akZ8xY+lB9eJdgz/daUgTFKTWS6HImdeqx30COlxQ+RMIbde/UJvII2MSPr
         BHLg==
X-Forwarded-Encrypted: i=1; AJvYcCW2llocjZ9jCns+EGywzJE8vVKttZiDTMYIAw2iQ5H8Z1311nqxqqYwSNy+fdgxS4yXx7eBfgVQ3VayULq4DJhz7cmmPdUPpIFwf99D
X-Gm-Message-State: AOJu0YzfUwPGa/aB7Xce+eX0z3Xpj7w1cQGqLy1TeGEnE5+oX9NJtQ6d
	JgeHENfsWdxQIF81QlUi9yvApWGG28CtPGO05ZhPaYCQwTo7kSUTK+2sC5WoZaY=
X-Google-Smtp-Source: AGHT+IElJpw3yCm9S4l81YiCAYTFbqQcMEaxlCe/Y/vun3hBezNkXoQkI96UNC8LRjTdHliw/4EueA==
X-Received: by 2002:a17:906:dfd7:b0:a46:f6fc:1fda with SMTP id jt23-20020a170906dfd700b00a46f6fc1fdamr92944ejc.20.1711516340821;
        Tue, 26 Mar 2024 22:12:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id kq1-20020a170906abc100b00a46a04d7dc4sm4957769ejb.61.2024.03.26.22.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 22:12:20 -0700 (PDT)
Message-ID: <16f72b4a-2aa9-49d5-a4aa-ed94eea1f32a@linaro.org>
Date: Wed, 27 Mar 2024 06:12:18 +0100
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <NTZPR01MB0956230296D881F112F92D119F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 14:43, Xingyu Wu wrote:
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - cdns,i2s-mc
>>>>
>>>> Why did this appear? Who asked for this? Usually these blocks are not
>>>> usable on their own.
>>>
>>> I wonder if I should keep the original IP compatible. Do I not need it?
>>
>> As I said, it is not usable on its own, so unless you have other arguments then no.
>> But my point was that no one asked for this.
> 
> I want to keep the original IP compatible which can distinguish from the JH8100 SoC.
> Can I write it like this:
> compatible:
>    enum:
>           - starfive,jh8100-i2s
>    const: cdns,i2s-mc
> 
> and I write this in the DTS:
> compatible = "starfive,jh8100-i2s", "cdns,i2s-mc";

Can you provide any rationale for this? I asked "unless you have other
arguments", so where are the arguments?

Nothing was explained in patch changelog. Nothing was provided in this
email thread.

> 
>>
>>>
>>>>
>>>>> +      - starfive,jh8100-i2s
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    description:
>>>>> +      The interrupt line number for the I2S controller. Add this
>>>>> +      parameter if the I2S controller that you are using does not
>>>>> +      using DMA.
>>>>
>>>> That's still wrong. You already got comment on this. Either you have interrupt
>> or not.
>>>> You do not add interrupts, based on your choice or not of having DMA.
>>>> Drop the comment.
>>>
>>> Do I keep this property and drop this description?
>>
>> Drop description. Keep property, if your hardware has interrupts.
>>
> 
> Will drop.
> 
>> ...
>>
>>>>
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - clocks
>>>>> +  - clock-names
>>>>> +  - resets
>>>>> +
>>>>> +oneOf:
>>>>> +  - required:
>>>>> +      - dmas
>>>>> +      - dma-names
>>>>> +  - required:
>>>>> +      - interrupts
>>>>
>>>> This won't work. Provide both interrupts and dmas, and then test your DTS.
>>>
>>> I provided both properties in the DTS and test by dtbs_check. Then it printed
>> that:
>>> 'More than one condition true in one of shema: ...'
>>
>> Exactly. Having both properties is a correct DTS. Interrupts do not disappear just
>> because you decide to describe DMA. It is OS choice what to use if both are
>> provided.
>>
> 
> But this I2S can only use either DMA or interrupts.

Just like many other components. DTS should reflect hardware. Hardware
has interrupts and DMA, right?

> 
> Can I use the config (like SND_SOC_CADENCE_I2S_MC_PCM)  to choose DMA or
> interrupt if having both them in DTS?

Don't know, I tend to focus here on bindings.

Best regards,
Krzysztof


