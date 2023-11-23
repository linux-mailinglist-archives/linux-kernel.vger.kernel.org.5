Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842BA7F647F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbjKWQ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbjKWQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043CCBC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0g-00058l-E4; Thu, 23 Nov 2023 17:57:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0g-00B55U-1W; Thu, 23 Nov 2023 17:57:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0f-006p04-Ok; Thu, 23 Nov 2023 17:57:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 16/18] mfd: ti_am335x_tscadc: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:44 +0100
Message-ID: <20231123165627.492259-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=958CZe9ea6jlgCw+DhNvLHgJQMdn3TTMy73VrfjhS7g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RNzUp+O1Q5mU1TkWEfA3LmuaPzBLdiln56y PSSEKex4f6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+ETQAKCRCPgPtYfRL+ TurkCACzAHQ8fH88QHgqOLqaNePjWA12uL4ORz6rDd/07Qql/Ocfh960J2cC1A9UR/xfVcUw5M1 xRz2DM97OMdCUYi6zn7jATB7wZ5HQbgdf4GWEN8PZOdNZdExU+Da70xA3G2ftNnvOBDYQ9Xpjjl LcIX/J36/F15n0ewUYD93CLn5i9eZOlbn8cZwF1aM7Vu6jp38egkaQbS5r9O9TmiEgHEjzytFjD 1dwiHTLqpkoExD/kLDpsEO1eT/FTDc8pB8BlE0IwT1ozQ+GMTCceLq9L/28LGwj0Pw59DT8Ll0O ocPFfGmV7OYX/MmBSfr301ogvoJCLRoWcetR7uv8ixprikzT
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
 drivers/mfd/ti_am335x_tscadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index b88eb70c17b3..4bbd542d753e 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -298,7 +298,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ti_tscadc_remove(struct platform_device *pdev)
+static void ti_tscadc_remove(struct platform_device *pdev)
 {
 	struct ti_tscadc_dev *tscadc = platform_get_drvdata(pdev);
 
@@ -308,8 +308,6 @@ static int ti_tscadc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	mfd_remove_devices(tscadc->dev);
-
-	return 0;
 }
 
 static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
@@ -381,7 +379,7 @@ static struct platform_driver ti_tscadc_driver = {
 		.of_match_table = ti_tscadc_dt_ids,
 	},
 	.probe	= ti_tscadc_probe,
-	.remove	= ti_tscadc_remove,
+	.remove_new = ti_tscadc_remove,
 
 };
 
-- 
2.42.0

