Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16A87AFDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjI0ILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjI0ILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0115CC0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-0007wR-W6; Wed, 27 Sep 2023 10:10:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-009I7H-HW; Wed, 27 Sep 2023 10:10:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-005BQY-8S; Wed, 27 Sep 2023 10:10:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 08/27] platform/chrome: cros_usbpd_logger: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:21 +0200
Message-Id: <20230927081040.2198742-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OR3i3JXD2RroVrhEaYXFvH7Zyx63QW9KL3sGpWCOSHI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NmcnjMJd1YF7F9Gmo1cKEwJETNMDNXQ8MpI +/rkZ4CkG2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjZgAKCRCPgPtYfRL+ TsedCACLo1awQfxrjnzfeCY8rAFtLXItTZBOhX68W7MhGBIue8KMiomkwzPEc4QO2EGPuHyBJgc LEP/AZ56sPA9AGaWsxnQcswD0DN2d0rKTQZrMONwkPrnf2ba5avG+mhOLWbVs3FN4aAbx9gj8Sj M7ZbJnExojsGA6df6k1o5sZtaYh1vaOftfre8XIn7A1c2Tw0fv4BzUsrYYpA6Su2qhGNtvZrTi+ zEQ+8DaALtH/U6mOIGuLgjEBNwBVdzanKp9WBp+yamwv2JRQxcg7ZnwYEfIlCHT2TYtg69YwJfE rgkWghOhE7zWiSQg1zZPqW4RspRoLL2GDNfOtf9gFNq5Wciu
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
 drivers/platform/chrome/cros_usbpd_logger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index d16931203d82..f618757f8b32 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -219,14 +219,12 @@ static int cros_usbpd_logger_probe(struct platform_device *pd)
 	return 0;
 }
 
-static int cros_usbpd_logger_remove(struct platform_device *pd)
+static void cros_usbpd_logger_remove(struct platform_device *pd)
 {
 	struct logger_data *logger = platform_get_drvdata(pd);
 
 	cancel_delayed_work_sync(&logger->log_work);
 	destroy_workqueue(logger->log_workqueue);
-
-	return 0;
 }
 
 static int __maybe_unused cros_usbpd_logger_resume(struct device *dev)
@@ -257,7 +255,7 @@ static struct platform_driver cros_usbpd_logger_driver = {
 		.pm = &cros_usbpd_logger_pm_ops,
 	},
 	.probe = cros_usbpd_logger_probe,
-	.remove = cros_usbpd_logger_remove,
+	.remove_new = cros_usbpd_logger_remove,
 };
 
 module_platform_driver(cros_usbpd_logger_driver);
-- 
2.40.1

