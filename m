Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC737B13F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjI1HIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjI1HH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B861B5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7B-0002SH-4M; Thu, 28 Sep 2023 09:07:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-009WCi-Mf; Thu, 28 Sep 2023 09:07:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll7A-005ZYI-DN; Thu, 28 Sep 2023 09:07:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/23] gpio: xilinx: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:07:05 +0200
Message-Id: <20230928070706.2290137-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OCUSDDDlpZowRKqn3i2KYETfeDiSoQ+fcaqhgCGW9E4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSR3juZR4QyyPw/qwux7zvp19nI7Skn/j7o6l tjat0CcGDyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUkdwAKCRCPgPtYfRL+ TnvSCACTk10j0dDCUwbMK8QsXCHKp6qMtMBfB69H00zn5h7bKfGDtOapxGbJmv0Vn9Prjfu+7Ua a6nKdghGiNXaYoeXGsL9g/fJVk4oWOnhXJ50bd3Hy+vNaCYRn/5WhvoXcajvyxLEjlQONXcddF/ YrMo75AayD4Bi0GED4bj4At8pU0UYawkjPjF63IgENPmHrYXvmFIoPn+WmU7hPO1i6IMbtoWRix DSdLPtF59wHjXS+7j1o9vYadzthGsZ0Q2rqhcxz3+f59FaPAnM2mqv3HMEUtTKPPLOPZXP6eHOu lEi0VbqeosVGRbsPmWgGUwBVP04FqZCUGjQSzCqtcVesEBpt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/gpio/gpio-xilinx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index a16945e8319e..823198368250 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -332,7 +332,7 @@ static int __maybe_unused xgpio_suspend(struct device *dev)
  *
  * Return: 0 always
  */
-static int xgpio_remove(struct platform_device *pdev)
+static void xgpio_remove(struct platform_device *pdev)
 {
 	struct xgpio_instance *gpio = platform_get_drvdata(pdev);
 
@@ -340,8 +340,6 @@ static int xgpio_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(gpio->clk);
-
-	return 0;
 }
 
 /**
@@ -715,7 +713,7 @@ MODULE_DEVICE_TABLE(of, xgpio_of_match);
 
 static struct platform_driver xgpio_plat_driver = {
 	.probe		= xgpio_probe,
-	.remove		= xgpio_remove,
+	.remove_new	= xgpio_remove,
 	.driver		= {
 			.name = "gpio-xilinx",
 			.of_match_table	= xgpio_of_match,
-- 
2.40.1

