Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E17684D4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 12:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjG3Kal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjG3Kaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 06:30:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D132E56
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:30:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c0290f0a8so125374366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690713036; x=1691317836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkEYPWgZTlQhSv5LCikyH90HRgzZdU7DFZTtwFHAaoM=;
        b=kGufy1f+o2U8lT8/RMltsbHJNQdTRWnBrBk0tmgTDkgeTFGrT7eerVE0HOAtR35TaH
         +AW6SAQ5SjfXrREsGQLLCBUDv3ZTGGY4rKwFXCxnHgM8+7sYSy/Cr56Yo5fb1p9uoLeK
         wK+lkHYC5tpNb1UD2XtLv97X5lE/rbeu5ygKi8fffqRWrgBD80dU1U+CF2bpepi+25/I
         MOYr/6XIHrpdojRT8Rdaesf64SRKqbYBGeudf+dFHWzHG6ME+qS6hnY+CYSa84GLBuOl
         RtyQS+5AHidj/EvC0a2DnslJyMaAfPz7wKy+EPCU+NrVNJOB9V9NKoY1VCQqrmUitvJa
         KUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690713036; x=1691317836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkEYPWgZTlQhSv5LCikyH90HRgzZdU7DFZTtwFHAaoM=;
        b=eEhaEjb6Yz5Lfb2hBGDlXOSX8J+A/52R02SgxnDP+fXsZrWD8Aq2gld+rxkmekQVDB
         ZO8EeI6pdwsIoHI0HlBF7Vz1RlPQIRwPPN0A2Q8kH4e/DTJz06OevMNF3IvGIdCebREb
         IzVAfTDBX+Mdn1dAjgluWZtCNrLutVV8/81VJAEOYUwAendo3IH/rbMtkZ8WXIACT/cC
         oJaIGpyh5MI4zY147QYIa0SQFcI8t8lOkRLJ7FmA/YqIhLt+VdNYapEhvfDh4y5Wf7fr
         gHrJ0uQs9VccbNXw6LmojHrLiQ4J9II4dicb5A4KPjNSRk/3DOzQ+LRx3iE7xDjWNL9W
         cLjQ==
X-Gm-Message-State: ABy/qLaVTMlDYkPlaWtBD+E8b5a+134yp+zR+2YF0ZKJCyA/GEf1wcCK
        ll7gqmYuGUS/dnfs/vjam3KYwQ==
X-Google-Smtp-Source: APBJJlGSIvRHw43C7JXpRLSOvfAeIXm0am8VZFecI32r1RXZxITtlxaiYwncRIz4Zx6VWrdLXQcXzw==
X-Received: by 2002:a17:907:2722:b0:994:5b1:6f92 with SMTP id d2-20020a170907272200b0099405b16f92mr3360286ejl.3.1690713035715;
        Sun, 30 Jul 2023 03:30:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0099304c10fd3sm4458169ejb.196.2023.07.30.03.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 03:30:35 -0700 (PDT)
Message-ID: <0a9b2ce4-a76a-8ba3-592f-3312bba06e1e@linaro.org>
Date:   Sun, 30 Jul 2023 12:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC] dt-bindings: gpio: brcm,kona-gpio: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZMQU7ap9CxfY5eIu@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 21:20, Stanislav Jakubek wrote:
> Convert Broadcom Kona family GPIO controller bindings to DT schema.
> 
> Changes during conversion:
>   - add used, but previously undocumented SoC-specific compatibles
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> RFC since dt_binding_check is giving me these errors/warnings:
> 
> Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dts:21.23-34.11: Warning (interrupts_property): /example-0/gpio@35003000: Missing interrupt-parent
> 
> The old txt bindings and all current DTs do not use interrupt-parent AFAICT,
> so I'm not sure what to do about that.
> 
> Documentation/devicetree/bindings/gpio/brcm,kona-gpio.example.dtb: gpio@35003000: interrupts: [[0], [106], [4], [0], [115], [4], [0], [114], [4], [0], [113], [4], [0], [112], [4], [0], [111], [4]] is too long
> 
> Here I'm not even sure what the issue is.
> 
>  .../bindings/gpio/brcm,kona-gpio.txt          | 52 -------------
>  .../bindings/gpio/brcm,kona-gpio.yaml         | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 78 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
> deleted file mode 100644
> index 4a63bc96b687..000000000000
> --- a/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -Broadcom Kona Family GPIO
> -=========================
> -
> -This GPIO driver is used in the following Broadcom SoCs:
> -  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> -
> -The Broadcom GPIO Controller IP can be configured prior to synthesis to
> -support up to 8 banks of 32 GPIOs where each bank has its own IRQ. The
> -GPIO controller only supports edge, not level, triggering of interrupts.
> -
> -Required properties
> --------------------
> -
> -- compatible: "brcm,bcm11351-gpio", "brcm,kona-gpio"
> -- reg: Physical base address and length of the controller's registers.
> -- interrupts: The interrupt outputs from the controller. There is one GPIO
> -  interrupt per GPIO bank. The number of interrupts listed depends on the
> -  number of GPIO banks on the SoC. The interrupts must be ordered by bank,
> -  starting with bank 0. There is always a 1:1 mapping between banks and
> -  IRQs.
> -- #gpio-cells: Should be <2>. The first cell is the pin number, the second
> -  cell is used to specify optional parameters:
> -  - bit 0 specifies polarity (0 for normal, 1 for inverted)
> -  See also "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
> -- #interrupt-cells: Should be <2>. The first cell is the GPIO number. The
> -  second cell is used to specify flags. The following subset of flags is
> -  supported:
> -  - trigger type (bits[1:0]):
> -      1 = low-to-high edge triggered.
> -      2 = high-to-low edge triggered.
> -      3 = low-to-high or high-to-low edge triggered
> -      Valid values are 1, 2, 3
> -  See also .../devicetree/bindings/interrupt-controller/interrupts.txt.
> -- gpio-controller: Marks the device node as a GPIO controller.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -
> -Example:
> -	gpio: gpio@35003000 {
> -		compatible = "brcm,bcm11351-gpio", "brcm,kona-gpio";
> -		reg = <0x35003000 0x800>;
> -		interrupts =
> -		       <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
> -			GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH
> -			GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
> -			GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
> -			GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
> -			GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> -		#gpio-cells = <2>;
> -		#interrupt-cells = <2>;
> -		gpio-controller;
> -		interrupt-controller;
> -	};
> diff --git a/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
> new file mode 100644
> index 000000000000..9d0b0a1af832
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/brcm,kona-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Kona family GPIO controller
> +
> +description:
> +  The Broadcom GPIO Controller IP can be configured prior to synthesis to
> +  support up to 8 banks of 32 GPIOs where each bank has its own IRQ. The
> +  GPIO controller only supports edge, not level, triggering of interrupts.
> +
> +maintainers:
> +  - Ray Jui <rjui@broadcom.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm11351-gpio
> +          - brcm,bcm21664-gpio
> +          - brcm,bcm23550-gpio
> +      - const: brcm,kona-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

As Linus pointed out, you do not have one interrupt. Put here the widest
constraints (min/maxItems) and narrow it per each variant in
allOf:if:then:. Also fix the syntax in example. Each interrupt is in its
own <>.


Best regards,
Krzysztof

