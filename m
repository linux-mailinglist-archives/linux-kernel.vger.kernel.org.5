Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06C7BD6D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbjJIJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjJIJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551CC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-0006sZ-By; Mon, 09 Oct 2023 11:22:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-000NWT-JS; Mon, 09 Oct 2023 11:22:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-00C4ox-AX; Mon, 09 Oct 2023 11:22:34 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] pinctrl: ti: ti-iodelay: Drop if block with always false condition
Date:   Mon,  9 Oct 2023 10:38:39 +0200
Message-Id: <20231009083856.222030-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ADcuWWwkM5/gkoFp6FtBWjwsKB9USL1JlIZt0PCZ89o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wC2UY8AHx4VUIV+FUuHGT44H9qCxr8Sw/dU 8c6tnLh2GmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8AgAKCRCPgPtYfRL+ TurFB/4kLIvktU36dHpqh45SEy0RA6rK+k31xiIn3waWC0qcGft0HgOWYcEVNw2TagvASbL80vz 4E0xrh2Op0jCl7twlM2P1nZvBV+9w26vr9EaVmSsjmfFEp5Grbde0adN03TW7CRCatfAmZsHDEm USTx3+8PNV537PLm8qrQ8bDHlTSdvaRsHd4Wa5caZ7+m9Y7kJLkqKddC7XASpiqY0J2zqOtdNk2 Bzk6lQLrMgZluxPjOJHU6hDq/hE/hJrRkbM1m0YZxm2PxIZoNdoBv1mnJZTGojOBhGJS+MYUVq3 0G0piGTFwOmz0p8cvRXZqjXs579tszkrgkXAg/A20Uub/e2M
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

ti_iodelay_remove() is only called after ti_iodelay_probe() completed
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so platform_get_drvdata() won't return NULL.

Simplify by removing the if block with the always false condition.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index c1477f657839..f3a273562095 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -903,9 +903,6 @@ static int ti_iodelay_remove(struct platform_device *pdev)
 {
 	struct ti_iodelay_device *iod = platform_get_drvdata(pdev);
 
-	if (!iod)
-		return 0;
-
 	if (iod->pctl)
 		pinctrl_unregister(iod->pctl);
 
-- 
2.40.1

