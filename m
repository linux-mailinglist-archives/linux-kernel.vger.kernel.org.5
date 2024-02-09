Return-Path: <linux-kernel+bounces-59461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63A84F765
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF57B27D04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120D16DD19;
	Fri,  9 Feb 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QgvOrLd4"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8643F9C0;
	Fri,  9 Feb 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489114; cv=none; b=ahbAgNZgPr+egkqcf02zYe3womeJJiL+fEU+xK35kbc0VAkswDKi78LB6SPTiWhBQ3DMOm1CytHoTAlWxtc2Ci9UtasBifZtw6YIaaW91emRldYR1AMdj6OYrgZeHbJUXbRdwvaJItmTWQ1uqXTGvHRvtjBJjb41ZJEx1enpDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489114; c=relaxed/simple;
	bh=QyuJSJlqyr4I15nAAAdkFa3ViskJgQew0x/JXRRa0AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NO6l/YpIPOpSYGq9KYpD3i2uCGrRYi/JR2twhPEsuTqSN94nSSAZ1GI/cl/vR71RxRQFDSDLerMikAJBVBTlN2Zf+tjbzJhZCA9FXnNHjfzi9JdnJsDqGfvtPMnAu9aBXxeKghK4YOAL3lFBDCa91eq5V4DDdHwC/nasFoQrhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QgvOrLd4; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F59C240002;
	Fri,  9 Feb 2024 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq9MbOqr21Sl0cLKaoBi7IfLbqhaI1zVPu3ITBlSL8o=;
	b=QgvOrLd4CH0xvBJjh2lbqtPgPCmRxHnDiPDPO54ZMRSb62wQ3AT6wnzDmq+w2Xf1Hcof7n
	cJBeXqM48r4vthLWHP8MbKcQFeeUXqprkIdIKsQv2YwtUzrWYFvbdiE7rkEvJgFEQ+Y6eg
	vLx2t/h5u8lwh6HkRY56X5Pi+6iS3lfhed97byLmBwV4nM1HpyLOQKGEScbnkz4FUex8Gz
	UAr7t02ETmVg9fIyLck3fz+GPlqBbnw7TK3q6KWjUXdxdaEeGxIwtR3Aff57RmzDTuYmxC
	pht/sVt95GcBJLa6vA4Gn3ye8cthaeKBfmTVKixNwLIYyok4XuahnECr9cNHkA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:39 +0100
Subject: [PATCH v5 03/13] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-3-f094ee5e918a@bootlin.com>
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

Add DT schema bindings for the EyeQ5 clock controller driver.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     | 22 +++++++++
 3 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
new file mode 100644
index 000000000000..44eff4618ca7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
@@ -0,0 +1,52 @@
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
+  Its registers live in a shared region called OLB.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  compatible:
+    const: mobileye,eyeq5-clk
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: plls
+      - const: ospi
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
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 35c752dc536b..2143f64e9e15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14789,10 +14789,12 @@ M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
+F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
 MODULE SUPPORT
diff --git a/include/dt-bindings/clock/mobileye,eyeq5-clk.h b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
new file mode 100644
index 000000000000..26d8930335e4
--- /dev/null
+++ b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
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


