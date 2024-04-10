Return-Path: <linux-kernel+bounces-139053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237889FE16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B32B30091
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87A17F376;
	Wed, 10 Apr 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J2Ssnzcm"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5417BB2F;
	Wed, 10 Apr 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769158; cv=none; b=ILEppKxCh5MiWfGwkJBvL7OP6TlxbpQrvPeAm0mO0gMfeXT4/dkbAYLSJDYVdir7P3fxybw+tOatcKCUtGVy47GuKpA2HcG9ZpiCb8GadmyNfBazyRxyA/FtH2bd5AAcLunGNP0E3C9ZkdOm/e9ut+tj56rZiRNa9kwUM8yWliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769158; c=relaxed/simple;
	bh=Or291JUs24MEUn69d+XwauX2nPmZNlD7rIxIXrFHe1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HX6lHKOMVy6HQ3cdKBVL16FkxB1WTGBXm7Gc1A+/ckD1Wzf+dstNNa9LeIs95YivrqIjhPOIwjAzsa0xCCsxuk/3mgFkIloOPuj/AdHFfwxAGVOH9gk9lJgPDrNvo+mTb8QXl8y5DVJJWvpnF2hNn4F0XjV3SZV3vkQwdMcmif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J2Ssnzcm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F3731C0009;
	Wed, 10 Apr 2024 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly+UQbnGLVNX/Ag4mEzSfzNVkLxnGyHhNenCfFPJ9mc=;
	b=J2Ssnzcm4DdjcFwztGM0r7y5ZeQCnf9WLKKEPZ2CDOoY+oFjgHn8Watlw9qZReaI7jBC4k
	15Ev/J4lvLOi/C2+rZxvKdNvPHA5k2RpGOZAiYM5QJ0vtx8IMN0R4VzGn77TOePt6fx0KA
	gfi6a+mCeXJzIEDVzh7E1hh3VzB5xDuSuLs1Fsv0Zw+O9n4BXAxo87ekAfU0O2MEZm81/D
	IVFalwxe+LO1dCfCAVB+KOet4XOEQotu9F6bgMN/CZtK9h0v/4TcWoOdJQTeED2lAw3cnV
	SetGrI3kiAYv1xBXtfUD+7AZh5TdeU7Fh0n1wqlhnQkXslEoAQXKR6vCqytbEw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 19:12:30 +0200
Subject: [PATCH 01/11] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-mbly-olb-v1-1-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
In-Reply-To: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add documentation to describe the "Other Logic Block" syscon.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 125 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 126 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
new file mode 100644
index 000000000000..c4e33a167fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ SoC system controller
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+description:
+  OLB ("Other Logic Block") is a hardware block grouping smaller blocks. Clocks,
+  resets, pinctrl are being handled from here. EyeQ5 and EyeQ6L host a single
+  instance. EyeQ6H hosts seven instances.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mobileye,eyeq5-olb
+          - mobileye,eyeq6l-olb
+          - mobileye,eyeq6h-olb
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  '^clock-controller@[0-9a-f]+$':
+    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
+
+  '^reset-controller@[0-9a-f]+$':
+    $ref: /schemas/reset/mobileye,eyeq5-reset.yaml#
+
+  '^pinctrl@[0-9a-f]+$':
+    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      system-controller@e00000 {
+        compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+        reg = <0x0 0xe00000 0x0 0x400>;
+        ranges = <0x0 0x0 0xe00000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reset-controller@e00000 {
+          compatible = "mobileye,eyeq5-reset";
+          reg = <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
+          reg-names = "d0", "d1", "d2";
+          #reset-cells = <2>;
+        };
+
+        clock-controller@e0002c {
+          compatible = "mobileye,eyeq5-clk";
+          reg = <0x02c 0x50>, <0x11c 0x04>;
+          reg-names = "plls", "ospi";
+          #clock-cells = <1>;
+          clocks = <&xtal>;
+          clock-names = "ref";
+        };
+
+        pinctrl@e000b0 {
+          compatible = "mobileye,eyeq5-pinctrl";
+          reg = <0x0b0 0x30>;
+
+          uart2_pins: uart2-pins {
+            function = "uart2";
+            pins = "PB8", "PB9";
+          };
+        };
+      };
+    };
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      system-controller@d2003000 {
+        compatible = "mobileye,eyeq6h-olb", "syscon", "simple-mfd";
+        reg = <0x0 0xd2003000 0x0 0x1000>;
+        ranges = <0x0 0x0 0xd2003000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reset-controller@d2003000 {
+          compatible = "mobileye,eyeq6h-acc-reset";
+          reg = <0x0 0x3c>;
+          #reset-cells = <1>;
+        };
+
+        clock-controller@d2003040 {
+          compatible = "mobileye,eyeq6h-acc-clk";
+          reg = <0x40 0x38>;
+          #clock-cells = <1>;
+          clocks = <&xtal>;
+          clock-names = "ref";
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..30dfbee84007 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14926,6 +14926,7 @@ M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S

-- 
2.44.0


