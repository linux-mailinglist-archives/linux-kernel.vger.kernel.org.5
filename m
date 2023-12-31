Return-Path: <linux-kernel+bounces-13717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC12820B91
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844A2B2120D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC18F6F;
	Sun, 31 Dec 2023 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YROVxWfe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FD6112;
	Sun, 31 Dec 2023 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7b9cca2fso5305976e87.3;
        Sun, 31 Dec 2023 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704033982; x=1704638782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpxmw1MOjmzccbo/izQr/FDy7PQ0i8LPXtRaCJbmvlE=;
        b=YROVxWfeWz46CVKFZsEUpuBwxw8Qaq01m2fbxJj9J2ovuZwa5tuwOnCbdUL49a71c3
         C7NKzaKZedNz/cPSMyeAFELzn8sH+2o0Cr7YPpK1dHYsTu/gOpEiuK7WEzeZ/UnS+wJP
         VuO9N7rfdr2hT9EUaeXxsVMniRmG6LieGu/cKjPWl+5WrhCORkePmYWMimDtJqsi+TJt
         +ffUWs26/r3DrPelhwvCFdlKwxIrIQ8zfJWQO9Ti9LHfHPbNPtxbVmVnuu0JAET7H0QA
         fF6kmfHHNUqFWyIFK/OUTfaF2fXQPlQ0qeuFyFzcZX7cjsfi+r+96DkN+HJ5AZ6OxUXm
         B9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033982; x=1704638782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rpxmw1MOjmzccbo/izQr/FDy7PQ0i8LPXtRaCJbmvlE=;
        b=WGdjJuTUtBSSUq1GQ50r2GEjH8HeMmCCqfiheoWqAlPnnZdOF1V+TxDQ/pxhe+l6AB
         sXc18CSQo5t2WQlYnfnTllt2Ep+tZ5jiFHJesTBuytghRFNzqbJ0aEJR3jppCY+NmCN/
         ns7q894eL6xwttFaMsOy1gXPOfg7NHbEVg3ncDjwi31rzDT6BNs5PuvEcU1qnkzdAuvW
         +fgoyFzs6EoG6aWaWtKazzqDRDzqYLDRZ2fMSnBmNhZvd4MvjcQoQ/JTBsqHSG+H0ZlE
         9OzE1Wd3y3GI7zW5MEeOD1zVn3Rors6sl9UmoifOHfxi9P0glIdb15eq5cJi5Zp12q1O
         0esA==
X-Gm-Message-State: AOJu0YyA/b2AK+lyTttNB/fDViSt5NoEwLb2Tg1KCe7YUuLnCk1AyA0M
	ljm028tM88FbDwtLybl+dTC+RIkUHr/aFg==
X-Google-Smtp-Source: AGHT+IGBOwX1SOIN0bGOgY+fOPQm+Ayo/pISmvULdSzALHatNdFgITPc4MQMMd2O1EipYqM+eAiu9Q==
X-Received: by 2002:a05:6512:3ba5:b0:50e:7b4a:7031 with SMTP id g37-20020a0565123ba500b0050e7b4a7031mr4495759lfv.51.1704033982325;
        Sun, 31 Dec 2023 06:46:22 -0800 (PST)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24a89000000b0050e7ec49881sm1854423lfp.21.2023.12.31.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 06:46:21 -0800 (PST)
From: Sergey Khimich <serghox@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jyan Chou <jyanchou@realtek.com>
Subject: [PATCH v5 2/2] mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
Date: Sun, 31 Dec 2023 17:46:19 +0300
Message-Id: <20231231144619.758290-3-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231144619.758290-1-serghox@gmail.com>
References: <20231231144619.758290-1-serghox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Khimich <serghox@gmail.com>

For enabling CQE support just set 'supports-cqe' in your DevTree file
for appropriate mmc node.

Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 181 +++++++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 58bd5fe4cd25..f7594705b013 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -233,6 +233,7 @@ config MMC_SDHCI_OF_DWCMSHC
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
 	depends on COMMON_CLK
+	select MMC_CQHCI
 	help
 	  This selects Synopsys DesignWare Cores Mobile Storage Controller
 	  support.
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 3a3bae6948a8..0ba1df4bcf36 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -20,6 +20,7 @@
 #include <linux/sizes.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
 
@@ -36,6 +37,9 @@
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
 
+/* DWC IP vendor area 2 pointer */
+#define DWCMSHC_P_VENDOR_AREA2		0xea
+
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
@@ -75,6 +79,11 @@
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
 
+#define DWCMSHC_SDHCI_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
+					 SDHCI_TRNS_BLK_CNT_EN | \
+					 SDHCI_TRNS_DMA)
+
+
 enum dwcmshc_rk_type {
 	DWCMSHC_RK3568,
 	DWCMSHC_RK3588,
@@ -90,7 +99,9 @@ struct rk35xx_priv {
 
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
-	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
+	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
+	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
+
 	void *priv; /* pointer to SoC private stuff */
 };
 
@@ -210,6 +221,90 @@ static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
 	sdhci_writel(host, vendor, reg);
 }
 
+static int dwcmshc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	int err = sdhci_execute_tuning(mmc, opcode);
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (err)
+		return err;
+
+	/*
+	 * Tuning can leave the IP in an active state (Buffer Read Enable bit
+	 * set) which prevents the entry to low power states (i.e. S0i3). Data
+	 * reset will clear it.
+	 */
+	sdhci_reset(host, SDHCI_RESET_DATA);
+
+	return 0;
+}
+
+static u32 dwcmshc_cqe_irq_handler(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static void dwcmshc_sdhci_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u8 ctrl;
+
+	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
+
+	sdhci_cqe_enable(mmc);
+
+	/*
+	 * The "DesignWare Cores Mobile Storage Host Controller
+	 * DWC_mshc / DWC_mshc_lite Databook" says:
+	 * when Host Version 4 Enable" is 1 in Host Control 2 register,
+	 * SDHCI_CTRL_ADMA32 bit means ADMA2 is selected.
+	 * Selection of 32-bit/64-bit System Addressing:
+	 * either 32-bit or 64-bit system addressing is selected by
+	 * 64-bit Addressing bit in Host Control 2 register.
+	 *
+	 * On the other hand the "DesignWare Cores Mobile Storage Host
+	 * Controller DWC_mshc / DWC_mshc_lite User Guide" says, that we have to
+	 * set DMA_SEL to ADMA2 _only_ mode in the Host Control 2 register.
+	 */
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl &= ~SDHCI_CTRL_DMA_MASK;
+	ctrl |= SDHCI_CTRL_ADMA32;
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
+static void dwcmshc_set_tran_desc(struct cqhci_host *cq_host, u8 **desc,
+				  dma_addr_t addr, int len, bool end, bool dma64)
+{
+	int tmplen, offset;
+
+	if (likely(!len || BOUNDARY_OK(addr, len))) {
+		cqhci_set_tran_desc(*desc, addr, len, end, dma64);
+		return;
+	}
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	cqhci_set_tran_desc(*desc, addr, tmplen, false, dma64);
+
+	addr += tmplen;
+	len -= tmplen;
+	*desc += cq_host->trans_desc_len;
+	cqhci_set_tran_desc(*desc, addr, len, end, dma64);
+}
+
+static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
 static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -345,6 +440,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
 };
 
 static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
@@ -379,6 +475,71 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
+	.enable		= dwcmshc_sdhci_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+	.dumpregs	= dwcmshc_cqhci_dumpregs,
+	.set_tran_desc	= dwcmshc_set_tran_desc,
+};
+
+static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
+{
+	struct cqhci_host *cq_host;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	bool dma64 = false;
+	u16 clk;
+	int err;
+
+	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+	cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: not enough memory\n");
+		return;
+	}
+
+	/*
+	 * For dwcmshc host controller we have to enable internal clock
+	 * before access to some registers from Vendor Specific Aria 2.
+	 */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (!(clk & SDHCI_CLOCK_INT_EN)) {
+		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: internal clock enable error\n");
+		goto free_cq_host;
+	}
+
+	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
+	cq_host->ops = &dwcmshc_cqhci_ops;
+
+	/* Enable using of 128-bit task descriptors */
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64) {
+		dev_dbg(mmc_dev(host->mmc), "128-bit task descriptors\n");
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+	}
+	err = cqhci_init(cq_host, host->mmc, dma64);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: error %d\n", err);
+		goto int_clock_disable;
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
+
+	return;
+
+int_clock_disable:
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+free_cq_host:
+	devm_kfree(&pdev->dev, cq_host);
+}
+
+
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
@@ -471,7 +632,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct rk35xx_priv *rk_priv = NULL;
 	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
-	u32 extra;
+	u32 extra, caps;
 
 	pltfm_data = device_get_match_data(&pdev->dev);
 	if (!pltfm_data) {
@@ -519,9 +680,12 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	priv->vendor_specific_area1 =
 		sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
+	priv->vendor_specific_area2 =
+		sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
 
 	host->mmc_host_ops.request = dwcmshc_request;
 	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
+	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
 		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
@@ -547,6 +711,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		sdhci_enable_v4_mode(host);
 #endif
 
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (caps & SDHCI_CAN_64BIT_V4)
+		sdhci_enable_v4_mode(host);
+
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	pm_runtime_get_noresume(dev);
@@ -557,6 +725,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (err)
 		goto err_rpm;
 
+	/* Setup Command Queue Engine if enabled */
+	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
+		if (caps & SDHCI_CAN_64BIT_V4)
+			dwcmshc_cqhci_init(host, pdev);
+		else
+			dev_warn(dev, "Cannot enable CQE without V4 mode support\n");
+	}
+
+
 	if (rk_priv)
 		dwcmshc_rk35xx_postinit(host, priv);
 
-- 
2.30.2


