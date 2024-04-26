Return-Path: <linux-kernel+bounces-160017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061598B37C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEB81C22870
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7B148302;
	Fri, 26 Apr 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bq9Hqf5l"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBF147C95;
	Fri, 26 Apr 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136461; cv=none; b=uT9+lHd8416PcvF3jfetInqUL0VW+0yThYOdoqxY8fU3qLqT4SoZJ6vobGgytKU1C7va1UHRwXO+UHslc7DZD+cF21YELIQSvCeeJiwt0JR4Cc72QdqMYE7gYWnBU9Wd1WzRYImOKHoRN8FiSUGQEwVHOcojVjpWjl1AUbnejbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136461; c=relaxed/simple;
	bh=gdRqxITpkFjYrUJvkxFmXlxSWb2+T05+5s5UutHdLqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czb1EOJW0svXd0JVroET5k4eX7dHYLoV4PinScZmgvoHVsLXd06/2XnNeuyc7xbytrXnFH3/WxkwF/gl0GwXE+BRu5UmzFNUpGfqFEkyK89KDtbLmO+G2zoUTmMTR3dVeiVQgjVhdjYQDSc6By/NBPvNTNtx/fm5hGXzZc6VYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bq9Hqf5l; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q97Sfw018300;
	Fri, 26 Apr 2024 15:00:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=zdOScCWi16Umq4Ie6jjJ/nimxxbncgqkcY22u+W2FUA=; b=Bq
	9Hqf5lTrFHuKKNiLdnHGI90mR91w9Rejo0skRIKnZ+1g+78r3x2a1h40NrQCR7+Q
	vem/pahGNV6URR6zCLtuNQJKbQQgzzNZzfWSkPvtmy533zvTWJgMGfvVtd57PIrF
	aNg9OFwiA39KheImehOBnR6W5oo3PpYzUtjDNANZlZfAGJSGyn734ntlELLG16mX
	KGn+50w259I8gAUfaYDpogS480Y+n5AKQuoYBfNoYOT/7lqlRKJHlPuPqIvse3RN
	XSlpufGDJJXWU5xA9uBAnjtnfWHLlv2X26xPoZBoKYMmu5kPqJctvrZQKtypuL2F
	wA3zoY+B4hcU9bi0+N7A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cntnun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 15:00:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EB2CD40049;
	Fri, 26 Apr 2024 15:00:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16675222C9E;
	Fri, 26 Apr 2024 14:59:21 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:59:18 +0200
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
Subject: [PATCH v2 07/11] net: stmmac: dwmac-stm32: support the phy-supply regulator binding
Date: Fri, 26 Apr 2024 14:57:03 +0200
Message-ID: <20240426125707.585269-8-christophe.roullier@foss.st.com>
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

Configure the phy regulator if defined by the "phy-supply" DT phandle.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 5d8f4eac4bc0..964173d08026 100644
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


