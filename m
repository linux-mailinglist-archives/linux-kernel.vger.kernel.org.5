Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD07AD4E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIYJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjIYJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20757C2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-0007m8-Cv; Mon, 25 Sep 2023 11:55:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJU-008pyq-OI; Mon, 25 Sep 2023 11:55:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJU-004dkg-FO; Mon, 25 Sep 2023 11:55:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 05/40] soc/fsl: dpaa2-console: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:54:56 +0200
Message-Id: <20230925095532.1984344-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ukbBE4jqLaAnZb877ktWYcrAFTDTf2PsCWS9tyemGBY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhFHEx0VdTwDi2rACcmeVnHEypdmd2pNmHks r+lH4Ry9/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYRQAKCRCPgPtYfRL+ TtIiCAC4R9nAgiMQjZCO/5mU/wf/nxEoTUTdqBt9lg3RdO1EreAHM8m6nzWChfYjPYnGbXHCu2F xnamcdNoXIrA8tW/PV/NM0V64iORJrkB6NzJrJuXBQMFukJhZCyFb8mnAulb0/SbErp9TR4YCKr M5ndH4LGJTuU72C5O/Ys+VdvqmbOkpK72KL7YUwJzIJ8+2Brq7Dnfs+7OMpiJKjdPGgOXOT+xd1 Zb4EqJj//MO3kK7l3JXb+ODqcAB8y6VCo6SF1S6gXgM56CWsD6X9Ir2KK5dlGewOROHZnmkUgnc F7w1Wc2uTSx8ajFcnQQo1/hMhbjQQDGVh6DCnCZ9TztZq/bU
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
 drivers/soc/fsl/dpaa2-console.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
index 1dca693b6b38..6dbc77db7718 100644
--- a/drivers/soc/fsl/dpaa2-console.c
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -300,12 +300,10 @@ static int dpaa2_console_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int dpaa2_console_remove(struct platform_device *pdev)
+static void dpaa2_console_remove(struct platform_device *pdev)
 {
 	misc_deregister(&dpaa2_mc_console_dev);
 	misc_deregister(&dpaa2_aiop_console_dev);
-
-	return 0;
 }
 
 static const struct of_device_id dpaa2_console_match_table[] = {
@@ -322,7 +320,7 @@ static struct platform_driver dpaa2_console_driver = {
 		   .of_match_table = dpaa2_console_match_table,
 		   },
 	.probe = dpaa2_console_probe,
-	.remove = dpaa2_console_remove,
+	.remove_new = dpaa2_console_remove,
 };
 module_platform_driver(dpaa2_console_driver);
 
-- 
2.40.1

