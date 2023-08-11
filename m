Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC7779041
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjHKNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjHKNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9AC3584;
        Fri, 11 Aug 2023 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759079; x=1723295079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJ+oDcj0/HsM4ftQsJN9ghcnz+v/hRDm+Rt5+H5fL6M=;
  b=ieuY2SYnhhUGwteyVFcuSQmpGIhpao+uxBtfENHxGnjRtu8eGx95KHNo
   MuDd62Eii3DGpXcpxSxtUBudTPlSVacwRMKEECLFg3KV4wWL9MVvuyGDg
   Lee/w3WVNc0Ip9RXYHcfAc+LWXPOm+QSXyXsc5pgeU38Un0i/31U3k7NJ
   SsvvENYAcGF4nziV4WYHu5Hzca9ub+ZF1DsVgHJlxFPE/nx3tgInTJY94
   WqL8sQzhr89aqt6K4AjBVuCel4vHZZmyW9OcudDcBSC7YOuFGAl5h+u1b
   1tuC6auRetHhHU3d1uybroFSEhlN4S3DnQJUSUm0vvBwZwVzaLaZUHkpv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361811747"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361811747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535211"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535211"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:04:29 -0700
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
Subject: [PATCH 03/16] mmc: sdhci-brcmstb: Use sdhci_pltfm_remove()
Date:   Fri, 11 Aug 2023 16:03:38 +0300
Message-Id: <20230811130351.7038-4-adrian.hunter@intel.com>
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
devm_clk_get_optional_enabled() can be used for pltfm_host->clk.

This has the side effect that the order of operations on the error path
and remove path is not the same as it was before, but should be safe
nevertheless.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index a2b6d8f2eeb6..c23251bb95f3 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -264,23 +264,17 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Probe found match for %s\n",  match->compatible);
 
-	clk = devm_clk_get_optional(&pdev->dev, NULL);
+	clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
-				     "Failed to get clock from Device Tree\n");
-
-	res = clk_prepare_enable(clk);
-	if (res)
-		return res;
+				     "Failed to get and enable clock from Device Tree\n");
 
 	memset(&brcmstb_pdata, 0, sizeof(brcmstb_pdata));
 	brcmstb_pdata.ops = match_priv->ops;
 	host = sdhci_pltfm_init(pdev, &brcmstb_pdata,
 				sizeof(struct sdhci_brcmstb_priv));
-	if (IS_ERR(host)) {
-		res = PTR_ERR(host);
-		goto err_clk;
-	}
+	if (IS_ERR(host))
+		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
@@ -369,9 +363,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 err:
 	sdhci_pltfm_free(pdev);
-err_clk:
 	clk_disable_unprepare(base_clk);
-	clk_disable_unprepare(clk);
 	return res;
 }
 
@@ -430,7 +422,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-	.remove_new	= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_remove,
 	.shutdown	= sdhci_brcmstb_shutdown,
 };
 
-- 
2.34.1

