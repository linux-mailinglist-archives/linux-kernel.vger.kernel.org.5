Return-Path: <linux-kernel+bounces-86286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D1486C368
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454191C20CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF14F1F5;
	Thu, 29 Feb 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRnN1GDG"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5741AAC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195146; cv=none; b=hF9TB3HlKe9/UGv25PDzpTT70QayGBTNFRMGhwuf386o58jtQovYulBrasgRDhaJyBWo+fFezglllmEEr24GjUilrA1kJlNc7/hoTVps4RVugod+5vvaUa8RJBSsZnIeGARULKg4u61hVKwbmUosn1KLXNRoZ35IGKzWRQzw7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195146; c=relaxed/simple;
	bh=+k6SMQqyldQYNx3b9w5bYaQJ0OzTpSI5/8PRew5oMq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2saZLA4+uQ9yX+hkPzl8sxML0UnysantIKX0aBkUbft4kQ+5LvuxKtBXfF3hsoPKDbmfDzukqo1poIRQA4Cea3nyO2D5No5LUrPkUaUWp3oo5+Ly56mpg2NGR9xc0HNPARXt04KInyxgx2REbFByWeCDCbqGEW4fipHNl5oS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WRnN1GDG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so112562266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709195143; x=1709799943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNXNtXezdPiz6WQwvH9xjCDeUeGJKj/mjFzziiI0LNM=;
        b=WRnN1GDGXIPPP1I7suTsKDwVNT3HVjSB/Ua//71/w6Jx0UvquPVeiDo62pzzL4+1MN
         ZdI4D+2uc/BQdPQ7oO3JWE9AMdrK1nGuL1P3c8GWd+0TlJI1jNLpqnJS5kYIbejrHvID
         3Tb9vtollxuPabklhC4+amiWCOKJWCdxXuzev66KadeJWCP/JYqbpVdOyMB9OOOglzSP
         dn1UbLDhGzPC8tQY8AQN/PYLnfsmcGvV8EFwvlBTsxEsZFkca6P71R067lnXSrI14O8O
         e4fI1N4NOAtnWseSlmmv+UyKipS+r0f50XNutzVfPMnLA4SMr8nM3JIIx/loxu18YoYx
         O3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195143; x=1709799943;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNXNtXezdPiz6WQwvH9xjCDeUeGJKj/mjFzziiI0LNM=;
        b=MTN4HMIBqHiKtBg2zcMLdTyZLb/I9d8hmMVHoEP+d1EHPAHagssBMtECy5ZlaPT0vb
         xApJnmkk/t5aYoGfdKKduO5hz0H1nObLZGqAN4PmufSxI89gIwKChckQRI+8QErrOPsU
         53IbZLwMFe5HZt1hEYYu8EF2yCnf94dxaFanBT/U+I/u0mvzGxjMzNEEFA2D/VpNJvG0
         ypR8MuM8bzKPti6IatgbEzvC0QxAxMpR1EvtCbsRUYLimJ5DwyUAiy6O0ORTM7vqm9hs
         eLvD0cHE2p43C6Ghn6ogO207xQbQnGL2AgPIEGKbC6sisDCRMbrHVIJ5Lm0KNKLagpwv
         qh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOPyxsFdnvOd20UUiyk2VPD7/OhXGndQ3L+TImwuM4lZqtKtavAMXpttYIpz+gQ4nWxrIX08MxcWk4BPoIap9XZ/81Y8Z274GUSiZp
X-Gm-Message-State: AOJu0YwJYJY1Rw1olJpVdhdLxx+B2jfEuLWTOEMkCGV9TvXlismpyTHV
	Aa58SRSRssEfZTOXJbtHNpRjRFGzqSRgnkjRbStQJ7mVIPkN7ffFmO24Rus2Sgg=
X-Google-Smtp-Source: AGHT+IEdRFYEnX4kAM1kYEF58dkyCyyKP45xIa7ZLp2VZd7u2TobvUB+aubfigdaalNJ9d2eEa2QgA==
X-Received: by 2002:a17:906:56d0:b0:a43:f22e:57a6 with SMTP id an16-20020a17090656d000b00a43f22e57a6mr715486ejc.67.1709195143177;
        Thu, 29 Feb 2024 00:25:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vg9-20020a170907d30900b00a4439b7756bsm434508ejc.6.2024.02.29.00.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:25:41 -0800 (PST)
Message-ID: <32ff2f66-7a94-41ed-b77b-f78da2e57446@linaro.org>
Date: Thu, 29 Feb 2024 09:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] ASoC: dt-bindings: mt8195: Document audio-routing
 and dai-link subnode
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 broonie@kernel.org
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com, amergnat@baylibre.com,
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com,
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com,
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
 <20240227120939.290143-19-angelogioacchino.delregno@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240227120939.290143-19-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 13:09, AngeloGioacchino Del Regno wrote:
> Document the dai-link subnodes and the audio-routing property, allowing
> to describe machine specific audio hardware and links in device tree.
> 
> While at it, also deprecate the old properties which were previously
> used with driver hardcoded configuration.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


>  
>    mediatek,adsp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> @@ -45,12 +56,75 @@ properties:
>        A list of the desired dai-links in the sound card. Each entry is a
>        name defined in the machine driver.
>  
> +patternProperties:
> +  ".*-dai-link$":
> +    type: object
> +    description:
> +      Container for dai-link level properties and CODEC sub-nodes.
> +
> +    properties:
> +      link-name:
> +        description: Indicates dai-link name and PCM stream name
> +        items:

That's not a list, but just enum.

> +          enum:
> +            - DPTX_BE
> +            - ETDM1_IN_BE
> +            - ETDM2_IN_BE
> +            - ETDM1_OUT_BE
> +            - ETDM2_OUT_BE
> +            - ETDM3_OUT_BE
> +            - PCM1_BE
> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          sound-dai:
> +            minItems: 1
> +            maxItems: 2
> +        required:
> +          - sound-dai
> +
> +      dai-format:
> +        description: audio format
> +        items:

Ditto

> +          enum:
> +            - i2s
> +            - right_j
> +            - left_j
> +            - dsp_a
> +            - dsp_b
> +
> +      mediatek,clk-provider:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Indicates dai-link clock master.
> +        items:

Ditto

> +          enum:
> +            - cpu
> +            - codec
> +
> +    additionalProperties: false

This goes either to the top of the section (after type:object) for
readability or after required: block below.

> +
> +    required:
> +      - link-name
> +
>  additionalProperties: false

>  
>  required:
>    - compatible
>    - mediatek,platform
>  
> +# Disallow legacy properties if dai-link-xxx nodes are specified
> +if:
> +  not:

I don't think this works. To test if node is present or node, you would
need to use required.
https://elixir.bootlin.com/linux/v6.4-rc7/source/Documentation/devicetree/bindings/net/qcom,ipa.yaml#L174

Are you sure this if:then: works as expected?


> +    patternProperties:
> +      ".*-dai-link$": false
> +then:
> +  properties:
> +    mediatek,dptx-codec: false
> +    mediatek,hdmi-codec: false
> +
>  examples:
>    - |
>  


Best regards,
Krzysztof


