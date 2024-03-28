Return-Path: <linux-kernel+bounces-122625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16B88FA86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BE3B27014
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07175789B;
	Thu, 28 Mar 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ie1uGaH2"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699454775
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616280; cv=none; b=pFe+YyNS72VBVts9VBuilEupy1KlNP9Y+SnOBr0fIx3KTMhPumxkDjSig0UpPxBK+Q25JmKfOBjbiX6CUYRh9T4HuIWMpXgC8K81Jh9YU12LmI62WHA2sNiKxsYza5/aJQHUUycF0/ZL6o/OjbhCxegF4FM3ePe4WP0pkAU9ppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616280; c=relaxed/simple;
	bh=ooRUq2ddQ1vPC7829e2Ird4axfo+2+6ZaBjqXrgySis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHY8WJTTr0sC0agQtdCq1fKi2uAZZT4PKDXBOfiVE1RxO0FHlyJSlzeb3vyOktFsXx9Pq65XCFJwGji0XqRTh5Ng8/HlCcHbNSEZcnwo3SSlWJfZic61J+rIJvmZq0QZ3RqREpCtxaGMNW9vd192roKeuvIR0W3heVYaTbpj5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ie1uGaH2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4149532da36so5293275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616277; x=1712221077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NRShXC1zO3OpW0uGpvJKq5K43bHvLfKJ1qejl8dVl2Q=;
        b=ie1uGaH2IAswfA94nIFxAzoOiQhv9oQ7Z325ANg3IJtoc1CdVy8A4u3almucFDAG0j
         0tWcnXJGUtU1mioXlnNFSKWqv53hNT8uPvET4K7yb2zlqZMu9fIkYiuZCM/nR0QzYtA1
         jSkvlJe85ISkejMnwgBu+BHH5nSVJdWf7J+/nsuqRkmpr7elLGyZ8oQrMx8OOl/4nQXt
         6vvF66yWrMGODUQN5uadlCDwv8yipfOr1HAe65T4RMMDullfgevXiuuox+GFJ8jkMtQ6
         J/bYK9AbG9EG9VOMH5iLHwMTUpictQSsEkzzMoI7s4/DvhQRQ2bsSl73Ic92XpafWp7o
         hmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616277; x=1712221077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRShXC1zO3OpW0uGpvJKq5K43bHvLfKJ1qejl8dVl2Q=;
        b=ILvSNRbkuCXDpGBj4+bIqZ7lNlnW6UiYz0UDwhawm/k9l5+HEnpGBFjV0YURnT4phf
         vXKZk1Ut/ILMQ8uQXFkJ7qFQRngywYrla9Vfeh3nHEykOajml9jxAcxsNiBTtz7PRgmV
         wQXHHgqFZwBm8vH5IkdlKgYGEvC7Evkg89RMhPiEztQpPm7KRN0Cv48QSxq9jk97/jdy
         OiU6PcC4iKzn5ux16/ND5VZBUSP6Mu+OT5ODcfRgloh8K1O+ehQx36VOD1jMfsKKJ5hw
         hDLKJSfuRa1bZ0yDC6pS3xGs5WbaByH8rTLPqNF7r4CsMqgMODoCnJq1Z3m7vI7xuteo
         xRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBaiy1MvGVKtenEVKCT44j6af4/IxxqILpcAAL7HHe83AiNcP0oi0Qfkg1dIQrXLRxR+wxPO7o6QH7WBU090H8pqv0uwytjiH2uwOB
X-Gm-Message-State: AOJu0Yx2ayBIr1/OqYwiTA7aGGOV886+KO3jdD8TGt/sduP8d/vOUM6I
	xhdCmLE7hE1niG0t5ayC8yuHO6CF+ydw+hlv13smBeHBelJMszACEJKxjhV+/8kDb8dvFiMBvKC
	j
X-Google-Smtp-Source: AGHT+IGClEr9Xl46lzchyoUADhh1NeJly47SViYywtFBwPicFQjYByaG0eB1JYYqM2Y+qq5k+R9jQw==
X-Received: by 2002:a05:600c:154a:b0:414:71d8:9c87 with SMTP id f10-20020a05600c154a00b0041471d89c87mr1668021wmg.19.1711616276716;
        Thu, 28 Mar 2024 01:57:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0041469869d11sm4703990wmq.47.2024.03.28.01.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:57:56 -0700 (PDT)
Message-ID: <5b917ec7-f8f8-489c-a804-70ea603262dd@linaro.org>
Date: Thu, 28 Mar 2024 09:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ti,pcm1681: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328014029.9710-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328014029.9710-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 02:40, Animesh Agarwal wrote:
> Convert the Texas Instruments PCM1681 bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../devicetree/bindings/sound/ti,pcm1681.txt  | 15 --------
>  .../devicetree/bindings/sound/ti,pcm1681.yaml | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1681.txt b/Documentation/devicetree/bindings/sound/ti,pcm1681.txt
> deleted file mode 100644
> index 4df17185ab80..000000000000
> --- a/Documentation/devicetree/bindings/sound/ti,pcm1681.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Texas Instruments PCM1681 8-channel PWM Processor
> -
> -Required properties:
> -
> - - compatible:		Should contain "ti,pcm1681".
> - - reg:			The i2c address. Should contain <0x4c>.
> -
> -Examples:
> -
> -	i2c_bus {
> -		pcm1681@4c {
> -			compatible = "ti,pcm1681";
> -			reg = <0x4c>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml b/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
> new file mode 100644
> index 000000000000..4093d0ff654d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,pcm1681.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments PCM1681 8-channel PWM Processor
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>

Why not existing driver maintainers? Do you have this device? Or use it,
or care in terms of your projects?

> +
> +properties:
> +  compatible:
> +    const: ti,pcm1681
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +

Missing dai-cells, $ref to dai-common and unevaluatedProperties: false,
just like in other simple DAI devices. Mention briefly in the commit msg
adding these ("Make bindings complete by adding #sound-dai-cells").

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pcm1681@4c {

Datasheet says it is dac, but we usually call it "audio-codec".

> +            compatible = "ti,pcm1681";
> +            reg = <0x4c>;
> +        };
> +    };

Best regards,
Krzysztof


