Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A97AD4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjIYJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIYJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BC0FB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJZ-0007ww-A3; Mon, 25 Sep 2023 11:55:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-008pzc-Er; Mon, 25 Sep 2023 11:55:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJX-004dlR-5c; Mon, 25 Sep 2023 11:55:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 17/40] soc/pxa: ssp: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:55:08 +0200
Message-Id: <20230925095532.1984344-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7RMXK7o5MKcvP26bqwpTH0k5DtjEeMQoS+T8l69yDkY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTBiODpyie7BT4bBoj6Pj3yb9LxfxLf3ZYoMxk6KuY3c YZFvr/YyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEVgqz/y8UOHdhVtlOtwlt Va/K9v8zcBeYrvYpM12O885e1erSj5y9wuHmKqZ1rvHBG4S/VAQ1ZtywteTZeGdWnXfpyokzZ5w S/8/IbBvodSS7q8E8kDVr/Z9Xpg+jsjk/rUwSbPyooKUQqs6zunKLs4bdu/lffm54ZbunaVKi97 mlW17nZ9TPEbvT+a3y//3F/87czCwvvpS8+/iOOMmkqPmsez9Klbc+kDUyKz4gZpLHmZH1QJVNw eK7Y9zbDWpOXW31WtZq+WX2UyJmzVrapOcfa3P0O39UTZzqqqu/1vcwaAifjZAV9t6ywcPXZu60 nmhZLy2GxYIe0tVitReYvC/u+9FwLbjq4HvncqDiNAA=
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
To:     unlisted-recipients:; (no To-header on input)
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
 drivers/soc/pxa/ssp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
index bd029e838241..a1e8a07f7275 100644
--- a/drivers/soc/pxa/ssp.c
+++ b/drivers/soc/pxa/ssp.c
@@ -176,15 +176,13 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pxa_ssp_remove(struct platform_device *pdev)
+static void pxa_ssp_remove(struct platform_device *pdev)
 {
 	struct ssp_device *ssp = platform_get_drvdata(pdev);
 
 	mutex_lock(&ssp_lock);
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
-
-	return 0;
 }
 
 static const struct platform_device_id ssp_id_table[] = {
@@ -199,7 +197,7 @@ static const struct platform_device_id ssp_id_table[] = {
 
 static struct platform_driver pxa_ssp_driver = {
 	.probe		= pxa_ssp_probe,
-	.remove		= pxa_ssp_remove,
+	.remove_new	= pxa_ssp_remove,
 	.driver		= {
 		.name		= "pxa2xx-ssp",
 		.of_match_table	= of_match_ptr(pxa_ssp_of_ids),
-- 
2.40.1

