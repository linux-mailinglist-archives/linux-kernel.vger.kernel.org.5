Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828367AD4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjIYJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjIYJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F88CF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-0007m4-Cv; Mon, 25 Sep 2023 11:55:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJT-008pye-W7; Mon, 25 Sep 2023 11:55:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJT-004dkQ-My; Mon, 25 Sep 2023 11:55:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 01/40] soc/aspeed: aspeed-lpc-ctrl: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:54:52 +0200
Message-Id: <20230925095532.1984344-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=T10onqHn9x5uUIg8BoRhKK1riwY5cUpQ2GEK0NPd3eU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhBGcn3H1WzwJha96bFOmLylL/5ZWUmdaf+6 I2kmTRasseJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYQQAKCRCPgPtYfRL+ ToJXB/oDQK1c2RVaj3HT1cFLqS0t5Kj2Z4VO1+1stBxATVkTrh6M5YnZnCd5X/oBGqZs4sEphpl 2qN2hiWYtlB6QsVkZph+lRVoYde9LJPTabvgU7DVh53UJ9fsgB17OzTx8QDiAEbjY9wb39AzvcH pIsyBU5Bzc2ueb8GILG8TOXMys5h1xMwnXUItIDFyDjCxWv4m7Jx0HVmlrVndL1l7b7LFzGr3IA 2FDDbEU85VC5GwjuTEqj1EKtN4zdSoVF9ZIe+/5nV3720fM5fomOwB0GLiAN7giPAtGPbADbCxn up/TSd62i75ftljnxjNYZrdiZubkMV9A+rLSx30ht7XOr5QR
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 258894ed234b..e87038009d1b 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -332,14 +332,12 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int aspeed_lpc_ctrl_remove(struct platform_device *pdev)
+static void aspeed_lpc_ctrl_remove(struct platform_device *pdev)
 {
 	struct aspeed_lpc_ctrl *lpc_ctrl = dev_get_drvdata(&pdev->dev);
 
 	misc_deregister(&lpc_ctrl->miscdev);
 	clk_disable_unprepare(lpc_ctrl->clk);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_lpc_ctrl_match[] = {
@@ -355,7 +353,7 @@ static struct platform_driver aspeed_lpc_ctrl_driver = {
 		.of_match_table = aspeed_lpc_ctrl_match,
 	},
 	.probe = aspeed_lpc_ctrl_probe,
-	.remove = aspeed_lpc_ctrl_remove,
+	.remove_new = aspeed_lpc_ctrl_remove,
 };
 
 module_platform_driver(aspeed_lpc_ctrl_driver);
-- 
2.40.1

