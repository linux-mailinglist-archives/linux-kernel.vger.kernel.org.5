Return-Path: <linux-kernel+bounces-36766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504383A63F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB31C22ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B63182BE;
	Wed, 24 Jan 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BWaI1bIH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C318C05;
	Wed, 24 Jan 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090485; cv=none; b=AKkWim2RZSisJ8UeDT2e9QnzbPx4mha3EH+qNYy5gnwnCz+Shelmd/mBt0/4t/DIGOKHJG9EGGcLnZli6Jo+RBhVDhF7eoCZKQuS8NTxRmI9yqE613GMQlHsAhEBQxNGQtKTM2lvB+ZVDfU6iKrZ8K35cwlBIszqsEx6/x0QRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090485; c=relaxed/simple;
	bh=0PDa4gBIohaxUIBgGmK/dEAi8w116bN/ZSNOiiGYcDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4eiWP+kEc7q0N1m/TxrH8/inDFdRWDEp/gg2h/m5oi6OCLStK0XXCyDHT7/K4wBtj07GRmOwuxA5Z9/gB/eROS7/bh6R78/8uRB+134wrA51VHerDf+jOKrTuaHGYDVrGTd4AUlpYz1wtsQUjag+yXCDoqFkEUMRWQ5slQVfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BWaI1bIH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706090484; x=1737626484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0PDa4gBIohaxUIBgGmK/dEAi8w116bN/ZSNOiiGYcDk=;
  b=BWaI1bIHAAGltIBpnal/DXHbFjCPeefR95ZFoHP2kzNdIELuUV4ve0p6
   vsjxy8OmZxxmzAI/nmTGM4u7HIyZBQOhhqtSppWXKG79DawrCeZ0cH2p7
   MBEGa8D/WpOTAgwG0BELzqHSUBVC/VLxcWxK0N8BSNew2IBk54qkb121I
   fwTzYS+SEKxcx+NDCr3+2IqW4C6+FzFN9L8jt26gkNAPmC2imB/eZV1NW
   JsHRHbZUOAYBNnJmgHCs87TrvTc2+Avq4KsSinB+QvRQiMogcb0QMMKUH
   zyl9xGGacrUVjBomwqjdY/UdWYKrAqJTCXxqgGRIGi54xk4g9Tpi/JAlk
   w==;
X-CSE-ConnectionGUID: FmI4LJdeRpqsQ+/EnHVlYQ==
X-CSE-MsgGUID: 0Tbov+NoTz23oqkwGn6WkA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="15213714"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2024 03:01:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 03:00:55 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 03:00:48 -0700
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
Subject: [PATCH v4 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
Date: Wed, 24 Jan 2024 15:30:19 +0530
Message-ID: <20240124100019.290120-4-dharma.b@microchip.com>
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

Convert the atmel,hlcdc binding to DT schema format.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
changelog
v3 -> v4
- Drop lvds_pll_clk, It can be enabled in lvds driver itself.
- Update commit message.
Note: Since there is no complexities now, I believe that specifying
maxitems in the clocks property should be sufficient.
v2 -> v3
- Rename hlcdc-display-controller and hlcdc-pwm to generic names.
- Modify the description by removing the unwanted comments and '|'.
- Modify clock-names simpler.
v1 -> v2
- Remove the explicit copyrights.
- Modify title (not include words like binding/driver).
- Modify description actually describing the hardware and not the driver.
- Add details of lvds_pll addition in commit message.
- Ref endpoint and not endpoint-base.
- Fix coding style.
..
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 97 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
 2 files changed, 97 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
new file mode 100644
index 000000000000..3062298bd756
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel's HLCD Controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
+
+description:
+  The Atmel HLCDC (HLCD Controller) IP available on Atmel SoCs exposes two
+  subdevices, a PWM chip and a Display Controller.
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91sam9n12-hlcdc
+      - atmel,at91sam9x5-hlcdc
+      - atmel,sama5d2-hlcdc
+      - atmel,sama5d3-hlcdc
+      - atmel,sama5d4-hlcdc
+      - microchip,sam9x60-hlcdc
+      - microchip,sam9x75-xlcdc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: periph_clk
+      - const: sys_clk
+      - const: slow_clk
+
+  display-controller:
+    $ref: /schemas/display/atmel/atmel,hlcdc-display-controller.yaml
+
+  pwm:
+    $ref: /schemas/pwm/atmel,hlcdc-pwm.yaml
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lcd_controller: lcd-controller@f0030000 {
+      compatible = "atmel,sama5d3-hlcdc";
+      reg = <0xf0030000 0x2000>;
+      clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+      clock-names = "periph_clk", "sys_clk", "slow_clk";
+      interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+
+      display-controller {
+        compatible = "atmel,hlcdc-display-controller";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <0>;
+
+          hlcdc_panel_output: endpoint@0 {
+            reg = <0>;
+            remote-endpoint = <&panel_input>;
+          };
+        };
+      };
+
+      pwm {
+        compatible = "atmel,hlcdc-pwm";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_lcd_pwm>;
+        #pwm-cells = <3>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
deleted file mode 100644
index 7de696eefaed..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver
-
-Required properties:
- - compatible: value should be one of the following:
-   "atmel,at91sam9n12-hlcdc"
-   "atmel,at91sam9x5-hlcdc"
-   "atmel,sama5d2-hlcdc"
-   "atmel,sama5d3-hlcdc"
-   "atmel,sama5d4-hlcdc"
-   "microchip,sam9x60-hlcdc"
-   "microchip,sam9x75-xlcdc"
- - reg: base address and size of the HLCDC device registers.
- - clock-names: the name of the 3 clocks requested by the HLCDC device.
-   Should contain "periph_clk", "sys_clk" and "slow_clk".
- - clocks: should contain the 3 clocks requested by the HLCDC device.
- - interrupts: should contain the description of the HLCDC interrupt line
-
-The HLCDC IP exposes two subdevices:
- - a PWM chip: see ../pwm/atmel-hlcdc-pwm.txt
- - a Display Controller: see ../display/atmel/hlcdc-dc.txt
-
-Example:
-
-	hlcdc: hlcdc@f0030000 {
-		compatible = "atmel,sama5d3-hlcdc";
-		reg = <0xf0030000 0x2000>;
-		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
-		clock-names = "periph_clk","sys_clk", "slow_clk";
-		interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
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
-- 
2.25.1


