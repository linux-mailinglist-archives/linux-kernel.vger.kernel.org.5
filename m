Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69D808995
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442472AbjLGNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjLGNyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:54:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08910CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:54:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00c200782dso117764866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957298; x=1702562098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJ9hXHlrIBM/3jPxvXf6fAHASy5vMq82OUvhHyJRLCk=;
        b=sYozApNSuGX2V5P1lnsKdERkbvTG+4fbpvjriLflLFNluhlMbiLBUsuL8/M0wCilp7
         S0tkEqQ2Mnwp4OQT++CtpyeFE21Ix2qc3ULEpQN0DAwjzZx2ACBMtxihqym9SBeKirH2
         x/e7fSTgZmeXA5XwPBRwQuLESneOsZHCEyD4hX3k4/A4eJN3Cg3CiH/n9fmA9Fu4rgo4
         4WQKFyhGoYNmVvcICSigbCAyoMH2BWe87j2YOEgNbWY94ydIQ56F2/t4+QzfjC771a1+
         ITRPrAxrFzWdOvveyZEqGBV8ZUy06ULhYmwQcFolVB1DO03dMH2FNhC6B1/5+fn/e3jN
         8J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957298; x=1702562098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ9hXHlrIBM/3jPxvXf6fAHASy5vMq82OUvhHyJRLCk=;
        b=FGMLoSkBjnnTLBwA3bx35LTlxwygiJM85M3oTZxygNBT9ro6X/MiJYelzcDjkRT+Vo
         IqKIvWP11OqusOvwzkgy/iCcxObrqvV65rm63vZ8Ry8OFIjFOwJQooEV8P33udhsk+Cm
         jS8sO6EzdCcgW75xNSw/kaYURIe0Jx5nglkeUoVYbpGpLzVOVmxdc80pQiR1zUjNBcxW
         +aw/Ic+SS5T2n0IQGTmHdOXb9LJjH4L6q8r7zlkG2LSS8pj25tqz1IKc8lx8MSF9QlWo
         qvPPaHTwveEI6U+geUEGOJOQUtxc0pR1C1VJCCJcEQy8RQYbsxY7phTWMEJYsqia89jb
         kmjw==
X-Gm-Message-State: AOJu0YyJ7CZLKhUN+w9KQ3bQPBoCu03VktIqj8Kvon8B7gLpMEVJhHXV
        EUoGmK6eor6jZVeDUp3SwDIFHg==
X-Google-Smtp-Source: AGHT+IE2LvaYsytYUpFN0WDUyMB9++h0rWbP9V5eOinvkhD/nT4mKOI0w9aJH5FBDfy6rf5+AQLWNw==
X-Received: by 2002:a17:906:104c:b0:a1d:b924:1044 with SMTP id j12-20020a170906104c00b00a1db9241044mr706249ejj.27.1701957298121;
        Thu, 07 Dec 2023 05:54:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id md21-20020a170906ae9500b00a1d18c142eesm860581ejb.59.2023.12.07.05.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:54:56 -0800 (PST)
Message-ID: <dd22f0fb-e07b-4bd4-bd6a-cf2d8a5687fc@linaro.org>
Date:   Thu, 7 Dec 2023 14:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: realtek: Add realtek,rtd-gpio
Content-Language: en-US
To:     TY Chang <tychang@realtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-2-tychang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231207100723.15015-2-tychang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 11:07, TY Chang wrote:
> From: Tzuyi Chang <tychang@realtek.com>
> 
> Add the device tree bindings for the Realtek DHC(Digital Home Center)
> RTD SoCs GPIO controllers.
> 
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> ---
> v2 to v3 change:
>     1. Remove generic compatible and use SoC-specific compatible instead.
> v1 to v2 change:
>     1. Add description for DHC RTD SoCs.
>     2. Revise the compatible names.
>     3. Add descriptions for reg and interrupts properties.
> ---
>  .../bindings/gpio/realtek,rtd-gpio.yaml       | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
> new file mode 100644
> index 000000000000..984e7dbd322e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/realtek,rtd-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC GPIO controller
> +
> +maintainers:
> +  - Tzuyi Chang <tychang@realtek.com>
> +
> +description:
> +  The GPIO controller is designed for the Realtek DHC (Digital Home Center)
> +  RTD series SoC family, which are high-definition media processor SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1295-misc-gpio
> +      - realtek,rtd1295-iso-gpio
> +      - realtek,rtd1395-iso-gpio
> +      - realtek,rtd1619-iso-gpio
> +      - realtek,rtd1319-iso-gpio
> +      - realtek,rtd1619b-iso-gpio
> +      - realtek,rtd1319d-iso-gpio
> +      - realtek,rtd1315e-iso-gpio

If there is going to be resend, please order this list alphanumerically.

> +
> +  reg:
> +    items:
> +      - description: GPIO controller registers
> +      - description: GPIO interrupt registers
> +

...

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio@100 {
> +      compatible = "realtek,rtd1319d-iso-gpio";
> +      reg = <0x100 0x100>,
> +            <0x000 0x0b0>;

That's odd. Why order is decreasing? Isn't 0x0 the address of the SoC
(soc@0)?

It is, btw, 0x0, not 0x000. The same for 0x0b0 -> 0xb0, unless you want
to pad to full word.

Best regards,
Krzysztof

