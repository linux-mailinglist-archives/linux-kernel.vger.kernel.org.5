Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EE7B13EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjI1HIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjI1HHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4578121
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-0002Qw-Nj; Thu, 28 Sep 2023 09:07:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-009WCJ-AP; Thu, 28 Sep 2023 09:07:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-005ZXt-1D; Thu, 28 Sep 2023 09:07:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/23] gpio: rockchip: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:59 +0200
Message-Id: <20230928070706.2290137-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/JLr4SMPsCZBTD/SLWvssmlD+6BeWoxGgRK3cfWhYFs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRwp8TO2fD5SYns9E6Kt3lGHfikwBVk3nEgE c2ujARGr8eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkcAAKCRCPgPtYfRL+ ThCBB/9GGMGnIv3R0ikL7rxHVHWdlAQxJ093w/Cjj1PDwYrmn6YN8qn1j/kbyX/QoErQm676zv3 YFk4SoO+F6cD3xDM0LDXo/cAvspHBGOg1wIEOtTNjvLEYjST/UfVkFTR6w6tZWylGPOO+bh6/f6 Q64M8I0lBnwv/z+z6jdhSVZNFki+iVgXiuJijg2r02fR6Mz0KZTvqqQA175SKaas9uRdgBmvx1u Xyxx75rLm6avnZ2iZASmP44wpOSE/BWNO+qG/e17AzZ3CbjLxGxepXYxV1BIEBQHwh0ueMYdAAT OW34nOZ8ZkuzJS1WYJT3iDR9mEUvoi/KxwOZnQTCzvusgZ2k
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
 drivers/gpio/gpio-rockchip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index b35b9604413f..23040a8cea34 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -778,14 +778,12 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rockchip_gpio_remove(struct platform_device *pdev)
+static void rockchip_gpio_remove(struct platform_device *pdev)
 {
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(bank->clk);
 	gpiochip_remove(&bank->gpio_chip);
-
-	return 0;
 }
 
 static const struct of_device_id rockchip_gpio_match[] = {
@@ -796,7 +794,7 @@ static const struct of_device_id rockchip_gpio_match[] = {
 
 static struct platform_driver rockchip_gpio_driver = {
 	.probe		= rockchip_gpio_probe,
-	.remove		= rockchip_gpio_remove,
+	.remove_new	= rockchip_gpio_remove,
 	.driver		= {
 		.name	= "rockchip-gpio",
 		.of_match_table = rockchip_gpio_match,
-- 
2.40.1

