Return-Path: <linux-kernel+bounces-161226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF688B493C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F0D2822AC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88020E3;
	Sun, 28 Apr 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um0/PXBQ"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BD10E5;
	Sun, 28 Apr 2024 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714271572; cv=none; b=hGdy5zIF9EpbaOzq+NkiqSfdTmGi6DyPHJMRNUEAoBs7jjU/M/gxEZAMM9pSf1ubOEXWM3rz80bCVxahSxXmchIKvoHSlxgydoN2BJf3d195Yb/b2jtrzrdbCzaPaRTzgDOy0OhxN+0YMmKR5GFklSdcEtYIOIk7t3WCDSyGpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714271572; c=relaxed/simple;
	bh=jkfQyD4TSkFPGgGvB9E0MlJqk8S0PJAcVXyJnrTR7N0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVdXe+kTjtDQG9ux3kawN9k+alIBh0knG8dibm7UlpIk+Fmz/npDDMjTS+jB8FJ4U84YANU2wSUHUPHqUvy/wCSaW4mnVgmJuQk4bcRN6/TgcnKuZ6fTaMaXELq5gSK7MxQWwt+r8HIoNcN+6iVz+k4BcII9XPbwdywxv389WKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um0/PXBQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c7513a991cso2367260b6e.1;
        Sat, 27 Apr 2024 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714271570; x=1714876370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Tm/X7jVaLOZHx4cX2r/MaUF1ehy4+INd54krGuf2Rw=;
        b=Um0/PXBQTrESCfhyQv6dEyto/fqnoTdrsPJOyBO2JVD4Jdn7Nw8H+yTErmvWQ8Sc3y
         XFMXhYD01Ie+jqIessffM1C9GBGN52z3BL+U1KNx1EkFcOz4zm+ZQASx/zQo4H4Lr4Z5
         YfddU96nQe+WyRTlwJyTuJhofJ4bKeDq9iEojl7oD48xIdBwvl2GGpMUBPg7JxPZGfyI
         ZQIzksyVrH4z9bm/8yAr+h/5OXpdBYw9BVWr1ukUdlpEfgtXUjxWzqj+ayOcPt7PxtSp
         95x9O5aOHlEbE4mDAwg5ohis1lYWc8aVGWcvNP3GZ135oLlZ8jzwcVRHSfZv/JbQeOQH
         mvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714271570; x=1714876370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Tm/X7jVaLOZHx4cX2r/MaUF1ehy4+INd54krGuf2Rw=;
        b=qhiu+Cl9kYHI+TkislHjolhCO7nQ+JSSc1qGO098+JtXSgDSD97MG09Vo56NLD5bFp
         egqJ80g6+am29/7FNK1bivbY3/t0m0OZmH16RwKo0FvswIkfX8iZhcucDpmFnag12dRp
         IIDHrZm7p01c3nzGPs9UM0oIPbj+L5UY21uBb7Hq40RmFCAxiHS2UWcANOwNal6bJp56
         Q7Ydpyr6ttWFe031yAm3C40S8TtETxzGG3Ow+Mvc87RIVWRxjXlUwsN5u3kLaF4Gw5I1
         wGsNwR3DAkBEfXm+GPnJKtYH4j4EasY04k4T/FFZMVaeTLXbcSDgnjk8wqRpTPZwQPUF
         gQSg==
X-Forwarded-Encrypted: i=1; AJvYcCVripeoP01LIu6Vu2O4tqTHW9BHnoMeCI1SF9zDCcYHMQuOJFqCia3A5jbwJ6YfqokF8mYD6/r9m9E0Ydx93UFmMknHAY6ZB5lAuW//lxEXEXE0fXfU/xQdLhAi9lO8hqyN1OIxTFl6
X-Gm-Message-State: AOJu0YxqpDyQe1FMSPl2a9OfP97q0qtK7HcosNMUocTM56YRPzC+ro8V
	hqLbkrXzf+ROMinQQ9MnRu0TvDW6ZjyUhALtmi3G6/vznCKxXT30
X-Google-Smtp-Source: AGHT+IG4ZVEXtRXCsLLDIK0vYRLFFOM+zWvT6N9TjdhceLPVevaCSZut0JYdHEKpzR8SR1WNuDB0cg==
X-Received: by 2002:a05:6808:114d:b0:3c8:5da4:5f7d with SMTP id u13-20020a056808114d00b003c85da45f7dmr5528858oiu.25.1714271570188;
        Sat, 27 Apr 2024 19:32:50 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id cp22-20020a056808359600b003c60bc31ed9sm2963912oib.17.2024.04.27.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 19:32:49 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org,
	dfustini@baylibre.com,
	yifeng.zhao@rock-chips.com,
	shawn.lin@rock-chips.com,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com,
	guoren@kernel.org,
	inochiama@outlook.com,
	unicorn_wang@outlook.com
Subject: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc_priv
Date: Sun, 28 Apr 2024 10:32:41 +0800
Message-Id: <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714270290.git.unicorn_wang@outlook.com>
References: <cover.1714270290.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The current framework is not easily extended to support new SOCs.
For example, in the current code we see that the SOC-level
structure `rk35xx_priv` and related logic are distributed in
functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
which is inappropriate.

The solution is to abstract some possible common operations of soc
into virtual members of `dwcmshc_priv`. Each soc implements its own
corresponding callback function and registers it in init function.
dwcmshc framework is responsible for calling these callback functions
in those dwcmshc_xxx functions.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 152 +++++++++++++++++-----------
 1 file changed, 91 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 39edf04fedcf..525f954bcb65 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -214,6 +214,10 @@ struct dwcmshc_priv {
 	void *priv; /* pointer to SoC private stuff */
 	u16 delay_line;
 	u16 flags;
+
+	void (*soc_postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	int (*soc_clks_enable)(struct dwcmshc_priv *dwc_priv);
+	void (*soc_clks_disable)(struct dwcmshc_priv *dwc_priv);
 };
 
 /*
@@ -1033,10 +1037,40 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
 }
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static int dwcmshc_rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
 {
-	int err;
 	struct rk35xx_priv *priv = dwc_priv->priv;
+	int ret = 0;
+
+	if (priv)
+		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
+	return ret;
+}
+
+static void dwcmshc_rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
+{
+	struct rk35xx_priv *priv = dwc_priv->priv;
+
+	if (priv)
+		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
+					   priv->rockchip_clks);
+}
+
+static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+static int dwcmshc_rk35xx_init(struct device *dev,
+			       struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	int err;
+	struct rk35xx_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
+		priv->devtype = DWCMSHC_RK3588;
+	else
+		priv->devtype = DWCMSHC_RK3568;
 
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
@@ -1071,6 +1105,11 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
 
+	dwc_priv->priv = priv;
+	dwc_priv->soc_postinit = dwcmshc_rk35xx_postinit;
+	dwc_priv->soc_clks_enable = dwcmshc_rk35xx_clks_enable;
+	dwc_priv->soc_clks_disable = dwcmshc_rk35xx_clks_disable;
+
 	return 0;
 }
 
@@ -1088,6 +1127,35 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 	}
 }
 
+static int dwcmshc_th1520_init(struct device *dev,
+			       struct sdhci_host *host,
+			       struct dwcmshc_priv *dwc_priv)
+{
+	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
+
+	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+	/*
+	 * start_signal_voltage_switch() will try 3.3V first
+	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
+	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+	 * in sdhci_start_signal_voltage_switch().
+	 */
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
+	}
+
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
@@ -1134,7 +1202,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	struct rk35xx_priv *rk_priv = NULL;
 	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
 	u32 extra, caps;
@@ -1191,46 +1258,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
-		if (!rk_priv) {
-			err = -ENOMEM;
-			goto err_clk;
-		}
-
-		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
-			rk_priv->devtype = DWCMSHC_RK3588;
-		else
-			rk_priv->devtype = DWCMSHC_RK3568;
-
-		priv->priv = rk_priv;
-
-		err = dwcmshc_rk35xx_init(host, priv);
+		err = dwcmshc_rk35xx_init(dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
 
 	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
-
-		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
-			priv->flags |= FLAG_IO_FIXED_1V8;
-		else
-			priv->flags &= ~FLAG_IO_FIXED_1V8;
-
-		/*
-		 * start_signal_voltage_switch() will try 3.3V first
-		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
-		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
-		 * in sdhci_start_signal_voltage_switch().
-		 */
-		if (priv->flags & FLAG_IO_FIXED_1V8) {
-			host->flags &= ~SDHCI_SIGNALING_330;
-			host->flags |=  SDHCI_SIGNALING_180;
-		}
-
-		sdhci_enable_v4_mode(host);
+		err = dwcmshc_th1520_init(dev, host, priv);
+		if (err)
+			goto err_clk;
 	}
 
 #ifdef CONFIG_ACPI
@@ -1260,8 +1296,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		dwcmshc_cqhci_init(host, pdev);
 	}
 
-	if (rk_priv)
-		dwcmshc_rk35xx_postinit(host, priv);
+	if (priv->soc_postinit)
+		priv->soc_postinit(host, priv);
 
 	err = __sdhci_add_host(host);
 	if (err)
@@ -1279,9 +1315,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
+
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1303,7 +1339,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1315,9 +1350,9 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
+
 	sdhci_pltfm_free(pdev);
 }
 
@@ -1327,7 +1362,6 @@ static int dwcmshc_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	pm_runtime_resume(dev);
@@ -1346,9 +1380,8 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
 
 	return ret;
 }
@@ -1358,7 +1391,6 @@ static int dwcmshc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -1371,29 +1403,27 @@ static int dwcmshc_resume(struct device *dev)
 			goto disable_clk;
 	}
 
-	if (rk_priv) {
-		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
-					      rk_priv->rockchip_clks);
+	if (priv->soc_clks_enable) {
+		ret = priv->soc_clks_enable(priv);
 		if (ret)
 			goto disable_bus_clk;
 	}
 
 	ret = sdhci_resume_host(host);
 	if (ret)
-		goto disable_rockchip_clks;
+		goto disable_soc_clks;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_resume(host->mmc);
 		if (ret)
-			goto disable_rockchip_clks;
+			goto disable_soc_clks;
 	}
 
 	return 0;
 
-disable_rockchip_clks:
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+disable_soc_clks:
+	if (priv->soc_clks_disable)
+		priv->soc_clks_disable(priv);
 disable_bus_clk:
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
-- 
2.25.1


