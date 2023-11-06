Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F57E1CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjKFI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjKFI5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:57:03 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87DCC;
        Mon,  6 Nov 2023 00:56:13 -0800 (PST)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 6 Nov 2023
 16:56:10 +0800
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
Subject: [PATCH V6 2/4] dt-bindings: clock: add Amlogic C3 peripherals clock controller bindings
Date:   Mon, 6 Nov 2023 16:55:52 +0800
Message-ID: <20231106085554.3237511-3-xianwei.zhao@amlogic.com>
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

Add the peripherals clock controller dt-bindings for Amlogic C3 SoC family

Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../clock/amlogic,c3-peripherals-clkc.yaml    | 104 ++++++++
 .../clock/amlogic,c3-peripherals-clkc.h       | 237 ++++++++++++++++++
 2 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
new file mode 100644
index 000000000000..af1807dfa94a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,c3-peripherals-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic C3 Serials Peripheral Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Chuan Liu <chuan.liu@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,c3-peripherals-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 12
+    items:
+      - description: input oscillator (usually at 24MHz)
+      - description: input oscillator (usually at 32KHz)
+      - description: input Fix PLL
+      - description: input Fclk div 2
+      - description: input Fclk div 2p5
+      - description: input Fclk div 3
+      - description: input Fclk div 4
+      - description: input Fclk div 5
+      - description: input Fclk div 7
+      - description: input gp0 pll
+      - description: input gp1 pll
+      - description: input hifi pll
+      - description: input pad clock for rtc_clk (optional)
+
+  clock-names:
+    minItems: 12
+    items:
+      - const: xtal_24m
+      - const: xtal_32k
+      - const: fix
+      - const: fdiv2
+      - const: fdiv2p5
+      - const: fdiv3
+      - const: fdiv4
+      - const: fdiv5
+      - const: fdiv7
+      - const: gp0
+      - const: gp1
+      - const: hifi
+      - const: pad
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
+        clock-controller@0 {
+            compatible = "amlogic,c3-peripherals-clkc";
+            reg = <0x0 0x0 0x0 0x49c>;
+            #clock-cells = <1>;
+            clocks = <&xtal_24m>,
+                     <&xtal_32k>,
+                     <&clkc_pll 1>,
+                     <&clkc_pll 5>,
+                     <&clkc_pll 7>,
+                     <&clkc_pll 9>,
+                     <&clkc_pll 11>,
+                     <&clkc_pll 13>,
+                     <&clkc_pll 15>,
+                     <&clkc_pll 17>,
+                     <&clkc_pll 19>,
+                     <&clkc_pll 21>;
+            clock-names = "xtal_24m",
+                          "xtal_32k",
+                          "fix",
+                          "fdiv2",
+                          "fdiv2p5",
+                          "fdiv3",
+                          "fdiv4",
+                          "fdiv5",
+                          "fdiv7",
+                          "gp0",
+                          "gp1",
+                          "hifi";
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
new file mode 100644
index 000000000000..0175d8b9b32b
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
+
+#define CLKID_PLL_SRC				0
+#define CLKID_MCLK_PLL_SRC			1
+#define CLKID_DDR_PLL_SRC			2
+#define CLKID_DDR_PHY_SRC                       3
+#define CLKID_USB_PLL_SRC                       4
+#define CLKID_MIPI_ISP_VOUT_SRC                 5
+#define CLKID_USB_CTRL_SRC                      6
+#define CLKID_ETH_PLL_SRC                       7
+#define CLKID_CTS_OSC_SRC                       8
+#define CLKID_RTC_XTAL_CLKIN			9
+#define CLKID_RTC_32K_DIV			10
+#define CLKID_RTC_32K_MUX			11
+#define CLKID_RTC_32K				12
+#define CLKID_RTC_CLK				13
+#define CLKID_SYS_A_SEL				14
+#define CLKID_SYS_A_DIV				15
+#define CLKID_SYS_A				16
+#define CLKID_SYS_B_SEL				17
+#define CLKID_SYS_B_DIV				18
+#define CLKID_SYS_B				19
+#define CLKID_SYS_CLK				20
+#define CLKID_AXI_A_SEL				21
+#define CLKID_AXI_A_DIV				22
+#define CLKID_AXI_A				23
+#define CLKID_AXI_B_SEL				24
+#define CLKID_AXI_B_DIV				25
+#define CLKID_AXI_B				26
+#define CLKID_AXI_CLK				27
+#define CLKID_SYS_RESET_CTRL			28
+#define CLKID_SYS_PWR_CTRL			29
+#define CLKID_SYS_PAD_CTRL			30
+#define CLKID_SYS_CTRL				31
+#define CLKID_SYS_TS_PLL			32
+#define CLKID_SYS_DEV_ARB			33
+#define CLKID_SYS_MMC_PCLK			34
+#define CLKID_SYS_CAPU				35
+#define CLKID_SYS_CPU_CTRL			36
+#define CLKID_SYS_JTAG_CTRL			37
+#define CLKID_SYS_IR_CTRL			38
+#define CLKID_SYS_IRQ_CTRL			39
+#define CLKID_SYS_MSR_CLK			40
+#define CLKID_SYS_ROM				41
+#define CLKID_SYS_UART_F			42
+#define CLKID_SYS_CPU_ARB			43
+#define CLKID_SYS_RSA				44
+#define CLKID_SYS_SAR_ADC			45
+#define CLKID_SYS_STARTUP			46
+#define CLKID_SYS_SECURE			47
+#define CLKID_SYS_SPIFC				48
+#define CLKID_SYS_NNA				49
+#define CLKID_SYS_ETH_MAC			50
+#define CLKID_SYS_GIC				51
+#define CLKID_SYS_RAMA				52
+#define CLKID_SYS_BIG_NIC			53
+#define CLKID_SYS_RAMB				54
+#define CLKID_SYS_AUDIO_PCLK			55
+#define CLKID_SYS_PWM_KL			56
+#define CLKID_SYS_PWM_IJ			57
+#define CLKID_SYS_USB				58
+#define CLKID_SYS_SD_EMMC_A			59
+#define CLKID_SYS_SD_EMMC_C			60
+#define CLKID_SYS_PWM_AB			61
+#define CLKID_SYS_PWM_CD			62
+#define CLKID_SYS_PWM_EF			63
+#define CLKID_SYS_PWM_GH			64
+#define CLKID_SYS_SPICC_1			65
+#define CLKID_SYS_SPICC_0			66
+#define CLKID_SYS_UART_A			67
+#define CLKID_SYS_UART_B			68
+#define CLKID_SYS_UART_C			69
+#define CLKID_SYS_UART_D			70
+#define CLKID_SYS_UART_E			71
+#define CLKID_SYS_I2C_M_A			72
+#define CLKID_SYS_I2C_M_B			73
+#define CLKID_SYS_I2C_M_C			74
+#define CLKID_SYS_I2C_M_D			75
+#define CLKID_SYS_I2S_S_A			76
+#define CLKID_SYS_RTC				77
+#define CLKID_SYS_GE2D				78
+#define CLKID_SYS_ISP				79
+#define CLKID_SYS_GPV_ISP_NIC			80
+#define CLKID_SYS_GPV_CVE_NIC			81
+#define CLKID_SYS_MIPI_DSI_HOST			82
+#define CLKID_SYS_MIPI_DSI_PHY			83
+#define CLKID_SYS_ETH_PHY			84
+#define CLKID_SYS_ACODEC			85
+#define CLKID_SYS_DWAP				86
+#define CLKID_SYS_DOS				87
+#define CLKID_SYS_CVE				88
+#define CLKID_SYS_VOUT				89
+#define CLKID_SYS_VC9000E			90
+#define CLKID_SYS_PWM_MN			91
+#define CLKID_SYS_SD_EMMC_B			92
+#define CLKID_AXI_SYS_NIC			93
+#define CLKID_AXI_ISP_NIC			94
+#define CLKID_AXI_CVE_NIC			95
+#define CLKID_AXI_RAMB				96
+#define CLKID_AXI_RAMA				97
+#define CLKID_AXI_CPU_DMC			98
+#define CLKID_AXI_NIC				99
+#define CLKID_AXI_DMA				100
+#define CLKID_AXI_MUX_NIC			101
+#define CLKID_AXI_CAPU				102
+#define CLKID_AXI_CVE				103
+#define CLKID_AXI_DEV1_DMC			104
+#define CLKID_AXI_DEV0_DMC			105
+#define CLKID_AXI_DSP_DMC			106
+#define CLKID_12_24M_IN				107
+#define CLKID_12M_24M				108
+#define CLKID_FCLK_25M_DIV			109
+#define CLKID_FCLK_25M				110
+#define CLKID_GEN_SEL				111
+#define CLKID_GEN_DIV				112
+#define CLKID_GEN				113
+#define CLKID_SARADC_SEL			114
+#define CLKID_SARADC_DIV			115
+#define CLKID_SARADC				116
+#define CLKID_PWM_A_SEL				117
+#define CLKID_PWM_A_DIV				118
+#define CLKID_PWM_A				119
+#define CLKID_PWM_B_SEL				120
+#define CLKID_PWM_B_DIV				121
+#define CLKID_PWM_B				122
+#define CLKID_PWM_C_SEL				123
+#define CLKID_PWM_C_DIV				124
+#define CLKID_PWM_C				125
+#define CLKID_PWM_D_SEL				126
+#define CLKID_PWM_D_DIV				127
+#define CLKID_PWM_D				128
+#define CLKID_PWM_E_SEL				129
+#define CLKID_PWM_E_DIV				130
+#define CLKID_PWM_E				131
+#define CLKID_PWM_F_SEL				132
+#define CLKID_PWM_F_DIV				133
+#define CLKID_PWM_F				134
+#define CLKID_PWM_G_SEL				135
+#define CLKID_PWM_G_DIV				136
+#define CLKID_PWM_G				137
+#define CLKID_PWM_H_SEL				138
+#define CLKID_PWM_H_DIV				139
+#define CLKID_PWM_H				140
+#define CLKID_PWM_I_SEL				141
+#define CLKID_PWM_I_DIV				142
+#define CLKID_PWM_I				143
+#define CLKID_PWM_J_SEL				144
+#define CLKID_PWM_J_DIV				145
+#define CLKID_PWM_J				146
+#define CLKID_PWM_K_SEL				147
+#define CLKID_PWM_K_DIV				148
+#define CLKID_PWM_K				149
+#define CLKID_PWM_L_SEL				150
+#define CLKID_PWM_L_DIV				151
+#define CLKID_PWM_L				152
+#define CLKID_PWM_M_SEL				153
+#define CLKID_PWM_M_DIV				154
+#define CLKID_PWM_M				155
+#define CLKID_PWM_N_SEL				156
+#define CLKID_PWM_N_DIV				157
+#define CLKID_PWM_N				158
+#define CLKID_SPICC_A_SEL			159
+#define CLKID_SPICC_A_DIV			160
+#define CLKID_SPICC_A				161
+#define CLKID_SPICC_B_SEL			162
+#define CLKID_SPICC_B_DIV			163
+#define CLKID_SPICC_B				164
+#define CLKID_SPIFC_SEL				165
+#define CLKID_SPIFC_DIV				166
+#define CLKID_SPIFC				167
+#define CLKID_SD_EMMC_A_SEL			168
+#define CLKID_SD_EMMC_A_DIV			169
+#define CLKID_SD_EMMC_A				170
+#define CLKID_SD_EMMC_B_SEL			171
+#define CLKID_SD_EMMC_B_DIV			172
+#define CLKID_SD_EMMC_B				173
+#define CLKID_SD_EMMC_C_SEL			174
+#define CLKID_SD_EMMC_C_DIV			175
+#define CLKID_SD_EMMC_C				176
+#define CLKID_TS_DIV				177
+#define CLKID_TS				178
+#define CLKID_ETH_125M_DIV			179
+#define CLKID_ETH_125M				180
+#define CLKID_ETH_RMII_DIV			181
+#define CLKID_ETH_RMII				182
+#define CLKID_MIPI_DSI_MEAS_SEL			183
+#define CLKID_MIPI_DSI_MEAS_DIV			184
+#define CLKID_MIPI_DSI_MEAS			185
+#define CLKID_DSI_PHY_SEL			186
+#define CLKID_DSI_PHY_DIV			187
+#define CLKID_DSI_PHY				188
+#define CLKID_VOUT_MCLK_SEL			189
+#define CLKID_VOUT_MCLK_DIV			190
+#define CLKID_VOUT_MCLK				191
+#define CLKID_VOUT_ENC_SEL			192
+#define CLKID_VOUT_ENC_DIV			193
+#define CLKID_VOUT_ENC				194
+#define CLKID_HCODEC_0_SEL			195
+#define CLKID_HCODEC_0_DIV			196
+#define CLKID_HCODEC_0				197
+#define CLKID_HCODEC_1_SEL			198
+#define CLKID_HCODEC_1_DIV			199
+#define CLKID_HCODEC_1				200
+#define CLKID_HCODEC				201
+#define CLKID_VC9000E_ACLK_SEL			202
+#define CLKID_VC9000E_ACLK_DIV			203
+#define CLKID_VC9000E_ACLK			204
+#define CLKID_VC9000E_CORE_SEL			205
+#define CLKID_VC9000E_CORE_DIV			206
+#define CLKID_VC9000E_CORE			207
+#define CLKID_CSI_PHY0_SEL			208
+#define CLKID_CSI_PHY0_DIV			209
+#define CLKID_CSI_PHY0				210
+#define CLKID_DEWARPA_SEL			211
+#define CLKID_DEWARPA_DIV			212
+#define CLKID_DEWARPA				213
+#define CLKID_ISP0_SEL				214
+#define CLKID_ISP0_DIV				215
+#define CLKID_ISP0				216
+#define CLKID_NNA_CORE_SEL			217
+#define CLKID_NNA_CORE_DIV			218
+#define CLKID_NNA_CORE				219
+#define CLKID_GE2D_SEL				220
+#define CLKID_GE2D_DIV				221
+#define CLKID_GE2D				222
+#define CLKID_VAPB_SEL				223
+#define CLKID_VAPB_DIV				224
+#define CLKID_VAPB				225
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H */
-- 
2.39.2

