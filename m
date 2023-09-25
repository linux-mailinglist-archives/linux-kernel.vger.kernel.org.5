Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA187AD520
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjIYJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjIYJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:56:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315931B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-0007m7-H5; Mon, 25 Sep 2023 11:55:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJU-008pyn-IQ; Mon, 25 Sep 2023 11:55:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJU-004dkc-97; Mon, 25 Sep 2023 11:55:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/40] soc/aspeed: aspeed-uart-routing: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:54:55 +0200
Message-Id: <20230925095532.1984344-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Dp6z+QS6f+BYha8PjTOhguNb6MQfm1ovSiqKV9hX2h4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhEDSuLBlvM8gieK9jXohUdapwIH+hiYb4hy aiG/QEwFEGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYRAAKCRCPgPtYfRL+ TlRbB/9A2LAHx8RySGAgbLbJ8MlzL2k1s7rTNPGGbJkPLkmNex9kVNnPPwajEiON0s8s7kTBAKC 1wD/b2E1kUJfaerSMsqbI0eLiRHfQZ8RrNiHt/U1/2mL1sZzE5lhb3qiVq4tfrL+KwX+hzV9Mdr sjOLm2OH6UluKyWV764xCygA01aJMnOTcCqHIZ8SaG/Vh44x755YDukvqAbcQ1ythtTxipk9+2S pbY5C/Es0/D6Vu9xNapnd2BJuqhUJdZzAz8UC89tbqnezgRBgN1cGEY7yA2lNvq1oBYb7LMIXg9 G10Ke9g15LerIWVCr6bhyew3OBir105Uex4voBQqUbQQ28M/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/aspeed/aspeed-uart-routing.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index 3a4c1f28cb34..a2195f062e01 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -565,14 +565,12 @@ static int aspeed_uart_routing_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_uart_routing_remove(struct platform_device *pdev)
+static void aspeed_uart_routing_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct aspeed_uart_routing *uart_routing = platform_get_drvdata(pdev);
 
 	sysfs_remove_group(&dev->kobj, uart_routing->attr_grp);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_uart_routing_table[] = {
@@ -591,7 +589,7 @@ static struct platform_driver aspeed_uart_routing_driver = {
 		.of_match_table = aspeed_uart_routing_table,
 	},
 	.probe = aspeed_uart_routing_probe,
-	.remove = aspeed_uart_routing_remove,
+	.remove_new = aspeed_uart_routing_remove,
 };
 
 module_platform_driver(aspeed_uart_routing_driver);
-- 
2.40.1

