Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5419D7AD4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIYJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIYJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434CCA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-0007ow-P3; Mon, 25 Sep 2023 11:55:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-008pzJ-BI; Mon, 25 Sep 2023 11:55:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJW-004dl8-24; Mon, 25 Sep 2023 11:55:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/40] soc/litex: litex_soc_ctrl: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:03 +0200
Message-Id: <20230925095532.1984344-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+aJKU9kQ906MNGjvm2UkK9UOq1OE6knQipDDEsBvRok=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhNqCRoX3E4tgYELpgXaTNQI0/SvvNFeLtdI b55H1R1c+iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYTQAKCRCPgPtYfRL+ Ts5KB/sGPfoH5i1nQoeV08Wpif32WBtRNbG3tWRhtvBYv8/jkPBuLyVPdFvPmarJ2uXvu++QqZQ KzOT3RBgwE21ZEZc9UfbOsLi/fT5s8kErxZth+P6ynkpTSM8jGIGM4nrdKiljcChlUa/qhCwWI8 BOjZOL85i+QXSg1nNW/Kp4b5QU1p9l3lwCA7zIbMMN8H3mFjQcTUowAYTLaTytCFMNoi/nqcvpN 7lDomFtFdeln3Y4F6LCs85QRun4zgHT9WSPtCflnI48vaVuNyBfIo4Q9yRhsfZ4mTGCTEeNrkGl DKpobOZJHu9c9e/e7KKoB2iIfBg1gNs+GcSk3lMO5nLSMS3o
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
 drivers/soc/litex/litex_soc_ctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index f75790091d38..10813299aa10 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -120,12 +120,11 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int litex_soc_ctrl_remove(struct platform_device *pdev)
+static void litex_soc_ctrl_remove(struct platform_device *pdev)
 {
 	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
-	return 0;
 }
 
 static struct platform_driver litex_soc_ctrl_driver = {
@@ -134,7 +133,7 @@ static struct platform_driver litex_soc_ctrl_driver = {
 		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
 	},
 	.probe = litex_soc_ctrl_probe,
-	.remove = litex_soc_ctrl_remove,
+	.remove_new = litex_soc_ctrl_remove,
 };
 
 module_platform_driver(litex_soc_ctrl_driver);
-- 
2.40.1

