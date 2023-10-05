Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0735A7BA3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbjJEP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjJEP46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA8662C;
        Thu,  5 Oct 2023 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514686; x=1728050686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v3qwi4Il0uHXyU4Gb6XPvF3wdo1K10RCU84IBPX9PAY=;
  b=FLhOYnH7C3pauGeZRfVHa7cH9JXHSYA+mnwV09U1YsqRuEzBjG2ZsYUu
   locsd1v8C+Duf6bpjkMQssfsrqiaMB7aIXS3CNu2TFhxaPNuX3kYv9Cwe
   NCtltdvrjA4aM7GzGeOKwj7RYh0W8IzCZNj0PhiAGVhrBfi2npa70TpMF
   kuvY3L2ymRQ2zFYO2h7MGQ5CqG+rYojbO24Pf3VxstMCq8GRRZSe6yqwW
   8/e+9AaH+tJwszDcPuLJUdlfooe2SwVooJSZwg+vRkImo4ijyq5IpZlF1
   BiYur3qCFJbi6NaOdzZcQ6LR7ABxgF2TsqgXQ2wAwV7xsMNbLqp/SqAji
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386336355"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386336355"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083047490"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083047490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2023 06:59:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A1E02345; Thu,  5 Oct 2023 16:59:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v1 1/1] pinctrl: broxton: Replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
Date:   Thu,  5 Oct 2023 16:39:49 +0300
Message-Id: <20231005133949.3613943-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-broxton.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-broxton.c b/drivers/pinctrl/intel/pinctrl-broxton.c
index 4d5ddb297909..3118c7c8842f 100644
--- a/drivers/pinctrl/intel/pinctrl-broxton.c
+++ b/drivers/pinctrl/intel/pinctrl-broxton.c
@@ -998,6 +998,7 @@ static const struct platform_device_id bxt_pinctrl_platform_ids[] = {
 	{ "broxton-pinctrl", (kernel_ulong_t)bxt_pinctrl_soc_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, bxt_pinctrl_platform_ids);
 
 static INTEL_PINCTRL_PM_OPS(bxt_pinctrl_pm_ops);
 
@@ -1026,6 +1027,4 @@ module_exit(bxt_pinctrl_exit);
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Broxton SoC pinctrl/GPIO driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:apollolake-pinctrl");
-MODULE_ALIAS("platform:broxton-pinctrl");
 MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.40.0.1.gaa8946217a0b

