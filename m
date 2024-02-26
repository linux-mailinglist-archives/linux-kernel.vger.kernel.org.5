Return-Path: <linux-kernel+bounces-80640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91707866ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480EC28116E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1AB208A4;
	Mon, 26 Feb 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSPUec1p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A691BF54;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932682; cv=none; b=UZfb0LQDxxJf3EPO+SGm5uT1JUoSLtPiZBI8S81ghQvNinIjS/v53Vk9tcw0DnU8ML7RHgNfCcPn3do5zRi488h8F+eMyDZPjxqlvWeplLLkpyrHfcjS23v/i/9OtOXa01mgHGJk5wXu9mY0xTRVXHg+nfzmTi7Odb8haHKpPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932682; c=relaxed/simple;
	bh=+FTxigicmwtWaDBJR5jbXPp4yMT74yxgCpF5zN8lPsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+er1+vnvlJHpwtnRC+3ZCqBY5uVgblpHfjjiZPcvB1asLEwPuN+8RvG2IKZ1euMDPak2EUTkXEzmQThfcxHIEyIDlzceG2sl1Z7xPeU8hX14MA3q0sADXURrq6bc8O7e9X/z9eDlhed9Xa+2Xm5CoZu+DFIwjmANKMGQ06kOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSPUec1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A8B7C41674;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932682;
	bh=+FTxigicmwtWaDBJR5jbXPp4yMT74yxgCpF5zN8lPsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SSPUec1pze8Fe0KnXF1vcllC/TLF/sf6KPKQZ3TxRbTUp3VsKq30HOzHYobDRiYh1
	 b3sPLqO/jRz7INWcR32VuXOTfwzp2kDeFMJ5qcs8+5VXXJ5PDsLYYlzcFph/l6xd0R
	 bTmOsPktekLDFCg75L7dLYw7AX4Te1gOPnulQxrGyos86rp2/KGw7CkHdBwzJgp/ig
	 4ULsbouZYByQWu7sXxovP7+Yg6iwAIQR5JYJkYqx+iXgfiuEyHL2XfXU3uejqd7lti
	 A8GKnXUvUZ9XMLy0Uv5JyBcurPm9FmZr4FgZe/fUW3yW7PbkoNbxoMu6//6HlinEuH
	 lBhTDVERqF5/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF5C5478C;
	Mon, 26 Feb 2024 07:31:21 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:02 +0300
Subject: [PATCH v8 06/38] dt-bindings: soc: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-6-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=6088;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=iNlcZrrHIhUppJS7Xi/bb76DeGwNtG9ndvp3OCXnWXw=; =?utf-8?q?b=3DsQkKk8IZJv+g?=
 =?utf-8?q?DkXbxVhK0j+MRvpMYhz7lic3nQbqMhENdF3JulZol0okhU+toXQE9bAG3LUTyuSQ?=
 V0BrRpaQAXWXGfr39iHXYIjI80eNSUoeOsmJr7ux3mZPwfIwh03+
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree bindings for the Cirrus Logic EP93xx SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
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


