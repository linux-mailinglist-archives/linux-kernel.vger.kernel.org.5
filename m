Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A417F7799E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjHKVuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjHKVuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:50:14 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 14:50:12 PDT
Received: from smtpdh19-su.aruba.it (smtpdh19-su.aruba.it [62.149.155.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A72D43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:50:12 -0700 (PDT)
Received: from localhost.localdomain ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Ua0Aq7XLHFroIUa0CqW4bs; Fri, 11 Aug 2023 23:49:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1691790548; bh=KJngbAjEFPIyEBfjQn07lPW+qRTIhtdwoSvYTeTqKZY=;
        h=From:To:Subject:Date:MIME-Version;
        b=D0rnICc6gHCRqrtX0c/5GJvFlidvSBLxQKTGADCP8vpvR3pCflK5tMIGRpPxCsWUN
         goWIH+T4ZzTjSRWekdEcN6k8Y87bkWZvE2Dhj8oUpbzWnJmFcnlSOIYQ1dAV0BGR1V
         qtJ6qWcjLfAN5CBHI7cu5mCqHvqmchWU3+/wsb9CbVf99Q3fuUNEDebW4sYqgFNSnX
         GHjwIeqxfLhZAwVwAXjD5bIfnmeVHPVOzbAW+Rm8dT4/EJVSAXtg0sHCp7jBTjILq7
         mY6lcv8jLNDVrJ9G1gGeG81FnvfjQ7G4ZTmmOAyswkE/komPpxh9D8SjrPicaCsoPW
         mN8rgsxqgTPVw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
Date:   Fri, 11 Aug 2023 23:48:53 +0200
Message-Id: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHpN8j46R7b2UpflHNODCxRDbca5TpBTdczR3rUGOoes8cF4qEerGe3nlPgCwdTFQN9CLc6xzMi1zADjleFUxD+qnOhufHUAubLxLwS2DpoLzPDYxiTk
 yI5czAh5FHAzUV0Qkwj2zj1ziTPr4iwVxovcDHdHuRF4y/fVAi2MBI2RzRj56YvegBAHUuB/f0+OTa8EwUWnqDhE/Mx9mxOad5sbWEBvwBeeFOH5K1j8AlZB
 4T5YD0k6hcl7x7A6746gS048o1R96aA4VnTLjPYUCgLR15pmLd3eDhBYI7ISx0f25huCh3JXevu5LspKeJhdvpy6rHieCumdl9XADoj3sK9yiYo1CePhTHXz
 pXnBPnJB6cs3x4D1zgDClPZ7hH17nDvOuwZc2nrJUNSvSfAn+/x5pfhfzAF1WmBEkpya/nSrfD5tEM1gWBmUfouGq6OYeKaoLzcDgGsQXfsbpbHKc5KvPQha
 y3K+yjXxA6/TT8zHPjThrtSADYUa4IdobJr76MSnx5cKAPg/ngvmCd/bojNgPawSqNzWdEj5pO/dDGvoKn2g5Eit4yG67j9dNqJD4VdfTxhkET+jKDeUbCXD
 doALwMcFkupxx4LtIHMYo4bgf6MxtpYx9pg8Sow9h4c5sGK/i+qowJQVFNNYXDQrbAj5E6DZL0mWOaW2YpmLS4YkQI0hWa5dH6eymCcXYMSn9JOXA2oGusTA
 jllcmnfTfVY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
supplied by 3v3 the errata can be ignored. So let's check for if quirk
SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.

Sponsored by: Tekvox Inc.
Cc: Jim Reinhart <jimr@tekvox.com>
Cc: James Autry <jautry@tekvox.com>
Cc: Matthew Maron <matthewm@tekvox.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index eebf94604a7f..cddecc1e1ac2 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -171,8 +171,8 @@
 #define ESDHC_FLAG_HS400		BIT(9)
 /*
  * The IP has errata ERR010450
- * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
- * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
+ * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
+ * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
  */
 #define ESDHC_FLAG_ERR010450		BIT(10)
 /* The IP supports HS400ES mode */
@@ -961,7 +961,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
+	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
+	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
 		unsigned int max_clock;
 
 		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
-- 
2.34.1

