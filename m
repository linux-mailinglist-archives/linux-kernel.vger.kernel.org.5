Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF97A535E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjIRTwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjIRTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:52:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E63129
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:51:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-0003tk-RZ; Mon, 18 Sep 2023 21:51:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-007I9E-DA; Mon, 18 Sep 2023 21:51:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiKHA-002mCs-3W; Mon, 18 Sep 2023 21:51:20 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 14/19] net: mdio: mux-meson-gxl: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 21:50:57 +0200
Message-Id: <20230918195102.1302746-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ozIWasGq3N/xU1iR0Yrnd+TYz54kh5bAZ+sTOn8pRXI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoQ0fJ6ojipVcTwNWKvfLBM8FcQpdBBlYn/S vCT+JOQEtKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqEAAKCRCPgPtYfRL+ TtTSB/4sCglF6vJ5Wp7MSvPiGxMQhwl9gEoGl7FOl2982E1bRen7y+6KM/7EvTSNNCmEUf8rTVE DLjZQnsVNHbz2YtuZ2viSjO/tzDgeMJVIheCkEw9WezNtIkYXMQNCUYt17CX7ph9FvrGDESDLw3 q+QcajXEZ89FjJQt3ZLVSaTl6hzIf4PQC7EbMEbWSp/dat9pN0quna3kzgSmCpW/7CfkH2kxlfy lHtIvEny8INNFJl8GS0dO2UOB1Bm4KKEFtukCYlRl/zPiCgnGaJZ6ikAFqGBhZ+GyIsKb0xL79S W219IQo4hv5EZnfLdrexM/ZuCPg5BvDEG6xeHndx1O/5Qw5K
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
 drivers/net/mdio/mdio-mux-meson-gxl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 76188575ca1f..89554021b5cc 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -140,18 +140,16 @@ static int gxl_mdio_mux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int gxl_mdio_mux_remove(struct platform_device *pdev)
+static void gxl_mdio_mux_remove(struct platform_device *pdev)
 {
 	struct gxl_mdio_mux *priv = platform_get_drvdata(pdev);
 
 	mdio_mux_uninit(priv->mux_handle);
-
-	return 0;
 }
 
 static struct platform_driver gxl_mdio_mux_driver = {
 	.probe		= gxl_mdio_mux_probe,
-	.remove		= gxl_mdio_mux_remove,
+	.remove_new	= gxl_mdio_mux_remove,
 	.driver		= {
 		.name	= "gxl-mdio-mux",
 		.of_match_table = gxl_mdio_mux_match,
-- 
2.40.1

