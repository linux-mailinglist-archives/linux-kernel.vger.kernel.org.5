Return-Path: <linux-kernel+bounces-46790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECC844441
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2947C1F2B37B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5B12CD93;
	Wed, 31 Jan 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XdC/ybVa"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0632433CB;
	Wed, 31 Jan 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718438; cv=none; b=U0+AeQIFFuKFbqXT6bGpTMgTpB9HRKFmoa6BzhEZsCvq2vivGKMLnY1LDQ63ukgvCOuVpdzYSdjD9sy9I0X3r3Lvsp42OA9gyyAJX8qDfLJeHQWlZQG344kCLMttN7i0nKCFWbHOjWprRVrrXL2yvrP1ajy0MifeJHjADs0Tf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718438; c=relaxed/simple;
	bh=lMUVrrK69PzOdKM3YZF8GuoM4TmAX5E9omOxsg+Tiy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAsZ9sMbdAaNU1iImLcwWDnLISyyvnTiOzotTmj2bYYEeHtWqI1qn14RyMMTUuT9GHdlOrJmpzP/WHAV9hBBBBk6zo9jMmwjmBe3Sl9EhvhLxE3T1wv1WCNSCHh+mbH71OirCnyfXhFY0sUrfVsIuXRIYioBvfEpLR4nZ3xJlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XdC/ybVa; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59F0640008;
	Wed, 31 Jan 2024 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiU9JeTONi6SPpWxtrTKBBxl6LhAdersmwuDpjHhYPA=;
	b=XdC/ybVaJgze3rlc55aeI7jIFbcIdjhJtrbVll+GoEUT7jvPSXul1qHL33F3a05beujHtF
	SxRZkFeySJPB/x2vT/Xs5LFjBlL+AqyYLVJACbwsIgCDEha2h3dXQuup7eTLkVRkf/Qudl
	EM+Z1JLx9XCLQLGgT02gNXYiMQmvJtt1GAhyCl+3lfc8HHhEOTTGa5XTFY7p4njO+0Xy+1
	sdF8DWxYjHmXhuBY1oFdFkk4tFrbOipx/tV6wu0paRm47HNPueQ1QX+QWkLMTFEX2lIhl3
	UgiLUu/WjrRZkmyzw45+CsydZ2wig+9UjrXp4vUvxDIY9m3+lW6TtFjZd4bFgQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:17 +0100
Subject: [PATCH v4 04/18] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-4-bcd00510d6a0@bootlin.com>
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
index 260bcfc6da8f..42db14d184be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14786,10 +14786,12 @@ M:	Gregory CLEMENT <gregory.clement@bootlin.com>
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


