Return-Path: <linux-kernel+bounces-46793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049B844456
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E821C1F292FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36296130E4C;
	Wed, 31 Jan 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jlf1jxKD"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311812BF2C;
	Wed, 31 Jan 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718441; cv=none; b=ODjuATVvfvDdGfYyKgxnuBzTmZQRutFMWXD3NH60Hd0O1sFzMjMtIBxLNDY29/id193lQVpG+8F1k9e++s8RWZWDrbNF7ZcUaPle3YXks/3epuObIw8iDgr0uB2K5NKeJn4KU4/To/+R5CHmWY9wKyMO5Qrl8MSpJaH/Rc7ivJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718441; c=relaxed/simple;
	bh=WbnaMVsFXy3qNJApHfk0c2GzYypd4s9COwcc1eCpHFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgKFy4g5zeQTZ4aZWhGAtERR5jQ7U9seSIIYPuuwUfceNnR01K87IkGCzBvb73ne8dXJLdvOxyqbzZXkcQLJPVFMlq5o0XhVnoj1kRuK/dE7JO3wnHFCWBT55pfe41UraGAe3HlW0HLDY5QUNnJ2AzIAgZYxi9Q5//sghkNdCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jlf1jxKD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B8D940010;
	Wed, 31 Jan 2024 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfF9UjR1RJ0Efc0NY0CaMI2Wy+q2hxRGYq2bx2zOXf0=;
	b=jlf1jxKDDwakyKV0EZBVfcpX91XhVNtFf6uNBpiNsa+ajpz1YjXybHMNlVIUPo9IMLOfue
	r6w4TWls4xcFUxeu7WhBIP6KT35TR4LyrulEDgKvQoOe7uF5D8q6VXNV70A0HnO1o80JJF
	snFjESSE3rco/d2ISegBhPlAFXwX6yZ/45bDTW2z2TnsN3s9ZjZFJ0/UOeF0HCD+fR4kbg
	4aquosYOZKsZM3dZClqoeuZA1t5MX5VwVHtULenCVCBslzF8eOS2Emss6R3KBBUeLBGA7L
	75K5qM7D8A00f18R8hU2tlma+icKhFr7ZT6brlfIVMzOx+4DkbczwLormhKh7g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:20 +0100
Subject: [PATCH v4 07/18] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-7-bcd00510d6a0@bootlin.com>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
In-Reply-To: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
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
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 89 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
new file mode 100644
index 000000000000..92d8e30fdc27
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
@@ -0,0 +1,89 @@
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
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x0 0xe00000 0x400>;
+
+        clocks: clock-controller@2c {
+          compatible = "mobileye,eyeq5-clk";
+          reg = <0x02C 0x50>, <0x11C 0x04>;
+          reg-names = "plls", "ospi";
+          #clock-cells = <1>;
+          clocks = <&xtal>;
+          clock-names = "ref";
+        };
+
+        reset: reset-controller@0 {
+          compatible = "mobileye,eyeq5-reset";
+          reg = <0x000 0x0C>, <0x200 0x34>, <0x120 0x04>;
+          reg-names = "d0", "d1", "d2";
+          #reset-cells = <2>;
+        };
+
+        pinctrl: pinctrl@b0 {
+          compatible = "mobileye,eyeq5-pinctrl";
+          reg = <0x0B0 0x30>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 15c9987af637..886de494df31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14790,6 +14790,7 @@ F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
+F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S

-- 
2.43.0


