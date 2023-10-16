Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F37CAE94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjJPQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjJPQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:10:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE46FF;
        Mon, 16 Oct 2023 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472632; x=1729008632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCalplfZS+ACuqT2hqG7Ibb2XR+tCJlozM7ZHTv3bHw=;
  b=JhGn1LyfunZ/wca0dwSmDDen57X1DmjedFlLs7cOs/Gd+MFh0QZnjGXO
   D+wvGqdNr6FHpCGj8w2d8Yh4B2pERtWdxPMwRRZU0lv4dbMdCXu36T7jc
   YJacfUCM7xLYuDFo++im30hfm4umwxA8AK+Qd75tul90Hhel5eZt51Xzg
   C1piMhyBQxpk9I6JsZVmVYlT7jQiJoh7d1DA+AOohiNmbKetWIwe/hfdn
   xp3Ge7XRZk4U/3PV2nDt0927Syz/vsodZ7tTzMNu1PugEUQ8DBVEN5l9K
   G06srvU/FjFHyLHTkQN4+JX63JuQyfCmxFzcRSh/ShIEaFBkhd6q1a3AC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7132787"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7132787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785123040"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785123040"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 09:10:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36C5995B; Mon, 16 Oct 2023 19:10:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 5/6] leds: gpio: Remove unneeded assignment
Date:   Mon, 16 Oct 2023 19:10:04 +0300
Message-Id: <20231016161005.1471768-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
References: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial ret is not used anywhere, drop the unneeded assignment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index fd3f90f95fa2..d6e8298ffb3e 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -255,7 +255,7 @@ static int gpio_led_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_led_platform_data *pdata = dev_get_platdata(dev);
 	struct gpio_leds_priv *priv;
-	int i, ret = 0;
+	int i, ret;
 
 	if (pdata && pdata->num_leds) {
 		priv = devm_kzalloc(dev, struct_size(priv, leds, pdata->num_leds), GFP_KERNEL);
-- 
2.40.0.1.gaa8946217a0b

