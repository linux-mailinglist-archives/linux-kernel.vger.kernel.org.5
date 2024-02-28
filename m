Return-Path: <linux-kernel+bounces-85158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AE786B143
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D65B2813A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026211552EA;
	Wed, 28 Feb 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKxron1X"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A9151CC5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129182; cv=none; b=NqVL1VFytImuYRXyV7AQwpLhko8oxZHxtmHTVZC3hlzEGzCk4kAoBqx7QQJtQyUWqZrDlh8JjfVudhPvcpbe544XCV4mGmDHEjDFyxe0JC/rkJ7HBYkfEJn7hF9+4hG3zsbAZi++dqesrQ8XqeJcMiCyPQz3GMJLHGWyeysN3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129182; c=relaxed/simple;
	bh=fUSaXoqtXRB0qGdabGFsyk62OVa7gFl3kWDiGvq9L48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK8RW/ow7vzAI2phdRdRDoh8zDI5jWqELUjhKTHb0X+c35Qkcbto0D9IQPDD9U71wXmQKc1forFlqjpmO/rF7c0j7NvBfhLkIwuPBvA2cs6xw927NnLo+eFzH4yEFZbeGmO5DdSREMafSYoR2djs3ksNJfwv9q8DiY3+cNNOlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKxron1X; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so9777375a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709129178; x=1709733978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/rpJyq/RgcopvSHJgS4VKLl6wgR1t9y0dcYjB0pkkA=;
        b=aKxron1Xi3Dmu2YFzEWO1RysdsHNLdF+gQu6CNRfJpFv37BdmxlqdpNevoi5Mzabxf
         EjKIv6SztXXqOuewrqlNhr/NTWngJnx4/+8YhQe25n++umgn0ZPKEC9m9dnl81Y5AHvR
         2M69odf/YHGbmCzp+6372QkLtyvVqWtJ3aSi7Xu96wkFiAWD8DFSM4zPpLSz1Z7GkHYX
         cAiD6bwBonkrcC0RyO/VDZpvpBXRYkQHUiesXEJJD84CIZemNwgIRNQjE981FIP/+Svz
         FfIp5K8QtRUxpITkMXPSnZR2Ac45gxlhmRBVrtvfAmS0vWswvGWiWIZfNHw7QeCW3oP1
         1k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709129178; x=1709733978;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/rpJyq/RgcopvSHJgS4VKLl6wgR1t9y0dcYjB0pkkA=;
        b=EddGpvUTFS3HPuwOIvx7Ed+msvWsXppaIi1nYJ8yuzj8xAntFo51rnLIWF7pKn8Vis
         62X2zh1SXOiLGkaY9DdQhFEEGqEWf3kAQTPHP3yCZw0MXdSffcXIMXt1xvw3l34ZbVaj
         wiSK0C/j2CeN0PZAIY6UTaN0jkV5Y0eob2ZeXOne1Y5MJeq/+lcHr0j7XKSVwURRYBVL
         evqD7ORF/EFoUQbTSFZwe4VxnfBdZoIs/2Cwh2QGw7IdvOtZCQMTkGLKPYsj9aZTCnDw
         Gk6qglaghG7TOH0scb0790yaN/6LFZdyRQbX9/pSAayuZ39Ux8yGGsShe/gSEfzuLNhf
         NDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnOZ1GIsiSAYNg0ZY7+1M/DKdrQZOzVF063+61hT57u5udX/eQ4B4c1k+wG7DZUtB3gkGNjyZhUqZFoESv3KzOoSvG1SvrrH9JCYYJ
X-Gm-Message-State: AOJu0YwWQyX3vPYtyeW4z1tbrIyXZTNteKpDgg1Pm19YY2U0xug0fXRF
	hFr219T5kUtymOvlL89IYZqq9z/LP+LNFzBdCi2wc5Zi7W0QqggnANTYpFqVNUs=
X-Google-Smtp-Source: AGHT+IFE4wiM4wtkf5DpMvBbMBdAJSPpOXes7UwK5f3dYxNRKxgNFtELeQKw7Zr46zFZZ2hHeYEafA==
X-Received: by 2002:a17:906:bce7:b0:a44:2178:d280 with SMTP id op7-20020a170906bce700b00a442178d280mr240776ejb.66.1709129178506;
        Wed, 28 Feb 2024 06:06:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id cd14-20020a170906b34e00b00a4412406741sm398217ejb.131.2024.02.28.06.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:06:18 -0800 (PST)
Message-ID: <01f6fd8b-2d2e-4324-b354-1ea1b0868976@linaro.org>
Date: Wed, 28 Feb 2024 15:06:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: adc: ad7192: Add AD7194 support
Content-Language: en-US
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
 alisa.roman@analog.com, dlechner@baylibre.com
References: <20240228122617.185814-1-alisa.roman@analog.com>
 <20240228122617.185814-4-alisa.roman@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228122617.185814-4-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 13:26, Alisa-Dariana Roman wrote:
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
> 
> Also add an example for AD7194 devicetree.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Signed-off-by: romandariana <alisa.roman@analog.com>

Something is not right here...

> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 16def2985ab4..c62862760311 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    reg:
>      maxItems: 1
>  
> @@ -96,8 +103,44 @@ required:
>    - spi-cpol
>    - spi-cpha
>  
> +patternProperties:
> +  "^channel@([0-9]+)$":

No need for ()

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 1
> +        maximum: 16
> +
> +      diff-channels:
> +        description: |
> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
> +          appropriate value from 1 to 16. The negative input can also be
> +          connected to AINCOM by choosing 0.
> +        items:
> +          minimum: 0
> +          maximum: 16
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,ad7190
> +            - adi,ad7192
> +            - adi,ad7193
> +            - adi,ad7195
> +    then:
> +      patternProperties:
> +        "^channel@([0-9]+)$": false

No need for ()

>  
>  unevaluatedProperties: false
>  
> @@ -127,3 +170,35 @@ examples:


Best regards,
Krzysztof


