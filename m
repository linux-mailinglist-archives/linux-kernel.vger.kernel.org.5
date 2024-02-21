Return-Path: <linux-kernel+bounces-75273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CB85E5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B4285758
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3519886654;
	Wed, 21 Feb 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xb9acCvV"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283DE8563B;
	Wed, 21 Feb 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539741; cv=none; b=c7jpVx+o1Ssv+P5g4h0LXkEQ4LZF8luSaZyny7A11Ln1gx3ZKgn6oxEgSiVw/wUaycxozIhhiRunSLQgEHC/Wqie8uw8DFwkxa8J+ACLBCB37/mfEdsTk0jyBfiQFYsnjbTfqGvNnrw3yCwC1sspOR6zF5TD6rs35ZAe9unQ6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539741; c=relaxed/simple;
	bh=9eRYZqbhLYxbm7+1d3AhD7zvp7+CWKCJVnKMerGkGE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZMFFc6rWEwvka93pZ9+Ral6NuYgGK3Wjb2TF9tcP1LAVwMXbgDkbufhmhnN/d4NSs+1tCdmiovv4cwDbYimNsUBHlRYAeraOULL1QgOK0APKJZFc2LxQw/vnN9rBsA/Snh/cs9lA7o32w1FHXFngRJxD41lBq/j8P3LOFXC5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xb9acCvV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BD7E1C000F;
	Wed, 21 Feb 2024 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoFx13fmMimmUzrYz1dYQIpzUCBtU/B9f7npkbpVW0I=;
	b=Xb9acCvVlz5wUDB90BspdOml0OIiw4pcfEzyOHCLswCWIaoC6Aw6WxPMG/MHbCBKp5rg+e
	/hisXcUUaA6KDjfVsc1wOMJ/g8glAVeTVvmXrTIvkjLshtsOCia3o4ezPd7tBOqyrjr7DT
	byoBcblS1fQNBDl9LKluhusRcvzk8ll+xq1r7lo6TwZYTwQJltbxNLwyRRNMNjm4bO7Dyd
	g4iaY280nA01vi9x9nt4Uqx6UjJxSz6jYinI/GK2tg9VAk6y8RYfnlDSnndTKUgaJeyy4H
	0WTr1ATNPV3N8tmy0F/fDsszxwrXyyOst9b6W4FTDYb2oYKkOAhxS+GF7+uj6Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:14 +0100
Subject: [PATCH v7 06/14] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-6-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
In-Reply-To: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
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
index 000000000000..bcded7fb86dc
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

-- 
2.43.2


