Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0994A7B13C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjI1HHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjI1HHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427C1BD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-0002Q0-T7; Thu, 28 Sep 2023 09:07:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-009WBy-Fc; Thu, 28 Sep 2023 09:07:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-005ZXZ-6b; Thu, 28 Sep 2023 09:07:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/23] gpio: mm-lantiq: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:54 +0200
Message-Id: <20230928070706.2290137-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=n5tiuRCZj+BI4ArBL1amsTPNue/ACzoBE2dS/KHIXLs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRrWhba52Fylm7LFemgwnPLaJRVq+zUqKPqv OWYJQCLyxCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkawAKCRCPgPtYfRL+ TpCWB/9iGudW5Pk35ZktG7pTbbs8Uohfe6WU7C2v7LbHdrnJFYoyEx/B8EtE3xt2ZzFmXC/mRZN 8bNtV2KaTSAVDQYbWp2vzW708oSn9H285Mjh3rRS5OtP2oaX1TbGZZKg7cCpXTyIbiG1xbVboVc 3lhREAsWNG+5cmVK8+MHhXPTpVZ+2M0V9VYICvyGJGjXGtS4HRcVTWQX+LpDRODXn51oxiTDaB5 ggcCmP88teX0WcTozvX0PIkw+BW6VM7nB3AhMycLcaX3t8qzzNxhLtjvMv5RZ50kSoF/pxkT21X ZcPaHnQSxIlLesCQ0kJsp0NMUBG/KOfVqQbtW5NhPCEeTVyW
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
 drivers/gpio/gpio-mm-lantiq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index f3c158259636..e855c68c981b 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -121,13 +121,11 @@ static int ltq_mm_probe(struct platform_device *pdev)
 	return of_mm_gpiochip_add_data(pdev->dev.of_node, &chip->mmchip, chip);
 }
 
-static int ltq_mm_remove(struct platform_device *pdev)
+static void ltq_mm_remove(struct platform_device *pdev)
 {
 	struct ltq_mm *chip = platform_get_drvdata(pdev);
 
 	of_mm_gpiochip_remove(&chip->mmchip);
-
-	return 0;
 }
 
 static const struct of_device_id ltq_mm_match[] = {
@@ -138,7 +136,7 @@ MODULE_DEVICE_TABLE(of, ltq_mm_match);
 
 static struct platform_driver ltq_mm_driver = {
 	.probe = ltq_mm_probe,
-	.remove = ltq_mm_remove,
+	.remove_new = ltq_mm_remove,
 	.driver = {
 		.name = "gpio-mm-ltq",
 		.of_match_table = ltq_mm_match,
-- 
2.40.1

