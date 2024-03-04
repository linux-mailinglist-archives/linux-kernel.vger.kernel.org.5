Return-Path: <linux-kernel+bounces-90059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B086F9A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C4D1F210E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B59BA31;
	Mon,  4 Mar 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GxdzCPv0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059933CF;
	Mon,  4 Mar 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530635; cv=none; b=nhGTXvUzTGnPxkoeSIrrh0mTIIaCBttbNnWBDPqllU7RzE+Nj+dofEUdQAe/z/MwUnofKrhhfJ0YWAL8Aj8kp6UE6Lv71P1EP8V46F8ov3a+gEcJuzeL5Jw0lJqMSasb3XE1b89515Gqq5dhnn3o3S34SZem9i1K2yUT5fbfdRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530635; c=relaxed/simple;
	bh=HjXWF3YIEhulQdNJEtfbqmTCEkvDaFvH0ggPzHbk8Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=K+bQN5/LWlxr1Y/tSuJbg42blmgQDi0BJrIQCU7oXIyHsBUM1v3vLvWLA5R0x+8bHZZOJ3s8B2p2k3haJQa7L9x6n/RCP6j7LcKe3NqZuJUWzEg+vhde8gsyaJfoB8yGhhernauz5XVbiAxBUsDMA5RSDKaU7FmHSwMAM1aDi44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GxdzCPv0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709530633; x=1741066633;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=HjXWF3YIEhulQdNJEtfbqmTCEkvDaFvH0ggPzHbk8Cc=;
  b=GxdzCPv0kdlDxubyZnN40Ef0ci5M0rolaxgGJA7+OR60xl1uQeFgNR1r
   w8cXfl6uGsAbgHVq01SznhhkfM0QsdbgxMypWMbp13joklE0AomIx9j/x
   zl2tAOKn0qMSvoGguI/kv37kDGDlDnroOs8UE7ZWeYr85fEpJf9+yeO0D
   IDGgyeNMwV/7cOHbVGW6QbWoIoC7KXFCx9gXDHLbA7tnRqtUBbxZffyId
   stk7W+NmavcpyKGnObuG3SJK/DroBtm8ELCc/PSYLEvAtOyAMpe5Lrpji
   EozItrEL0Xjg3/Nbe+zBzWKmPXZ73Sjgq6LDYSbdJIcWIv/aqJmjR+u8+
   Q==;
X-CSE-ConnectionGUID: BFFWnpeARXSwNbz8PKIqCA==
X-CSE-MsgGUID: TFY0ZBszR/y5IYBHvTBWdQ==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="18764271"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2024 22:37:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 22:37:00 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 22:36:54 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 4 Mar 2024 11:06:39 +0530
Subject: [PATCH v2] dt-bindings: display: atmel,lcdc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-lcdc-fb-v2-1-a14b463c157a@microchip.com>
X-B4-Tracking: v=1; b=H4sIAOZd5WUC/2XMQQrCMBCF4auUWRtppqFVV95DujCTiRmwTUmkK
 CV3N3br8n88vg0yJ+EMl2aDxKtkiXMNPDRA4T4/WImrDdiiaRE79SRHyltlTw4ZfUdnbaC+l8R
 e3rt0G2sHya+YPju86t/6b6xaaWWoN2R7HAbnr5NQihRkOVKcYCylfAHkeWP8ogAAAA==
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709530605; l=9543;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=HjXWF3YIEhulQdNJEtfbqmTCEkvDaFvH0ggPzHbk8Cc=;
 b=94IRQwX7s9gnTfvI89sYFyGFfb2/zTDBlP2tesca5BXKYhwTOxOR2fmhzfCVTizuThfraY/xL
 vlXlKQ8yR2iDuJ0PGZEAl+ibN2vL9V6ZHreClongs0/iqur3eXTsAtq
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

These bindings are tested against the existing at91 dts files using
dtbs_check.
---
Changes in v2:
- Run checkpatch and remove whitespace errors.
- Add the standard interrupt flags.
- Split the binding into two, namely lcdc.yaml and lcdc-display.yaml.
- Link to v1: https://lore.kernel.org/r/20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com
---
 .../bindings/display/atmel,lcdc-display.yaml       | 98 ++++++++++++++++++++++
 .../devicetree/bindings/display/atmel,lcdc.txt     | 87 -------------------
 .../devicetree/bindings/display/atmel,lcdc.yaml    | 70 ++++++++++++++++
 3 files changed, 168 insertions(+), 87 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
new file mode 100644
index 000000000000..ea4fd34b9e2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
@@ -0,0 +1,98 @@
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
+    - required: [ bits-per-pixel ]
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
+
+  bits-per-pixel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: lcd panel bit-depth.
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
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: lcd wiring mode "RGB" or "BRG"
+
+  atmel,power-control-gpio:
+    description: gpio to power on or off the LCD (as many as needed)
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
+      atmel,lcd-wiring-mode = <1>;
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
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240223-lcdc-fb-b8d2e2f3c914

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


