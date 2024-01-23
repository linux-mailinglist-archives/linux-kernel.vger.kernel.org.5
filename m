Return-Path: <linux-kernel+bounces-35903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C8839897
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CF81C25DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088DE12BE99;
	Tue, 23 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nNOeSUJv"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093685C66;
	Tue, 23 Jan 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035635; cv=none; b=b5ViTi9ezF6XwdQjH08mw9ISgda3Qvw5sxmdytYEuvrPH2+u3JFZY7pZu6D/86oFZ4q8IbbjVsklTufft26T6FxtN8uC9apbm/Ux0Jup/v0zkF4N6PmaGHdzkllDy/9seUEoMDZkNgkUjazDeiwKtDSjxCXDISocvxAOysXmjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035635; c=relaxed/simple;
	bh=mcP13FcLt70jViAo9vNjz77UW3Km+NAIWebLZ+hBN3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYPpQCL8cdFYWaCVvf+U6k1D+wiaT77raHFmmgZgssvTnjAeR6g4DrUqGWNBQYA9nafPGXopRk8SKzgYHDmIpphxLBxeqzZYi8kTIufGJKeXon+kEnuAwxtTC9x/gsHAWTPzKF8G6hfX7nSGYNoHXpFsT1GGl7bQ3mJEyxYzXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nNOeSUJv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4DD2C0009;
	Tue, 23 Jan 2024 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyGh5PC+t14CEaCNPIcOatciMxawIJd7iXPS9OoBlF0=;
	b=nNOeSUJvJNQcaS2b1CCel2bWOCke6t6EdiZUOhFm8AB7VZEYDg/bD6wtPuKxDlpLefquOu
	MYUKMzWhIu9uQ5OxKkTDAYlm+ojSLtsgaflb/z4WhG7YeYkZFCbZjlK+hwRz6R3LMz8AeW
	NP1nEYhBSRj2To+IU1t6uGnvkLhpp6kN+0Rh5jVQ+ynb0WbpZ0gbX1PjglIHRAaTRR9Sf+
	kZkeY/GNOIfSGEfZY+qJIQ8MXWX25Uds3ztSYzDbhePJkt1W2NDGW3F0zsTVRkxAY28sCv
	ybYckpW+5aUuJxlFDMHP9I0DwNdLk0vT+GTKbnsAGOaaKYpaEREqm3mMSblkzw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:50 +0100
Subject: [PATCH v3 05/17] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-5-392b010b8281@bootlin.com>
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

Add DT schema bindings for the EyeQ5 clock controller driver.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 ++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     | 22 ++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
new file mode 100644
index 000000000000..e1813c010122
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
@@ -0,0 +1,41 @@
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
+  - "#clock-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index fe1270e8c983..45ab636b6605 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14785,11 +14785,13 @@ M:	Gregory CLEMENT <gregory.clement@bootlin.com>
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


