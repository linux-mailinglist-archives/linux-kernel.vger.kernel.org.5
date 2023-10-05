Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34937BA3DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjJEP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjJEP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC2662D;
        Thu,  5 Oct 2023 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514686; x=1728050686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c+EU5e+VJU8NEVpBuRP3uooNbGb9G1Bmp+k4isAZ9oI=;
  b=I+UJ/siUQ4NNEvZvMFM+fu+j3Zde+8FnOxc+4xbQV44TcbJG52vUAalj
   pincitIqljuR3R97lFBesOhePP4hk0H2lnVZ29umAndFCvRwS/q3HTgPx
   bFa4+NY+PgwUvrA7IW412Op74moxVxgY7C8vc2CDunDOkc/B5pmciE8LR
   inqru4Qz6/m8WInJT80osxIvSfNfhihCIiMTCpwnc9zLYqWed/+/X8mfl
   n//KofCiin9AIVZ7lGWTS218c4M/mISSRwd66aEDqtM6hZbsZKqek7fal
   a5Fcr1eeM0LI7Uz1giRwLGxc6HfiXOdyWTD7ycGkUq7rRwzudKwnfwgK0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386336382"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386336382"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083047510"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083047510"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2023 06:59:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 666BD345; Thu,  5 Oct 2023 16:59:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v1 1/1] pinctrl: denverton: Replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
Date:   Thu,  5 Oct 2023 16:59:45 +0300
Message-Id: <20231005135945.3672438-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Krzysztof pointed out the better is to use MODULE_DEVICE_TABLE()
as it will be consistent with the content of the real ID table of
the platform devices.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-denverton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-denverton.c b/drivers/pinctrl/intel/pinctrl-denverton.c
index a1a7242e0451..562a4f9188e4 100644
--- a/drivers/pinctrl/intel/pinctrl-denverton.c
+++ b/drivers/pinctrl/intel/pinctrl-denverton.c
@@ -261,6 +261,7 @@ static const struct platform_device_id dnv_pinctrl_platform_ids[] = {
 	{ "denverton-pinctrl", (kernel_ulong_t)&dnv_soc_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, dnv_pinctrl_platform_ids);
 
 static struct platform_driver dnv_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
@@ -287,5 +288,4 @@ module_exit(dnv_pinctrl_exit);
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Denverton SoC pinctrl/GPIO driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:denverton-pinctrl");
 MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.40.0.1.gaa8946217a0b

