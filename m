Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7734D7E0BF4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377742AbjKCXAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjKCXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:00:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BBD50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:00:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qz398-0001mx-Rt; Sat, 04 Nov 2023 00:00:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qz398-006QIH-B7; Sat, 04 Nov 2023 00:00:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qz398-00Cfjy-2H; Sat, 04 Nov 2023 00:00:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] bus: fsl-mc: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 00:00:03 +0100
Message-ID: <20231103230001.3652259-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
References: <20231103230001.3652259-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TEYSif78AS4Gcw+iCobp41gDoygtpg1QfW8cvK2R0Os=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRXtzs81eCkLfO5zDn5cScn9ojGW/BZXG1EtBx kGqOB1G8q6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUV7cwAKCRCPgPtYfRL+ Tm8qCACyXlWM+clqNXl1Ub+xxojMj87aP7vrdhTCdDrXSr8m8PIUwt7SxATg0SKliLN006s73l7 ZowQ42MfQiu0QvLYRD7Sis3wx7QofW4hePGOyNd0CxqcI8CfUy1NaYbVhPx+pMElVdygkkTZr0s 9yy1zw7uy61FfTJtX++SfCc/MnKwqsYwxkzbovBnuqXevZU+wKGGZcxl4fDjWyJaPNQ77p+24XT /3OK3xdwtvxpqIhCeCCAkfFxDD/fuovjivEXAkX9zF7Q9ABC5IQI46sDr+QQM54tDzosb4MjWlT YgU+KKxtNUKSkbvqB9hRXWD+YMtSNH+lqDWy2J4a16iZajmN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
callback to the void returning variant. As fsl_mc_bus_remove() has the
same type now as fsl_mc_bus_shutdown() and the only thing the latter
does is to call the former, use fsl_mc_bus_remove() directly as
.shutdown() callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 75a8d365ffd4..78b96cd63de9 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1167,7 +1167,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
  * fsl_mc_bus_remove - callback invoked when the root MC bus is being
  * removed
  */
-static int fsl_mc_bus_remove(struct platform_device *pdev)
+static void fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
 	struct fsl_mc_io *mc_io;
@@ -1187,13 +1187,6 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 		       (GCR1_P1_STOP | GCR1_P2_STOP),
 		       mc->fsl_mc_regs + FSL_MC_GCR1);
 	}
-
-	return 0;
-}
-
-static void fsl_mc_bus_shutdown(struct platform_device *pdev)
-{
-	fsl_mc_bus_remove(pdev);
 }
 
 static const struct of_device_id fsl_mc_bus_match_table[] = {
@@ -1217,8 +1210,8 @@ static struct platform_driver fsl_mc_bus_driver = {
 		   .acpi_match_table = fsl_mc_bus_acpi_match_table,
 		   },
 	.probe = fsl_mc_bus_probe,
-	.remove = fsl_mc_bus_remove,
-	.shutdown = fsl_mc_bus_shutdown,
+	.remove_new = fsl_mc_bus_remove,
+	.shutdown = fsl_mc_bus_remove,
 };
 
 static int fsl_mc_bus_notifier(struct notifier_block *nb,
-- 
2.42.0

