Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7975D635
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGUVMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGUVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:12:03 -0400
X-Greylist: delayed 340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 14:11:57 PDT
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D19B30ED;
        Fri, 21 Jul 2023 14:11:57 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id D31C586D1D;
        Fri, 21 Jul 2023 23:06:12 +0200 (CEST)
From:   =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Subject: [PATCH 05/10] dt-bindings: clock: Add Marvell PXA1908 clock bindings
Date:   Fri, 21 Jul 2023 22:37:47 +0200
Message-ID: <20230721210042.21535-6-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721210042.21535-1-duje.mihanovic@skole.hr>
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dt bindings for Marvell PXA1908 clock controller.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 include/dt-bindings/clock/marvell,pxa1908.h | 93 +++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 include/dt-bindings/clock/marvell,pxa1908.h

diff --git a/include/dt-bindings/clock/marvell,pxa1908.h b/include/dt-bindings/clock/marvell,pxa1908.h
new file mode 100644
index 000000000000..da9c5d499ae4
--- /dev/null
+++ b/include/dt-bindings/clock/marvell,pxa1908.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __DTS_MARVELL_PXA1908_CLOCK_H
+#define __DTS_MARVELL_PXA1908_CLOCK_H
+
+/* plls */
+#define PXA1908_CLK_CLK32		0x1
+#define PXA1908_CLK_VCTCXO		0x2
+#define PXA1908_CLK_PLL1_624		0x3
+#define PXA1908_CLK_PLL1_416		0x4
+#define PXA1908_CLK_PLL1_499		0x5
+#define PXA1908_CLK_PLL1_832		0x6
+#define PXA1908_CLK_PLL1_1248		0x7
+#define PXA1908_CLK_PLL1_D2		0x8
+#define PXA1908_CLK_PLL1_D4		0x9
+#define PXA1908_CLK_PLL1_D8		0xa
+#define PXA1908_CLK_PLL1_D16		0xb
+#define PXA1908_CLK_PLL1_D6		0xc
+#define PXA1908_CLK_PLL1_D12		0xd
+#define PXA1908_CLK_PLL1_D24		0xe
+#define PXA1908_CLK_PLL1_D48		0xf
+#define PXA1908_CLK_PLL1_D96		0x10
+#define PXA1908_CLK_PLL1_D13		0x11
+#define PXA1908_CLK_PLL1_32		0x12
+#define PXA1908_CLK_PLL1_208		0x13
+#define PXA1908_CLK_PLL1_117		0x14
+#define PXA1908_CLK_PLL1_416_GATE	0x15
+#define PXA1908_CLK_PLL1_624_GATE	0x16
+#define PXA1908_CLK_PLL1_832_GATE	0x17
+#define PXA1908_CLK_PLL1_1248_GATE	0x18
+#define PXA1908_CLK_PLL1_D2_GATE	0x19
+#define PXA1908_CLK_PLL1_499_EN		0x1a
+#define PXA1908_CLK_PLL2VCO		0x1b
+#define PXA1908_CLK_PLL2		0x1c
+#define PXA1908_CLK_PLL2P		0x1d
+#define PXA1908_CLK_PLL2VCODIV3		0x1e
+#define PXA1908_CLK_PLL3VCO		0x1f
+#define PXA1908_CLK_PLL3		0x20
+#define PXA1908_CLK_PLL3P		0x21
+#define PXA1908_CLK_PLL3VCODIV3		0x22
+#define PXA1908_CLK_PLL4VCO		0x23
+#define PXA1908_CLK_PLL4		0x24
+#define PXA1908_CLK_PLL4P		0x25
+#define PXA1908_CLK_PLL4VCODIV3		0x26
+#define PXA1908_MPMU_NR_CLKS		38
+
+/* apb (apbc) peripherals */
+#define PXA1908_CLK_UART0		0x1
+#define PXA1908_CLK_UART1		0x2
+#define PXA1908_CLK_GPIO		0x3
+#define PXA1908_CLK_PWM0		0x4
+#define PXA1908_CLK_PWM1		0x5
+#define PXA1908_CLK_PWM2		0x6
+#define PXA1908_CLK_PWM3		0x7
+#define PXA1908_CLK_SSP0		0x8
+#define PXA1908_CLK_SSP1		0x9
+#define PXA1908_CLK_IPC_RST		0xa
+#define PXA1908_CLK_RTC			0xb
+#define PXA1908_CLK_TWSI0		0xc
+#define PXA1908_CLK_KPC			0xd
+#define PXA1908_CLK_SWJTAG		0x11
+#define PXA1908_CLK_SSP2		0x14
+#define PXA1908_CLK_TWSI1		0x19
+#define PXA1908_CLK_THERMAL		0x1c
+#define PXA1908_CLK_TWSI3		0x1d
+#define PXA1908_APBC_NR_CLKS		0x30
+
+/* apb (apbcp) peripherals */
+#define PXA1908_CLK_UART2		0x7
+#define PXA1908_CLK_TWSI2		0xa
+#define PXA1908_CLK_AICER		0xe
+#define PXA1908_APBCP_NR_CLKS		0xe
+
+/* axi (apmu) peripherals */
+#define PXA1908_CLK_CCIC1		0x9
+#define PXA1908_CLK_ISP			0xe
+#define PXA1908_CLK_GATE_CTRL		0x10
+#define PXA1908_CLK_DSI1		0x11
+#define PXA1908_CLK_DISP1		0x13
+#define PXA1908_CLK_CCIC0		0x14
+#define PXA1908_CLK_SDH0		0x15
+#define PXA1908_CLK_SDH1		0x16
+#define PXA1908_CLK_SDH2		0x38
+#define PXA1908_CLK_USB			0x17
+#define PXA1908_CLK_NF			0x18
+#define PXA1908_CLK_CORE_DEBUG		0x24
+#define PXA1908_CLK_VPU			0x29
+#define PXA1908_CLK_GC			0x51
+#define PXA1908_CLK_GC2D		0x3d
+#define PXA1908_CLK_TRACE		0x42
+#define PXA1908_CLK_DVC_DFC_DEBUG	0x50
+#define PXA1908_APMU_NR_CLKS		0x60
+
+#endif
-- 
2.41.0


