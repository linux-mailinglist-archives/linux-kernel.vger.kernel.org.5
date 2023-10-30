Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E237DB9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjJ3MId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjJ3MIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:08:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FC9F4;
        Mon, 30 Oct 2023 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667668; x=1730203668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SuALRcFHet1VQPwinCdbLgm/7exVlSMWjFr50V1Snuk=;
  b=ZQzHrZsVzik5pj7RW4Al94L1au3HfycFk2ePpMoplRXgVUtLAed3yDxj
   ynbl2f88zm24rsFDDusC5ET+v4IzWKdqUJm8I43Cyy6HE+IrJnnaLgiH1
   wGO5dHtz5/PkvXiYRuSXmap92wzZ3mBm4hsQBwf7kl0/oho8NBYGSvjDL
   QhqPUDGSKRW1Dc8Ezt+FQa3p7EfEq2kNNvzB3NvC/vz+neRq5IfgHrz4t
   wUT4HkwtMbV1EWoFf+q7Q9DidAwROtS9pwDi3Sg6q+mSr2n9f5/wiIpBH
   JYcq2CgylWIKmYEbdRRPtm77ZTfqKA4ohhdrfj/CGCtxp3/vB1+rfUoWs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6691350"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6691350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826036562"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826036562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 05:07:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9337551D; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 17/17] pinctrl: intel: Make PM ops functions static
Date:   Mon, 30 Oct 2023 14:07:34 +0200
Message-Id: <20231030120734.2831419-18-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users outside of the main module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 6 ++----
 drivers/pinctrl/intel/pinctrl-intel.h | 9 ---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 9fbdc7bfa65c..f1d8f7e0d9b7 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1727,7 +1727,7 @@ static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl, unsigned int
 	return false;
 }
 
-int intel_pinctrl_suspend_noirq(struct device *dev)
+static int intel_pinctrl_suspend_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	struct intel_community_context *communities;
@@ -1770,7 +1770,6 @@ int intel_pinctrl_suspend_noirq(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_pinctrl_suspend_noirq);
 
 static bool intel_gpio_update_reg(void __iomem *reg, u32 mask, u32 value)
 {
@@ -1837,7 +1836,7 @@ static void intel_restore_padcfg(struct intel_pinctrl *pctrl, unsigned int pin,
 	dev_dbg(dev, "restored pin %u padcfg%u %#08x\n", pin, n, readl(padcfg));
 }
 
-int intel_pinctrl_resume_noirq(struct device *dev)
+static int intel_pinctrl_resume_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	const struct intel_community_context *communities;
@@ -1881,7 +1880,6 @@ int intel_pinctrl_resume_noirq(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
 
 EXPORT_NS_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops, PINCTRL_INTEL) = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index d3f511f97ed9..e7d911a65584 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -255,15 +255,6 @@ struct intel_pinctrl {
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
 int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 
-int intel_pinctrl_suspend_noirq(struct device *dev);
-int intel_pinctrl_resume_noirq(struct device *dev);
-
-#define INTEL_PINCTRL_PM_OPS(_name)					\
-const struct dev_pm_ops _name = {					\
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,	\
-				      intel_pinctrl_resume_noirq)	\
-}
-
 extern const struct dev_pm_ops intel_pinctrl_pm_ops;
 
 struct intel_community *intel_get_community(struct intel_pinctrl *pctrl, unsigned int pin);
-- 
2.40.0.1.gaa8946217a0b

