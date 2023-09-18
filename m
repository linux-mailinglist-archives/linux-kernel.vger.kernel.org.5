Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18D7A5358
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjIRTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjIRTvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747E6138
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-0003tq-30; Mon, 18 Sep 2023 21:51:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-007I9I-KW; Mon, 18 Sep 2023 21:51:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-002mCw-B6; Mon, 18 Sep 2023 21:51:20 +0200
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
Subject: [PATCH net-next 15/19] net: mdio: mux-mmioreg: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:58 +0200
Message-Id: <20230918195102.1302746-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=h77ZoxiZILJ2uftNiEK49Y/i2dgAg9dOqTvmcC7eB20=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoRGsMzHv7bGXYkSmLQKpNxzSN8UoMzYZeCj OBrHu6dHmWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqEQAKCRCPgPtYfRL+ TuY+B/4llkrJrV/Nref3OzOaBFdS31P40gXJUMnIjaw+WQYSbPcIYmJswUGisfpQM/BndF/MHFE XlhPSl/mCv3r1iwssmEofBO3ZdlrtV5PcobhkAWp2k+0yMChTk9OPMOf+UaBHRpxhLS7x1H9nic HYFEbgD+ZBN//1kJy3FMoI5p0mQZhLz0y7/3d53rtPnv9SyOCr8+n6KzOTMmd2qfmlgBkHnD1eL kgETkh44aqw4YbOwGDdazQW8upR/yF8ivcdQW4M7Om/Po2+9gH3idNG1F/oE2ps/hQ1X7oZ47zs CZAxfJ3RrM/TY6rcc1mbfKP0NLKYQ+pK5y0Dm2tq/1Yrdm7Q
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
 drivers/net/mdio/mdio-mux-mmioreg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
index 09af150ed774..de08419d0c98 100644
--- a/drivers/net/mdio/mdio-mux-mmioreg.c
+++ b/drivers/net/mdio/mdio-mux-mmioreg.c
@@ -169,13 +169,11 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mdio_mux_mmioreg_remove(struct platform_device *pdev)
+static void mdio_mux_mmioreg_remove(struct platform_device *pdev)
 {
 	struct mdio_mux_mmioreg_state *s = dev_get_platdata(&pdev->dev);
 
 	mdio_mux_uninit(s->mux_handle);
-
-	return 0;
 }
 
 static const struct of_device_id mdio_mux_mmioreg_match[] = {
@@ -192,7 +190,7 @@ static struct platform_driver mdio_mux_mmioreg_driver = {
 		.of_match_table = mdio_mux_mmioreg_match,
 	},
 	.probe		= mdio_mux_mmioreg_probe,
-	.remove		= mdio_mux_mmioreg_remove,
+	.remove_new	= mdio_mux_mmioreg_remove,
 };
 
 module_platform_driver(mdio_mux_mmioreg_driver);
-- 
2.40.1

