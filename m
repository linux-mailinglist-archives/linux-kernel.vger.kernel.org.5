Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6127E7B13CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjI1HH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjI1HHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF4CC0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-0002QC-1t; Thu, 28 Sep 2023 09:07:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-009WC2-LF; Thu, 28 Sep 2023 09:07:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-005ZXd-Bn; Thu, 28 Sep 2023 09:07:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/23] gpio: mpc5200: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:55 +0200
Message-Id: <20230928070706.2290137-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zmgUfSKQdCVTn8R3yT+ExDBT2pKzswgrwKMQchT/9+w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSRsPE9N9aetn2FJ2he52w0YP2cqBNLx7tI5j 5dsuyqX92yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkbAAKCRCPgPtYfRL+ ToZMB/9yLWW6JUJdo8x9wXhN+yAwH4sgUpCYI99iJix+SieoJshz3IKPq0lUDSwGymVONezHNHZ yLV1+XifKo5VFx1JGRQ6z315BMWhRI1Amj11CoGZhPE1PdTtVQ3oQn7jed/CQ+J0tsPw+W0DjWq dHDpNgaZ5EO+rHczvHfKSejNzbSunkSZoDvfyU+y6kME4xdW0j/ociKE5NHYPMqfVSYFlXXXDav cZulsr8eNlNF4nWkRO/+0OgyU5zuDZ8uJXjnDozfZaA3JdjKPOrmputEDrT1N+eyUFS8RcBTGOo 9GDpjZBa/OfKPGStK+Tg/ajV0D+WEzj3N7PigCRDeWk6lErm
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
 drivers/gpio/gpio-mpc5200.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index b49e3ca64015..a199dce3394a 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -165,13 +165,11 @@ static int mpc52xx_wkup_gpiochip_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static int mpc52xx_gpiochip_remove(struct platform_device *ofdev)
+static void mpc52xx_gpiochip_remove(struct platform_device *ofdev)
 {
 	struct mpc52xx_gpiochip *chip = platform_get_drvdata(ofdev);
 
 	of_mm_gpiochip_remove(&chip->mmchip);
-
-	return 0;
 }
 
 static const struct of_device_id mpc52xx_wkup_gpiochip_match[] = {
@@ -185,7 +183,7 @@ static struct platform_driver mpc52xx_wkup_gpiochip_driver = {
 		.of_match_table = mpc52xx_wkup_gpiochip_match,
 	},
 	.probe = mpc52xx_wkup_gpiochip_probe,
-	.remove = mpc52xx_gpiochip_remove,
+	.remove_new = mpc52xx_gpiochip_remove,
 };
 
 /*
@@ -338,7 +336,7 @@ static struct platform_driver mpc52xx_simple_gpiochip_driver = {
 		.of_match_table = mpc52xx_simple_gpiochip_match,
 	},
 	.probe = mpc52xx_simple_gpiochip_probe,
-	.remove = mpc52xx_gpiochip_remove,
+	.remove_new = mpc52xx_gpiochip_remove,
 };
 
 static struct platform_driver * const drivers[] = {
-- 
2.40.1

