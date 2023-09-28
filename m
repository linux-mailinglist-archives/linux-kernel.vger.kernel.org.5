Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2987B132A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjI1GgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjI1GgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:36:15 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F01AE;
        Wed, 27 Sep 2023 23:35:21 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 28 Sep 2023
 14:34:59 +0800
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
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH 2/4] dt-bindings: clock: add Amlogic C3 peripherals clock controller bindings
Date:   Thu, 28 Sep 2023 14:34:46 +0800
Message-ID: <20230928063448.3544464-3-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230928063448.3544464-1-xianwei.zhao@amlogic.com>
References: <20230928063448.3544464-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the peripherals clock controller dt-bindings for Amlogic C3 SoC family

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../clock/amlogic,c3-peripherals-clkc.yaml    |  86 +++++++
 .../clock/amlogic,c3-peripherals-clkc.h       | 230 ++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
new file mode 100644
index 000000000000..ec4673714fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,c3-peripherals-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic C serials Peripherals Clock Controller
+
+maintainers:
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
+    minItems: 10
+    items:
+      - description: input oscillator (usually at 24MHz)
+      - description: input fixed pll
+      - description: input fixed pll div2
+      - description: input fixed pll div2p5
+      - description: input fixed pll div3
+      - description: input fixed pll div4
+      - description: input fixed pll div5
+      - description: input fixed pll div7
+      - description: input gp0 pll
+      - description: input hifi pll
+
+  clock-names:
+    minItems: 10
+    items:
+      - const: xtal
+      - const: fixed_pll
+      - const: fclk_div2
+      - const: fclk_div2p5
+      - const: fclk_div3
+      - const: fclk_div4
+      - const: fclk_div5
+      - const: fclk_div7
+      - const: gp0_pll
+      - const: hifi_pll
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
+    clkc_periphs: clock-controller {
+      compatible = "amlogic,c3-peripherals-clkc";
+      #clock-cells = <1>;
+      reg = <0x0 0x0 0x0 0x49c>;
+      clocks = <&xtal>,
+               <&clkc_pll CLKID_FIXED_PLL>,
+               <&clkc_pll CLKID_FCLK_DIV2>,
+               <&clkc_pll CLKID_FCLK_DIV2P5>,
+               <&clkc_pll CLKID_FCLK_DIV3>,
+               <&clkc_pll CLKID_FCLK_DIV4>,
+               <&clkc_pll CLKID_FCLK_DIV5>,
+               <&clkc_pll CLKID_FCLK_DIV7>,
+               <&clkc_pll CLKID_GP0_PLL>,
+               <&clkc_pll CLKID_HIFI_PLL>;
+      clock-names = "xtal",
+                    "fixed_pll",
+                    "fclk_div2",
+                    "fclk_div2p5",
+                    "fclk_div3",
+                    "fclk_div4",
+                    "fclk_div5",
+                    "fclk_div7",
+                    "gp0_pll",
+                    "hifi_pll";
+    };
diff --git a/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
new file mode 100644
index 000000000000..82f9bf683ea0
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
@@ -0,0 +1,230 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
+
+#define CLKID_PLL_IN				0
+#define CLKID_MCLK_PLL_IN			1
+#define CLKID_RTC_XTAL_CLKIN			2
+#define CLKID_RTC_32K_DIV			3
+#define CLKID_RTC_32K_MUX			4
+#define CLKID_RTC_32K				5
+#define CLKID_RTC_CLK				6
+#define CLKID_SYS_A_SEL				7
+#define CLKID_SYS_A_DIV				8
+#define CLKID_SYS_A				9
+#define CLKID_SYS_B_SEL				10
+#define CLKID_SYS_B_DIV				11
+#define CLKID_SYS_B				12
+#define CLKID_SYS_CLK				13
+#define CLKID_AXI_A_SEL				14
+#define CLKID_AXI_A_DIV				15
+#define CLKID_AXI_A				16
+#define CLKID_AXI_B_SEL				17
+#define CLKID_AXI_B_DIV				18
+#define CLKID_AXI_B				19
+#define CLKID_AXI_CLK				20
+#define CLKID_SYS_RESET_CTRL			21
+#define CLKID_SYS_PWR_CTRL			22
+#define CLKID_SYS_PAD_CTRL			23
+#define CLKID_SYS_CTRL				24
+#define CLKID_SYS_TS_PLL			25
+#define CLKID_SYS_DEV_ARB			26
+#define CLKID_SYS_MMC_PCLK			27
+#define CLKID_SYS_CAPU				28
+#define CLKID_SYS_CPU_CTRL			29
+#define CLKID_SYS_JTAG_CTRL			30
+#define CLKID_SYS_IR_CTRL			31
+#define CLKID_SYS_IRQ_CTRL			32
+#define CLKID_SYS_MSR_CLK			33
+#define CLKID_SYS_ROM				34
+#define CLKID_SYS_UART_F			35
+#define CLKID_SYS_CPU_ARB			36
+#define CLKID_SYS_RSA				37
+#define CLKID_SYS_SAR_ADC			38
+#define CLKID_SYS_STARTUP			39
+#define CLKID_SYS_SECURE			40
+#define CLKID_SYS_SPIFC				41
+#define CLKID_SYS_NNA				42
+#define CLKID_SYS_ETH_MAC			43
+#define CLKID_SYS_GIC				44
+#define CLKID_SYS_RAMA				45
+#define CLKID_SYS_BIG_NIC			46
+#define CLKID_SYS_RAMB				47
+#define CLKID_SYS_AUDIO_PCLK			48
+#define CLKID_SYS_PWM_KL			49
+#define CLKID_SYS_PWM_IJ			50
+#define CLKID_SYS_USB				51
+#define CLKID_SYS_SD_EMMC_A			52
+#define CLKID_SYS_SD_EMMC_C			53
+#define CLKID_SYS_PWM_AB			54
+#define CLKID_SYS_PWM_CD			55
+#define CLKID_SYS_PWM_EF			56
+#define CLKID_SYS_PWM_GH			57
+#define CLKID_SYS_SPICC_1			58
+#define CLKID_SYS_SPICC_0			59
+#define CLKID_SYS_UART_A			60
+#define CLKID_SYS_UART_B			61
+#define CLKID_SYS_UART_C			62
+#define CLKID_SYS_UART_D			63
+#define CLKID_SYS_UART_E			64
+#define CLKID_SYS_I2C_M_A			65
+#define CLKID_SYS_I2C_M_B			66
+#define CLKID_SYS_I2C_M_C			67
+#define CLKID_SYS_I2C_M_D			68
+#define CLKID_SYS_I2S_S_A			69
+#define CLKID_SYS_RTC				70
+#define CLKID_SYS_GE2D				71
+#define CLKID_SYS_ISP				72
+#define CLKID_SYS_GPV_ISP_NIC			73
+#define CLKID_SYS_GPV_CVE_NIC			74
+#define CLKID_SYS_MIPI_DSI_HOST			75
+#define CLKID_SYS_MIPI_DSI_PHY			76
+#define CLKID_SYS_ETH_PHY			77
+#define CLKID_SYS_ACODEC			78
+#define CLKID_SYS_DWAP				79
+#define CLKID_SYS_DOS				80
+#define CLKID_SYS_CVE				81
+#define CLKID_SYS_VOUT				82
+#define CLKID_SYS_VC9000E			83
+#define CLKID_SYS_PWM_MN			84
+#define CLKID_SYS_SD_EMMC_B			85
+#define CLKID_AXI_SYS_NIC			86
+#define CLKID_AXI_ISP_NIC			87
+#define CLKID_AXI_CVE_NIC			88
+#define CLKID_AXI_RAMB				89
+#define CLKID_AXI_RAMA				90
+#define CLKID_AXI_CPU_DMC			91
+#define CLKID_AXI_NIC				92
+#define CLKID_AXI_DMA				93
+#define CLKID_AXI_MUX_NIC			94
+#define CLKID_AXI_CAPU				95
+#define CLKID_AXI_CVE				96
+#define CLKID_AXI_DEV1_DMC			97
+#define CLKID_AXI_DEV0_DMC			98
+#define CLKID_AXI_DSP_DMC			99
+#define CLKID_12_24M_IN				100
+#define CLKID_12M_24M				101
+#define CLKID_FCLK_25M_DIV			102
+#define CLKID_FCLK_25M				103
+#define CLKID_GEN_SEL				104
+#define CLKID_GEN_DIV				105
+#define CLKID_GEN				106
+#define CLKID_SARADC_SEL			107
+#define CLKID_SARADC_DIV			108
+#define CLKID_SARADC				109
+#define CLKID_PWM_A_SEL				110
+#define CLKID_PWM_A_DIV				111
+#define CLKID_PWM_A				112
+#define CLKID_PWM_B_SEL				113
+#define CLKID_PWM_B_DIV				114
+#define CLKID_PWM_B				115
+#define CLKID_PWM_C_SEL				116
+#define CLKID_PWM_C_DIV				117
+#define CLKID_PWM_C				118
+#define CLKID_PWM_D_SEL				119
+#define CLKID_PWM_D_DIV				120
+#define CLKID_PWM_D				121
+#define CLKID_PWM_E_SEL				122
+#define CLKID_PWM_E_DIV				123
+#define CLKID_PWM_E				124
+#define CLKID_PWM_F_SEL				125
+#define CLKID_PWM_F_DIV				126
+#define CLKID_PWM_F				127
+#define CLKID_PWM_G_SEL				128
+#define CLKID_PWM_G_DIV				129
+#define CLKID_PWM_G				130
+#define CLKID_PWM_H_SEL				131
+#define CLKID_PWM_H_DIV				132
+#define CLKID_PWM_H				133
+#define CLKID_PWM_I_SEL				134
+#define CLKID_PWM_I_DIV				135
+#define CLKID_PWM_I				136
+#define CLKID_PWM_J_SEL				137
+#define CLKID_PWM_J_DIV				138
+#define CLKID_PWM_J				139
+#define CLKID_PWM_K_SEL				140
+#define CLKID_PWM_K_DIV				141
+#define CLKID_PWM_K				142
+#define CLKID_PWM_L_SEL				143
+#define CLKID_PWM_L_DIV				144
+#define CLKID_PWM_L				145
+#define CLKID_PWM_M_SEL				146
+#define CLKID_PWM_M_DIV				147
+#define CLKID_PWM_M				148
+#define CLKID_PWM_N_SEL				149
+#define CLKID_PWM_N_DIV				150
+#define CLKID_PWM_N				151
+#define CLKID_SPICC_A_SEL			152
+#define CLKID_SPICC_A_DIV			153
+#define CLKID_SPICC_A				154
+#define CLKID_SPICC_B_SEL			155
+#define CLKID_SPICC_B_DIV			156
+#define CLKID_SPICC_B				157
+#define CLKID_SPIFC_SEL				158
+#define CLKID_SPIFC_DIV				159
+#define CLKID_SPIFC				160
+#define CLKID_SD_EMMC_A_SEL			161
+#define CLKID_SD_EMMC_A_DIV			162
+#define CLKID_SD_EMMC_A				163
+#define CLKID_SD_EMMC_B_SEL			164
+#define CLKID_SD_EMMC_B_DIV			165
+#define CLKID_SD_EMMC_B				166
+#define CLKID_SD_EMMC_C_SEL			167
+#define CLKID_SD_EMMC_C_DIV			168
+#define CLKID_SD_EMMC_C				169
+#define CLKID_TS_DIV				170
+#define CLKID_TS				171
+#define CLKID_ETH_125M_DIV			172
+#define CLKID_ETH_125M				173
+#define CLKID_ETH_RMII_DIV			174
+#define CLKID_ETH_RMII				175
+#define CLKID_MIPI_DSI_MEAS_SEL			176
+#define CLKID_MIPI_DSI_MEAS_DIV			177
+#define CLKID_MIPI_DSI_MEAS			178
+#define CLKID_DSI_PHY_SEL			179
+#define CLKID_DSI_PHY_DIV			180
+#define CLKID_DSI_PHY				181
+#define CLKID_VOUT_MCLK_SEL			182
+#define CLKID_VOUT_MCLK_DIV			183
+#define CLKID_VOUT_MCLK				184
+#define CLKID_VOUT_ENC_SEL			185
+#define CLKID_VOUT_ENC_DIV			186
+#define CLKID_VOUT_ENC				187
+#define CLKID_HCODEC_0_SEL			188
+#define CLKID_HCODEC_0_DIV			189
+#define CLKID_HCODEC_0				190
+#define CLKID_HCODEC_1_SEL			191
+#define CLKID_HCODEC_1_DIV			192
+#define CLKID_HCODEC_1				193
+#define CLKID_HCODEC				194
+#define CLKID_VC9000E_ACLK_SEL			195
+#define CLKID_VC9000E_ACLK_DIV			196
+#define CLKID_VC9000E_ACLK			197
+#define CLKID_VC9000E_CORE_SEL			198
+#define CLKID_VC9000E_CORE_DIV			199
+#define CLKID_VC9000E_CORE			200
+#define CLKID_CSI_PHY0_SEL			201
+#define CLKID_CSI_PHY0_DIV			202
+#define CLKID_CSI_PHY0				203
+#define CLKID_DEWARPA_SEL			204
+#define CLKID_DEWARPA_DIV			205
+#define CLKID_DEWARPA				206
+#define CLKID_ISP0_SEL				207
+#define CLKID_ISP0_DIV				208
+#define CLKID_ISP0				209
+#define CLKID_NNA_CORE_SEL			210
+#define CLKID_NNA_CORE_DIV			211
+#define CLKID_NNA_CORE				212
+#define CLKID_GE2D_SEL				213
+#define CLKID_GE2D_DIV				214
+#define CLKID_GE2D				215
+#define CLKID_VAPB_SEL				216
+#define CLKID_VAPB_DIV				217
+#define CLKID_VAPB				218
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H */
-- 
2.37.1

