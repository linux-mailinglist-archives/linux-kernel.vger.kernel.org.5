Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6C75930D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGSK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjGSK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:29:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989330E2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:29:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso9168468a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689762546; x=1692354546;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExPK31B4ljf4lopgSPrp6SO4czwztEWUPRdEkb+8xNo=;
        b=w7AG3lT/hleVDVJWoBWR/9b30ZYcgiAULuogEcKrVjW4wsEyArMaNchv2LL1RE/bul
         oxRQq9r5JoHKtZz3Ow87qVBlQvLxaDs5scr8e6rhDfcHqJGArp/KOzfHikZkFn6qoa2b
         QrJGXKXtS1Ly9ogY7Xa26nRYk89lX3lCNq/42xKVeG5fZzeNeh+OExcIMIwvAlSI7vaA
         FwSYwz2naQtrWqw6hiikqFFDybDbeimBwPSbuib42ZynZ5VihrsiyrcfCs4VFdmU3Vjn
         sIq90rOss4+PUaa0mtoQcdK+tBflunFm2hRLQSNTQQclooMzQGj7Ot42nI8d5StaLtNu
         TN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762546; x=1692354546;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExPK31B4ljf4lopgSPrp6SO4czwztEWUPRdEkb+8xNo=;
        b=HSHVHH9ZyeZHrSNhzOGdPybaq1KZIpAMcchpHF3NmfVxLf95moGmAhS74gt+ppEljR
         qMDih8V4mzXSuG4uoH/CCqlB2ne/qNGtHhlgnTpmeMvTzpzgKh1nEE+fIo6jei/vjSr1
         nzUt/sTKJQzadGghYEgSGErO8mgJyGZfKNBdm45jbG+26ylE/U6ukjKsVT5padN/1X7o
         uk+etaLAu8ere8JmjdmdSYqbkOHje3ol8PfrcY0Qjqy43prqehuySoadt5muHDR5NLbF
         ACyk+KZOT+0424b1fZiCT3H+H8M3yEOpkj/wOMEumuc93WrwonIp3E8CznG7G878JMj8
         hLkA==
X-Gm-Message-State: ABy/qLb3ONMBH4uCHxyRr/0937boPR7IxtLiICP2qS7d0Wdmvhyr33By
        yp9iw6jybUXJPbMMU8s9REwGZQ==
X-Google-Smtp-Source: APBJJlFj1TXxAa83rkP3FsR6k80oE7zp7zFFP1kYWHxI2V2j3NwUp9HJ/acreyD3O7Q9i8cabhBYXQ==
X-Received: by 2002:a17:907:3e99:b0:967:21:5887 with SMTP id hs25-20020a1709073e9900b0096700215887mr2368427ejc.40.1689762546292;
        Wed, 19 Jul 2023 03:29:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709064a1500b00982b204678fsm2124473eju.207.2023.07.19.03.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:29:05 -0700 (PDT)
Message-ID: <bccf2ce1-1cdc-9bd3-9670-e346c22e92af@linaro.org>
Date:   Wed, 19 Jul 2023 12:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: add vendor-prefixes and bindings for
 pcd8544 displays
Content-Language: en-US
To:     Viktar Simanenka <viteosen@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719102430.316504-1-viteosen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719102430.316504-1-viteosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 12:24, Viktar Simanenka wrote:
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>

Missing commit msg, missing changelog, missing versioning - I already
asked for the last two things.

> ---
>  .../bindings/display/philips,pcd8544.yaml     | 89 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/philips,pcd8544.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/philips,pcd8544.yaml b/Documentation/devicetree/bindings/display/philips,pcd8544.yaml
> new file mode 100644
> index 000000000000..ac880d9d8cc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/philips,pcd8544.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/philips,pcd8544.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Philips PCD8544 LCD Display Controller
> +
> +maintainers:
> +  - Viktar Simanenka <viteosen@gmail.com>
> +
> +description: |
> +  Philips PCD8544 LCD Display Controller with SPI control bus.
> +  Monochrome 84x48 LCD displays, such as Nokia 5110/3310 LCDs.
> +  May contain backlight LED.
> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:

That's not oneOf.

> +      - enum:
> +          - philips,pcd8544
> +
> +  dc-gpios:
> +    maxItems: 1
> +    description: Data/Command selection pin (D/CX)
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Display Reset pin (RST)
> +
> +  philips,inverted:
> +    type: boolean
> +    description: Display color inversion

Not much improved here. What is it?

> +
> +  philips,voltage-op:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 127
> +    description: Display liquid crystal operation voltage

Voltage is in microvolts (or other *volts). Use proper unit suffix.


> +
> +  philips,bias:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description: Display bias voltage system value

In which units? Voltage is in microvolts.

> +
> +  philips,temperature-coeff:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description: Display temperature compensation coefficient
> +
> +required:
> +  - compatible
> +  - reg
> +  - dc-gpios
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display@0 {
> +            compatible = "philips,pcd8544";
> +            spi-max-frequency = <8000000>;
> +            reg = <0>;

reg is always after compatible.

> +
> +            dc-gpios = <&pio 0 3 GPIO_ACTIVE_HIGH>; /* DC=PA3 */
> +            reset-gpios = <&pio 0 1 GPIO_ACTIVE_HIGH>; /* RESET=PA1 */
> +            backlight = <&backlight>;
> +
> +            philips,inverted;
> +            philips,voltage-op = <0>;
> +            philips,bias = <4>;
> +            philips,temperature-coeff = <0>;
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index af60bf1a6664..0c3844af6776 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1037,6 +1037,8 @@ patternProperties:
>      description: Pervasive Displays, Inc.
>    "^phicomm,.*":
>      description: PHICOMM Co., Ltd.
> +  "^philips,.*":
> +    description: Koninklijke Philips N.V.

Isn't this Philips Semiconductors? That's what datasheet is saying.



Best regards,
Krzysztof

