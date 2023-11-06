Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA40F7E1CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjKFI44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjKFI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:56:53 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66388E1;
        Mon,  6 Nov 2023 00:56:11 -0800 (PST)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 6 Nov 2023
 16:56:08 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V6 1/4] dt-bindings: clock: add Amlogic C3 PLL clock controller bindings
Date:   Mon, 6 Nov 2023 16:55:51 +0800
Message-ID: <20231106085554.3237511-2-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PLL clock controller dt-bindings for Amlogic C3 SoC family.

Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
 .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 44 ++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
new file mode 100644
index 000000000000..9ca047698045
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
+title: Amlogic C3 Serials PLL Clock Controller
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
+      - description: input Top pll
+      - description: input MCLK pll
+
+  clock-names:
+    items:
+      - const: top
+      - const: mpll
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
+            clocks = <&clkc_periphs 0>,
+                     <&clkc_periphs 1>;
+            clock-names = "top", "mpll";
+            #clock-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
new file mode 100644
index 000000000000..60df483629ed
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
+
+#define CLKID_FIXED_PLL_DCO			0
+#define CLKID_FIXED_PLL				1
+#define CLKID_FCLK_50M_EN			2
+#define CLKID_FCLK_50M				3
+#define CLKID_FCLK_DIV2_DIV			4
+#define CLKID_FCLK_DIV2				5
+#define CLKID_FCLK_DIV2P5_DIV			6
+#define CLKID_FCLK_DIV2P5			7
+#define CLKID_FCLK_DIV3_DIV			8
+#define CLKID_FCLK_DIV3				9
+#define CLKID_FCLK_DIV4_DIV			10
+#define CLKID_FCLK_DIV4				11
+#define CLKID_FCLK_DIV5_DIV			12
+#define CLKID_FCLK_DIV5				13
+#define CLKID_FCLK_DIV7_DIV			14
+#define CLKID_FCLK_DIV7				15
+#define CLKID_GP0_PLL_DCO			16
+#define CLKID_GP0_PLL				17
+#define CLKID_GP1_PLL_DCO			18
+#define CLKID_GP1_PLL				19
+#define CLKID_HIFI_PLL_DCO			20
+#define CLKID_HIFI_PLL				21
+#define CLKID_MCLK_PLL_DCO			22
+#define CLKID_MCLK_PLL_OD			23
+#define CLKID_MCLK_PLL				24
+#define CLKID_MCLK0_SEL				25
+#define CLKID_MCLK0_SEL_EN			26
+#define CLKID_MCLK0_DIV				27
+#define CLKID_MCLK0				28
+#define CLKID_MCLK1_SEL				29
+#define CLKID_MCLK1_SEL_EN			30
+#define CLKID_MCLK1_DIV				31
+#define CLKID_MCLK1				32
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */
-- 
2.39.2

