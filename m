Return-Path: <linux-kernel+bounces-88681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7042886E53B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DACB21FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9088271B27;
	Fri,  1 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xe/QgBe+"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579870CB6;
	Fri,  1 Mar 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310143; cv=none; b=QXEtq+gDvhm2LnN1LnGd0OIDeW/PfSdP8zZdVh6hBLulG6WKAis7yKdILFDHvLNaQhii228+GJ/02YeTBZMf0jkmnORgWs4C1YIyY8rDGZGPjpXY0ziEFraBhV7vxT9ZzLftZiwlWi4lEz74PHaKGB9UXTzTqKRYWFW5rhi8u9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310143; c=relaxed/simple;
	bh=hGcKFaa62JHu+i7aODcau5uKFUqbq77XcRozy2C1vBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/RgXRqm/ocIEc+gNiHwjsw2/RzFSrIDgcvmFwfAG883K+AuAH38pYvn15c1yxFkg5zmRkT+Nc4EXeWPii4AEjU/EgZzVgTKJ4wPric1YcKBbHw2N6J5RJ+lIHTtzPXmmAW6uQxF7UCdpvRwxJGxDSDseLMaTiQtMcjitGPkiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xe/QgBe+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA0B7C0003;
	Fri,  1 Mar 2024 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709310138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVagSC9xnvAH5g6knNt1Nu5204l9Vq+huwJu4u7z3PE=;
	b=Xe/QgBe+DhLx6UogoUK3oXUvY0ndzheTAUQ5cZLhhUeBR/ih/HXZb713Zqyt5dv0nNJ088
	GSmznR42leYEe87Zt8FyICuacKz1RPe0VNz+hlXNAiM/k18UknJRlCHqgpMWBtHs9uneWz
	kMakypN0x/Vef9dzZm17KwZ02DEewm3OLqvGbpMo0ndsoH7PKAGs7HLOWTY3cswU8semVg
	cUsWbHhU5VNyeTdMow+sPlk0vDBRnXczz2Mvi6kTKg/PpUcB1C12PcjU5IiHRJoWxcdM08
	K3pRplK30FJxYacf0PqSYguYnz8ZUvNbenI+u8GtESLyAmyEmsLQ+P7/RmSCTg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 01 Mar 2024 17:22:14 +0100
Subject: [PATCH v9 1/9] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240301-mbly-clk-v9-1-cbf06eb88708@bootlin.com>
References: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
In-Reply-To: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add documentation to describe the "Other Logic Block" syscon.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.yaml
new file mode 100644
index 000000000000..898cb1111f09
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
+        reset-controller@0 {
+          compatible = "mobileye,eyeq5-reset";
+          reg = <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
+          reg-names = "d0", "d1", "d2";
+          #reset-cells = <2>;
+        };
+
+        clock-controller@2c {
+          compatible = "mobileye,eyeq5-clk";
+          reg = <0x02c 0x50>, <0x11c 0x04>;
+          reg-names = "plls", "ospi";
+          #clock-cells = <1>;
+          clocks = <&xtal>;
+          clock-names = "ref";
+        };
+
+        pinctrl@b0 {
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

-- 
2.44.0


