Return-Path: <linux-kernel+bounces-4140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26581785F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15358B23699
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336555D734;
	Mon, 18 Dec 2023 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SFohura8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75534FF6D;
	Mon, 18 Dec 2023 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3874AE000A;
	Mon, 18 Dec 2023 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/269SREveuMrY7DCSLC6z4qyIspt2wftuz4Mfih0Tk=;
	b=SFohura81X2ZS5XNQOFijfGbI9eOFRq4FktH0AtA1UAfLlezPF1Ii277hBAjETVjSwq47C
	jDaH9zDFKm1P8XbcCeypsKLcafiQQ8bXPvE/L2hy4QsXawnMkezJ2d3X7mct5D0c0ngcwj
	mwBzjZ5ZZeMpSPURWbulcksAUZ5Rw0B4N8HJg9cL8dU8zV+s5PwYyu5HuRCxVpuqHq5exu
	rXcQohJq9g9yKlaN73vVMkZme8j1mlhT3McLtJCNPghc8ufH0+YLIUkyF1C95HSqmskygZ
	5MVy7GO0CGaYNSnnwmrtjYndzRn+oZljryKvcDU5KSL4/EV2DJYlAsMrOA4Iqw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:16:12 +0100
Subject: [PATCH 1/4] dt-bindings: reset: mobileye,eyeq5-reset: add bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-reset-v1-1-b4688b916213@bootlin.com>
References: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
In-Reply-To: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add DT-Schema bindings for the EyeQ5 reset controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 69 +++++++++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/reset/mobileye,eyeq5-reset.h   | 80 ++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
new file mode 100644
index 000000000000..cab6a75ba59d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye EyeQ5 reset controller
+
+description:
+  The EyeQ5 reset driver handles three reset domains. It is custom to this
+  platform, its registers live in a shared region called OLB.
+
+maintainers:
+  - Grégory Clement <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+
+properties:
+  $nodename:
+    pattern: "^reset-controller$"
+    description:
+      We have no unique address, we rely on OLB.
+
+  compatible:
+    const: mobileye,eyeq5-reset
+
+  "#reset-cells":
+    const: 2
+    description:
+      The first cell is the domain (0 to 2 inclusive) and the second one is the
+      reset index inside that domain.
+
+  mobileye,olb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle to the OLB syscon. This is a fallback to using the parent as
+      syscon node.
+
+required:
+  - compatible
+  - "#reset-cells"
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
+      reset-controller {
+        compatible = "mobileye,eyeq5-reset";
+        #reset-cells = <2>;
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
+    reset-controller {
+      compatible = "mobileye,eyeq5-reset";
+      #reset-cells = <2>;
+      mobileye,olb = <&olb>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a7bd6b40d74..9096a940b425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14553,9 +14553,11 @@ M:	Théo Lebrun <theo.lebrun@bootlin.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/generic/board-eyeq5.config
 F:	arch/mips/generic/board-epm5.its.S
+F:	include/dt-bindings/reset/mobileye,eyeq5-reset.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
 MODULE SUPPORT
diff --git a/include/dt-bindings/reset/mobileye,eyeq5-reset.h b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
new file mode 100644
index 000000000000..ce59fe5409ac
--- /dev/null
+++ b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
+ */
+
+#ifndef _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
+#define _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
+
+/* Domain 0 */
+
+/* 0..2 are reserved */
+#define EQ5R_D0_CAN0				3
+#define EQ5R_D0_CAN1				4
+#define EQ5R_D0_CAN2				5
+#define EQ5R_D0_SPI0				6
+#define EQ5R_D0_SPI1				7
+#define EQ5R_D0_SPI2				8
+#define EQ5R_D0_SPI3				9
+#define EQ5R_D0_UART0				10
+#define EQ5R_D0_UART1				11
+#define EQ5R_D0_UART2				12
+#define EQ5R_D0_I2C0				13
+#define EQ5R_D0_I2C1				14
+#define EQ5R_D0_I2C2				15
+#define EQ5R_D0_I2C3				16
+#define EQ5R_D0_I2C4				17
+#define EQ5R_D0_TIMER0				18
+#define EQ5R_D0_TIMER1				19
+#define EQ5R_D0_TIMER2				20
+#define EQ5R_D0_TIMER3				21
+#define EQ5R_D0_TIMER4				22
+#define EQ5R_D0_WD0				23
+#define EQ5R_D0_EXT0				24
+#define EQ5R_D0_EXT1				25
+#define EQ5R_D0_GPIO				26
+#define EQ5R_D0_WD1				27
+/* 28..31 are reserved */
+
+/* Domain 1 */
+
+/* Vector Microcode Processors */
+#define EQ5R_D1_VMP0				0
+#define EQ5R_D1_VMP1				1
+#define EQ5R_D1_VMP2				2
+#define EQ5R_D1_VMP3				3
+/* Programmable Macro Array */
+#define EQ5R_D1_PMA0				4
+#define EQ5R_D1_PMA1				5
+#define EQ5R_D1_PMAC0				6
+#define EQ5R_D1_PMAC1				7
+/* Multi-threaded Processing Clusters */
+#define EQ5R_D1_MPC0				8
+#define EQ5R_D1_MPC1				9
+
+/* Domain 2 */
+
+#define EQ5R_D2_PCIE0_CORE_SWRST_DIS		0
+#define EQ5R_D2_PCIE0_APB_SWRST_DIS		1
+#define EQ5R_D2_PCIE0_LINK_AXI_RST_DIS		2
+#define EQ5R_D2_PCIE0_LINK_MGMT_RST_DIS		3
+#define EQ5R_D2_PCIE0_LINK_HOT_RST_DIS		4
+#define EQ5R_D2_PCIE0_LINK_PIPE_RST_DIS		5
+
+#define EQ5R_D2_PCIE1_CORE_SWRST_DIS		6
+#define EQ5R_D2_PCIE1_APB_SWRST_DIS		7
+#define EQ5R_D2_PCIE1_LINK_AXI_RST_DIS		8
+#define EQ5R_D2_PCIE1_LINK_MGMT_RST_DIS		9
+#define EQ5R_D2_PCIE1_LINK_HOT_RST_DIS		10
+#define EQ5R_D2_PCIE1_LINK_PIPE_RST_DIS		11
+
+#define EQ5R_D2_MULTIPHY_SWRST_DIS		12
+#define EQ5R_D2_MULTIPHY_APB_RST_DIS		13
+/* 14 is refclk select, ie not a reset */
+#define EQ5R_D2_PCIE0_LINK_MGMT_RST		15
+#define EQ5R_D2_PCIE1_LINK_MGMT_RST		16
+#define EQ5R_D2_PCIE0_LINK_PM_RST		17
+#define EQ5R_D2_PCIE1_LINK_PM_RST		18
+/* 19..31 are unknown */
+
+#endif

-- 
2.43.0


