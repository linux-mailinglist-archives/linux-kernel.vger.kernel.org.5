Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93EC7912AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbjIDH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjIDH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:56:17 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81F103;
        Mon,  4 Sep 2023 00:56:13 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 4 Sep 2023
 15:56:11 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>,
        Yu Tu <yu.tu@amlogic.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V11 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
Date:   Mon, 4 Sep 2023 15:55:01 +0800
Message-ID: <20230904075504.23263-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20230904075504.23263-1-yu.tu@amlogic.com>
References: <20230904075504.23263-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the S4 PLL clock controller dt-bindings in the S4 SoC family.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/amlogic,s4-pll-clkc.yaml   | 49 +++++++++++++++++++
 .../dt-bindings/clock/amlogic,s4-pll-clkc.h   | 43 ++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
new file mode 100644
index 000000000000..d8932ec26ca8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic S4 PLL Clock Controller
+
+maintainers:
+  - Yu Tu <yu.tu@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,s4-pll-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: xtal
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
+    clkc_pll: clock-controller@fe008000 {
+      compatible = "amlogic,s4-pll-clkc";
+      reg = <0xfe008000 0x1e8>;
+      clocks = <&xtal>;
+      clock-names = "xtal";
+      #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
new file mode 100644
index 000000000000..af9f110f8b62
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2022-2023 Amlogic, Inc. All rights reserved.
+ * Author: Yu Tu <yu.tu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H
+
+#define CLKID_FIXED_PLL_DCO		0
+#define CLKID_FIXED_PLL			1
+#define CLKID_FCLK_DIV2_DIV		2
+#define CLKID_FCLK_DIV2			3
+#define CLKID_FCLK_DIV3_DIV		4
+#define CLKID_FCLK_DIV3			5
+#define CLKID_FCLK_DIV4_DIV		6
+#define CLKID_FCLK_DIV4			7
+#define CLKID_FCLK_DIV5_DIV		8
+#define CLKID_FCLK_DIV5			9
+#define CLKID_FCLK_DIV7_DIV		10
+#define CLKID_FCLK_DIV7			11
+#define CLKID_FCLK_DIV2P5_DIV		12
+#define CLKID_FCLK_DIV2P5		13
+#define CLKID_GP0_PLL_DCO		14
+#define CLKID_GP0_PLL			15
+#define CLKID_HIFI_PLL_DCO		16
+#define CLKID_HIFI_PLL			17
+#define CLKID_HDMI_PLL_DCO		18
+#define CLKID_HDMI_PLL_OD		19
+#define CLKID_HDMI_PLL			20
+#define CLKID_MPLL_50M_DIV		21
+#define CLKID_MPLL_50M			22
+#define CLKID_MPLL_PREDIV		23
+#define CLKID_MPLL0_DIV			24
+#define CLKID_MPLL0			25
+#define CLKID_MPLL1_DIV			26
+#define CLKID_MPLL1			27
+#define CLKID_MPLL2_DIV			28
+#define CLKID_MPLL2			29
+#define CLKID_MPLL3_DIV			30
+#define CLKID_MPLL3			31
+
+#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H */
-- 
2.33.1

