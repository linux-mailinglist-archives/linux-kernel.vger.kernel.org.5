Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D640B779010
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjHKNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE144119;
        Fri, 11 Aug 2023 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759053; x=1723295053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z8+rkxc4P60KdDoslinpq17RvjhrHcszfdDCu5xSmBY=;
  b=Jc16DM3ownDP1zenQO4KnaARPGTd1Sx+ZZ1b5K8Z8amCGQPRD89ZLIvg
   hq/nNFycAPJFMgF47uHvhLoBGinhALJ4ilJ8UxrR9iErFpKUAeYE+ORTp
   KSH3Et71Od0CuonVXAeYgqWTb50H7A0WoEoZu/m5z0IA3olxXkj/PKOi5
   ygcMEigwq34rwQUWo9MJVklttWz1hxvuZJK2g8dd+rfe/nsF0nndG8SsQ
   yiVODDs/GhDf937QHFxzdkieeFYDhCSZTMVv/5E4izjV7PNEKxqZK6LRD
   mS/zsYhzOv/6XDkNeSqq0/w2VPS1Uim2bTr43zcHL03ZExG1rOOFeXMio
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361811604"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361811604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535172"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535172"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:04:03 -0700
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
Subject: [PATCH 00/16] mmc: sdhci-pltfm: Minor clean up
Date:   Fri, 11 Aug 2023 16:03:35 +0300
Message-Id: <20230811130351.7038-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi

sdhci_pltfm_unregister() does:

	clk_disable_unprepare(pltfm_host->clk)

which prevents drivers from using devm_clk_get_enabled() or similar.

Move it out, and where drivers are doing devm_clk_get*() immediately
followed by clk_prepare_enable(), combine them into devm_clk_get_*enabled().

sdhci_pltfm_register() and sdhci_pltfm_unregister() are not paired functions.
That are just helpers and effectively get renamed:

	sdhci_pltfm_register() -> sdhci_pltfm_init_and_add_host()
	sdhci_pltfm_unregister() -> sdhci_pltfm_remove()

Please note, the patches are based on top of some 
"Convert to platform remove callback returning void"
patches by Yangtao Li, which were posted here:

	https://lore.kernel.org/linux-mmc/20230727070051.17778-1-frank.li@vivo.com/

Patches can also be found here:

	https://github.com/ahunter6/linux/commits/sdhci-pltfm-cleanup-1


Adrian Hunter (16):
      mmc: sdhci-pltfm: Add sdhci_pltfm_remove()
      mmc: sdhci-bcm-kona: Use sdhci_pltfm_remove()
      mmc: sdhci-brcmstb: Use sdhci_pltfm_remove()
      mmc: sdhci-cadence: Use sdhci_pltfm_remove()
      mmc: sdhci-dove: Use sdhci_pltfm_remove()
      mmc: sdhci_f_sdh30: Use sdhci_pltfm_remove()
      mmc: sdhci-iproc: Use sdhci_pltfm_remove()
      mmc: sdhci-of-arasan: Use sdhci_pltfm_remove()
      mmc: sdhci-of-at91: Use sdhci_pltfm_remove()
      mmc: sdhci-of-esdhc: Use sdhci_pltfm_remove()
      mmc: sdhci-of-hlwd: Use sdhci_pltfm_remove()
      mmc: sdhci-of-sparx5: Use sdhci_pltfm_remove()
      mmc: sdhci-pxav2: Use sdhci_pltfm_remove()
      mmc: sdhci-st: Use sdhci_pltfm_remove()
      mmc: sdhci-pltfm: Remove sdhci_pltfm_unregister()
      mmc: sdhci-pltfm: Rename sdhci_pltfm_register()

 drivers/mmc/host/sdhci-bcm-kona.c  | 12 +++++++++++-
 drivers/mmc/host/sdhci-brcmstb.c   | 18 +++++-------------
 drivers/mmc/host/sdhci-cadence.c   | 17 ++++-------------
 drivers/mmc/host/sdhci-dove.c      |  8 ++------
 drivers/mmc/host/sdhci-iproc.c     | 14 +++-----------
 drivers/mmc/host/sdhci-of-arasan.c |  4 +++-
 drivers/mmc/host/sdhci-of-at91.c   |  2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   |  4 ++--
 drivers/mmc/host/sdhci-of-sparx5.c | 17 ++++++-----------
 drivers/mmc/host/sdhci-pltfm.c     | 14 ++++++--------
 drivers/mmc/host/sdhci-pltfm.h     |  8 ++++----
 drivers/mmc/host/sdhci-pxav2.c     | 19 ++++++-------------
 drivers/mmc/host/sdhci-st.c        |  4 +++-
 drivers/mmc/host/sdhci_f_sdh30.c   |  2 +-
 15 files changed, 58 insertions(+), 87 deletions(-)


Regards
Adrian
