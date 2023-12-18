Return-Path: <linux-kernel+bounces-4134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8049817846
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6D81C2153B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4275BFB0;
	Mon, 18 Dec 2023 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MVk80s1w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8144237E;
	Mon, 18 Dec 2023 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8289C1BF209;
	Mon, 18 Dec 2023 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahVSmLR6iTDswYEVK643yMqHt0HqBdSL9hiXEU1xdC8=;
	b=MVk80s1wI3podiIZQs9nkEv4UUsu3EcRpWDQHVCYfcI9zGt5GHineoZD6d/rCp89z1wll6
	Ap2LwHKoNMR4cHOSVK0Yj16YJwchvkKEKxIUKRujOr6Y4dM1LfD3HWtj1jXuXGkcmw82kW
	MlBeluHLAIV86aXCkGWIRX74GTAHA8ESjWXJxJTQgzuS0OXf5NlyzsTvbnUBRXo2F5pih3
	8y8W3Nm7dLOV4eMx5iFwl8YnyJXYJ6+H7gxONrN69HV9EX+VLDeZVT3DioZRIWAuxipItY
	CDwbZdgNfVzzBmdymSpU49Q0mixjWF+6SEPXtCbmFQDSEdZqb2yVOUnPB6aIRg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:14:17 +0100
Subject: [PATCH 2/5] dt-bindings: clock: mobileye,eyeq5-clk: add bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-clk-v1-2-44ce54108f06@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
In-Reply-To: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add DT schema bindings for the EyeQ5 clock controller driver.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 83 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     | 22 ++++++
 3 files changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
new file mode 100644
index 000000000000..d56482a06bf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 clock controller
+
+description:
+  The EyeQ5 clock controller handles 10 read-only PLLs derived from the main
+  crystal clock. It also exposes one divider clock, a child of one of the PLLs.
+  It is custom to this platform, its registers live in a shared region called
+  OLB.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  $nodename:
+    pattern: "^clocks$"
+    description:
+      We have no unique address, we rely on OLB.
+
+  compatible:
+    const: mobileye,eyeq5-clk
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Input parent clock to all PLLs. Expected to be the main crystal.
+
+  clock-names:
+    items:
+      - const: ref
+
+  mobileye,olb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle to the OLB syscon. This is a fallback to using the parent as
+      syscon node.
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
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
+      clocks {
+        compatible = "mobileye,eyeq5-clk";
+        #clock-cells = <1>;
+        clocks = <&xtal>;
+        clock-names = "ref";
+      };
+    };
+
+  - |
+    olb: olb@e00000 {
+      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+      reg = <0xe00000 0x400>;
+      reg-io-width = <4>;
+    };
+
+    clocks {
+      compatible = "mobileye,eyeq5-clk";
+      mobileye,olb = <&olb>;
+      #clock-cells = <1>;
+      clocks = <&xtal>;
+      clock-names = "ref";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a7bd6b40d74..7f04fa760a4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14552,10 +14552,12 @@ M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/generic/board-eyeq5.config
 F:	arch/mips/generic/board-epm5.its.S
+F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
 MODULE SUPPORT
diff --git a/include/dt-bindings/clock/mobileye,eyeq5-clk.h b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
new file mode 100644
index 000000000000..7aa974354bb6
--- /dev/null
+++ b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_MOBILEYE_EYEQ5_CLK_H
+#define _DT_BINDINGS_CLOCK_MOBILEYE_EYEQ5_CLK_H
+
+#define EQ5C_PLL_CPU	0
+#define EQ5C_PLL_VMP	1
+#define EQ5C_PLL_PMA	2
+#define EQ5C_PLL_VDI	3
+#define EQ5C_PLL_DDR0	4
+#define EQ5C_PLL_PCI	5
+#define EQ5C_PLL_PER	6
+#define EQ5C_PLL_PMAC	7
+#define EQ5C_PLL_MPC	8
+#define EQ5C_PLL_DDR1	9
+
+#define EQ5C_DIV_OSPI	10
+
+#endif

-- 
2.43.0


