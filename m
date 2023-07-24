Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A820875FB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGXQNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjGXQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFB10F5;
        Mon, 24 Jul 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215204; x=1721751204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fh5M9h1tdqdfGuthjHR2Aj2Kf7ae0/kXGfXtNCxVjfM=;
  b=INxdD3MYDTmKj8c6uKw4QGZWB5wWqHzJORpmxvhg83DNYPnJLM10dpfw
   Qo+Lg0Wy17D75Pkpf53ixim+p5yEhLl04EdFNN3v9WIIleq+RyA5urBbt
   JGMEvsXicl2MEyTma2Lo+ULVvwnqgrT2AT+PxKbHQVzaz2E/u/va2otOo
   aFJVbU8wW3mIBnqRr/Nt8FTIrDv0yB6W1ZJp4bPVyqSMXKxCvR9Wg8zqB
   Glnb2w/PFxE6y7UQHTzZ2pPzCjPmmexNg/CXZh5lJJjMNyGUhe0SxOe3b
   Udmu7HOJgE+oGzrhVPANQaljdCWNF7f6Bicj+qJdk7iMEH+21U+oase64
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347089852"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347089852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815884110"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815884110"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 09:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F3952BC; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v1 2/6] gpio: ge: Fix English spelling and grammar
Date:   Mon, 24 Jul 2023 19:13:16 +0300
Message-Id: <20230724161320.63876-3-andriy.shevchenko@linux.intel.com>
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

Fix English spelling and grammar in the comments.
While at it, fix the MODULE_AUTHOR() email address format.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/r/65b4ac1a-1128-6e2a-92c0-9bbcca4b760a@infradead.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-ge.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index ecadb81ce7f8..f92b3c8a3a8a 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -10,11 +10,12 @@
  * kind, whether express or implied.
  */
 
-/* TODO
+/*
+ * TODO:
  *
- * Configuration of output modes (totem-pole/open-drain)
- * Interrupt configuration - interrupts are always generated the FPGA relies on
- * the I/O interrupt controllers mask to stop them propergating
+ * Configuration of output modes (totem-pole/open-drain).
+ * Interrupt configuration - interrupts are always generated, the FPGA relies
+ * on the I/O interrupt controllers mask to stop them from being propagated.
  */
 
 #include <linux/gpio/driver.h>
@@ -104,5 +105,5 @@ static struct platform_driver gef_gpio_driver = {
 module_platform_driver_probe(gef_gpio_driver, gef_gpio_probe);
 
 MODULE_DESCRIPTION("GE I/O FPGA GPIO driver");
-MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com>");
 MODULE_LICENSE("GPL");
-- 
2.40.0.1.gaa8946217a0b

