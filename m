Return-Path: <linux-kernel+bounces-36764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3216283A638
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE94284F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ECF182DF;
	Wed, 24 Jan 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EEJZGKkn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E850182B3;
	Wed, 24 Jan 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090479; cv=none; b=WCkRYnW3mqFqQUXE/PTzFb4bcWrRm8BrdkUm/Zg5roJT5WSF93TAaddP3o9GHLaYhwTbMRpTc0YXKqyRfIrc4oC8mvdxWdeXbDrxS0hfS/G+gnGSB5JYSneMDghdOZhBIvtIG5H/XLLsnLKA0I8t6fBm3CQNIWrajwOAtMZOqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090479; c=relaxed/simple;
	bh=jIDWduTFtYpC86U78bFtNesGnbEIBT3A8nSw6gzET7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd7rtGqup2J/9d5Sb4bGAr8WOt9FaZ9nR5OtpHdELquvUHEwFe1X1tx8eGrkVu1XkMnHZx2YLfK0ibFEfU/nFhC/REbh/AwsG/uoSOgwQxomuszIw96k+aXAnU/ABom1vH8sKzoTCU8fwfRk8Ms1ZGEW0rKz+LlRazPAm47q9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EEJZGKkn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706090477; x=1737626477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jIDWduTFtYpC86U78bFtNesGnbEIBT3A8nSw6gzET7E=;
  b=EEJZGKknA3+zuM7GuLmI3QeYssCcy0OPtKd6t+OTeyUaFXcZ5Hrvfb3z
   tlLsEFtb0v7CfLSkuIDl+mGqyL33yxf2QOf70X/Fjy2rK4WdwWL2aERKY
   dz78mdtcWD4spCAyLADPU7FgLIC9Q6t6ZSlZD+Wpr/Izygd2UIvAyJJxl
   ZjEErkvMNqtYkC60XN0cfvyjHLPv0zx4T8/Turq1PMTSyiS3Bnl8OeDbV
   ebhsAaLRiq2yDZs12Zz2NLf6a1rjGYI8+KKjhX7za267gZhhv8rED824j
   /A2IPqDclqS40CcaJLzUQbDXVP4uGOyNaWZk7iiCbcsN5wfGMuZSB+0Jy
   A==;
X-CSE-ConnectionGUID: 1QMie5Z5QlKTBJNwgsTZyw==
X-CSE-MsgGUID: eAkncTxtS1W+qHNgpZjXtg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="15213686"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2024 03:01:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 03:00:39 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 03:00:31 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: display: convert Atmel's HLCDC to DT schema
Date: Wed, 24 Jan 2024 15:30:17 +0530
Message-ID: <20240124100019.290120-2-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124100019.290120-1-dharma.b@microchip.com>
References: <20240124100019.290120-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert the existing DT binding to DT schema of the Atmel's HLCDC display
controller.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
changelog
v3 -> v4
- Add bus-width property to have one complete example.
v2 -> v3
- Remove '|' in description, as there is no formatting to preserve.
- Ref video-interfaces as endpoint.
- Remove ref and description for bus-width.
- Add new line before the child node in example.
- Remove 'example 2', as it is not required for just one additional property.
v1 -> v2
- Remove the explicit copyrights.
- Modify filename like compatible.
- Modify title (drop words like binding/driver).
- Modify description actually describing the hardware and not the driver.
- Remove pinctrl properties which aren't required.
- Ref endpoint and not endpoint-base.
- Drop redundant info about bus-width description and add ref to video-interfaces.
- Move 'additionalProperties' after 'Required'.
- Drop parent node and it's other sub-device node which are not related here.
- Add compatible to example 2 and add comments that bus-width is the diff between two examples.
---

 .../atmel/atmel,hlcdc-display-controller.yaml | 85 +++++++++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       | 75 ----------------
 2 files changed, 85 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt

diff --git a/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
new file mode 100644
index 000000000000..e59d16dce652
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/atmel/atmel,hlcdc-display-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel's High LCD Controller (HLCDC)
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
+
+description:
+  The LCD Controller (LCDC) consists of logic for transferring LCD image
+  data from an external display buffer to a TFT LCD panel. The LCDC has one
+  display input buffer per layer that fetches pixels through the single bus
+  host interface and a look-up table to allow palletized display
+  configurations.
+
+properties:
+  compatible:
+    const: atmel,hlcdc-display-controller
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  port@0:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description:
+      Output endpoint of the controller, connecting the LCD panel signals.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      reg:
+        maxItems: 1
+
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+        description:
+          Endpoint connecting the LCD panel signals.
+
+        properties:
+          bus-width:
+            enum: [ 12, 16, 18, 24 ]
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+  - compatible
+  - port@0
+
+additionalProperties: false
+
+examples:
+  - |
+    display-controller {
+      compatible = "atmel,hlcdc-display-controller";
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      port@0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0>;
+
+        hlcdc_panel_output: endpoint@0 {
+          reg = <0>;
+          bus-width = <16>;
+          remote-endpoint = <&panel_input>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
deleted file mode 100644
index 923aea25344c..000000000000
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
-
-The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
-See ../../mfd/atmel-hlcdc.txt for more details.
-
-Required properties:
- - compatible: value should be "atmel,hlcdc-display-controller"
- - pinctrl-names: the pin control state names. Should contain "default".
- - pinctrl-0: should contain the default pinctrl states.
- - #address-cells: should be set to 1.
- - #size-cells: should be set to 0.
-
-Required children nodes:
- Children nodes are encoding available output ports and their connections
- to external devices using the OF graph representation (see ../graph.txt).
- At least one port node is required.
-
-Optional properties in grandchild nodes:
- Any endpoint grandchild node may specify a desired video interface
- according to ../../media/video-interfaces.txt, specifically
- - bus-width: recognized values are <12>, <16>, <18> and <24>, and
-   override any output mode selection heuristic, forcing "rgb444",
-   "rgb565", "rgb666" and "rgb888" respectively.
-
-Example:
-
-	hlcdc: hlcdc@f0030000 {
-		compatible = "atmel,sama5d3-hlcdc";
-		reg = <0xf0030000 0x2000>;
-		interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
-		clock-names = "periph_clk","sys_clk", "slow_clk";
-
-		hlcdc-display-controller {
-			compatible = "atmel,hlcdc-display-controller";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0>;
-
-				hlcdc_panel_output: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&panel_input>;
-				};
-			};
-		};
-
-		hlcdc_pwm: hlcdc-pwm {
-			compatible = "atmel,hlcdc-pwm";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd_pwm>;
-			#pwm-cells = <3>;
-		};
-	};
-
-Example 2: With a video interface override to force rgb565; as above
-but with these changes/additions:
-
-	&hlcdc {
-		hlcdc-display-controller {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
-
-			port@0 {
-				hlcdc_panel_output: endpoint@0 {
-					bus-width = <16>;
-				};
-			};
-		};
-	};
-- 
2.25.1


