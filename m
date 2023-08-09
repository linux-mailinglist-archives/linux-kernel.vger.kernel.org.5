Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49277530F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHIGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjHIGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:43:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9041BF7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:43:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1d03e124so843632566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691563390; x=1692168190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZyUku1x+f9M0xM3Ul9QhwkG2Pa4msuJfeZ1LHhOsik=;
        b=ZZpsCQBj3cFm5Focd5nI1JUm5t7Oo3hVwYpZ5eMXHplAo7N6A8PPKBBq0+0XFLpSk+
         GDePJrY70aEfmssU3uzizsDNkDn/Jcx3BJYylBvgNI+vJNdhV3AhTHU5M5x1ft71lcQr
         nJVWaYF2DMfp3XgSoH/tIw8oiTqy8HTJE0cd18ZWdvojVy1KhpUj0YXDibGgGNQdp1nT
         hZnbe39jL9Fx3ohjFkjwt5HnEZrIqR5e4fekHGfhhbO1PpU+Gz3eq42Qc8tfAPldAlz6
         NI2n3o6Rt/gZBe6gQm8Z+W57O0ewMyTH/tQ7HLGS7PW8XobsSSY4if/KtqL92sPbKaFw
         h4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563390; x=1692168190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZyUku1x+f9M0xM3Ul9QhwkG2Pa4msuJfeZ1LHhOsik=;
        b=WrhwHO6e1/VaWXNFnwolZcMhbHWHBXo0kAVsVhLlhb5wyXPvqdVe8AnPRHzm2fIGmL
         Y780spVVAeMH/3dZLYihgGOTkRCVGG1UHjnwN2lGM5GQGLx0ZtB85/uy4NPIWVWOh6jG
         u6N0QJ51JMe5mMa/zfhGQA6B2lhI9CF39Cnca4c2kGBynhuF1WitiWEW9WvRK7s8bBjZ
         KN4AearvNZTLfqfEo6Lyok6BtRe3lUfkN1d1k00IudA4Q3B0VvHcNUmBQCqaJITcEaZw
         3H90Aop52xwkcsci25vyDFo53Uh0GWgulIo926Gbh3qQ1C3aEzlE4m/++zUvoaIz32wy
         J6TA==
X-Gm-Message-State: AOJu0YzQtka9cBc3sxSdFEOvxfW0RmEhnI4JUio9sTQyfzVzjguZX+2G
        IOsSpmq+egeo6J8VNKMbKZqiEw==
X-Google-Smtp-Source: AGHT+IE8ZiM5GoL0C22Y2H3x1S2Pvxfd6o+BZM2JsmIdYE5jdtjZHhPX6ZjDBJmS857WPPx1QIQdig==
X-Received: by 2002:a17:907:77c8:b0:99b:499c:ddb6 with SMTP id kz8-20020a17090777c800b0099b499cddb6mr1246773ejc.68.1691563389748;
        Tue, 08 Aug 2023 23:43:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id z20-20020a1709067e5400b0099b42c90830sm7592234ejr.36.2023.08.08.23.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 23:43:09 -0700 (PDT)
Message-ID: <9a85bc7f-8f20-6241-beba-6d705f62e071@linaro.org>
Date:   Wed, 9 Aug 2023 08:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: input: cirrus,cs40l50: Support for
 CS40L50
Content-Language: en-US
To:     James Ogletree <james.ogletree@cirrus.com>,
        dmitry.torokhov@gmail.com
Cc:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jeff LaBundy <jeff@labundy.com>, Peng Fan <peng.fan@nxp.com>,
        Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>, patches@cirrus.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808172511.665787-1-james.ogletree@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 19:25, James Ogletree wrote:
> Introduce device tree bindings for the initial commit
> of the CS40L50 driver.
> 
> Change-Id: I95369831f947cb32a0a80e81923fd28ace888481

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
> ---
>  .../bindings/input/cirrus,cs40l50.yaml        | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  9 +++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml b/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> new file mode 100644
> index 000000000000..5437c6beb1b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cirrus,cs40l50.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS40L50 Advanced Haptic Driver

Driver as "motor"? If yes, then ok. If "Linux Driver" then not.

> +
> +maintainers:
> +  - James Ogletree <james.ogletree@cirrus.com>
> +
> +description:
> +  CS40L50 is a Haptic Driver with Waveform Memory DSP
> +  and Closed-Loop Algorithms
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,cs40l50
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  VA-supply:
> +    description: Regulator for analog voltage

Keep lowercase, so "va-supply".

> +
> +  VP-supply:
> +    description: Regulator for peak voltage

ditto

> +
> +  VIO-supply:
> +    description: Regulator for digital IO voltage

ditto

> +
> +  cirrus,external-boost:
> +    description:
> +      Bypass the CS40L50 boost converter.
> +
> +      The amplifier on CS40L50 can be powered internally through the boost
> +      converter, or else can be powered using an external supply. If an
> +      external VA supply is used, the boost converter must be bypassed.
> +    type: boolean

Isn't this property then conflicting with va-supply?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cs40l50@34 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "cirrus,cs40l50";
> +        reg = <0x34>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <113 IRQ_TYPE_LEVEL_LOW>;
> +        reset-gpios = <&gpio 112 GPIO_ACTIVE_LOW>;
> +        VA-supply = <&dummy_vreg>;

s/dummy_//

> +        VP-supply = <&dummy_vreg>;

s/dummy_//

> +        VIO-supply = <&dummy_vreg>;

s/dummy_//

> +        cirrus,external-boost;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54ef320bb689..016e5ff3b831 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2081,6 +2081,15 @@ F:	arch/arm/boot/compressed/misc-ep93xx.h
>  F:	arch/arm/mach-ep93xx/
>  F:	drivers/iio/adc/ep93xx_adc.c
>  
> +CIRRUS LOGIC HAPTICS DRIVER
> +M:	James Ogletree <james.ogletree@cirrus.com>
> +M:	Fred Treven <fred.treven@cirrus.com>
> +M:	Ben Bright <ben.bright@cirrus.com>
> +L:	patches@Qopensource.cirrus.com

No typo in email? Qopensource?

> +S:	Supported
> +T:	git https://github.com/CirrusLogic/linux-drivers.git

We do not have real maintenance entries for individual drivers, thus no
git trees. Who is going to pull from your tree? Is your GPG key in
kernel.org keyring? I propose to drop the tree reference.

> +F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
> +
>  ARM/CLKDEV SUPPORT
>  M:	Russell King <linux@armlinux.org.uk>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

Best regards,
Krzysztof

