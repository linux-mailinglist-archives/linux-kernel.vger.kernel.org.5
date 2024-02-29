Return-Path: <linux-kernel+bounces-86642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB986C846
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4BC1C210AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DDB7C6CA;
	Thu, 29 Feb 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nww28hpV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB57C094;
	Thu, 29 Feb 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206939; cv=none; b=JsmCveYi8tIqdZgiPck5Lc3Tf+rgp/JpYkSwQ1ObdaugllLZr5M6SYKnMYb1Qli3PWta0FdvZTM6RXI117tlyM4osyTkxmRywQFvW68CR1r1gmo0loAXcfWnTzsjL+PxR5jAedn+YHLF5YGEEzTpj4qaMkdUBeRECnkCk2yBbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206939; c=relaxed/simple;
	bh=88/nCfzcv/0mBvz7vctQH4WqIZwLFpdPUBRZoFLWORs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ax1M/tVsajddnaNLIz4nCw+vBQc/INVUirXz/o94bHEya10JWfVOE3WEsYXZ5FD3F3neiFVmA2RoTEQY4QbbbJYDxkZCrnjoqzAUgVoiT5wxvzJXPEclGmwCgJ3iQdflbbkIWLsDJ9evkk0YTOkolnxOtKgC1lzsrDc5WthcO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nww28hpV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709206937; x=1740742937;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=88/nCfzcv/0mBvz7vctQH4WqIZwLFpdPUBRZoFLWORs=;
  b=nww28hpVyvOqhGMkGarA4erIy5O4P2IWJy/mqZ76VUcpcl/Of81JfMPY
   rQhhSwuYqUD6PZbCXYWgYG9ej43yLBgc71ljUzYPe7l7GmAB19HUyMi/l
   EAMsCtN3niEbo6zqzTQeYoY+7Npa6ln1OJfUIiU9H9rM4dGVSAbuksLhv
   iM0MmWHPTHsnaBWmKIybXmfVf6ysCcsUtvZrkTgJ6xOTQvxv6Fh8L0ZIg
   tDLQFlFS6fwAYq/sLzAARf7n26JzntHe3IYXTIEnyVA+V45VBdlmz0WaG
   ncI6Ju+ebE6WOCBLtXJrtx2E1kNQ/RVqdrNIMVUv84Jb3H28Cmt00U5fv
   Q==;
X-CSE-ConnectionGUID: d8+oGP1LQdGqNaTtcEJPXQ==
X-CSE-MsgGUID: q8U8MYpsRv2FsgSctH5nmA==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="247759793"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 04:42:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 04:41:45 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Feb 2024 04:41:42 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Thu, 29 Feb 2024 17:09:32 +0530
Subject: [PATCH 3/3] dt-bindings: pinctrl: at91-pio4: convert Atmel's PIO4
 bindings to json-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-pio4-pinctrl-yaml-v1-3-c4d8279c083f@microchip.com>
References: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
In-Reply-To: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Linus Walleij <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Balakrishnan
 Sambath" <balakrishnan.s@microchip.com>
X-Mailer: b4 0.13.0

Convert the existing text DT bindings of Atmel's PIO4 pincontroller to
yaml based DT schema.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  98 ---------------
 .../bindings/pinctrl/atmel,sama5d2-pinctrl.yaml    | 140 +++++++++++++++++++++
 2 files changed, 140 insertions(+), 98 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
deleted file mode 100644
index 774c3c269c40..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-* Atmel PIO4 Controller
-
-The Atmel PIO4 controller is used to select the function of a pin and to
-configure it.
-
-Required properties:
-- compatible:
-	"atmel,sama5d2-pinctrl"
-	"microchip,sama7g5-pinctrl"
-- reg: base address and length of the PIO controller.
-- interrupts: interrupt outputs from the controller, one for each bank.
-- interrupt-controller: mark the device node as an interrupt controller.
-- #interrupt-cells: should be two.
-- gpio-controller: mark the device node as a gpio controller.
-- #gpio-cells: should be two.
-
-Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
-a general description of GPIO and interrupt bindings.
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices.
-
-Subnode format
-Each node (or subnode) will list the pins it needs and how to configured these
-pins.
-
-	node {
-		pinmux = <PIN_NUMBER_PINMUX>;
-		GENERIC_PINCONFIG;
-	};
-
-Required properties:
-- pinmux: integer array. Each integer represents a pin number plus mux and
-ioset settings. Use the macros from boot/dts/<soc>-pinfunc.h file to get the
-right representation of the pin.
-
-Optional properties:
-- GENERIC_PINCONFIG: generic pinconfig options to use:
-	- bias-disable, bias-pull-down, bias-pull-up, drive-open-drain,
-	 drive-push-pull input-schmitt-enable, input-debounce, output-low,
-	 output-high.
-	- for microchip,sama7g5-pinctrl only:
-		- slew-rate: 0 - disabled, 1 - enabled (default)
-- atmel,drive-strength: 0 or 1 for low drive, 2 for medium drive and 3 for
-high drive. The default value is low drive.
-
-Example:
-
-#include <sama5d2-pinfunc.h>
-
-...
-{
-	pioA: pinctrl@fc038000 {
-		compatible = "atmel,sama5d2-pinctrl";
-		reg = <0xfc038000 0x600>;
-		interrupts = <18 IRQ_TYPE_LEVEL_HIGH 7>,
-			     <68 IRQ_TYPE_LEVEL_HIGH 7>,
-			     <69 IRQ_TYPE_LEVEL_HIGH 7>,
-			     <70 IRQ_TYPE_LEVEL_HIGH 7>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		clocks = <&pioA_clk>;
-
-		pinctrl_i2c0_default: i2c0_default {
-			pinmux = <PIN_PD21__TWD0>,
-				 <PIN_PD22__TWCK0>;
-			bias-disable;
-		};
-
-		pinctrl_led_gpio_default: led_gpio_default {
-			pinmux = <PIN_PB0>,
-				 <PIN_PB5>;
-			bias-pull-up;
-			atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
-		};
-
-		pinctrl_sdmmc1_default: sdmmc1_default {
-			cmd_data {
-				pinmux = <PIN_PA28__SDMMC1_CMD>,
-					 <PIN_PA18__SDMMC1_DAT0>,
-					 <PIN_PA19__SDMMC1_DAT1>,
-					 <PIN_PA20__SDMMC1_DAT2>,
-					 <PIN_PA21__SDMMC1_DAT3>;
-				bias-pull-up;
-			};
-
-			ck_cd {
-				pinmux = <PIN_PA22__SDMMC1_CK>,
-					 <PIN_PA30__SDMMC1_CD>;
-				bias-disable;
-			};
-		};
-		...
-	};
-};
-...
diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.yaml
new file mode 100644
index 000000000000..8a2dee1d6dd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,sama5d2-pinctrl.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/atmel,sama5d2-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIO4 Controller
+
+maintainers:
+  - Balakrishnan Sambath <balakrishnan.s@microchip.com>
+
+description:
+  The Microchip PIO4 controller is used to select the function of a pin and to
+  configure it.
+
+
+properties:
+  compatible:
+    enum:
+      - microchip,sama7g5-pinctrl
+      - atmel,sama5d2-pinctrl
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    description:
+      Interrupt outputs from the controller, one for each bank.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  clocks:
+    maxItems: 1
+if:
+  properties:
+    compatible:
+      contains:
+        const: microchip,sama7g5-pinctrl
+then:
+  patternProperties:
+    '^.*([-_]default)?$':
+      anyOf:
+        - $ref: "#/$defs/mchp-pio4-pincfg-node-1"
+        - patternProperties:
+            '^[a-z_-][a-z_-]*$':
+              $ref: "#/$defs/mchp-pio4-pincfg-node-1"
+else:
+  patternProperties:
+    '^.*([-_]default)?$':
+      anyOf:
+        - $ref: "#/$defs/mchp-pio4-pincfg-node-2"
+        - patternProperties:
+            '^[a-z_-][a-z_-]*$':
+              $ref: "#/$defs/mchp-pio4-pincfg-node-2"
+
+$defs:
+  mchp-pio4-pincfg-node-1:
+    $ref: pincfg-node.yaml#properties
+    properties:
+      pinmux:
+        $ref: pinmux-node.yaml#/properties/pinmux
+      atmel,drive-strength:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 0
+    required:
+      - pinmux
+
+  mchp-pio4-pincfg-node-2:
+    $ref: pincfg-node.yaml#properties
+    properties:
+      pinmux:
+        $ref: pinmux-node.yaml#/properties/pinmux
+    required:
+      - pinmux
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/pinctrl/sama5d2-pinfunc.h>
+
+    pinctrl@fc038000 {
+        compatible = "atmel,sama5d2-pinctrl";
+        reg = <0xfc038000 0x600>;
+        interrupts = <18 IRQ_TYPE_LEVEL_HIGH 7>,
+                     <68 IRQ_TYPE_LEVEL_HIGH 7>,
+                     <69 IRQ_TYPE_LEVEL_HIGH 7>,
+                     <70 IRQ_TYPE_LEVEL_HIGH 7>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        clocks = <&pioA_clk>;
+
+        pinctrl_i2c0_default: i2c0_default {
+            pinmux = <PIN_PD21__TWD0>,
+                     <PIN_PD22__TWCK0>;
+            bias-disable;
+        };
+
+        pinctrl_sdmmc1_default: sdmmc1_default {
+            cmd_data {
+                pinmux = <PIN_PA28__SDMMC1_CMD>,
+                         <PIN_PA18__SDMMC1_DAT0>,
+                         <PIN_PA19__SDMMC1_DAT1>,
+                         <PIN_PA20__SDMMC1_DAT2>,
+                         <PIN_PA21__SDMMC1_DAT3>;
+                bias-pull-up;
+            };
+
+            ck_cd {
+                pinmux = <PIN_PA22__SDMMC1_CK>,
+                         <PIN_PA30__SDMMC1_CD>;
+                bias-disable;
+            };
+        };
+    };
+...

-- 
2.25.1


