Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943D6779053
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHKNHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjHKNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:07:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399923C22;
        Fri, 11 Aug 2023 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759214; x=1723295214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLITUlXAKi/BwJx9Dy+d4fQ//8DCwhp6Xa5EddapwMg=;
  b=eeqA5VsIccWXyx36g/1edgGK6moElEpi6MDnHWzjQWqJAyMes7lFQmZT
   ESzMzpsTuMLSGUFJoBwkDcrUBrFTctCXmQ8YmJ2+CIayF6e1IQEcZfXyR
   SoIzV41MRPnFNbU39QhMb1XYaLJdqdktuUcum/4wQuDrESbyR9mxwAzZZ
   qFTQBNuebe+42D7RkVsx24cL+W4oJWCgR5cvKMlChrgBN+prGWZiRoC0Q
   f3lAg/ywONtNTlNrRncQodNiArS8s3XyQpSPZcn+sT2kLASIAR66+WX6t
   w8orvtKiI07QFPfJ0wQ9l7ZmxMJOo/4sa0pJNaCUYEY7cYeLf1oVqbwIn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361812675"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361812675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535288"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535288"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Brian Norris <briannorris@chromium.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Brad Larson <blarson@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Andy Tang <andy.tang@nxp.com>,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Doug Brown <doug@schmorgal.com>,
        Li Zetao <lizetao1@huawei.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/16] mmc: sdhci-of-sparx5: Use sdhci_pltfm_remove()
Date:   Fri, 11 Aug 2023 16:03:47 +0300
Message-Id: <20230811130351.7038-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811130351.7038-1-adrian.hunter@intel.com>
References: <20230811130351.7038-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sdhci_pltfm_remove() instead of sdhci_pltfm_unregister() so that
devm_clk_get_enabled() can be used for pltfm_host->clk.

This has the side effect that the order of operations on the error path
and remove path is not the same as it was before, but should be safe
nevertheless.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-sparx5.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index 653480dbe6bb..64b77e7d14cd 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -184,15 +184,12 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 	sdhci_sparx5 = sdhci_pltfm_priv(pltfm_host);
 	sdhci_sparx5->host = host;
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+	pltfm_host->clk = devm_clk_get_enabled(&pdev->dev, "core");
 	if (IS_ERR(pltfm_host->clk)) {
 		ret = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to get and enable core clk: %d\n", ret);
 		goto free_pltfm;
 	}
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret)
-		goto free_pltfm;
 
 	if (!of_property_read_u32(np, "microchip,clock-delay", &value) &&
 	    (value > 0 && value <= MSHC_DLY_CC_MAX))
@@ -202,13 +199,13 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-		goto err_clk;
+		goto free_pltfm;
 
 	sdhci_sparx5->cpu_ctrl = syscon_regmap_lookup_by_compatible(syscon);
 	if (IS_ERR(sdhci_sparx5->cpu_ctrl)) {
 		dev_err(&pdev->dev, "No CPU syscon regmap !\n");
 		ret = PTR_ERR(sdhci_sparx5->cpu_ctrl);
-		goto err_clk;
+		goto free_pltfm;
 	}
 
 	if (sdhci_sparx5->delay_clock >= 0)
@@ -225,7 +222,7 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto err_clk;
+		goto free_pltfm;
 
 	/* Set AXI bus master to use un-cached access (for DMA) */
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA) &&
@@ -239,8 +236,6 @@ static int sdhci_sparx5_probe(struct platform_device *pdev)
 
 	return ret;
 
-err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -260,7 +255,7 @@ static struct platform_driver sdhci_sparx5_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_sparx5_probe,
-	.remove_new = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_sparx5_driver);
-- 
2.34.1

