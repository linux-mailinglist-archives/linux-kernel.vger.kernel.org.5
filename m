Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388A27BF30D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442263AbjJJGa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442242AbjJJGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:30:25 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608E9D;
        Mon,  9 Oct 2023 23:29:37 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Tue, 10 Oct 2023
 14:29:34 +0800
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
Subject: [PATCH V2 1/4] dt-bindings: clock: add Amlogic C3 PLL clock controller bindings
Date:   Tue, 10 Oct 2023 14:29:14 +0800
Message-ID: <20231010062917.3624223-2-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the C3 PLL clock controller dt-bindings for Amlogic C3 SoC family

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
V1 -> V2: Fix errors when check dtbinding use "make dt_binding_check"
---
 .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
 .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 42 +++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
new file mode 100644
index 000000000000..a646992917b7
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
+title: Amlogic C3 serials PLL Clock Controller
+
+maintainers:
+  - Chuan Liu <chuan.liu@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,c3-pll-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: input pll_in
+      - description: input mclk_pll_in
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: pll_in
+      - const: mclk_pll_in
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
+    #include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clkc_pll: clock-controller@8000 {
+          compatible = "amlogic,c3-pll-clkc";
+          reg = <0x0 0x8000 0x0 0x1a4>;
+          clocks = <&clkc_periphs CLKID_PLL_IN>,
+                   <&clkc_periphs CLKID_MCLK_PLL_IN>;
+          clock-names = "pll_in", "mclk_pll_in";
+          #clock-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
new file mode 100644
index 000000000000..aa731e8fae29
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
@@ -0,0 +1,42 @@
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
+#define CLKID_FCLK_DIV40_DIV			2
+#define CLKID_FCLK_DIV40			3
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
+#define CLKID_HIFI_PLL_DCO			18
+#define CLKID_HIFI_PLL				19
+#define CLKID_MCLK_PLL_DCO			20
+#define CLKID_MCLK_PLL				21
+#define CLKID_MCLK_PLL_CLK			22
+#define CLKID_MCLK0_SEL				23
+#define CLKID_MCLK0_SEL_OUT			24
+#define CLKID_MCLK0_DIV				25
+#define CLKID_MCLK0				26
+#define CLKID_MCLK1_SEL				27
+#define CLKID_MCLK1_SEL_OUT			28
+#define CLKID_MCLK1_DIV				29
+#define CLKID_MCLK1				30
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */

base-commit: 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
-- 
2.37.1

