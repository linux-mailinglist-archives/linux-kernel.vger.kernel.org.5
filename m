Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D80E7A534D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjIRTvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIRTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FACC112
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-0003u8-Av; Mon, 18 Sep 2023 21:51:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-007I9M-SL; Mon, 18 Sep 2023 21:51:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-002mD0-Il; Mon, 18 Sep 2023 21:51:20 +0200
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
Subject: [PATCH net-next 16/19] net: mdio: mux-multiplexer: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:59 +0200
Message-Id: <20230918195102.1302746-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=aBuTX9v1GXrVkGebzfqqZP9JXk2psQGbdaJCDMk0zD0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSOVUKaTpYZHBwGXckGwc1dy0TedJ25fMU2oe2a560Mq bNBVy90MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRCY7sv1k1pkt72uT/4/96 4vTpGS3FBcJJTk+ZApcbZUSIH5D8yy98g1lmsdTr95Y/3G4kB8VJc3toLz58sm/+z1nZ/ndPHXZ /etEnQ+Xlb6/w8AAdXdXsfT0a/nvEJZl2WIRdl3N+vYd1af5iu+gi+f7bocJ/r+6cJXUrq32xjc TjJx9+9h4T+jGdUTCAt/m5uvHyDhk3kfxXCo73pKTb152fXf81V/fsjDCNAkWZj0+5d2zykPjH8 ZVn3ypem8U74pMCuzdP+sP4yPe8eq2Nr1321+YNTdzHl9W2PN/ussJWL0aEzfb0+6Wavvd2b+ae duAVt6p6xkzuAP9LCaJ/OUNCdsuGyHYbfZI6dqtxr/M0AA==
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
 drivers/net/mdio/mdio-mux-multiplexer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-multiplexer.c b/drivers/net/mdio/mdio-mux-multiplexer.c
index bfa5af577b0a..569b13383191 100644
--- a/drivers/net/mdio/mdio-mux-multiplexer.c
+++ b/drivers/net/mdio/mdio-mux-multiplexer.c
@@ -85,7 +85,7 @@ static int mdio_mux_multiplexer_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mdio_mux_multiplexer_remove(struct platform_device *pdev)
+static void mdio_mux_multiplexer_remove(struct platform_device *pdev)
 {
 	struct mdio_mux_multiplexer_state *s = platform_get_drvdata(pdev);
 
@@ -93,8 +93,6 @@ static int mdio_mux_multiplexer_remove(struct platform_device *pdev)
 
 	if (s->do_deselect)
 		mux_control_deselect(s->muxc);
-
-	return 0;
 }
 
 static const struct of_device_id mdio_mux_multiplexer_match[] = {
@@ -109,7 +107,7 @@ static struct platform_driver mdio_mux_multiplexer_driver = {
 		.of_match_table	= mdio_mux_multiplexer_match,
 	},
 	.probe		= mdio_mux_multiplexer_probe,
-	.remove		= mdio_mux_multiplexer_remove,
+	.remove_new	= mdio_mux_multiplexer_remove,
 };
 
 module_platform_driver(mdio_mux_multiplexer_driver);
-- 
2.40.1

