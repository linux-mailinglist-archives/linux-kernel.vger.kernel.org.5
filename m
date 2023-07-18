Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F292C758874
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGRWa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGRWaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:30:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212B198E;
        Tue, 18 Jul 2023 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689719455; x=1721255455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BiJCmzJbE53V+dnM+etuGHTrRreB4VKMv2OXfSndhuA=;
  b=Waqpc+PnWO1j6itIkPLhxpul5Ae0A5Cz/J+w6f69iHxbhtepPyohnyOL
   feVq0WMFxMekFGrPQojwGHfS19othXb5qAgs9HnYP72zai4aVTfZw+mWR
   lm+rZr/P22D0pmoNhY2xoYAqe2DcLKQe3U32dC3augctAlanVL6UXrnZh
   WRAVHoMWe084l+oXznjCKQUyscJSxqeVwrUANa02dvJNYgyEpYoU5ajdy
   XC/0lxUK7EnNTuVv3y4GLrLmB9AD3TUhPICbkJPtPAnohJfnrZxXTg2w9
   5BRBqHCun2q56FM2jrF5aX7c86cW86SyLyUpN2S9yBFdYAUM8KQ+K0Cw4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366369825"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="366369825"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 15:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793791444"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="793791444"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 15:30:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06A601A5; Wed, 19 Jul 2023 01:30:58 +0300 (EEST)
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
Subject: [PATCH v3 3/3] gpio: bcm-kona: Drop unused pdev member in private data structure
Date:   Wed, 19 Jul 2023 01:30:55 +0300
Message-Id: <20230718223055.2809-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230718223055.2809-1-andriy.shevchenko@linux.intel.com>
References: <20230718223055.2809-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pdev member is assigned and not used, drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
v3: no changes
 drivers/gpio/gpio-bcm-kona.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index f67c0f76a196..5321ef98f442 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -64,7 +64,6 @@ struct bcm_kona_gpio {
 	struct gpio_chip gpio_chip;
 	struct irq_domain *irq_domain;
 	struct bcm_kona_gpio_bank *banks;
-	struct platform_device *pdev;
 };
 
 struct bcm_kona_gpio_bank {
@@ -591,7 +590,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 	if (!kona_gpio->banks)
 		return -ENOMEM;
 
-	kona_gpio->pdev = pdev;
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
-- 
2.40.0.1.gaa8946217a0b

