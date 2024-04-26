Return-Path: <linux-kernel+bounces-160014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A788B37B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2990AB23666
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510A148843;
	Fri, 26 Apr 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2F8d1h3v"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E65146D51;
	Fri, 26 Apr 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136393; cv=none; b=FwH4vrVMO9XWkdAupr8eRDnvhbm7H50ZijBzA89OzjK/nld445HVrn6j+YfWa0qvBS8MWYACQLIZDwWcuc3PNF+8FI7bltVyhvvVNnSMd9ZXVBziIlUKUrBaR5BKO6A9Wk5NAxeFt44JCP1iozXc1QjqRiKI8kWnkFawDMjxaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136393; c=relaxed/simple;
	bh=EIva1o/gXMQp7IWDORL0GnC39kF5VrcwcKfaF7S9cFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1sGWr90KCjucYDttNiTUIpebv4wRUHiWrLdV6nPW7GN/iRRat4gCM5M6nd/BB17zyczJ0AEHxBp5ep2hocxIlvozMvUiVxIs+SJWEQa0kYK+d6H1K5FpQJTMc5s8Ls62osu/NgfSnJMmND3xU2BrtYHSLwHasrcmCvn2odv/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2F8d1h3v; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9YPXh012219;
	Fri, 26 Apr 2024 14:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=8sB1ikOtdlQ3NXaefe2u/s/cUhwF4Zg2dm963RYFnU0=; b=2F
	8d1h3v6VIJeUusZzqWJVb+xBWGTT6uUkOD5UnMqzy861lnI6mhg1tDLtdn+AKmWx
	HZwfSEdWeWTgmJw04cJ05Cuwfaqk4wJiNIZN8fE2pocArHeRxJpHg09ibRvtdaBj
	WSyt2PStowECXy9tlG7lI1Q5Lvc2vxpQzKj1Knk/No/bcOAxiaFKl2MsQ+RWUJn5
	3GlMxX43skomTJg9DuyYWUbOy3YKUDm3n/mqpN2fddd0Oqx02/SSh1htkoXFBTKs
	IHqpfHFbIvd9keP04pxWXs0aBh9Pmmf8+KtrIebwZlWQM6wGrKaTv5i1XOA0FUUW
	5kpyviAm1JnwbmuEW8yA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmq9108bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:59:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 709C640045;
	Fri, 26 Apr 2024 14:59:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C8AF222C9F;
	Fri, 26 Apr 2024 14:58:05 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:58:04 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/11] net: stmmac: dwmac-stm32: rework glue to simplify management
Date: Fri, 26 Apr 2024 14:56:59 +0200
Message-ID: <20240426125707.585269-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Change glue to be more generic and manage easily next stm32 products.
The goal of this commit is to have one stm32mp1_set_mode function which
can manage different STM32 SOC. SOC can have different SYSCFG register
bitfields. so in pmcsetr we defined the bitfields corresponding to the SOC.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 76 +++++++++++++------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index c92dfc4ecf57..68a02de25ac7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -23,10 +23,6 @@
 
 #define SYSCFG_MCU_ETH_MASK		BIT(23)
 #define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
-#define SYSCFG_PMCCLRR_OFFSET		0x40
-
-#define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
-#define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
 
 /* CLOCK feed to PHY*/
 #define ETH_CK_F_25M	25000000
@@ -46,9 +42,6 @@
  * RMII  |   1	 |   0	  |   0	   |  n/a  |
  *------------------------------------------
  */
-#define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
-#define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
-#define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
 #define SYSCFG_PMCR_ETH_SEL_GMII	0
 #define SYSCFG_MCU_ETH_SEL_MII		0
 #define SYSCFG_MCU_ETH_SEL_RMII		1
@@ -90,19 +83,33 @@ struct stm32_dwmac {
 	int eth_ref_clk_sel_reg;
 	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
+	u32 mode_mask;
 	struct regmap *regmap;
 	u32 speed;
 	const struct stm32_ops *ops;
 	struct device *dev;
 };
 
+struct stm32_syscfg_pmcsetr {
+	u32 eth1_clk_sel;
+	u32 eth1_ref_clk_sel;
+	u32 eth1_selmii;
+	u32 eth1_sel_rgmii;
+	u32 eth1_sel_rmii;
+	u32 eth2_clk_sel;
+	u32 eth2_ref_clk_sel;
+	u32 eth2_sel_rgmii;
+	u32 eth2_sel_rmii;
+};
+
 struct stm32_ops {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
 	int (*suspend)(struct stm32_dwmac *dwmac);
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
-	u32 syscfg_eth_mask;
+	u32 syscfg_clr_off;
+	struct stm32_syscfg_pmcsetr pmcsetr;
 	bool clk_rx_enable_in_suspend;
 };
 
@@ -161,7 +168,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	u32 reg = dwmac->mode_reg, clk_rate;
-	int val;
+	int val = 0;
 
 	clk_rate = clk_get_rate(dwmac->clk_eth_ck);
 	dwmac->enable_eth_ck = false;
@@ -169,7 +176,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_MII:
 		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
 			dwmac->enable_eth_ck = true;
-		val = SYSCFG_PMCR_ETH_SEL_MII;
+		val = dwmac->ops->pmcsetr.eth1_selmii;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
@@ -177,16 +184,17 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		if (clk_rate == ETH_CK_F_25M &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		val = SYSCFG_PMCR_ETH_SEL_RMII;
+		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
 		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
 		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
+			val |= dwmac->ops->pmcsetr.eth2_ref_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
@@ -194,11 +202,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		val = SYSCFG_PMCR_ETH_SEL_RGMII;
+		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
 		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
+			val |= dwmac->ops->pmcsetr.eth2_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
@@ -210,12 +219,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	/* Need to update PMCCLRR (clear register) */
-	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
-		     dwmac->ops->syscfg_eth_mask);
+	regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
+		     dwmac->mode_mask);
 
 	/* Update PMCSETR (set register) */
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val);
+				 dwmac->mode_mask, val);
 }
 
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -241,7 +250,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val << 23);
+				 SYSCFG_MCU_ETH_MASK, val << 23);
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
@@ -286,10 +295,17 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 		return PTR_ERR(dwmac->regmap);
 
 	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
+	if (err) {
+		dev_err(dev, "Can't get sysconfig register offset (%d)\n", err);
+		return err;
+	}
+
+	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
+	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
 	if (err)
-		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
+		pr_debug("Warning sysconfig register mask not set\n");
 
-	return err;
+	return 0;
 }
 
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
@@ -478,8 +494,7 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 	stm32_dwmac_suspend, stm32_dwmac_resume);
 
 static struct stm32_ops stm32mcu_dwmac_data = {
-	.set_mode = stm32mcu_set_mode,
-	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
+	.set_mode = stm32mcu_set_mode
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
@@ -487,8 +502,19 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
-	.clk_rx_enable_in_suspend = true
+	.clk_rx_enable_in_suspend = true,
+	.syscfg_clr_off = 0x44,
+	.pmcsetr = {
+		.eth1_clk_sel		= BIT(16),
+		.eth1_ref_clk_sel	= BIT(17),
+		.eth1_selmii		= BIT(20),
+		.eth1_sel_rgmii		= BIT(21),
+		.eth1_sel_rmii		= BIT(23),
+		.eth2_clk_sel		= 0,
+		.eth2_ref_clk_sel	= 0,
+		.eth2_sel_rgmii		= 0,
+		.eth2_sel_rmii		= 0
+	}
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
-- 
2.25.1


