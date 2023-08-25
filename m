Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226F788BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbjHYOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjHYOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:35:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814BE1FFA;
        Fri, 25 Aug 2023 07:35:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso1070254e87.0;
        Fri, 25 Aug 2023 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692974129; x=1693578929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah6WOtKEB2loZxvmkh4OP0LwSt7l7JSfpCxtqd0FpYI=;
        b=E6lJweLx08plMRFD8JUX1Ms9u4gqM+3dkSjnCirrMaGSiFIEw5elMMkZIC2AgR9k3g
         ZcSD5PAsZ7BE890HfEJIE/mqx598qA/Nk80y27YrK33cERZ8SHwE0mrycNnUZy7gZDRg
         fPIh+ogEm0ur1dI7BS4xr3i2hYOAoyPINMyT8N+GI21CbIsTJ6cpj6bT4cl3HZ/FQjxE
         /uk+AMBgL9CnhAVjFXh4U8j1gTNoxRY+LnaBcwVRlAxF0qAL0SxLopcXpyoox3//y7t8
         5Z7PYN043fHLD1NrIOsPUqweaC4c6NZXIJkjh+nC25ehHgcEPEi8VTsRK39ijy7Suxkw
         weiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692974129; x=1693578929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah6WOtKEB2loZxvmkh4OP0LwSt7l7JSfpCxtqd0FpYI=;
        b=NCS31Yri2SLbxGKdCSOss7tiO5zHbXDeEaKM1iPdvA0u+uD7j8DlXOoO5N5jRE8FJq
         2pMG/sYCSBDgrNaNFPQMjaYGjqpDamY9Rsk6BFYhMtVuQLm9fg/rDbhWRapowf7CV489
         N0zJ9v+MRxZqo0vslzOEId9NhxmAciIx4GhMCWXKkkh05pLkHqX2esnR7kdGvgQkFY2o
         e9G+00sJV4d1KVtatDhueWdGS7rxwQT0f1I9Q2YOweDhMyRezboAXc/vpeYDJg4LpQJa
         usVgZ2QCgp8XCncWwo+fJNwNmmRGavAJMIOWC14f5plHD1aC4DSP6d1PygWlRUKJtD4Z
         Y3kg==
X-Gm-Message-State: AOJu0YxLoV8JRnb+SvG7u62tavKSyPZQ2D4nr69Vj0+8gjF9GiWdwP6p
        VUERbqGTnF59pjWa6TyZ0hoFJzLJcb25WNLTw1w=
X-Google-Smtp-Source: AGHT+IGOs9b0BS0bS7NtawwfI+MTsMpLn3tZGz81Z7j9e2tIJepf+ErfCRJlTv+0lC2HHoDxiXoKXA==
X-Received: by 2002:ac2:4dba:0:b0:4f8:bfb4:e4c4 with SMTP id h26-20020ac24dba000000b004f8bfb4e4c4mr12329204lfe.19.1692974128437;
        Fri, 25 Aug 2023 07:35:28 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id z1-20020ac25de1000000b004fddbd29457sm310118lfq.7.2023.08.25.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:35:28 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add CQE support
Date:   Fri, 25 Aug 2023 17:35:25 +0300
Message-Id: <20230825143525.869906-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230825143525.869906-1-serghox@gmail.com>
References: <20230825143525.869906-1-serghox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement SDHCI CQE support for DesignWare SDHCI.
For enabling CQE support just set 'supports-cqe' in your DevTree file
for appropriate mmc node.

Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 154 +++++++++++++++++++++++++++-
 2 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 159a3e9490ae..c9fc790d7dba 100644
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
index e68cd87998c8..5ee8954a8f5a 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -19,6 +19,7 @@
 #include <linux/sizes.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
 
@@ -35,6 +36,9 @@
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
 
+/* DWC IP vendor area 2 pointer */
+#define DWCMSHC_P_VENDOR_AREA2		0xea
+
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
@@ -74,6 +78,10 @@
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
 
+#define DWCMCHC_SDHCI_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
+					 SDHCI_TRNS_BLK_CNT_EN | \
+					 SDHCI_TRNS_DMA)
+
 enum dwcmshc_rk_type {
 	DWCMSHC_RK3568,
 	DWCMSHC_RK3588,
@@ -89,7 +97,8 @@ struct rk35xx_priv {
 
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
-	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
+	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
+	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
 	void *priv; /* pointer to SoC private stuff */
 };
 
@@ -209,6 +218,65 @@ static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
 	sdhci_writel(host, vendor, reg);
 }
 
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
+	u32 pstate;
+	u8 ctrl;
+	int count = 10;
+
+	/*
+	 * CQE gets stuck if it sees Buffer Read Enable bit set, which can be
+	 * the case after tuning, so ensure the buffer is drained.
+	 */
+	pstate = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	while (pstate & SDHCI_DATA_AVAILABLE) {
+		sdhci_readl(host, SDHCI_BUFFER);
+		pstate = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (count-- == 0) {
+			dev_warn(mmc_dev(host->mmc),
+				 "CQE may get stuck because the Buffer Read Enable bit is set\n");
+			break;
+		}
+		mdelay(1);
+	}
+
+	sdhci_writew(host, DWCMCHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
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
 static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -344,6 +412,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.get_max_clock		= dwcmshc_get_max_clock,
 	.reset			= sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
 };
 
 static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
@@ -378,6 +447,74 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
+	.enable		= dwcmshc_sdhci_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+	.dumpregs	= dwcmshc_cqhci_dumpregs,
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
+		goto int_clok_disable;
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
+
+	return;
+
+int_clok_disable:
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+free_cq_host:
+	devm_kfree(&pdev->dev, cq_host);
+}
+
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
@@ -471,6 +608,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
 	u32 extra;
+	u32 caps;
 
 	pltfm_data = device_get_match_data(&pdev->dev);
 	if (!pltfm_data) {
@@ -518,6 +656,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	priv->vendor_specific_area1 =
 		sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
+	priv->vendor_specific_area2 =
+		sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
 
 	host->mmc_host_ops.request = dwcmshc_request;
 	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
@@ -546,12 +686,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		sdhci_enable_v4_mode(host);
 #endif
 
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (caps & SDHCI_CAN_64BIT_V4)
+		sdhci_enable_v4_mode(host);
+
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	err = sdhci_setup_host(host);
 	if (err)
 		goto err_clk;
 
+	/* Setup Command Queue Engine if enabled */
+	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
+		if (caps & SDHCI_CAN_64BIT_V4)
+			dwcmshc_cqhci_init(host, pdev);
+		else
+			dev_warn(dev, "Cannot enable CQE without V4 mode support\n");
+	}
+
 	if (rk_priv)
 		dwcmshc_rk35xx_postinit(host, priv);
 
-- 
2.30.2

