Return-Path: <linux-kernel+bounces-124318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2BE89159E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715902849EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73A3FBBC;
	Fri, 29 Mar 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg3xu9IY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F73A1B6;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703855; cv=none; b=Ubu0Y+Xm0843oDjRTp16BXJuck9EkhZORrsxIfhILJu3iTGmhiEly0EDvzN+HaR59Rxpa5VCLI+KC1K7LYTj9mwybBpss5JqAzeXHUj9D5ehUg2FgQJDMTQ71Le8zz2inp8KvlYjluhlXPz+g++fu2FEJewJI9OGfxwVnOlnnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703855; c=relaxed/simple;
	bh=wTTt2oWAUpdvp/Jby37qhdU7Cy3yJY7C1pEsGj2HtOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwr0P1h39kg1YEufpBgIlOJmqhBsLzo8EmZhfbC1rvd1RVNByurL9PkyWZiyRDd3KznU1FMRm9j/P5LL1vbmgrewsBJlgvnesk/D9a+/xNMTrPVhD8oj0R0Sd3iksjkVPFdnNvrlD8jzH7rt6BUhE15N/biKeQVVCQ7VfB9gjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg3xu9IY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49129C43390;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703855;
	bh=wTTt2oWAUpdvp/Jby37qhdU7Cy3yJY7C1pEsGj2HtOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zg3xu9IYVljLLYwSeJi1feRS2ECt6TwFeLOKnwsR7kOaN+8YBDyPtL3arb/eqcyWz
	 1MurpMUNiBy8pr6fSAoc76ZgyTM72lrSc4c3zj5tg6DxorcLnCIlh26zaQSdDiephO
	 +1CkjVGqQ27FuAnufeOOWvh2pxbQQLpC4Iu3zaM3FG5n70tzdJYqQBH3uBgFsN9mlJ
	 MwNWc0ofb1NjATJrnVw6RII3vvupG/temK4nn8xgY1K7t8ugwtGvrjAG6ctCaawYrA
	 w2/leAkcl1VxKig4DmeoD0pLEvBHROQ0YFOJqyWu4Lhajx57VafGzPqZleO9gWDiyr
	 hjusy8KQshzWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291FCD1288;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Fri, 29 Mar 2024 17:17:13 +0800
Subject: [PATCH 1/3] dt-bindings: reset: Add Amlogic T7 Reset Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-t7-reset-v1-1-4c6e2e68359e@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
In-Reply-To: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zelong Dong <zelong.dong@amlogic.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711703853; l=7020;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=mluS+tHhwQAUrUJxW0K+7LJ2Wjk2i0Km6qCpYYcquZo=;
 b=Nx96vMfnWtH6zdahWonwuNnsrj3vbehWWJXGHgK8O2gkXmMmzhjZP6T4P3XYVHoziVH3hXGrK
 pazxVUWy6tpDN/b8xUFTL/j+mBEZ2LdUNWvRbh2KAsRS9BLaucZh/cv
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

Add a new compatible and the related header file
for Amlogic T7 Reset Controller.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
 include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index f0c6c0df0ce3..fefe343e5afe 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -19,6 +19,7 @@ properties:
       - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
       - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
       - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
+      - amlogic,t7-reset # Reset Controller on T7 and compatible SoCs
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/reset/amlogic,t7-reset.h b/include/dt-bindings/reset/amlogic,t7-reset.h
new file mode 100644
index 000000000000..ca4a832eeeec
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,t7-reset.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_T7_RESET_H
+#define _DT_BINDINGS_AMLOGIC_T7_RESET_H
+
+/* RESET0 */
+/*					0-3	*/
+#define RESET_USB			4
+#define RESET_U2DRD			5
+#define RESET_U3DRD			6
+#define RESET_U3DRD_PIPE0		7
+#define RESET_U2PHY20			8
+#define RESET_U2PHY21			9
+#define RESET_GDC			10
+#define RESET_HDMI20_AES		11
+#define RESET_HDMIRX			12
+#define RESET_HDMIRX_APB		13
+#define RESET_DEWARP			14
+/*					15	*/
+#define RESET_HDMITX_CAPB3		16
+#define RESET_BRG_VCBUG_DEC		17
+#define RESET_VCBUS			18
+#define RESET_VID_PLL_DIV		19
+#define RESET_VDI6			20
+#define RESET_GE2D			21
+#define RESET_HDMITXPHY			22
+#define RESET_VID_LOCK			23
+#define RESET_VENC0			24
+#define RESET_VDAC			25
+#define RESET_VENC2			26
+#define RESET_VENC1			27
+#define RESET_RDMA			28
+#define RESET_HDMITX			29
+#define RESET_VIU			30
+#define RESET_VENC			31
+
+/* RESET1 */
+#define RESET_AUDIO			32
+#define RESET_MALI_CAPB3		33
+#define RESET_MALI			34
+#define RESET_DDR_APB			35
+#define RESET_DDR			36
+#define RESET_DOS_CAPB3			37
+#define RESET_DOS			38
+#define RESET_COMBO_DPHY_CHAN2		39
+#define RESET_DEBUG_B			40
+#define RESET_DEBUG_A			41
+#define RESET_DSP_B			42
+#define RESET_DSP_A			43
+#define RESET_PCIE_A			44
+#define RESET_PCIE_PHY			45
+#define RESET_PCIE_APB			46
+#define RESET_ANAKIN			47
+#define RESET_ETH			48
+#define RESET_EDP0_CTRL			49
+#define RESET_EDP1_CTRL			50
+#define RESET_COMBO_DPHY_CHAN0		51
+#define RESET_COMBO_DPHY_CHAN1		52
+#define RESET_DSI_LVDS_EDP_TOP		53
+#define RESET_PCIE1_PHY			54
+#define RESET_PCIE1_APB			55
+#define RESET_DDR_1			56
+/*					57	*/
+#define RESET_EDP1_PIPELINE		58
+#define RESET_EDP0_PIPELINE		59
+#define RESET_MIPI_DSI1_PHY		60
+#define RESET_MIPI_DSI0_PHY		61
+#define RESET_MIPI_DSI_A_HOST		62
+#define RESET_MIPI_DSI_B_HOST		63
+
+/* RESET2 */
+#define RESET_DEVICE_MMC_ARB		64
+#define RESET_IR_CTRL			65
+#define RESET_TS_A73			66
+#define RESET_TS_A53			67
+#define RESET_SPICC_2			68
+#define RESET_SPICC_3			69
+#define RESET_SPICC_4			70
+#define RESET_SPICC_5			71
+#define RESET_SMART_CARD		72
+#define RESET_SPICC_0			73
+#define RESET_SPICC_1			74
+#define RESET_RSA			75
+/*					76-79	*/
+#define RESET_MSR_CLK			80
+#define RESET_SPIFC			81
+#define RESET_SAR_ADC			82
+#define RESET_BT			83
+/*					84-87	*/
+#define RESET_ACODEC			88
+#define RESET_CEC			89
+#define RESET_AFIFO			90
+#define RESET_WATCHDOG			91
+/*					92-95	*/
+
+/* RESET3 */
+#define RESET_BRG_NIC1_GPV		96
+#define RESET_BRG_NIC2_GPV		97
+#define RESET_BRG_NIC3_GPV		98
+#define RESET_BRG_NIC4_GPV		99
+#define RESET_BRG_NIC5_GPV		100
+/*					101-121	*/
+#define RESET_MIPI_ISP			122
+#define RESET_BRG_ADB_MALI_1		123
+#define RESET_BRG_ADB_MALI_0		124
+#define RESET_BRG_ADB_A73		125
+#define RESET_BRG_ADB_A53		126
+#define RESET_BRG_CCI			127
+
+/* RESET4 */
+#define RESET_PWM_AO_AB			128
+#define RESET_PWM_AO_CD			129
+#define RESET_PWM_AO_EF			130
+#define RESET_PWM_AO_GH			131
+#define RESET_PWM_AB			132
+#define RESET_PWM_CD			133
+#define RESET_PWM_EF			134
+/*					135-137	*/
+#define RESET_UART_A			138
+#define RESET_UART_B			139
+#define RESET_UART_C			140
+#define RESET_UART_D			141
+#define RESET_UART_E			142
+#define RESET_UART_F			143
+#define RESET_I2C_S_A			144
+#define RESET_I2C_M_A			145
+#define RESET_I2C_M_B			146
+#define RESET_I2C_M_C			147
+#define RESET_I2C_M_D			148
+#define RESET_I2C_M_E			149
+#define RESET_I2C_M_F			150
+#define RESET_I2C_M_AO_A		151
+#define RESET_SD_EMMC_A			152
+#define RESET_SD_EMMC_B			153
+#define RESET_SD_EMMC_C			154
+#define RESET_I2C_M_AO_B		155
+#define RESET_TS_GPU			156
+#define RESET_TS_NNA			157
+#define RESET_TS_VPN			158
+#define RESET_TS_HEVC			159
+
+/* RESET5 */
+#define RESET_BRG_NOC_DDR_1		160
+#define RESET_BRG_NOC_DDR_0		161
+#define RESET_BRG_NOC_MAIN		162
+#define RESET_BRG_NOC_ALL		163
+/*					164-167	*/
+#define RESET_BRG_NIC2_SYS		168
+#define RESET_BRG_NIC2_MAIN		169
+#define RESET_BRG_NIC2_HDMI		170
+#define RESET_BRG_NIC2_ALL		171
+#define RESET_BRG_NIC3_WAVE		172
+#define RESET_BRG_NIC3_VDEC		173
+#define RESET_BRG_NIC3_HEVCF		174
+#define RESET_BRG_NIC3_HEVCB		175
+#define RESET_BRG_NIC3_HCODEC		176
+#define RESET_BRG_NIC3_GE2D		177
+#define RESET_BRG_NIC3_GDC		178
+#define RESET_BRG_NIC3_AMLOGIC		179
+#define RESET_BRG_NIC3_MAIN		180
+#define RESET_BRG_NIC3_ALL		181
+#define RESET_BRG_NIC5_VPU		182
+/*					183-185	*/
+#define RESET_BRG_NIC4_DSPB		186
+#define RESET_BRG_NIC4_DSPA		187
+#define RESET_BRG_NIC4_VAPB		188
+#define RESET_BRG_NIC4_CLK81		189
+#define RESET_BRG_NIC4_MAIN		190
+#define RESET_BRG_NIC4_ALL		191
+
+/* RESET6 */
+#define RESET_BRG_VDEC_PIPEL		192
+#define RESET_BRG_HEVCF_DMC_PIPEL	193
+#define RESET_BRG_NIC2TONIC4_PIPEL	194
+#define RESET_BRG_HDMIRXTONIC2_PIPEL	195
+#define RESET_BRG_SECTONIC4_PIPEL	196
+#define RESET_BRG_VPUTONOC_PIPEL	197
+#define RESET_BRG_NIC4TONOC_PIPEL	198
+#define RESET_BRG_NIC3TONOC_PIPEL	199
+#define RESET_BRG_NIC2TONOC_PIPEL	200
+#define RESET_BRG_NNATONOC_PIPEL	201
+#define RESET_BRG_FRISP3_PIPEL		202
+#define RESET_BRG_FRISP2_PIPEL		203
+#define RESET_BRG_FRISP1_PIPEL		204
+#define RESET_BRG_FRISP0_PIPEL		205
+/*					206-217	*/
+#define RESET_BRG_AMPIPE_NAND		218
+#define RESET_BRG_AMPIPE_ETH		219
+/*					220	*/
+#define RESET_BRG_AM2AXI0		221
+#define RESET_BRG_AM2AXI1		222
+#define RESET_BRG_AM2AXI2		223
+
+#endif

-- 
2.37.1



