Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938477F6483
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjKWQ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjKWQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5F0D48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-0004z6-SO; Thu, 23 Nov 2023 17:56:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-00B54Z-FD; Thu, 23 Nov 2023 17:56:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-006ozA-5t; Thu, 23 Nov 2023 17:56:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 02/18] mfd: cros_ec_dev: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:30 +0100
Message-ID: <20231123165627.492259-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LCw3bj2aWliMJeRhvUQKWZ55KhVQThCiahgEmDcwN4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4Q9cxZ+4UCl/GvDKW8mubt9953vOUXfszBV1 wxXWkcEyzCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+EPQAKCRCPgPtYfRL+ TnSGCACPvoDxVg9509CpoLILWkjmQePD3RgHtDcRoR7vpXswXCrpfuxJ0LgJhErkN9IMJwHLJCZ n5MH/d47hy4AAlYyGpVfRdJDAaId5dQHOIC6qcmZh8IUKbJ+I4oFt5ReW2XRjvPZJD6SuE/HMIn m97u6S+ZX0DD7ELI5VFlmtH8lyt3zN6niBuAvpMc5aR0l+yGGUDuxto0cg1r19oGht93TgQUZJB bnuZFTb6XFh/A0ewm4kADppa6R23xUdDqI+I9J/wv1rF5Q8uOnVPQLBHM4jfZ9uqdEz7dNbHoPb BKvxqOcnohoCSeEKMHyyLOhGrMIytQKUsZ4X3M/BFwQ42KxY
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
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/cros_ec_dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 79d393b602bf..603b1cd52785 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -288,13 +288,12 @@ static int ec_device_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static int ec_device_remove(struct platform_device *pdev)
+static void ec_device_remove(struct platform_device *pdev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
 
 	mfd_remove_devices(ec->dev);
 	device_unregister(&ec->class_dev);
-	return 0;
 }
 
 static const struct platform_device_id cros_ec_id[] = {
@@ -309,7 +308,7 @@ static struct platform_driver cros_ec_dev_driver = {
 	},
 	.id_table = cros_ec_id,
 	.probe = ec_device_probe,
-	.remove = ec_device_remove,
+	.remove_new = ec_device_remove,
 };
 
 static int __init cros_ec_dev_init(void)
-- 
2.42.0

