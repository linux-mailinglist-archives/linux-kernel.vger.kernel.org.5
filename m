Return-Path: <linux-kernel+bounces-151669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F48AB1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862511C21AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C312F5AF;
	Fri, 19 Apr 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mtOpmYdK"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209F12FF69;
	Fri, 19 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540565; cv=none; b=p3xnd/P3SfgbttFF8dVkpWHYslEeZziQRRyBliii9QM0FkHnY8YrvBl39cBuSVpKYPxGZAp8DzeTBnSMOdQU2I1UTOi1+wQVf2hK7cOuLe+x7u3+BVKhu/Px1/X3PJwxJFunYqA3UR8FVoJXywbjPLpDlwlOBW5hq91/6zrGThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540565; c=relaxed/simple;
	bh=L6V3zkCgl72IeS36DZZPewcOyOhc5YMuHEqyxoQe2j8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zt0o2wKt+jFOlv8nfhIGZassRxaFjxqdsQy+7KDeZsrnzzWy82HEdP3UaWF+D7cFO4v1EtddQktwV1eSFU65sohD9dshCKvU46CevGhcaxAF1Pri2uTxrCh/XQXFFtpg//BEnCxljBBvmgCIV/V0kVHOzaFhc+AWvs5dYoC+urg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mtOpmYdK; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JF1LM1030179;
	Fri, 19 Apr 2024 17:28:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=QoUwuX5KHIbdoh+40YurQ3xUX1JJr1lgGIxxzL2DBuc=; b=mt
	OpmYdKxY6Y0Hy9hQTTb70KcQ+UrSgkM/JNOhPcbLmMbwMW9Xx/gnW4/+qNoFmtua
	/GSdBuHg7abvGC0q+EqDoB94Q28xWE65KkbQsgVbtmR6PzQoMxERJxbI/nB+XQ8v
	trpbjJ+wSi9d9oWx4xbFh8PXk/Y32mHdNkgv6N659d3JkYEoeNzmuZut5NXRLqE7
	umtUMMD9i5IZn+bH+XuVWrZqbFv7N1e82304JDCdJI1pef/HeoveZdwniv0S3oXi
	V1gvSH0BwAeSuEObUo5gLjnNgtqmsgOwGHHVTNZ4wDcCoAnklK0fob9wey+XVuva
	56uW/auKw13QVY3av9sg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecys4kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 17:28:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C5B2640045;
	Fri, 19 Apr 2024 17:28:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6892223F00;
	Fri, 19 Apr 2024 17:27:54 +0200 (CEST)
Received: from localhost (10.252.27.3) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 17:27:54 +0200
From: <gabriel.fernandez@foss.st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] clk: stm32mp2: use of STM32 access controller
Date: Fri, 19 Apr 2024 17:27:21 +0200
Message-ID: <20240419152723.570159-3-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Use an STM32 access controller to filter the registration of clocks.
If a clock is used by the security world, then it must not registered.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32-core.c |   2 +-
 drivers/clk/stm32/clk-stm32-core.h |   2 +-
 drivers/clk/stm32/clk-stm32mp13.c  |   2 +-
 drivers/clk/stm32/clk-stm32mp25.c  | 475 +++++++++++++++++------------
 4 files changed, 283 insertions(+), 198 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 1721a3ed7386..933e3cde0795 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -46,7 +46,7 @@ static int stm32_rcc_clock_init(struct device *dev,
 		struct clk_hw *hw = ERR_PTR(-ENOENT);
 
 		if (data->check_security &&
-		    data->check_security(base, cfg_clock))
+		    data->check_security(dev->of_node, base, cfg_clock))
 			continue;
 
 		if (cfg_clock->func)
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
index bb5aa19a792d..4be103710e12 100644
--- a/drivers/clk/stm32/clk-stm32-core.h
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -71,7 +71,7 @@ struct stm32_rcc_match_data {
 	unsigned int			maxbinding;
 	struct clk_stm32_clock_data	*clock_data;
 	struct clk_stm32_reset_data	*reset_data;
-	int (*check_security)(void __iomem *base,
+	int (*check_security)(struct device_node *np, void __iomem *base,
 			      const struct clock_config *cfg);
 	int (*multi_mux)(void __iomem *base, const struct clock_config *cfg);
 };
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
index bf81d7491708..9bc94c3c5df8 100644
--- a/drivers/clk/stm32/clk-stm32mp13.c
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -1458,7 +1458,7 @@ static const struct clock_config stm32mp13_clock_cfg[] = {
 	STM32_COMPOSITE_CFG(CK_MCO2, ck_mco2, SECF_MCO2),
 };
 
-static int stm32mp13_clock_is_provided_by_secure(void __iomem *base,
+static int stm32mp13_clock_is_provided_by_secure(struct device_node *np, void __iomem *base,
 						 const struct clock_config *cfg)
 {
 	int sec_id = cfg->sec_id;
diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
index 210b75b39e50..a37ee9f707e3 100644
--- a/drivers/clk/stm32/clk-stm32mp25.c
+++ b/drivers/clk/stm32/clk-stm32mp25.c
@@ -4,7 +4,9 @@
  * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
  */
 
+#include <linux/bus/stm32_firewall_device.h>
 #include <linux/clk-provider.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "clk-stm32-core.h"
@@ -14,6 +16,31 @@
 #include <dt-bindings/clock/st,stm32mp25-rcc.h>
 #include <dt-bindings/reset/st,stm32mp25-rcc.h>
 
+/* Clock security definition */
+#define SECF_NONE		-1
+
+#define RCC_REG_SIZE	32
+#define RCC_SECCFGR(x)	(((x) / RCC_REG_SIZE) * 0x4 + RCC_SECCFGR0)
+#define RCC_CIDCFGR(x)	((x) * 0x8 + RCC_R0CIDCFGR)
+#define RCC_SEMCR(x)	((x) * 0x8 + RCC_R0SEMCR)
+#define RCC_CID1	1
+
+/* Register: RIFSC_CIDCFGR */
+#define RCC_CIDCFGR_CFEN	BIT(0)
+#define RCC_CIDCFGR_SEM_EN	BIT(1)
+#define RCC_CIDCFGR_SEMWLC1_EN	BIT(17)
+#define RCC_CIDCFGR_SCID_MASK	GENMASK(6, 4)
+
+/* Register: RIFSC_SEMCR */
+#define RCC_SEMCR_SEMCID_MASK	GENMASK(6, 4)
+
+#define MP25_RIF_RCC_IS2M	107
+#define MP25_RIF_RCC_MCO1	108
+#define MP25_RIF_RCC_MCO2	109
+
+#define SEC_RIFSC_FLAG		BIT(31)
+#define SEC_RIFSC(_id)		((_id) | SEC_RIFSC_FLAG)
+
 enum {
 	HSE,
 	HSI,
@@ -1507,203 +1534,260 @@ static struct clk_stm32_gate ck_icn_p_wwdg2 = {
 	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_wwdg2", ICN_LS_MCU, &clk_stm32_gate_ops, 0),
 };
 
-#define SECF_NONE -1
+static int stm32_rcc_get_access(void __iomem *base, u32 index)
+{
+	u32 seccfgr, cidcfgr, semcr;
+	int bit, cid;
+
+	bit = index % RCC_REG_SIZE;
+
+	seccfgr = readl(base + RCC_SECCFGR(index));
+	if (seccfgr & BIT(bit))
+		return -EACCES;
+
+	cidcfgr = readl(base + RCC_CIDCFGR(index));
+	if (!(cidcfgr & RCC_CIDCFGR_CFEN))
+		/* CID filtering is turned off: access granted */
+		return 0;
+
+	if (!(cidcfgr & RCC_CIDCFGR_SEM_EN)) {
+		/* Static CID mode */
+		cid = FIELD_GET(RCC_CIDCFGR_SCID_MASK, cidcfgr);
+		if (cid != RCC_CID1)
+			return -EACCES;
+		return 0;
+	}
+
+	/* Pass-list with semaphore mode */
+	if (!(cidcfgr & RCC_CIDCFGR_SEMWLC1_EN))
+		return -EACCES;
+
+	semcr = readl(base + RCC_SEMCR(index));
+
+	cid = FIELD_GET(RCC_SEMCR_SEMCID_MASK, semcr);
+	if (cid != RCC_CID1)
+		return -EACCES;
+
+	return 0;
+}
+
+static int stm32mp25_check_security(struct device_node *np, void __iomem *base,
+				    const struct clock_config *cfg)
+{
+	int ret = 0;
+
+	if (cfg->sec_id != SECF_NONE) {
+		struct stm32_firewall firewall;
+		u32 index = (u32)cfg->sec_id;
+
+		if (index & SEC_RIFSC_FLAG) {
+			ret = stm32_firewall_get_firewall(np, &firewall, 1);
+			if (ret)
+				return ret;
+			ret = stm32_firewall_grant_access_by_id(&firewall, index & ~SEC_RIFSC_FLAG);
+		} else {
+			ret = stm32_rcc_get_access(base, cfg->sec_id & ~SEC_RIFSC_FLAG);
+		}
+	}
+
+	return ret;
+}
 
 static const struct clock_config stm32mp25_clock_cfg[] = {
-	STM32_GATE_CFG(CK_BUS_ETH1,		ck_icn_p_eth1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ETH2,		ck_icn_p_eth2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_PCIE,		ck_icn_p_pcie,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ETHSW,		ck_icn_p_ethsw,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ADC12,		ck_icn_p_adc12,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ADC3,		ck_icn_p_adc3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_CCI,		ck_icn_p_cci,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_CRC,		ck_icn_p_crc,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_MDF1,		ck_icn_p_mdf1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_OSPIIOM,		ck_icn_p_ospiiom,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_HASH,		ck_icn_p_hash,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_CRYP1,		ck_icn_p_cryp1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_CRYP2,		ck_icn_p_cryp2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ADF1,		ck_icn_p_adf1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI8,		ck_icn_p_spi8,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LPUART1,		ck_icn_p_lpuart1,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C8,		ck_icn_p_i2c8,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LPTIM3,		ck_icn_p_lptim3,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LPTIM4,		ck_icn_p_lptim4,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LPTIM5,		ck_icn_p_lptim5,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_IWDG5,		ck_icn_p_iwdg5,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_WWDG2,		ck_icn_p_wwdg2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I3C4,		ck_icn_p_i3c4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SDMMC1,		ck_icn_m_sdmmc1,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SDMMC2,		ck_icn_m_sdmmc2,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SDMMC3,		ck_icn_m_sdmmc3,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USB2OHCI,		ck_icn_m_usb2ohci,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USB2EHCI,		ck_icn_m_usb2ehci,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USB3DR,		ck_icn_m_usb3dr,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM2,		ck_icn_p_tim2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM3,		ck_icn_p_tim3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM4,		ck_icn_p_tim4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM5,		ck_icn_p_tim5,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM6,		ck_icn_p_tim6,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM7,		ck_icn_p_tim7,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM10,		ck_icn_p_tim10,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM11,		ck_icn_p_tim11,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM12,		ck_icn_p_tim12,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM13,		ck_icn_p_tim13,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM14,		ck_icn_p_tim14,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LPTIM1,		ck_icn_p_lptim1,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LPTIM2,		ck_icn_p_lptim2,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI2,		ck_icn_p_spi2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI3,		ck_icn_p_spi3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPDIFRX,		ck_icn_p_spdifrx,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USART2,		ck_icn_p_usart2,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USART3,		ck_icn_p_usart3,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_UART4,		ck_icn_p_uart4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_UART5,		ck_icn_p_uart5,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C1,		ck_icn_p_i2c1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C2,		ck_icn_p_i2c2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C3,		ck_icn_p_i2c3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C4,		ck_icn_p_i2c4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C5,		ck_icn_p_i2c5,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C6,		ck_icn_p_i2c6,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I2C7,		ck_icn_p_i2c7,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I3C1,		ck_icn_p_i3c1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I3C2,		ck_icn_p_i3c2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_I3C3,		ck_icn_p_i3c3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM1,		ck_icn_p_tim1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM8,		ck_icn_p_tim8,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM15,		ck_icn_p_tim15,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM16,		ck_icn_p_tim16,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM17,		ck_icn_p_tim17,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_TIM20,		ck_icn_p_tim20,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SAI1,		ck_icn_p_sai1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SAI2,		ck_icn_p_sai2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SAI3,		ck_icn_p_sai3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SAI4,		ck_icn_p_sai4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USART1,		ck_icn_p_usart1,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USART6,		ck_icn_p_usart6,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_UART7,		ck_icn_p_uart7,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_UART8,		ck_icn_p_uart8,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_UART9,		ck_icn_p_uart9,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_FDCAN,		ck_icn_p_fdcan,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI1,		ck_icn_p_spi1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI4,		ck_icn_p_spi4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI5,		ck_icn_p_spi5,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI6,		ck_icn_p_spi6,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_SPI7,		ck_icn_p_spi7,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_IWDG2,		ck_icn_p_iwdg2,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_IWDG3,		ck_icn_p_iwdg3,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_IWDG4,		ck_icn_p_iwdg4,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_WWDG1,		ck_icn_p_wwdg1,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_VREF,		ck_icn_p_vref,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_HDP,		ck_icn_p_hdp,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_IS2M,		ck_icn_p_is2m,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_DSI,		ck_icn_p_dsi,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LTDC,		ck_icn_p_ltdc,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_CSI,		ck_icn_p_csi,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_DCMIPP,		ck_icn_p_dcmipp,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_LVDS,		ck_icn_p_lvds,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USBTC,		ck_icn_p_usbtc,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_USB3PCIEPHY,	ck_icn_p_usb3pciephy,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_VDEC,		ck_icn_p_vdec,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_VENC,		ck_icn_p_venc,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM2,		ck_ker_tim2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM3,		ck_ker_tim3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM4,		ck_ker_tim4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM5,		ck_ker_tim5,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM6,		ck_ker_tim6,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM7,		ck_ker_tim7,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM10,		ck_ker_tim10,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM11,		ck_ker_tim11,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM12,		ck_ker_tim12,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM13,		ck_ker_tim13,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM14,		ck_ker_tim14,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM1,		ck_ker_tim1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM8,		ck_ker_tim8,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM15,		ck_ker_tim15,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM16,		ck_ker_tim16,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM17,		ck_ker_tim17,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_TIM20,		ck_ker_tim20,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LPTIM1,		ck_ker_lptim1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LPTIM2,		ck_ker_lptim2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_USART2,		ck_ker_usart2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_UART4,		ck_ker_uart4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_USART3,		ck_ker_usart3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_UART5,		ck_ker_uart5,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI2,		ck_ker_spi2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI3,		ck_ker_spi3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPDIFRX,		ck_ker_spdifrx,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C1,		ck_ker_i2c1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C2,		ck_ker_i2c2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I3C1,		ck_ker_i3c1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I3C2,		ck_ker_i3c2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C3,		ck_ker_i2c3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C5,		ck_ker_i2c5,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I3C3,		ck_ker_i3c3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C4,		ck_ker_i2c4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C6,		ck_ker_i2c6,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C7,		ck_ker_i2c7,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI1,		ck_ker_spi1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI4,		ck_ker_spi4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI5,		ck_ker_spi5,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI6,		ck_ker_spi6,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI7,		ck_ker_spi7,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_USART1,		ck_ker_usart1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_USART6,		ck_ker_usart6,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_UART7,		ck_ker_uart7,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_UART8,		ck_ker_uart8,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_UART9,		ck_ker_uart9,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_MDF1,		ck_ker_mdf1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SAI1,		ck_ker_sai1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SAI2,		ck_ker_sai2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SAI3,		ck_ker_sai3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SAI4,		ck_ker_sai4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_FDCAN,		ck_ker_fdcan,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_CSI,		ck_ker_csi,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_CSITXESC,		ck_ker_csitxesc,	SECF_NONE),
-	STM32_GATE_CFG(CK_KER_CSIPHY,		ck_ker_csiphy,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_USBTC,		ck_ker_usbtc,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I3C4,		ck_ker_i3c4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SPI8,		ck_ker_spi8,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_I2C8,		ck_ker_i2c8,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LPUART1,		ck_ker_lpuart1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LPTIM3,		ck_ker_lptim3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LPTIM4,		ck_ker_lptim4,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LPTIM5,		ck_ker_lptim5,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ADF1,		ck_ker_adf1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SDMMC1,		ck_ker_sdmmc1,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SDMMC2,		ck_ker_sdmmc2,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_SDMMC3,		ck_ker_sdmmc3,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ETH1,		ck_ker_eth1,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH1_STP,		ck_ker_eth1stp,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ETHSW,		ck_ker_ethsw,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ETH2,		ck_ker_eth2,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH2_STP,		ck_ker_eth2stp,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ETH1PTP,		ck_ker_eth1ptp,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ETH2PTP,		ck_ker_eth2ptp,		SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_GPU,		ck_icn_m_gpu,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_GPU,		ck_ker_gpu,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_ETHSWREF,		ck_ker_ethswref,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ETHSWACMCFG,	ck_icn_p_ethsw_acm_cfg,	SECF_NONE),
-	STM32_GATE_CFG(CK_BUS_ETHSWACMMSG, ck_icn_p_ethsw_acm_msg,	SECF_NONE),
-	STM32_GATE_CFG(CK_ETH1_MAC,		ck_ker_eth1mac,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH1_TX,		ck_ker_eth1tx,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH1_RX,		ck_ker_eth1rx,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH2_MAC,		ck_ker_eth2mac,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH2_TX,		ck_ker_eth2tx,		SECF_NONE),
-	STM32_GATE_CFG(CK_ETH2_RX,		ck_ker_eth2rx,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_MCO1,		ck_mco1,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_MCO2,		ck_mco2,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_ADC12,	ck_ker_adc12,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_ADC3,	ck_ker_adc3,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_USB2PHY1,	ck_ker_usb2phy1,	SECF_NONE),
-	STM32_GATE_CFG(CK_KER_USB2PHY2,		ck_ker_usb2phy2,	SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_USB2PHY2EN,	ck_ker_usb2phy2_en,	SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_USB3PCIEPHY,	ck_ker_usb3pciephy,	SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_DSIBLANE,	clk_lanebyte,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_DSIPHY,	clk_phy_dsi,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_LVDSPHY,	ck_ker_lvdsphy,		SECF_NONE),
-	STM32_COMPOSITE_CFG(CK_KER_DTS,		ck_ker_dts,		SECF_NONE),
-	STM32_GATE_CFG(CK_KER_LTDC,		ck_ker_ltdc,		SECF_NONE),
+	STM32_GATE_CFG(CK_BUS_ETH1,		ck_icn_p_eth1,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_BUS_ETH2,		ck_icn_p_eth2,		SEC_RIFSC(61)),
+	STM32_GATE_CFG(CK_BUS_PCIE,		ck_icn_p_pcie,		SEC_RIFSC(68)),
+	STM32_GATE_CFG(CK_BUS_ETHSW,		ck_icn_p_ethsw,		SEC_RIFSC(70)),
+	STM32_GATE_CFG(CK_BUS_ADC12,		ck_icn_p_adc12,		SEC_RIFSC(58)),
+	STM32_GATE_CFG(CK_BUS_ADC3,		ck_icn_p_adc3,		SEC_RIFSC(59)),
+	STM32_GATE_CFG(CK_BUS_CCI,		ck_icn_p_cci,		SEC_RIFSC(88)),
+	STM32_GATE_CFG(CK_BUS_CRC,		ck_icn_p_crc,		SEC_RIFSC(109)),
+	STM32_GATE_CFG(CK_BUS_MDF1,		ck_icn_p_mdf1,		SEC_RIFSC(54)),
+	STM32_GATE_CFG(CK_BUS_OSPIIOM,		ck_icn_p_ospiiom,	SEC_RIFSC(111)),
+	STM32_GATE_CFG(CK_BUS_HASH,		ck_icn_p_hash,		SEC_RIFSC(95)),
+	STM32_GATE_CFG(CK_BUS_CRYP1,		ck_icn_p_cryp1,		SEC_RIFSC(96)),
+	STM32_GATE_CFG(CK_BUS_CRYP2,		ck_icn_p_cryp2,		SEC_RIFSC(97)),
+	STM32_GATE_CFG(CK_BUS_ADF1,		ck_icn_p_adf1,		SEC_RIFSC(55)),
+	STM32_GATE_CFG(CK_BUS_SPI8,		ck_icn_p_spi8,		SEC_RIFSC(29)),
+	STM32_GATE_CFG(CK_BUS_LPUART1,		ck_icn_p_lpuart1,	SEC_RIFSC(40)),
+	STM32_GATE_CFG(CK_BUS_I2C8,		ck_icn_p_i2c8,		SEC_RIFSC(48)),
+	STM32_GATE_CFG(CK_BUS_LPTIM3,		ck_icn_p_lptim3,	SEC_RIFSC(19)),
+	STM32_GATE_CFG(CK_BUS_LPTIM4,		ck_icn_p_lptim4,	SEC_RIFSC(20)),
+	STM32_GATE_CFG(CK_BUS_LPTIM5,		ck_icn_p_lptim5,	SEC_RIFSC(21)),
+	STM32_GATE_CFG(CK_BUS_IWDG5,		ck_icn_p_iwdg5,		SEC_RIFSC(102)),
+	STM32_GATE_CFG(CK_BUS_WWDG2,		ck_icn_p_wwdg2,		SEC_RIFSC(104)),
+	STM32_GATE_CFG(CK_BUS_I3C4,		ck_icn_p_i3c4,		SEC_RIFSC(117)),
+	STM32_GATE_CFG(CK_BUS_SDMMC1,		ck_icn_m_sdmmc1,	SEC_RIFSC(76)),
+	STM32_GATE_CFG(CK_BUS_SDMMC2,		ck_icn_m_sdmmc2,	SEC_RIFSC(77)),
+	STM32_GATE_CFG(CK_BUS_SDMMC3,		ck_icn_m_sdmmc3,	SEC_RIFSC(78)),
+	STM32_GATE_CFG(CK_BUS_USB2OHCI,		ck_icn_m_usb2ohci,	SEC_RIFSC(63)),
+	STM32_GATE_CFG(CK_BUS_USB2EHCI,		ck_icn_m_usb2ehci,	SEC_RIFSC(63)),
+	STM32_GATE_CFG(CK_BUS_USB3DR,		ck_icn_m_usb3dr,	SEC_RIFSC(66)),
+	STM32_GATE_CFG(CK_BUS_TIM2,		ck_icn_p_tim2,		SEC_RIFSC(1)),
+	STM32_GATE_CFG(CK_BUS_TIM3,		ck_icn_p_tim3,		SEC_RIFSC(2)),
+	STM32_GATE_CFG(CK_BUS_TIM4,		ck_icn_p_tim4,		SEC_RIFSC(3)),
+	STM32_GATE_CFG(CK_BUS_TIM5,		ck_icn_p_tim5,		SEC_RIFSC(4)),
+	STM32_GATE_CFG(CK_BUS_TIM6,		ck_icn_p_tim6,		SEC_RIFSC(5)),
+	STM32_GATE_CFG(CK_BUS_TIM7,		ck_icn_p_tim7,		SEC_RIFSC(6)),
+	STM32_GATE_CFG(CK_BUS_TIM10,		ck_icn_p_tim10,		SEC_RIFSC(8)),
+	STM32_GATE_CFG(CK_BUS_TIM11,		ck_icn_p_tim11,		SEC_RIFSC(9)),
+	STM32_GATE_CFG(CK_BUS_TIM12,		ck_icn_p_tim12,		SEC_RIFSC(10)),
+	STM32_GATE_CFG(CK_BUS_TIM13,		ck_icn_p_tim13,		SEC_RIFSC(11)),
+	STM32_GATE_CFG(CK_BUS_TIM14,		ck_icn_p_tim14,		SEC_RIFSC(12)),
+	STM32_GATE_CFG(CK_BUS_LPTIM1,		ck_icn_p_lptim1,	SEC_RIFSC(17)),
+	STM32_GATE_CFG(CK_BUS_LPTIM2,		ck_icn_p_lptim2,	SEC_RIFSC(18)),
+	STM32_GATE_CFG(CK_BUS_SPI2,		ck_icn_p_spi2,		SEC_RIFSC(23)),
+	STM32_GATE_CFG(CK_BUS_SPI3,		ck_icn_p_spi3,		SEC_RIFSC(24)),
+	STM32_GATE_CFG(CK_BUS_SPDIFRX,		ck_icn_p_spdifrx,	SEC_RIFSC(30)),
+	STM32_GATE_CFG(CK_BUS_USART2,		ck_icn_p_usart2,	SEC_RIFSC(32)),
+	STM32_GATE_CFG(CK_BUS_USART3,		ck_icn_p_usart3,	SEC_RIFSC(33)),
+	STM32_GATE_CFG(CK_BUS_UART4,		ck_icn_p_uart4,		SEC_RIFSC(34)),
+	STM32_GATE_CFG(CK_BUS_UART5,		ck_icn_p_uart5,		SEC_RIFSC(35)),
+	STM32_GATE_CFG(CK_BUS_I2C1,		ck_icn_p_i2c1,		SEC_RIFSC(41)),
+	STM32_GATE_CFG(CK_BUS_I2C2,		ck_icn_p_i2c2,		SEC_RIFSC(42)),
+	STM32_GATE_CFG(CK_BUS_I2C3,		ck_icn_p_i2c3,		SEC_RIFSC(43)),
+	STM32_GATE_CFG(CK_BUS_I2C4,		ck_icn_p_i2c4,		SEC_RIFSC(44)),
+	STM32_GATE_CFG(CK_BUS_I2C5,		ck_icn_p_i2c5,		SEC_RIFSC(45)),
+	STM32_GATE_CFG(CK_BUS_I2C6,		ck_icn_p_i2c6,		SEC_RIFSC(46)),
+	STM32_GATE_CFG(CK_BUS_I2C7,		ck_icn_p_i2c7,		SEC_RIFSC(47)),
+	STM32_GATE_CFG(CK_BUS_I3C1,		ck_icn_p_i3c1,		SEC_RIFSC(114)),
+	STM32_GATE_CFG(CK_BUS_I3C2,		ck_icn_p_i3c2,		SEC_RIFSC(115)),
+	STM32_GATE_CFG(CK_BUS_I3C3,		ck_icn_p_i3c3,		SEC_RIFSC(116)),
+	STM32_GATE_CFG(CK_BUS_TIM1,		ck_icn_p_tim1,		SEC_RIFSC(0)),
+	STM32_GATE_CFG(CK_BUS_TIM8,		ck_icn_p_tim8,		SEC_RIFSC(7)),
+	STM32_GATE_CFG(CK_BUS_TIM15,		ck_icn_p_tim15,		SEC_RIFSC(13)),
+	STM32_GATE_CFG(CK_BUS_TIM16,		ck_icn_p_tim16,		SEC_RIFSC(14)),
+	STM32_GATE_CFG(CK_BUS_TIM17,		ck_icn_p_tim17,		SEC_RIFSC(15)),
+	STM32_GATE_CFG(CK_BUS_TIM20,		ck_icn_p_tim20,		SEC_RIFSC(16)),
+	STM32_GATE_CFG(CK_BUS_SAI1,		ck_icn_p_sai1,		SEC_RIFSC(49)),
+	STM32_GATE_CFG(CK_BUS_SAI2,		ck_icn_p_sai2,		SEC_RIFSC(50)),
+	STM32_GATE_CFG(CK_BUS_SAI3,		ck_icn_p_sai3,		SEC_RIFSC(51)),
+	STM32_GATE_CFG(CK_BUS_SAI4,		ck_icn_p_sai4,		SEC_RIFSC(52)),
+	STM32_GATE_CFG(CK_BUS_USART1,		ck_icn_p_usart1,	SEC_RIFSC(31)),
+	STM32_GATE_CFG(CK_BUS_USART6,		ck_icn_p_usart6,	SEC_RIFSC(36)),
+	STM32_GATE_CFG(CK_BUS_UART7,		ck_icn_p_uart7,		SEC_RIFSC(37)),
+	STM32_GATE_CFG(CK_BUS_UART8,		ck_icn_p_uart8,		SEC_RIFSC(38)),
+	STM32_GATE_CFG(CK_BUS_UART9,		ck_icn_p_uart9,		SEC_RIFSC(39)),
+	STM32_GATE_CFG(CK_BUS_FDCAN,		ck_icn_p_fdcan,		SEC_RIFSC(56)),
+	STM32_GATE_CFG(CK_BUS_SPI1,		ck_icn_p_spi1,		SEC_RIFSC(22)),
+	STM32_GATE_CFG(CK_BUS_SPI4,		ck_icn_p_spi4,		SEC_RIFSC(25)),
+	STM32_GATE_CFG(CK_BUS_SPI5,		ck_icn_p_spi5,		SEC_RIFSC(26)),
+	STM32_GATE_CFG(CK_BUS_SPI6,		ck_icn_p_spi6,		SEC_RIFSC(27)),
+	STM32_GATE_CFG(CK_BUS_SPI7,		ck_icn_p_spi7,		SEC_RIFSC(28)),
+	STM32_GATE_CFG(CK_BUS_IWDG2,		ck_icn_p_iwdg2,		SEC_RIFSC(99)),
+	STM32_GATE_CFG(CK_BUS_IWDG3,		ck_icn_p_iwdg3,		SEC_RIFSC(100)),
+	STM32_GATE_CFG(CK_BUS_IWDG4,		ck_icn_p_iwdg4,		SEC_RIFSC(101)),
+	STM32_GATE_CFG(CK_BUS_WWDG1,		ck_icn_p_wwdg1,		SEC_RIFSC(103)),
+	STM32_GATE_CFG(CK_BUS_VREF,		ck_icn_p_vref,		SEC_RIFSC(106)),
+	STM32_GATE_CFG(CK_BUS_HDP,		ck_icn_p_hdp,		SEC_RIFSC(57)),
+	STM32_GATE_CFG(CK_BUS_IS2M,		ck_icn_p_is2m,		MP25_RIF_RCC_IS2M),
+	STM32_GATE_CFG(CK_BUS_DSI,		ck_icn_p_dsi,		SEC_RIFSC(81)),
+	STM32_GATE_CFG(CK_BUS_LTDC,		ck_icn_p_ltdc,		SEC_RIFSC(80)),
+	STM32_GATE_CFG(CK_BUS_CSI,		ck_icn_p_csi,		SEC_RIFSC(86)),
+	STM32_GATE_CFG(CK_BUS_DCMIPP,		ck_icn_p_dcmipp,	SEC_RIFSC(87)),
+	STM32_GATE_CFG(CK_BUS_LVDS,		ck_icn_p_lvds,		SEC_RIFSC(84)),
+	STM32_GATE_CFG(CK_BUS_USBTC,		ck_icn_p_usbtc,		SEC_RIFSC(69)),
+	STM32_GATE_CFG(CK_BUS_USB3PCIEPHY,	ck_icn_p_usb3pciephy,	SEC_RIFSC(67)),
+	STM32_GATE_CFG(CK_BUS_VDEC,		ck_icn_p_vdec,		SEC_RIFSC(89)),
+	STM32_GATE_CFG(CK_BUS_VENC,		ck_icn_p_venc,		SEC_RIFSC(90)),
+	STM32_GATE_CFG(CK_KER_TIM2,		ck_ker_tim2,		SEC_RIFSC(1)),
+	STM32_GATE_CFG(CK_KER_TIM3,		ck_ker_tim3,		SEC_RIFSC(2)),
+	STM32_GATE_CFG(CK_KER_TIM4,		ck_ker_tim4,		SEC_RIFSC(3)),
+	STM32_GATE_CFG(CK_KER_TIM5,		ck_ker_tim5,		SEC_RIFSC(4)),
+	STM32_GATE_CFG(CK_KER_TIM6,		ck_ker_tim6,		SEC_RIFSC(5)),
+	STM32_GATE_CFG(CK_KER_TIM7,		ck_ker_tim7,		SEC_RIFSC(6)),
+	STM32_GATE_CFG(CK_KER_TIM10,		ck_ker_tim10,		SEC_RIFSC(8)),
+	STM32_GATE_CFG(CK_KER_TIM11,		ck_ker_tim11,		SEC_RIFSC(9)),
+	STM32_GATE_CFG(CK_KER_TIM12,		ck_ker_tim12,		SEC_RIFSC(10)),
+	STM32_GATE_CFG(CK_KER_TIM13,		ck_ker_tim13,		SEC_RIFSC(11)),
+	STM32_GATE_CFG(CK_KER_TIM14,		ck_ker_tim14,		SEC_RIFSC(12)),
+	STM32_GATE_CFG(CK_KER_TIM1,		ck_ker_tim1,		SEC_RIFSC(0)),
+	STM32_GATE_CFG(CK_KER_TIM8,		ck_ker_tim8,		SEC_RIFSC(7)),
+	STM32_GATE_CFG(CK_KER_TIM15,		ck_ker_tim15,		SEC_RIFSC(13)),
+	STM32_GATE_CFG(CK_KER_TIM16,		ck_ker_tim16,		SEC_RIFSC(14)),
+	STM32_GATE_CFG(CK_KER_TIM17,		ck_ker_tim17,		SEC_RIFSC(15)),
+	STM32_GATE_CFG(CK_KER_TIM20,		ck_ker_tim20,		SEC_RIFSC(16)),
+	STM32_GATE_CFG(CK_KER_LPTIM1,		ck_ker_lptim1,		SEC_RIFSC(17)),
+	STM32_GATE_CFG(CK_KER_LPTIM2,		ck_ker_lptim2,		SEC_RIFSC(18)),
+	STM32_GATE_CFG(CK_KER_USART2,		ck_ker_usart2,		SEC_RIFSC(32)),
+	STM32_GATE_CFG(CK_KER_UART4,		ck_ker_uart4,		SEC_RIFSC(34)),
+	STM32_GATE_CFG(CK_KER_USART3,		ck_ker_usart3,		SEC_RIFSC(33)),
+	STM32_GATE_CFG(CK_KER_UART5,		ck_ker_uart5,		SEC_RIFSC(35)),
+	STM32_GATE_CFG(CK_KER_SPI2,		ck_ker_spi2,		SEC_RIFSC(23)),
+	STM32_GATE_CFG(CK_KER_SPI3,		ck_ker_spi3,		SEC_RIFSC(24)),
+	STM32_GATE_CFG(CK_KER_SPDIFRX,		ck_ker_spdifrx,		SEC_RIFSC(30)),
+	STM32_GATE_CFG(CK_KER_I2C1,		ck_ker_i2c1,		SEC_RIFSC(41)),
+	STM32_GATE_CFG(CK_KER_I2C2,		ck_ker_i2c2,		SEC_RIFSC(42)),
+	STM32_GATE_CFG(CK_KER_I3C1,		ck_ker_i3c1,		SEC_RIFSC(114)),
+	STM32_GATE_CFG(CK_KER_I3C2,		ck_ker_i3c2,		SEC_RIFSC(115)),
+	STM32_GATE_CFG(CK_KER_I2C3,		ck_ker_i2c3,		SEC_RIFSC(43)),
+	STM32_GATE_CFG(CK_KER_I2C5,		ck_ker_i2c5,		SEC_RIFSC(45)),
+	STM32_GATE_CFG(CK_KER_I3C3,		ck_ker_i3c3,		SEC_RIFSC(116)),
+	STM32_GATE_CFG(CK_KER_I2C4,		ck_ker_i2c4,		SEC_RIFSC(44)),
+	STM32_GATE_CFG(CK_KER_I2C6,		ck_ker_i2c6,		SEC_RIFSC(46)),
+	STM32_GATE_CFG(CK_KER_I2C7,		ck_ker_i2c7,		SEC_RIFSC(47)),
+	STM32_GATE_CFG(CK_KER_SPI1,		ck_ker_spi1,		SEC_RIFSC(22)),
+	STM32_GATE_CFG(CK_KER_SPI4,		ck_ker_spi4,		SEC_RIFSC(25)),
+	STM32_GATE_CFG(CK_KER_SPI5,		ck_ker_spi5,		SEC_RIFSC(26)),
+	STM32_GATE_CFG(CK_KER_SPI6,		ck_ker_spi6,		SEC_RIFSC(27)),
+	STM32_GATE_CFG(CK_KER_SPI7,		ck_ker_spi7,		SEC_RIFSC(28)),
+	STM32_GATE_CFG(CK_KER_USART1,		ck_ker_usart1,		SEC_RIFSC(31)),
+	STM32_GATE_CFG(CK_KER_USART6,		ck_ker_usart6,		SEC_RIFSC(36)),
+	STM32_GATE_CFG(CK_KER_UART7,		ck_ker_uart7,		SEC_RIFSC(37)),
+	STM32_GATE_CFG(CK_KER_UART8,		ck_ker_uart8,		SEC_RIFSC(38)),
+	STM32_GATE_CFG(CK_KER_UART9,		ck_ker_uart9,		SEC_RIFSC(39)),
+	STM32_GATE_CFG(CK_KER_MDF1,		ck_ker_mdf1,		SEC_RIFSC(54)),
+	STM32_GATE_CFG(CK_KER_SAI1,		ck_ker_sai1,		SEC_RIFSC(49)),
+	STM32_GATE_CFG(CK_KER_SAI2,		ck_ker_sai2,		SEC_RIFSC(50)),
+	STM32_GATE_CFG(CK_KER_SAI3,		ck_ker_sai3,		SEC_RIFSC(51)),
+	STM32_GATE_CFG(CK_KER_SAI4,		ck_ker_sai4,		SEC_RIFSC(52)),
+	STM32_GATE_CFG(CK_KER_FDCAN,		ck_ker_fdcan,		SEC_RIFSC(56)),
+	STM32_GATE_CFG(CK_KER_CSI,		ck_ker_csi,		SEC_RIFSC(86)),
+	STM32_GATE_CFG(CK_KER_CSITXESC,		ck_ker_csitxesc,	SEC_RIFSC(86)),
+	STM32_GATE_CFG(CK_KER_CSIPHY,		ck_ker_csiphy,		SEC_RIFSC(86)),
+	STM32_GATE_CFG(CK_KER_USBTC,		ck_ker_usbtc,		SEC_RIFSC(69)),
+	STM32_GATE_CFG(CK_KER_I3C4,		ck_ker_i3c4,		SEC_RIFSC(117)),
+	STM32_GATE_CFG(CK_KER_SPI8,		ck_ker_spi8,		SEC_RIFSC(29)),
+	STM32_GATE_CFG(CK_KER_I2C8,		ck_ker_i2c8,		SEC_RIFSC(48)),
+	STM32_GATE_CFG(CK_KER_LPUART1,		ck_ker_lpuart1,		SEC_RIFSC(40)),
+	STM32_GATE_CFG(CK_KER_LPTIM3,		ck_ker_lptim3,		SEC_RIFSC(19)),
+	STM32_GATE_CFG(CK_KER_LPTIM4,		ck_ker_lptim4,		SEC_RIFSC(20)),
+	STM32_GATE_CFG(CK_KER_LPTIM5,		ck_ker_lptim5,		SEC_RIFSC(21)),
+	STM32_GATE_CFG(CK_KER_ADF1,		ck_ker_adf1,		SEC_RIFSC(55)),
+	STM32_GATE_CFG(CK_KER_SDMMC1,		ck_ker_sdmmc1,		SEC_RIFSC(76)),
+	STM32_GATE_CFG(CK_KER_SDMMC2,		ck_ker_sdmmc2,		SEC_RIFSC(77)),
+	STM32_GATE_CFG(CK_KER_SDMMC3,		ck_ker_sdmmc3,		SEC_RIFSC(78)),
+	STM32_GATE_CFG(CK_KER_ETH1,		ck_ker_eth1,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_ETH1_STP,		ck_ker_eth1stp,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_KER_ETHSW,		ck_ker_ethsw,		SEC_RIFSC(70)),
+	STM32_GATE_CFG(CK_KER_ETH2,		ck_ker_eth2,		SEC_RIFSC(61)),
+	STM32_GATE_CFG(CK_ETH2_STP,		ck_ker_eth2stp,		SEC_RIFSC(61)),
+	STM32_GATE_CFG(CK_KER_ETH1PTP,		ck_ker_eth1ptp,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_KER_ETH2PTP,		ck_ker_eth2ptp,		SEC_RIFSC(61)),
+	STM32_GATE_CFG(CK_BUS_GPU,		ck_icn_m_gpu,		SEC_RIFSC(79)),
+	STM32_GATE_CFG(CK_KER_GPU,		ck_ker_gpu,		SEC_RIFSC(79)),
+	STM32_GATE_CFG(CK_KER_ETHSWREF,		ck_ker_ethswref,	SEC_RIFSC(70)),
+	STM32_GATE_CFG(CK_BUS_ETHSWACMCFG,	ck_icn_p_ethsw_acm_cfg,	SEC_RIFSC(71)),
+	STM32_GATE_CFG(CK_BUS_ETHSWACMMSG,	ck_icn_p_ethsw_acm_msg,	SEC_RIFSC(72)),
+	STM32_GATE_CFG(CK_ETH1_MAC,		ck_ker_eth1mac,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_ETH1_TX,		ck_ker_eth1tx,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_ETH1_RX,		ck_ker_eth1rx,		SEC_RIFSC(60)),
+	STM32_GATE_CFG(CK_ETH2_MAC,		ck_ker_eth2mac,		SEC_RIFSC(61)),
+	STM32_GATE_CFG(CK_ETH2_TX,		ck_ker_eth2tx,		SEC_RIFSC(61)),
+	STM32_GATE_CFG(CK_ETH2_RX,		ck_ker_eth2rx,		SEC_RIFSC(61)),
+	STM32_COMPOSITE_CFG(CK_MCO1,		ck_mco1,		MP25_RIF_RCC_MCO1),
+	STM32_COMPOSITE_CFG(CK_MCO2,		ck_mco2,		MP25_RIF_RCC_MCO1),
+	STM32_COMPOSITE_CFG(CK_KER_ADC12,	ck_ker_adc12,		SEC_RIFSC(58)),
+	STM32_COMPOSITE_CFG(CK_KER_ADC3,	ck_ker_adc3,		SEC_RIFSC(59)),
+	STM32_COMPOSITE_CFG(CK_KER_USB2PHY1,	ck_ker_usb2phy1,	SEC_RIFSC(63)),
+	STM32_GATE_CFG(CK_KER_USB2PHY2,		ck_ker_usb2phy2,	SEC_RIFSC(63)),
+	STM32_COMPOSITE_CFG(CK_KER_USB2PHY2EN,	ck_ker_usb2phy2_en,	SEC_RIFSC(63)),
+	STM32_COMPOSITE_CFG(CK_KER_USB3PCIEPHY,	ck_ker_usb3pciephy,	SEC_RIFSC(67)),
+	STM32_COMPOSITE_CFG(CK_KER_DSIBLANE,	clk_lanebyte,		SEC_RIFSC(81)),
+	STM32_COMPOSITE_CFG(CK_KER_DSIPHY,	clk_phy_dsi,		SEC_RIFSC(81)),
+	STM32_COMPOSITE_CFG(CK_KER_LVDSPHY,	ck_ker_lvdsphy,		SEC_RIFSC(84)),
+	STM32_COMPOSITE_CFG(CK_KER_DTS,		ck_ker_dts,		SEC_RIFSC(107)),
+	STM32_GATE_CFG(CK_KER_LTDC,		ck_ker_ltdc,		SEC_RIFSC(80)),
 };
 
 #define RESET_MP25(id, _offset, _bit_idx, _set_clr)	\
@@ -1839,6 +1923,7 @@ static const struct stm32_rcc_match_data stm32mp25_data = {
 	.maxbinding	= STM32MP25_LAST_CLK,
 	.clock_data	= &stm32mp25_clock_data,
 	.reset_data	= &stm32mp25_reset_data,
+	.check_security = &stm32mp25_check_security,
 };
 
 static const struct of_device_id stm32mp25_match_data[] = {
-- 
2.25.1


