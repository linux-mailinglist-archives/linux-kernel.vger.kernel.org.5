Return-Path: <linux-kernel+bounces-4149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9018817879
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9431C22DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560655D747;
	Mon, 18 Dec 2023 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lYY9FGk/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F75A879;
	Mon, 18 Dec 2023 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55C7C20002;
	Mon, 18 Dec 2023 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702920008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Wwl11dg+pn6TldO6thipG27TxYZycqcEukr6hWE+P4=;
	b=lYY9FGk/iH5dT4vEQQ+pS0PIcjNBxY/kGIy31ILNItU95ll7qIg6IDIJYYt641fks0rhKI
	c9C/LsAG5K+iFfmD9vD2+oZ0rA3W02eiiLrO4PCUsGmObheXj2+WtOggTMU5n7squSyV/5
	9XSnoKS0rdNwRr9QnBQqruPrLpVgfHhQky9pVPkddzXfTk8ZlngXVS91oMvNokjZ2wpTYZ
	Bq8JTv3RZ3vkI9XZ+PQ5Y/VkJTlRFd+iaVFn90JcAVfHv9wiHX88QcoYXWprr+Qz5BV4UM
	t71a8xacDXq9PXbywhbTne2BgRdAZHOICtGeHOup1P5BXvAJSfujalaROAbLiA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:19:46 +0100
Subject: [PATCH 1/4] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-pinctrl-v1-1-2f7d366c2051@bootlin.com>
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
In-Reply-To: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 125 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 126 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
new file mode 100644
index 000000000000..5faddebe2413
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 pinctrl (pinmux & pinconf) controller
+
+description:
+  The EyeQ5 pin controller handles a pin bank. It is custom to this platform,
+  its registers live in a shared region called OLB.
+  There are two pin banks on the platform, each having a specific compatible.
+  Pins and groups are bijective.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  $nodename:
+    pattern: "^pinctrl([0-9]+)?$"
+    description:
+      We have no unique address, we rely on OLB; we therefore can't keep the
+      standard pattern and cannot inherit from pinctrl.yaml.
+
+  compatible:
+    enum:
+      - mobileye,eyeq5-a-pinctrl
+      - mobileye,eyeq5-b-pinctrl
+
+  "#pinctrl-cells":
+    const: 1
+
+  mobileye,olb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle to the OLB syscon. This is a fallback to using the parent as
+      syscon node.
+
+required:
+  - compatible
+  - "#pinctrl-cells"
+
+patternProperties:
+  "-pins?$":
+    type: object
+    description: Pin muxing configuration.
+    $ref: pinmux-node.yaml#
+    additionalProperties: false
+    properties:
+      pins: true
+      function: true
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+    required:
+      - pins
+      - function
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-a-pinctrl
+    then:
+      patternProperties:
+        "-pins?$":
+          properties:
+            function:
+              enum: [gpio, timer0, timer1, timer2, timer5, uart0, uart1, can0,
+                     can1, spi0, spi1, refclk0]
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-b-pinctrl
+    then:
+      patternProperties:
+        "-pins?$":
+          properties:
+            function:
+              enum: [gpio, timer3, timer4, timer6, uart2, can2, spi2, spi3,
+                     mclk0]
+
+additionalProperties: false
+
+examples:
+  - |
+    olb@e00000 {
+      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+      reg = <0xe00000 0x400>;
+      reg-io-width = <4>;
+
+      pinctrl0 {
+        compatible = "mobileye,eyeq5-a-pinctrl";
+        #pinctrl-cells = <1>;
+      };
+
+      pinctrl1 {
+        compatible = "mobileye,eyeq5-b-pinctrl";
+        #pinctrl-cells = <1>;
+      };
+    };
+  - |
+    olb: olb@e00000 {
+      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+      reg = <0xe00000 0x400>;
+      reg-io-width = <4>;
+    };
+
+    pinctrl0 {
+      compatible = "mobileye,eyeq5-a-pinctrl";
+      #pinctrl-cells = <1>;
+      mobileye,olb = <&olb>;
+    };
+
+    pinctrl1 {
+      compatible = "mobileye,eyeq5-b-pinctrl";
+      #pinctrl-cells = <1>;
+      mobileye,olb = <&olb>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 138e0303c5da..d8d9583a5a06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14553,6 +14553,7 @@ M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/generic/board-eyeq5.config

-- 
2.43.0


