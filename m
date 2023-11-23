Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0D7F6482
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjKWQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbjKWQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:56:58 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49236D42
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0g-00058v-MR; Thu, 23 Nov 2023 17:57:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0g-00B55X-9s; Thu, 23 Nov 2023 17:57:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0g-006p08-0j; Thu, 23 Nov 2023 17:57:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 17/18] mfd: tps65911-comparator: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:45 +0100
Message-ID: <20231123165627.492259-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
References: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DS/bp0Y0SVGN2rxRjkqNDXNDiJW5c7dknT63m3wnUL0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlX4RPuliNKk8BbKe9n0XXWQ4RFLhS0vJCQB6pC DrWE2WIpRuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV+ETwAKCRCPgPtYfRL+ Tq/hB/9U5uK3C/E0qQE1XN08NxkYDjSWNC4dbR5jjSSKuRmoMI8gTsSDNv3DoPuc4gnWelJuKC6 Ma9cm4OjpqmKbLrWJJrDz7gm1TZFnm8uVKpCrciM9LIcI4HJdN7UXIAeRDerSf7WxM6A72fzT+E jKhDQa2EQuYmy17k5vZdAqXtL8qNDSghg2l+miMezfZi8Dx1Er7k2Rqa2x2k8mHYTT4gk815wc+ CfpMKMaOCBNY3/S1Kf7lDYrt51v8Btv2mV0+UDPV/vmbsV41oUjKJzRfog+A5D1ktSXUXHmS4LO ku+89U/RF+v0wvHHfu4G2TJtB6Dlygj8IsH14ELnJ3TqSUcy
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
 drivers/mfd/tps65911-comparator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index 8f4210075913..f206a9c50e9d 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -140,15 +140,13 @@ static int tps65911_comparator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tps65911_comparator_remove(struct platform_device *pdev)
+static void tps65911_comparator_remove(struct platform_device *pdev)
 {
 	struct tps65910 *tps65910;
 
 	tps65910 = dev_get_drvdata(pdev->dev.parent);
 	device_remove_file(&pdev->dev, &dev_attr_comp2_threshold);
 	device_remove_file(&pdev->dev, &dev_attr_comp1_threshold);
-
-	return 0;
 }
 
 static struct platform_driver tps65911_comparator_driver = {
@@ -156,7 +154,7 @@ static struct platform_driver tps65911_comparator_driver = {
 		.name = "tps65911-comparator",
 	},
 	.probe = tps65911_comparator_probe,
-	.remove = tps65911_comparator_remove,
+	.remove_new = tps65911_comparator_remove,
 };
 
 static int __init tps65911_comparator_init(void)
-- 
2.42.0

