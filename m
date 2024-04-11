Return-Path: <linux-kernel+bounces-140671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BD8A1797
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA761C20FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAF171C9;
	Thu, 11 Apr 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VOUK0RsN"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CBDDA8;
	Thu, 11 Apr 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846411; cv=none; b=riLqdcHUPHiVaZkhb/AtcBec8rwRFlz0vQDZV1i8158wFuwR3JYNLCSOgHLbyeTTlXC44uMjTg8tHql5pjByc8c6pka2Z41Y5zg2OBPHfSr1VJeEs7XPqX3j6BnPaCD3gGS3ZHFFnnc9iRX6HeqZhiariXVJaWI/WjaIuW2xryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846411; c=relaxed/simple;
	bh=AB0cVBhiYC5vUidZLIiKpknzQlhSM7BtaR97drJ0AOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McVw/BGUUvToxe1pkeM+Imbn7KoP9iK4p/hU2PyQrJD8TJAZfFNjuAyBLZas6O74juhVqidduDemrBLJhdeJi6y8XEWsW1rQ3PeXSAMAFcf/RSAqgVK6RF0HrngQpP/kpGVrRclEjZTHcCXUmL7/Pj1yRuiHXSssKXF/dEdC8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VOUK0RsN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BC7dsL019953;
	Thu, 11 Apr 2024 16:39:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=a1bbaUurTgp0uCDEFRQ4uHDKTCeu+5gtz/DudOT+hI4=; b=VO
	UK0RsNQe+Ft0ZqlnEDPgTMhjyuIsg2yjLmmiLB1KQ9iHj0OxUlM82pwGRqc4AXE3
	mWdomP7AMgC/73N8jJleEgl1+c4S6wmfQqs/IAJVY6wqzu7liRvq/vgWUrU0A/hv
	2al53tYro3G7Ctfp+mwN8jC9J/Ms/o2kWAlconkqmQPwkrftHxVI9K+mZVBozuua
	1eXSjNUdj9nkX/Ar/V9Y7v4D6iRkDBvtNwlVNayZMgtvAVI25uWf/RZZy4JX7omm
	N77LTbgjSURmQOFJ2Up8k2Tkl+kooPKQ+nd5B99mqtrP0NMNC4sIrcG1gyQIsVdc
	fQox7or4NhnPCYogNPtw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbfy13r1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:39:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9918640046;
	Thu, 11 Apr 2024 16:39:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6E4C21BF55;
	Thu, 11 Apr 2024 16:38:37 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:38:37 +0200
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
Subject: [PATCH 07/11] net: ethernet: stmmac: stm32: support the phy-supply regulator binding
Date: Thu, 11 Apr 2024 16:36:54 +0200
Message-ID: <20240411143658.1049706-8-christophe.roullier@foss.st.com>
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

Configure the phy regulator if defined by the "phy-supply" DT phandle.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 5d8f4eac4bc0f..964173d080263 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -14,6 +14,7 @@
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -84,6 +85,7 @@ struct stm32_dwmac {
 	u32 mode_reg;		 /* MAC glue-logic mode register */
 	u32 mode_mask;
 	struct regmap *regmap;
+	struct regulator *regulator;
 	u32 speed;
 	const struct stm32_ops *ops;
 	struct device *dev;
@@ -305,6 +307,16 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 	if (err)
 		pr_debug("Warning sysconfig register mask not set\n");
 
+	dwmac->regulator = devm_regulator_get_optional(dev, "phy");
+	if (IS_ERR(dwmac->regulator)) {
+		if (PTR_ERR(dwmac->regulator) == -EPROBE_DEFER) {
+			dev_dbg(dev, "phy regulator is not available yet, deferred probing\n");
+			return -EPROBE_DEFER;
+		}
+		dev_dbg(dev, "no regulator found\n");
+		dwmac->regulator = NULL;
+	}
+
 	return 0;
 }
 
@@ -363,6 +375,27 @@ static int stm32_dwmac_wake_init(struct device *dev,
 	return 0;
 }
 
+static int phy_power_on(struct stm32_dwmac *bsp_priv, bool enable)
+{
+	int ret;
+	struct device *dev = bsp_priv->dev;
+
+	if (!bsp_priv->regulator)
+		return 0;
+
+	if (enable) {
+		ret = regulator_enable(bsp_priv->regulator);
+		if (ret)
+			dev_err(dev, "fail to enable phy-supply\n");
+	} else {
+		ret = regulator_disable(bsp_priv->regulator);
+		if (ret)
+			dev_err(dev, "fail to disable phy-supply\n");
+	}
+
+	return ret;
+}
+
 static int stm32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -410,12 +443,18 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_wake_init_disable;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	ret = phy_power_on(plat_dat->bsp_priv, true);
 	if (ret)
 		goto err_clk_disable;
 
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		goto err_gmac_powerdown;
+
 	return 0;
 
+err_gmac_powerdown:
+	phy_power_on(plat_dat->bsp_priv, false);
 err_clk_disable:
 	stm32_dwmac_clk_disable(dwmac, false);
 err_wake_init_disable:
@@ -436,6 +475,8 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
+
+	phy_power_on(priv->plat->bsp_priv, false);
 }
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
@@ -466,6 +507,10 @@ static int stm32_dwmac_suspend(struct device *dev)
 	if (dwmac->ops->suspend)
 		ret = dwmac->ops->suspend(dwmac);
 
+	/* Keep the PHY up if we use Wake-on-Lan. */
+	if (!device_may_wakeup(dwmac->dev))
+		phy_power_on(dwmac, false);
+
 	return ret;
 }
 
@@ -479,6 +524,10 @@ static int stm32_dwmac_resume(struct device *dev)
 	if (dwmac->ops->resume)
 		dwmac->ops->resume(dwmac);
 
+	/* The PHY was up for Wake-on-Lan. */
+	if (!device_may_wakeup(dwmac->dev))
+		phy_power_on(dwmac, true);
+
 	ret = stm32_dwmac_init(priv->plat, true);
 	if (ret)
 		return ret;
-- 
2.25.1


