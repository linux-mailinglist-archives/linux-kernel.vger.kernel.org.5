Return-Path: <linux-kernel+bounces-69425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CA8588E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9685282575
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2114A0B4;
	Fri, 16 Feb 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRCAqNuA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19C146904;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123020; cv=none; b=MlRurYWvOPxIUYJoXyDujDud8ssNS/ogI3aXK0brHgnGUVdoNSQstlngPBOLPk652h/caGuyv1aX/Txzb7q0Trfg+yPhZeXxJgxBRBv2rv6W/qWlM+veuLuNSr98YvAY+bjFXUw4LVmkSzZr20NO8grQEnX/0Nxvk2/4stjABYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123020; c=relaxed/simple;
	bh=wsCtGpiDTocW4vbleg11KHxRFROoKpRqbaZuvc+TfiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my7dgVS8gPfsMZGTwPywS7u18XM5zTHYmG8YnlhAoA5Ok1IPCs4+BQ9zAndKejVP2+wGlfTCWgr21JR3VR1HQUg/+VrlYs+8R7vL3jB5R5hknhDLUtlh81YJ88sEUnkSEJwR1dC8JWBh09MLml8eiEuMB67X1VMxEgzsY9PbGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRCAqNuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41180C43394;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123019;
	bh=wsCtGpiDTocW4vbleg11KHxRFROoKpRqbaZuvc+TfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRCAqNuAArlY3+RvUluSrU9yTzLvvQtzIb8zhYaZHIKoY9zgvxp6JZ2FUuAfOUMBr
	 MLsNtfonCOiLJJ+r+zPmPnC89pXRdz7hCs6xik/UmVlKVjSK4P3ov4zpwAsCO4eVFK
	 2hGaaA6f8Uca/Bxk0LPrvUxmF0oHJHPP1qqzzwRMY4U84cBBe9hPn3qqsqSCQHShZT
	 yWGk/YnjH/3Vt+kIPOdAhvGO1NZjhqgZgAaNh1g8hcN6HiowJZOvIyqLk9jJr7vIBC
	 6lnac7pQefJoytPJLd+DhenjkzaJXtOpArVbBNE9xdbRkJeLO2YeICkBWRKzsHatCv
	 Ogpw42tOzpUpw==
Received: by mercury (Postfix, from userid 1000)
	id 9941A1063397; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/16] dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
Date: Fri, 16 Feb 2024 23:34:22 +0100
Message-ID: <20240216223654.1312880-4-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the i.MX6UL touchscreen DT binding to YAML.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     | 97 +++++++++++++++++++
 .../bindings/input/touchscreen/imx6ul_tsc.txt | 38 --------
 2 files changed, 97 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
new file mode 100644
index 000000000000..678756ad0f92
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/fsl,imx6ul-tsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX6UL Touch Controller
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+  - Shawn Guo <shawnguo@kernel.org>
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    const: fsl,imx6ul-tsc
+
+  reg:
+    items:
+      - description: touch controller address
+      - description: ADC2 address
+
+  interrupts:
+    items:
+      - description: touch controller address
+      - description: ADC2 address
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: tsc
+      - const: adc
+
+  xnur-gpios:
+    maxItems: 1
+    description:
+      The X- gpio this controller connect to. This xnur-gpio returns to
+      low once the finger leave the touch screen (The last touch event
+      the touch controller capture).
+
+  measure-delay-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The value of measure delay time. Before X-axis or Y-axis measurement,
+      the screen need some time before even potential distribution ready.
+    default: 0xffff
+    minimum: 0
+    maximum: 0xffffff
+
+  pre-charge-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The touch screen need some time to precharge.
+    default: 0xfff
+    minimum: 0
+    maximum: 0xffffffff
+
+  touchscreen-average-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of data samples which are averaged for each read.
+    enum: [ 1, 4, 8, 16, 32 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - xnur-gpios
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6ul-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
+    touchscreen@2040000 {
+        compatible = "fsl,imx6ul-tsc";
+        reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6UL_CLK_IPG>,
+                 <&clks IMX6UL_CLK_ADC2>;
+        clock-names = "tsc", "adc";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_tsc>;
+        xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+        measure-delay-time = <0xfff>;
+        pre-charge-time = <0xffff>;
+        touchscreen-average-samples = <32>;
+    };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
deleted file mode 100644
index 164915004424..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Freescale i.MX6UL Touch Controller
-
-Required properties:
-- compatible: must be "fsl,imx6ul-tsc".
-- reg: this touch controller address and the ADC2 address.
-- interrupts: the interrupt of this touch controller and ADC2.
-- clocks: the root clock of touch controller and ADC2.
-- clock-names; must be "tsc" and "adc".
-- xnur-gpio: the X- gpio this controller connect to.
-  This xnur-gpio returns to low once the finger leave the touch screen (The
-  last touch event the touch controller capture).
-
-Optional properties:
-- measure-delay-time: the value of measure delay time.
-  Before X-axis or Y-axis measurement, the screen need some time before
-  even potential distribution ready.
-  This value depends on the touch screen.
-- pre-charge-time: the touch screen need some time to precharge.
-  This value depends on the touch screen.
-- touchscreen-average-samples: Number of data samples which are averaged for
-  each read. Valid values are 1, 4, 8, 16 and 32.
-
-Example:
-	tsc: tsc@2040000 {
-		compatible = "fsl,imx6ul-tsc";
-		reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
-		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX6UL_CLK_IPG>,
-			 <&clks IMX6UL_CLK_ADC2>;
-		clock-names = "tsc", "adc";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tsc>;
-		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
-		measure-delay-time = <0xfff>;
-		pre-charge-time = <0xffff>;
-		touchscreen-average-samples = <32>;
-	};
-- 
2.43.0


