Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBB80540E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjLEM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjLEM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F910F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-0005XY-K6; Tue, 05 Dec 2023 13:26:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00Djuu-7a; Tue, 05 Dec 2023 13:26:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVW-00EhQh-Uq; Tue, 05 Dec 2023 13:26:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/8] regulator: db8500-prcmu: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:18 +0100
Message-ID:  <fcaa42d7dd707031ed8dd9e8c28483891b879965.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aQBaFL+FANXD31y3+CbqmAskYiXzkwfN3BmtZOQME1Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbpizW0JIt1XczXtpIgApN7XcjmUuaG+FhOf Df5QsH3KhaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W6QAKCRCPgPtYfRL+ TmbUB/wK0Qf/b8gsd9YQ6Hsl1DpgEI0ASqXa8lirDvQU/cJMTo5iN1xlEcnjAqYEC8VR6+gBUWU 3/Nqjdcco4i+4fQ9KzGyL7HzmTuhL5xUcRSA6WYpVxeL940o6HfR7HBLiQZZziXdVe+uf6lilc8 oiJiqebw9iuv7BuMZHpo3tlbhOIcm9U1zb9/EsJYWtx55MmSrNbUx7SJsl9q7mY3WJS6cLDdOZ6 bEW/5dB8SPO19nZ6p0E9OrUAv9wFcfofvozmJwiv4O316ACdj3hDbVzkyagRuo7ycx83GuRcOp6 DABtEHAPSWb370DtrDpUBkbagM0g8oaB5ItADe/JUICsqV9+
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
 drivers/regulator/db8500-prcmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 34c5e485d0af..1e2d54da1b9a 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -469,11 +469,9 @@ static int db8500_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int db8500_regulator_remove(struct platform_device *pdev)
+static void db8500_regulator_remove(struct platform_device *pdev)
 {
 	ux500_regulator_debug_exit();
-
-	return 0;
 }
 
 static struct platform_driver db8500_regulator_driver = {
@@ -482,7 +480,7 @@ static struct platform_driver db8500_regulator_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = db8500_regulator_probe,
-	.remove = db8500_regulator_remove,
+	.remove_new = db8500_regulator_remove,
 };
 
 static int __init db8500_regulator_init(void)
-- 
2.42.0

