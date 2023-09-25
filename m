Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3C7AD501
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjIYJ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIYJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE713E8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJb-00088E-Ah; Mon, 25 Sep 2023 11:55:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-008q0h-TZ; Mon, 25 Sep 2023 11:55:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJa-004dmT-KN; Mon, 25 Sep 2023 11:55:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 33/40] soc/ti: k3-ringacc: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:24 +0200
Message-Id: <20230925095532.1984344-34-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hlwfHmXrVPpoUA6HQvorzbxZ+wVHWipEdQuyoYdBV0k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhlVFfuEe2s8yzgLrMDIqb7suMbNJw8ygZ86 nDZkEJWesOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYZQAKCRCPgPtYfRL+ TpUEB/9jnSCqzUu3P1MFhGYE6gKOTj94efDqWml5vzmoAJQUEYcKuuGw75sXiVQOo2J4JRcN1IM G/0Q4ApYlUzZkqGbV3MvgrjnM9O0YIF4zWK3+rlpJ7SQT9xo/dAnZhzHmbiwgh2rn9HviFvUFJ1 v8u6Swskv5DobZsmnb02DQNreSG59l/CKndoFyOcjuGRhugM7u8TNJkSgquN9OAENQqbPQXfnPm 8D/CfD+Hzzs3kGADN86pEEWdJw2G7Pzpm8oyR8k/zXaF5GzQVqrC5DvhQmBLbw/H4q+Llgq8vxn CxjbnyIrHf1VgypDRhbGIPre/2Uh2RihkQ47ToXk4HDWrXly
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
 drivers/soc/ti/k3-ringacc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 148f54d9691d..fd4251d75935 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1551,19 +1551,18 @@ static int k3_ringacc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int k3_ringacc_remove(struct platform_device *pdev)
+static void k3_ringacc_remove(struct platform_device *pdev)
 {
 	struct k3_ringacc *ringacc = dev_get_drvdata(&pdev->dev);
 
 	mutex_lock(&k3_ringacc_list_lock);
 	list_del(&ringacc->list);
 	mutex_unlock(&k3_ringacc_list_lock);
-	return 0;
 }
 
 static struct platform_driver k3_ringacc_driver = {
 	.probe		= k3_ringacc_probe,
-	.remove		= k3_ringacc_remove,
+	.remove_new	= k3_ringacc_remove,
 	.driver		= {
 		.name	= "k3-ringacc",
 		.of_match_table = k3_ringacc_of_match,
-- 
2.40.1

