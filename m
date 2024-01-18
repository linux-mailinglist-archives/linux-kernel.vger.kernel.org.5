Return-Path: <linux-kernel+bounces-29954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA78315C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5431F27B91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA2208B1;
	Thu, 18 Jan 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JGbNEWuW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5301BC55;
	Thu, 18 Jan 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570025; cv=none; b=GTPwVfI34kKe/UvaxhtoodQgFJ/xAhnk7/0TbXwmM85gqU2OpPsPDZaP2gsXwjhmDcLRqWD+/JViHrvmO5mJgGw+Ej2bk8IWwx2nXSIkosFE7QdAewD7vvEKkpxFPQy8wD4GP5JqLqQEnOWdV4NSWFPGhg9E2bTGS+hOCq2vo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570025; c=relaxed/simple;
	bh=dcKyS7d091j+ugqrLiDIroRDn17ZqkpKb5ELTNcoDf0=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type; b=exbqsVlAPQ13PRvhH7im6d42VpFF7ZaAs1Sk0B9KVU7pQmTyi+W5yUoXEhkdCmOib1BAetcV/9RVVoTM7d4atpay5kYvH8COLpDx3nZKKdUaZOIT/nhDv+rKcvBLByBSuoZEElqJjUGkmC0eNRfEufH+BZ39U97Y+Vi/MdgLKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JGbNEWuW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705570025; x=1737106025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcKyS7d091j+ugqrLiDIroRDn17ZqkpKb5ELTNcoDf0=;
  b=JGbNEWuWVZ+HjFwULlTHnzhfiokW9me8n8QIT/G3IITywGcsIdZnSN2m
   fxnoAe6WsrM3Ej9UDH6/pbcWLNX/xu7MU4i46sKUI/MlLRIcOWkWGP9sH
   1/dJ0Ll/upGBoWKAFg5lp7GCzeYCZqgbSEIrxHGWX+N6BgGJPfKpdfYqg
   BKV7+1zAU+xtgUFf5qQr9ujrnDUxm+KCuMvAw4qzBEBMkgSZb+0oGDgIo
   Q0IDDWEH+CPZux/vtKg1KmbsGGBD/QRY3MQy6VePNuMe/V3yaOhzK5pU5
   oo4SvWwmPguHyxaAd0p6nkhsyXq47veRWp368EwuZ6nLq7iDPxq/TruY6
   Q==;
X-CSE-ConnectionGUID: KNMCAjpUT6KHlCBTUwUTnw==
X-CSE-MsgGUID: LV80OOZJQEuQma1igEV3wQ==
X-IronPort-AV: E=Sophos;i="6.05,201,1701154800"; 
   d="scan'208";a="14940987"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 02:27:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 02:26:42 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 02:26:33 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <conor.dooley@microchip.com>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>
CC: <linux4microchip@microchip.com>, Dharma Balasubiramani
	<dharma.b@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
Date: Thu, 18 Jan 2024 14:56:11 +0530
Message-ID: <20240118092612.117491-3-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118092612.117491-1-dharma.b@microchip.com>
References: <20240118092612.117491-1-dharma.b@microchip.com>
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


