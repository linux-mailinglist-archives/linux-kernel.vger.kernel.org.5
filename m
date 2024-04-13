Return-Path: <linux-kernel+bounces-143880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22188A3EA9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4717C281D46
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2CF56443;
	Sat, 13 Apr 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cerVMa/5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0B1758B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713043152; cv=none; b=Ln3A/VjiC/QlA6R6vpNCTtyFHlPaP5VEqodDyasCl7P4owd0T+PxezUFaPce1uCFOTUVKtN47v1RNkMSkMx0sLT951/FNBiVNJIqVpONIYwvA2s7+TLiM7MZlMExJUP2cGc4HtJJcADZ9JGDqomUERUueexe0mFQFF2zqvfH8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713043152; c=relaxed/simple;
	bh=f5WpgDyI5RH4w8+qTrxQQLmHeovh7aUIMRBXq45KDFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THeyQFVxFE9A4cpw1KEj/z/ABRm2xlsld1TvaUXP5K0irfUC+jJPlVyAij6pyQu8FHM5Nd9Fy7MrVbkTqKkMC1ri7IcUbRB7spxjIbM/F5BlXJnePlqdyD7EQLZCbRQqHWhkCdpmL54xNwdI9Q7Cgaj34mA+JQqotacvFbdwZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cerVMa/5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d895138d0eso16286661fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713043149; x=1713647949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c/t4RoIebmHtQnR1i/xtxOlbaIAoGHKLclvovPcq0xw=;
        b=cerVMa/5hzIU+1CskjIT/YEU4S02Ul9/CPomQQEUbSgsVcGmLX9Gj4ZpmRoXszhSB5
         NaCJO5qEpmXKXePkPcKVM/NVkadNXgRSfWnLcjbh8YnVSLGIGYWWg/TddB0724uD17JM
         vz+w8g5X+fZF+h7dTWFtk0Gutu/BkXmadZXb+x6lBKJxOZtxyHxuQG5mRlsm6FX9bLy1
         q4qDIBB/iKv6pfV6A1mDaeHrY+8qOPH+OodYLOppBF6AQizSohW1OMSRyTM/x1bJvDwQ
         yBObj6QJqt+xq+cCiJ16kj11mkJB0Bqn2uNjMCYVBMFtMFdXahAlDbm75XhfJv7CK6/B
         8hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713043149; x=1713647949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/t4RoIebmHtQnR1i/xtxOlbaIAoGHKLclvovPcq0xw=;
        b=EEb31L/7OOMAhKaKI8pheI0q9LKfDIdQWSaHUouncrXcR55AuZ3E1so89AEZyeFYvd
         6NYc6PcPLMyhZnLqesKe6WTh9ZWl5+bCJJUXZlXsH9pcX6W5a8SWI7T3IgolaofRYfhg
         SOXDnSZLvICJ2/Cv/nyX1Ay0XxMsaf6uDbfnCeQWqabUlrdhdoQcsivRIkJZYYyxbCDs
         /Xi7RrVB1DNmvr+PMf+AEkIWQ9reyrEOeDC05uQehd4YM50lWuXs6zUCvf2zR3lUOqXn
         HdkcDrotBx13khK9HfoAH3byyT90aZdVb1tDPAuog5g2qwtkGnBsbgx6r4Ul1pCrO7+e
         fFJg==
X-Forwarded-Encrypted: i=1; AJvYcCVxVChRmSk8BUILmwlUAK7fiB0skQFu8T+FSidh9DD4P2hzVRbzfB9gQl5fFDnOd6ShGlKWtCGyydIVvxSYfu3lt/OTbKh7NKFqUm1Y
X-Gm-Message-State: AOJu0YzQR11+m4yA3OIpREJYz9cFWq7mNr1Ytk0OI9c/oJR7USZ7mBju
	4Cqb6SmXopQwKL0ues16rrLFPTc6P1EQS+OBAezgwGTZt+6ota6KvpA9LSnkncw=
X-Google-Smtp-Source: AGHT+IGhEJoY1T2bRdIh0oLnEjbTS4HjO2WSGv+niFTapwKxg+8kSZyCCAZ9hw79+MgWE8QFweZpig==
X-Received: by 2002:a2e:9cc2:0:b0:2d9:fde1:dcf1 with SMTP id g2-20020a2e9cc2000000b002d9fde1dcf1mr3401347ljj.41.1713043148768;
        Sat, 13 Apr 2024 14:19:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7d445000000b0056b7ed75a46sm2942843edr.27.2024.04.13.14.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 14:19:08 -0700 (PDT)
Message-ID: <2ad06ea8-220f-4d09-bbe7-c4dd12d0d8bd@linaro.org>
Date: Sat, 13 Apr 2024 23:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-5-alisa.roman@analog.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240413151152.165682-5-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 17:11, Alisa-Dariana Roman wrote:
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
> 
> Also add an example for AD7194 devicetree.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index ba506af3b73e..855f0a2d7d75 100644
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
> @@ -104,8 +111,43 @@ required:
>    - spi-cpol
>    - spi-cpha
>  
> +patternProperties:

This goes after properties:, so before required: block.

> +  "^channel@[0-9]+$":

Why restricting the pattern? If you have 256 channels, how are you going
to encode it?

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 1
> +        maximum: 256
> +
> +      diff-channels:
> +        description: |
> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
> +          appropriate value from 1 to 16.
> +        items:
> +          minimum: 1
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
> +        "^channel@[0-9]+$": false
>  
>  unevaluatedProperties: false
>  
> @@ -136,3 +178,35 @@ examples:
>              adi,burnout-currents-enable;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "adi,ad7194";
> +            reg = <0>;

compatible is always the first property. reg is second.


Best regards,
Krzysztof


