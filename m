Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C97A5245
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjIRSoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIRSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF0F7;
        Mon, 18 Sep 2023 11:44:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC69C433C8;
        Mon, 18 Sep 2023 18:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695062687;
        bh=l94fNcvQJf/PIKELnXSlgPSkqASiwOKlOKbSxFVwC6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2VzlRoLMm7NBWOFWE82KEzGVGHQdnSPvWMA9hoL6OAaB+IEu6drWsA1e7wt1CfH1
         C2QbKJqt+c8hmtrL63FHUj+Rq5JkuvZ6Q1mrd+4oiF/G9WLzWI9hoZkqOCYu4jRzf+
         O2xPQM49wxEY00m66uzp5tkxiRDrJDhgl/NVm5z1zsE/tlagklF716JwRtGXLcEg21
         vqDrVOLJF5X7IxWkbnJr0L6kJO9HpTtIJ7Spjj+RAoUy2QmLYnVe52jD25k2I3Evpj
         75/eyzJiZD9567+KqLwGlC0fHgVtQG+O6ldxOOuBGy2Asom9a8JpWbAnOME2jdmAMi
         Jk8WpHJ75RVVA==
Received: (nullmailer pid 1497106 invoked by uid 1000);
        Mon, 18 Sep 2023 18:44:38 -0000
Date:   Mon, 18 Sep 2023 13:44:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Crispin <john@phrozen.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 05/10] dt-bindings: net: dsa: define MDIO bus
 child node
Message-ID: <20230918184438.GC1464506-robh@kernel.org>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-6-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230916110902.234273-6-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 02:08:57PM +0300, Arınç ÜNAL wrote:
> Some DSA subdrivers register the MDIO bus of the switch they control. Or
> let the DSA driver register the MDIO bus. The node for these buses are
> either required or optional, depending on the subdriver. Document this on
> all of the affected DSA switch schemas.
> 
> The attributes of a DSA subdriver that lets the DSA driver register the
> bus:
> - ds->ops->phy_read() and ds->ops->phy_write() are present.
> - ds->slave_mii_bus is not populated by the DSA subdriver.
> - The bus is registered non-OF-based or OF-based. Registered OF-based if
>   "mdio" child node is defined.
> 
> The affected DSA switch schemas are documented below.
> 
> - brcm,b53.yaml
> 
> drivers/net/dsa/b53/b53_common.c:
> - The DSA subdriver lets the DSA driver register the bus.
> 
> ---

This will cause everything after here to be dropped when the patch is 
applied.

In any case, write binding commit message without Linux details. 
Ideally, variations should be based on hardware differences not driver 
policies.

> 
> - mediatek,mt7530.yaml
> 
> drivers/net/dsa/mt7530.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
>   child node is defined.
> 
> ---
> 
> - microchip,ksz.yaml
> - microchip,lan937x.yaml
> 
> drivers/net/dsa/microchip/ksz_common.c:
> - The DSA subdriver won't let the DSA driver register the bus when "mdio"
>   child node is defined. Registers the bus OF-based only. Registers the bus
>   when "mdio" child node is defined.
>   - mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");
>     if (!mdio_np)
>       return 0;
>     ds->slave_mii_bus = bus;
> 
> ---
> 
> - nxp,sja1105.yaml
> 
> drivers/net/dsa/sja1105/sja1105_mdio.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers multiple buses OF-based only. Registers the buses when "mdios"
>   child node and "nxp,sja1110-base-tx-mdio" and "nxp,sja1110-base-t1-mdio"
>   compatible strings per child node under "mdios" is defined.
>   - mdio_node = of_get_child_by_name(switch_node, "mdios");
>     if (!mdio_node)
>       return 0;
>   - np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-tx-mdio");
>     if (!np)
>       return 0;
>   - np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-t1-mdio");
>     if (!np)
>       return 0;
> 
> ---
> 
> - qca8k.yaml
> 
> drivers/net/dsa/qca/qca8k-8xxx.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
>   child node is defined.
>   - mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
> 
> ---
> 
> - realtek.yaml
> 
> drivers/net/dsa/realtek/realtek-smi.c:
> - The DSA subdriver won't let the DSA driver register the bus. Registers
>   the bus OF-based only. Registering the bus is mandatory. Registers the
>   bus when compatible string "realtek,smi-mdio" on a child node is defined.
>   - mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
>     if (!mdio_np)
>       return -ENODEV;
>     ds->slave_mii_bus = priv->slave_mii_bus;
> 
> drivers/net/dsa/realtek/realtek-mdio.c:
> - The DSA subdriver lets the DSA driver register the bus.
> 
> ---
> 
> - renesas,rzn1-a5psw.yaml
> 
> drivers/net/dsa/rzn1_a5psw.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers the bus OF-based only. Registers the bus when "mdio" child node
>   is defined.
>   -	mdio = of_get_child_by_name(dev->of_node, "mdio");
>     if (of_device_is_available(mdio))
>       ret = a5psw_probe_mdio(a5psw, mdio);
> 
> ---
> 
> - ar9331.txt
> 
> drivers/net/dsa/qca/ar9331.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers the bus OF-based only. Registering the bus is mandatory.
>   Registers the bus when "mdio" child node is defined.
>   - mnp = of_get_child_by_name(np, "mdio");
>     if (!mnp)
>       return -ENODEV;
> 
> ---
> 
> - lan9303.txt
> 
> drivers/net/dsa/lan9303-core.c:
> - The DSA subdriver lets the DSA driver register the bus.
> 
> ---
> 
> - lantiq-gswip.txt
> 
> drivers/net/dsa/lantiq_gswip.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - No ds->ops->phy_read() or ds->ops->phy_write().
> - Registers the bus OF-based only. Registers the bus when compatible string
>   "lantiq,xrx200-mdio" on a child node is defined.
>   - mdio_np = of_get_compatible_child(dev->of_node, "lantiq,xrx200-mdio");
>     if (mdio_np)
>       err = gswip_mdio(priv, mdio_np);
> 
> ---
> 
> - marvell.txt
> 
> drivers/net/dsa/mv88e6xxx/chip.c:
> - The DSA subdriver won't let the DSA driver register the bus.
>   - ds->slave_mii_bus = mv88e6xxx_default_mdio_bus(chip);
> - Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
>   child node is defined.
> 
> ---
> 
> - vitesse,vsc73xx.txt
> 
> drivers/net/dsa/vitesse-vsc73xx-core.c:
> - The DSA subdriver lets the DSA driver register the bus.
> 
> I will convert the non json-schema documents accordingly.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/net/dsa/brcm,b53.yaml          |  7 +++++++
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml   |  7 +++++++
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml     |  7 +++++++
>  .../devicetree/bindings/net/dsa/microchip,lan937x.yaml |  3 +++
>  .../devicetree/bindings/net/dsa/nxp,sja1105.yaml       |  3 ++-
>  Documentation/devicetree/bindings/net/dsa/qca8k.yaml   | 10 +++++-----
>  Documentation/devicetree/bindings/net/dsa/realtek.yaml |  4 ++++
>  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml           |  3 +++
>  8 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> index 4c78c546343f..0bb2ff0cf2d0 100644
> --- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> @@ -65,6 +65,13 @@ properties:
>                - brcm,bcm63268-switch
>            - const: brcm,bcm63xx-switch
>  
> +  mdio:
> +    description:
> +      The optional node for the MDIO bus of the switch. The bus will be
> +      registered non-OF-based if this is not defined.
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index e532c6b795f4..31a7dbbf704d 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -151,6 +151,13 @@ properties:
>        ethsys.
>      maxItems: 1
>  
> +  mdio:
> +    description:
> +      The optional node for the MDIO bus of the switch. The bus will be
> +      registered non-OF-based if this is not defined.
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
>  patternProperties:
>    "^(ethernet-)?ports$":
>      type: object
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index e51be1ac0362..20e4174fe1ab 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -49,6 +49,13 @@ properties:
>        Set if the output SYNCLKO clock should be disabled. Do not mix with
>        microchip,synclko-125.
>  
> +  mdio:
> +    description:
> +      The optional node for the MDIO bus of the switch. The bus will be
> +      registered non-OF-based if this is not defined.
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> index d187034fb31a..33a4926b2d94 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
> @@ -32,6 +32,9 @@ properties:
>      maxItems: 1
>  
>    mdio:
> +    description:
> +      The optional node for the MDIO bus of the switch. The bus will be
> +      registered non-OF-based if this is not defined.
>      $ref: /schemas/net/mdio.yaml#
>      unevaluatedProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 3f3c4ecc6442..6838dc165d06 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -37,7 +37,8 @@ properties:
>  
>    mdios:
>      description:
> -      The optional container node for the two MDIO buses of the SJA1110.
> +      The optional container node for the two MDIO buses of the SJA1110. The bus
> +      won't be registered if its node is not defined.
>      type: object
>  
>      properties:
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> index df64eebebe18..c472050582be 100644
> --- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
> @@ -60,13 +60,13 @@ properties:
>        B68 on the QCA832x and B49 on the QCA833x.
>  
>    mdio:
> +    description:
> +      The optional node for the MDIO bus of the switch. The bus will be
> +      registered non-OF-based if this is not defined. In that case, the legacy
> +      mapping will be used. With the legacy mapping, the reg corresponding to
> +      the MDIO bus is the switch reg with an offset of -1.
>      $ref: /schemas/net/mdio.yaml#
>      unevaluatedProperties: false
> -    description: Qca8k switch have an internal mdio to access switch port.
> -                 If this is not present, the legacy mapping is used and the
> -                 internal mdio access is used.
> -                 With the legacy mapping the reg corresponding to the internal
> -                 mdio is the switch reg with an offset of -1.
>  
>  $ref: dsa.yaml#
>  
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> index 7eb025df0df8..62ebaa4b5ae3 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -96,6 +96,10 @@ properties:
>        - '#interrupt-cells'
>  
>    mdio:
> +    description:
> +      The node for the MDIO bus of the switch. For the MDIO controlled switches,
> +      this is optional and the bus will be registered non-OF-based if this is
> +      not defined.
>      $ref: /schemas/net/mdio.yaml#
>      unevaluatedProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> index 833d2f68daa1..9ad9f5cdf688 100644
> --- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> @@ -46,6 +46,9 @@ properties:
>      maxItems: 1
>  
>    mdio:
> +    description:
> +      The optional node for the MDIO bus of the switch. The bus won't be
> +      registered if this is not defined.
>      $ref: /schemas/net/mdio.yaml#
>      unevaluatedProperties: false
>  
> -- 
> 2.39.2
> 
