Return-Path: <linux-kernel+bounces-105712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8287E34E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5188B2142B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7FD21A1C;
	Mon, 18 Mar 2024 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ifLYgCN2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828E1E864;
	Mon, 18 Mar 2024 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740528; cv=none; b=bbxF5wh08DKVaaWVQ6qox6j58w9IfdXiMBzJ6yYNMpP11iWdMiKiSyJAy06pMu8QDRi8zRaXyx76Y4nISN6t+9sSliaZ/AHiG05oP9VmGVOX6f6g6Uu36ixG1WmGx90pFoRKORaR6kUN3RxtpL2vrwHGZ4lnv3yjsXGVKDmJGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740528; c=relaxed/simple;
	bh=7KtphudW08v3j8hsGj4FHCEmq2vBqBU1nXvXdEn8XrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cZHbY0SA1ueg9j7WK0fCSoK1m5aF5i1LJJeniDh4bKxoUYAqTSK6Uv0iJjZFr9Tmply/V90oCAExqBOtbIGG+HESqdKtDgXErGsVqoESI84uxZG/iAYRkqcb4dAMY3Q0+TS1dvu4z101M9R3qtpPYd5aeckzOyuGMgGFkiAzfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ifLYgCN2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710740525; x=1742276525;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=7KtphudW08v3j8hsGj4FHCEmq2vBqBU1nXvXdEn8XrE=;
  b=ifLYgCN2eD5ldh3LEBeraGiNHleVAEPWJ5CTqQAqo0Z7mox8reKCh3Y/
   77O6g+Yl/lquQOGmhZo80d+hwTQEr85Sh4ev7TvdrbjsBnyRtfa5KoNCl
   tjG2rdMvqNuQBt3E4Oap2+3l54lA7wZRCFhUNCoNNRlsQeTtahbLmmWlz
   KZf7SMwatAQPaC57hBTnLk+z4bWGcyzvHOIIAz2MRgTlkUTQ1vndIIMCM
   otaIAejOYmNrduywwbaGGbk+ysJKNTRdy0oUkzeUZCIGhVtVro2PTC46+
   gAJ02tT83OGdjU2cEV9Wr6vTfQ4XYMIVJ/IF1ToQID6WB4z/GXw+YRhJp
   w==;
X-CSE-ConnectionGUID: oBxbmAQ8RyGXMoL9fzPpkg==
X-CSE-MsgGUID: xj2kPIJxTw6jJI8aiJ1/Kw==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; 
   d="scan'208";a="17742587"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2024 22:40:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 22:40:29 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 22:40:23 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 18 Mar 2024 11:10:13 +0530
Subject: [PATCH v4] dt-bindings: display: atmel,lcdc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240318-lcdc-fb-v4-1-c533c7c2c706@microchip.com>
X-B4-Tracking: v=1; b=H4sIALzT92UC/3XMTQ7CIBCG4asY1mJgQNq68h7GRRnAktjSgCGap
 neXdtPEn+U3meedSLLR20ROu4lEm33yYShD7ncEu3a4WepN2QQYSAYg6B0NUqeprg1YcAIbLkn
 5HqN1/rmWLteyO58eIb7WcObL9buROeVUopKoFVSVcefeYwzY+fGAoSdLJ8NmBZObhWJbLrVUA
 vmxan9Z8ceKYmutuHJaM940n3ae5zdi08UQGgEAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710740422; l=10193;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=7KtphudW08v3j8hsGj4FHCEmq2vBqBU1nXvXdEn8XrE=;
 b=Xll0PHbapNWcdl+aNX7Q9XZBrOg6/VSdZRd6BB4a/AwcTQx1u5dDFI/mNlkcBvyN/hmMgSq0V
 MQiLqEWNy4FDwzUGYsX21iDgD0ZhfsMAthF0ReB1sJeJuJXWExbhFJz
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert the atmel,lcdc bindings to DT schema.
Changes during conversion: add missing clocks and clock-names properties.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
This patch converts the existing lcdc display text binding to JSON schema.
The binding is split into two namely
lcdc.yaml
- Holds the frame buffer properties
lcdc-display.yaml
- Holds the display panel properties which is a phandle to the display
property in lcdc fb node.

These bindings are tested using the following command.
'make DT_CHECKER_FLAGS=-m dt_binding_check'
---
Changes in v4:
- Add maximum for atmel,guard-time property.
- Add constraints for bits-per-pixel property.
- Update the atmel,lcd-wiring-mode property's ref to point single string
  rather than an array.
- Add constraints for atmel,lcd-wiring-mode property.
- Add maxItems to the atmel,power-control-gpio property.
- Link to v3: https://lore.kernel.org/r/20240304-lcdc-fb-v3-1-8b616fbb0199@microchip.com

Changes in v3:
- Remove the generic property "bits-per-pixel"
- Link to v2: https://lore.kernel.org/r/20240304-lcdc-fb-v2-1-a14b463c157a@microchip.com

Changes in v2:
- Run checkpatch and remove whitespace errors.
- Add the standard interrupt flags.
- Split the binding into two, namely lcdc.yaml and lcdc-display.yaml.
- Link to v1: https://lore.kernel.org/r/20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com
---
 .../bindings/display/atmel,lcdc-display.yaml       | 103 +++++++++++++++++++++
 .../devicetree/bindings/display/atmel,lcdc.txt     |  87 -----------------
 .../devicetree/bindings/display/atmel,lcdc.yaml    |  70 ++++++++++++++
 3 files changed, 173 insertions(+), 87 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
new file mode 100644
index 000000000000..a5cf040ab4ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/atmel,lcdc-display.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip's LCDC Display
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Dharma Balasubiramani <dharma.b@microchip.com>
+
+description:
+  The LCD Controller (LCDC) consists of logic for transferring LCD image data
+  from an external display buffer to a TFT LCD panel. The LCDC has one display
+  input buffer per layer that fetches pixels through the single bus host
+  interface and a look-up table to allow palletized display configurations. The
+  LCDC is programmable on a per layer basis, and supports different LCD
+  resolutions, window sizes, image formats and pixel depths.
+
+# We need a select here since this schema is applicable only for nodes with the
+# following properties
+
+select:
+  anyOf:
+    - required: [ 'atmel,dmacon' ]
+    - required: [ 'atmel,lcdcon2' ]
+    - required: [ 'atmel,guard-time' ]
+
+properties:
+  atmel,dmacon:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: dma controller configuration
+
+  atmel,lcdcon2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: lcd controller configuration
+
+  atmel,guard-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: lcd guard time (Delay in frame periods)
+    maximum: 127
+
+  bits-per-pixel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: lcd panel bit-depth.
+    enum: [1, 2, 4, 8, 16, 24, 32]
+
+  atmel,lcdcon-backlight:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: enable backlight
+
+  atmel,lcdcon-backlight-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: invert backlight PWM polarity
+
+  atmel,lcd-wiring-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: lcd wiring mode "RGB" or "BRG"
+    enum:
+      - RGB
+      - BRG
+
+  atmel,power-control-gpio:
+    description: gpio to power on or off the LCD (as many as needed)
+    maxItems: 1
+
+  display-timings:
+    $ref: panel/display-timings.yaml#
+
+required:
+  - atmel,dmacon
+  - atmel,lcdcon2
+  - atmel,guard-time
+  - bits-per-pixel
+
+additionalProperties: false
+
+examples:
+  - |
+    display: panel {
+      bits-per-pixel = <32>;
+      atmel,lcdcon-backlight;
+      atmel,dmacon = <0x1>;
+      atmel,lcdcon2 = <0x80008002>;
+      atmel,guard-time = <9>;
+      atmel,lcd-wiring-mode = "RGB";
+
+      display-timings {
+        native-mode = <&timing0>;
+        timing0: timing0 {
+          clock-frequency = <9000000>;
+          hactive = <480>;
+          vactive = <272>;
+          hback-porch = <1>;
+          hfront-porch = <1>;
+          vback-porch = <40>;
+          vfront-porch = <1>;
+          hsync-len = <45>;
+          vsync-len = <1>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc.txt b/Documentation/devicetree/bindings/display/atmel,lcdc.txt
deleted file mode 100644
index b5e355ada2fa..000000000000
--- a/Documentation/devicetree/bindings/display/atmel,lcdc.txt
+++ /dev/null
@@ -1,87 +0,0 @@
-Atmel LCDC Framebuffer
------------------------------------------------------
-
-Required properties:
-- compatible :
-	"atmel,at91sam9261-lcdc" , 
-	"atmel,at91sam9263-lcdc" ,
-	"atmel,at91sam9g10-lcdc" ,
-	"atmel,at91sam9g45-lcdc" ,
-	"atmel,at91sam9g45es-lcdc" ,
-	"atmel,at91sam9rl-lcdc" ,
-- reg : Should contain 1 register ranges(address and length).
-	Can contain an additional register range(address and length)
-	for fixed framebuffer memory. Useful for dedicated memories.
-- interrupts : framebuffer controller interrupt
-- display: a phandle pointing to the display node
-
-Required nodes:
-- display: a display node is required to initialize the lcd panel
-	This should be in the board dts.
-- default-mode: a videomode within the display with timing parameters
-	as specified below.
-
-Optional properties:
-- lcd-supply: Regulator for LCD supply voltage.
-
-Example:
-
-	fb0: fb@00500000 {
-		compatible = "atmel,at91sam9g45-lcdc";
-		reg = <0x00500000 0x1000>;
-		interrupts = <23 3 0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_fb>;
-		display = <&display0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-	};
-
-Example for fixed framebuffer memory:
-
-	fb0: fb@00500000 {
-		compatible = "atmel,at91sam9263-lcdc";
-		reg = <0x00700000 0x1000 0x70000000 0x200000>;
-		[...]
-	};
-
-Atmel LCDC Display
------------------------------------------------------
-Required properties (as per of_videomode_helper):
-
- - atmel,dmacon: dma controller configuration
- - atmel,lcdcon2: lcd controller configuration
- - atmel,guard-time: lcd guard time (Delay in frame periods)
- - bits-per-pixel: lcd panel bit-depth.
-
-Optional properties (as per of_videomode_helper):
- - atmel,lcdcon-backlight: enable backlight
- - atmel,lcdcon-backlight-inverted: invert backlight PWM polarity
- - atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
- - atmel,power-control-gpio: gpio to power on or off the LCD (as many as needed)
-
-Example:
-	display0: display {
-		bits-per-pixel = <32>;
-		atmel,lcdcon-backlight;
-		atmel,dmacon = <0x1>;
-		atmel,lcdcon2 = <0x80008002>;
-		atmel,guard-time = <9>;
-		atmel,lcd-wiring-mode = <1>;
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <9000000>;
-				hactive = <480>;
-				vactive = <272>;
-				hback-porch = <1>;
-				hfront-porch = <1>;
-				vback-porch = <40>;
-				vfront-porch = <1>;
-				hsync-len = <45>;
-				vsync-len = <1>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc.yaml
new file mode 100644
index 000000000000..1b6f7e395006
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel,lcdc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/atmel,lcdc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip's LCDC Framebuffer
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Dharma Balasubiramani <dharma.b@microchip.com>
+
+description:
+  The LCDC works with a framebuffer, which is a section of memory that contains
+  a complete frame of data representing pixel values for the display. The LCDC
+  reads the pixel data from the framebuffer and sends it to the LCD panel to
+  render the image.
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91sam9261-lcdc
+      - atmel,at91sam9263-lcdc
+      - atmel,at91sam9g10-lcdc
+      - atmel,at91sam9g45-lcdc
+      - atmel,at91sam9g45es-lcdc
+      - atmel,at91sam9rl-lcdc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: hclk
+      - const: lcdc_clk
+
+  display:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle pointing to the display node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - display
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    fb@500000 {
+      compatible = "atmel,at91sam9g45-lcdc";
+      reg = <0x00500000 0x1000>;
+      interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_fb>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_PERIPHERAL 23>;
+      clock-names = "hclk", "lcdc_clk";
+      display = <&display>;
+    };

---
base-commit: f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
change-id: 20240223-lcdc-fb-b8d2e2f3c914

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


