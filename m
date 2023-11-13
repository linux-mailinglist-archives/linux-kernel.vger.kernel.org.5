Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70C7E9C45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjKMMkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:40:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869CD79;
        Mon, 13 Nov 2023 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699879198; x=1731415198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E7fDxJK51e9bco+AhBHJ0FtTr2XjHsY+0b0sdYUYno8=;
  b=fQs0wgSImwTyMkW8CuprQWa40kURnpXdlaKkXaNJAeoP2geR1ZFLkLvo
   AmJNYIsWs89s9AnNINjTJWTQOAMTjnh6bBWcSZZWwMjEMB9P0RVr0+cgA
   jTjffWPviUNYt8rI61jbQ0UHhTIp5e/TroIJZ9x8WCGCoaaviAJa8gr2D
   RCiemDP6okPz4EeWOmwomXV5OKYe5T2m3Ldya0I0148xlsLpdPGnq54nB
   LR9zjcrRe/0hLvdn4B4BSNI0ZWYSP21Jw+w8Ms0wJs7ryxAX2i+7vzMWt
   hBSCRYpBd0qw9fBhHcu+73wZnnobe3FhV3K1pcnSInRW+RoMdMrKjO/iE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="476646574"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="476646574"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 04:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="1095740696"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095740696"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 04:39:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 402395C2; Mon, 13 Nov 2023 14:31:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/2] pinctrl: intel: Revert "Unexport intel_pinctrl_probe()"
Date:   Mon, 13 Nov 2023 14:28:47 +0200
Message-ID: <20231113123147.4075203-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231113123147.4075203-1-andriy.shevchenko@linux.intel.com>
References: <20231113123147.4075203-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for a new coming driver export the original
intel_pinctrl_probe() again.

This reverts commit 0dd519e3784b13befa1cdfeff847a0885b06650f.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 5 +++--
 drivers/pinctrl/intel/pinctrl-intel.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 62daf189d3f4..2367c2747a83 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1504,8 +1504,8 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
 	return PTR_ERR_OR_ZERO(pwm);
 }
 
-static int intel_pinctrl_probe(struct platform_device *pdev,
-			       const struct intel_pinctrl_soc_data *soc_data)
+int intel_pinctrl_probe(struct platform_device *pdev,
+			const struct intel_pinctrl_soc_data *soc_data)
 {
 	struct device *dev = &pdev->dev;
 	struct intel_pinctrl *pctrl;
@@ -1623,6 +1623,7 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_pinctrl_probe, PINCTRL_INTEL);
 
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev)
 {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index e7d911a65584..fde65e18cd14 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -252,6 +252,9 @@ struct intel_pinctrl {
 	int irq;
 };
 
+int intel_pinctrl_probe(struct platform_device *pdev,
+			const struct intel_pinctrl_soc_data *soc_data);
+
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
 int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 
-- 
2.43.0.rc1.1.gbec44491f096

