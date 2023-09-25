Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941D97AD50F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjIYJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjIYJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F324121
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-0008Ac-Ef; Mon, 25 Sep 2023 11:55:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-008q11-1g; Mon, 25 Sep 2023 11:55:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-004dmo-Os; Mon, 25 Sep 2023 11:55:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 38/40] soc/ti: smartreflex: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:29 +0200
Message-Id: <20230925095532.1984344-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4d422s6IfK+PZd49xO16KIpO0P7Pb3ZoYCNlxGHe6UU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhqi4q+YX2/ODz50t5a28eJtr2XsnuzvYPbP DbLVwZkIoaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYagAKCRCPgPtYfRL+ TnvhB/9W+/ztDY/B6mFgKPRJGOLWPay5fz2LE+GwCJwYG3J+xWdj3UHzQ7CoOdzms8DROx2+OOv 7HBEsORfaLju3D+s0fk4eriQzpt6IF4tJ5gd7WPMwg1hzV91tXDZ/sUP36U5hXZgslSrWjAqr0G aGtXkA0O5XXpgZEXDtFs43B3FYypbG+11R7ZiToT+OELuJUbnuJNTywcHPimwT8dEXf6RdnRRUV VBwiwpzFkQdSEin4w1L9CrBck5ST1PQJ7EYguG1BkbLmVWkf1FPTIG3sbysqEyo/w2klJL8/TPw 6kLJR0m1jq5LiLk21/fKqs8Z0BpQDhMthlhA3qrjKFuMFaD/
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
 drivers/soc/ti/smartreflex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index 62b2f1464e46..d6219060b616 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -933,7 +933,7 @@ static int omap_sr_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_sr_remove(struct platform_device *pdev)
+static void omap_sr_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct omap_sr *sr_info = platform_get_drvdata(pdev);
@@ -945,7 +945,6 @@ static int omap_sr_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	clk_unprepare(sr_info->fck);
 	list_del(&sr_info->node);
-	return 0;
 }
 
 static void omap_sr_shutdown(struct platform_device *pdev)
@@ -970,7 +969,7 @@ MODULE_DEVICE_TABLE(of, omap_sr_match);
 
 static struct platform_driver smartreflex_driver = {
 	.probe		= omap_sr_probe,
-	.remove         = omap_sr_remove,
+	.remove_new     = omap_sr_remove,
 	.shutdown	= omap_sr_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
-- 
2.40.1

