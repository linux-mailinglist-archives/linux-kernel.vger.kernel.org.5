Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761177CA8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJPM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:57:48 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B194A2;
        Mon, 16 Oct 2023 05:57:47 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3afc38cbdbcso2328455b6e.1;
        Mon, 16 Oct 2023 05:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461066; x=1698065866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MwlUK1egCZ2dvdbGrNweXe0Njk0R/Nf5RkQ1HODqQg=;
        b=VSrkCkeOlPO1yxYOGPLh+sLtzaQKikbMIvkGFfMop5MStuYxtiD5iPU2qdgW9DM7dU
         5AB/FITR1JGsDXA9y+PwQhjdueG9PXc7LbD1uTmzTufSPBMzuRl151ZRuN9BKNWxD9Mi
         8VCugpZJUzMFr2SjDe2wraa2qvPZ9KPXQyodLayStxc+eGq4P9W7jpFPZ7+7I78h50aX
         0nUqzgxcrncmDGSP9hzebocuNhSgLCuVxXclQX7zKaL0h0RwDf+NkjYdCHsQq1Co9xA7
         NWu6NA6/kEnYWFujQTVb3e1VLSSUSbx3EJYkxKtbawGBf/cwKX8HMeJO+JShPOsjTtF5
         a8Hw==
X-Gm-Message-State: AOJu0YzRse4+AMvGe2p0FBDcCFB1/7G8jU/OMCl3Na9UjrT22mXjy4tO
        hImZ9xTZCcWNNA5edsmJog==
X-Google-Smtp-Source: AGHT+IFyYahMS48AlCxtEa8fqlsOgFUCfzkyZbq3xoT1b3JjxPOUHloC5ggzFsKyNNZvSpU7Q1muyw==
X-Received: by 2002:a05:6808:1a21:b0:3ad:cb0f:afa8 with SMTP id bk33-20020a0568081a2100b003adcb0fafa8mr4589679oib.2.1697461066341;
        Mon, 16 Oct 2023 05:57:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a056808034500b003afe5617691sm1844805oie.12.2023.10.16.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:57:45 -0700 (PDT)
Received: (nullmailer pid 2590929 invoked by uid 1000);
        Mon, 16 Oct 2023 12:57:38 -0000
Date:   Mon, 16 Oct 2023 07:57:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231016125738.GA2578576-robh@kernel.org>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:12:54AM +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 243 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 244 insertions(+), 110 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> new file mode 100644
> index 000000000000..954db04147f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> @@ -0,0 +1,243 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MV88E6xxx DSA switch family
> +
> +maintainers:
> +  - Andrew Lunn <andrew@lunn.ch>
> +
> +description:
> +  The Marvell MV88E6xxx switch series has been produced and sold
> +  by Marvell since at least 2010. The switch has a few compatibles which
> +  just indicate the base address of the switch, then operating systems
> +  can investigate switch ID registers to find out which actual version
> +  of the switch it is dealing with.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:

Don't need oneOf with only 1 entry. However, I'd probably split each 
compatible and description for it into 3 entries.

> +          - marvell,mv88e6085
> +          - marvell,mv88e6190
> +          - marvell,mv88e6250
> +    description: |
> +      marvell,mv88e6085: This switch uses base address 0x10.
> +        This switch and its siblings will be autodetected from
> +        ID registers found in the switch, so only "marvell,mv88e6085" should be
> +        specified. This includes the following list of MV88Exxxx switches:
> +        6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165, 6171, 6172, 6175, 6176,
> +        6185, 6240, 6320, 6321, 6341, 6350, 6351, 6352
> +      marvell,mv88e6190: This switch uses base address 0x00.
> +        This switch and its siblings will be autodetected from
> +        ID registers found in the switch, so only "marvell,mv88e6190" should be
> +        specified. This includes the following list of MV88Exxxx switches:
> +        6190, 6190X, 6191, 6290, 6361, 6390, 6390X
> +      marvell,mv88e6250: This switch uses base address 0x08 or 0x18.
> +        This switch and its siblings will be autodetected from
> +        ID registers found in the switch, so only "marvell,mv88e6250" should be
> +        specified. This includes the following list of MV88Exxxx switches:
> +        6220, 6250
> +
> +  reg:
> +    maxItems: 1
> +
> +  eeprom-length:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set to the length of an EEPROM connected to the switch. Must be
> +      set if the switch can not detect the presence and/or size of a connected
> +      EEPROM, otherwise optional.
> +
> +  reset-gpios:
> +    description:
> +      GPIO to be used to reset the whole device
> +    maxItems: 1
> +
> +  interrupts:
> +    description: The switch provides an external interrupt line, but it is
> +      not always used by target systems.
> +    maxItems: 1
> +
> +  interrupt-controller:
> +    description: The switch has an internal interrupt controller used by
> +      the different sub-blocks.
> +
> +  '#interrupt-cells':
> +    description: The internal interrupt controller only supports triggering
> +      on active high level interrupts so the second cell must alway be set to
> +      IRQ_TYPE_LEVEL_HIGH.
> +    const: 2
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches have an varying combination of
> +    internal and external MDIO buses, in some cases a combined bus that
> +    can be used both internally and externally. This node is for the
> +    primary bus, used internally and sometimes also externally.
> +
> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches that have a separate external
> +      MDIO bus use this port to access external components on the MDIO bus.
> +
> +    properties:
> +      compatible:
> +        const: marvell,mv88e6xxx-mdio-external
> +
> +    required:
> +      - compatible
> +

> +$ref: dsa.yaml#
> +
> +patternProperties:
> +  "^(ethernet-)?ports$":
> +    type: object
> +    patternProperties:
> +      "^(ethernet-)?port@[0-9]+$":
> +        type: object
> +        description: Ethernet switch ports
> +
> +        $ref: dsa-port.yaml#
> +
> +        unevaluatedProperties: false

You can drop all this and ref dsa.yaml#/$defs/ethernet-ports instead of 
just dsa.yaml.

> +
> +oneOf:
> +  - required:
> +      - ports
> +  - required:
> +      - ethernet-ports

This probably belongs in dsa.yaml.

Rob
