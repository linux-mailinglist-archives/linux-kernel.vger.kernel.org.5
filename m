Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9437CFBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbjJSNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345725AbjJSNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:51:08 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E881124;
        Thu, 19 Oct 2023 06:51:06 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ce2add34c9so378282a34.1;
        Thu, 19 Oct 2023 06:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697723465; x=1698328265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXPDgRRQ6T5BPQS0IhBT47wS9hbtPGflBMHajnRGGOU=;
        b=n/fMgAEt+x7IO3K9zsUaa/mskzflaWXiDAASjl8Ky+8ZItJ2jmCziLNXRls1CJPn+G
         6SKRpmLus2VyJeTnrvuCDm9CKE8z6OKzFRp2rI7/P79qtUlruSGbQFw3p9ADYd2bIQ3r
         3FfGFG1lf8CEk4YogDLhnThbowdiC1ADgVzFFWn1sNEoregLWEmYhP80u/uqStJJSmcx
         DmdFHPpvj3KnTj/06RTNbYJx+MhkCaJluPrLOrpbxv3E2FXhyD3nOwpqDAmpT3ek9nKC
         zADGfVzNBt5n63e8IR90VlaxG0KrdoVPOG9yOaXmujpaMXEdsVtzo7qd59x07FkuXTfr
         EENw==
X-Gm-Message-State: AOJu0YzRpUaC2bw2W7epasNJzp3bFJldEdK8I+9db+kV0xpeicgHKzcB
        1tU5HzFcHfVPbu7yV2cZDQ==
X-Google-Smtp-Source: AGHT+IENuZL/HnUy7UDsGrM7VcB4suJ9r662njqRotNT7nKM+017ingvmHICt23kcrkZUgb4MoqrLA==
X-Received: by 2002:a9d:6a8f:0:b0:6bf:ef0:c69 with SMTP id l15-20020a9d6a8f000000b006bf0ef00c69mr2277189otq.34.1697723465201;
        Thu, 19 Oct 2023 06:51:05 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m46-20020a05683026ee00b006c4d38e12b9sm1040630otu.65.2023.10.19.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:51:04 -0700 (PDT)
Received: (nullmailer pid 206032 invoked by uid 1000);
        Thu, 19 Oct 2023 13:51:03 -0000
Date:   Thu, 19 Oct 2023 08:51:03 -0500
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
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231019135103.GA203636-robh@kernel.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:03:45AM +0200, Linus Walleij wrote:
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
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 225 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 226 insertions(+), 110 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> new file mode 100644
> index 000000000000..8013ac411b15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> @@ -0,0 +1,225 @@
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
> +    enum:
> +      - marvell,mv88e6085
> +      - marvell,mv88e6190
> +      - marvell,mv88e6250
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
> +      internal and external MDIO buses, in some cases a combined bus that
> +      can be used both internally and externally. This node is for the
> +      primary bus, used internally and sometimes also externally.
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

Drop this. Covered by the line below.

> +
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports

