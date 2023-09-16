Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664127A2FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjIPLOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbjIPLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:14:17 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A031BD;
        Sat, 16 Sep 2023 04:14:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89478240005;
        Sat, 16 Sep 2023 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694862843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAZCgeoh9KUduxxc51sEyaD/Ww3GnyAUx/PFLTVQyPc=;
        b=hKK2Wuk79GoaUo/hY/fuO5GNEsYpXvHQTmZHzkmUu1psjYgV5XTyUjTmWeR3yNV65L4Ghz
        kQB0p3rthYgY0/1iJ1iTHdBtt3XqWLfmGTwb2cQTywTU4YqVAi5uQYhbNk7NK/b0s7wch5
        o3R6bt5DMAyUXaAkMcviVr7aHL8KquFNdxeplIiYsZKYMMVXrxtHkocr3elHkU4mPcuJqK
        21vBYwU+gVEk/OLBULj3WcOF61OeP3y7yC+8z+plp1vHHwnnZbaTiVNcvxSGNrMqFtf+FM
        p6uiuukzlQvtFjbmaBTjXA7kM9QiyQdGrD7nVsUCHlmLE9UgQKwalLOkDla9Pw==
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
Subject: [PATCH net-next v2 10/10] dt-bindings: net: marvell-armada-370-neta: convert to json-schema
Date:   Sat, 16 Sep 2023 14:09:02 +0300
Message-Id: <20230916110902.234273-11-arinc.unal@arinc9.com>
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

Convert the document for Marvell Armada 370 / Armada XP / Armada 3700
Ethernet Controller (NETA) to json-schema.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../bindings/net/marvell-armada-370-neta.txt  |  50 ---------
 .../bindings/net/marvell-armada-370-neta.yaml | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
deleted file mode 100644
index 2bf31572b08d..000000000000
--- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Marvell Armada 370 / Armada XP / Armada 3700 Ethernet Controller (NETA)
-
-Required properties:
-- compatible: could be one of the following:
-	"marvell,armada-370-neta"
-	"marvell,armada-xp-neta"
-	"marvell,armada-3700-neta"
-	"marvell,armada-ac5-neta"
-- reg: address and length of the register set for the device.
-- interrupts: interrupt for the device
-- phy: See ethernet.txt file in the same directory.
-- phy-mode: See ethernet.txt file in the same directory
-- clocks: List of clocks for this device. At least one clock is
-  mandatory for the core clock. If several clocks are given, then the
-  clock-names property must be used to identify them.
-
-Optional properties:
-- tx-csum-limit: maximum mtu supported by port that allow TX checksum.
-  Value is presented in bytes. If not used, by default 1600B is set for
-  "marvell,armada-370-neta" and 9800B for others.
-- clock-names: List of names corresponding to clocks property; shall be
-  "core" for core clock and "bus" for the optional bus clock.
-- phys: comphy for the ethernet port, see ../phy/phy-bindings.txt
-
-Optional properties (valid only for Armada XP/38x):
-
-- buffer-manager: a phandle to a buffer manager node. Please refer to
-  Documentation/devicetree/bindings/net/marvell-neta-bm.txt
-- bm,pool-long: ID of a pool, that will accept all packets of a size
-  higher than 'short' pool's threshold (if set) and up to MTU value.
-  Obligatory, when the port is supposed to use hardware
-  buffer management.
-- bm,pool-short: ID of a pool, that will be used for accepting
-  packets of a size lower than given threshold. If not set, the port
-  will use a single 'long' pool for all packets, as defined above.
-
-Example:
-
-ethernet@70000 {
-	compatible = "marvell,armada-370-neta";
-	reg = <0x70000 0x2500>;
-	interrupts = <8>;
-	clocks = <&gate_clk 4>;
-	tx-csum-limit = <9800>
-	phy = <&phy0>;
-	phy-mode = "rgmii-id";
-	buffer-manager = <&bm>;
-	bm,pool-long = <0>;
-	bm,pool-short = <1>;
-};
diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml
new file mode 100644
index 000000000000..9283ab74cdb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/marvell-armada-370-neta.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 370 / Armada XP / Armada 3700 Ethernet Controller (NETA)
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-controller.yaml#/$defs/phylink
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-370-neta
+      - marvell,armada-xp-neta
+      - marvell,armada-3700-neta
+      - marvell,armada-ac5-neta
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      List of clocks for this device. At least one clock is mandatory for the
+      core clock. If several clocks are given, then the clock-names property
+      must be used to identify them.
+
+  tx-csum-limit:
+    description:
+      Maximum mtu supported by port that allow TX checksum. Value is presented
+      in bytes. If not used, by default 1600B is set for
+      "marvell,armada-370-neta" and 9800B for others.
+
+  clock-names:
+    description:
+      List of names corresponding to clocks property; shall be "core" for core
+      clock and "bus" for the optional bus clock.
+
+  phys:
+    description:
+      comphy for the ethernet port, see ../phy/phy-bindings.txt.
+
+if:
+  properties:
+    compatible:
+      enum:
+        - marvell,armada-370-neta
+        - marvell,armada-xp-neta
+then:
+  properties:
+    buffer-manager:
+      description:
+        A phandle to a buffer manager node. Please refer to
+        Documentation/devicetree/bindings/net/marvell-neta-bm.txt.
+
+    bm,pool-long:
+      description:
+        ID of a pool, that will accept all packets of a size higher than 'short'
+        pool's threshold (if set) and up to MTU value. Obligatory, when the port
+        is supposed to use hardware buffer management.
+
+    bm,pool-short:
+      description:
+        ID of a pool, that will be used for accepting packets of a size lower
+        than given threshold. If not set, the port will use a single 'long' pool
+        for all packets, as defined above.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - phy-mode
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@70000 {
+        compatible = "marvell,armada-370-neta";
+        reg = <0x70000 0x2500>;
+        interrupts = <8>;
+        clocks = <&gate_clk 4>;
+        tx-csum-limit = <9800>;
+        phy-mode = "rgmii-id";
+        buffer-manager = <&bm>;
+        bm,pool-long = <0>;
+        bm,pool-short = <1>;
+
+        fixed-link {
+            speed = <1000>;
+            full-duplex;
+        };
+    };
-- 
2.39.2

