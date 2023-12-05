Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125F80541A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjLEM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjLEM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:26:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC2B109
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:26:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVZ-0005Y1-Ay; Tue, 05 Dec 2023 13:26:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00Djv1-LJ; Tue, 05 Dec 2023 13:26:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAUVX-00EhQq-CJ; Tue, 05 Dec 2023 13:26:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 5/8] regulator: uniphier: Convert to platform remove callback returning void
Date:   Tue,  5 Dec 2023 13:26:20 +0100
Message-ID:  <ced2a73a1aeca3f33d4b194e4dbe2672ad84a50a.1701778038.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701778038.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MfQF9iwHzK7xCZssdcBcprKdoRpEqSRfvgyJg9UlPro=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbxbrq9fl7uKhfoRDiG7dqJCrt0vg0UWtZzvc/ +ly7sZfv92JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW8W6wAKCRCPgPtYfRL+ TlwyCAC02HaN2JA3GOM5Pz1awjMRcqAd7FBE3meTNtDblEqQYbRj45gdB3s+eakbwt8OGXe0s4+ IYvp/HN4pzTqf52GEThQ4tzV0heLJDZqsTo8G1zwhTUICI93/Mwsl3JtaYrgj89jASG5I4ZA0+W KLX86oNb1t2tAlyzUQAuC4iqJpD3d8MaQRWhGc7nDRUTP55DdlZ7onsx5ttLvAh5WGYrtD/3+1e xD+ZEps+OeYZUr8Uc/TnLmCg3Lh3NuC9BqUIWA/fW5vt1/8xYF4+8MOuPvcRPXziAUZ0gcEOW4K PW6h57ydJu6eI0TeCsy/nyb3KfjsM499f5xeQtMABzzHO4tx
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
 drivers/regulator/uniphier-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 1d8304b88bd6..5f868042392f 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -115,7 +115,7 @@ static int uniphier_regulator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_regulator_remove(struct platform_device *pdev)
+static void uniphier_regulator_remove(struct platform_device *pdev)
 {
 	struct uniphier_regulator_priv *priv = platform_get_drvdata(pdev);
 	int i;
@@ -124,8 +124,6 @@ static int uniphier_regulator_remove(struct platform_device *pdev)
 		reset_control_assert(priv->rst[i]);
 
 	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
-
-	return 0;
 }
 
 /* USB3 controller data */
@@ -209,7 +207,7 @@ MODULE_DEVICE_TABLE(of, uniphier_regulator_match);
 
 static struct platform_driver uniphier_regulator_driver = {
 	.probe = uniphier_regulator_probe,
-	.remove = uniphier_regulator_remove,
+	.remove_new = uniphier_regulator_remove,
 	.driver = {
 		.name  = "uniphier-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-- 
2.42.0

