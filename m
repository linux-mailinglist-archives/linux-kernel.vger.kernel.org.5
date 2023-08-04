Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C937701DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHDNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjHDNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:34:54 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F0D1;
        Fri,  4 Aug 2023 06:34:46 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 4E98583BEE;
        Fri,  4 Aug 2023 15:34:45 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 04 Aug 2023 15:32:33 +0200
Subject: [PATCH v3 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230804-pxa1908-lkml-v3-3-8e48fca37099@skole.hr>
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
In-Reply-To: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5011;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=bvGyZPHsdhuC2IA5ya4ZPRAgBo0cHNxoqnND9HvsWdo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBkzP48fJJt2ZRP9BeTpweOZ0vIKbQepsGl5OOS/
 LSN9ejCSM6JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZMz+PAAKCRCaEZ6wQi2W
 4Y6GD/44GWMmWhqZhcpCI75MTPkcWd6sHx+5ODkCsXrMtoChEOqM6fxpTVIAgAEfRY2Siuzeq8s
 DMfBsAIXHHZxzMiqIzprHZP+9ye6iuWLGbdvT72TmLmhJpr/KPBut+FYDW6qSaCXtATXvce1QHr
 QjnH498nGNqmTR2mGnZqRhZzLiJp+VXuEovFECOZlkC6OpSYJayEXAFHblhPkr80ThuKW1C9RPb
 6+RQKuR6aGmirgZ4cpSCvmVjH8zaUIc+Ij9Di6VIu2cRZsNygaNR3RbMG8LcIZyfN8b/DSsF9AO
 vfUIcVgwzJa2tv9aHaEk47/2uSGfswOcuwfamFcS8a0Ent60RBIpi+MeFOPn5Tka0kiEMohTkHP
 Ux8uzNfwglbCRXALO77Gs8Ofnd+eda5pITUERNcZvyQUyVXfVxm8wqtxac8yKl3pHcwksU0/9Pq
 LMhrH6E8V2ZOFcl2FuiZ5L/lm6kdgVN45SVGpXdlhCAxFtZvhtpSk1Xuk3zboLeLvRQax3yfiaW
 WojKTj2vbLQX35SNGWaR38pjCi1VaJVmETGcyp//9OcA/PNQh6TuU/4cpRDNB1UIgvHzPeob8nH
 CHvps/YzFioOZH6V6hH8gS5npO5dsyJ5tW3b5xyGfXqDydOeo86g+waltUANKvKfqsPPrYaBYAm
 Fdwu/KYfyNz+teg==
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

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../devicetree/bindings/clock/marvell,pxa1908.yaml | 48 +++++++++++
 include/dt-bindings/clock/marvell,pxa1908.h        | 92 ++++++++++++++++++++++
 2 files changed, 140 insertions(+)

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
index 000000000000..1fff3bcefd21
--- /dev/null
+++ b/include/dt-bindings/clock/marvell,pxa1908.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
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
+#define PXA1908_MPMU_NR_CLKS		38
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
+#define PXA1908_APBC_NR_CLKS		50
+
+/* apb (apbcp) peripherals */
+#define PXA1908_CLK_UART2		1
+#define PXA1908_CLK_TWSI2		2
+#define PXA1908_CLK_AICER		3
+#define PXA1908_APBCP_NR_CLKS		50
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
+#define PXA1908_APMU_NR_CLKS		50
+
+#endif

-- 
2.41.0


