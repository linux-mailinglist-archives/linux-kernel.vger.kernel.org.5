Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61CD75FB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGXQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGXQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318D10FD;
        Mon, 24 Jul 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215205; x=1721751205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RG8VsiElN3tPMSruZOdFSG7H2jFBx3bqqLi4H8oXmwQ=;
  b=c43s9KzwC4j6PVYEZFZy9KkHf3YzsSWeVUvuS+n+eg837yeDgPuUsx67
   wVRj173ICg7J66WEdUK3LJlCJsXPo12r0kcaoivwLgvxUl0jU3pdIUHw3
   Q8aEJwWRV9yf/MZxtho7bUASxbOQqOwk5Pbs1GCL0mf2kaatO2nlLQy+V
   NZ+hFHwEU7FoybRG2R3EjA/A/I+h1Ao9iKZgYjDQA6AC2ncYY6MhiPc0G
   +/cOpHvR5/DcY1FxfruxA8L4g2wyXe5yZedmmkTPFrQhBjs0q4YurWXoK
   ntXkboWvZ8Rx0b6RP4kXx5tL0MX69EqzEpH1D+DIVkmB2KWVn6nH9WPxr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347089871"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347089871"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815884111"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815884111"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 09:13:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5116376; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 6/6] gpio: ge: Enable COMPILE_TEST for the driver
Date:   Mon, 24 Jul 2023 19:13:20 +0300
Message-Id: <20230724161320.63876-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver is so simple, yet there was a room for mistakes.
Reduce their appearance in the future by enabling COMPILE_TEST
option.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7d41f59d21d8..5981ad290c6e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -282,7 +282,7 @@ config GPIO_EXAR
 
 config GPIO_GE_FPGA
 	bool "GE FPGA based GPIO"
-	depends on GE_FPGA
+	depends on GE_FPGA || COMPILE_TEST
 	select GPIO_GENERIC
 	help
 	  Support for common GPIO functionality provided on some GE Single Board
-- 
2.40.0.1.gaa8946217a0b

