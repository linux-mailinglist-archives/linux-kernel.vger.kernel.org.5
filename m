Return-Path: <linux-kernel+bounces-2834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C4681629A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC51F21A94
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A64B136;
	Sun, 17 Dec 2023 21:50:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A414B131;
	Sun, 17 Dec 2023 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rEz1K-0001RW-1A;
	Sun, 17 Dec 2023 21:49:59 +0000
Date: Sun, 17 Dec 2023 21:49:55 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	"Garmin.Chang" <Garmin.Chang@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v7 3/5] dt-bindings: clock: mediatek: add clock controllers
 of MT7988
Message-ID: <07e76a544ce4392bcb88e34d5480e99bb7994618.1702849494.git.daniel@makrotopia.org>
References: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org>

Add various clock controllers found in the MT7988 SoC to existing
bindings (if applicable) and add files for the new ethwarp, mcusys
and xfi-pll clock controllers not previously present in any SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v7:
 * fix wrong path in $id of mediatek,mt7988-xfi-pll.yaml and
   mediatek,mt7988-ethwarp.yaml

v6:
 * remove invalid '_' from compatible string
 * drop minItems where uneeded due to listed clock-names
 * fix condition regarding presence of the 'pcs' subnode

v5:
 * drop use of ti,syscon-reset and hence also syscon and simple-mfd
   compatibles from mt7988-ethwarp clock controller which now got the
   clock controller provide the reset(s).

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
 .../clock/mediatek,mt7988-ethwarp.yaml        | 52 +++++++++++++++
 .../clock/mediatek,mt7988-xfi-pll.yaml        | 48 ++++++++++++++
 .../bindings/clock/mediatek,topckgen.yaml     |  2 +
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   | 65 ++++++++++++++++---
 7 files changed, 161 insertions(+), 9 deletions(-)
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
index 0000000000000..e32a0251ff6ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7988-ethwarp.yaml
@@ -0,0 +1,52 @@
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
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
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
+            compatible = "mediatek,mt7988-ethwarp";
+            reg = <0 0x15031000 0 0x1000>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7988-xfi-pll.yaml
new file mode 100644
index 0000000000000..192f1451f0afc
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
index 66a95191bd776..1bacc0eeff757 100644
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
+              - mediatek,mt7988-sgmiisys0
+              - mediatek,mt7988-sgmiisys1
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
@@ -35,11 +42,51 @@ properties:
     description: Invert polarity of the SGMII data lanes
     type: boolean
 
+  pcs:
+    type: object
+    description: MediaTek LynxI HSGMII PCS
+    properties:
+      compatible:
+        const: mediatek,mt7988-sgmii
+
+      clocks:
+        maxItems: 3
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
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7988-sgmiisys0
+              - mediatek,mt7988-sgmiisys1
+
+    then:
+      required:
+        - pcs
+
+    else:
+      properties:
+        pcs: false
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

