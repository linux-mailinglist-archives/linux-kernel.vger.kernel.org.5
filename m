Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB097C0033
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjJJPRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjJJPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:17:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A8C9;
        Tue, 10 Oct 2023 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696951036; x=1728487036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfi2ScUuQ38Rjpas5/iU2szLV7W2WROp/dyzeK87y4E=;
  b=csOEtFfhoWAPmG3pgKhLABa0dAjecUwK8QWP7LbERrL+bidKI7hA4YgE
   tEgyBc3Y0xpSKND4DcLlz/tJpdqDxxIdRsXuMX7JvqpjPGOLqh2FKfsPB
   rUVAe+mP4bzDa6b9jQdSAi4nVdSVZO4iCXOeoD4ZckSIJJMgWiSMaN9Be
   KxXro7+IaF3U3CwE7P/pr2skxcpF8LMaA0QdYwIB3z1YYJzF7tN77gVB4
   GJvqREEGfacXijwQPNM+JUjU6UiYfTei/nWpbaGUUTUPJrDgOPWfz01ff
   cOsKtPmVq1a5Wlyo069zQIa4vhOzOFAw5wY/GxLn1StgvAEmiGnNoWYhi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363771593"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="363771593"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823812776"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="823812776"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 08:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 484EE6DA; Tue, 10 Oct 2023 18:17:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 3/4] hte: tegra194: Remove redundant dev_err()
Date:   Tue, 10 Oct 2023 18:17:08 +0300
Message-Id: <20231010151709.4104747-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the dev_err() function directly to print a custom
message when handling an error from platform_get_irq() function as it is
going to display an appropriate error message in case of a failure.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hte/hte-tegra194.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 339ff5921ec8..30ef1750a9fa 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -731,10 +731,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "failed to get irq\n");
+	if (ret < 0)
 		return ret;
-	}
 	hte_dev->hte_irq = ret;
 	ret = devm_request_irq(dev, hte_dev->hte_irq, tegra_hte_isr, 0,
 			       dev_name(dev), hte_dev);
-- 
2.40.0.1.gaa8946217a0b

