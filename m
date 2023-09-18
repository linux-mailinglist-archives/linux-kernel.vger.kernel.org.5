Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3F7A4426
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbjIRILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbjIRILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:11:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692E94;
        Mon, 18 Sep 2023 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024655; x=1726560655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qZ3GjX/cquXbN0My6239EnQBA462WhVjaagN9mFDH+A=;
  b=aOOUNf1dB8NQhFpxBfTUmLLT9+Xn7IpkF25++WlSTro29m9iaIwrxfGv
   ScbAczXiDuge+90WKciM8cd/Ciz3R0gcFe4FXKAbmfLnnySE2iK0OF3Mh
   T+1xdn75LTl1/xyGuKkQCsqGwjs8EVkbm/60brUAVdb/trRAaJEGd0frF
   Syvr93ISGIrQSeO7grYzr/x4nHB7TUJxZKTyZJWbv9TKRbT//ltD42l1c
   63vMi0bFLJ9/cPVqE4NFwgxGxrURCdbRRE7XWg3lDwnoleMDDxiCFCw85
   9hssYEXU+dF9/DYHuzhhjqvv06/UkmqxECv8b+oOMRwA/Iqb7DhtzCJVl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410551059"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410551059"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442560"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442560"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:10:46 -0700
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
Subject: [PATCH for-next v2 05/10] iio: imu: inv_icm42600: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:46 +0530
Message-Id: <20230918080951.3615-6-raag.jadav@intel.com>
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a5e81906e37e..d0c7e4702981 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -790,7 +790,7 @@ static int inv_icm42600_runtime_resume(struct device *dev)
 	return ret;
 }
 
-EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
+EXPORT_NS_GPL_RUNTIME_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) = {
 	SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_resume)
 	RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,
 		       inv_icm42600_runtime_resume, NULL)
-- 
2.17.1

