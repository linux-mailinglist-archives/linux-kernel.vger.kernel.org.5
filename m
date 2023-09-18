Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957657A4434
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjIRILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbjIRIKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:10:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87699;
        Mon, 18 Sep 2023 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024647; x=1726560647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=r1CpW7kgq3if3Jc00gzYCuqJwiMxcedcZb4XZfdjY5A=;
  b=YNF2BEJnTC7FB/D9rDKLl+f9Ld+ag9epgwtUYRN8ebzvz0KBrMPx7Xp0
   w8kVPZeBsFD+bIQlONXpQWd5+TcOJrCIL3/TA2wh5tuQ0TXc7uTN3/tfQ
   YmvVKB7u2vx5TgEpMGkwUkP0aFtRgxH40Djb4o8nd6WxDnglp7bWaWdVL
   8Nns+39o2VfxW0JVy6iUClk9IliYp+pimaU+vLzj8sVfsJ6BdY45cJal0
   D1dkrZjS5AZTOQGZuIbBdqN+w6Z0+C5R9CWX/KLUpgaOudLDfhVYk27mV
   8Xf8x/idOtZvvtyq6EVsLPMefc6SYZJ2CEAJk31yboL0Ko+bvB3N9Iz9p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410551018"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410551018"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442515"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442515"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:10:40 -0700
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
Subject: [PATCH for-next v2 04/10] iio: gyro: fxas21002c: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:45 +0530
Message-Id: <20230918080951.3615-5-raag.jadav@intel.com>
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
 drivers/iio/gyro/fxas21002c_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index c28d17ca6f5e..ccea3dd7be28 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -1047,7 +1047,7 @@ static int fxas21002c_runtime_resume(struct device *dev)
 	return fxas21002c_mode_set(data, FXAS21002C_MODE_ACTIVE);
 }
 
-EXPORT_NS_GPL_DEV_PM_OPS(fxas21002c_pm_ops, IIO_FXAS21002C) = {
+EXPORT_NS_GPL_RUNTIME_PM_OPS(fxas21002c_pm_ops, IIO_FXAS21002C) = {
 	SYSTEM_SLEEP_PM_OPS(fxas21002c_suspend, fxas21002c_resume)
 	RUNTIME_PM_OPS(fxas21002c_runtime_suspend, fxas21002c_runtime_resume,
 		       NULL)
-- 
2.17.1

