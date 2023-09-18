Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6767A5352
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjIRTv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIRTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8779E10F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH9-0003og-Uw; Mon, 18 Sep 2023 21:51:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH9-007I8x-GU; Mon, 18 Sep 2023 21:51:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH9-002mCc-5i; Mon, 18 Sep 2023 21:51:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/19] net: mdio: mux-bcm-iproc: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:53 +0200
Message-Id: <20230918195102.1302746-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M52LgWHkFZ/4d48b6ksHEiG2E1+/CV6YxGBCzg5tYiU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoL1nUgsydk6XQA+RbH/xkc34Zk0EDvzUx2w +VD7AMY/YqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqCwAKCRCPgPtYfRL+ TiPIB/9kGsTktZ5XGR76AWUBluoKx4ggJTt+L92ib8tyoU82m553O0Ah2JdARGVnCmMaA781hN3 ro4SnJWwnRzKoxVqLiep+XhI4svyu6mXqsTjAihRf4JTdb0KKrPL2B0yemtzs330yJyiW6v7u2Y MH/z9yB/CGM3dzsMuxWMTPVnxdaJraa4cmQBLgsW6ie2LMn9Uhv7QemRA0p1g1TNHXwXhID5Utt SLfuYnqNXEiRr/dftP3gvZaaYGEeC7B+6XsGIRwouJgSDYH81cmy4HerpdYA98XuLUcmYzWdo2i 4HY3GNXxp+lrRO1E7qVdb+qk0To6Oz3EBUTEwI/T6XNlhGV5
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
 drivers/net/mdio/mdio-mux-bcm-iproc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-bcm-iproc.c b/drivers/net/mdio/mdio-mux-bcm-iproc.c
index 956d54846b62..a750bd4c77a0 100644
--- a/drivers/net/mdio/mdio-mux-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-mux-bcm-iproc.c
@@ -287,15 +287,13 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int mdio_mux_iproc_remove(struct platform_device *pdev)
+static void mdio_mux_iproc_remove(struct platform_device *pdev)
 {
 	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
 	clk_disable_unprepare(md->core_clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -342,7 +340,7 @@ static struct platform_driver mdiomux_iproc_driver = {
 		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
-	.remove		= mdio_mux_iproc_remove,
+	.remove_new	= mdio_mux_iproc_remove,
 };
 
 module_platform_driver(mdiomux_iproc_driver);
-- 
2.40.1

