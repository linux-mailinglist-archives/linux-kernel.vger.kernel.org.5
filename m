Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3485E7BD6C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbjJIJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbjJIJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C940F2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-0006sq-ML; Mon, 09 Oct 2023 11:22:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-000NWd-8p; Mon, 09 Oct 2023 11:22:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-00C4p9-Vt; Mon, 09 Oct 2023 11:22:34 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] pinctrl: intel: lynxpoint: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:42 +0200
Message-Id: <20231009083856.222030-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fsWrpmMKU/rWYOktZJIIlG/sX3wfJlY9nv6zFWW4epw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wFI8hfY+1w3twniM/3CdxJLG0rAcTAt0xJF 0qOyf/xxIyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8BQAKCRCPgPtYfRL+ TghlCACZDDI0PkhZyjCfCHJ0oqnMoOlO09LfV3fC5w9nMJGRtsyksabDJwhBx983q4n/99/S8xK ywSo9xqhRmu7U1TVeL2sySStoniBDvRChCr4b0dXEEEoqIS+oxraQSqvL7fOTm3Y1unpnZlLnkV VVWCFZTUI1Zq1wtfwctxP4o6Kbsi6hrp/2cydsHJ2VP7Z7LEhJkhHjpAuvpi3rbeI93fn8kwtKW AkPmk7TGjz9odn1RnyYK7X4DTdQUZkyF7PEwhxyUprZj9g2uCU0ZTUrUQhMxKaYVPt5znxy1HVo pUcfO8/APURWonW/z7OfVzxfbdcYq/LQGRlMiqSgxkymvVoc
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
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index c3732a9f0658..f0725edcab3b 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -846,10 +846,9 @@ static int lp_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lp_gpio_remove(struct platform_device *pdev)
+static void lp_gpio_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int lp_gpio_runtime_suspend(struct device *dev)
@@ -890,7 +889,7 @@ MODULE_DEVICE_TABLE(acpi, lynxpoint_gpio_acpi_match);
 
 static struct platform_driver lp_gpio_driver = {
 	.probe          = lp_gpio_probe,
-	.remove         = lp_gpio_remove,
+	.remove_new     = lp_gpio_remove,
 	.driver         = {
 		.name   = "lp_gpio",
 		.pm	= pm_ptr(&lp_gpio_pm_ops),
-- 
2.40.1

