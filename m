Return-Path: <linux-kernel+bounces-144089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DE8A41B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD3D1F2148F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8942E851;
	Sun, 14 Apr 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwgCUfW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3A22F11;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089051; cv=none; b=SHxnlskCwTC+/ahA5tRj3tblTdQ2yELZE5GWx50BhkDpAuRKE9dtFtwhwrxaFEWqC+b2hsGsLKBXT0ny9WY8e+ItPI3zX9xy3us99iIJZZGCRLCdDBv03QcQ9CCCI60J3W5mstRmTEZXu7EJejtgpFBOIGaF1M9bSqKjVFQ83dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089051; c=relaxed/simple;
	bh=iwHUZTcFO0Bj+sswdGNfI4SFWlUW0XK/svWbnDHhZPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQusXs2/VKaqiLw2YgZW7Asr8vmL2WdeeQjgQ5GRLu+HkkuRH5JewT2k5UrAQWmqfR9B+DCmOGCAXXe4NJ5/I9r+DNRhBh7isgXeFWlzLiZM6dH1n9aYQX/nkIXQPSTg2WDM+UsTTAHOsKeELi34//LLLqSUks0OerNf4clsui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwgCUfW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B216BC32786;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713089050;
	bh=iwHUZTcFO0Bj+sswdGNfI4SFWlUW0XK/svWbnDHhZPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BwgCUfW4NRQIouf14kSG2RpksuGmL5WlEDIaIEj7tEv9Xrah5SrivqGIWJFBmd3KN
	 4Hxd7hEkH5+AxsGKS4i+kFxEvgMmGPR1HsPxWQs6vy1riEhCM8LZ45SS4xauBeouYL
	 9iW5XlXx9OlTM7puEvNgK0jKWeH18S7vneqOMQET+CCi6il/1ItVKvC5QyKp+UVdUX
	 6h5I0aChOmugE33bx2RKVNQBW15nKhJvFzwQkVb6zvmNDFjxCNesZ46SJH3oc4LM4w
	 MdXceuTZNLcJMosyUh5YeDBgOSXRkWnUP2NKCKEqGWpQHIosmjzVpRLVVkjY8KtrYh
	 /nKx2tQ2kLMwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB56C05023;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Sun, 14 Apr 2024 13:03:50 +0300
Subject: [PATCH v2 3/4] dt-bindings: soc: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-ep93xx-clk-v2-3-9c5629dec2dd@maquefel.me>
References: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
In-Reply-To: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713089049; l=6134;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=rxV5iIpC+Z8YB9Bx/6Nn01nHLk5VTCsvmwXWNV3UZtY=;
 b=AVytOUgb2xVzAZw61c2VwFUm/3Z0ko/kNpmw+E5DPpcTdwLU0uFl3u0H4WdTCAApKKO8nyVu4i7J
 sI3izRR9C8G+kaHWjcU25CS0WL1s9hXnWuqb5lY9SKqGlqL0JFpQ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree bindings for the Cirrus Logic EP93xx SoC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/arm/cirrus/cirrus,ep9301.yaml         | 38 +++++++++
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  | 94 ++++++++++++++++++++++
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   | 46 +++++++++++
 3 files changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
new file mode 100644
index 000000000000..170aad5dd7ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cirrus/cirrus,ep9301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx platforms
+
+description:
+  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: The TS-7250 is a compact, full-featured Single Board
+          Computer (SBC) based upon the Cirrus EP9302 ARM9 CPU
+        items:
+          - const: technologic,ts7250
+          - const: cirrus,ep9301
+
+      - description: The Liebherr BK3 is a derivate from ts7250 board
+        items:
+          - const: liebherr,bk3
+          - const: cirrus,ep9301
+
+      - description: EDB302 is an evaluation board by Cirrus Logic,
+          based on a Cirrus Logic EP9302 CPU
+        items:
+          - const: cirrus,edb9302
+          - const: cirrus,ep9301
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
new file mode 100644
index 000000000000..7cb1b4114985
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/cirrus/cirrus,ep9301-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx Platforms System Controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+description: |
+  Central resources are controlled by a set of software-locked registers,
+  which can be used to prevent accidental accesses. Syscon generates
+  the various bus and peripheral clocks and controls the system startup
+  configuration.
+
+  The System Controller (Syscon) provides:
+  - Clock control
+  - Power management
+  - System configuration management
+
+  Syscon registers are common for all EP93xx SoC's, through some actual peripheral
+  may be missing depending on actual SoC model.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - cirrus,ep9302-syscon
+              - cirrus,ep9307-syscon
+              - cirrus,ep9312-syscon
+              - cirrus,ep9315-syscon
+          - const: cirrus,ep9301-syscon
+          - const: syscon
+      - items:
+          - const: cirrus,ep9301-syscon
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    items:
+      - description: reference clock
+
+patternProperties:
+  '^pins-':
+    type: object
+    description: pin node
+    $ref: /schemas/pinctrl/pinmux-node.yaml
+
+    properties:
+      function:
+        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]
+
+      groups:
+        enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
+                gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
+                rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp ]
+
+    required:
+      - function
+      - groups
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@80930000 {
+      compatible = "cirrus,ep9301-syscon", "syscon";
+      reg = <0x80930000 0x1000>;
+
+      #clock-cells = <1>;
+      clocks = <&xtali>;
+
+      spi_default_pins: pins-spi {
+        function = "spi";
+        groups = "ssp";
+      };
+    };
diff --git a/include/dt-bindings/clock/cirrus,ep9301-syscon.h b/include/dt-bindings/clock/cirrus,ep9301-syscon.h
new file mode 100644
index 000000000000..6bb8f532e7d0
--- /dev/null
+++ b/include/dt-bindings/clock/cirrus,ep9301-syscon.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
+#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
+
+#define EP93XX_CLK_PLL1		0
+#define EP93XX_CLK_PLL2		1
+
+#define EP93XX_CLK_FCLK		2
+#define EP93XX_CLK_HCLK		3
+#define EP93XX_CLK_PCLK		4
+
+#define EP93XX_CLK_UART		5
+#define EP93XX_CLK_SPI		6
+#define EP93XX_CLK_PWM		7
+#define EP93XX_CLK_USB		8
+
+#define EP93XX_CLK_M2M0		9
+#define EP93XX_CLK_M2M1		10
+
+#define EP93XX_CLK_M2P0		11
+#define EP93XX_CLK_M2P1		12
+#define EP93XX_CLK_M2P2		13
+#define EP93XX_CLK_M2P3		14
+#define EP93XX_CLK_M2P4		15
+#define EP93XX_CLK_M2P5		16
+#define EP93XX_CLK_M2P6		17
+#define EP93XX_CLK_M2P7		18
+#define EP93XX_CLK_M2P8		19
+#define EP93XX_CLK_M2P9		20
+
+#define EP93XX_CLK_UART1	21
+#define EP93XX_CLK_UART2	22
+#define EP93XX_CLK_UART3	23
+
+#define EP93XX_CLK_ADC		24
+#define EP93XX_CLK_ADC_EN	25
+
+#define EP93XX_CLK_KEYPAD	26
+
+#define EP93XX_CLK_VIDEO	27
+
+#define EP93XX_CLK_I2S_MCLK	28
+#define EP93XX_CLK_I2S_SCLK	29
+#define EP93XX_CLK_I2S_LRCLK	30
+
+#endif /* DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H */

-- 
2.41.0



