Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8937F1627
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjKTOr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjKTOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:47:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877DD65;
        Mon, 20 Nov 2023 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700491619; x=1732027619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MsQEfbBN1HcZU/6xkH82vQLZL3LbP0Qpqn2wuJGDYp4=;
  b=OneQezRPT98pCnqSvPkyy+rHDmgmuQpT573unsufq2GiQa1Rs0DQpHpr
   JRJV/3rgRH3w9iugL0Lf6zflNFk+Kckyzs+Dy/XVksM0Bz3s/Lj7hyahG
   88z4H1vGhPSvG368fyrUm5Ev5JaEw2X3CViMN41TMLbF25VOXC02m/BP6
   +m4lAhYdt62zpGO1GP+WVR8DmimykVQEgFl92n4UuV8nyvPUfaal+UtD/
   qmXXannqUfX7AaEyKBe9n8khq88zSiGsE/p2wXa6Y/MDBXZBSpTU7OJfh
   JMMlMQO82+ACpUzuuJ7qFWwgYYxvvK3M5jXxVUfPk4PpwiEB4t9XLRovH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="455956504"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="455956504"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801193203"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801193203"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:46:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA2B3376; Mon, 20 Nov 2023 16:46:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 13/24] i2c: designware: Rename dw_i2c_of_configure() -> i2c_dw_of_configure()
Date:   Mon, 20 Nov 2023 16:41:55 +0200
Message-ID: <20231120144641.1660574-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of consistency, rename dw_i2c_of_configure() and change
its parameter to be aligned with the i2c_dw_acpi_configure().

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7449f1b37ecf..b8606b651feb 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -110,9 +110,10 @@ static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-static void dw_i2c_of_configure(struct platform_device *pdev)
+static void i2c_dw_of_configure(struct device *device)
 {
-	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(device);
+	struct dw_i2c_dev *dev = dev_get_drvdata(device);
 
 	switch (dev->flags & MODEL_MASK) {
 	case MODEL_MSCC_OCELOT:
@@ -130,7 +131,7 @@ static int bt1_i2c_request_regs(struct dw_i2c_dev *dev)
 	return -ENODEV;
 }
 
-static inline void dw_i2c_of_configure(struct platform_device *pdev)
+static inline void i2c_dw_of_configure(struct device *device)
 {
 }
 #endif
@@ -306,7 +307,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	i2c_dw_adjust_bus_speed(dev);
 
 	if (pdev->dev.of_node)
-		dw_i2c_of_configure(pdev);
+		i2c_dw_of_configure(&pdev->dev);
 
 	if (has_acpi_companion(&pdev->dev))
 		i2c_dw_acpi_configure(&pdev->dev);
-- 
2.43.0.rc1.1.gbec44491f096

