Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1269D7A534C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjIRTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC76109
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH9-0003lJ-LJ; Mon, 18 Sep 2023 21:51:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH9-007I8t-7G; Mon, 18 Sep 2023 21:51:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH8-002mCY-U9; Mon, 18 Sep 2023 21:51:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/19] net: mdio: mscc-miim: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:52 +0200
Message-Id: <20230918195102.1302746-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=041TtYXxE7dnRKGf01E0nKWqzpFWJPRnpGRIyKv8VLg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoKsaAjqfD4HL51xNTtF1K7xknpVDy1TRBo5 xjWiIf1Yu2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqCgAKCRCPgPtYfRL+ Tr/KCACYwA5Axo2xV8jZiqHtAim2rPaK47qldTD4vu/bNJo/SSEIRt+qv8oUvzi6XWr+6NkEOMU KOS/v4UDnM8V0gdPCDDbwoZkyBCR66yCN0xCYMkxaHGUjSNKjyKFpj6cZgaQh390SQfbs4h0XSB aM++rseZQdmkpsdOaU2/K2Hm4U1e9u78jY5UUIiU1dLGYGYK/WTU0md8n59F9n8JHhZSftQl68J ESuSnayftPl/WAgak6cq8Aksjc+HcsToh/VPE1e07PQiA78Qi1C0TluDojxJI4n0ZSRJ363EoPT M3/K0majEtAzi8k9Vj/i/xJ21emdKJ/jnkYJpr6w+tkKLKEk
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
 drivers/net/mdio/mdio-mscc-miim.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index 1a1b95ae95fa..c29377c85307 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -335,15 +335,13 @@ static int mscc_miim_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mscc_miim_remove(struct platform_device *pdev)
+static void mscc_miim_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 	struct mscc_miim_dev *miim = bus->priv;
 
 	clk_disable_unprepare(miim->clk);
 	mdiobus_unregister(bus);
-
-	return 0;
 }
 
 static const struct mscc_miim_info mscc_ocelot_miim_info = {
@@ -371,7 +369,7 @@ MODULE_DEVICE_TABLE(of, mscc_miim_match);
 
 static struct platform_driver mscc_miim_driver = {
 	.probe = mscc_miim_probe,
-	.remove = mscc_miim_remove,
+	.remove_new = mscc_miim_remove,
 	.driver = {
 		.name = "mscc-miim",
 		.of_match_table = mscc_miim_match,
-- 
2.40.1

