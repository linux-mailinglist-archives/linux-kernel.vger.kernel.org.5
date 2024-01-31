Return-Path: <linux-kernel+bounces-45713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3F84348D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933031C24D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D042D17BC8;
	Wed, 31 Jan 2024 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vNknWUux"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE6107B2;
	Wed, 31 Jan 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672182; cv=none; b=CSmnnytg5QIQIZqpldjwUoKOdGqU7oPyVoWn6HM34/DtffmYoaNX1Ji6Ez/Of2oXO5yB1mQWTjsFXp9m57Zr/04oS5G748YbNOfW1SumfLEZOEfg9WUkswVyYdZbiypSXGX+g8DE7iQlkKrj048Mysadrf6UalKqj9SaS2vgd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672182; c=relaxed/simple;
	bh=U4nu0SSRIOV/I1x868UpWnGqhiUCxDm728KMZE9eQFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0SUq6b3oCLBMVwtW4+IL1NzrgsyzrrYS+2lKyTECx176LAHXt4Q5EWUT8LJUt2SlN8TmZkBikTLBAi7Jh2C4sxe+TgiJVR8hjwy3xKHDsIjL+k+AQ5dUuPlPdA8k7DG/pSWorlo69CCfoDtjllgnJpA56K/H/e3ldNgzN8gPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vNknWUux; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706672180; x=1738208180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4nu0SSRIOV/I1x868UpWnGqhiUCxDm728KMZE9eQFU=;
  b=vNknWUuxiTrNOjv9b79Idtt1LpWm8+R36LqAgNVRmugrkXFio5anVAw5
   Fw2Z2IP137AXH8LuQ9W1j7FIr77T9P1l+pUpOpC3VUVBgnKvt6xq836IL
   xww6S/rg7k3wEaFqKxPf7h7MBRAUeW6MBaYg2fcWaCJXIO5GulHZQWdRX
   iqqjnnWqno3BxMXo8UEzrKJHWJkntDf9ggd81L9xWlVvCz8UXdh4cqnmC
   5GaoPKEl4VXQGD6a7q2GRHdHvO030J2Txi4tFrwDDZgskLIn+/ZrxDiw2
   j+9u676rR6p+ELfcYGjIOuD96fI85/VGOlQ7GVCN1gDA0KtwTSJ1c0fRC
   w==;
X-CSE-ConnectionGUID: +XEgZ6ByRE2uf35ecqUrlw==
X-CSE-MsgGUID: xcLhiBGESrOTTZy8fyAz1A==
X-IronPort-AV: E=Sophos;i="6.05,231,1701154800"; 
   d="scan'208";a="15536688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 20:36:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 20:35:50 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 20:35:42 -0700
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
 Balasubiramani" <dharma.b@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [linux][PATCH v5 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
Date: Wed, 31 Jan 2024 09:05:22 +0530
Message-ID: <20240131033523.577450-3-dharma.b@microchip.com>
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

Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
format.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changelog
v4 -> v5
v3 -> v4
- No changes
Note: The clean up patch will be sent later as Sam suggested.
v2 -> v3
- Remove '|' in description, as there is no formatting to preserve.
- Delete the description for pwm-cells.
- Drop the label for pwm node as it not used.
v1 -> v2
- Remove the explicit copyrights.
- Modify title (not include words like binding/driver).
- Modify description actually describing the hardware and not the driver.
- Remove pinctrl properties which aren't required.
- Drop parent node and it's other sub-device node which are not related here.
---
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 44 +++++++++++++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------------
 2 files changed, 44 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
new file mode 100644
index 000000000000..4f4cc21fe4f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel's HLCDC's PWM controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
+
+description:
+  The LCDC integrates a Pulse Width Modulation (PWM) Controller. This block
+  generates the LCD contrast control signal (LCD_PWM) that controls the
+  display's contrast by software. LCDC_PWM is an 8-bit PWM signal that can be
+  converted to an analog voltage with a simple passive filter. LCD display
+  panels have different backlight specifications in terms of minimum/maximum
+  values for PWM frequency. If the LCDC PWM frequency range does not match the
+  LCD display panel, it is possible to use the standalone PWM Controller to
+  drive the backlight.
+
+properties:
+  compatible:
+    const: atmel,hlcdc-pwm
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm {
+      compatible = "atmel,hlcdc-pwm";
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_lcd_pwm>;
+      #pwm-cells = <3>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
deleted file mode 100644
index afa501bf7f94..000000000000
--- a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Device-Tree bindings for Atmel's HLCDC (High-end LCD Controller) PWM driver
-
-The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
-See ../mfd/atmel-hlcdc.txt for more details.
-
-Required properties:
- - compatible: value should be one of the following:
-   "atmel,hlcdc-pwm"
- - pinctr-names: the pin control state names. Should contain "default".
- - pinctrl-0: should contain the pinctrl states described by pinctrl
-   default.
- - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
-   bindings defined in pwm.yaml in this directory.
-
-Example:
-
-	hlcdc: hlcdc@f0030000 {
-		compatible = "atmel,sama5d3-hlcdc";
-		reg = <0xf0030000 0x2000>;
-		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
-		clock-names = "periph_clk","sys_clk", "slow_clk";
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


