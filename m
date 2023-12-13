Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF51811D30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379116AbjLMSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjLMSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:46:00 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670ABEB;
        Wed, 13 Dec 2023 10:46:07 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so113274b6e.3;
        Wed, 13 Dec 2023 10:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493166; x=1703097966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypDAUZtqQsHCWJvG9R68gKE5grPMiGIdHhSF45/XI9Y=;
        b=J5ZaGphrlGw8cDc6qEUlXkDCCh2yYjW2eoIQImxxNgq/Dl5sYF0gToYecka6tGJvv9
         KzsvsRiPNNYjVYub3SBXV70FJHWWXnBTgzZbtceBdVIT4++ksSIhbY1uvAnv+uJPZp7s
         JEWy8yHWQQH0xfvD1bShvnfuQefs2SlZwT3qwnXTD4aVboMgV1M9+m59+D/+6QXn1PB5
         +l1mRp0b7Bv/WACnHRMNrnOdjcepgOXS1S8OJ0XkRNGOBUFRSHqlOPP46A6uypAfs8E9
         mPdUvsDTe+BhOSbBrx7nwf/GPWhuIuaVwlZR/Vz1uJCc3kWcNJthG3vIHwOj2IBgduG0
         H5uA==
X-Gm-Message-State: AOJu0Yz6YTv6s3c6lCPTIPgVc8+nRgBch8cxs2AomfeSjMujTTZd1fHc
        8Xwy22359Dk2peeRDAhnrMHz+thGTg==
X-Google-Smtp-Source: AGHT+IFr/VJgLdjQp5boJaMDjP0/Xxbbt4r1gRhYk+65qogG3aH9Gj22wXCt/wNNPMMIZWVT/JGFTA==
X-Received: by 2002:a05:6808:3c8b:b0:3b9:f584:1e9 with SMTP id gs11-20020a0568083c8b00b003b9f58401e9mr11687488oib.7.1702493166470;
        Wed, 13 Dec 2023 10:46:06 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r5-20020a056808210500b003b85c2b17efsm3049174oiw.9.2023.12.13.10.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:46:05 -0800 (PST)
Received: (nullmailer pid 1705906 invoked by uid 1000);
        Wed, 13 Dec 2023 18:46:04 -0000
Date:   Wed, 13 Dec 2023 12:46:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
Message-ID: <20231213184604.GA1701402-robh@kernel.org>
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209014828.28194-1-ansuelsmth@gmail.com>
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

On Sat, Dec 09, 2023 at 02:48:27AM +0100, Christian Marangi wrote:
> Add Documentation for QCA808x PHYs for the additional property for the
> active high LED setting and also document the LED configuration for this
> PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/net/qca,qca808x.yaml  | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
> new file mode 100644
> index 000000000000..73cfff357311
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0+

Dual license as checkpatch.pl points out.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qca,qca808x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Atheros QCA808X PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Bindings for Qualcomm Atheros QCA808X PHYs
> +
> +  QCA808X PHYs can have up to 3 LEDs attached.
> +  All 3 LEDs are disabled by default.
> +  2 LEDs have dedicated pins with the 3rd LED having the
> +  double function of Interrupt LEDs/GPIO or additional LED.
> +
> +  By default this special PIN is set to LED function.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id004d.d101

Move this to properties and drop the select.

> +  required:
> +    - compatible
> +
> +properties:
> +  qca,led-active-high:
> +    description: Set all the LEDs to active high to be turned on.
> +    type: boolean
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
> +        ethernet-phy@0 {
> +            compatible = "ethernet-phy-id004d.d101";
> +            reg = <0>;
> +            qca,led-active-high;
> +
> +            leds {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                    reg = <0>;
> +                    color = <LED_COLOR_ID_GREEN>;
> +                    function = LED_FUNCTION_WAN;
> +                    default-state = "keep";
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.40.1
> 
