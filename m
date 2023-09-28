Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572EE7B13C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjI1HHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjI1HHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BF1B5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-0002P7-VU; Thu, 28 Sep 2023 09:07:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-009WBe-IX; Thu, 28 Sep 2023 09:07:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-005ZXF-9M; Thu, 28 Sep 2023 09:07:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/23] gpio: ftgpio010: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:49 +0200
Message-Id: <20230928070706.2290137-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=l45A4QRi1f0y2FEP2IUoyR7fsQQnLWR2bOHoquRkF04=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRlaO92/QIUiLLMq9THmGFZLYQRcRkTVcpNb lUZrMHWXJqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkZQAKCRCPgPtYfRL+ TohVB/9NkW6LhKL0SbUO0m8ugQc7XQh+ipkYLG9n57q7CkOOh/ur3tH2nqMLiZm++b+l3n/WyQZ +uZdivrDmS3sBZ8HloBT49RCI2YGun98Jfv0BuY/eGohrhzZM+QDkBceYqLBMqpNJz2DNU2BSqc tNqpOvfvP4IAVCaswIXoXaY5NHgA19ZnCN9NeTym59xZluVSNfW4ras9iqYyZMPkEsAYt2SVZfu Asb1KoyOL+kUK2uYPi1R7SUiZerxN+fAvIOO81HotEkNJcXUonIt6lANDGZgMmW5kUchwkT+pbu qIVjsG+30yD2FOkh1TLFDqMA/SVE9g+mLntlDQ19GblpdaE8
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
 drivers/gpio/gpio-ftgpio010.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 5ce59dcf02e3..97d345b59352 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -324,13 +324,11 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ftgpio_gpio_remove(struct platform_device *pdev)
+static void ftgpio_gpio_remove(struct platform_device *pdev)
 {
 	struct ftgpio_gpio *g = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(g->clk);
-
-	return 0;
 }
 
 static const struct of_device_id ftgpio_gpio_of_match[] = {
@@ -352,6 +350,6 @@ static struct platform_driver ftgpio_gpio_driver = {
 		.of_match_table = ftgpio_gpio_of_match,
 	},
 	.probe = ftgpio_gpio_probe,
-	.remove = ftgpio_gpio_remove,
+	.remove_new = ftgpio_gpio_remove,
 };
 builtin_platform_driver(ftgpio_gpio_driver);
-- 
2.40.1

