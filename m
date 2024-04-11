Return-Path: <linux-kernel+bounces-140674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB98A17A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41ABE1C20F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10C2942C;
	Thu, 11 Apr 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="05hr5bql"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943A219FF;
	Thu, 11 Apr 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846418; cv=none; b=JrpM186HG/Tczo1hc6B0K7cGFyKClWqOaBxepqhtcDAeBglhqrf61onQGbSpUOCoguzzjsm2kEQ+EqCyY15ODP941Of4zHUzRGkCZBcDIWZu69QzCQQK45AFR9juvzIdlbH4L5n5Kkev/NvWcDZVUPNLHXVcBZefll5hiYbeZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846418; c=relaxed/simple;
	bh=KqIzjIXDRy7bmxFkI5JP21C11AhDPkvBuXIyFp7tOGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ta3eGcKhAB8G4XXLIS6pCiH291RJVsBI6dQJ3uvR1y/req6DcOj8A70AWsQTsiJWISJiljPBSkwKDMRzDMJRoybs5mjVPCVhVdgOsnxMg1HiogxUp8Ldr4LDgx0wmUEjkbdXi+GZCs5lQ4eBzj83s4GDwBtMGbNz0P8xLwfz8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=05hr5bql; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BDROjo029165;
	Thu, 11 Apr 2024 16:39:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=lmuT1TQX9KX0XMZKPrpyK3DzjQlXsMn6u/Q9ctOGe5I=; b=05
	hr5bqlgUo0AFYhH55jTzcpfFx0dCQEblHkeMpX6a6F/CTpsszW4KQ9j8Tw8ZwN/B
	URb3bWBIpqdo+4RQms2tUW8qz/kS9uWKLuXfVvimCFCcL/mmo+N2U0L3lRn5hrAr
	LwWeh6HqNWIGHrGwb5vVhpU/eJ34l4JZsv8UfEKvKxH6/c9+d7ok5dijCJKVtn85
	+kOW0iMCbQsLlTWBfKklmYKRSrmx249IdVddTVX2ZdOqCJDNV6Js/Qx/juONSs9r
	A98klyxb6cn4NikAx9xFJ2JzMwYAz/3eBL7T8qTrw0ExMyi32SQC/ananOc9nxIf
	UeX9d5mnGbEjVugPi6tQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh5dd0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:39:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D046E40044;
	Thu, 11 Apr 2024 16:39:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2478621BF52;
	Thu, 11 Apr 2024 16:38:37 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:38:36 +0200
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
Subject: [PATCH 06/11] net: ethernet: stm32: clean the way to manage wol irqwake
Date: Thu, 11 Apr 2024 16:36:53 +0200
Message-ID: <20240411143658.1049706-7-christophe.roullier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

On STM32 platforms it is no longer needed to use a dedicated wakeup to
wake up system from CStop. This patch removes the dedicated wake up usage
and clean the way to register the wake up irq.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 66 +++++++++----------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index e648c4e790a78..5d8f4eac4bc0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -81,7 +81,6 @@ struct stm32_dwmac {
 	int enable_eth_ck;
 	int eth_clk_sel_reg;
 	int eth_ref_clk_sel_reg;
-	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
 	u32 mode_mask;
 	struct regmap *regmap;
@@ -312,9 +311,7 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 			       struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	int err = 0;
 
 	/* Ethernet PHY have no crystal */
 	dwmac->ext_phyclk = of_property_read_bool(np, "st,ext-phyclk");
@@ -346,29 +343,24 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	if (IS_ERR(dwmac->syscfg_clk))
 		dwmac->syscfg_clk = NULL;
 
-	/* Get IRQ information early to have an ability to ask for deferred
-	 * probe if needed before we went too far with resource allocation.
-	 */
-	dwmac->irq_pwr_wakeup = platform_get_irq_byname_optional(pdev,
-							"stm32_pwr_wakeup");
-	if (dwmac->irq_pwr_wakeup == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	if (!dwmac->clk_eth_ck && dwmac->irq_pwr_wakeup >= 0) {
-		err = device_init_wakeup(&pdev->dev, true);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to init wake up irq\n");
-			return err;
-		}
-		err = dev_pm_set_dedicated_wake_irq(&pdev->dev,
-						    dwmac->irq_pwr_wakeup);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to set wake up irq\n");
-			device_init_wakeup(&pdev->dev, false);
-		}
-		device_set_wakeup_enable(&pdev->dev, false);
+	return 0;
+}
+
+static int stm32_dwmac_wake_init(struct device *dev,
+				 struct stmmac_resources *stmmac_res)
+{
+	int err;
+
+	device_set_wakeup_capable(dev, true);
+
+	err = dev_pm_set_wake_irq(dev, stmmac_res->wol_irq);
+	if (err) {
+		dev_err(dev, "Failed to set wake up irq\n");
+		device_set_wakeup_capable(dev, false);
+		return err;
 	}
-	return err;
+
+	return 0;
 }
 
 static int stm32_dwmac_probe(struct platform_device *pdev)
@@ -406,11 +398,17 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (stmmac_res.wol_irq && !dwmac->clk_eth_ck) {
+		ret = stm32_dwmac_wake_init(&pdev->dev, &stmmac_res);
+		if (ret)
+			goto err_wake_init_disable;
+	}
+
 	plat_dat->bsp_priv = dwmac;
 
 	ret = stm32_dwmac_init(plat_dat, false);
 	if (ret)
-		return ret;
+		goto err_wake_init_disable;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -420,7 +418,11 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 
 err_clk_disable:
 	stm32_dwmac_clk_disable(dwmac, false);
-
+err_wake_init_disable:
+	if (stmmac_res.wol_irq && !dwmac->clk_eth_ck) {
+		dev_pm_clear_wake_irq(&pdev->dev);
+		device_set_wakeup_capable(&pdev->dev, false);
+	}
 	return ret;
 }
 
@@ -428,16 +430,12 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
 
 	stmmac_dvr_remove(&pdev->dev);
+	stm32_dwmac_clk_disable(priv->plat->bsp_priv, false);
 
-	stm32_dwmac_clk_disable(dwmac, false);
-
-	if (dwmac->irq_pwr_wakeup >= 0) {
-		dev_pm_clear_wake_irq(&pdev->dev);
-		device_init_wakeup(&pdev->dev, false);
-	}
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
-- 
2.25.1


