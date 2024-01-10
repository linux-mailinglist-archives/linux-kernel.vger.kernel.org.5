Return-Path: <linux-kernel+bounces-21994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90F8297A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8562F28F3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC147F4A;
	Wed, 10 Jan 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QMRWzH1e"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C046BA6;
	Wed, 10 Jan 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704882399; x=1736418399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WUd7zZW6vaz2VFpcySRfwde2JHnsfcvgGymaZA0H0s=;
  b=QMRWzH1e9gW+jYSuJIF5GsdSF5RBrlor7KuSCb0kOw6fIqNq8uSVkzSu
   1Y/90fiPzybFg++BmPNYwWkFlmNzmrBIY98uCXc4dFXrPlpGQDyK8ZAqD
   URLReSa7ZeG2AUSbczMvjmsb2PM6Eomr7k4ge3FIYTfGbxvO+GLcYLshb
   pxoHJpZSeuDLdiNUie/M4qswfkkX/b/OjSzfyTlvqII6yytoFXvW6ROPk
   3x6sS8Sql1A5kGo8/g4hNQUYkDAKjNCHqAjZxW7rx2J2LTBrjtjc8TA3P
   yrtMOPgIq5At0KhdnYHa+C6mGI9hOg1FXQTyWk33DV4YHI4LWWEulQuVK
   w==;
X-CSE-ConnectionGUID: 5D2eo3saR72tqfGaKhDyVQ==
X-CSE-MsgGUID: P1+T+hWdTWqrrzrBB18h6g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="14511322"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2024 03:26:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 03:26:25 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 03:26:17 -0700
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
Subject: [PATCH 3/3] dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
Date: Wed, 10 Jan 2024 15:55:35 +0530
Message-ID: <20240110102535.246177-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110102535.246177-1-dharma.b@microchip.com>
References: <20240110102535.246177-1-dharma.b@microchip.com>
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
---
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 62 +++++++++++++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ---------
 2 files changed, 62 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
new file mode 100644
index 000000000000..99eaad55ccb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel's HLCDC (High-end LCD Controller) PWM driver
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
+
+description: |
+  Device-Tree bindings for Atmel's HLCDC PWM driver. The Atmel HLCDC PWM is a
+  subdevice of the HLCDC MFD device.
+  # See ../mfd/atmel,hlcdc.yaml for more details.
+
+properties:
+  compatible:
+    const: atmel,hlcdc-pwm
+
+  pinctrl-names:
+    const: default
+
+  pinctrl-0: true
+
+  "#pwm-cells":
+    const: 3
+    description: |
+      This PWM chip uses the default 3 cells bindings defined in pwm.yaml in
+      this directory.
+
+required:
+  - compatible
+  - pinctrl-names
+  - pinctrl-0
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/pwm/pwm.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    hlcdc: hlcdc@f0030000 {
+      compatible = "atmel,sama5d3-hlcdc";
+      reg = <0xf0030000 0x2000>;
+      clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+      clock-names = "periph_clk","sys_clk", "slow_clk";
+      interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+
+      hlcdc_pwm: hlcdc-pwm {
+        compatible = "atmel,hlcdc-pwm";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_lcd_pwm>;
+        #pwm-cells = <3>;
+      };
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


