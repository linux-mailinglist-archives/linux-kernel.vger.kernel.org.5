Return-Path: <linux-kernel+bounces-140673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585CC8A17A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6092B1C209B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C1729428;
	Thu, 11 Apr 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5kuQXLaV"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3B21340;
	Thu, 11 Apr 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846418; cv=none; b=rnsDemr7ZpF/HbQdrVURCv45/21iZUR1M9nKtuDWmNMum2/cLdbZ27XN7/khHYVGs+rHwVT7A0rrcyRDQwf9hSZ+lTg7K2kvvVNPHpGj1IJ74VKhNLSh8nZqF8lRCNb+LcMKIaQFsNUKhL2ohPF9pZBkGoTAPT1VBvZU5XcoEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846418; c=relaxed/simple;
	bh=IKspCoq4ADW3i1gSVAAY46SDMJr0J+CkwQY3Dex11C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON7+XI0dbIVRgesBmBrRkzL2TmtIfyczRZ41kqs9wZE7O33loBG9egVbLXyKxwCQtNrisViFXV1ox8sCXv1+g+d2Q6KpU4xXbdNT/Z4OKCuJrwGLVzkYIzgLU9cnwSt0GuxFJngIhuVOJ6GsJA76uqKvs+JtVGB9IgfdeBoDxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5kuQXLaV; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BDxrnp029809;
	Thu, 11 Apr 2024 16:39:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=apa5DF5P4haEw0D9FiaNe0iffZu62o/fBJKD6Mic6so=; b=5k
	uQXLaVtKBeTVx4RyoVaQBz72/tNOyQmx3WGt4NKUpZRt+gnBcmiVVw89YviCyChC
	uufMtIIX9L8SjN4Cxn4gSuEImD0LA00GOBaqezxMSz7pxwu0Do76aceNkoSBpJI9
	h1njyHjNwHsDhn/0Nmd6tQr+If5/bVohV+7ZwwUrKU4J+ExQ4M140QhHymmrmdg8
	itcP/jgiMF7rfeY/JejheoDY7NJ8qyWGtP3+esN7sfuPgFTHHF53LHc5jSwiQGSg
	kQj6O8zh1nxO7k83YjINu4QFcEmZ4JjHnzpf7m1Ug4V9UANQJDKZ6E+nECg7ZOI1
	QR6WJRBag1bWAE5brEEw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xaw9d59au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:39:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0B2C94002D;
	Thu, 11 Apr 2024 16:39:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 562C6216821;
	Thu, 11 Apr 2024 16:38:36 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:38:35 +0200
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
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] net: ethernet: stmmac: stm32: update config management for phy wo cristal
Date: Thu, 11 Apr 2024 16:36:52 +0200
Message-ID: <20240411143658.1049706-6-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

Some cleaning because some Ethernet PHY configs do not need to add
st,ext-phyclk property.
Change print info message "No phy clock provided" only when debug.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 7529a8d154920..e648c4e790a78 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -55,17 +55,17 @@
  *|         |        |      25MHz    |        50MHz       |                  |
  * ---------------------------------------------------------------------------
  *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
- *|         |        | st,ext-phyclk |                    |		     |
+ *|         |        |	             |                    |		     |
  * ---------------------------------------------------------------------------
  *|  GMII   |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
- *|         |        | st,ext-phyclk |                    |		     |
+ *|         |        |               |                    |		     |
  * ---------------------------------------------------------------------------
  *| RGMII   |	 -   |     eth-ck    |	      n/a	  |      eth-ck      |
- *|         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
+ *|         |        |               |                    | st,eth-clk-sel or|
  *|         |        |               |                    | st,ext-phyclk    |
  * ---------------------------------------------------------------------------
  *| RMII    |	 -   |     eth-ck    |	    eth-ck        |	  n/a        |
- *|         |        | st,ext-phyclk | st,eth-ref-clk-sel |		     |
+ *|         |        |               | st,eth-ref-clk-sel |		     |
  *|         |        |               | or st,ext-phyclk   |		     |
  * ---------------------------------------------------------------------------
  *
@@ -174,23 +174,22 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	dwmac->enable_eth_ck = false;
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
+		if (clk_rate == ETH_CK_F_25M)
 			dwmac->enable_eth_ck = true;
 		val = dwmac->ops->pmcsetr.eth1_selmii;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (clk_rate == ETH_CK_F_25M &&
-		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (clk_rate == ETH_CK_F_25M)
 			dwmac->enable_eth_ck = true;
-			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
+		if (clk_rate == ETH_CK_F_25M)
+			dwmac->enable_eth_ck = true;
+		if (clk_rate == ETH_CK_F_50M &&
 		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
 			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
@@ -203,7 +202,9 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
+		if (clk_rate == ETH_CK_F_25M)
+			dwmac->enable_eth_ck = true;
+		if (clk_rate == ETH_CK_F_125M &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
 			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
@@ -219,7 +220,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	/* Need to update PMCCLRR (clear register) */
-	regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
+	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
 		     dwmac->mode_mask);
 
 	/* Update PMCSETR (set register) */
@@ -328,7 +329,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	/*  Get ETH_CLK clocks */
 	dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
 	if (IS_ERR(dwmac->clk_eth_ck)) {
-		dev_info(dev, "No phy clock provided...\n");
+		dev_dbg(dev, "No phy clock provided...\n");
 		dwmac->clk_eth_ck = NULL;
 	}
 
-- 
2.25.1


