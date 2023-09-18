Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7977A534E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjIRTvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0FF10A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH8-0003kN-PK; Mon, 18 Sep 2023 21:51:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH7-007I8T-MK; Mon, 18 Sep 2023 21:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKH7-002mC6-CQ; Mon, 18 Sep 2023 21:51:17 +0200
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
Subject: [PATCH net-next 02/19] net: mdio: bcm-iproc: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:45 +0200
Message-Id: <20230918195102.1302746-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wWOk5ISRV+Cu8beJpj4odlkFSht8tvcCLTItEfQP5kQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoBowTF/6mTesdVE3rQTlFpYwkX8+FZIowHa JOgBIu64zGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqAQAKCRCPgPtYfRL+ TmjjB/4lCfQp5h7nyKtACQrfiQ6ZTgSB75P9Q7dNR1kc+jd4DE4cOLP0GKrF1iaocN5wCzQSulb PvNFwvsGP2VtbKCwF/ceWh5EyY6MnGYxoZmYrhJlmUUoXDOvf25qlGhaWL/463JpR1fdqxkwjFo QeE2lTCbPcFVmHZ7W6YveCd+xt4hMTyuHwSn8pCdFPMaEvpXUP7hvr+WmC+ChjKRmMIQhvWIFV/ vBLDP9+OI12BR4g1Wz/C/VvdGXVbgRkjoyiv/7qRu2fhBQ0MxwMnhBIZEgbruIy2l1B7km1H7PO xGlVlpMbAQSekrDtS8NWqWAm5KWxqfgm06RBOZL5FIp9ELvo
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
 drivers/net/mdio/mdio-bcm-iproc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-iproc.c b/drivers/net/mdio/mdio-bcm-iproc.c
index 77fc970cdfde..5a2d26c6afdc 100644
--- a/drivers/net/mdio/mdio-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-bcm-iproc.c
@@ -168,14 +168,12 @@ static int iproc_mdio_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int iproc_mdio_remove(struct platform_device *pdev)
+static void iproc_mdio_remove(struct platform_device *pdev)
 {
 	struct iproc_mdio_priv *priv = platform_get_drvdata(pdev);
 
 	mdiobus_unregister(priv->mii_bus);
 	mdiobus_free(priv->mii_bus);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -210,7 +208,7 @@ static struct platform_driver iproc_mdio_driver = {
 #endif
 	},
 	.probe = iproc_mdio_probe,
-	.remove = iproc_mdio_remove,
+	.remove_new = iproc_mdio_remove,
 };
 
 module_platform_driver(iproc_mdio_driver);
-- 
2.40.1

