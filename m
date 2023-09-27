Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A637AFDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjI0ILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjI0IK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:10:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4B1B0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-0007vd-6k; Wed, 27 Sep 2023 10:10:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-009I70-Q2; Wed, 27 Sep 2023 10:10:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-005BQH-Gr; Wed, 27 Sep 2023 10:10:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/27] platform/chrome: cros_ec_lpc: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:17 +0200
Message-Id: <20230927081040.2198742-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UaQf0aOVJXiwdHwFWYo4P0yhmaqn5f73vpG9iCiRQPg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+Nh8vWZtz/iFdllV5+D+P+cfjaMU6C4DQ7d0 /+1D3PLh0SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjYQAKCRCPgPtYfRL+ Tp3FB/9lOQ/A452SjdzNZdgRv/RkGyVoKEua5t6iB3pV5YLNbs3o2QgaowqnxYbDooMVrzKIIOC ENs6k+iT0W+SnomZwuyUsry1H63YYawHFMk3OIgS/yJZRdyA3xaoOlqauVsYCqFYTFPgbqvH+Nw JY8zcKh6+bA6qQVBOWOyzXdSUf9+CCaWZn/xWS4XgseRDpKY5ZC7rdO2/CHUWip619zYnjGxbEL qwUuEAKtcQtvim/fRwpkazLjcI3WvTN2UgboVMcdMELLI2BTY5UiEPGRTf6xjDe04OvB91G+JF6 hDbptCQ6gTQTafv427EjajEyQZzOLqw5PCmZ95Cv9zODuDdi
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
 drivers/platform/chrome/cros_ec_lpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 356572452898..897090f0f26e 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -460,7 +460,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int cros_ec_lpc_remove(struct platform_device *pdev)
+static void cros_ec_lpc_remove(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec_dev = platform_get_drvdata(pdev);
 	struct acpi_device *adev;
@@ -471,8 +471,6 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 					   cros_ec_lpc_acpi_notify);
 
 	cros_ec_unregister(ec_dev);
-
-	return 0;
 }
 
 static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
@@ -580,7 +578,7 @@ static struct platform_driver cros_ec_lpc_driver = {
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 	.probe = cros_ec_lpc_probe,
-	.remove = cros_ec_lpc_remove,
+	.remove_new = cros_ec_lpc_remove,
 };
 
 static struct platform_device cros_ec_lpc_device = {
-- 
2.40.1

