Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD07A2F87
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbjIPLLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbjIPLLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:11:04 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6581AA;
        Sat, 16 Sep 2023 04:10:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A131B240005;
        Sat, 16 Sep 2023 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4p0NlFBH4xgH4kzo+ZWXDnGHN/kVaqsbVlpwtx8tToU=;
        b=GE4iVrg/VE60T4umjJ4+5PcY1uIjtRw3gTxSOWhjhMl1LwG2XNoSjEFnOZ0dZOadfELSFU
        pOfLfwbcAltSQTZaKj/bT32T4K4uc/NY2+crFKO7ljS9at1cQKOmC5F1Bb6IFA/P3kEMY0
        BgK/+953ow3X4WlpMSs4ZvNx/64Q6nPf3zfLGyEffzzkgUxlZ4/GI27HNd8U88/1PGNiM2
        OFLtIXplJbGO72zyIhGV7N5r61QYKwIcVmZwppFqtgp4obfTpB5BnHlSB5jq4Q+nPWYVQm
        44ZADQdPQEC1SMG+DcZ9V/9ZgjksBqHUUa3TmdTAxTBP0pey/1KlshitGGnVeg==
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
Subject: [PATCH net-next v2 04/10] dt-bindings: net: dsa: nxp,sja1105: improve MDIO bus bindings
Date:   Sat, 16 Sep 2023 14:08:56 +0300
Message-Id: <20230916110902.234273-5-arinc.unal@arinc9.com>
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

The SJA1110 switch uses the mdios property for its two MDIO buses. Instead
of a pattern, define two mdio nodes. This ensures the same compatible
string won't be used twice. The address and size cell definitions can also
be removed now that the reg property has become unnecessary.

Move the comment to the description of mdios, mdio0, and mdio1 properties.
Disallow the mdios property for SJA1105. Require at least one of the MDIO
buses to be defined to prevent empty mdios child node.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../bindings/net/dsa/nxp,sja1105.yaml         | 49 ++++++++++---------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
index 4d5f5cc6d031..3f3c4ecc6442 100644
--- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
@@ -35,42 +35,44 @@ properties:
   spi-cpha: true
   spi-cpol: true
 
-  # Optional container node for the 2 internal MDIO buses of the SJA1110
-  # (one for the internal 100base-T1 PHYs and the other for the single
-  # 100base-TX PHY). The "reg" property does not have physical significance.
-  # The PHY addresses to port correspondence is as follows: for 100base-T1,
-  # port 5 has PHY 1, port 6 has PHY 2 etc, while for 100base-TX, port 1 has
-  # PHY 1.
   mdios:
+    description:
+      The optional container node for the two MDIO buses of the SJA1110.
     type: object
 
     properties:
-      '#address-cells':
-        const: 1
-      '#size-cells':
-        const: 0
-
-    patternProperties:
-      "^mdio@[0-1]$":
+      mdio0:
+        description:
+          The node for the bus controlling the 100base-T1 PHYs of the SJA1110
+          switch. PHY address to port correspondence is port 5 has PHY 1, port 6
+          has PHY 2, etc.
         $ref: /schemas/net/mdio.yaml#
         unevaluatedProperties: false
 
         properties:
           compatible:
-            oneOf:
-              - enum:
-                  - nxp,sja1110-base-t1-mdio
-                  - nxp,sja1110-base-tx-mdio
+            const: nxp,sja1110-base-t1-mdio
+
+        required:
+          - compatible
 
-          reg:
-            oneOf:
-              - enum:
-                  - 0
-                  - 1
+      mdio1:
+        description:
+          The node for the bus controlling the 100base-TX PHY of the SJA1110
+          switch. PHY address to port correspondence is port 1 has PHY 1.
+        $ref: /schemas/net/mdio.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          compatible:
+            const: nxp,sja1110-base-tx-mdio
 
         required:
           - compatible
-          - reg
+
+    anyOf:
+      - required: [ mdio0 ]
+      - required: [ mdio1 ]
 
 patternProperties:
   "^(ethernet-)?ports$":
@@ -124,6 +126,7 @@ allOf:
     then:
       properties:
         spi-cpol: false
+        mdios: false
       required:
         - spi-cpha
     else:
-- 
2.39.2

