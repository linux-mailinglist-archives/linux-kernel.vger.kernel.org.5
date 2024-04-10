Return-Path: <linux-kernel+bounces-139054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEDC89FE57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D677B2416B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666717F397;
	Wed, 10 Apr 2024 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cN7RmgcG"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259217BB30;
	Wed, 10 Apr 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769159; cv=none; b=jDemgfJu4JpeaKBRM99toWzrIiaTKMyM8j1Nb9pZAI1YtIT0SkVR0P39XWQzj8vBUR7vjyGuNmlzkZXw50hMyLUxDk0rds6QpKQMyemTnw985gZw4Or+80LgMin2SNC4xAS9bjtGboBvFj8aNGRMwhB0OJ0Tt4fHdeDRduLvzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769159; c=relaxed/simple;
	bh=c+IFxwQfthW/nqRziH56DeSWLrMbg5sRJ/KRQ1A0kQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvq4VkTIhzRkdjoMLJGUBEyUERihO+ntbRNmMlKR8XQvdG6dTEg5CD2vu1gEMOYJy27zmPQnxRdN7wiUaK3PRsTud1fuGto3K08AnK0mtIuXBpFhtt+OYRsUWXZsRGFNMkP/h6oxKMLZFhUMFezRxm9cZwANeGx8B/aTGti8LJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cN7RmgcG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C51251C0002;
	Wed, 10 Apr 2024 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712769154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rXMr8mwJCHqbdg+nZTnRhhVEsvK2g8zb+kr2700fN8=;
	b=cN7RmgcGveDOP6X6p+9gUFdwZv655Qq0diqOgTgOKrR1e3MYYsHpFdqStpi8OzVKBQhGUy
	L8Lwudexe3EB35yCp6Y40yvdCq9Dc2AbE/4piY2GKx+EHLl/CJ8DlaNFBdppnupLGrGd8D
	0iDYCzIskgNC2UMrmRSoV+uM9bxkGl3hPxW96L2A0AoDEz0CGwFun7FW1e7YbChJDKJ4tR
	eoYlvJxAjgCL5O7oOjRNNgDmIrrZYwlVgtJaeit5uX86MFuN/AnqMGEPXMGlCV6fEco0Ph
	lAUAbY77/R5EMGoExZYA8OL6f7mmktqiRTtvaY72C3XQo78dgCPY0LH42c5hUw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 19:12:31 +0200
Subject: [PATCH 02/11] dt-bindings: clock: mobileye,eyeq5-clk: add EyeQ6L
 and EyeQ6H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-mbly-olb-v1-2-335e496d7be3@bootlin.com>
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

Add bindings describing EyeQ6L and EyeQ6H clock controllers.
Add constants to index clocks.

Bindings are conditional for two reasons:
 - Some compatibles expose a single clock; they do not take clock cells.
 - All compatibles take a PLLs resource, not all take others (aimed at
   divider clocks). Those that only take a resource for PLLs do not
   require named resources.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 103 ++++++++++++++++++---
 MAINTAINERS                                        |   2 +
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +++++
 3 files changed, 113 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
index 2d4f2cde1e58..a1651fcce258 100644
--- a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
@@ -4,12 +4,13 @@
 $id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mobileye EyeQ5 clock controller
+title: Mobileye EyeQ clock controller
 
 description:
-  The EyeQ5 clock controller handles 10 read-only PLLs derived from the main
-  crystal clock. It also exposes one divider clock, a child of one of the PLLs.
-  Its registers live in a shared region called OLB.
+  EyeQ clock controllers expose read-only PLLs derived from main crystal clock.
+  Some also expose divider clocks, children of specific PLLs. Its registers
+  live in a shared region called OLB. EyeQ5 and EyeQ6L have a single OLB
+  instance while EyeQ6H have seven, leading to seven clock controllers.
 
 maintainers:
   - Grégory Clement <gregory.clement@bootlin.com>
@@ -18,18 +19,23 @@ maintainers:
 
 properties:
   compatible:
-    const: mobileye,eyeq5-clk
+    enum:
+      - mobileye,eyeq5-clk
+      - mobileye,eyeq6l-clk
+      - mobileye,eyeq6h-central-clk
+      - mobileye,eyeq6h-west-clk
+      - mobileye,eyeq6h-east-clk
+      - mobileye,eyeq6h-south-clk
+      - mobileye,eyeq6h-ddr0-clk
+      - mobileye,eyeq6h-ddr1-clk
+      - mobileye,eyeq6h-acc-clk
 
-  reg:
-    maxItems: 2
+  reg: true
 
-  reg-names:
-    items:
-      - const: plls
-      - const: ospi
+  reg-names: true
 
   "#clock-cells":
-    const: 1
+    enum: [0, 1]
 
   clocks:
     maxItems: 1
@@ -43,9 +49,80 @@ properties:
 required:
   - compatible
   - reg
-  - reg-names
   - "#clock-cells"
   - clocks
   - clock-names
 
+allOf:
+  # "mobileye,eyeq5-clk" provides:
+  #  - PLLs and,
+  #  - One divider clock related to ospi.
+  - if:
+      properties:
+        compatible:
+          const: mobileye,eyeq5-clk
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            enum: [ plls, ospi ]
+      required:
+        - reg-names
+
+  # "mobileye,eyeq6h-south-clk" provides:
+  #  - PLLs and,
+  #  - Four divider clocks related to emmc, ospi and tsu.
+  - if:
+      properties:
+        compatible:
+          const: mobileye,eyeq6h-south-clk
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          minItems: 4
+          maxItems: 4
+          items:
+            enum: [ plls, emmc, ospi, tsu ]
+      required:
+        - reg-names
+
+  # Other compatibles only provide PLLs. Do not ask for named resources.
+  - if:
+      not:
+        required:
+          - reg-names
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+        reg-names: false
+
+  # Some compatibles provide a single clock; they do not take a clock cell.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mobileye,eyeq6h-central-clk
+            - mobileye,eyeq6h-west-clk
+            - mobileye,eyeq6h-east-clk
+            - mobileye,eyeq6h-ddr0-clk
+            - mobileye,eyeq6h-ddr1-clk
+    then:
+      properties:
+        "#clock-cells":
+          const: 0
+    else:
+      properties:
+        "#clock-cells":
+          const: 1
+
 additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 30dfbee84007..f5a488331b38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14925,11 +14925,13 @@ M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
+F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
diff --git a/include/dt-bindings/clock/mobileye,eyeq5-clk.h b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
index 26d8930335e4..b433c1772c28 100644
--- a/include/dt-bindings/clock/mobileye,eyeq5-clk.h
+++ b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
@@ -19,4 +19,25 @@
 
 #define EQ5C_DIV_OSPI	10
 
+#define EQ6LC_PLL_DDR		0
+#define EQ6LC_PLL_CPU		1
+#define EQ6LC_PLL_PER		2
+#define EQ6LC_PLL_VDI		3
+
+#define EQ6HC_SOUTH_PLL_VDI		0
+#define EQ6HC_SOUTH_PLL_PCIE		1
+#define EQ6HC_SOUTH_PLL_PER		2
+#define EQ6HC_SOUTH_PLL_ISP		3
+
+#define EQ6HC_SOUTH_DIV_EMMC		4
+#define EQ6HC_SOUTH_DIV_OSPI_REF	5
+#define EQ6HC_SOUTH_DIV_OSPI_SYS	6
+#define EQ6HC_SOUTH_DIV_TSU		7
+
+#define EQ6HC_ACC_PLL_XNN		0
+#define EQ6HC_ACC_PLL_VMP		1
+#define EQ6HC_ACC_PLL_PMA		2
+#define EQ6HC_ACC_PLL_MPC		3
+#define EQ6HC_ACC_PLL_NOC		4
+
 #endif

-- 
2.44.0


