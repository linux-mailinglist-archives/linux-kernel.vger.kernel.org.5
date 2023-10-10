Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B207C02A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjJJR1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjJJR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:27:40 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3D93;
        Tue, 10 Oct 2023 10:27:38 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id B5C838516A;
        Tue, 10 Oct 2023 19:27:36 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Tue, 10 Oct 2023 19:27:21 +0200
Subject: [PATCH v6 4/9] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-pxa1908-lkml-v6-4-b2fe09240cf8@skole.hr>
References: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
In-Reply-To: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4927;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=TlG0VLv0pzCYmcMvi3T5+D0/zIGO/YXSblFLjN8kznw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJYl41Swe9nH2p6V586V4Gr6z3SEexgUANloI1
 aGjsKt1ThmJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSWJeAAKCRCaEZ6wQi2W
 4S5iD/9ZyP2KWs7zbwU33mli9CRYqP6stjwRNLrPq6kMZLwZoa0AmO5WPgK9LLwCNsUVdgtp58X
 g/pv3frwinebyXqXjJ7bFEMi56IYQ8ojLblD4cKvtySYAWuTC0inU8YCI1o9EJIexIhUnIMeWo4
 IDxbv4vQRS5tqEeUgWoGekIq07rWRuMfQFPHE8XSBx7QiwkPfaA0Zyt+wtuWYRq599zxK7JqCFM
 VUQMme24Wna9Q4h8JbYiLiD1J2GEgCXvPtqyqpfkE5W6TJGhPUCfke6bnJnTygj9l5X51XyQ+fm
 RLwtmbDJLRqTWVYS9oCfcv1s21r5SPHGS7XpsE+D+foKlejpdZII0hHjJ9QH+aEvnmZDaG+DBJ3
 NGo1UMkkfnnMLk5vnY1miEU9rC4gcHqjDiUkHT3OtWMq2hv8VUsB5/UmURZ5MpqD1pxOesFpbAi
 wvHiK5QWEREDDdY8aGXTYgfOi+UpSM/5/QqnCq41kjZNshzJREaLIbZo2CKh8OmCA8OKOg1qWJ9
 JzrzPMzjegyRkneGhUsGXxfzQNRDa4rthUkwdQKsfpTwN6QryiSzow/DvlWtlTIyUw9Tc5PPggM
 1Spm34ImWWhJk2DloQeuSWemd6ERaub9WRVfxOLuuApI0hj/GEuJP2VSkofhAtdHl95tPG5RvOd
 wucSOwy6zmoBP9g==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings and documentation for the Marvell PXA1908 clock
controller.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../devicetree/bindings/clock/marvell,pxa1908.yaml | 48 ++++++++++++
 include/dt-bindings/clock/marvell,pxa1908.h        | 88 ++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
new file mode 100644
index 000000000000..4e78933232b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/marvell,pxa1908.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA1908 Clock Controllers
+
+maintainers:
+  - Duje Mihanović <duje.mihanovic@skole.hr>
+
+description: |
+  The PXA1908 clock subsystem generates and supplies clock to various
+  controllers within the PXA1908 SoC. The PXA1908 contains numerous clock
+  controller blocks, with the ones currently supported being APBC, APBCP, MPMU
+  and APMU roughly corresponding to internal buses.
+
+  All these clock identifiers could be found in <include/dt-bindings/marvell,pxa1908.h>.
+
+properties:
+  compatible:
+    enum:
+      - marvell,pxa1908-apbc
+      - marvell,pxa1908-apbcp
+      - marvell,pxa1908-mpmu
+      - marvell,pxa1908-apmu
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # APMU block:
+  - |
+    clock-controller@d4282800 {
+      compatible = "marvell,pxa1908-apmu";
+      reg = <0xd4282800 0x400>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/marvell,pxa1908.h b/include/dt-bindings/clock/marvell,pxa1908.h
new file mode 100644
index 000000000000..fb15b0d0cd4c
--- /dev/null
+++ b/include/dt-bindings/clock/marvell,pxa1908.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef __DTS_MARVELL_PXA1908_CLOCK_H
+#define __DTS_MARVELL_PXA1908_CLOCK_H
+
+/* plls */
+#define PXA1908_CLK_CLK32		1
+#define PXA1908_CLK_VCTCXO		2
+#define PXA1908_CLK_PLL1_624		3
+#define PXA1908_CLK_PLL1_416		4
+#define PXA1908_CLK_PLL1_499		5
+#define PXA1908_CLK_PLL1_832		6
+#define PXA1908_CLK_PLL1_1248		7
+#define PXA1908_CLK_PLL1_D2		8
+#define PXA1908_CLK_PLL1_D4		9
+#define PXA1908_CLK_PLL1_D8		10
+#define PXA1908_CLK_PLL1_D16		11
+#define PXA1908_CLK_PLL1_D6		12
+#define PXA1908_CLK_PLL1_D12		13
+#define PXA1908_CLK_PLL1_D24		14
+#define PXA1908_CLK_PLL1_D48		15
+#define PXA1908_CLK_PLL1_D96		16
+#define PXA1908_CLK_PLL1_D13		17
+#define PXA1908_CLK_PLL1_32		18
+#define PXA1908_CLK_PLL1_208		19
+#define PXA1908_CLK_PLL1_117		20
+#define PXA1908_CLK_PLL1_416_GATE	21
+#define PXA1908_CLK_PLL1_624_GATE	22
+#define PXA1908_CLK_PLL1_832_GATE	23
+#define PXA1908_CLK_PLL1_1248_GATE	24
+#define PXA1908_CLK_PLL1_D2_GATE	25
+#define PXA1908_CLK_PLL1_499_EN		26
+#define PXA1908_CLK_PLL2VCO		27
+#define PXA1908_CLK_PLL2		28
+#define PXA1908_CLK_PLL2P		29
+#define PXA1908_CLK_PLL2VCODIV3		30
+#define PXA1908_CLK_PLL3VCO		31
+#define PXA1908_CLK_PLL3		32
+#define PXA1908_CLK_PLL3P		33
+#define PXA1908_CLK_PLL3VCODIV3		34
+#define PXA1908_CLK_PLL4VCO		35
+#define PXA1908_CLK_PLL4		36
+#define PXA1908_CLK_PLL4P		37
+#define PXA1908_CLK_PLL4VCODIV3		38
+
+/* apb (apbc) peripherals */
+#define PXA1908_CLK_UART0		1
+#define PXA1908_CLK_UART1		2
+#define PXA1908_CLK_GPIO		3
+#define PXA1908_CLK_PWM0		4
+#define PXA1908_CLK_PWM1		5
+#define PXA1908_CLK_PWM2		6
+#define PXA1908_CLK_PWM3		7
+#define PXA1908_CLK_SSP0		8
+#define PXA1908_CLK_SSP1		9
+#define PXA1908_CLK_IPC_RST		10
+#define PXA1908_CLK_RTC			11
+#define PXA1908_CLK_TWSI0		12
+#define PXA1908_CLK_KPC			13
+#define PXA1908_CLK_SWJTAG		14
+#define PXA1908_CLK_SSP2		15
+#define PXA1908_CLK_TWSI1		16
+#define PXA1908_CLK_THERMAL		17
+#define PXA1908_CLK_TWSI3		18
+
+/* apb (apbcp) peripherals */
+#define PXA1908_CLK_UART2		1
+#define PXA1908_CLK_TWSI2		2
+#define PXA1908_CLK_AICER		3
+
+/* axi (apmu) peripherals */
+#define PXA1908_CLK_CCIC1		1
+#define PXA1908_CLK_ISP			2
+#define PXA1908_CLK_DSI1		3
+#define PXA1908_CLK_DISP1		4
+#define PXA1908_CLK_CCIC0		5
+#define PXA1908_CLK_SDH0		6
+#define PXA1908_CLK_SDH1		7
+#define PXA1908_CLK_USB			8
+#define PXA1908_CLK_NF			9
+#define PXA1908_CLK_CORE_DEBUG		10
+#define PXA1908_CLK_VPU			11
+#define PXA1908_CLK_GC			12
+#define PXA1908_CLK_SDH2		13
+#define PXA1908_CLK_GC2D		14
+#define PXA1908_CLK_TRACE		15
+#define PXA1908_CLK_DVC_DFC_DEBUG	16
+
+#endif

-- 
2.42.0


