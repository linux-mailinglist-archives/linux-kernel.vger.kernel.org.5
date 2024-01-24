Return-Path: <linux-kernel+bounces-36765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5B83A63A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794E51F27F13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D418641;
	Wed, 24 Jan 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IOrziM9W"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7C182CA;
	Wed, 24 Jan 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090481; cv=none; b=es+dOEPyLGI+GJsA1tIrq0dkOhchjBxR6jOeL5UqGU6wUdtIWgf1k64I/fvI/ZyoeolWudi6H24IHgAoI7m1CnVkX6ypwDgEWh7RAnqD8eCeIx2t9Hi7IRQl3cEbHkm1RLqIj8fHXGCuP+e/OmAwD754LE6QccKs0M7mw5ExOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090481; c=relaxed/simple;
	bh=dRNkfHsEle0CT+J9KdNwJBKTNJDKyu+uA/lefkgAzek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJm5nNdWe80i4Q/o/1TSC1fEZ15BkRdeWVhu40KqBVUwWzz+pFbIGWQehMVkHAheT6NyOZf2/7JcikP+vs4bvJuAFTztUJ690N10UpYimp/+4Jt1sTQLSL9RA3VcmtdeNMgAWK4wu2DyAOR6MBq6AW+BFHV/dsKsPOnJLEUKuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IOrziM9W; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706090479; x=1737626479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRNkfHsEle0CT+J9KdNwJBKTNJDKyu+uA/lefkgAzek=;
  b=IOrziM9W1nljuU9YNQcVmlMgQ1gbNjCKTVFlrqiNLEZk+3TqUW90UqHm
   UEAZlYxFggd2AFJlpZ2sWqBN/t5zPf6YyHIUgV49ezGE8XTpVDMyhdrK6
   ahMHqHjlWzWMEq+kyjBJNcrnpsZyUZKOu34n6sINPXXN4+gK6RCcEroLo
   rZlCZB4qLFSztYjPUpZl/+zmTgyck8HlpEUA7CvB1qoZz6k0W9RruaKGq
   yxji3OPZ63E3IwWLtt6nugYsRcu9DKZXn9ZXreDB1RwOP1mAkQlKzqYpi
   e9Mbi4+EzI4XX4LuqVKMJ7uTPAc/nXJDSJEJE2zuSBmhuzuPfzt0rkq2D
   w==;
X-CSE-ConnectionGUID: 1QMie5Z5QlKTBJNwgsTZyw==
X-CSE-MsgGUID: R9afv0qbRHiWCKxruYABhQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="15213689"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2024 03:01:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 03:00:47 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 03:00:40 -0700
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
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
Date: Wed, 24 Jan 2024 15:30:18 +0530
Message-ID: <20240124100019.290120-3-dharma.b@microchip.com>
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

Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
format.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
changelog
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


