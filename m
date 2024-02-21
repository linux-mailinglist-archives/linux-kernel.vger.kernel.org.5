Return-Path: <linux-kernel+bounces-74237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352C85D170
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4A01F25465
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12C3AC19;
	Wed, 21 Feb 2024 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tp1iY+NL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8A39FE4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500789; cv=none; b=CV+d2UwaKRDzEJDkBz7IU5PL2HuY5j5Tk80W9FGmQho9iDVZA+dXpCRbxVPdccY9HlX84E0sC74fmDIPQg0mMsmNmi/Wsp2FJw5ID5xLr6u9Xxe576q7e8V/7X5FTYWSCpHHXZWkofgsjr6HuJ3sNjuTlo8opBRPDx37VoggIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500789; c=relaxed/simple;
	bh=sR//o/tuJf857xJLOyU2EoRSgAjpFAylMFwVtpE+sCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXdN+22qWBdTPn7iVyFcr/7kVRHVASxOzRWdP+6mb6iWY21rSxwYZKyVcESkPjvs5i7INNs0yR+XVmK9thWU6pzL7oQ0hUHUFFwcy9McA4zAdSRtRMj/xB8KBU36o4ysWvKiMPWdg2f2S4ekMH3r8b5/fMHe9p7uzDzMesPSEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tp1iY+NL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e87b2de41so299689966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708500786; x=1709105586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ge+YsHI3pA9L1s6/L6Hl+8/Uj32oY85P6VFsTj+jp9s=;
        b=tp1iY+NLQyKsEQAyWwba6C1Dtk7jcQKs8uz51ILWqw4522efrbPBdHFv04K1vHT/7Y
         Gfibl0KuHbr+wMZazDAM5bnYFBJbizHmI6UOJg1G9zBOuysadhPcRYGel6HkOvjLbioP
         CxUQm6bNZMnfIYRDAu+TQe7RIIjldMYcJmTaVkkoM9UuKN2IwKLmmCdd2eFJE8ib03Kd
         O7lgJ03vN39uoPysqVyfbW4B94sjB0Vr5NtcsgWgvwCy2+3F2Fo8OvBnbzDoOiCstUw3
         mkcMfqtmLElK5BWgzbW0bFnZybmMaIJIt5UmSydHG871iV4r4kmmeNct/sW5pHtPw0G0
         tiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500786; x=1709105586;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge+YsHI3pA9L1s6/L6Hl+8/Uj32oY85P6VFsTj+jp9s=;
        b=Dp9ni1yoeGuvyyWqz4Z34IZi4AgjolUORgiMsHU5Ccx0EqpivxmeucxJre7ie6Lo5y
         0YZe8wsVRTZIu1ICW7yiUTnZEI0zGsGvMdu7urBJTTle6G8FKvMR8Ugi/wIEWnBY8oZG
         2Y+RTx2AhkDPT7sjRHWBn8BQeBhLFWn7w+T+Mo1YlMJ5pF1dNQPu4W+xLlJUB4GXtXl3
         byLzki3oVzIyFyhQRCrGh46BaOyoCMUh3Xem+REUyFkBCLiJ/1cDgNYH6x/Z8AQr6rv3
         nEDl40uZBupqVMN3f4Y+upf8zXaUKoKw6mpsP1WSajR16vvLV1ICQubgvdfTdDE3ZLrW
         DTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrntHV9yzvCtH5BmZWQ//SIVSUs/YRGRg3ryH+5YrCaz5O6V1NabGR40wm8HwoB35sTh8eEKwas/5sSWwl5eB2k9RJ8EsXm11uZ4bZ
X-Gm-Message-State: AOJu0Yx9lkAdhgQizzkdpBN9TveUWSgR2EgcY4egpoIf5uBaBs08XlLE
	/McZX26KVgz5McExBIx1ldSra65xm4R6JYp6Qu7T4cPxzE4UmndaAF6usm4IPOI=
X-Google-Smtp-Source: AGHT+IHWzQ5/tTM5Uqis2UhNSPWnEXfUlTqsaXLus/bMg3HEQg2kJ0AW5ft9wP/BnmHfjxFeGZBqzQ==
X-Received: by 2002:a17:906:eb19:b0:a3e:d0ab:5fac with SMTP id mb25-20020a170906eb1900b00a3ed0ab5facmr4686121ejb.28.1708500785945;
        Tue, 20 Feb 2024 23:33:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709060e9200b00a3d153fba90sm4636654ejf.220.2024.02.20.23.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:33:05 -0800 (PST)
Message-ID: <c6dbbb75-a67e-485f-8e00-3be05fb53b7f@linaro.org>
Date: Wed, 21 Feb 2024 08:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, linux-kernel@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
 tiwai@suse.com, 13916275206@139.com, mohit.chawla@ti.com, soyer@irl.hu,
 jkhuang3@ti.com, tiwai@suse.de, pdjuandi@ti.com, manisha.agrawal@ti.com,
 s-hari@ti.com, aviel@ti.com, hnagalla@ti.com, praneeth@ti.com
References: <20240221051501.627-1-shenghao-ding@ti.com>
 <20240221051501.627-4-shenghao-ding@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221051501.627-4-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 06:15, Shenghao Ding wrote:
> PCM6240 family chips are popular among audio customers, in spite of only a
> portion of the functionality of codec, such as ADC or DAC, and so on, for
> different Specifications, range from Personal Electric to Automotive
> Electric, even some professional fields. Yet their audio performance is far
> superior to the codec's, and cost is lower than codec, and much easier to
> program than codec.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> Change in v5:

?!? You got review which you ignored. Now you rewrite everything?

>  - Rewrite the subject to match something similar to other commits.
>  - And none of them are compatible with something.
>  - minItems, then maxItems.
>  - Drop reset-gpios description
>  - Remove the repeated reg descriptions and reg constraints.
>  - Drop redundant spaces.
>  - Add missing line breaks between blocks and additionalProperties.
>  - Correct compatibility issue on adc6120 and pcm6240.
>  - All these chips have only a portion of the functionality of codec,
>    such as ADC or DAC, and so on, but their audio performance is far
>    superior to the codec's, and cost is lower than codec, and much easier
>    to program than codec. Simply one or two register settings can enable
>    them to work. Init for these chips are hardware reset or software reset.
>    As to some audio filter params for internal filters, it is up to the
>    special user cases, which can be saved into the bin file. The default
>    value also can work well.
>  - Add blank line before reg.
>  - remove unneeded items and if branches.
>  - Add missing compatible devices, such as adc6120, etc.
>  - Add necessary people into the list for DTS review
>  - correct misaligned.
>  - simplify the compatibility
>  - Add sound-name-prefix

Didn't you do all this?

..

> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Invalid only for ti,pcm1690 because of no INT pin.
> +
> +  sound-name-prefix: true

Drop

> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,pcm1690
> +    then:
> +      properties:
> +        interrupts: false
> +
> +additionalProperties: false

unevaluatedProperties
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c {


This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof


