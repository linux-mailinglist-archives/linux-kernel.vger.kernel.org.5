Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CA7A535C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjIRTwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjIRTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:49 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB4197
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHC-0003v0-1P; Mon, 18 Sep 2023 21:51:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-007I9Y-Hh; Mon, 18 Sep 2023 21:51:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-002mDB-7z; Mon, 18 Sep 2023 21:51:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 19/19] net: mdio: xgene: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:51:02 +0200
Message-Id: <20230918195102.1302746-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+lRpMpTPOqtxkBsIhgMJZMmhqpybzGn51IpnndXHe20=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoVxIes308o6YqvuoA1oRizRNhw4eywBhr9t iUjxlYbnGaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqFQAKCRCPgPtYfRL+ TmxCB/4/Kgd4hHK5avDIvbMAescmiI8fyE6w2FIEs0ibcV7oQkt20IzJE0kJVpEr6iarQJ0MhDM FXMPcHgHiqhnkz/JvfVz8xVGfy1PMyCv69MMZrD5g62mbrfIQKjx10WtjEh+AA6SQgYvSd4LnZj 1SZ0cWAs3nLYYxzlleFvhT1ulbRemLTAyQZYXTX9sfyM/r9iGYCwnok69zoJ1cOw8enpQexgKjV uxqdu+65O5XnO7BAqkpPeEEG5wcI4USfDPJx7cRmdKYZjCYr77tcfyXdlw5qh8p3YeK7oqqlX5E rTqWpH7erqc4dcDwSMxpEkUflHlA6Y2V4n/OJ8OkJS/AY+8J
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/mdio/mdio-xgene.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 1190a793555a..7909d7caf45c 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -432,7 +432,7 @@ static int xgene_mdio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xgene_mdio_remove(struct platform_device *pdev)
+static void xgene_mdio_remove(struct platform_device *pdev)
 {
 	struct xgene_mdio_pdata *pdata = platform_get_drvdata(pdev);
 	struct mii_bus *mdio_bus = pdata->mdio_bus;
@@ -443,8 +443,6 @@ static int xgene_mdio_remove(struct platform_device *pdev)
 
 	if (dev->of_node)
 		clk_disable_unprepare(pdata->clk);
-
-	return 0;
 }
 
 static struct platform_driver xgene_mdio_driver = {
@@ -454,7 +452,7 @@ static struct platform_driver xgene_mdio_driver = {
 		.acpi_match_table = ACPI_PTR(xgene_mdio_acpi_match),
 	},
 	.probe = xgene_mdio_probe,
-	.remove = xgene_mdio_remove,
+	.remove_new = xgene_mdio_remove,
 };
 
 module_platform_driver(xgene_mdio_driver);
-- 
2.40.1

