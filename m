Return-Path: <linux-kernel+bounces-45714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FA84348E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6121C24013
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC618634;
	Wed, 31 Jan 2024 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YaS4yvmq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB1125CB;
	Wed, 31 Jan 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672182; cv=none; b=Ds71rTV4rVLU+dflAB5Rk2VTefv+zBZTu9MVu3q/2lkvEREHejhBS7nwOtHxHtqs6UqsVCjOu3yN+qbkTY6JBlYqGfji9tZj08sgpH+83gL/tiRQ0QqhZLXiljpul1fnbVB+g0IhK6k0m9BJ4tY+bQMNugEnQ18AyT4v0OR0hQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672182; c=relaxed/simple;
	bh=XT0bHFobJmRfHg3nHaesYL94nri6XD6wL1E3rwFVUA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYgp/Ymuw7AUkHIUSEjL/gWhfVz9d+CxQSf80u02+L9KaSmF2vMCd5Oy/qWDi2upNpfSZdu+Tzc1UxJubjz0op/fccjD+pahl5sP7IBq5xelXtTrzKZu//Blk9w8C+9Wzmeh5ErCNCuNy2nsKXeV0ahDDKsqPJfgXCkzl+eT6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YaS4yvmq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706672180; x=1738208180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XT0bHFobJmRfHg3nHaesYL94nri6XD6wL1E3rwFVUA4=;
  b=YaS4yvmqpiZwi8eOKHIrjXAFv75uUty7/HEzUK0GrpVLNFFkLlPqDPyy
   Uv8MWhHMGcLtEvPb5pzDALq6FzTh3qXwojQbWEjz2Ict31ioAxTYNqVHF
   2I74wghc2zboHqYhYS8alEJxzVqAm47dDxBXkHU3gobusWB5lbDPIq2Vx
   aFKlVWPZvFN3bljiJ1+Npu6jAOn4utKTQyyM2EnXM1ZT+8iC4q+V4OJuh
   mxQhGUWhuKGfLh/MrorZ/HtrFPsWstNNdjsvsJizS98+6GMrNHcxPJfJ5
   H2SQ/+fhBAFtZHYe7DEXQPPyqH9pouoOxntfzODxI/XrE1XoQyxvizBkw
   Q==;
X-CSE-ConnectionGUID: +XEgZ6ByRE2uf35ecqUrlw==
X-CSE-MsgGUID: U09GgqQxRNWtQAZjBWjkzw==
X-IronPort-AV: E=Sophos;i="6.05,231,1701154800"; 
   d="scan'208";a="15536692"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 20:36:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 20:35:58 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 20:35:51 -0700
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
CC: <hari.prasathge@microchip.com>, <manikandan.m@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>
Subject: [linux][PATCH v5 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
Date: Wed, 31 Jan 2024 09:05:23 +0530
Message-ID: <20240131033523.577450-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131033523.577450-1-dharma.b@microchip.com>
References: <20240131033523.577450-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert the atmel,hlcdc binding to DT schema format.

Align clocks and clock-names properties to clearly indicate that the LCD
controller expects lvds_pll_clk when interfaced with the lvds display. This
alignment with the specific hardware requirements ensures accurate device tree
configuration for systems utilizing the HLCDC IP.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changelog
v4 -> v5
- Revert v3 dropping lvds_pll_clk instead add it as an optional clock.
- Update minItems to 3.
- Update commit message accordingly.
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
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 99 +++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   | 56 -----------
 2 files changed, 99 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
new file mode 100644
index 000000000000..4aa36903e755
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
@@ -0,0 +1,99 @@
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
+    minItems: 3
+
+  clock-names:
+    items:
+      - const: periph_clk
+      - const: sys_clk
+      - const: slow_clk
+      - const: lvds_pll_clk
+    minItems: 3
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


