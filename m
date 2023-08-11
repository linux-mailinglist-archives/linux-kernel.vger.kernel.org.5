Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA00779050
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHKNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjHKNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:07:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0B3AA5;
        Fri, 11 Aug 2023 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759200; x=1723295200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ld9CK0rCa3tPsrpHzxmuQkRBDumJn2j+IQr/7+g+C+4=;
  b=NOhgzVmzkcDHjDld3+m5Sy0Ao9iwwSNqSHCqt2TK5/8EWLSyEBY/a8V3
   cSpmBMHanTm0n3TdDQTJiXmkp/S77uCzyYBcO3vJJMqQfAbEUnhvh9piy
   7OY2ZpyTTbg8mI+4w37bXQBADF7qs/etamflYp+OJnKwzc5wS6affkR21
   cGgjXSs00mW8802GO3XAOaJ6cAwVfTxKBwtEgM4TUVvU6x9/GN64ZS120
   WTZ5nlwVixkummFv54eoBoINVP6Ny+ws5uvOCHbZpmo7CaUBel67DlhqV
   pXdHIveU3xgA0iI3BCzLtMAlmjGZ3d88D7qC24mDe9GMFhG7Fxadlm4x+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361812509"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361812509"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535268"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535268"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:30 -0700
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
Subject: [PATCH 10/16] mmc: sdhci-of-esdhc: Use sdhci_pltfm_remove()
Date:   Fri, 11 Aug 2023 16:03:45 +0300
Message-Id: <20230811130351.7038-11-adrian.hunter@intel.com>
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

Use sdhci_pltfm_remove() instead of sdhci_pltfm_unregister() because
sdhci_pltfm_unregister() is going to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5072b59f6165..3ae9aa25745a 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.pm = &esdhc_of_dev_pm_ops,
 	},
 	.probe = sdhci_esdhc_probe,
-	.remove_new = sdhci_pltfm_unregister,
+	.remove_new = sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_esdhc_driver);
-- 
2.34.1

