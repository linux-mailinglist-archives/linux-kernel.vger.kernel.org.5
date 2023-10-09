Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E67BD6D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjJIJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345842AbjJIJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:22:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF42F9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:22:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTD-0006se-M8; Mon, 09 Oct 2023 11:22:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-000NWW-QH; Mon, 09 Oct 2023 11:22:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTC-00C4p1-HB; Mon, 09 Oct 2023 11:22:34 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] pinctrl: cirrus: madera-core: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:40 +0200
Message-Id: <20231009083856.222030-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=26z5dwfBVv8uNLLkaBoXVqJ2/KKNhn+09EFI0ePmRQg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTlPcyLrj76ufie/uJEWe5rEaxxUsbXZzfNSbtxO+Gg6 uwSm+M2nYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMRFKe/X+hyM/6vsxPDw62 hMcmBvn6BOm82a06IVqFne2v4o0vCR+qM6dmZ/mvC00K3xc6QWnKrvbXRVaW9dK9j17p23wsuDP HbvGzpVmrIjIXSTYeyjvs+WZv1L3q3bpVjVlrTCPdbtq8eKkXf+Rp1LQvGnM6uJPPdTNfrLT1M0 sSm6D3iPF6rrmLwMtvdRNuWihMm+NYmPzUybBvVQAb3+LMk2ItuRWHb9zwMAqSNjcQf6he43MpM FLKRaDXLH22XIGMwOIovzdSfRZWzhNnq72sMOsK333QX6vpQUKZ4ZOJKpcMJs8pufn2yjrhHHE3 J5GMfoHbX8OiZj/RutK/Xa3o5hynl3ziendCZNtCNNcCAA==
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
 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index bb589922d8c5..898b197c3738 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -1084,19 +1084,17 @@ static int madera_pin_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int madera_pin_remove(struct platform_device *pdev)
+static void madera_pin_remove(struct platform_device *pdev)
 {
 	struct madera_pin_private *priv = platform_get_drvdata(pdev);
 
 	if (priv->madera->pdata.gpio_configs)
 		pinctrl_unregister_mappings(priv->madera->pdata.gpio_configs);
-
-	return 0;
 }
 
 static struct platform_driver madera_pin_driver = {
 	.probe = madera_pin_probe,
-	.remove = madera_pin_remove,
+	.remove_new = madera_pin_remove,
 	.driver = {
 		.name = "madera-pinctrl",
 	},
-- 
2.40.1

