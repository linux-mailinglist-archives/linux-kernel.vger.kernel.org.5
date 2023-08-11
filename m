Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0A779061
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjHKNIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjHKNHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:07:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A83594;
        Fri, 11 Aug 2023 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759244; x=1723295244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LId8a7HwDxC1IoswqQqzYbnaFhMlLbhkTHUD6bZclso=;
  b=CtAZ96YJ6ZPwnqpIlYLYoCrvOd3GZ14zrUECURSaP28xsi0qdXjSzGyQ
   v8DKz2+TJ9RQ/PMjYPeVeNA5/lLeQ/tyOGw0d7zx7ud3qXgtdBxkmVqfX
   /Ixqqh0UTyjkvK//booJp8MD5hZougg/X8wMUmbk0NvFp9jS1XVvRjEA3
   tUGOsv6LOQ8MbjsUy/Ul+x/eE4BqrybOTuOb2rAn2JZXOtpVK2Kx0ScAu
   UfMCvI8gsjHqlPD+gZC/h5KaIjjpuNE2bHCUx5YP1lLIliS+UK0C6kz8Q
   8b1dxh56ghsjnS4vUYEUzZu42wVhnql98cd1mjyoS2ydoSvuCKWDsMTYg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361812905"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361812905"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535540"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535540"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:06:29 -0700
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
Subject: [PATCH 16/16] mmc: sdhci-pltfm: Rename sdhci_pltfm_register()
Date:   Fri, 11 Aug 2023 16:03:51 +0300
Message-Id: <20230811130351.7038-17-adrian.hunter@intel.com>
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

Now that sdhci_pltfm_unregister() has been removed, rename
sdhci_pltfm_register() to sdhci_pltfm_init_and_add_host() to better
reflect what it does.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-hlwd.c | 2 +-
 drivers/mmc/host/sdhci-pltfm.c   | 8 ++++----
 drivers/mmc/host/sdhci-pltfm.h   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 06e88bb22ea5..9c1c0ce610ef 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -68,7 +68,7 @@ static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
 
 static int sdhci_hlwd_probe(struct platform_device *pdev)
 {
-	return sdhci_pltfm_register(pdev, &sdhci_hlwd_pdata, 0);
+	return sdhci_pltfm_init_and_add_host(pdev, &sdhci_hlwd_pdata, 0);
 }
 
 static const struct of_device_id sdhci_hlwd_of_match[] = {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 894f3bbe2b0f..a72e123a585d 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -166,9 +166,9 @@ void sdhci_pltfm_free(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
 
-int sdhci_pltfm_register(struct platform_device *pdev,
-			const struct sdhci_pltfm_data *pdata,
-			size_t priv_size)
+int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
+				  const struct sdhci_pltfm_data *pdata,
+				  size_t priv_size)
 {
 	struct sdhci_host *host;
 	int ret = 0;
@@ -185,7 +185,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
+EXPORT_SYMBOL_GPL(sdhci_pltfm_init_and_add_host);
 
 void sdhci_pltfm_remove(struct platform_device *pdev)
 {
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index bebc450d5098..b81d5b0fd616 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -99,9 +99,9 @@ extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  size_t priv_size);
 extern void sdhci_pltfm_free(struct platform_device *pdev);
 
-extern int sdhci_pltfm_register(struct platform_device *pdev,
-				const struct sdhci_pltfm_data *pdata,
-				size_t priv_size);
+extern int sdhci_pltfm_init_and_add_host(struct platform_device *pdev,
+					 const struct sdhci_pltfm_data *pdata,
+					 size_t priv_size);
 extern void sdhci_pltfm_remove(struct platform_device *pdev);
 
 extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
-- 
2.34.1

