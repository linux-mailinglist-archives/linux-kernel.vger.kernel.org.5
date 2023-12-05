Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8A805419
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjLEM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjLEM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:34 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623C10F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVY-0005YU-Jo; Tue, 05 Dec 2023 13:26:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVY-00DjvC-6i; Tue, 05 Dec 2023 13:26:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00EhR2-U0; Tue, 05 Dec 2023 13:26:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 8/8] regulator: wm8350: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:23 +0100
Message-ID:  <1f7bbc545829a1cc3df40be0424fe46d7449fb72.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=uGW+3kGg7E8CYPUZDYr0vtieqTGUZjfYrj/+nnZMeCo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbvtvaXAKewk789zdSg231w7Q/drOBpuY49i mOQm03R7/uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W7wAKCRCPgPtYfRL+ TqJ7CACEozsAbKkt6lOP19XV6OZ6tXJSH5WsUAVOfYvQohvM9BR+HeeUI22qYxq22wpvRnFEzkv SfTf/fyXYiifW7/88tlLg+5UpL6v+GCVQJMRsKJcJ5lvDDZYH7XfOTMz5PqNox/ZIXpgQf2ehRg gPaec0VE41ysvLW/I7AX9DUNbxL1aglPNYOYVzcrZkDviz+K+XDG3686mReIEcrOvpZE8bTapRA uNHH8sxlAug8ssCzBBvxtTLfJb5tkg/n7i9gEChJH6sg2l9CqN3RqlV4dUgzo1wJUJZEQOZlk2a GjHLKwB+BrdzwfT6RT7mnIKrJixUvZ50xBntzjKgnnKLMDPr
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
 drivers/regulator/wm8350-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 1445bafcab40..9939a5d2cbec 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1158,14 +1158,12 @@ static int wm8350_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm8350_regulator_remove(struct platform_device *pdev)
+static void wm8350_regulator_remove(struct platform_device *pdev)
 {
 	struct regulator_dev *rdev = platform_get_drvdata(pdev);
 	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
 
 	wm8350_free_irq(wm8350, wm8350_reg[pdev->id].irq, rdev);
-
-	return 0;
 }
 
 int wm8350_register_regulator(struct wm8350 *wm8350, int reg,
@@ -1306,7 +1304,7 @@ EXPORT_SYMBOL_GPL(wm8350_register_led);
 
 static struct platform_driver wm8350_regulator_driver = {
 	.probe = wm8350_regulator_probe,
-	.remove = wm8350_regulator_remove,
+	.remove_new = wm8350_regulator_remove,
 	.driver		= {
 		.name	= "wm8350-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.42.0

