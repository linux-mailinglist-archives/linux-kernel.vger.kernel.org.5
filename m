Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBD7AD506
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjIYJ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjIYJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C77106
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJY-0007vo-4O; Mon, 25 Sep 2023 11:55:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-008pzZ-76; Mon, 25 Sep 2023 11:55:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-004dlO-UI; Mon, 25 Sep 2023 11:55:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 16/40] soc/microchip: mpfs-sys-controller: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:07 +0200
Message-Id: <20230925095532.1984344-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qMSvMdLyWMVv0eJCyiyAecwlWse+6vZrOq8DCVNTw0k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhRLmiPsKzsDJkYR+pBw2aoZnqSIdabHXV7C DpcqEXgCa2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYUQAKCRCPgPtYfRL+ TmTYB/99Y/TSuw+jf9J9wshJHpxLVPHGRUpd5pY81V4tLP2iw+PzEksAiYPeQymUzFoH1qsh1Is t/RZu7byjFUcQGsdQUHYb01thd2I/BwqgtXqnj+9f12ZgIjs7T4uvIpZsMzscvrM2Z1/sMclYZV wdhVIxGpotONKw8apwUR4kd/G8FCPI2TcopqkrjyY9Ct4lrPx14ra2v6XX2VDVxBuH8RCNM/Ux4 eRqP8T8xLhpjFcbn9JNZGJucAUxruSr0cvVjqp0poxFMXVTwr7UVF+8ZZLrWnC6oyqNUrWCyCad HSTQYlWFtRsmsaS2sIQWLy7FhEOniQGQem/769udRIwibvDm
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
 drivers/soc/microchip/mpfs-sys-controller.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index fbcd5fd24d7c..0935e9e94172 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -149,13 +149,11 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mpfs_sys_controller_remove(struct platform_device *pdev)
+static void mpfs_sys_controller_remove(struct platform_device *pdev)
 {
 	struct mpfs_sys_controller *sys_controller = platform_get_drvdata(pdev);
 
 	mpfs_sys_controller_put(sys_controller);
-
-	return 0;
 }
 
 static const struct of_device_id mpfs_sys_controller_of_match[] = {
@@ -207,7 +205,7 @@ static struct platform_driver mpfs_sys_controller_driver = {
 		.of_match_table = mpfs_sys_controller_of_match,
 	},
 	.probe = mpfs_sys_controller_probe,
-	.remove = mpfs_sys_controller_remove,
+	.remove_new = mpfs_sys_controller_remove,
 };
 module_platform_driver(mpfs_sys_controller_driver);
 
-- 
2.40.1

