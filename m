Return-Path: <linux-kernel+bounces-34662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8968385D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E651F222CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5F1C02;
	Tue, 23 Jan 2024 02:57:04 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886A812;
	Tue, 23 Jan 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978623; cv=none; b=bTbzYyvX5Gytsq7AAiXhWvGjF76OUAzjaEYMuwmMeNydPLOvcBjtmwG7zxMPwJEFLKU0mfMYB9F6OWDUpU+PNpGAbrTWCZF5X5Cz69fBrfkc5So6E+CEIU8OzUp626zON0UQ1mpWpGpFyCVpWmh7yj6YUr3B0Uuc7H+RYKOJdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978623; c=relaxed/simple;
	bh=i9F130l1Dwqzgo1WfgjZ211rOn/9OZ4b3Qdi35e2274=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLMEqhMkF5xcUXob/8iuVlExFDhxnzS13iaCZhazHf/ws6QSW9jJk7vTt3jMSqXL4SnJMq2CoWd1aSlBfZDHoJCLDUanlPmR9fmxsFnrix8QGxmrqz2mJo+qN8gJyJ5feLLez92NZaPJoucitmsb1taE6rLUYFD7OEI54IZ6aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40N2uISL022710;
	Tue, 23 Jan 2024 10:56:18 +0800 (+08)
	(envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJs3s0Z0Fz2S82tk;
	Tue, 23 Jan 2024 10:48:57 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 23 Jan
 2024 10:56:16 +0800
From: Zhifeng Tang <zhifeng.tang@unisoc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V4 1/3] dt-bindings: reset: Add reset controller bindings for Unisoc's ums512
Date: Tue, 23 Jan 2024 10:56:11 +0800
Message-ID: <20240123025613.3976-2-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
References: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 40N2uISL022710

From: "zhifeng.tang" <zhifeng.tang@unisoc.com>

In most of Sprd SOCs,The clock controller register block also
contains reset bits for some of these peripherals,so reset
controller and clock provider are combined together as a block,
and put it under the driver/clk/.

Signed-off-by: zhifeng.tang <zhifeng.tang@unisoc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/sprd,ums512-clk.yaml       |   3 +
 include/dt-bindings/reset/sprd,ums512-reset.h | 203 ++++++++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 include/dt-bindings/reset/sprd,ums512-reset.h

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
index 43d2b6c31357..6b0892d637fe 100644
--- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -34,6 +34,9 @@ properties:
   "#clock-cells":
     const: 1
 
+  "#reset-cells":
+    const: 1
+
   clocks:
     minItems: 1
     maxItems: 4
diff --git a/include/dt-bindings/reset/sprd,ums512-reset.h b/include/dt-bindings/reset/sprd,ums512-reset.h
new file mode 100644
index 000000000000..d7ec3dd7c291
--- /dev/null
+++ b/include/dt-bindings/reset/sprd,ums512-reset.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2022, Unisoc Inc.
+ */
+
+#ifndef __DT_BINDINGS_SPRD_UMS512_RESET_H
+#define __DT_BINDINGS_SPRD_UMS512_RESET_H
+
+/* PMU APB resets */
+#define RESET_PMU_APB_WTLCP_SOFT_RST			0
+#define RESET_PMU_APB_PUBCP_SOFT_RST			1
+#define RESET_PMU_APB_WTLCP_DSP_SOFT_RST		2
+#define RESET_PMU_APB_MM_SOFT_RST			3
+#define RESET_PMU_APB_GPU_SOFT_RST			4
+#define RESET_PMU_APB_AP_SOFT_RST			5
+#define RESET_PMU_APB_PUB_SOFT_RST			6
+#define RESET_PMU_APB_APCPU_SOFT_RST			7
+#define RESET_PMU_APB_SP_SYS_SOFT_RST			8
+#define RESET_PMU_APB_AUDCP_SYS_SOFT_RST		9
+#define RESET_PMU_APB_AUDCP_AUDDSP_SOFT_RST		10
+#define RESET_PMU_APB_CDMA_SOFT_RST			11
+#define RESET_PMU_APB_WTLCP_AON_SOFT_RST		12
+#define RESET_PMU_APB_WCDMA_AON_SOFT_RST		13
+#define RESET_PMU_APB_WTLCP_LDSP_SOFT_RST		14
+#define RESET_PMU_APB_WTLCP_TGDSP_SOFT_RST		15
+#define RESET_PMU_APB_AP_VSP_SOFT_RST			16
+#define RESET_PMU_APB_AP_VDSP_SOFT_RST			17
+#define RESET_PMU_APB_APCPU_CORE0_MODE_ST_SOFT_RST	18
+#define RESET_PMU_APB_APCPU_CORE1_MODE_ST_SOFT_RST	19
+#define RESET_PMU_APB_APCPU_CORE2_MODE_ST_SOFT_RST	20
+#define RESET_PMU_APB_APCPU_CORE3_MODE_ST_SOFT_RST	21
+#define RESET_PMU_APB_APCPU_CORE4_MODE_ST_SOFT_RST	22
+#define RESET_PMU_APB_APCPU_CORE5_MODE_ST_SOFT_RST	23
+#define RESET_PMU_APB_APCPU_CORE6_MODE_ST_SOFT_RST	24
+#define RESET_PMU_APB_APCPU_CORE7_MODE_ST_SOFT_RST	25
+#define RESET_PMU_APB_APCPU_CLUSTER_MODE_ST_SOFT_RST	26
+
+/* AP APB resets */
+#define RESET_AP_APB_SIM0_SOFT_RST		0
+#define RESET_AP_APB_IIS0_SOFT_RST		1
+#define RESET_AP_APB_IIS1_SOFT_RST		2
+#define RESET_AP_APB_IIS2_SOFT_RST		3
+#define RESET_AP_APB_SPI0_SOFT_RST		4
+#define RESET_AP_APB_SPI1_SOFT_RST		5
+#define RESET_AP_APB_SPI2_SOFT_RST		6
+#define RESET_AP_APB_SPI3_SOFT_RST		7
+#define RESET_AP_APB_I2C0_SOFT_RST		8
+#define RESET_AP_APB_I2C1_SOFT_RST		9
+#define RESET_AP_APB_I2C2_SOFT_RST		10
+#define RESET_AP_APB_I2C3_SOFT_RST		11
+#define RESET_AP_APB_I2C4_SOFT_RST		12
+#define RESET_AP_APB_UART0_SOFT_RST		13
+#define RESET_AP_APB_UART1_SOFT_RST		14
+#define RESET_AP_APB_UART2_SOFT_RST		15
+#define RESET_AP_APB_SDIO0_SOFT_RST		16
+#define RESET_AP_APB_SDIO1_SOFT_RST		17
+#define RESET_AP_APB_SDIO2_SOFT_RST		18
+#define RESET_AP_APB_EMMC_SOFT_RST		19
+#define RESET_AP_APB_CE_SEC_SOFT_RST		20
+#define RESET_AP_APB_CE_PUB_SOFT_RST		21
+#define RESET_AP_APB_AP_DVFS_SOFT_RST		22
+
+/* AP AHB resets */
+#define RESET_AP_AHB_DSI_SOFT_RST		0
+#define RESET_AP_AHB_DISPC_SOFT_RST		1
+#define RESET_AP_AHB_VDSP_IDMA_VAU_SOFT_RST	2
+#define RESET_AP_AHB_VDSP_MSTD_VAU_SOFT_RST	3
+#define RESET_AP_AHB_VDSP_MSTI_VAU_SOFT_RST	4
+#define RESET_AP_AHB_VDMA_VAU_SOFT_RST		5
+#define RESET_AP_AHB_IPI_SOFT_RST		6
+#define RESET_AP_AHB_VDMA_SOFT_RST		7
+#define RESET_AP_AHB_DMA_SOFT_RST		8
+#define RESET_AP_AHB_VDSP_SOFT_RST		9
+#define RESET_AP_AHB_VDSP_DEBUG_SOFT_RST	10
+#define RESET_AP_AHB_VSP_GLOBAL_SOFT_RST	11
+#define RESET_AP_AHB_VPP_SOFT_RST		12
+#define RESET_AP_AHB_VSP_SOFT_RST		13
+#define RESET_AP_AHB_DISPC_VAU_SOFT_RST		14
+
+/* AON APB resets */
+#define RESET_AON_APB_RC100M_CAL_SOFT_RST		0
+#define RESET_AON_APB_RFTI_SOFT_RST			1
+#define RESET_AON_APB_DCXO_LC_SOFT_RST			2
+#define RESET_AON_APB_BB_CAL_SOFT_RST			3
+#define RESET_AON_APB_MSPI0_SOFT_RST			4
+#define RESET_AON_APB_MSPI1_SOFT_RST			5
+#define RESET_AON_APB_DAP_MTX_SOFT_RST			6
+#define RESET_AON_APB_LVDSDIS_SOFT_RST			7
+#define RESET_AON_APB_SERDES_DPHY_SOFT_RST		8
+#define RESET_AON_APB_SERDES_DPHY_APB_SOFT_RST		9
+#define RESET_AON_APB_AP_EMMC_SOFT_RST			10
+#define RESET_AON_APB_AP_SDIO0_SOFT_RST			11
+#define RESET_AON_APB_AP_SDIO1_SOFT_RST			12
+#define RESET_AON_APB_AP_SDIO2_SOFT_RST			13
+#define RESET_AON_APB_PUBCP_SDIO0_SOFT_RST		14
+#define RESET_AON_APB_EFUSE_SOFT_RST			15
+#define RESET_AON_APB_GPIO_SOFT_RST			16
+#define RESET_AON_APB_MBOX_SOFT_RST			17
+#define RESET_AON_APB_KPD_SOFT_RST			18
+#define RESET_AON_APB_AON_SYST_SOFT_RST			19
+#define RESET_AON_APB_AP_SYST_SOFT_RST			20
+#define RESET_AON_APB_AON_TMR_SOFT_RST			21
+#define RESET_AON_APB_DVFS_TOP_SOFT_RST			22
+#define RESET_AON_APB_OTG_UTMI_SOFT_RST			23
+#define RESET_AON_APB_OTG_PHY_SOFT_RST			24
+#define RESET_AON_APB_SPLK_SOFT_RST			25
+#define RESET_AON_APB_PIN_SOFT_RST			26
+#define RESET_AON_APB_ANA_SOFT_RST			27
+#define RESET_AON_APB_CKG_SOFT_RST			28
+#define RESET_AON_APB_ETC_SOFT_RST			29
+#define RESET_AON_APB_APCPU_TS0_SOFT_RST		30
+#define RESET_AON_APB_APB_BUSMON_SOFT_RST		31
+#define RESET_AON_APB_AON_IIS_SOFT_RST			32
+#define RESET_AON_APB_SCC_SOFT_RST			33
+#define RESET_AON_APB_THM0_SOFT_RST			34
+#define RESET_AON_APB_THM1_SOFT_RST			35
+#define RESET_AON_APB_THM2_SOFT_RST			36
+#define RESET_AON_APB_AP_SIM_AON_TOP_SOFT_RST		37
+#define RESET_AON_APB_PUBCP_SIM0_AON_TOP_SOFT_RST	38
+#define RESET_AON_APB_PUBCP_SIM1_AON_TOP_SOFT_RST	39
+#define RESET_AON_APB_PUBCP_SIM2_AON_TOP_SOFT_RST	40
+#define RESET_AON_APB_I2C_SOFT_RST			41
+#define RESET_AON_APB_PMU_SOFT_RST			42
+#define RESET_AON_APB_ADI_SOFT_RST			43
+#define RESET_AON_APB_EIC_SOFT_RST			44
+#define RESET_AON_APB_AP_INTC0_SOFT_RST			45
+#define RESET_AON_APB_AP_INTC1_SOFT_RST			46
+#define RESET_AON_APB_AP_INTC2_SOFT_RST			47
+#define RESET_AON_APB_AP_INTC3_SOFT_RST			48
+#define RESET_AON_APB_AP_INTC4_SOFT_RST			49
+#define RESET_AON_APB_AP_INTC5_SOFT_RST			50
+#define RESET_AON_APB_AUDCP_INTC_SOFT_RST		51
+#define RESET_AON_APB_PUBCP_INTC_SOFT_RST		52
+#define RESET_AON_APB_WTLCP_TGDSP_INTC_SOFT_RST		53
+#define RESET_AON_APB_WTLCP_LDSP_INTC_SOFT_RST		54
+#define RESET_AON_APB_WTLCP_INTC_SOFT_RST		55
+#define RESET_AON_APB_AP_TMR0_SOFT_RST			56
+#define RESET_AON_APB_AP_TMR1_SOFT_RST			57
+#define RESET_AON_APB_AP_TMR2_SOFT_RST			58
+#define RESET_AON_APB_PWM0_SOFT_RST			59
+#define RESET_AON_APB_PWM1_SOFT_RST			60
+#define RESET_AON_APB_PWM2_SOFT_RST			61
+#define RESET_AON_APB_PWM3_SOFT_RST			62
+#define RESET_AON_APB_AP_WDG_SOFT_RST			63
+#define RESET_AON_APB_APCPU_WDG_SOFT_RST		64
+#define  RESET_AON_APB_SERDES_SOFT_RST			65
+#define RESET_AON_APB_DJTAG_SOFT_RST			66
+
+/* AUDCP APB  resets */
+#define RESET_AUDCP_APB_WDG_SOFT_RST		0
+#define RESET_AUDCP_APB_TMR0_SOFT_RST		1
+#define RESET_AUDCP_APB_TMR1_SOFT_RST		2
+
+/* AUDCP AHB resets */
+#define RESET_AUDCP_AHB_VBC_24M_SOFT_RST	0
+#define RESET_AUDCP_AHB_DMA_AP_SOFT_RST		1
+#define RESET_AUDCP_AHB_SRC48K_SOFT_RST		2
+#define RESET_AUDCP_AHB_MCDT_SOFT_RST		3
+#define RESET_AUDCP_AHB_VBCIFD_SOFT_RST		4
+#define RESET_AUDCP_AHB_VBC_SOFT_RST		5
+#define RESET_AUDCP_AHB_SPINLOCK_SOFT_RST	6
+#define RESET_AUDCP_AHB_DMA_CP_SOFT_RST		7
+#define RESET_AUDCP_AHB_IIS0_SOFT_RST		8
+#define RESET_AUDCP_AHB_IIS1_SOFT_RST		9
+#define RESET_AUDCP_AHB_IIS2_SOFT_RST		10
+#define RESET_AUDCP_AHB_UART_SOFT_RST		11
+#define RESET_AUDCP_AHB_AUD_SOFT_RST		12
+#define RESET_AUDCP_AHB_DVFS_SOFT_RST		13
+
+/* GPU APB resets */
+#define RESET_GPU_APB_GPU_CORE_SOFT_RST		0
+#define RESET_GPU_APB_SYS_SOFT_RST_REQ_CORE	1
+
+/* MM AHB resets */
+#define RESET_MM_AHB_CKG_SOFT_RST		0
+#define RESET_MM_AHB_JPG_SOFT_RST		1
+#define RESET_MM_AHB_DCAM_AXI_SOFT_RST		2
+#define RESET_MM_AHB_DCAM2_SOFT_RST		3
+#define RESET_MM_AHB_DCAM1_SOFT_RST		4
+#define RESET_MM_AHB_DCAM0_SOFT_RST		5
+#define RESET_MM_AHB_DCAM_VAU_SOFT_RST		6
+#define RESET_MM_AHB_MIPI_CSI2_SOFT_RST		7
+#define RESET_MM_AHB_MIPI_CSI1_SOFT_RST		8
+#define RESET_MM_AHB_MIPI_CSI0_SOFT_RST		9
+#define RESET_MM_AHB_ISP_SOFT_RST		10
+#define RESET_MM_AHB_ISP_VAU_SOFT_RST		11
+#define RESET_MM_AHB_ISP_AHB_SOFT_RST		12
+#define RESET_MM_AHB_CPP_DMA_SOFT_RST		13
+#define RESET_MM_AHB_CPP_PATH1_SOFT_RST		14
+#define RESET_MM_AHB_CPP_PATH0_SOFT_RST		15
+#define RESET_MM_AHB_CPP_SOFT_RST		16
+#define RESET_MM_AHB_MM_MAIN_SOFT_RST		17
+#define RESET_MM_AHB_CPP_SOFT_RST_MASK		18
+#define RESET_MM_AHB_JPG_SOFT_RST_MASK		19
+#define RESET_MM_AHB_JPG_VAU_SOFT_RST		20
+#define RESET_MM_AHB_CPP_VAU_SOFT_RST		21
+#define RESET_MM_AHB_FD_VAU_SOFT_RST		22
+#define RESET_MM_AHB_DCAM_ALL_SOFT_RST		23
+#define RESET_MM_AHB_DVFS_SOFT_RST		24
+#define RESET_MM_AHB_FD_SOFT_RST		25
+#define RESET_MM_AHB_FD_SOFT_RST_MASK		26
+
+#endif /* __DT_BINDINGS_SPRD_UMS512_RESET_H */
-- 
2.17.1


