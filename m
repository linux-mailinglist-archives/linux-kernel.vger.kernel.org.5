Return-Path: <linux-kernel+bounces-153267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BD8ACBBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685D91F243E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A5146591;
	Mon, 22 Apr 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X139oaBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27F145FFF;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784333; cv=none; b=UJC2OtWM6R4TnxC5RmF0gOitwz3HJcg79+gu/ynBaLEtgHOB9tLcDNR4ctSsoY4uVEr99vMP0tFR5/wTCABB4E9hWOS8O1GcIPw7vj7JN+ixsjtmOljDm/3i1aU8MvPKzvpjSKim2tRx59vJ8UCE5pyYfaPJJuKcYu87bcEJLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784333; c=relaxed/simple;
	bh=bMqGcfPIcqx1tPWsZvdzEzpM4FPqCSlBC/LMTX8Eg+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tktP+hkmbLknGIMxcQYQ9QVKB/nWfsaADqLV6ml7pL3Q0U4Y8bbarMyUo+oTnPMGMciSSpYeLHs4Op0bZgJmzwyAVzbJ9P3iJ54HiGj6nY6jUPp8ZCRADpQNicq74vOqEXcvwSdX7IY/wxH1p4OyVlhg6wWX6vCDjnQu3syRetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X139oaBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58BD0C32783;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713784333;
	bh=bMqGcfPIcqx1tPWsZvdzEzpM4FPqCSlBC/LMTX8Eg+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X139oaBoc3aq5DGz6cVJHdIoOEfnMpMuFxPhWbGxdWByxgt5adBGeLiopc1oP4LsX
	 g3ahZJGh05hmwNRkaAiI/TTj4Bdnt8bhKHxSnD9OTYu6Pob40aMkxRZcn4514yB+pj
	 LUM6bYVvFsDdMjRyv80du+fP2apHLZAAMN513FGMufaxpDZ03B3Dfsh4TsCqkoPZ3d
	 1rGvmGDELRnUJPtbFOPBl7z0Ik0fB/UlxxhktahwJ1joJSxGJtEwVY+wsyqoGngayO
	 RkotAskrxa0gh+HpFJiOyYh/hRGRot+46hTRxP9BROu76fbtBLfR8znTll95uWmJZJ
	 MI9ntNJ+vF7HA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B639C10F15;
	Mon, 22 Apr 2024 11:12:13 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Mon, 22 Apr 2024 19:11:45 +0800
Subject: [PATCH v2 3/3] arm64: dts: amlogic: Add Amlogic T7 reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-t7-reset-v2-3-cb82271d3296@amlogic.com>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
In-Reply-To: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713784331; l=7206;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=AZvvv8u/6d8dUV/1ucCs/zLKuwMDc1r1Xd/1XFvNB84=;
 b=NOZLubPnMfr1mcIsYi2kiMtNjw6LmHvaiN/sYtNjbdOVcrQNS6zwAXohzFaQmPGbEDplUg9TG
 wNPYUjFXcVMDN5BWz98fW3q9H+ZEla0z1lD71YU2svlbw3pIybdn95d
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

Add the device node and related header file
for Amlogic T7 reset controller.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h | 197 +++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi    |   7 +
 2 files changed, 204 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h b/arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h
new file mode 100644
index 000000000000..ec90a11df508
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __DTS_AMLOGIC_T7_RESET_H
+#define __DTS_AMLOGIC_T7_RESET_H
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
+#endif /* ___DTS_AMLOGIC_T7_RESET_H */
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 5248bdf824ea..c23efc6c7ac0 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
+#include "amlogic-t7-reset.h"
 
 / {
 	interrupt-parent = <&gic>;
@@ -149,6 +150,12 @@ apb4: bus@fe000000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
 
+			reset: reset-controller@2000 {
+				compatible = "amlogic,t7-reset";
+				reg = <0x0 0x2000 0x0 0x98>;
+				#reset-cells = <1>;
+			};
+
 			watchdog@2100 {
 				compatible = "amlogic,t7-wdt";
 				reg = <0x0 0x2100 0x0 0x10>;

-- 
2.37.1



