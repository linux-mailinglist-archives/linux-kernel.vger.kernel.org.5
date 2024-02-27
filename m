Return-Path: <linux-kernel+bounces-82776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC586898A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB911C2164F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AF554645;
	Tue, 27 Feb 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPx8K1ea"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900D253E32
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017586; cv=none; b=fnJahYpI0aB0mHizeCRwYMF8spKtdzFWKR6XRFceICN3+6rgGQW7SCuJ6Gg5wRFAXpDhbS+P2Li8tZPCHhETwLPSxcm6G4Z/+zW2scok8ssyrFWMiXJn6BcjL+To/0kz8Y0w5QwiksmcMmrrQDJCj7fIBwqL+MVQ+/WEs6VTtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017586; c=relaxed/simple;
	bh=TmTOt+hyHAifX2R0VSXHdchHMKRvzNoke2wPc8Ndato=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+ox9pNQLd0Ims5KyZkBGanGqzq/85BYITWq5GgVsEPG2lEpaMgLdBM+6efeOa3SQxETQ2zl/h/Yjz6sotv1njbWJKA3B1rktLGzMx7Lx4Gdcw0ZARKm5pIpjiSiVbDxQ8mCCjFulHrdhK2HtW6bvq6mMFLsS3s1XiVJ27Dsoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QPx8K1ea; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so4083915a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709017582; x=1709622382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLCxLnglQud6AafcMTZGxWqddfDheQOqmiuHd+EOBrk=;
        b=QPx8K1ea+WO3K6OFeWl6S9PLsQj57L+TF8mVy/zgqpj4dZBBheF+ag/e1B8cWquf7M
         GJFWIuUWQXm+tTNyq8Yl0DWJ3Dh8MOWRBjbHUo0V04+fMdpo4NVR+jOjhfFaeLpBlJYi
         c1yZbOZb8AbAB/HYT3x8IOlsJtqf0i0SiFLQhHHX36LILSWLa1gInWy3Omh0xsmndfpb
         wOP7mydp5ShnJy+sdjbleb03rOyl81VheMNl1tiPWGdwuDMEBWbwExvJxoyhXuqN5VAW
         SJZxIhQR2HNyvAym38GEp1nGbKLd9jdTjF/lgrFX8KVYHJMmq5DJzFZUXq+hPAiYDteH
         GzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017582; x=1709622382;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLCxLnglQud6AafcMTZGxWqddfDheQOqmiuHd+EOBrk=;
        b=EKqGLKbrOqcg8cb8R5Zk1TSmUMPzUgYEyDE0cpKKJSNz6HU/pLiZVCXbAgKcNnrsNc
         UrBum6BY4dF4G1vVzy5p4GZh4//j+Qn4xLrut/HPD6n02RbkXC3jz6mB0zE3fGyO67sC
         We0MO+rjAeUfzUkchAz2N1A7tg7L1ZrROqEXqm3qdKF56YG5mdU5sy2bs7cy+IZ6yEas
         IyhgubMeJhyidv6irHHW31g5UVIbp4P5oqeJrDhNsNxuNbqc59XUJAOjyAVikzFvhs4G
         ABQc/17tYEgM8EbFEc17KwfvymRK0/kg62epK5HJINalWi9cdZjEGnrqB1tDdjIgDo3R
         VQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKnMPNrRA0m/HlnbfDZprrivT/btyqOb8Boao14SBVY1GmGlfy8CDevoHIqHY+IbLxZxf82XwhI6mx9BGSuU2crRhzFE5nYNrO5QFp
X-Gm-Message-State: AOJu0YzX1aJhXipwgPorkLSstVbJV4+wnc6BTZmHyGvbuLHEnT0SQIab
	zpT7dPAx1c5V0LmDsH0DRyh9nyWhl1hgBZ/MLBtVAOLugbLfwQm52mrpb0ZAOB0=
X-Google-Smtp-Source: AGHT+IH3nPjxyLxePuzG85v10xOwBHg/CBPZEZjd12HuCqZJPvxpHQEs182DxeMGYt2iwDOWsPmcwg==
X-Received: by 2002:a05:6402:78f:b0:565:ced9:2657 with SMTP id d15-20020a056402078f00b00565ced92657mr4158876edy.7.1709017582311;
        Mon, 26 Feb 2024 23:06:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id r11-20020a056402018b00b0056608214577sm472173edv.16.2024.02.26.23.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:06:21 -0800 (PST)
Message-ID: <f69ef2ad-8ace-40c8-b923-4dde20eda2ec@linaro.org>
Date: Tue, 27 Feb 2024 08:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT
 schema
Content-Language: en-US
To: Andrew Jeffery <andrew@codeconstruct.com.au>, linus.walleij@linaro.org,
 brgl@bgdev.pl, krzysztof.kozlowski+dt@linaro.org
Cc: robh+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240227052353.1060306-1-andrew@codeconstruct.com.au>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240227052353.1060306-1-andrew@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 06:23, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v5: Resolve macro definition clashes from aspeed clock headers in examples
>     identified by Rob's bot:
> 
>     https://lore.kernel.org/all/170900020204.2360855.790404478830111761.robh@kernel.org/
> 
>     Clearly I missed running `make dt_binding_check` on the final iteration of
>     the v4 patch I sent. Hopefully I'm running out of rakes to step on here!
> 
> v4: https://lore.kernel.org/all/20240227004414.841391-1-andrew@codeconstruct.com.au/
> 
>     Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
>     https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647@linaro.org/
> 
>     Add more examples to exercise constraints.

No, one or two examples (if there are quite different) is enough.

> 
> v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew@codeconstruct.com.au/
> 
>     Base on v6.8-rc6, fix yamllint warning
> 
>     Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
>     patch was based on v6.8-rc1, and going back over my shell history I missed
>     the following output from `make dt_binding_check`:
> 
>     ```
>     ...
>       LINT    Documentation/devicetree/bindings
>       usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
>       yamllint: error: one of the arguments FILE_OR_DIR - is required   
>     ...
>     ```
> 
>     I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
>     of `yamllint`.
> 
> [1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh@kernel.org/
> 
> v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew@codeconstruct.com.au/
> 
>     Address feedback from Krzysztof:
>     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/
> 
> v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/
> 
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 143 ++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
>  2 files changed, 143 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> new file mode 100644
> index 000000000000..1aa28b1817cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed GPIO controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-gpio
> +      - aspeed,ast2500-gpio
> +      - aspeed,ast2600-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: The clock to use for debounce timings
> +
> +  gpio-controller: true
> +  gpio-line-names: true

min/maxItems


> +  gpio-ranges: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  ngpios: true

minimum/maximum.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2400-gpio
> +    then:
> +      properties:
> +        gpio-line-names:
> +          minItems: 220
> +          maxItems: 220
> +        ngpios:
> +          const: 220
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2500-gpio
> +    then:
> +      properties:
> +        gpio-line-names:
> +          minItems: 232
> +          maxItems: 232
> +        ngpios:
> +          const: 232
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-gpio
> +    then:
> +      properties:
> +        gpio-line-names:
> +          minItems: 36
> +          maxItems: 208
> +        ngpios:
> +          enum: [ 36, 208 ]
> +      required:
> +        - ngpios
Best regards,
Krzysztof


