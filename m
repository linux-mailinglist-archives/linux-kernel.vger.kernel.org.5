Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8710F7BD6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbjJIJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbjJIJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73335101
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTG-0006vN-Nr; Mon, 09 Oct 2023 11:22:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTG-000NXW-B7; Mon, 09 Oct 2023 11:22:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTG-00C4pz-21; Mon, 09 Oct 2023 11:22:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] pinctrl: renesas: rzn1: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:55 +0200
Message-Id: <20231009083856.222030-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=whu1K3F7uiPsNXc85/ItXxw8lSWdHF4ifU6FSRE1eb0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wVKp/h4ZmXafNql0+fn8GJ8n3xLvUqunKyn 9hjgl1/LeSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8FQAKCRCPgPtYfRL+ Tno+B/4x6SoP3sqUW0skGY4krgmujz6/rJAcDeQTwBv7ti5toHbjFhYFTeyZWzj7JoS+XzO+pru EtVB6g8xRdV8pO8+t8pgjnNzHsNl8yZazWPyuye9g5D4pmKhH+yPlMBQtX3bua5Mqznb4tcc7nK R9I449F3w0NToI7rCRiNt/eEs1One16x8nDJfjH68YDJA7OsXH5Vi4k9m6tYwQxkpwOl1sGMxdh S/va6B43w9zNhP8dfWM/7q7Rpy9P9FAUfhAo4DYnwm5eMSUdXaKbeRSkiJT+pGtSv5o9PyTZPSY ewklrqHyUZK9oPohr3mtuZFOdwBYbxwipnmeVxla9eKGD+PB
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
 drivers/pinctrl/renesas/pinctrl-rzn1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index 374b9f281324..4b2f107824fe 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -920,13 +920,11 @@ static int rzn1_pinctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rzn1_pinctrl_remove(struct platform_device *pdev)
+static void rzn1_pinctrl_remove(struct platform_device *pdev)
 {
 	struct rzn1_pinctrl *ipctl = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(ipctl->clk);
-
-	return 0;
 }
 
 static const struct of_device_id rzn1_pinctrl_match[] = {
@@ -937,7 +935,7 @@ MODULE_DEVICE_TABLE(of, rzn1_pinctrl_match);
 
 static struct platform_driver rzn1_pinctrl_driver = {
 	.probe	= rzn1_pinctrl_probe,
-	.remove = rzn1_pinctrl_remove,
+	.remove_new = rzn1_pinctrl_remove,
 	.driver	= {
 		.name		= "rzn1-pinctrl",
 		.of_match_table	= rzn1_pinctrl_match,
-- 
2.40.1

