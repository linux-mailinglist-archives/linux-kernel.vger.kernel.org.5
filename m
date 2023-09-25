Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1A7AD502
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjIYJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIYJzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A937CFE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJc-0008AT-8C; Mon, 25 Sep 2023 11:55:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-008q0x-Rd; Mon, 25 Sep 2023 11:55:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-004dmk-Gk; Mon, 25 Sep 2023 11:55:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 37/40] soc/ti: pruss: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:28 +0200
Message-Id: <20230925095532.1984344-38-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=c709ql2KZbhU/Nl8vVPOXcOtp/pbM4UUu61jct04VQs=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTBiMyND1a/8WSSXy+oJMj0pyN86clHNreORvveyv9cl /7uhH5KJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATmSnJ/k/HVTDCsJ2Zf9Ms mbz+CWt7NYPNpnZc1wlNS7rqNsdUeo9itffT18sDuj3DrzsWdspdirms+DQqvuhM32kVBW0ZMdd v33fVM9xu8dO9WDXLJ2lh1gqf3gOmER3/Df3s221rqkUEJBUytxWKvvjXJvLspN1fxsL3JWr7bb 4IF+iLz5itFf9lo+nL3ikrTsulil3U25ihd3pTo0UcSyXDj9yjG2candDx1quobVV/FlDCf7ggN OGndndt9fVTxnbhqXVWn9yPrJc+yv9+655fk1vlp35O4rjQ+mKD87L3Znbp73/f/T+L/ceikrhY ox82D5fssZV9sUX106eQyLdW864JBdxWKntx/E79QWkWAA==
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
 drivers/soc/ti/pruss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index f49f8492dde5..24a42e0b645c 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -565,7 +565,7 @@ static int pruss_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pruss_remove(struct platform_device *pdev)
+static void pruss_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
@@ -573,8 +573,6 @@ static int pruss_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 /* instance-specific driver private data */
@@ -610,7 +608,7 @@ static struct platform_driver pruss_driver = {
 		.of_match_table = pruss_of_match,
 	},
 	.probe  = pruss_probe,
-	.remove = pruss_remove,
+	.remove_new = pruss_remove,
 };
 module_platform_driver(pruss_driver);
 
-- 
2.40.1

