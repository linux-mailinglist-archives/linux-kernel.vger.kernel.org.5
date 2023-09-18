Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054BE7A442C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbjIRILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbjIRILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:11:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7EC99;
        Mon, 18 Sep 2023 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024679; x=1726560679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JOfYWZvSrqz98ohv43tBDBTpo/UNSaZ+11aVlYab1rY=;
  b=H36Q5HA4xni35nZY2dUIEFEIvdnnTukfErQHm0plNLWTwyhnV8bv9rQW
   8WGm1glwXTxjmCeJkFjVB3WlIE2HpTim4tYv++OQdmKu4wmenTllWKJ8O
   4yTkb1ydM62Xj1yXmBI3oAAAJTyQV0v88enB+BOTi+Ysk6A7aYYL2QGlD
   mHsRbfxjavxHm6pwpOciP8oOzyO5sz0WnJnoY1L+ofphB667ByjvwXGCa
   bHPHXbDZKQukT89h95IuyEQarW6vTik3pNx4R+1Tj3jBkuNJ/nDwF5jSA
   felKiKPJiNMqA3Uos1sExpGCZIiv5U5KwuthKLdj/boHzSN0f5pzOEZD1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410551226"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410551226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442772"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442772"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:11:07 -0700
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
Subject: [PATCH for-next v2 08/10] mfd: arizona: convert to EXPORT_GPL_RUNTIME_PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:49 +0530
Message-Id: <20230918080951.3615-9-raag.jadav@intel.com>
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

With original macro being renamed to EXPORT_GPL_RUNTIME_PM_OPS(),
use the new macro.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/mfd/arizona-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 19a0adf8ce3d..1d36deb1b79f 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -781,7 +781,7 @@ static int arizona_resume(struct device *dev)
 	return 0;
 }
 
-EXPORT_GPL_DEV_PM_OPS(arizona_pm_ops) = {
+EXPORT_GPL_RUNTIME_PM_OPS(arizona_pm_ops) = {
 	RUNTIME_PM_OPS(arizona_runtime_suspend,
 		       arizona_runtime_resume,
 		       NULL)
-- 
2.17.1

