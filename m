Return-Path: <linux-kernel+bounces-77275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8A860304
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C24E28726F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7AF73F20;
	Thu, 22 Feb 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGa2WVNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FF6AF9F;
	Thu, 22 Feb 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630837; cv=none; b=RZjE4Fla5N6csiLBrbRI81K1I/s3Y3mlmr9ay2hoVvguGka30iZorYacgggmNAfDjcIaCKrUUt9HHsKH4Vn8TVkcqkUZNmlJwUefixdhSUMUFArh9nKDi8POP6o4COV375L/QNyS3ApYfBdOj+nzU8WX2HYJMVTX+1MfSXt1rW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630837; c=relaxed/simple;
	bh=rJGffzjUViLS+nDkKe7uZ+BiLBpGRvDkA+9bjaqnrd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LnBaQemOKo4gUtw1bBBv0VtRLyPKVOdhXx+CY2r2A2H6Crwh7OSfCfGv/JgUcLi/Y2yKrpP9MkO0vawwyP82GDFoHnmPtKFWNrcSPHp6UIWyVAMuNhogLvN71eoNwztpbzh8+zVB3+ztnom0MRybXbpDS9gHy08QhPnjvcQHH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGa2WVNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6A9AC41679;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630836;
	bh=rJGffzjUViLS+nDkKe7uZ+BiLBpGRvDkA+9bjaqnrd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TGa2WVNemD312SzLNe8O35DwZKvBbAuWiVURjPnLuSgp/YaDuLX7yPJ0z9pIkUM8u
	 D97Nh3ZyV2/HiT6aWXcIyRS3GtU8wCh/ZU/w/nE7pIjY1vdDeh/gkySl7yEKBTEzAV
	 IJjeWq11+uQXSMlTvbPfoUJN+7VJo96B/r6A782ex6u6gh1/CVkrEHJ9oYf4aZ/WOI
	 +XF3LaivqXY/+ZAd5Gdx3zzHXoFeAVz0dzm8X8Uof6qxIhVAJmu5AKmoxybbV7qrUc
	 NW5UeIXCoS2Fqlj6PomWN7dAdUwSNKCeTa8ugMwxfgJeyDnMtaZl+p9G1RXERrEmWe
	 PRdesfIxIe9lA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A7C54E4A;
	Thu, 22 Feb 2024 19:40:36 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 03:40:16 +0800
Subject: [PATCH v4 6/7] dt-bindings: clock: hisilicon: add clock
 definitions for Hi3798MV200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-clk-mv200-v4-6-3e37e501d407@outlook.com>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
In-Reply-To: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708630834; l=7237;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=6xOEgYF0B7eiIZ4EYO0h2UBTdSjOiERYXdjqsZonns4=;
 b=jP0y2Cxu4i8nReKbqviaSEux8oQSWb8kyzSYYYQETBQhHUY6hmFjVxrx3CuberfxxJ6IZmACh
 SU4OZpi53xxCEBL68pg7XnoCO31Wzc2c3juT4MQC16CAd9bS9pv9g+a
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add clock definitions for core CRG and mcu CRG for Hi3798MV200 SoC.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../dt-bindings/clock/hisilicon,hi3798mv200-crg.h  | 150 +++++++++++++++++++++
 .../clock/hisilicon,hi3798mv200-sysctrl.h          |  21 +++
 2 files changed, 171 insertions(+)

diff --git a/include/dt-bindings/clock/hisilicon,hi3798mv200-crg.h b/include/dt-bindings/clock/hisilicon,hi3798mv200-crg.h
new file mode 100644
index 000000000000..33df1e3ef1ee
--- /dev/null
+++ b/include/dt-bindings/clock/hisilicon,hi3798mv200-crg.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 Yang Xiwen <forbidden405@outlook.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_HI3798MV200_CRG_H
+#define __DT_BINDINGS_CLOCK_HI3798MV200_CRG_H
+
+/* clocks provided by core CRG */
+#define HI3798MV200_OSC_CLK			0
+#define HI3798MV200_APB_CLK			1
+#define HI3798MV200_AHB_CLK			2
+#define HI3798MV200_APLL_CLK			3
+#define HI3798MV200_BPLL_CLK			4
+#define HI3798MV200_DPLL_CLK			5
+#define HI3798MV200_VPLL_CLK			6
+#define HI3798MV200_HPLL_CLK			7
+#define HI3798MV200_EPLL_CLK			8
+#define HI3798MV200_QPLL_CLK			9
+#define HI3798MV200_PERI_DIV_CLK		10
+#define HI3798MV200_CORE_BUS_CLK		11
+#define HI3798MV200_MDE0_BUS_CLK		12
+#define HI3798MV200_MDE1_BUS_CLK		13
+#define HI3798MV200_MDE2_BUS_CLK		14
+#define HI3798MV200_MDE3_BUS_CLK		15
+/* UART1 does not exist */
+#define HI3798MV200_UART2_CLK			16
+#define HI3798MV200_UART3_CLK			17
+#define HI3798MV200_I2C0_CLK			18
+#define HI3798MV200_I2C1_CLK			19
+#define HI3798MV200_I2C2_CLK			20
+#define HI3798MV200_SPI0_CLK			21
+#define HI3798MV200_SCI0_CLK			22
+#define HI3798MV200_SCI1_CLK			23
+#define HI3798MV200_VDH_CLK			24
+#define HI3798MV200_VDH_DSP_CLK			25
+#define HI3798MV200_JPGD_CLK			26
+#define HI3798MV200_PGD_CLK			27
+#define HI3798MV200_BPD_CLK			28
+#define HI3798MV200_VENV_CLK			29
+#define HI3798MV200_VENV_AXI_CLK		30
+#define HI3798MV200_JPGE_CLK			31
+#define HI3798MV200_TDE_CLK			32
+#define HI3798MV200_SDIO0_BIU_CLK		33
+#define HI3798MV200_SDIO0_CIU_CLK		34
+#define HI3798MV200_SDIO0_DRV_CLK		35
+#define HI3798MV200_SDIO0_SAMPLE_CLK		36
+#define HI3798MV200_MMC_BIU_CLK			37
+#define HI3798MV200_MMC_CIU_CLK			38
+#define HI3798MV200_MMC_DRV_CLK			39
+#define HI3798MV200_MMC_SAMPLE_CLK		40
+#define HI3798MV200_SATA_CLK			41
+#define HI3798MV200_SATA_RX_CLK			42
+#define HI3798MV200_SATA_CKO_ALIVE_CLK		43
+#define HI3798MV200_SATA_TX_CLK			44
+#define HI3798MV200_USB3_BUS_CLK		45
+#define HI3798MV200_USB3_REF_CLK		46
+#define HI3798MV200_USB3_SUSPEND_CLK		47
+#define HI3798MV200_USB3_PIPE_CLK		48
+#define HI3798MV200_USB3_UTMI_CLK		49
+#define HI3798MV200_USB3_GS_CLK			50
+#define HI3798MV200_USB3_GM_CLK			51
+#define HI3798MV200_USB2_BUS_CLK		52
+#define HI3798MV200_USB2_48M_CLK		53
+#define HI3798MV200_USB2_12M_CLK		54
+#define HI3798MV200_USB2_OTG_UTMI_CLK		55
+#define HI3798MV200_USB2_HST_PHY_CLK		56
+#define HI3798MV200_USB2_UTMI0_CLK		57
+#define HI3798MV200_USB2_UTMI1_CLK		58
+#define HI3798MV200_USB2_PHY1_REF_CLK		59
+#define HI3798MV200_USB2_PHY2_REF_CLK		60
+#define HI3798MV200_SHA0_CLK			61
+#define HI3798MV200_SHA1_CLK			62
+#define HI3798MV200_PMC_CLK			63
+#define HI3798MV200_GSF_CLK			64
+#define HI3798MV200_GMAC_CLK			65
+#define HI3798MV200_EXT_NETPHY_CLK		66
+#define HI3798MV200_ETH_BUS_CLK			67
+#define HI3798MV200_ETH_CLK			68
+#define HI3798MV200_GPU_CLK			69
+#define HI3798MV200_VO_BUS			70
+#define HI3798MV200_VO_SD			71
+#define HI3798MV200_VO_SDATE			72
+#define HI3798MV200_VDAC_CH0_CLK		73
+#define HI3798MV200_VO_HD			74
+#define HI3798MV200_VDP_CLK			75
+#define HI3798MV200_VDP_CFG_CLK			76
+#define HI3798MV200_VPSS_CLK			77
+#define HI3798MV200_PVR_BUS_CLK			78
+#define HI3798MV200_PVR_DMX_CLK			79
+#define HI3798MV200_PVR_27M_CLK			80
+#define HI3798MV200_PVR_TSI1_CLK		81
+#define HI3798MV200_PVR_TSI2_CLK		82
+#define HI3798MV200_PVR_TSI3_CLK		83
+#define HI3798MV200_PVR_TSI4_CLK		84
+#define HI3798MV200_PVR_TS0_CLK			85
+#define HI3798MV200_PVR_TSOUT0_CLK		86
+#define HI3798MV200_HDMITX_SSC_CLK		87
+#define HI3798MV200_HDMITX_SSC_BYPASS_CLK	88
+#define HI3798MV200_HDMITX_CTRL_24M_CLK		89
+#define HI3798MV200_HDMITX_CTRL_CEC_CLK		90
+#define HI3798MV200_HDMITX_CTRL_60M_CLK		91
+#define HI3798MV200_HDMITX_CTRL_AS_CLK		92
+#define HI3798MV200_HDMITX_PHY_TMDS_CLK		93
+#define HI3798MV200_ADAC_CLK			94
+#define HI3798MV200_AIAO_CLK			95
+#define HI3798MV200_VDAC_CHOP_CLK		96
+#define HI3798MV200_WDG0_CLK			97
+#define HI3798MV200_COMBPHY_CLK			98
+#define HI3798MV200_PCIE_BUS_CLK		99
+#define HI3798MV200_PCIE_SYS_CLK		100
+#define HI3798MV200_PCIE_PIPE_CLK		101
+#define HI3798MV200_PCIE_AUX_CLK		102
+#define HI3798MV200_SDIO1_BIU_CLK		103
+#define HI3798MV200_SDIO1_CIU_CLK		104
+#define HI3798MV200_SDIO1_DRV_CLK		105
+#define HI3798MV200_SDIO1_SAMPLE_CLK		106
+#define HI3798MV200_VENC_SMMU_CLK		107
+#define HI3798MV200_TDE_SMMU_CLK		108
+#define HI3798MV200_JPGD_SMMU_CLK		109
+#define HI3798MV200_VDH_SMMU_CLK		110
+#define HI3798MV200_VDP_SMMU_CLK		111
+#define HI3798MV200_VPSS_SMMU_CLK		112
+#define HI3798MV200_PGD_SMMU_CLK		113
+#define HI3798MV200_VO_BP_CLK			114
+#define HI3798MV200_VDP_G4_CLK			115
+#define HI3798MV200_VDP_V3_CLK			116
+#define HI3798MV200_VDP_SD_CLK			117
+#define HI3798MV200_VDP_WBC_CP_CLK		118
+#define HI3798MV200_VDP_WBC_GP_CLK		119
+#define HI3798MV200_VDP_WBC_HD_CLK		120
+#define HI3798MV200_VDP_G3_CLK			121
+#define HI3798MV200_VDP_G1_CLK			122
+#define HI3798MV200_VDP_G0_CLK			123
+#define HI3798MV200_VDP_V1_CLK			124
+#define HI3798MV200_VDP_V0_CLK			125
+#define HI3798MV200_VDP_HD_CLK			126
+#define HI3798MV200_CIPHER_SMMU_CLK		127
+#define HI3798MV200_FMC_CLK			128
+#define HI3798MV200_FEPHY_CLK			129
+#define HI3798MV200_DMAC_CLK			130
+#define HI3798MV200_GZIP_CLK			131
+#define HI3798MV200_GZIP_AXI_CLK		132
+#define HI3798MV200_GZIP_APB_CLK		133
+#define HI3798MV200_PM_CLK			134
+#define HI3798MV200_FRACDIV_CLK			135
+
+#define HI3798MV200_CRG_CLK_COUNT		136
+
+#endif	/* __DT_BINDINGS_CLOCK_HI3798MV200_CRG_H */
diff --git a/include/dt-bindings/clock/hisilicon,hi3798mv200-sysctrl.h b/include/dt-bindings/clock/hisilicon,hi3798mv200-sysctrl.h
new file mode 100644
index 000000000000..185e4b701e23
--- /dev/null
+++ b/include/dt-bindings/clock/hisilicon,hi3798mv200-sysctrl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 Yang Xiwen <forbidden405@outlook.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_HI3798MV200_SYSCTRL_H
+#define __DT_BINDINGS_CLOCK_HI3798MV200_SYSCTRL_H
+
+/* clocks provided by mcu CRG */
+#define HI3798MV200_MCU_BUS_CLK			0
+#define HI3798MV200_MCE_CLK			1
+#define HI3798MV200_IR_CLK			2
+#define HI3798MV200_TIMER01_CLK			3
+#define HI3798MV200_LEDC_CLK			4
+#define HI3798MV200_UART0_CLK			5
+#define HI3798MV200_WIFI_CLK			6
+#define HI3798MV200_LSADC_CLK			7
+
+#define HI3798MV200_SYSCTRL_CLK_COUNT		8
+
+#endif	/* __DT_BINDINGS_CLOCK_HI3798MV200_SYSCTRL_H */

-- 
2.43.0


