Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF17B13F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjI1HIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjI1HH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E41B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7B-0002SM-8i; Thu, 28 Sep 2023 09:07:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-009WCl-Rv; Thu, 28 Sep 2023 09:07:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-005ZYM-Ih; Thu, 28 Sep 2023 09:07:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/23] gpio: zynq: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:06 +0200
Message-Id: <20230928070706.2290137-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=96k0kAmXLbqfVn+TrjpQXRYXe0bAG/EB7eGn8jOevJ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSR4vNTmHvbNJyAE3nH8cjTQVbb/2RGswimTr 0m+7AOa+0qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkeAAKCRCPgPtYfRL+ TvERB/9pENxPs7T+w2jw8MK2hBTIIJ5XfvoU/aqUYTUhDWsLBp/YIPkysQMnczpOCEMt7acRljX /BvcajQuvhsIDyPM82Ig7qC37kwr4cKk0E8BcEHGKYPrk4BnRVgoJpi8olM7A3eDE51tvDNsMOE VWVt2W1XHlXzkdQst3NXxkZ7XozMFh3OQFpAT3LeEFnkJQHGOrybr7vbCa5AEhq3wi7tZngpTQk MUjZNt1F0SVaB6APLwVf0RxI5yknWFEKOk9jZvDd0XAAiKqZUCBg3e94BZX7KPetDKmLhDgP3d8 pxbnrV3jLIEm18kFQbyDOUkvPx0MlXecw9ngkVkKkYPRaw6K
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
 drivers/gpio/gpio-zynq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 324e942c0650..466e23031afc 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -1010,7 +1010,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
  *
  * Return: 0 always
  */
-static int zynq_gpio_remove(struct platform_device *pdev)
+static void zynq_gpio_remove(struct platform_device *pdev)
 {
 	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
 	int ret;
@@ -1022,7 +1022,6 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	clk_disable_unprepare(gpio->clk);
 	device_set_wakeup_capable(&pdev->dev, 0);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static struct platform_driver zynq_gpio_driver = {
@@ -1032,7 +1031,7 @@ static struct platform_driver zynq_gpio_driver = {
 		.of_match_table = zynq_gpio_of_match,
 	},
 	.probe = zynq_gpio_probe,
-	.remove = zynq_gpio_remove,
+	.remove_new = zynq_gpio_remove,
 };
 
 module_platform_driver(zynq_gpio_driver);
-- 
2.40.1

