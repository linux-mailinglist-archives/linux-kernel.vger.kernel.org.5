Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301817BD6AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbjJIJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjJIJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CFF97
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-0006td-KC; Mon, 09 Oct 2023 11:22:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-000NWw-7o; Mon, 09 Oct 2023 11:22:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-00C4pP-Uy; Mon, 09 Oct 2023 11:22:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] pinctrl: as3722: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:46 +0200
Message-Id: <20231009083856.222030-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MPWtYbMOQgZR7mlnb/mgL+Kp5Cn22AjikhRP10lPHcU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wKE74xmYD8QqeyqKDdAd0aRFg6ar601wE4U 3O0gprgCImJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8CgAKCRCPgPtYfRL+ TigkB/0ezfjZNnv82AK92u26hpU28QyX4rIKqnS5KQojWwblAi+52ppN5+EMlbRRrFGYY5wSBn4 TnVuCrRpr6YUxKBV7pz7p490x5ndIbSoG2wc3Y0AXYrp9XbqC4bqPLq4mQ+9jfG3MKEC25+WbyF /N4Q5VRsfG5fuV5jlzoXjNzTr97EzrLIVmpy8UTVLLBHJl9lz1SpLYObXzJPtPwtcrBAg5KLuWn hIb4IhnvbcAahYVYJOl+49L09sxhggWJFA1jqK1ZQCSJN46A4o0WbeL0RKpHJ2srBnCTvjJZuvO tM6KKRWDc4dB+lNZ28YbuKUFaS09UNJJsveOHajkwX6taoPs
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
 drivers/pinctrl/pinctrl-as3722.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index f0e5d87ac50b..84b47a6cc3a6 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -587,12 +587,11 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int as3722_pinctrl_remove(struct platform_device *pdev)
+static void as3722_pinctrl_remove(struct platform_device *pdev)
 {
 	struct as3722_pctrl_info *as_pci = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&as_pci->gpio_chip);
-	return 0;
 }
 
 static const struct of_device_id as3722_pinctrl_of_match[] = {
@@ -607,7 +606,7 @@ static struct platform_driver as3722_pinctrl_driver = {
 		.of_match_table = as3722_pinctrl_of_match,
 	},
 	.probe = as3722_pinctrl_probe,
-	.remove = as3722_pinctrl_remove,
+	.remove_new = as3722_pinctrl_remove,
 };
 module_platform_driver(as3722_pinctrl_driver);
 
-- 
2.40.1

