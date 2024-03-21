Return-Path: <linux-kernel+bounces-109780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A188559F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB874282C80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA469947;
	Thu, 21 Mar 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFd0EZ4s"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4958ACB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009460; cv=none; b=X/0NQQyQ8IXuTGA98oDxIuFkChV5+TMLjJav3jbNd1rMcU4Bv84Kse7v0xbhgcwVRZiOOhPGVjZKn4xXv5vphS3zlb+AqaAIGbIwiS259DDFtIdytq2H0wluWpsYUKJrHX9otjJaaHWPwhfARoLBQruPwE3PjY6gpetAjUxBxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009460; c=relaxed/simple;
	bh=puypE/cD4qoL7TggRdj4y0HLYHlNQcFzzc+Li1UZ2kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scwFOPpR0Ih+BClKHGZS3S9YgXp2QLX+S+/M/0OCh9xlIaIWFnB73RbOO+BtflfWXPg6qTv8gccZRk0N1M491o+LAoRcIq3qCiv3BN6bJ9c1uOU8tQJ/LYKbYQtkhSXn5ezmMiZaU3dKiA599mUOTiLbL5qxbMRf3lHzkcSs/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AFd0EZ4s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46ba938de0so91475766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711009457; x=1711614257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+UypPW8gPwDLXrQUnDbD7DxFqZiEj0eZW8k1MOScP+U=;
        b=AFd0EZ4sw8lzS7CjgGAzvVy3q1l9AwT4ythC+6Ib3IRj4mrKZDLuBkOUDRj8IoyBfx
         WuSvemsTMycRvIhhcIPBJAEASeP43y2KkTPNPl1S1Gb9SokTcZpifueb/MZMYAOummf0
         B620l24O9i5mWxQJWBUO+jESFuKNkjvb7serpXyRTcLTH353unomYdG/pOXsh5+fQgQQ
         HP0GjbqR+4mWpUX/tP89nbxwFOlncfWxbyw1p2d5ZD/0gZ3jv4rXpZ0dluvKjkyfxsq3
         vk2xPR5/4YMkUYYJj31AQDuiYYBmwosJy5QQGNTpnrKtVTJ5wEgmnHnH9TIBlPgWvwe/
         /DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009457; x=1711614257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UypPW8gPwDLXrQUnDbD7DxFqZiEj0eZW8k1MOScP+U=;
        b=u7f40mJT+BSc54aoE0EXDCzoAtyft00QKWFmZr9N2tqHP4Q1SWLCk2C0ODOFEDLpMh
         qS847Du5gSPhtNoM5+Tr5wudFPVh84q2Z0v7mqwOZ71wiKcrl2H9I0Xxk7X6jVDVbrGY
         e9bAenvCKNGhYZ6BfL6Zd80j1zNb9k57DKned9nYwNnZ7mkR2wyZh20HPLWhzxqTyxB+
         E+TbMqzQX3uNkzlNPteofoG5OXqc3DWLDMLF1O9qQGpZ7Ra7IFIIdpvTXf1wDFw+AGda
         quwqJityVqIZJLrowJc/3j0ZUNqQh48nj3nNd9mSgSB744gTLVlSvkyX/iPygTbyDn1n
         n95Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1zwFdQKBEo6zfuM4F+SLLQBxfHuwhNaB2R5EfauupBKce1okbTqznSMSMkOwmqcWcDn96jL0127IHCFLTJ0aO8sERWEITjZEj4SP0
X-Gm-Message-State: AOJu0YxoLXxkKYnWnv1v4mAq7A/Pgo6gMRZr0fqhbHrN/DioVFVt730/
	GmdTNDRVfMozb+U6gi4ut52NAir8tQW4jfJfqsJuQwp1bECwSoK/NFtOugm1pBw=
X-Google-Smtp-Source: AGHT+IGnBqvwAnhgvz2ONAGBSV04k1AJkK5A2dPVwZs64JtSxb2/pkLeOZkuNPJugcGk81huW3bM2g==
X-Received: by 2002:a17:907:940c:b0:a46:ea52:3ed2 with SMTP id dk12-20020a170907940c00b00a46ea523ed2mr4872278ejc.44.1711009457118;
        Thu, 21 Mar 2024 01:24:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id jz8-20020a17090775e800b00a4644397aa9sm8164487ejc.67.2024.03.21.01.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:24:16 -0700 (PDT)
Message-ID: <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
Date: Thu, 21 Mar 2024 09:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Add bindings for Cadence I2S-MC
 controller
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320090239.168743-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 10:02, Xingyu Wu wrote:
> Add bindings for the Multi-Channel I2S controller of Cadence.
> 
> The Multi-Channel I2S (I2S-MC) implements a function of the
> 8-channel I2S bus interfasce. Each channel can become receiver
> or transmitter. Four I2S instances are used on the StarFive
> JH8100 SoC. One instance of them is limited to 2 channels, two
> instance are limited to 4 channels, and the other one can use
> most 8 channels. Add a unique property about
> 'starfive,i2s-max-channels' to distinguish each instance.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../bindings/sound/cdns,i2s-mc.yaml           | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cdns,i2s-mc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/cdns,i2s-mc.yaml b/Documentation/devicetree/bindings/sound/cdns,i2s-mc.yaml
> new file mode 100644
> index 000000000000..0a1b0122a246
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cdns,i2s-mc.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cdns,i2s-mc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence multi-channel I2S controller
> +
> +description:
> +  The Cadence I2S Controller implements a function of the multi-channel
> +  (up to 8-channel) bus. It combines functions of a transmitter and a receiver.
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,i2s-mc

Why did this appear? Who asked for this? Usually these blocks are not
usable on their own.

> +      - starfive,jh8100-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The interrupt line number for the I2S controller. Add this
> +      parameter if the I2S controller that you are using does not
> +      using DMA.

That's still wrong. You already got comment on this. Either you have
interrupt or not. You do not add interrupts, based on your choice or not
of having DMA. Drop the comment.

> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bit clock
> +      - description: Main ICG clock
> +      - description: Inner master clock
> +
> +  clock-names:
> +    items:
> +      - const: bclk
> +      - const: icg
> +      - const: mclk_inner
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel
> +      - description: RX DMA Channel
> +    minItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +    minItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh8100-i2s
> +    then:
> +      properties:
> +        starfive,i2s-max-channels:
> +          description:
> +            Number of I2S max stereo channels supported on the StarFive
> +            JH8100 SoC.
> +          $ref: /schemas/types.yaml#/definitions/uint32

Properties must be defined in top-level. You can disallow the property
for other variants, but I claim you won't have here other variants.

https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L212


> +          enum: [2, 4, 8]
> +      required:
> +        - starfive,i2s-max-channels
> +
> +required:

required goes after properties.

> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +oneOf:
> +  - required:
> +      - dmas
> +      - dma-names
> +  - required:
> +      - interrupts

This won't work. Provide both interrupts and dmas, and then test your DTS.

> +
> +unevaluatedProperties: false
> +

Best regards,
Krzysztof


