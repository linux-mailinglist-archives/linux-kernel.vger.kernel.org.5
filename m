Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592F7A535B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjIRTwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIRTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:51:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48E10F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-0003ud-PW; Mon, 18 Sep 2023 21:51:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-007I9U-BF; Mon, 18 Sep 2023 21:51:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHB-002mD8-1H; Mon, 18 Sep 2023 21:51:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 18/19] net: mdio: sun4i: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:51:01 +0200
Message-Id: <20230918195102.1302746-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DxgwDrTNtar3WQDWuF/eoiYnPZavw7pBqQg5E7ipNvg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoU61GepEzgl+fGpmUa34PTQOtixU0+QHOcm 4RqWewvs0WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqFAAKCRCPgPtYfRL+ TrSZB/4wwL0kIdl7KHlEmjF6EEGnJoKJ6GOEo1Or9142qoGDYE2jjd8cDTaknANzPfclJq3fJsc kKf9b4p2e5kb7Ru5ZgUE/cdHUbOZeQ6DT4l1v1EF3dYYtXBT6dcdUq665sgBMlV11ksHgwLfz1h HD8IsSThQdEnU9nSi8JbV5bNkO8IhSUG29Me9MlT333FTcJe+JtXruLy/sLz3ViCvnEmK9oig0Y XBFUebRgRfPT9/g8r90hTMo2wFe60lOQHFM7ffNXzqM2OKjMihiwLB4DX2qcrJBteXCfus2q765 V6V5RlO2yD2JstOsFYak2nMlyX4KuC+n7mAfK7E2M2IYRwHX
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
 drivers/net/mdio/mdio-sun4i.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-sun4i.c b/drivers/net/mdio/mdio-sun4i.c
index f798de3276dc..4511bcc73b36 100644
--- a/drivers/net/mdio/mdio-sun4i.c
+++ b/drivers/net/mdio/mdio-sun4i.c
@@ -142,7 +142,7 @@ static int sun4i_mdio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun4i_mdio_remove(struct platform_device *pdev)
+static void sun4i_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 	struct sun4i_mdio_data *data = bus->priv;
@@ -151,8 +151,6 @@ static int sun4i_mdio_remove(struct platform_device *pdev)
 	if (data->regulator)
 		regulator_disable(data->regulator);
 	mdiobus_free(bus);
-
-	return 0;
 }
 
 static const struct of_device_id sun4i_mdio_dt_ids[] = {
@@ -166,7 +164,7 @@ MODULE_DEVICE_TABLE(of, sun4i_mdio_dt_ids);
 
 static struct platform_driver sun4i_mdio_driver = {
 	.probe = sun4i_mdio_probe,
-	.remove = sun4i_mdio_remove,
+	.remove_new = sun4i_mdio_remove,
 	.driver = {
 		.name = "sun4i-mdio",
 		.of_match_table = sun4i_mdio_dt_ids,
-- 
2.40.1

