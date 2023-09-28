Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753CF7B13F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjI1HIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjI1HH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE281B4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-0002RU-9D; Thu, 28 Sep 2023 09:07:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-009WCV-Rf; Thu, 28 Sep 2023 09:07:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll79-005ZY5-IM; Thu, 28 Sep 2023 09:07:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/23] gpio: uniphier: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:02 +0200
Message-Id: <20230928070706.2290137-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bkApXA01tGfNfpgysiyQC1mURMZijlgXCXcOlH9/CzU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSR01UED8lLvKL6iw0a22cHMHwxZe73TV5XEy qPw1w8wUVGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkdAAKCRCPgPtYfRL+ TjaUB/oDdhtr2klL8tb2/jjDA3Phmu8XHMX0ezozOjCI3s+9jWvfkcwPhUwYfhKNwP2AIpgOpgl 9mryeO06YcomQz75MNGhiJiuRvwwZRysefF1qIWxxQagBKmsMqnlvRS71vfZvrqfko4NJeh3mJI jkSLhF+l4L/Nhdzqy5i1pv3aWi43CRXrwi5aS3d9F5EdagiEruSHHA73y0pM1HVjlNd9StccwII 77pCaJ2HmlwiZkrsAqjB2oaY9MiRNdApl+vLlB6PHX6YX5v7pV7RAHBekHtjAV8tqgXXbDOhuRW BzbehJClDmrpiRJQGK7BtJK6hwV2YB89aVMHgGV781FS9h6Q
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
 drivers/gpio/gpio-uniphier.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 9725b7aa18a7..1f440707f8f4 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -414,13 +414,11 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int uniphier_gpio_remove(struct platform_device *pdev)
+static void uniphier_gpio_remove(struct platform_device *pdev)
 {
 	struct uniphier_gpio_priv *priv = platform_get_drvdata(pdev);
 
 	irq_domain_remove(priv->domain);
-
-	return 0;
 }
 
 static int __maybe_unused uniphier_gpio_suspend(struct device *dev)
@@ -482,7 +480,7 @@ MODULE_DEVICE_TABLE(of, uniphier_gpio_match);
 
 static struct platform_driver uniphier_gpio_driver = {
 	.probe = uniphier_gpio_probe,
-	.remove = uniphier_gpio_remove,
+	.remove_new = uniphier_gpio_remove,
 	.driver = {
 		.name = "uniphier-gpio",
 		.of_match_table = uniphier_gpio_match,
-- 
2.40.1

