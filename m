Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3CC80B6B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjLIV4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:56:18 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9F610E;
        Sat,  9 Dec 2023 13:56:23 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rC5In-0000A5-29;
        Sat, 09 Dec 2023 21:56:02 +0000
Date:   Sat, 9 Dec 2023 21:55:58 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Daniel Golle <daniel@makrotopia.org>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: clock: mediatek: add clock controllers
 of MT7988
Message-ID: <93025cdb7c31bf413fb2be5a071340073a0679d1.1702158423.git.daniel@makrotopia.org>
References: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add various clock controllers found in the MT7988 SoC to existing
bindings (if applicable) and add files for the new ethwarp, mcusys
and xfi-pll clock controllers not previously present in any SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 * add subnodes for controllers acting as MFD

v3:
 * move clock bindings to clock folder
 * drop ti,syscon-reset from bindings and example
 * merge mcusys with topckgen bindings

v2:
 * dropped unused labels
 * add 'type: object' declaration for reset-controller found in new
   ethwarp controller and represented as ti,syscon-reset
 * rebase on top of
   "dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema"

 .../arm/mediatek/mediatek,infracfg.yaml       |  1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |  1 +
 .../bindings/clock/mediatek,ethsys.yaml       |  1 +
 .../clock/mediatek,mt7988-ethwarp.yaml        | 66 +++++++++++++++++++
 .../clock/mediatek,mt7988-xfi-pll.yaml        | 48 ++++++++++++++
 .../bindings/clock/mediatek,topckgen.yaml     |  2 +
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   | 61 ++++++++++++++---
 7 files changed, 171 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index ea98043c6ba3d..230b5188a88db 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt7629-infracfg
               - mediatek,mt7981-infracfg
               - mediatek,mt7986-infracfg
+              - mediatek,mt7988-infracfg
               - mediatek,mt8135-infracfg
               - mediatek,mt8167-infracfg
               - mediatek,mt8173-infracfg
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index 372c1d744bc27..685535846cbb7 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt7622-apmixedsys
           - mediatek,mt7981-apmixedsys
           - mediatek,mt7986-apmixedsys
+          - mediatek,mt7988-apmixedsys
           - mediatek,mt8135-apmixedsys
           - mediatek,mt8173-apmixedsys
           - mediatek,mt8516-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
index 94d42c8647777..f9cddacc2eae1 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,ethsys.yaml
@@ -22,6 +22,7 @@ properties:
               - mediatek,mt7629-ethsys
               - mediatek,mt7981-ethsys
               - mediatek,mt7986-ethsys
+              - mediatek,mt7988-ethsys
           - const: syscon
       - items:
           - const: mediatek,mt7623-ethsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
new file mode 100644
index 0000000000000..e126f3fe0856c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt7988-ethwarp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7988 ethwarp Controller
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The Mediatek MT7988 ethwarp controller provides clocks and resets for the
+  Ethernet related subsystems found the MT7988 SoC.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt7988-ethwarp
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  reset-controller:
+    type: object
+    properties:
+      compatible:
+        const: ti,syscon-reset
+
+    # TODO: Convert to DT schema
+    additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/ti-syscon.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@15031000 {
+            compatible = "mediatek,mt7988-ethwarp", "syscon", "simple-mfd";
+            reg = <0 0x15031000 0 0x1000>;
+            #clock-cells = <1>;
+
+            reset-controller {
+                compatible = "ti,syscon-reset";
+                #reset-cells = <1>;
+                ti,reset-bits = <
+                  0x8 9 0x8 9 0 0 (ASSERT_SET | DEASSERT_CLEAR | STATUS_NONE)
+                >;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
new file mode 100644
index 0000000000000..fe5e3a70299fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt7988-xfi-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7988 XFI PLL Clock Controller
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The MediaTek XFI PLL controller provides the 156.25MHz clock for the
+  Ethernet SerDes PHY from the 40MHz top_xtal clock.
+
+properties:
+  compatible:
+    const: mediatek,mt7988-xfi-pll
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        clock-controller@11f40000 {
+            compatible = "mediatek,mt7988-xfi-pll";
+            reg = <0 0x11f40000 0 0x1000>;
+            resets = <&watchdog 16>;
+            #clock-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 6d087ded7437a..bdf3b55bd56fd 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -37,6 +37,8 @@ properties:
               - mediatek,mt7629-topckgen
               - mediatek,mt7981-topckgen
               - mediatek,mt7986-topckgen
+              - mediatek,mt7988-mcusys
+              - mediatek,mt7988-topckgen
               - mediatek,mt8167-topckgen
               - mediatek,mt8183-topckgen
           - const: syscon
diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
index 66a95191bd776..f5f1fd97c50eb 100644
--- a/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
@@ -15,15 +15,22 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - mediatek,mt7622-sgmiisys
-          - mediatek,mt7629-sgmiisys
-          - mediatek,mt7981-sgmiisys_0
-          - mediatek,mt7981-sgmiisys_1
-          - mediatek,mt7986-sgmiisys_0
-          - mediatek,mt7986-sgmiisys_1
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7622-sgmiisys
+              - mediatek,mt7629-sgmiisys
+              - mediatek,mt7981-sgmiisys_0
+              - mediatek,mt7981-sgmiisys_1
+              - mediatek,mt7986-sgmiisys_0
+              - mediatek,mt7986-sgmiisys_1
+          - const: syscon
+      - items:
+          - enum:
+              - mediatek,mt7988-sgmiisys_0
+              - mediatek,mt7988-sgmiisys_1
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -35,11 +42,47 @@ properties:
     description: Invert polarity of the SGMII data lanes
     type: boolean
 
+  pcs:
+    type: object
+    description: HSGMII PCS logic
+    properties:
+      compatible:
+        const: mediatek,mt7988-sgmii
+
+      clocks:
+        maxItems: 3
+        minItems: 3
+
+      clock-names:
+        items:
+          - const: sgmii_sel
+          - const: sgmii_tx
+          - const: sgmii_rx
+
+    required:
+      - compatible
+      - clocks
+      - clock-names
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
   - '#clock-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mt7988-sgmiisys_0
+          - mediatek,mt7988-sgmiisys_1
+
+then:
+  required:
+    - pcs
+
 additionalProperties: false
 
 examples:
-- 
2.43.0
