Return-Path: <linux-kernel+bounces-59467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0A84F77F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7831F22578
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE47D3ED;
	Fri,  9 Feb 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mxOrYrV8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE36F06C;
	Fri,  9 Feb 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489119; cv=none; b=aCJ276J6S0STrQPO2gU0/yYnoLcjXuAlKCQbovzdZ1tOZYkyLPS1t0XkjaUoZZjt9iNGvP4V/Tp4z+1/B4uk9dGs3DFNT610jN/LidHfuyFNfZiw4ME4Xsx7BtCRT+0epanCgmB0ce+b/vfpl26fRmZmP3EG9wrrLtSa6cbHMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489119; c=relaxed/simple;
	bh=e+hmStUrY3u9nabSGW4AZ/zZ6+E5rH8WkoPvGWObM2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXljbuURXKyN12zMoH+gPenBNXQ7o0PxyQlWiqSmDlwEO5J737Vpak67HeDbtoatD1Qg+ZwdPwhhddjmTaetvKy3Pu8LnSjP4mkLsfP2SaE6iVLFyrqHHYJotUSgH2v0hImJDezGwPCzutFTawbxgrtwA+2QPIdqCb9zhhWrUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mxOrYrV8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 422AF24000B;
	Fri,  9 Feb 2024 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syaGWASVz7HJ8EsREfptT5dsVQfBdow3w7CFtxWQaiQ=;
	b=mxOrYrV8krBhVCmaFuPG2Pof20O2IkcdnW1Mz8felwO3PGPxf0+T5j/4NUde2qvprkllrz
	T+8z2FFQfpg3uzmYBlDe1EM0d8oMiBHs6TWu2AyAHztcfepQAF7d/Y7i7G/AejLkLUBlqe
	eO/kkL6Mcj4cThZHhCGgaABN2aPDp4IAkTuxxAU9Oth5jXInNTUWYRvvNne9PLPWwrUeJy
	Suno5G6h1jWSUOInY2tw4VG2xzhGUA3PQHG5us6LbWKU4Ye6t8eAx4pvoynIsU6HVJjDEA
	fLbrps+k6nkaJo91h8/95oAYCYU8H/hje5qDYM61kYMhInw+KwjwJ/mQwdQq+g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:42 +0100
Subject: [PATCH v5 06/13] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-6-f094ee5e918a@bootlin.com>
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
In-Reply-To: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
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
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 94 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
new file mode 100644
index 000000000000..768ff1aa1db7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
@@ -0,0 +1,94 @@
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^clock-controller@[0-9a-f]+$":
+    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
+
+  "^reset-controller@[0-9a-f]+$":
+    $ref: /schemas/reset/mobileye,eyeq5-reset.yaml#
+
+  "^pinctrl@[0-9a-f]+$":
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
+        reset: reset-controller@0 {
+          compatible = "mobileye,eyeq5-reset";
+          reg = <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
+          reg-names = "d0", "d1", "d2";
+          #reset-cells = <2>;
+        };
+
+        clocks: clock-controller@2c {
+          compatible = "mobileye,eyeq5-clk";
+          reg = <0x02c 0x50>, <0x11c 0x04>;
+          reg-names = "plls", "ospi";
+          #clock-cells = <1>;
+          clocks = <&xtal>;
+          clock-names = "ref";
+        };
+
+        pinctrl: pinctrl@b0 {
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
diff --git a/MAINTAINERS b/MAINTAINERS
index a09899acfa6a..d6e1dacf1c84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14793,6 +14793,7 @@ F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
+F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S

-- 
2.43.0


