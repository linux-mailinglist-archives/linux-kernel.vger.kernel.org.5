Return-Path: <linux-kernel+bounces-72796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86585B8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B341F2483F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5660EF2;
	Tue, 20 Feb 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBCEu6Yl"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235360DF0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424091; cv=none; b=G7SbHrZEtgZN2M97w5gwFpWay97FYi93hOFS2i/S09kJ+2LfskVADjQ8fazm6AuR5BjhsSdcr1YrY0gj6PVsoXvy+x1lPLphkkDcs5nEOlIKWKU1AmXY0Y55y9jBDNuM3JnTQBUK9rk8ZD8zbXYjv4tdsqxmW74QDD8v2iOPcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424091; c=relaxed/simple;
	bh=7YIkIrO3MaHffyN0m8OVMVyl9H01uIv19UQydyCXah8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkN0l5M4OqQ8gm/GG2lPBS2bW+jaBWe5yVE116AMll78qVlNXfDf9MYu+i7V5RcxlE7N9ESbCD1JfR7+LitK8/8fr3UNm3RUe64wgv0g8/ANIPjr6NWLxMBCDCYrv6CaddSgH98oFgNlJIwcoTj2gVw8b9vxft32gugf7zteH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBCEu6Yl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d32f74833so1489484f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708424088; x=1709028888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COiGTCffwAg01Jdjn+XjVIppc9Nqd/qPCKW+vjHD9lE=;
        b=DBCEu6Yldofz1jG975yZKh7lk8LRkLMLfHuJtRRhLRKiHzdK2DuHAIzGohRrKGHdTh
         88s9PHfWzIUZUisAoT1UzpOyNridWbs6aSwk+yTqR0J/oFO6mLaeu3GODubEUrtY3hd3
         IyDU/emdGgRVBsYr2yvsCqRKkVqIU8KYx3U+70Z/sP0475Q88x724xedwSAAd4+CwMEk
         xf5B6z78IbW6dVatJWmba7gr/RZ7h3uxNSv3weLt6Xah5c2lmrIywjkltT8Y43NaGU11
         DA8Xxj1mXtJXWzn7g803l6ppYHAjm9MS0KBTRVv9FpSpPyb6O4NQoB6/3hh69eJbmdUX
         L8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424088; x=1709028888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COiGTCffwAg01Jdjn+XjVIppc9Nqd/qPCKW+vjHD9lE=;
        b=u1edlZbeZQmVWS4TJc0y/S0Cf3Egtg3ROzYCNfxyT0ICh1cadKdd0xvXFjfwCuM919
         jRF33XZIzBzDbPw0tHXSOKrN+65ic5gJ3ZHg27WQAvp+0vgdNtWKr6G4eL3rwbkTVwSc
         h6cf/aPXwASbl6wumadsLHLTI8d/eAa0LNpRnKQw/Bzw9ckm/gXGXqTegLVsP3KDnK63
         Y8Bf9YKgu/e1N69ycKNTM0yY7ZysDSxD6lhaxQ5oJPK66xqRvZTmVJPRQeZ+YLSuWkRf
         A2dxRv0FlN8USw3wn3o4JWLcCerrxwqcZS15wccOinRcL3VuX6vlNqEpYYHbSyKBUzwh
         qBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlI5BlL/O0XRjeZM+KJicxxrevm62nPhYcLYiBIbGxL5N/DUejmHHmcItleabsNK4biPCKtcu/1Pmu1BLASmUs5tC9kSB6Xoh415Cc
X-Gm-Message-State: AOJu0YxwSlQRocgB5uAe19VBTtZFfl2KIKL84WlYSMP3ElpFleqpCggv
	JsGTHM9C0rlcQQC/kJBtQNAU64PHWIRgwHHPmCySFL8dLuuE8eQ6F5vzOFk/qyI=
X-Google-Smtp-Source: AGHT+IEv7K+Hul3kxYgB6AvHJTUIQnJws0ganlYk1E66M6/hye118SvQKZr4glclkdqIHWQJI6nstA==
X-Received: by 2002:adf:f645:0:b0:33d:1d94:cd58 with SMTP id x5-20020adff645000000b0033d1d94cd58mr7246159wrp.31.1708424087941;
        Tue, 20 Feb 2024 02:14:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm8491785wru.76.2024.02.20.02.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:14:47 -0800 (PST)
Message-ID: <32d0a9c5-6c4b-4d85-bcbe-6192c63ba5fc@linaro.org>
Date: Tue, 20 Feb 2024 11:14:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] dt-bindings: clock: merge all hisilicon clock
 bindings to hisilicon,clock-reset-generator
Content-Language: en-US
To: forbidden405@outlook.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-3-b782e4eb66f7@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240217-clk-mv200-v2-3-b782e4eb66f7@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> We don't need so many separated and duplicated dt-binding files. Merge
> them all and convert them to YAML.

What was exactly duplicated? You created unspecific, lose binding...

Why this is RFC? RFC means we should not review.

> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../devicetree/bindings/clock/hi3660-clock.txt     |  47 -------
>  .../devicetree/bindings/clock/hi3670-clock.txt     |  43 -------
>  .../devicetree/bindings/clock/hi6220-clock.txt     |  52 --------
>  .../devicetree/bindings/clock/hisi-crg.txt         |  50 --------
>  .../clock/hisilicon,clock-reset-generator.yaml     | 139 +++++++++++++++++++++
>  .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ---------
>  6 files changed, 139 insertions(+), 251 deletions(-)
> 


> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> new file mode 100644
> index 000000000000..d37cd892473e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hisilicon,clock-reset-generator.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/hisilicon,clock-reset-generator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon SOC Clock and Reset Generator (CRG) module
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@foxmail.com>
> +
> +description: |
> +  Hisilicon SOC clock control module which supports the clocks, resets and
> +  power domains on various SoCs.
> +
> +properties:
> +  compatible:
> +    minItems: 1

No, it does not work like that. Compatibles are fixed, not fluid. It's
quite a hint that your merging is wrong approach.


> +    items:
> +      - enum:
> +          - hisilicon,hi3559av100-clock
> +          - hisilicon,hi3559av100-shub-clock
> +          - hisilicon,hi3660-crgctrl
> +          - hisilicon,hi3660-pctrl
> +          - hisilicon,hi3660-pmuctrl
> +          - hisilicon,hi3660-sctrl
> +          - hisilicon,hi3660-iomcu
> +          - hisilicon,hi3660-stub-clk
> +          - hisilicon,hi3670-crgctrl
> +          - hisilicon,hi3670-pctrl
> +          - hisilicon,hi3670-pmuctrl
> +          - hisilicon,hi3670-sctrl
> +          - hisilicon,hi3670-iomcu
> +          - hisilicon,hi3670-media1-crg
> +          - hisilicon,hi3670-media2-crg
> +          - hisilicon,hi6220-acpu-sctrl
> +          - hisilicon,hi6220-aoctrl
> +          - hisilicon,hi6220-sysctrl
> +          - hisilicon,hi6220-mediactrl
> +          - hisilicon,hi6220-pmctrl
> +          - hisilicon,hi6220-stub-clk
> +          - hisilicon,hi3516cv300-crg
> +          - hisilicon,hi3516cv300-sysctrl
> +          - hisilicon,hi3519-crg
> +          - hisilicon,hi3798cv200-crg
> +          - hisilicon,hi3798cv200-sysctrl
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    enum: [1, 2]
> +    description: |

Previous bindings has only 2. Your patch is difficult to review and
understand.

> +      First cell is reset request register offset.
> +      Second cell is bit offset in reset request register.

All of these are reset controllers? I doubt.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1

All of these have children? No, sorry, but this merging does not make
any sense.

> +
> +  mboxes:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Phandle to the mailbox for sending msg to MCU
> +      (See ../mailbox/hisilicon,hi3660-mailbox.txt for more info)
> +
> +  mbox-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      Names of the mailboxes.
> +
> +  hisilicon,hi6220-clk-sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the syscon managing the SoC internal sram
> +      the driver needs using the sram to pass parameters for frequency change.
> +
> +  reset-controller:
> +    type: object
> +    description: |
> +      Reset controller for Hi3798CV200 GMAC module
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - hisilicon,hi3798cv200-crg
> +    then:
> +      properties:
> +        reset-controller: false
> +  - oneOf:
> +      - required:
> +          - hisilicon,hi6220-clk-sram
> +      - required:
> +          - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3559av100-clock.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@12010000 {
> +            compatible = "hisilicon,hi3559av100-clock";
> +            #clock-cells = <1>;
> +            #reset-cells = <2>;
> +            reg = <0x0 0x12010000 0x0 0x10000>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/hi3660-clock.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@fff35000 {
> +            compatible = "hisilicon,hi3660-crgctrl", "syscon";
> +            reg = <0x0 0xfff35000 0x0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml b/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> deleted file mode 100644
> index 3ceb29cec704..000000000000
> --- a/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/clock/hisilicon,hi3559av100-clock.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#

NAK, not related patch.

Please split all your patches into logical chunks.

Please read submitting-patches *BEFORE SENDING* further submissions.

Best regards,
Krzysztof


