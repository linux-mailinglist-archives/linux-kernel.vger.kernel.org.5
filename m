Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634C7A3100
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjIPO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIPO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 10:58:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72819F;
        Sat, 16 Sep 2023 07:58:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE970C433C8;
        Sat, 16 Sep 2023 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694876317;
        bh=dX6K8/8XTSFKCE9NxfqH47czugynVM+kjIOAxFuFB9s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YjCrlxY1jQcRkHX+Hldo+cnX3j9K2He5UwSQk4NsQe5K4qCH8v+6AvS5OambCyNVi
         UMO/Fq8TTQUxh1RquceijxjT8DaCPaqdP9hEp2O31bnA08K/Q/J7tRVBY2c9TIc3Yz
         gLDgVuZ88cFu8SQ1juqlnaQZ/yPOc1RlDg6OFsagLql9SkeM/ZtEvH8huiIX4N45kJ
         C5uOQA0JQ+I0L/LQUDhyl19yIAPLNOuOtCRO8XHXsepTW4dkvZPh4A0iqwLHddO1/O
         dQCrMXpXXxitmlKHJmu0SQ/6g5xeeW6PSEyn7pHZnfceNBCBHtnykGm+I2vKXF1rsN
         NH2hhZg+QV5Xw==
Received: (nullmailer pid 1637982 invoked by uid 1000);
        Sat, 16 Sep 2023 14:58:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     Marcin Wojtas <mw@semihalf.com>, erkin.bozoglu@xeront.com,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Machon <daniel.machon@microchip.com>,
        =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Magnus Damm <magnus.damm@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Steen He gelund <steen.hegelund@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, mithat.guner@xeront.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        George McCollister <george.mccollister@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        DENG Qingfang <dqfext@gmail.com>, Felix Fietkau <nbd@nbd.name>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        linux-mediatek@lists.infradead.org,
        Eric Dumazet <edumazet@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Alexandr e Torgue <alexandre.torgue@foss.st.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230916110902.234273-8-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-8-arinc.unal@arinc9.com>
Message-Id: <169487630940.1637895.12001153052612710003.robh@kernel.org>
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
Date:   Sat, 16 Sep 2023 09:58:30 -0500
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Sep 2023 14:08:59 +0300, Arınç ÜNAL wrote:
> Phylink bindings are required for ethernet controllers that utilise
> phylink_fwnode_phy_connect() directly or through phylink_of_phy_connect(),
> and register OF-based only MDIO buses, if they register any.
> 
> All the drivers that utilise phylink_fwnode_phy_connect() directly or
> through phylink_of_phy_connect():
> 
> - DSA
> - drivers/net/ethernet/mscc/ocelot_net.c
>   - mscc,vsc7514-switch.yaml
> - drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
>   - microchip,sparx5-switch.yaml
> - drivers/net/ethernet/altera/altera_tse_main.c
>   - altr,tse.yaml
> - drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>   - xlnx,axi-ethernet.yaml
> - drivers/net/ethernet/mediatek/mtk_eth_soc.c
>   - mediatek,net.yaml
> - drivers/net/ethernet/ti/am65-cpsw-nuss.c
>   - ti,k3-am654-cpsw-nuss.yaml
> - drivers/net/ethernet/atheros/ag71xx.c
>   - qca,ar71xx.yaml
> - drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
>   - fsl,fman-dtsec.yaml
> - drivers/net/ethernet/microchip/lan966x/lan966x_main.c
>   - microchip,lan966x-switch.yaml
> - drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>   - marvell,pp2.yaml
> - drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
>   - fsl,qoriq-mc-dpmac.yaml
> - drivers/net/ethernet/cadence/macb_main.c
>   - cdns,macb.yaml
>   - Can register non-OF-based bus.
> - drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>   - snps,dwmac.yaml
>   - Can register non-OF-based bus.
> - drivers/net/ethernet/marvell/mvneta.c
>   - marvell-armada-370-neta.txt
> - drivers/net/ethernet/freescale/enetc/enetc.c
>   - fsl-enetc.txt
> 
> RFC: The drivers marked with "can register non-OF-based bus" seem to search
> the MDIO bus to connect the PHY to the MAC using phylink_connect_phy()
> and/or phy_find_first() if phylink bindings don't exist. Should we enforce
> phylink bindings on their schemas regardless?
> 
> DSA, like any other driver utilising the Linux MDIO infrastructure,
> can register a bus. On certain conditions, it registers the MDIO
> bus of the switch it controls non-OF-based.
> 
> We can know when DSA won't create any non-OF-based buses. That leaves us
> with only OF-based buses in which case we can enforce phylink bindings for
> user ports. The bindings are already enforced for shared ports so we can
> enforce the bindings for all ports on the switch schemas which will achieve
> the same result with fewer lines.
> 
> By looking at whether the mdio child node exists and what is explained on
> it, we can enforce phylink bindings.
> 
> - mscc,vsc7514-switch.yaml
>   - Enforce phylink bindings for all ports.
> 
> - arrow,xrs700x.yaml
>   - Enforce phylink bindings for all ports.
> 
> - brcm,b53.yaml
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - brcm,sf2.yaml
>   - Enforce phylink bindings for all ports.
> 
> - hirschmann,hellcreek.yaml
>   - Enforce phylink bindings for all ports.
> 
> - mediatek,mt7530.yaml
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - microchip,ksz.yaml
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - microchip,lan937x.yaml
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - mscc,ocelot.yaml
>   - Enforce phylink bindings for all ports.
> 
> - nxp,sja1105.yaml
>   - Enforce phylink bindings for all ports.
> 
> - qca8k.yaml
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - realtek.yaml
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - renesas,rzn1-a5psw.yaml
>   - Enforce phylink bindings for all ports.
> 
> - ar9331.txt
>   - Enforce phylink bindings for all ports.
> 
> - lan9303.txt
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - lantiq-gswip.txt
>   - Enforce phylink bindings for all ports.
> 
> - marvell.txt
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> - vitesse,vsc73xx.txt
>   - Enforce phylink bindings for all ports if "mdio" is defined.
> 
> I will convert the non json-schema documents accordingly.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/net/altr,tse.yaml     |  1 +
>  .../devicetree/bindings/net/cdns,macb.yaml    |  1 +
>  .../bindings/net/dsa/arrow,xrs700x.yaml       |  6 ++
>  .../devicetree/bindings/net/dsa/brcm,b53.yaml |  9 +++
>  .../devicetree/bindings/net/dsa/brcm,sf2.yaml |  6 +-
>  .../net/dsa/hirschmann,hellcreek.yaml         |  6 ++
>  .../bindings/net/dsa/mediatek,mt7530.yaml     |  9 +++
>  .../bindings/net/dsa/microchip,ksz.yaml       |  9 +++
>  .../bindings/net/dsa/microchip,lan937x.yaml   |  9 +++
>  .../bindings/net/dsa/mscc,ocelot.yaml         |  6 ++
>  .../bindings/net/dsa/nxp,sja1105.yaml         |  1 +
>  .../devicetree/bindings/net/dsa/qca8k.yaml    |  9 +++
>  .../devicetree/bindings/net/dsa/realtek.yaml  | 57 +++++++++++--------
>  .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  |  2 +-
>  .../bindings/net/fsl,fman-dtsec.yaml          |  1 +
>  .../bindings/net/fsl,qoriq-mc-dpmac.yaml      |  1 +
>  .../devicetree/bindings/net/marvell,pp2.yaml  |  4 +-
>  .../devicetree/bindings/net/mediatek,net.yaml |  1 +
>  .../net/microchip,lan966x-switch.yaml         |  4 +-
>  .../bindings/net/microchip,sparx5-switch.yaml |  5 +-
>  .../bindings/net/mscc,vsc7514-switch.yaml     |  5 ++
>  .../devicetree/bindings/net/qca,ar71xx.yaml   |  1 +
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   |  4 +-
>  .../bindings/net/xlnx,axi-ethernet.yaml       |  3 +-
>  25 files changed, 130 insertions(+), 31 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'snps,axi-config', 'snps,pbl', 'snps,tso' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40028000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40028000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'snps,mixed-burst', 'snps,pbl' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40028000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'snps,pbl' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/stm32-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/cdns,macb.example.dtb: ethernet@fffc4000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/cdns,macb.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,pp2.example.dtb: ethernet@f0000: ethernet-port@0: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/marvell,pp2.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,pp2.example.dtb: ethernet@f0000: ethernet-port@1: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/marvell,pp2.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,pp2.example.dtb: ethernet@0: ethernet-port@0: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/marvell,pp2.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,pp2.example.dtb: ethernet@0: ethernet-port@1: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/marvell,pp2.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,dwmac-imx.example.dtb: ethernet@30bf0000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/nxp,dwmac-imx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,dwmac-imx.example.dtb: ethernet@30bf0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/nxp,dwmac-imx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,dwmac-imx.example.dtb: ethernet@30bf0000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/rockchip-dwmac.example.dtb: ethernet@ff290000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/rockchip-dwmac.example.dtb: ethernet@ff290000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.example.dtb: ethernet@c9410000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/amlogic,meson-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.example.dtb: ethernet@c9410000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/amlogic,meson-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.example.dtb: ethernet@c9410000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/snps,dwmac.example.dtb: ethernet@e0800000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.example.dtb: ethernet@1c50000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun7i-a20-gmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.example.dtb: ethernet@1c50000: Unevaluated properties are not allowed ('phy-mode' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/allwinner,sun7i-a20-gmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000: 'anyOf' conditional failed, one must be fixed:
	'fixed-link' is a required property
	'pcs-handle' is a required property
	'tbi-handle' is a required property
	'phy-handle' is a required property
	'sfp' is a required property
	'managed' is a required property
	from schema $id: http://devicetree.org/schemas/net/mediatek-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek-dwmac.example.dtb: ethernet@1101c000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mac-address', 'phy-mode', 'reg', 'snps,reset-delays-us', 'snps,reset-gpio', 'snps,rxpbl', 'snps,txpbl' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/mediatek-dwmac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230916110902.234273-8-arinc.unal@arinc9.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

