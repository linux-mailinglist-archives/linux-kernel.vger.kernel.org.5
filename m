Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B07FAD90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjK0WfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjK0WfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:35:19 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC82CA5;
        Mon, 27 Nov 2023 14:35:25 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b863ec1732so845498b6e.0;
        Mon, 27 Nov 2023 14:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124525; x=1701729325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g86YtSS//IjTCJBYsf1NPWyqXQksoEkdn33XBneuwxE=;
        b=sa4zN/SA3k6R6Y+LaC2K6i1kn4Rpv9I04p8We9DgZTm6wtC8AU6SIJJi8UBD3k2TeG
         kuqPNvNlGaYTA6SJUPnG2FKy8jSJnfM3On1ypCeBr+Ne8aQVAbEt/d4x+C4D884PyMi8
         5nT7sDWzWw9obEDCHhf2SlKrgpRsx04bMVsREkSkpmqiY8N5A+Ty7fRd3JhSTdZLFFgH
         lJBpm9CXvmgrSz36pcDWwu5BnY8HX25DFh/a3FjR68T/GxloCvN7NRl+U5Bt1r9gn9xS
         u/Z+iPjNkslf727EHmCUJNWY+9mV9sOTLdgVrqm3sYkn7S+vbtfCkZZAL01Se4u9cmxX
         +AnQ==
X-Gm-Message-State: AOJu0YydE8CWT7gKHUV15QM9UWfUkFO4rr5TKH7tiYtJ2H2NugYJO+/I
        mOVlHS909ZHd4VWA2YJ54A==
X-Google-Smtp-Source: AGHT+IG3Ehv5n5h/9/ZyzIfSBG1aHBg8h1q7IcFURoniaHTNxt9dc4pnOUUpAeplCccO1Zl8PRxQUw==
X-Received: by 2002:a05:6808:bd0:b0:3af:7c6a:6043 with SMTP id o16-20020a0568080bd000b003af7c6a6043mr6023680oik.23.1701124524930;
        Mon, 27 Nov 2023 14:35:24 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf4-20020a056808190400b003af56ef1510sm1630793oib.20.2023.11.27.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 14:35:24 -0800 (PST)
Received: (nullmailer pid 151319 invoked by uid 1000);
        Mon, 27 Nov 2023 22:35:23 -0000
Date:   Mon, 27 Nov 2023 16:35:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 6/8] dt-bindings: net: Document Qcom
 QCA807x PHY package
Message-ID: <20231127223523.GB4023452-robh@kernel.org>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126015346.25208-7-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 02:53:44AM +0100, Christian Marangi wrote:
> Document Qcom QCA807x PHY package.
> 
> Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> 1000BASE-T PHY-s.
> 
> Document the required property to make the PHY package correctly
> configure and work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/net/qcom,qca807x.yaml | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> new file mode 100644
> index 000000000000..136ba2128b73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCA807X Ethernet PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> +  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> +  1000BASE-T PHY-s.
> +
> +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> +  MAC, while second one is SGMII for connection to MAC or fiber.
> +
> +  Both models have a combo port that supports 1000BASE-X and
> +  100BASE-FX fiber.
> +
> +  Each PHY inside of QCA807x series has 4 digitally controlled
> +  output only pins that natively drive LED-s for up to 2 attached
> +  LEDs. Some vendor also use these 4 output for GPIO usage without
> +  attaching LEDs.
> +
> +  Note that output pins can be set to drive LEDs OR GPIO, mixed
> +  definition are not accepted.

This so far is about the only thing that convinces me of having child 
nodes.

> +
> +  PHY package can be configured in 3 mode following this table:
> +
> +                First Serdes mode       Second Serdes mode
> +  Option 1      PSGMII for copper       Disabled
> +                ports 0-4
> +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> +                ports 0-4
> +  Option 3      QSGMII for copper       SGMII for
> +                ports 0-3               copper port 4
> +
> +$ref: ethernet-phy-package.yaml#
> +

Did you test this binding? No, because there is nothing to select it. 
Just put a wrong value for qcom,package-mode and see.

ethernet-phy-package.yaml will be applied, but since it allows any extra 
properties not much is tested.

> +properties:
> +  qcom,package-mode:
> +    enum:
> +      - qsgmii
> +      - psgmii

description needed.

I don't understand how the 3 modes works with only 2 modes defined here.

> +
> +  qcom,tx-driver-strength:
> +    description: set the TX Amplifier value in mv.

millivolts or...

> +      If not defined, 600mw is set by default.

milliwatts?

Whatever it is, use standard unit suffix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [140, 160, 180, 200, 220,
> +           240, 260, 280, 300, 320,
> +           400, 500, 600]
> +
> +patternProperties:
> +  ^ethernet-phy(@[a-f0-9]+)?$:

I'm confused. The addresses are MDIO, but you have just 0-4. Might be 
correct or might not?

In any case, the unit-address should be restricted to '@1?[0-9a-f]$'. 
Though that belongs in mdio.yaml and here '^ethernet-phy@' is sufficient 
(once there's a reference to mdio.yaml).

> +    $ref: ethernet-phy.yaml#

> +
> +    properties:
> +      gpio-controller:
> +        description: set the output lines as GPIO instead of LEDs
> +        type: boolean
> +
> +      '#gpio-cells':
> +        description: number of GPIO cells for the PHY
> +        const: 2
> +
> +    dependencies:
> +      gpio-controller: ['#gpio-cells']

No need for this, the common gpio schema does this.

> +
> +    if:
> +      required:
> +        - gpio-controller
> +    then:
> +      properties:
> +        leds: false
> +
> +    unevaluatedProperties: false

Move under $ref.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "ethernet-phy-package";
> +            reg = <0>;
> +
> +            qcom,package-mode = "qsgmii";

Nothing in here tells me this is a QCA807X other than this property 
(sort of). You need a specific compatible.

> +
> +            ethernet-phy@0 {
> +                reg = <0>;
> +
> +                leds {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    led@0 {
> +                        reg = <0>;
> +                        color = <LED_COLOR_ID_GREEN>;
> +                        function = LED_FUNCTION_LAN;
> +                        default-state = "keep";
> +                    };
> +                };
> +            };
> +
> +            ethernet-phy@1 {
> +                reg = <1>;
> +            };
> +
> +            ethernet-phy@2 {
> +                reg = <2>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            ethernet-phy@3 {
> +                reg = <3>;
> +            };
> +
> +            ethernet-phy@4 {
> +                reg = <4>;
> +            };
> +        };
> +    };
> -- 
> 2.40.1
> 
