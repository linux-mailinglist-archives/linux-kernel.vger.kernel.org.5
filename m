Return-Path: <linux-kernel+bounces-49031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88DE846508
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E67628A592
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F8110B;
	Fri,  2 Feb 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vd6W6CUy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D33C15;
	Fri,  2 Feb 2024 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833117; cv=none; b=g59O9hRFFI+7AWAdrOo/lg2GDCJ8xcPe/fiX6Q82qy7S5niGvgAtjrV799TBOm+LqK1XSl9a7IOGnAFmMN9CNB2NC4/8YyOKBRCnPTjvdfaUmW84Vhv2f/yYxCwykcLpCyDSy0F5DdRvZnzGB6VwAYTB0yKMQUt02w3fKML22Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833117; c=relaxed/simple;
	bh=pVc0YyrdgWVHe+p97SOEFi+igo1KERmYptjMM1/rrAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SY8q/pz7wa9fUxTNVi9CRpBNr95G+b7WjlE/s6nPzi5i4vfOBdH6t1fOCH3upWdeR6FyexGhhkj5BRV53PxV2QBB8HoocVy1ypEuEpdHObuJOMuwmh+VPBkGodE+2CafhW/F85SGPA4KrPrz5cHovZwRQVwhLdsLLUoqLBR0wBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vd6W6CUy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706833116; x=1738369116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVc0YyrdgWVHe+p97SOEFi+igo1KERmYptjMM1/rrAk=;
  b=vd6W6CUysKz8WIavmobrjiZKCdJoVjz/+Po6kTN0W4TY+KxF37nSyBXC
   eQzZSCB1yXlEw11ROokT0wBA6APdqFl6O+AR27QUE99gegZhV+ZkRvSnt
   96pXadaeDWjaL/Fu/KVKC8oLtA12SqR4HoBj/7C+QOPPzprdUirmfehMh
   y1LmClyDrkcWXhzRg+ib/HZX9O8faShjnR2t3XSSIv2iYAmn1yldgyM0D
   wg7VNc2lHhQ/clNq9N1EqCL40bP4wo2/b6v/dhKdG/2RT5x4cBlg+D2YY
   yEXNejQLxtPWdfVqEEwU+zK5/dxFMCnyH7/oB2u99I485AQmbZMqGq+61
   A==;
X-CSE-ConnectionGUID: Tlyov34qQnmeSyEAEelR7w==
X-CSE-MsgGUID: 9NZP3zeVR3+AZmQbxzStLg==
X-IronPort-AV: E=Sophos;i="6.05,236,1701154800"; 
   d="scan'208";a="15650219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 17:18:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 17:18:03 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 17:17:55 -0700
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
Subject: [linux][PATCH v6 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
Date: Fri, 2 Feb 2024 05:47:32 +0530
Message-ID: <20240202001733.91455-3-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202001733.91455-1-dharma.b@microchip.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
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
v5 -> v6
- Drop the example as we have one complete example in mfd binding.
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
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 35 +++++++++++++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ---------------
 2 files changed, 35 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
new file mode 100644
index 000000000000..0e92868a2b68
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
@@ -0,0 +1,35 @@
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


