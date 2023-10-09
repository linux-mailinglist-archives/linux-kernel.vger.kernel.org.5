Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675037BD6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjJIJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbjJIJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE255DF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-0006sy-Sw; Mon, 09 Oct 2023 11:22:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-000NWi-Fw; Mon, 09 Oct 2023 11:22:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-00C4pD-71; Mon, 09 Oct 2023 11:22:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] pinctrl: nomadik: abx500: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:43 +0200
Message-Id: <20231009083856.222030-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x2KWQ8ND+eDvRay0aKLtZDCZD1SPAhsCIdQmVEps4lo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI7wHsl1vdO0V+6YWoS08CB0bmd/UjRDek9bRC dXtf5HfDhCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSO8BwAKCRCPgPtYfRL+ TjeFCACbpMBmj7EOf+G1UFGYv3PxitszRTnu9lWkhurVE7IsmkEsb+WQq7EsN0hE+S5AIKjcuHX eoDGCNbRLj0Y50C6P3zDeCdwe91dtx7eugvi3xsOkeEFdmIqB8MIdgr+l9InqnIw/fWHDXY38Ac wshhoqeRZF3E3vuMDy97fhtAZKauXplJ8Z8FMVnPmUyCZiJQ4TZxqRwrc0r/ogUtzIJHxJaDaDs wBtk2i0BAlzXEiMmXBez1UkMLh15Xwxc8qlfANnoJn3TAQCqegPHFSKSfRC7dGfjghsH+7yPQn+ 4rO4837lZEUGxc0AH2HPL4f8ZfbZyXoPAWwZhB1QAdXu+SB1
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
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 6b90051af206..233857d54403 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -1079,12 +1079,11 @@ static int abx500_gpio_probe(struct platform_device *pdev)
  * abx500_gpio_remove() - remove Ab8500-gpio driver
  * @pdev:	Platform device registered
  */
-static int abx500_gpio_remove(struct platform_device *pdev)
+static void abx500_gpio_remove(struct platform_device *pdev)
 {
 	struct abx500_pinctrl *pct = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pct->chip);
-	return 0;
 }
 
 static struct platform_driver abx500_gpio_driver = {
@@ -1093,7 +1092,7 @@ static struct platform_driver abx500_gpio_driver = {
 		.of_match_table = abx500_gpio_match,
 	},
 	.probe = abx500_gpio_probe,
-	.remove = abx500_gpio_remove,
+	.remove_new = abx500_gpio_remove,
 };
 
 static int __init abx500_gpio_init(void)
-- 
2.40.1

