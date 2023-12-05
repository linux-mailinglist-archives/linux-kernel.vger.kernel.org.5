Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7CD805415
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjLEM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjLEM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:32 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655CAC9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVY-0005YB-DY; Tue, 05 Dec 2023 13:26:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVY-00Djv9-0j; Tue, 05 Dec 2023 13:26:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00EhQy-OG; Tue, 05 Dec 2023 13:26:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 7/8] regulator: virtual: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:22 +0100
Message-ID:  <d9954f02ae51b1b0b0077c710d16bfaeafa216ec.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1OKfIPBeDkKIREgYV7LXbr/0td99Z79KwgLwoughZ/c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbuOE/46ozZYuwEBtuuizP6Db361dH5Sjxp+ Slow9GJVjeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W7gAKCRCPgPtYfRL+ TmwIB/wJ6YpQ2ODQNk1jeVFJkg/vHO2WmI6bTHeiE1UEBDv3ANOfLiYCgutRQsfrDuzLocHJtF0 AEs1cdzNB5wQY5HtKvILN9fDWyidpJPwtG3Zygn1MHiEiOjmSsA364LJdS+hviBCGw+Xsa9B0FN zbCqA6olDtPyDCvo2C0Kz6oA3NH9Jlknhxqk03o2q8ayvEoCIvKf7I8uRHOYBuOTxiwRsz9/vrl qVeJhH4DGsPUz9jt36MBGXgfZYIe4PWb/oonaWO2mWv1oxl6FM2lCtHk5cYxViy0kpVtWb0D+YA V00SHr+iaR43hrxfthWVFdCA4uFAJLxNBVwubf0D8mG4w51T
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
 drivers/regulator/virtual.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/virtual.c b/drivers/regulator/virtual.c
index d5a160efdae6..0a0ee186c6af 100644
--- a/drivers/regulator/virtual.c
+++ b/drivers/regulator/virtual.c
@@ -345,7 +345,7 @@ static int regulator_virtual_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int regulator_virtual_remove(struct platform_device *pdev)
+static void regulator_virtual_remove(struct platform_device *pdev)
 {
 	struct virtual_consumer_data *drvdata = platform_get_drvdata(pdev);
 
@@ -353,13 +353,11 @@ static int regulator_virtual_remove(struct platform_device *pdev)
 
 	if (drvdata->enabled)
 		regulator_disable(drvdata->regulator);
-
-	return 0;
 }
 
 static struct platform_driver regulator_virtual_consumer_driver = {
 	.probe		= regulator_virtual_probe,
-	.remove		= regulator_virtual_remove,
+	.remove_new	= regulator_virtual_remove,
 	.driver		= {
 		.name		= "reg-virt-consumer",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.42.0

