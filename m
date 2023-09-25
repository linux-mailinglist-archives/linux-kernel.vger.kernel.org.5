Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDB7AD504
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjIYJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjIYJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDDD100
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-0008Ar-NY; Mon, 25 Sep 2023 11:55:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-008q15-Ap; Mon, 25 Sep 2023 11:55:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-004dms-1k; Mon, 25 Sep 2023 11:55:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 39/40] soc/ti: wkup_m3_ipc: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:30 +0200
Message-Id: <20230925095532.1984344-40-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uKW31zoDaSRnidHyxwgUspOOB3QVRh8Uu/IMjh6/dVw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhreqDzPwrtv2WQm2i+IxS/5UArlWfx0Rx+z c0iw41zTrGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYawAKCRCPgPtYfRL+ Tgj7B/sEJhCf+1WQJSVdnoeJx+FmTbUzIRWuDSgAgygIwuy13zVj7Ku/cIffjU3ntQqe4ybLY+3 oU4/yc7ndjFJ+5zLPHhetU84byJyVn7RArFqSKG9OdOTWP3YXELqmaQYmO7MZMMNo2ttNAoLsox ILAZEc4X/eUWLJ3voeH0ICDFS8xrPh9Kb7EwWZWZ2slwFMxh9DFW4kLF/H4WITAm/ezT8TglhxY IzuSMW1NCA3IRIilWP04/MPRZ/kSWpzzItf9r4jFtqGEAsPsyYG5ct8xPlhIFjBHZ7AcSaGKF1x dQdTNWpzC8dUmqKbNSAB/5qIV2xFv/ouz8ZyzCWyj4N1PWdv
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
 drivers/soc/ti/wkup_m3_ipc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 3aff106fc11a..6a1c6b34c414 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -713,7 +713,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wkup_m3_ipc_remove(struct platform_device *pdev)
+static void wkup_m3_ipc_remove(struct platform_device *pdev)
 {
 	wkup_m3_ipc_dbg_destroy(m3_ipc_state);
 
@@ -723,8 +723,6 @@ static int wkup_m3_ipc_remove(struct platform_device *pdev)
 	rproc_put(m3_ipc_state->rproc);
 
 	m3_ipc_state = NULL;
-
-	return 0;
 }
 
 static int __maybe_unused wkup_m3_ipc_suspend(struct device *dev)
@@ -760,7 +758,7 @@ MODULE_DEVICE_TABLE(of, wkup_m3_ipc_of_match);
 
 static struct platform_driver wkup_m3_ipc_driver = {
 	.probe = wkup_m3_ipc_probe,
-	.remove = wkup_m3_ipc_remove,
+	.remove_new = wkup_m3_ipc_remove,
 	.driver = {
 		.name = "wkup_m3_ipc",
 		.of_match_table = wkup_m3_ipc_of_match,
-- 
2.40.1

