Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C117A1C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjIOKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjIOKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:37:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA895C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:37:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso250244066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774262; x=1695379062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98LorT2C/IEceI1kVOQrQwUEnGbTB4Xy5v+bq2wc0hc=;
        b=BzPrOHR5uGbOEhxIQoanxet6tHwWnnqEVu5Q17GZzgSffD0VEAOj9s5fQSyp0UJeuH
         EdKtJJD8C8YbsAodJ0q11Mvx/exHAk+Dnb4krNYGB1OiiBwLMZ1uFhp4u2po08OnuYNH
         IWNsERUtC5QPUHrxlPMI9dZ717gkQeMhl7dAl4DhOCRFVEz0aSM2tx5uyuakAZoRCOHJ
         Bs/a+lqROoK4dZrQmI4U5kqd0mBqZyC9elJD6WHr9cwxVnjo+oD3H32oaj+ILRjoTeNH
         zyNssDWDYpGSGsXU04+LuuAsp5tJ/EdouvgjVjureHOCLMp2SV94G6N3QhO0Gil3hrfO
         JUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774262; x=1695379062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98LorT2C/IEceI1kVOQrQwUEnGbTB4Xy5v+bq2wc0hc=;
        b=aaccJoY1ZKoPf8gGnyFB079XM2rDgCYl/TnCryxucZeBAleOq+CcuyP7882erMXNz5
         lIBeupWPqun00oXQmpw//+QiGLzshNObyKw2P9oCRGDMQI+o2/uhbULXdhTcnj2gtzZQ
         syoj43MQU+Ilba+f88qRpjwIJdo3dWjHBDoQYs9+w8T5KMHZWOBMrcSDxvihnz3QysPU
         GTUuGE8XU8miPTqYhr2XxRucCjsPXVwftudfLF0xONL1IAXHdtpwNWMjH1QmjAnBncfw
         HcPnxIJSf7NLAHUqkrluSHIZLklEewBZqva+DoM/3CDMkWYAyJG38VlCIbNbVSgLyYXH
         ctkA==
X-Gm-Message-State: AOJu0YyLJrTN2WxEbMpNXKl0yXHb82n7dS9sgIrk3o2xTS2Cvmk6pz+o
        sZyLjnpdwxuefP4Wb6FYO4QYKA==
X-Google-Smtp-Source: AGHT+IEQafJGx4l388iNt4dr4fwEIJ2pK6342pfCYa+9DReCIi2MelRzA414gIgWF+YORHSNocMX7A==
X-Received: by 2002:a17:906:8465:b0:993:d5bd:a757 with SMTP id hx5-20020a170906846500b00993d5bda757mr967607ejc.19.1694774262271;
        Fri, 15 Sep 2023 03:37:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id uz3-20020a170907118300b009ad8acac02asm2280677ejb.172.2023.09.15.03.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:37:41 -0700 (PDT)
Message-ID: <7014b3dd-76f2-bd71-adda-45db6835c008@linaro.org>
Date:   Fri, 15 Sep 2023 12:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 05/42] dt-bindings: pinctrl: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-5-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-5-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC pinctrl.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/pinctrl/cirrus,ep9301-pinctrl.yaml    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> new file mode 100644
> index 000000000000..1dbdc5ccc232
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cirrus,ep9301-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus ep93xx pins mux controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-pinctrl
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-pinctrl
> +              - cirrus,ep9307-pinctrl
> +              - cirrus,ep9312-pinctrl
> +              - cirrus,ep9315-pinctrl
> +          - const: cirrus,ep9301-pinctrl
> +
> +patternProperties:
> +  '^pins-':
> +    type: object
> +    description: pin node
> +    $ref: pinmux-node.yaml#

Still missing unevaluatedProperties: false

> +
> +    properties:
> +      function:
> +        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]
> +
> +      groups:
> +        enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
> +                gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
> +                rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp ]
> +
> +    required:
> +      - function
> +      - groups
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false

Why this was changed? I did not ask for this. I commented in different
place on different level of indentation.

This is unfortunately still wrong. :(

Best regards,
Krzysztof

