Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361087A2F99
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjIPLOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjIPLNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:13:40 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45320E4E;
        Sat, 16 Sep 2023 04:13:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51BF6240003;
        Sat, 16 Sep 2023 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhIrExaH+Pxga2qgOi/puibscZ/eAZoI/ny/hgH81io=;
        b=jQd0Gg737dggiZcbuwSo9+ScBsaoWp0hSmSQV+Uw4DHZL9+nAfv+His6tE/s4jcaPECdfS
        3PGuHtcD6ZBST3GP+GcXpao4T+19AD3mR7a0iFPctDerOEbID43OqogHDjknexA5ZJOMTR
        3jQreJPImNKLVLB66K/k1GeC6ELcVz0NXoe6iqaEVmyCFzqMiKcrxkYwbQTNGoIiWJ8S2i
        yKMaMRd2GDcKecgNAeNhq+uSnl0ewa5HnqlZUOUerSkE/fUtuZtuSqfhDSNnZLYA1l01DN
        p3PY5iRyOgyQh/9bP1g7+HlEF4DT8I/684zeGZ1QKOS/0rQtEvPXZazEW85C9w==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
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
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Woojung Huh <Woojung.Huh@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink bindings on certain ethernet controllers
Date:   Sat, 16 Sep 2023 14:08:59 +0300
Message-Id: <20230916110902.234273-8-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230916110902.234273-1-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phylink bindings are required for ethernet controllers that utilise
phylink_fwnode_phy_connect() directly or through phylink_of_phy_connect(),
and register OF-based only MDIO buses, if they register any.

All the drivers that utilise phylink_fwnode_phy_connect() directly or
through phylink_of_phy_connect():

- DSA
- drivers/net/ethernet/mscc/ocelot_net.c
  - mscc,vsc7514-switch.yaml
- drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
  - microchip,sparx5-switch.yaml
- drivers/net/ethernet/altera/altera_tse_main.c
  - altr,tse.yaml
- drivers/net/ethernet/xilinx/xilinx_axienet_main.c
  - xlnx,axi-ethernet.yaml
- drivers/net/ethernet/mediatek/mtk_eth_soc.c
  - mediatek,net.yaml
- drivers/net/ethernet/ti/am65-cpsw-nuss.c
  - ti,k3-am654-cpsw-nuss.yaml
- drivers/net/ethernet/atheros/ag71xx.c
  - qca,ar71xx.yaml
- drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
  - fsl,fman-dtsec.yaml
- drivers/net/ethernet/microchip/lan966x/lan966x_main.c
  - microchip,lan966x-switch.yaml
- drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
  - marvell,pp2.yaml
- drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
  - fsl,qoriq-mc-dpmac.yaml
- drivers/net/ethernet/cadence/macb_main.c
  - cdns,macb.yaml
  - Can register non-OF-based bus.
- drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
  - snps,dwmac.yaml
  - Can register non-OF-based bus.
- drivers/net/ethernet/marvell/mvneta.c
  - marvell-armada-370-neta.txt
- drivers/net/ethernet/freescale/enetc/enetc.c
  - fsl-enetc.txt

RFC: The drivers marked with "can register non-OF-based bus" seem to search
the MDIO bus to connect the PHY to the MAC using phylink_connect_phy()
and/or phy_find_first() if phylink bindings don't exist. Should we enforce
phylink bindings on their schemas regardless?

DSA, like any other driver utilising the Linux MDIO infrastructure,
can register a bus. On certain conditions, it registers the MDIO
bus of the switch it controls non-OF-based.

We can know when DSA won't create any non-OF-based buses. That leaves us
with only OF-based buses in which case we can enforce phylink bindings for
user ports. The bindings are already enforced for shared ports so we can
enforce the bindings for all ports on the switch schemas which will achieve
the same result with fewer lines.

By looking at whether the mdio child node exists and what is explained on
it, we can enforce phylink bindings.

- mscc,vsc7514-switch.yaml
  - Enforce phylink bindings for all ports.

- arrow,xrs700x.yaml
  - Enforce phylink bindings for all ports.

- brcm,b53.yaml
  - Enforce phylink bindings for all ports if "mdio" is defined.

- brcm,sf2.yaml
  - Enforce phylink bindings for all ports.

- hirschmann,hellcreek.yaml
  - Enforce phylink bindings for all ports.

- mediatek,mt7530.yaml
  - Enforce phylink bindings for all ports if "mdio" is defined.

- microchip,ksz.yaml
  - Enforce phylink bindings for all ports if "mdio" is defined.

- microchip,lan937x.yaml
  - Enforce phylink bindings for all ports if "mdio" is defined.

- mscc,ocelot.yaml
  - Enforce phylink bindings for all ports.

- nxp,sja1105.yaml
  - Enforce phylink bindings for all ports.

- qca8k.yaml
  - Enforce phylink bindings for all ports if "mdio" is defined.

- realtek.yaml
  - Enforce phylink bindings for all ports if "mdio" is defined.

- renesas,rzn1-a5psw.yaml
  - Enforce phylink bindings for all ports.

- ar9331.txt
  - Enforce phylink bindings for all ports.

- lan9303.txt
  - Enforce phylink bindings for all ports if "mdio" is defined.

- lantiq-gswip.txt
  - Enforce phylink bindings for all ports.

- marvell.txt
  - Enforce phylink bindings for all ports if "mdio" is defined.

- vitesse,vsc73xx.txt
  - Enforce phylink bindings for all ports if "mdio" is defined.

I will convert the non json-schema documents accordingly.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/net/altr,tse.yaml     |  1 +
 .../devicetree/bindings/net/cdns,macb.yaml    |  1 +
 .../bindings/net/dsa/arrow,xrs700x.yaml       |  6 ++
 .../devicetree/bindings/net/dsa/brcm,b53.yaml |  9 +++
 .../devicetree/bindings/net/dsa/brcm,sf2.yaml |  6 +-
 .../net/dsa/hirschmann,hellcreek.yaml         |  6 ++
 .../bindings/net/dsa/mediatek,mt7530.yaml     |  9 +++
 .../bindings/net/dsa/microchip,ksz.yaml       |  9 +++
 .../bindings/net/dsa/microchip,lan937x.yaml   |  9 +++
 .../bindings/net/dsa/mscc,ocelot.yaml         |  6 ++
 .../bindings/net/dsa/nxp,sja1105.yaml         |  1 +
 .../devicetree/bindings/net/dsa/qca8k.yaml    |  9 +++
 .../devicetree/bindings/net/dsa/realtek.yaml  | 57 +++++++++++--------
 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  |  2 +-
 .../bindings/net/fsl,fman-dtsec.yaml          |  1 +
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml      |  1 +
 .../devicetree/bindings/net/marvell,pp2.yaml  |  4 +-
 .../devicetree/bindings/net/mediatek,net.yaml |  1 +
 .../net/microchip,lan966x-switch.yaml         |  4 +-
 .../bindings/net/microchip,sparx5-switch.yaml |  5 +-
 .../bindings/net/mscc,vsc7514-switch.yaml     |  5 ++
 .../devicetree/bindings/net/qca,ar71xx.yaml   |  1 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   |  4 +-
 .../bindings/net/xlnx,axi-ethernet.yaml       |  3 +-
 25 files changed, 130 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,tse.yaml b/Documentation/devicetree/bindings/net/altr,tse.yaml
index f5d3b70af07a..24e0f1213109 100644
--- a/Documentation/devicetree/bindings/net/altr,tse.yaml
+++ b/Documentation/devicetree/bindings/net/altr,tse.yaml
@@ -67,6 +67,7 @@ required:
 
 allOf:
   - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index bf8894a0257e..a455de04c5f1 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -156,6 +156,7 @@ required:
 
 allOf:
   - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
 
   - if:
       not:
diff --git a/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml b/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
index 9565a7402146..7829fc9e202d 100644
--- a/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/arrow,xrs700x.yaml
@@ -29,6 +29,12 @@ properties:
   reg:
     maxItems: 1
 
+patternProperties:
+  "^(ethernet-)?ports$":
+    patternProperties:
+      "^(ethernet-)?port@[0-9]+$":
+        $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
index 0bb2ff0cf2d0..ed5b3eab1948 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
@@ -142,6 +142,15 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      required: [ mdio ]
+    then:
+      patternProperties:
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-9]+$":
+              $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
index c745407f2f68..6cffcd35a943 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml
@@ -81,7 +81,10 @@ properties:
 
     patternProperties:
       '^port@[0-9a-f]$':
-        $ref: dsa-port.yaml#
+        type: object
+        allOf:
+          - $ref: dsa-port.yaml#
+          - $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
         unevaluatedProperties: false
 
         properties:
@@ -161,6 +164,7 @@ examples:
                     port@0 {
                             label = "gphy";
                             reg = <0>;
+                            phy-handle = <&phy8>;
                     };
             };
     };
diff --git a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
index 4021b054f684..30b4c7b1fd08 100644
--- a/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml
@@ -67,6 +67,12 @@ properties:
 
     additionalProperties: false
 
+patternProperties:
+  "^(ethernet-)?ports$":
+    patternProperties:
+      "^(ethernet-)?port@[0-9]+$":
+        $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 31a7dbbf704d..a8e1134707e4 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -297,6 +297,15 @@ allOf:
         mediatek,mcm: false
         reset-names: false
 
+  - if:
+      required: [ mdio ]
+    then:
+      patternProperties:
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-9]+$":
+              $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 20e4174fe1ab..d8f12234eec6 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -60,6 +60,15 @@ required:
   - compatible
   - reg
 
+if:
+  required: [ mdio ]
+then:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-9]+$":
+          $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 33a4926b2d94..44a892b93eca 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
@@ -65,6 +65,15 @@ required:
   - compatible
   - reg
 
+if:
+  required: [ mdio ]
+then:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-9]+$":
+          $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml b/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
index fe02d05196e4..80cc9c49282b 100644
--- a/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml
@@ -73,6 +73,12 @@ properties:
   little-endian: true
   big-endian: true
 
+patternProperties:
+  "^(ethernet-)?ports$":
+    patternProperties:
+      "^(ethernet-)?port@[0-9]+$":
+        $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 6838dc165d06..1d5c4a81caf6 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -79,6 +79,7 @@ patternProperties:
   "^(ethernet-)?ports$":
     patternProperties:
       "^(ethernet-)?port@[0-9]+$":
+        $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
         allOf:
           - if:
               properties:
diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
index c472050582be..546939ab2053 100644
--- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
@@ -114,6 +114,15 @@ required:
   - compatible
   - reg
 
+if:
+  required: [ mdio ]
+then:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-6]$":
+          $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 62ebaa4b5ae3..ec0428b74157 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -6,8 +6,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek switches for unmanaged switches
 
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
+$ref: dsa.yaml#/$defs/ethernet-ports
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
@@ -107,33 +106,43 @@ properties:
       compatible:
         const: realtek,smi-mdio
 
-if:
-  required:
-    - reg
+allOf:
+  - if:
+      required:
+        - reg
 
-then:
-  $ref: /schemas/spi/spi-peripheral-props.yaml#
-  properties:
-    mdc-gpios: false
-    mdio-gpios: false
-    mdio:
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
       properties:
-        compatible: false
+        mdc-gpios: false
+        mdio-gpios: false
+        mdio:
+          properties:
+            compatible: false
 
-else:
-  properties:
-    mdio:
-      required:
-        - compatible
+    else:
+      properties:
+        mdio:
+          required:
+            - compatible
 
-  required:
-    - mdc-gpios
-    - mdio-gpios
-    - mdio
-    - reset-gpios
+      required:
+        - mdc-gpios
+        - mdio-gpios
+        - mdio
+        - reset-gpios
 
-required:
-  - compatible
+    required:
+      - compatible
+
+  - if:
+      required: [ mdio ]
+    then:
+      patternProperties:
+        "^(ethernet-)?ports$":
+          patternProperties:
+            "^(ethernet-)?port@[0-9]+$":
+              $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
index 9ad9f5cdf688..7ec4371932ef 100644
--- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
@@ -72,7 +72,7 @@ properties:
 
     patternProperties:
       "^(ethernet-)?port@[0-4]$":
-        type: object
+        $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
         description: Ethernet switch ports
 
         properties:
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
index c80c880a9dab..c31db5f7d548 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
@@ -136,6 +136,7 @@ dependencies:
 
 allOf:
   - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index a1b71b35319e..b2cab0fa7b35 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -15,6 +15,7 @@ description:
 
 allOf:
   - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/net/marvell,pp2.yaml b/Documentation/devicetree/bindings/net/marvell,pp2.yaml
index 4eadafc43d4f..8e60cc4bbbc9 100644
--- a/Documentation/devicetree/bindings/net/marvell,pp2.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,pp2.yaml
@@ -59,7 +59,9 @@ patternProperties:
   '^(ethernet-)?port@[0-2]$':
     type: object
     description: subnode for each ethernet port.
-    $ref: ethernet-controller.yaml#
+    allOf:
+      - $ref: ethernet-controller.yaml#
+      - $ref: ethernet-controller.yaml#/$defs/phylink
     unevaluatedProperties: false
 
     properties:
diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index e74502a0afe8..7562bb64baa9 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -391,6 +391,7 @@ patternProperties:
     unevaluatedProperties: false
     allOf:
       - $ref: ethernet-controller.yaml#
+      - $ref: ethernet-controller.yaml#/$defs/phylink
     description:
       Ethernet MAC node
     properties:
diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
index 306ef9ecf2b9..a770cfc490a9 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
@@ -73,7 +73,9 @@ properties:
       "^port@[0-9a-f]+$":
         type: object
 
-        $ref: /schemas/net/ethernet-controller.yaml#
+        allOf:
+          - $ref: ethernet-controller.yaml#
+          - $ref: ethernet-controller.yaml#/$defs/phylink
         unevaluatedProperties: false
 
         properties:
diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index fcafef8d5a33..da4b4d934705 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -84,7 +84,10 @@ properties:
 
     patternProperties:
       "^port@[0-9a-f]+$":
-        $ref: /schemas/net/ethernet-controller.yaml#
+        type: object
+        allOf:
+          - $ref: ethernet-controller.yaml#
+          - $ref: ethernet-controller.yaml#/$defs/phylink
         unevaluatedProperties: false
 
         properties:
diff --git a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
index 8ee2c7d7ff42..b3aff7b0790e 100644
--- a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
@@ -126,6 +126,11 @@ properties:
       - const: xtr
       - const: fdma
 
+  ethernet-ports:
+    patternProperties:
+      "^port@[0-9a-f]+$":
+        $ref: ethernet-controller.yaml#/$defs/phylink
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/qca,ar71xx.yaml b/Documentation/devicetree/bindings/net/qca,ar71xx.yaml
index 89f94b31b546..d021bfb4ad20 100644
--- a/Documentation/devicetree/bindings/net/qca,ar71xx.yaml
+++ b/Documentation/devicetree/bindings/net/qca,ar71xx.yaml
@@ -8,6 +8,7 @@ title: QCA AR71XX MAC
 
 allOf:
   - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..62d8c2cfafe9 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -567,6 +567,7 @@ dependencies:
 
 allOf:
   - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index c9c25132d154..d4366a11918e 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -117,7 +117,9 @@ properties:
         type: object
         description: CPSWxG NUSS external ports
 
-        $ref: ethernet-controller.yaml#
+        allOf:
+          - $ref: ethernet-controller.yaml#
+          - $ref: ethernet-controller.yaml#/$defs/phylink
         unevaluatedProperties: false
 
         properties:
diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index 1d33d80af11c..f8894546c02a 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -130,7 +130,8 @@ required:
   - phy-handle
 
 allOf:
-  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
 
 additionalProperties: false
 
-- 
2.39.2

