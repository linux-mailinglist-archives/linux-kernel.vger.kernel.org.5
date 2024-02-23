Return-Path: <linux-kernel+bounces-77987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60074860DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DC21F2215E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173752F95;
	Fri, 23 Feb 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oZc5npPj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6F1642C;
	Fri, 23 Feb 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679775; cv=none; b=Av7jkpJR2HjOMia3iUFzT8DvI5t2b1uG+g9Gq1jRL6MirfLdOCnDvv+XOMGQyU3znC+MjLl/bE09itqkuSc8ascKU+Wahq2BGHUffkJGqaCLZriJ4RPRMDYDjTEWz+4RT/FcqqEtsYFoTXIbPiMF8P48n5ZIQZSPMX8uTHWVfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679775; c=relaxed/simple;
	bh=9Vu1VRNAWtniGY/jtoOfNnxYyiQmtWAxgcCmBslvTO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=s7U4SpY53zKOvnSN4pUGRCBBI2vosoE9ecy1ED02fMe/12iFjKpBdFRL6MXT7FStzY03FCkOynef7ixToLu5YIkj6LhmoVJyljg8X3nbvmn0eayuRW9oVusPjuBaHEe32/ArhgOG0XePwl6hJSJNhD703mRTRJ+M0j41JPPCEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oZc5npPj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708679773; x=1740215773;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=9Vu1VRNAWtniGY/jtoOfNnxYyiQmtWAxgcCmBslvTO0=;
  b=oZc5npPjDu9L56qk1dnX/kPzmov+9ubLbyZigyqlyBU8c23FTUH/lQXt
   4D6DZtew9cBobqCu28egHTW4kQAQV82ZKXXZkZ8h8Fuq94/dHbalxGHpI
   snSKNWfbRtG83sqyZ/daXGDamuYc0NXoVzQEAs5tTMoiYKRkh4HfgImYc
   6YteLhTLH52+lR0ZhzHLaFRfZjcyTZ5OBJOYWd2TyfXxZ8b3ZzaVlLKNx
   M+WFCsVUElmYAn0JJlI0GDR4x5l3sZKMKjE3zYelcF5z6h3KUIik78N7x
   7sna0bRTCQ7hE7TZz+q1RFBTT//h+0sOQ7coBbmfBFY8HUoFrnBPqReox
   g==;
X-CSE-ConnectionGUID: xzqCRm/2QM6BAc1jATjzJA==
X-CSE-MsgGUID: Zfo9vPMnSfmdi3vZldUFCA==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="17247390"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:16:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:15:09 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 02:15:04 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 23 Feb 2024 14:44:48 +0530
Subject: [PATCH] dt-bindings: display: atmel,lcdc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com>
X-B4-Tracking: v=1; b=H4sIAAdi2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNj3ZzklGTdtCTdJIsUo1SjNONkS0MTJaDqgqLUtMwKsEnRsbW1AF8
 WmF1ZAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708679703; l=7368;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=9Vu1VRNAWtniGY/jtoOfNnxYyiQmtWAxgcCmBslvTO0=;
 b=WtHfIsVvFXuF0Iwjp/BdSegvujxE26RubKhGI3LA7nPOdb2Pl02iAfiQEkXCy/LMwMP+U6Pup
 HUtmfMFt7gsB69GYwXblwVmJtzMI/hOvC2egN9xf9xlrCue/NQWzuuE
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert the atmel,lcdc bindings to DT schema.
Changes during conversion: add missing clocks and clock-names properties.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../devicetree/bindings/display/atmel,lcdc.txt     |  87 --------------
 .../devicetree/bindings/display/atmel,lcdc.yaml    | 133 +++++++++++++++++++++
 2 files changed, 133 insertions(+), 87 deletions(-)

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
index 000000000000..4a1de5a8d64b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel,lcdc.yaml
@@ -0,0 +1,133 @@
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
+    properties:
+      atmel,dmacon:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: dma controller configuration
+
+      atmel,lcdcon2:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: lcd controller configuration
+
+      atmel,guard-time:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: lcd guard time (Delay in frame periods)
+
+      bits-per-pixel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: lcd panel bit-depth.
+
+      atmel,lcdcon-backlight: 
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: enable backlight
+
+      atmel,lcdcon-backlight-inverted:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: invert backlight PWM polarity
+
+      atmel,lcd-wiring-mode:
+        $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+        description: lcd wiring mode "RGB" or "BRG"
+
+      atmel,power-control-gpio:
+        description: gpio to power on or off the LCD (as many as needed)
+
+    required:
+      - atmel,dmacon
+      - atmel,lcdcon2
+      - atmel,guard-time
+      - bits-per-pixel 
+
+    additionalProperties: false
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
+    fb@500000 {
+      compatible = "atmel,at91sam9g45-lcdc";
+      reg = <0x00500000 0x1000>;
+      interrupts = <23 3 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_fb>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_PERIPHERAL 23>;
+      clock-names = "hclk", "lcdc_clk";
+      display = <&display0>;
+    };
+
+    display {
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

---
base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
change-id: 20240223-lcdc-fb-b8d2e2f3c914

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


