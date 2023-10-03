Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3E7B687E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjJCMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjJCMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:06:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DAA9;
        Tue,  3 Oct 2023 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696334812; x=1727870812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TjniIZhzKzC35iBW82KnmeoLWBQCp+HfnnP4c9zFzAQ=;
  b=NDXhjRBm5KN4eh3IQf4g8OL2rNrv+uU6a/F2s1sXAiKCkqghsOo5AeXj
   lRAQyxYOrqPSgGCDcEVSJy3oR8+SN6VB2OXZiPo4bhBqJ5NaRv003R2bA
   SUygzhf2XlnBiASh6WqYdZtnQs5d3qhuhwfn2N/1XBx6uePJOhmjKiOwd
   9wGPwdi0gIf+A0csv5kHBUiSOKG7o/Lr26WQBM/wM/SeZAoal4MxX9IpH
   3DPHxfQ/07ksCJB8vhjSqD3P16kiv6Jx+hET/U1ykTF0ngBcKycXIrihr
   TjAR48IMULJeeUIBgEOKeOM4CzSITXGg+ZOI4RLJ8o+mAL8z18TSBQCzh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="380135669"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="380135669"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821234279"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="821234279"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2023 05:06:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 92E1718A0; Tue,  3 Oct 2023 15:06:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: core: Remove unneeded {} around one line conditional body
Date:   Tue,  3 Oct 2023 15:06:48 +0300
Message-Id: <20231003120648.2838047-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one line conditional body doesn't require {} surrounding it.
Remove unneeded {}.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e2f7519bef04..5a15583bf4ae 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -445,9 +445,9 @@ struct pinctrl_dev *pinctrl_find_and_add_gpio_range(const char *devname,
 	 * it has not probed yet, so the driver trying to register this
 	 * range need to defer probing.
 	 */
-	if (!pctldev) {
+	if (!pctldev)
 		return ERR_PTR(-EPROBE_DEFER);
-	}
+
 	pinctrl_add_gpio_range(pctldev, range);
 
 	return pctldev;
-- 
2.40.0.1.gaa8946217a0b

