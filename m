Return-Path: <linux-kernel+bounces-143165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C5B8A3545
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A484F1F234E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565D14E2F5;
	Fri, 12 Apr 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fY9tdDir"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9514D708
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945011; cv=none; b=Xh8bCyHDPfLV/Yk4VUf3CUvHmhOLQVwsBz+xAM3wUNL/f+yaV72brU97iXsu1fqWqdwnaahu8toubLBzN1oj5ENoogGW6dSSxL4oLzr7WOKMzqiMtFgpgDueuSnj4iNqNeVJsDkEGPRn4E54jxp+0FNbGXagww41yxwcYrKEyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945011; c=relaxed/simple;
	bh=/lxF20mKrFXMIZ123CDSd95uJ/Clv7SZv23meh+yWLU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vEEq1zc3FER7oLi0+rogsTXwXvpDW15QxIaVXDj3qQMllHAHLgIC2kzbWBxC2ijo4xqSwuNYLdlxk1YXjGLN2HA1zA7LQu2ogzFfUJ9YonHiZSf8hiBQ86c/M7cTWOY//P3kcglHu68RaAI791YbbLwQDLR/xOvmLqGwtpgkwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fY9tdDir; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a450bedffdfso154321566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712945007; x=1713549807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HR/aAkjvKF0fR28DfhCSal3L9DD0SQbRu453C6NBc70=;
        b=fY9tdDirZgdKAX3UPB3LrS8X872i2mS1PervnP62wNuRuF3q7ET88+tp2Aso4Oetta
         g+XMxK+2bKfXRv8mNyMAC8dOjJJFEwGCuWFzBSFr7WxLrC2gORFAHFQqJJf8NlSmN8bh
         MwfGtJ5GXDBfEQA67ERxe4C7RAJiTfmIhqPBfU2VKwVQklBijyjNpOFSfinItbnq8baA
         NfQ5LfoY9c0QifAIXIbvkSTsJbSL2oJ3U6zYzzka7GaoNUcNWeDREqRDzIc+HFa1bOdp
         7YX4OvhnHGW2oWNVGGQkT21T2Ij64jH4mF2X7Vhr284gIQ3h7BuLogP0YUBvK9DBqVhS
         Q+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945007; x=1713549807;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR/aAkjvKF0fR28DfhCSal3L9DD0SQbRu453C6NBc70=;
        b=qEjkD6QIFEnPXhu2dpU3RbWM90e6uddDVBkBBzPwQXRnCZ+qMZxcKV5vgvBYkABLLd
         RI/M+t4tlIBqSotGWclTfCH43QRAduiZZTIo7ZrbD/oGGaEXxM7tPGsZU9iawRfuQt0C
         HmupQ7ksf6WkHPsBPa2pTl2HuuyB/Tae4AGLmB1NQClfl+16S/SamSmTl1SU9uXE1O4X
         k9dn696fNaIp0dxHzxHCDyCIbFSscnf7njzO+CHey/73j7CaUcTkfF5EigL6wZxrLu8P
         Tlx0gJuTxunOW1BQc8g1yTyI33YiOmu5Ul9PcZXx08KrmmQAOvT3Rj6K2jZKU1F9zZ6l
         DHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVlJQ5nU1DzMTJxm7hhNeiecT+jWD980BfqyQ0aX4zM3HR5o0OVjX4sB/4N6uA6BJW6ud5hKnDJR/uoLmY8rxPtKmjiSZ3pPPFLVJ6S
X-Gm-Message-State: AOJu0Yz8k5tH/ucewrR64kCFB6g/3u49aBtXOxdxPo+SsjutPwa68chJ
	lr5znlawS+ptU2lafViF6Kz2mFgrfLmlWD9ED5RkBYl8x8BUqwFX7ZTgEP34C9w=
X-Google-Smtp-Source: AGHT+IEuWD72JZ9Ik4dvihzkKi11pD0lYAKVIEdiAiY1u2CC2sce6QkxEAvKZljKbXNtcDpCX/U3uA==
X-Received: by 2002:a17:906:1589:b0:a51:b1b1:b772 with SMTP id k9-20020a170906158900b00a51b1b1b772mr1918124ejd.65.1712945006687;
        Fri, 12 Apr 2024 11:03:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b00a51ab8fc2f9sm2063689ejy.67.2024.04.12.11.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 11:03:26 -0700 (PDT)
Message-ID: <c7e243e3-3f61-4d63-8727-3837838bdfcc@linaro.org>
Date: Fri, 12 Apr 2024 20:03:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add Amlogic T7 Reset Controller
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: neil.armstrong@linaro.org, kelvin.zhang@amlogic.com,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
 <20240329-t7-reset-v1-1-4c6e2e68359e@amlogic.com>
 <927ad2cb-3b41-4eda-b930-856be64ae9ba@linaro.org>
 <10650c59-96f2-4234-b5fd-aa8efec90e5b@linaro.org>
 <579a1569-7bba-491f-ba5e-7cfcb34ccc1f@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <579a1569-7bba-491f-ba5e-7cfcb34ccc1f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 19:57, Krzysztof Kozlowski wrote:
> On 12/04/2024 15:12, Neil Armstrong wrote:
>> Hi,
>>
>> On 29/03/2024 20:39, Krzysztof Kozlowski wrote:
>>> On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
>>>> From: Zelong Dong <zelong.dong@amlogic.com>
>>>>
>>>> Add a new compatible and the related header file
>>>> for Amlogic T7 Reset Controller.
>>>>
>>>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>>>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>>> ---
>>>>   .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>>>>   include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
>>>>   2 files changed, 198 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>> index f0c6c0df0ce3..fefe343e5afe 100644
>>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>> @@ -19,6 +19,7 @@ properties:
>>>>         - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>>>         - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>>>         - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>>> +      - amlogic,t7-reset # Reset Controller on T7 and compatible SoCs
>>>>   
>>>
>>> If there is going to be any resend, please drop the comment. It's not
>>> really helpful and makes it trickier to read.
>>>
>>>>     reg:
>>>>       maxItems: 1
>>>> diff --git a/include/dt-bindings/reset/amlogic,t7-reset.h b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>> new file mode 100644
>>>> index 000000000000..ca4a832eeeec
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>> @@ -0,0 +1,197 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>> +#define _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>> +
>>>> +/* RESET0 */
>>>> +/*					0-3	*/
>>>
>>> I assume this matches existing drivers which do not use IDs but map the
>>> binding to hardware value? I remember we talked about changing it, so if
>>> something happened about this and it could be changed: please change.
>>
>> I'm not aware of such discussion, and I don't really see the issue...
>> thoses are IDs, and yes they match the Hardware offsets, and ?
> 
> Bindings are not for hardware offsets/values/addresses. It's just not a
> binding.
> 
> I quickly looked at your driver patch and it confirms: not a binding.
> Binding constant is used by the driver and DTS consumer.
> 
> I am really sure we had this talk in the past, but could be I think
> about different platform. Since this is not a binding, I do not think
> claiming there is any ABI here is reasonable. Feel free to store them
> with other hardware values, like in DTS headers etc. We already moved to
> DTS headers several such "non-binding" constants.

Un-acked.

I looked at my archives and we did talk about it and you were CCed:

https://lore.kernel.org/linux-devicetree/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
simple-reset is an exception.

So to recap:
That's not a binding. Don't add some real values to binding headers
because it is not a binding then.

https://lore.kernel.org/linux-devicetree/CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com/
https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/
https://lore.kernel.org/linux-devicetree/b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org/
https://lore.kernel.org/linux-devicetree/418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org/
https://lore.kernel.org/all/201401111415.29395.arnd@arndb.de/


Best regards,
Krzysztof


