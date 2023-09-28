Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676937B13E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjI1HIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjI1HHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82F1A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll77-0002OG-2d; Thu, 28 Sep 2023 09:07:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-009WBM-LJ; Thu, 28 Sep 2023 09:07:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-005ZWw-Bp; Thu, 28 Sep 2023 09:07:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/23] gpio: altera: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:44 +0200
Message-Id: <20230928070706.2290137-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=movoJjxQGZhdEpgxeET/qoYXLgHYq3xl1yWlhPlVaxA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRfsfQe8UNLM96ju5YikzLyrTwfSWJGH9BpG gLuYVJNbUWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkXwAKCRCPgPtYfRL+ TjMzB/9FzKkndhb2OKR9Cj0r+JiewFdwFzc7z8IBbKvN6fDWG3gLCpOrIOWyxBatr9+TcLNmq7j mo1kDYs7JLymGovUd4VcK++ImsZ7qguUArtD2qF2dcmHAGM8IbTN0vscbllr0tFed9uQuWfYMRY yV7t4XStCPUTYfnbOKamM2wGp6+xeCHuziRURSoxqpwMBpdFcquBi8zL1Gv04D2gYntEt0Klxix 2Ds73wlW82DU0u8XHbPLyoLOzhdciaN7Yzpn52bC2gaiYV24FZCC+F6AcusccIvWLzXM900Pqhy BkSHMT81As2tCrR3tebgGVCNbHwa9PNag0QtQ6zpyPIsT09O
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
 drivers/gpio/gpio-altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 54d7c450c596..c2edfbb231fc 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -317,13 +317,11 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int altera_gpio_remove(struct platform_device *pdev)
+static void altera_gpio_remove(struct platform_device *pdev)
 {
 	struct altera_gpio_chip *altera_gc = platform_get_drvdata(pdev);
 
 	of_mm_gpiochip_remove(&altera_gc->mmchip);
-
-	return 0;
 }
 
 static const struct of_device_id altera_gpio_of_match[] = {
@@ -338,7 +336,7 @@ static struct platform_driver altera_gpio_driver = {
 		.of_match_table = altera_gpio_of_match,
 	},
 	.probe		= altera_gpio_probe,
-	.remove		= altera_gpio_remove,
+	.remove_new	= altera_gpio_remove,
 };
 
 static int __init altera_gpio_init(void)
-- 
2.40.1

