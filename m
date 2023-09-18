Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A47A443C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbjIRIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjIRILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:11:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B5D2;
        Mon, 18 Sep 2023 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024694; x=1726560694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SKBpwvJ+2z+sXH/P1raKgMvPz1M4b8A8fYC4yoa4lwM=;
  b=E6wCBSzCBIHziGkulYHe54BRTOvsMR2KkOrf2J8dlnjM99BVOpX+Ue6y
   u4SyfZlXgeuANEWbk2VYaFOxc8jloLp0ktdaaTvspP4dTtvOZqwopWKkn
   hkPBnro0bf82FQP2PqgXzIx/nFWe4zFKlwzDceiXPHznn5SaIAV9j0lJH
   ALG/EUR26avsNY+1A5TsnKbsXkMFMBgn3TbfnpeKD8Be5Fv74ZUoe9pJc
   6QVXMxz+0/+kWQ8oDwBqQWJqGBZNeoPfZSQc8E36bxk5TMpJAed8x30iu
   7Q6CArkcVQ0fnd3DYEdvoFkCdpUnZd/g/dV6foZ+X93wKoHCK3/AmGTau
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410551297"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410551297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442857"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442857"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:11:23 -0700
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
Subject: [PATCH for-next v2 10/10] ASoC: cs35l41: convert to EXPORT_GPL_RUNTIME_PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:51 +0530
Message-Id: <20230918080951.3615-11-raag.jadav@intel.com>
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
 sound/soc/codecs/cs35l41.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 4bc64ba71cd6..651aeaa6a5c4 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1454,7 +1454,7 @@ static int cs35l41_sys_resume(struct device *dev)
 	return 0;
 }
 
-EXPORT_GPL_DEV_PM_OPS(cs35l41_pm_ops) = {
+EXPORT_GPL_RUNTIME_PM_OPS(cs35l41_pm_ops) = {
 	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
 
 	SYSTEM_SLEEP_PM_OPS(cs35l41_sys_suspend, cs35l41_sys_resume)
-- 
2.17.1

