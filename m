Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F8D7BD6AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjJIJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbjJIJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C312C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-0006uJ-JM; Mon, 09 Oct 2023 11:22:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTF-000NXC-6U; Mon, 09 Oct 2023 11:22:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-00C4pf-Tc; Mon, 09 Oct 2023 11:22:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] pinctrl: tb10x: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:50 +0200
Message-Id: <20231009083856.222030-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DKr3s0/IU/9sggic3G90VxKYmkp4LOaBG2R8uqmIaBI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wPHaUEnsZbOMDT1bwDG9HhpL7Mrhfl6NcXM XP1WUpvkImJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8DwAKCRCPgPtYfRL+ TqOkB/4+mvvSTSCbIkonA1f363duBm9ycbAcAL+Qj6k7tBYZT9yRJi1bt8NK7NGDgWUOJRKVDVt iU29qId7bbp5GSMZsDVj3RCQVISSzx8K5mGddUCpF2HCbJ3GsMh2Y1nq6DeWLAy4qEYqp/8jUAo Kj6wLoJaD5pyOuDOqZ0AJBhGbmNlUQcNz0EWkeqkVT/LGyTy9Xc94XQZZ1vQL2+vdRinKxTRvnR TPNDuXVMA/cYQOUvAlmTVC20vg23+XoxtE2AIL4hFxRBuvBvcJcU44n0zQZ5MeLBdomrnV1ZRPo 633k1yS3UHwHRNGH5q7O7VW3j6jHRdGca620Oyg9s6g7fN9Q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/pinctrl-tb10x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
index ab49bd708969..c3b76e6511ac 100644
--- a/drivers/pinctrl/pinctrl-tb10x.c
+++ b/drivers/pinctrl/pinctrl-tb10x.c
@@ -804,13 +804,11 @@ static int tb10x_pinctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tb10x_pinctrl_remove(struct platform_device *pdev)
+static void tb10x_pinctrl_remove(struct platform_device *pdev)
 {
 	struct tb10x_pinctrl *state = platform_get_drvdata(pdev);
 
 	mutex_destroy(&state->mutex);
-
-	return 0;
 }
 
 
@@ -822,7 +820,7 @@ MODULE_DEVICE_TABLE(of, tb10x_pinctrl_dt_ids);
 
 static struct platform_driver tb10x_pinctrl_pdrv = {
 	.probe   = tb10x_pinctrl_probe,
-	.remove  = tb10x_pinctrl_remove,
+	.remove_new = tb10x_pinctrl_remove,
 	.driver  = {
 		.name  = "tb10x_pinctrl",
 		.of_match_table = of_match_ptr(tb10x_pinctrl_dt_ids),
-- 
2.40.1

