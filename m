Return-Path: <linux-kernel+bounces-62138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA6851C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CD31C213D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0467E3FE4B;
	Mon, 12 Feb 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xZx3E2ww"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A73FB2F;
	Mon, 12 Feb 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760285; cv=none; b=gSrMY5wn2UzFL6NsEwOXqqwEPb8ZRglkSRON3sA6wURkATpfq4Lh/P7lknqi8S2Ae+F55hshYbmAHvlVBJkSjSEe0hQwzKRgHBNwe/ogu0zp7+hGdUBmjTbJDR93k1UI5FiIwzoOkO8TEHFrj0JI+Tn+Gw89QUVjJs/XhuSrlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760285; c=relaxed/simple;
	bh=BirkVWS+mSl3fX1O0cWUQWmo13pH6fBvp3WBZIckfaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPnKtVbd1bs17CqycQb4lLr/sPjW47lGKwPnVUMRk0+i6b9RxJwdK8S0tK9yJMPwJQdvPIBUuourkDzC3SEEji37wPX8YehD/FSSsIzbSRaIKfS+57cPM6IZDWfKijanfBaSyrlQdhnQJFlKbK/GV23pr7UoRnlBaC+mrvHg+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xZx3E2ww; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CFLrBU012118;
	Mon, 12 Feb 2024 18:51:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=yBt3J1JvC9JWaK1tn/1K6Z3tKSfz+E4rgFKGPurOxBY=; b=xZ
	x3E2wwN4kEMq39WrPmVwFEDW1B6Fddppyfll/2jFmRLCGh5NB7tkU0x5A482/pEE
	ZXMIHanjrTw/RdTfl/IpKwIySG9HQlvt39JXzgvxWoysu5OR+87MqPDZd6DAH+qP
	MjionM8pOk8HXk5x3uYhh55FfatkPuwaAtvdBfEQE/8XI5A4I1VWkOJsfUQmwEPm
	2EGk8a/5oadfOjS7fXFUjzCbTDFSqAShhsRS77VFdqfCQR7TdD31N7ET8pTSIPTk
	JkMriE1G81O2EZs7sd2IaeXXCuWunz7FzRUujzIRtWV3ShZs5KFhSV7y42tJIkS9
	0/WaGLDduM5ZnFjVCBsA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62h0qkux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:51:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 669B740044;
	Mon, 12 Feb 2024 18:51:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15F5927F261;
	Mon, 12 Feb 2024 18:50:22 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:50:21 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 07/12] memory: stm32-fmc2-ebi: add runtime PM support
Date: Mon, 12 Feb 2024 18:48:17 +0100
Message-ID: <20240212174822.77734-8-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212174822.77734-1-christophe.kerello@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02

Add runtime PM support in FMC2 ebi driver to be able to manage GENPD
support when it will be enabled.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/memory/stm32-fmc2-ebi.c | 40 ++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 04248c15832f..8c30e56be3b0 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -11,6 +11,7 @@
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -1381,6 +1382,7 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ebi->dev = dev;
+	platform_set_drvdata(pdev, ebi);
 
 	ebi->data = of_device_get_match_data(dev);
 	if (!ebi->data)
@@ -1398,10 +1400,14 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	if (PTR_ERR(rstc) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	ret = clk_prepare_enable(ebi->clk);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
 	if (!IS_ERR(rstc)) {
 		reset_control_assert(rstc);
 		reset_control_deassert(rstc);
@@ -1432,7 +1438,6 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 		goto err_release;
 
 	stm32_fmc2_ebi_save_setup(ebi);
-	platform_set_drvdata(pdev, ebi);
 
 	return 0;
 
@@ -1440,7 +1445,7 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	stm32_fmc2_ebi_disable_banks(ebi);
 	stm32_fmc2_ebi_disable(ebi);
 	stm32_fmc2_ebi_put_sems(ebi);
-	clk_disable_unprepare(ebi->clk);
+	pm_runtime_put_sync_suspend(dev);
 
 	return ret;
 }
@@ -1453,7 +1458,23 @@ static void stm32_fmc2_ebi_remove(struct platform_device *pdev)
 	stm32_fmc2_ebi_disable_banks(ebi);
 	stm32_fmc2_ebi_disable(ebi);
 	stm32_fmc2_ebi_put_sems(ebi);
+	pm_runtime_put_sync_suspend(&pdev->dev);
+}
+
+static int __maybe_unused stm32_fmc2_ebi_runtime_suspend(struct device *dev)
+{
+	struct stm32_fmc2_ebi *ebi = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(ebi->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_fmc2_ebi_runtime_resume(struct device *dev)
+{
+	struct stm32_fmc2_ebi *ebi = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(ebi->clk);
 }
 
 static int __maybe_unused stm32_fmc2_ebi_suspend(struct device *dev)
@@ -1462,7 +1483,7 @@ static int __maybe_unused stm32_fmc2_ebi_suspend(struct device *dev)
 
 	stm32_fmc2_ebi_disable(ebi);
 	stm32_fmc2_ebi_put_sems(ebi);
-	clk_disable_unprepare(ebi->clk);
+	pm_runtime_put_sync_suspend(dev);
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1475,8 +1496,8 @@ static int __maybe_unused stm32_fmc2_ebi_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(ebi->clk);
-	if (ret)
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
 
 	stm32_fmc2_ebi_get_sems(ebi);
@@ -1486,8 +1507,11 @@ static int __maybe_unused stm32_fmc2_ebi_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_fmc2_ebi_pm_ops, stm32_fmc2_ebi_suspend,
-			 stm32_fmc2_ebi_resume);
+static const struct dev_pm_ops stm32_fmc2_ebi_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_fmc2_ebi_runtime_suspend,
+			   stm32_fmc2_ebi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_fmc2_ebi_suspend, stm32_fmc2_ebi_resume)
+};
 
 static const struct stm32_fmc2_ebi_data stm32_fmc2_ebi_mp1_data = {
 	.rnb_for_nand = false,
-- 
2.25.1


