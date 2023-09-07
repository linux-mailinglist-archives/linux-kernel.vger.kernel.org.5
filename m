Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04F79766E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjIGQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbjIGQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA67D22A5B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:01:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so1089587f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102403; x=1694707203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3O3RNcMeBxjQQhA0dbRmngWyitShsXqfun7LC7NYjS8=;
        b=v+DsX4uCwH4WB5quSbybM1kwOMgNhc0heRB6HR13qx4bqN55zwt5qUWKdrq8GnA5XD
         y/PNaezqeecLRbvsB7233TZ3FtGFzTlsF2qBVPXXgw7NJbtebXWdpmb84hfFburtstVw
         mrSmkUbFF/JBUceIHAUfQnzjsjLqE6Ha3bxicdY58i/GshtUJcddPkdyAzOf/C9bCz4m
         zi6zycDasvGBe7mHAPjRf0gr9DFoaV/OsT2WlCdfk56hhDYWfLlaKAtHVCqVrWjFCM3P
         pJDF5zmYkuB93RKdgWXX0QCvH4rTCTvwI/vaRJtw828UCuuWt2XlWMQ1ePOx8d0vpgdy
         BS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102403; x=1694707203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O3RNcMeBxjQQhA0dbRmngWyitShsXqfun7LC7NYjS8=;
        b=i7Vey1/zhViR66kOyf6/PP2O4f/yOkja8PchBr5wW/D5nB6PRNaSOYtOJk93MCY1Gt
         Kq4iVHpjf3YG1WPFcruaAdQqBXmu9ic+7Oxa7HOF34sgQIvhsuUF19XSPrZQky2orWZ+
         Qkplu6ieXMgE3M+2sSGcBazZKRJsktq8PPYoLnc+9RjFY6SRQ1OdQUBiNp/mT3KdEHfg
         UMsLr4egAP10zd8muhUwmKbQyr3bi9HYwadPL2y8RzRTMvYy1g2FoMR5JNB6W5WNEeGS
         mYp4+G0RK+mubNDNCFTtPL16y6FUv/JiWp1lGI1dgK0NaYbuYaHQe5zC6CMEXn4rhU2w
         5nhQ==
X-Gm-Message-State: AOJu0Yz+jfKo9BozJeHRxMCd8gz6/sv2u3bZt61t69mWYAF1Q/3G2R/i
        UvjbpdwjcmA3RhEg3qHWZCh13kEUbEf5I/tC+I+NOw==
X-Google-Smtp-Source: AGHT+IHTRWxWv8Q4u0fzUOsy1juZlGxj/UwfMeS4tSxa+9HNW5R8xUt9SALZq24RvaBvGYkAQcp1Kg==
X-Received: by 2002:a17:906:9bed:b0:9a5:b95a:1179 with SMTP id de45-20020a1709069bed00b009a5b95a1179mr3482874ejc.77.1694066930742;
        Wed, 06 Sep 2023 23:08:50 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709061d1000b0097404f4a124sm9903735ejh.2.2023.09.06.23.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:08:50 -0700 (PDT)
Message-ID: <5eee2990-5fa6-d4c2-a877-a48afc916198@linaro.org>
Date:   Thu, 7 Sep 2023 08:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: display: Add st7735s driver
Content-Language: en-US
To:     Stefan x Nilsson <stefan.x.nilsson@axis.com>,
        David Lechner <david@lechnology.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230906-st7735s-v1-0-add92677c190@axis.com>
 <20230906-st7735s-v1-1-add92677c190@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906-st7735s-v1-1-add92677c190@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 18:22, Stefan x Nilsson wrote:
> Add bindings for a driver for Sitronix st7735s display controller, as
> well as for a Winstar wf0096atyaa3dnn0 0.96" 80x160 TFT panel.

Commit msg and subject: if by "driver" you mean Linux driver, then drop
these references and focus on the hardware.

> 
> Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
> ---
>  .../bindings/display/sitronix,st7735s.yaml         | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sitronix,st7735s.yaml b/Documentation/devicetree/bindings/display/sitronix,st7735s.yaml
> new file mode 100644
> index 000000000000..36234ec22fe2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sitronix,st7735s.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sitronix,st7735s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sitronix ST7735S Display Panels
> +
> +maintainers:
> +  - Stefan x Nilsson <stefan.x.nilsson@axis.com>
> +
> +description:
> +  This binding is for display panels using a Sitronix ST7735S
> +  controller in SPI mode.

Drop: "This binding is for". Describe the hardware instead.

> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:

You do not have multiple choices here, so why oneOf? Do you expect it to
grow very soon?

> +      - description:
> +          Winstar WF0096ATYAA3DNN0 0.96" 80x160 Color TFT
> +        items:
> +          - enum:
> +              - winstar,wf0096atyaa3dnn0
> +          - const: sitronix,st7735s
> +
> +  dc-gpios:
> +    maxItems: 1
> +    description: Display data/command selection (D/CX)
> +
> +  backlight: true
> +  reg: true
> +  spi-max-frequency: true
> +  reset-gpios: true
> +  rotation: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - dc-gpios
> +
> +additionalProperties: true

This cannot be true. From where did you get such code as example?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    backlight: backlight {
> +            compatible = "gpio-backlight";
> +            gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
> +    };

Drop node, not related.

> +
> +    regdisplay: regulatordisplay {
> +            compatible = "regulator-fixed";
> +            regulator-name = "display";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            regulator-enable-ramp-delay = <100000>;
> +            enable-active-high;

Drop node, not related. Again: from where did you get such example?

> +    };
> +
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            display@0 {
> +                    compatible = "winstar,wf0096atyaa3dnn0","sitronix,st7735s";

You need to fix formatting. Missing space after ,. Wrong indentation.

Use 4 spaces for example indentation.

> +                    reg = <0>;
> +                    spi-max-frequency = <12000000>;
> +                    dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
> +                    reset-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +                    backlight = <&backlight>;
> +                    power-supply = <&regdsiplay>;
> +                    rotation = <270>;
> +            };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6308efa121e1..c00b2b9086f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6728,6 +6728,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
>  F:	drivers/gpu/drm/tiny/st7735r.c
>  
> +DRM DRIVER FOR SITRONIX ST7735S PANELS
> +M:	Stefan x Nilsson <stefan.x.nilsson@axis.com>
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc

Do you have the push rights to this repo? If not, then don't add it.

Best regards,
Krzysztof

