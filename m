Return-Path: <linux-kernel+bounces-156298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58438B00F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30F52836CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA9156867;
	Wed, 24 Apr 2024 05:25:27 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A41552FC;
	Wed, 24 Apr 2024 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936327; cv=none; b=A14ocjxUZIn52wl6WPP3PhebgPQXdd4R7vEF+cqpaVJeWeKz4G177K28gZXO4a0O8ZToupzFPRWZRGRCkkKjsxAsLDmhJQRp6QV9UNegg3xWQGZD1C6+Fewv9C0q2+FwSX+R6BGtz3fCFKMbA5Ec95q3G/BaBcPrysARoOKDPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936327; c=relaxed/simple;
	bh=vnBURd88BzQGdLsCt5oWszBO5nUaBcW/oA6W2AlAjMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7hqjr4DEGi/ksq80Oyaen2XxBtBB+Uy1q7NZYZkGhHgfh9DIrFt51c4GOsBBEyL6Tsf42EqqehqC8EBpKAWRA234mUkFmFqH5S6cg+XTwaeSA9ZDz4jFwpPHyGX+JBUW8hRRrpJ3cjNqXA0SHR679LBlLyo/lftpYjp1Rw8f+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Wed, 24 Apr 2024
 13:10:15 +0800
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
To: <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chuan Liu
	<chuan.liu@amlogic.com>
Subject: [PATCH v7 1/5] dt-bindings: clock: add Amlogic C3 PLL clock controller
Date: Wed, 24 Apr 2024 13:09:24 +0800
Message-ID: <20240424050928.1997820-2-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the PLL clock controller dt-bindings for Amlogic C3 SoC family.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
 .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 40 +++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
new file mode 100644
index 000000000000..43de3c6fc1cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,c3-pll-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic C3 series PLL Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Chuan Liu <chuan.liu@amlogic.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,c3-pll-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input top pll
+      - description: input mclk pll
+
+  clock-names:
+    items:
+      - const: top
+      - const: mclk
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@8000 {
+            compatible = "amlogic,c3-pll-clkc";
+            reg = <0x0 0x8000 0x0 0x1a4>;
+            clocks = <&scmi_clk 2>,
+                     <&scmi_clk 5>;
+            clock-names = "top", "mclk";
+            #clock-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
new file mode 100644
index 000000000000..fcdc558715e8
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
+
+#define CLKID_FCLK_50M_EN			0
+#define CLKID_FCLK_50M				1
+#define CLKID_FCLK_DIV2_DIV			2
+#define CLKID_FCLK_DIV2				3
+#define CLKID_FCLK_DIV2P5_DIV			4
+#define CLKID_FCLK_DIV2P5			5
+#define CLKID_FCLK_DIV3_DIV			6
+#define CLKID_FCLK_DIV3				7
+#define CLKID_FCLK_DIV4_DIV			8
+#define CLKID_FCLK_DIV4				9
+#define CLKID_FCLK_DIV5_DIV			10
+#define CLKID_FCLK_DIV5				11
+#define CLKID_FCLK_DIV7_DIV			12
+#define CLKID_FCLK_DIV7				13
+#define CLKID_GP0_PLL_DCO			14
+#define CLKID_GP0_PLL				15
+#define CLKID_HIFI_PLL_DCO			16
+#define CLKID_HIFI_PLL				17
+#define CLKID_MCLK_PLL_DCO			18
+#define CLKID_MCLK_PLL_OD			19
+#define CLKID_MCLK_PLL				20
+#define CLKID_MCLK0_SEL				21
+#define CLKID_MCLK0_SEL_EN			22
+#define CLKID_MCLK0_DIV				23
+#define CLKID_MCLK0				24
+#define CLKID_MCLK1_SEL				25
+#define CLKID_MCLK1_SEL_EN			26
+#define CLKID_MCLK1_DIV				27
+#define CLKID_MCLK1				28
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */
-- 
2.39.2


