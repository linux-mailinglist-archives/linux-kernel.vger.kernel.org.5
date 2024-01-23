Return-Path: <linux-kernel+bounces-35904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C12D8398A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14E31C25817
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31C12BF1C;
	Tue, 23 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mhugsTg1"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDE85C69;
	Tue, 23 Jan 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035635; cv=none; b=swhaufhGkIwm8zKwWoSVXzUsp4FuUUOnve7tXokUxddOYUkHX1CaiA1hNfdOCP5upFMxypZkQoAm6C9ag5OfvZIMVDMh99aRebwDZQV0lAAOSjLzTq4ySC2khq9CEeeBBaJiHJOBsnZpRcxsIgz67Fuiei6wvG3Nxmb49ziHDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035635; c=relaxed/simple;
	bh=7a7PULsrWAbyk9o4WQFw6EoMLo4uq3Z4GNa/bdfQE3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Msr5ChaqMbavffqPw6llGwS+H1Sqll14wyVzY5D/V65ftjk4ncJYnHhHfLru5n9gEu9zW/xi6StR9Z3vgXt4vm5w3PT9lFKxqCxzqBQU8+SOj0WBEu4QXhTNqyrVoNaHLDRuF2JyWeq8yjmyo6QoyUEZ2VNCAAjCceeLG6J7hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mhugsTg1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D388C0003;
	Tue, 23 Jan 2024 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALLeDsdcOzz1oO5db0iKwfD4lCc6kwOs8jwpRo0rnSg=;
	b=mhugsTg1cC2oVa+DAg4hs8kC/QXRlGyvpQY1PDaxVlpwfmjXlaQGXHEp69SymbFAbSjnQp
	hYk6a2BkwNKx5VSt5ZdoFdd84W1DzVndG1bLcI7N305fuFDFrMvxgmeMYje9QL3MG3ZHrh
	QaFTiUrqCA0NDFjNYc4G57ttbQ9uAHrEjsc4OF1ImJHYJ/+7ff823KW/0v6XjWGBMt41ZI
	XhA5IyvLAwxf8eGojwAZ29fkzBKGYQuuZnNbqv6+o5SHc0p8t5uW3MoOmCW0XyrfedQBys
	wA14QYS0TeDfEdJDNwNzFFzFhaPw8LWe9FlYs4UPwk//zigCvYauTkiPpO2CeA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:49 +0100
Subject: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add documentation to describe the "Other Logic Block" syscon.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
new file mode 100644
index 000000000000..031ef6a532c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 SoC system controller
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+description:
+  OLB ("Other Logic Block") is a hardware block grouping smaller blocks. Clocks,
+  resets, pinctrl are being handled from here.
+
+properties:
+  compatible:
+    items:
+      - const: mobileye,eyeq5-olb
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
+    type: object
+
+  reset-controller:
+    $ref: /schemas/reset/mobileye,eyeq5-reset.yaml#
+    type: object
+
+  pinctrl-a:
+    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
+    type: object
+
+  pinctrl-b:
+    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@e00000 {
+      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+      reg = <0xe00000 0x400>;
+
+      clock-controller {
+        compatible = "mobileye,eyeq5-clk";
+        #clock-cells = <1>;
+        clocks = <&xtal>;
+        clock-names = "ref";
+      };
+
+      reset-controller {
+        compatible = "mobileye,eyeq5-reset";
+        #reset-cells = <2>;
+      };
+
+      pinctrl-a {
+        compatible = "mobileye,eyeq5-a-pinctrl";
+        #pinctrl-cells = <1>;
+      };
+
+      pinctrl-b {
+        compatible = "mobileye,eyeq5-b-pinctrl";
+        #pinctrl-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cb431c79c7b8..fe1270e8c983 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14786,6 +14786,7 @@ M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S

-- 
2.43.0


