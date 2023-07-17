Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB275663D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGQOVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGQOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:21:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1B98;
        Mon, 17 Jul 2023 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689603711; x=1721139711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQ7zOf20oE8XNZm2qF5j348lP5D/2PnIX1KMRMac/Io=;
  b=gijx0SPIkiQgYkp/numjuFB2PMj3TjHQsqbZn9rGkGAov+apYeuF7Fhq
   6miY7pIM6FsXfupr7zZMyLMeYMvznKmBqlnMPbBgDT9lABE9lkacNPdj1
   d87aAACEDN3DrBYDHk2vsJ7M4erakTOETOr/5/qoIqtVk7tEB2BoF+AaT
   uZXMBkkyXtcXX4WDT328TsLuA8xJyF50dHdpaKKRVlY9oOKGTQC1Mej8U
   4Y7PjB1arFHEaAd28Ivnp74vPa3X5GyKBfoY+lZaeoZ1h0zuVeQutkdfC
   Lkvhqcg9HJLFa6zCZpSV6gpNkfIW4/jbbkdQvz8hkfU0NQKRJBXV9z6BX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432112879"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432112879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="717257685"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="717257685"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2023 07:18:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B4A7370; Mon, 17 Jul 2023 17:18:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2 3/3] gpio: bcm-kona: Drop unused pdev member in private data structure
Date:   Mon, 17 Jul 2023 17:18:45 +0300
Message-Id: <20230717141845.41415-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
References: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
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

The pdev member is assigned and not used, drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/gpio-bcm-kona.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 9af1549ee0df..0e3fdb42b9ed 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -63,7 +63,6 @@ struct bcm_kona_gpio {
 	struct gpio_chip gpio_chip;
 	struct irq_domain *irq_domain;
 	struct bcm_kona_gpio_bank *banks;
-	struct platform_device *pdev;
 };
 
 struct bcm_kona_gpio_bank {
@@ -590,7 +589,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 	if (!kona_gpio->banks)
 		return -ENOMEM;
 
-	kona_gpio->pdev = pdev;
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
-- 
2.40.0.1.gaa8946217a0b

