Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E296D758D78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGSGK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGSGK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:10:56 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31141FC8;
        Tue, 18 Jul 2023 23:10:03 -0700 (PDT)
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 19 Jul 2023
 14:09:51 +0800
From:   zelong dong <zelong.dong@amlogic.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <kelvin.zhang@amlogic.com>,
        Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings for Amlogic C3 Reset Controller
Date:   Wed, 19 Jul 2023 14:09:52 +0800
Message-ID: <20230719060954.14864-2-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230719060954.14864-1-zelong.dong@amlogic.com>
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.69]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelong Dong <zelong.dong@amlogic.com>

Add new compatible and DT bindings for Amlogic C3 Reset Controller

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
 include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index d3fdee89d4f8..f0c6c0df0ce3 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -18,6 +18,7 @@ properties:
       - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
       - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
       - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
+      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
new file mode 100644
index 000000000000..d9127863f603
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,c3-reset.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_C3_RESET_H
+#define _DT_BINDINGS_AMLOGIC_C3_RESET_H
+
+/* RESET0 */
+/*						0-3 */
+#define RESET_USBCTRL				4
+/*						5-7 */
+#define RESET_USBPHY20				8
+/*						9 */
+#define RESET_USB2DRD				10
+#define RESET_MIPI_DSI_HOST			11
+#define RESET_MIPI_DSI_PHY			12
+/*						13-20 */
+#define RESET_GE2D				21
+#define RESET_DWAP				22
+/*						23-31 */
+
+/* RESET1 */
+#define RESET_AUDIO				32
+/*						33-34 */
+#define RESET_DDRAPB				35
+#define RESET_DDR				36
+#define RESET_DOS_CAPB3				37
+#define RESET_DOS				38
+/*						39-46 */
+#define RESET_NNA				47
+#define RESET_ETHERNET				48
+#define RESET_ISP				49
+#define RESET_VC9000E_APB			50
+#define RESET_VC9000E_A				51
+/*						52 */
+#define RESET_VC9000E_CORE			53
+/*						54-63 */
+
+/* RESET2 */
+#define RESET_ABUS_ARB				64
+#define RESET_IRCTRL				65
+/*						66 */
+#define RESET_TEMP_PII				67
+/*						68-72 */
+#define RESET_SPICC_0				73
+#define RESET_SPICC_1				74
+#define RESET_RSA				75
+
+/*						76-79 */
+#define RESET_MSR_CLK				80
+#define RESET_SPIFC				81
+#define RESET_SAR_ADC				82
+/*						83-87 */
+#define RESET_ACODEC				88
+/*						89-90 */
+#define RESET_WATCHDOG				91
+/*						92-95 */
+
+/* RESET3 */
+#define RESET_ISP_NIC_GPV			96
+#define RESET_ISP_NIC_MAIN			97
+#define RESET_ISP_NIC_VCLK			98
+#define RESET_ISP_NIC_VOUT			99
+#define RESET_ISP_NIC_ALL			100
+#define RESET_VOUT				101
+#define RESET_VOUT_VENC				102
+/*						103 */
+#define RESET_CVE_NIC_GPV			104
+#define RESET_CVE_NIC_MAIN			105
+#define RESET_CVE_NIC_GE2D			106
+#define RESET_CVE_NIC_DW			106
+#define RESET_CVE_NIC_CVE			108
+#define RESET_CVE_NIC_ALL			109
+#define RESET_CVE				110
+/*						112-127 */
+
+/* RESET4 */
+#define RESET_RTC				128
+#define RESET_PWM_AB				129
+#define RESET_PWM_CD				130
+#define RESET_PWM_EF				131
+#define RESET_PWM_GH				132
+#define RESET_PWM_IJ				133
+#define RESET_PWM_KL				134
+#define RESET_PWM_MN				135
+/*						136-137 */
+#define RESET_UART_A				138
+#define RESET_UART_B				139
+#define RESET_UART_C				140
+#define RESET_UART_D				141
+#define RESET_UART_E				142
+#define RESET_UART_F				143
+#define RESET_I2C_S_A				144
+#define RESET_I2C_M_A				145
+#define RESET_I2C_M_B				146
+#define RESET_I2C_M_C				147
+#define RESET_I2C_M_D				148
+/*						149-151 */
+#define RESET_SD_EMMC_A				152
+#define RESET_SD_EMMC_B				153
+#define RESET_SD_EMMC_C				154
+
+/* RESET5 */
+/*						160-172 */
+#define RESET_BRG_NIC_NNA			173
+#define RESET_BRG_MUX_NIC_MAIN			174
+#define RESET_BRG_AO_NIC_ALL			175
+/*						176-183 */
+#define RESET_BRG_NIC_VAPB			184
+#define RESET_BRG_NIC_SDIO_B			185
+#define RESET_BRG_NIC_SDIO_A			186
+#define RESET_BRG_NIC_EMMC			187
+#define RESET_BRG_NIC_DSU			188
+#define RESET_BRG_NIC_SYSCLK			189
+#define RESET_BRG_NIC_MAIN			190
+#define RESET_BRG_NIC_ALL			191
+
+#endif
-- 
2.35.1

