Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE397806F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378096AbjLFLwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377792AbjLFLwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:52:21 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906F10C3;
        Wed,  6 Dec 2023 03:51:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8B6D77FD6;
        Wed,  6 Dec 2023 19:51:42 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:51:42 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:51:35 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>, <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [PATCH v1 11/16] dt-bindings: clock: Add StarFive JH8100 System-South-West clock and reset generator
Date:   Wed, 6 Dec 2023 19:49:55 +0800
Message-ID: <20231206115000.295825-12-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [175.136.135.142]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the System-South-West clock and reset generator
(SYSCRG-SW) on JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../clock/starfive,jh8100-syscrg-sw.yaml      | 66 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 14 ++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   | 10 +++
 3 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-sw.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-sw.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-sw.yaml
new file mode 100644
index 000000000000..8bd41af040b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-sw.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-syscrg-sw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 System-South-West Clock And Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-syscrg-sw
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB_BUS clock from SYSCRG
+      - description: VDEC_ROOT clock from SYSCRG
+      - description: FLEXNOC1 clock from SYSCRG
+
+  clock-names:
+    items:
+      - const: sys_clk_apb_bus
+      - const: sys_clk_vdec_root
+      - const: sys_clk_flexnoc1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive-jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@12720000 {
+            compatible = "starfive,jh8100-syscrg-sw";
+            reg = <0x12720000 0x10000>;
+            clocks = <&syscrg SYSCRG_CLK_APB_BUS>,
+                     <&syscrg SYSCRG_CLK_VDEC_ROOT>,
+                     <&syscrg SYSCRG_CLK_FLEXNOC1>;
+            clock-names = "sys_clk_apb_bus",
+                          "sys_clk_vdec_root",
+                          "sys_clk_flexnoc1";
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
index b30ccd16a802..3ce0b9ec66be 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -344,4 +344,18 @@
 #define SYSCRG_NE_CLK_SMBUS0_ICG_EN					174
 
 #define SYSCRG_NE_CLK_END						175
+
+/* SYSCRG_SW_CLK */
+#define SYSCRG_SW_CLK_JPEG_AXI						0
+#define SYSCRG_SW_CLK_VC9000DJ_AXI					1
+#define SYSCRG_SW_CLK_VC9000DJ_VDEC					2
+#define SYSCRG_SW_CLK_VC9000DJ_APB					3
+#define SYSCRG_SW_CLK_VDEC_AXI						4
+#define SYSCRG_SW_CLK_VC9000D_AXI					5
+#define SYSCRG_SW_CLK_VC9000D_VDEC					6
+#define SYSCRG_SW_CLK_VC9000D_APB					7
+#define SYSCRG_SW_CLK_JPEG_ICG_EN					8
+#define SYSCRG_SW_CLK_VDEC_ICG_EN					9
+
+#define SYSCRG_SW_CLK_END						10
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
index 7626da648686..55209382e00e 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -96,4 +96,14 @@
 #define SYSCRG_NE_RSTN_DUBHE_TVSENSOR				49
 
 #define SYSCRG_NE_RESET_NR_RESETS				50
+
+/*
+ * syscrg_sw: assert0
+ */
+#define SYSCRG_SW_RSTN_PRESETN					0
+#define SYSCRG_SW_RSTN_VC9000DJ					1
+#define SYSCRG_SW_RSTN_VC9000D					2
+#define SYSCRG_SW_RSTN_DDR_TVSENSOR				3
+
+#define SYSCRG_SW_RESET_NR_RESETS				4
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1

