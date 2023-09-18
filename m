Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45AA7A4419
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbjIRILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjIRIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:10:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865494;
        Mon, 18 Sep 2023 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024642; x=1726560642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RDJPisfJjUJt530FHZOgWYbOdATdjB0I5DUbkK2VW5U=;
  b=PjEVba7YbaNiz8pQtaU9dvIyWS1WY5JJCr0o84+raR0JfPh7ksKoipEz
   z24efje93XupTRcd4tb8QGB+uZx+zjqC6vkDykA9L6VlSu0sBl0+4AMp4
   l4oTXCfyFTfyPgkTZuuAwBgUX+kqUx3DHf2hrWzHlyyjnrO+rQhX1+QEK
   5MGEkdztyhBT3HL7T0jY8GZktBjCOSRLnupMqB7dy0n16QjssnXNZBJvx
   Ra9o2VTceFOPD+NRNNuGKobN4P1P0Ad2x6/2Hl2/jlB8yOVtSbhyeCSFn
   dclkTyX2uX2ruqrtA6AUxV8+eRC8OKd79S9K6snVpMgog8hyo3QhzrHkU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410550976"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410550976"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442423"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442423"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:10:33 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        rmfrfs@gmail.com, jean-baptiste.maneyrol@tdk.com, lee@kernel.org,
        laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v2 03/10] iio: accel: fxls8962af: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:44 +0530
Message-Id: <20230918080951.3615-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918080951.3615-1-raag.jadav@intel.com>
References: <20230918080951.3615-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With original macro being renamed to EXPORT_NS_GPL_RUNTIME_PM_OPS(),
use the new macro.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/iio/accel/fxls8962af-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index be8a15cb945f..69e73c54047e 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1282,7 +1282,7 @@ static int fxls8962af_resume(struct device *dev)
 	return 0;
 }
 
-EXPORT_NS_GPL_DEV_PM_OPS(fxls8962af_pm_ops, IIO_FXLS8962AF) = {
+EXPORT_NS_GPL_RUNTIME_PM_OPS(fxls8962af_pm_ops, IIO_FXLS8962AF) = {
 	SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend, fxls8962af_resume)
 	RUNTIME_PM_OPS(fxls8962af_runtime_suspend, fxls8962af_runtime_resume, NULL)
 };
-- 
2.17.1

