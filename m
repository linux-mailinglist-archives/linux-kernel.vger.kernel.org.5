Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966CB782F99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjHURoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjHURoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8447100;
        Mon, 21 Aug 2023 10:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 467976277F;
        Mon, 21 Aug 2023 17:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3B2C433C8;
        Mon, 21 Aug 2023 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692639866;
        bh=qxBWLXm1TVKhqUStz3O0CU4MkI9YOr1ue36lkAtr6lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dS4g89w53VA93FPWStKLhn6oQbLT/jv7ri2G0X6VdHmQTcdjE63vpciEN6PD0wtov
         G7yZ0K7yvwFa/YOziTf7eVcEEDhj+iNAG8bAEiajQIKzYpcNVhU6WZyYG6iA1SlRf8
         XOA3ZEasA6xNA8BJtTittFjF/+wK5oQZm+k1VfNpX99Bscw+DevQ5OapigvwhcpGuF
         f42jUnNxr/A2G9Ech9j/HRAV+XpF3QHnysmour4nkYUGqcvQ1PGBNdR0wBWajoRgUT
         Z7PGOpYODKuq9gqmfnUb5VfkuucQpk/NvpnrLAFztS9LZwt43vuBllq9TSqYDJpyMZ
         FpjqR9xnEu5JA==
Received: (nullmailer pid 2018954 invoked by uid 1000);
        Mon, 21 Aug 2023 17:44:23 -0000
Date:   Mon, 21 Aug 2023 12:44:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230821174423.GA2008354-robh@kernel.org>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 10:20:43PM +0300, Arınç ÜNAL wrote:
> I've realised there are more schemas that extend the mdio.yaml schema. This
> is the final state of this patch.
> 
> dt-bindings: net: dsa: document internal MDIO bus
> 
> Add the schema to document the internal MDIO bus. Require the phy-handle
> property on the non-CPU ports if the mdio property is being used.
> 
> Define the mdio property on all of the schemas that refer to
> dsa.yaml#/$defs/ethernet-ports. Refer to dsa.yaml#/properties/mdio to point
> the human readers to the description on the dsa.yaml schema.
> 
> Some of these schemas extend the mdio.yaml schema. The mdio.yaml schema is
> also being referred to through dsa.yaml#/$defs/ethernet-ports now which
> means we cannot disallow additional properties by 'unevaluatedProperties:
> false' on the dsa.yaml schema.
> 
> ---
>  .../bindings/net/dsa/arrow,xrs700x.yaml        |  4 ++++
>  .../devicetree/bindings/net/dsa/brcm,b53.yaml  |  4 ++++
>  .../devicetree/bindings/net/dsa/brcm,sf2.yaml  |  4 ++++
>  .../devicetree/bindings/net/dsa/dsa.yaml       | 18 ++++++++++++++++++
>  .../bindings/net/dsa/hirschmann,hellcreek.yaml |  4 ++++
>  .../bindings/net/dsa/mediatek,mt7530.yaml      |  4 ++++
>  .../bindings/net/dsa/microchip,ksz.yaml        |  4 ++++
>  .../bindings/net/dsa/microchip,lan937x.yaml    |  2 +-
>  .../bindings/net/dsa/mscc,ocelot.yaml          |  4 ++++
>  .../bindings/net/dsa/nxp,sja1105.yaml          |  4 ++++
>  .../devicetree/bindings/net/dsa/qca8k.yaml     |  2 +-
>  .../devicetree/bindings/net/dsa/realtek.yaml   |  2 +-
>  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml   |  2 +-
>  13 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml b/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
> index 9565a740214629..f0229352e05694 100644
> --- a/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
> @@ -29,6 +29,10 @@ properties:
>    reg:
>      maxItems: 1
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> index 4c78c546343f5e..e14562b33bfb97 100644
> --- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> @@ -65,6 +65,10 @@ properties:
>                - brcm,bcm63268-switch
>            - const: brcm,bcm63xx-switch
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
> index c745407f2f6853..1bf4317e038687 100644
> --- a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
> @@ -90,6 +90,10 @@ properties:
>                tags enabled (per-packet metadata)
>              type: boolean
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  required:
>    - reg
>    - interrupts
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> index ec74a660bedaed..03ccedbc49dcc3 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> @@ -31,6 +31,24 @@ properties:
>        (single device hanging off a CPU port) must not specify this property
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> +  mdio:
> +    description: The internal MDIO bus of the switch
> +    $ref: /schemas/net/mdio.yaml#
> +
> +if:
> +  required: [ mdio ]
> +then:
> +  patternProperties:
> +    "^(ethernet-)?ports$":
> +      patternProperties:
> +        "^(ethernet-)?port@[0-9]+$":
> +          if:
> +            not:
> +              required: [ ethernet ]
> +          then:
> +            required:
> +              - phy-handle
> +
>  additionalProperties: true
>  $defs:
> diff --git a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
> index 4021b054f68446..32f17345825d4a 100644
> --- a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
> @@ -67,6 +67,10 @@ properties:
>      additionalProperties: false
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index e532c6b795f4fc..293d1affe75451 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -151,6 +151,10 @@ properties:
>        ethsys.
>      maxItems: 1
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  patternProperties:
>    "^(ethernet-)?ports$":
>      type: object
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index e51be1ac036237..01d11c642ecfd4 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -49,6 +49,10 @@ properties:
>        Set if the output SYNCLKO clock should be disabled. Do not mix with
>        microchip,synclko-125.
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> index 49af4b0d591695..15f24a1716cd44 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> @@ -32,7 +32,7 @@ properties:
>      maxItems: 1
>    mdio:
> -    $ref: /schemas/net/mdio.yaml#
> +    $ref: dsa.yaml#/properties/mdio
>      unevaluatedProperties: false
>  patternProperties:
> diff --git a/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml b/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
> index fe02d05196e4a6..d781b8c2324836 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
> @@ -73,6 +73,10 @@ properties:
>    little-endian: true
>    big-endian: true
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 4d5f5cc6d031e2..82dda8fae8b16e 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -72,6 +72,10 @@ properties:
>            - compatible
>            - reg
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false
> +
>  patternProperties:
>    "^(ethernet-)?ports$":
>      patternProperties:
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> index df64eebebe1856..001b72bcd0746b 100644
> --- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> @@ -60,7 +60,7 @@ properties:
>        B68 on the QCA832x and B49 on the QCA833x.
>    mdio:
> -    $ref: /schemas/net/mdio.yaml#
> +    $ref: dsa.yaml#/properties/mdio
>      unevaluatedProperties: false

Just from a schema standpoint, this is pointless indirection as 
dsa.yaml#/properties/mdio is just a reference to /schemas/net/mdio.yaml#.

As it seems an MDIO bus is not universal for DSA, it seems you'll be 
dropping this change anyways.

Rob
