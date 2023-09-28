Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494357B13B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjI1HHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjI1HHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744C1B4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-0002PF-4w; Thu, 28 Sep 2023 09:07:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-009WBh-O2; Thu, 28 Sep 2023 09:07:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-005ZXJ-Eq; Thu, 28 Sep 2023 09:07:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/23] gpio: grgpio: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:50 +0200
Message-Id: <20230928070706.2290137-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CBRa5uc4jxkn5sVY8frORfw+bQVQ0W6ZrDl2ytRwOVw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRmrR74n8YeidQDHng8LSxFjhMKe5ULUsUQf I8LtTIQNkuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkZgAKCRCPgPtYfRL+ Tg8OB/9Qmd8kmBwuNsJEQXn/z5BtpNMLdsh9EGEmxP7/6REtWKdCuqTOYdzJt9tQKw6jand0WJh //zdsKChP3Xca/hv5CgORW2ACPrAZKhb7o0pOB6aVtakBCxuEtpwIs1PnAQ/2kI0Lk+rfakzy3a 6mAZf+x8e3UZJdXjzRwkhJFRFIcF0sA9mjyYut2RcBYMe3VbDcqKWys8R4UcwsuySUXb+HBNglM oZ3qM2vANqw9wqNHDxkFPXJ499LSt8i9VlNkAIXFcdJ7liuCg/W+h0Ng9Y6GHX/LTyPcEwVzmld 7MTAzYJ8T855BORoU9K+SVr4Oc+dFuPwtK+L3YVMzzaTI+C+
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
 drivers/gpio/gpio-grgpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 0163c95f6dd7..017c7170eb57 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -431,7 +431,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static int grgpio_remove(struct platform_device *ofdev)
+static void grgpio_remove(struct platform_device *ofdev)
 {
 	struct grgpio_priv *priv = platform_get_drvdata(ofdev);
 
@@ -439,8 +439,6 @@ static int grgpio_remove(struct platform_device *ofdev)
 
 	if (priv->domain)
 		irq_domain_remove(priv->domain);
-
-	return 0;
 }
 
 static const struct of_device_id grgpio_match[] = {
@@ -457,7 +455,7 @@ static struct platform_driver grgpio_driver = {
 		.of_match_table = grgpio_match,
 	},
 	.probe = grgpio_probe,
-	.remove = grgpio_remove,
+	.remove_new = grgpio_remove,
 };
 module_platform_driver(grgpio_driver);
 
-- 
2.40.1

