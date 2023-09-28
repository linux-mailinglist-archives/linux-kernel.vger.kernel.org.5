Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392E57B13DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjI1HIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjI1HHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C4CCD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-0002R4-SP; Thu, 28 Sep 2023 09:07:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-009WCM-FW; Thu, 28 Sep 2023 09:07:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-005ZXx-6S; Thu, 28 Sep 2023 09:07:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/23] gpio: tb10x: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:00 +0200
Message-Id: <20230928070706.2290137-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=52/8sMpkLnXCJmkoyAgbmBwgoxxupHjoRdYeDAnq7oA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRy4K9Ba9AEx+FrTZPsUfwm4VMZgfhNmqnB+ 0jVi/Uew2iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkcgAKCRCPgPtYfRL+ Tj9BCACFsyugK4kPlLC6+uCxN5Sxud39t4cTpR7ANtPlVe0az6A4UDLIDwDCEpskhhqkMS0vVwO ui/NFi4UfVbdYYNDOAK39Lcc6YsjzbDMfnWuMASLCDEW9GY6+jfMTaMqZdY1E3zTJAqzmx2Sw58 c2V5rbv/TsypRNCHVsOoBT0MZ6u2c2aRCZdNQ0zQqqctuSc0Nw3SYbH+B8cW2oGIBz9Y7TBQhyf 2g55bMdfuYB4bq6RUxqt2u9JING3IheS5YcLx18+Z2dsjTXq+wH9Gq4KzzXHtXyVNHcalWh7KHM VSAQZ55vSqDMyJIggNLChJV6tLF2TbMUH45IgBsVeTgBVpTq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-tb10x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index f96d260a4a19..e8c1485b9c73 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -215,7 +215,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tb10x_gpio_remove(struct platform_device *pdev)
+static void tb10x_gpio_remove(struct platform_device *pdev)
 {
 	struct tb10x_gpio *tb10x_gpio = platform_get_drvdata(pdev);
 
@@ -225,8 +225,6 @@ static int tb10x_gpio_remove(struct platform_device *pdev)
 		kfree(tb10x_gpio->domain->gc);
 		irq_domain_remove(tb10x_gpio->domain);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id tb10x_gpio_dt_ids[] = {
@@ -237,7 +235,7 @@ MODULE_DEVICE_TABLE(of, tb10x_gpio_dt_ids);
 
 static struct platform_driver tb10x_gpio_driver = {
 	.probe		= tb10x_gpio_probe,
-	.remove		= tb10x_gpio_remove,
+	.remove_new	= tb10x_gpio_remove,
 	.driver = {
 		.name	= "tb10x-gpio",
 		.of_match_table = tb10x_gpio_dt_ids,
-- 
2.40.1

