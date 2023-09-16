Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AA7A2F94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjIPLNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjIPLNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:13:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F36E62;
        Sat, 16 Sep 2023 04:12:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86FEF240002;
        Sat, 16 Sep 2023 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxK8lRKWIBb9Z0O3Tvb06WKXqFsJaGZqBLWHiNoJa3o=;
        b=DjJ2fCg+wOKIS1DRGr73CWt8njm6u2HR4WWyOJN4HutNBHu3/1RBIe+MHn7PjSeGIMw80C
        yP9rtDIfZKpD82VrW1U/XKKELh1kDRKoMHwxMdgEyyPzKJShHGQ9cxqafjEDOkmlfw23WY
        pCa2BdbZUMV8QP1VaCiRb5Q061T7COsXPzdtfNE1S5pDdfbWus9ads9qANlQwgR/Zn3dGN
        5v4N9sqpqn8MM/3dA//0l6TKN38AtKhhOtmLqUkNaLVB/eO2NomBYxZsESH18gCfMzu5i7
        cYOy2zBTTP4eNXco6g9d1Werqui7D+26dueceOzN3KMSzZIGPNE0/N81TmDHXA==
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
Subject: [PATCH net-next v2 06/10] dt-bindings: net: define phylink bindings
Date:   Sat, 16 Sep 2023 14:08:58 +0300
Message-Id: <20230916110902.234273-7-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230916110902.234273-1-arinc.unal@arinc9.com>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the phylink bindings on ethernet-controller.yaml and replace the
bindings on the dsa-port.yaml schema with them. The shared ports of DSA
requires phy-mode so keep that.

Important remarks about the phylink bindings:
- fsl,fman-dtsec uses tbi-handle instead of pcs-handle, therefore
  tbi-handle is included.
- For sfp, only managed with the in-band-status value must be required, but
  phy-handle is required as another option because of a special case on the
  eth2 node on arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/net/dsa/dsa-port.yaml | 12 ++------
 .../bindings/net/ethernet-controller.yaml     | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
index 480120469953..53efb686cfc7 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
@@ -65,16 +65,8 @@ if:
     - required: [ ethernet ]
     - required: [ link ]
 then:
-  allOf:
-    - required:
-        - phy-mode
-    - oneOf:
-        - required:
-            - fixed-link
-        - required:
-            - phy-handle
-        - required:
-            - managed
+  $ref: /schemas/net/ethernet-controller.yaml#/$defs/phylink
+  required: [ phy-mode ]
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 9f6a5ccbcefe..ef28ebc76798 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -284,6 +284,35 @@ allOf:
             controllers that have configurable TX internal delays. If this
             property is present then the MAC applies the TX delay.
 
+$defs:
+  phylink:
+    description: phylink bindings for ethernet controllers
+    allOf:
+      - anyOf:
+          - required: [ fixed-link ]
+          - required: [ pcs-handle ]
+          - required: [ tbi-handle ]
+          - required: [ phy-handle ]
+          - required: [ sfp ]
+          - required: [ managed ]
+
+      - if:
+          required: [ fixed-link ]
+        then:
+          properties:
+            managed:
+              const: auto
+
+      - if:
+          required: [ sfp ]
+        then:
+          oneOf:
+            - required: [ phy-handle ]
+            - required: [ managed ]
+              properties:
+                managed:
+                  const: in-band-status
+
 additionalProperties: true
 
 ...
-- 
2.39.2

