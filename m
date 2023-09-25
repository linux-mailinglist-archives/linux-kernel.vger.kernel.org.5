Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED337AD508
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjIYJ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIYJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D76103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-00088k-Ik; Mon, 25 Sep 2023 11:55:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-008q0l-5j; Mon, 25 Sep 2023 11:55:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-004dmY-SW; Mon, 25 Sep 2023 11:55:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 34/40] soc/ti: knav_dma: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:25 +0200
Message-Id: <20230925095532.1984344-35-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dh69mYFR4egmQPe5mzBDjMQ4mx/++UfHvxZ/Uiregas=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhm5EBdm/9vZUJsuOCEfsIrnQ0tb63Zgo3D5 qY3Qz1ktIWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYZgAKCRCPgPtYfRL+ TgjQCAC5JeA5F/+ij1LEKrRjIRPwuHFcPLZh7epJ7fyS/uyW/ZWnboMCmRCFDToziZTi3mu4CpT i29Yks7ZtxuYCiD8TzVK6mal/7N8AKCjEIb73yt4wGecf+PZBlAcXUio9lNiWwW0UqoRoauYgei TfkpJ5gM2s4W8TACWjnWDWTgbh+rP8Ii8Wid2s7cckVyN7F9L7V1QuxOFKw1nfe3ob1a3y+lzqI Qyib16oG7GZ/UOo/XsyAtCZXBMRmn2yJWHYslQUk+CKoRVgnsijWMyYsPZpW4mnu0yRkhxFOens 6sH36RS/3vvF5IWVv8Nut2LVqwnxuSOfU5JWiwTPrL29ZU8g
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
 drivers/soc/ti/knav_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 0fbc37cd5123..6023006685fc 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -773,7 +773,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int knav_dma_remove(struct platform_device *pdev)
+static void knav_dma_remove(struct platform_device *pdev)
 {
 	struct knav_dma_device *dma;
 
@@ -784,8 +784,6 @@ static int knav_dma_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static struct of_device_id of_match[] = {
@@ -797,7 +795,7 @@ MODULE_DEVICE_TABLE(of, of_match);
 
 static struct platform_driver knav_dma_driver = {
 	.probe	= knav_dma_probe,
-	.remove	= knav_dma_remove,
+	.remove_new = knav_dma_remove,
 	.driver = {
 		.name		= "keystone-navigator-dma",
 		.of_match_table	= of_match,
-- 
2.40.1

