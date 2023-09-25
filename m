Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C57AD4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjIYJzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:55:45 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4DAA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:55:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-0007n8-Ri; Mon, 25 Sep 2023 11:55:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-008pyz-Ei; Mon, 25 Sep 2023 11:55:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qkiJV-004dks-5Z; Mon, 25 Sep 2023 11:55:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 08/40] soc/fujitsu: a64fx-diag: Convert to platform remove callback returning void
Date:   Mon, 25 Sep 2023 11:54:59 +0200
Message-Id: <20230925095532.1984344-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=saXqsLDHKnHalVQxew/MdBsH6YDXz3ImTwJq8YFGrKw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEVhIlQMyzfP/6okjPblsvnLY5ljbi40E89BdP TdBef3YVZSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRFYSAAKCRCPgPtYfRL+ TuRZB/9CAMDp4N6XKzi15yXUJ/0r+i6UjQAowApyp9OWmLwTPlhqHOLe5KtbxMmkeJpAYcOqxt+ UjEinBWWG3DXy36ZISIk9ggwuKVIQunoOXY6Cp9FH1dDUacIjWGDi4FgoIJ9c+s2Y7eD6EVxd/p bGcE4jDmYkpXwLA5I//CvB1LnXgkBAqImvd+TVqoW+OuexRkt+xF87LW71Qni39hupQi7Zq9fO8 YxkBLLxX/NqUuFb7km3fR+8l51WEXfVlLFOrWBe5DtPjHjHNbQtGV7mLC9LRGxyVUhbWGGYemCS j+g54ccFCLwqUBA+ObaRwRVKaPcAbLZts80N4Etx27+/tLRr
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
 drivers/soc/fujitsu/a64fx-diag.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fujitsu/a64fx-diag.c b/drivers/soc/fujitsu/a64fx-diag.c
index 524fbfeb94e3..330901893577 100644
--- a/drivers/soc/fujitsu/a64fx-diag.c
+++ b/drivers/soc/fujitsu/a64fx-diag.c
@@ -116,7 +116,7 @@ static int a64fx_diag_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int a64fx_diag_remove(struct platform_device *pdev)
+static void a64fx_diag_remove(struct platform_device *pdev)
 {
 	struct a64fx_diag_priv *priv = platform_get_drvdata(pdev);
 
@@ -127,8 +127,6 @@ static int a64fx_diag_remove(struct platform_device *pdev)
 		free_nmi(priv->irq, NULL);
 	else
 		free_irq(priv->irq, NULL);
-
-	return 0;
 }
 
 static const struct acpi_device_id a64fx_diag_acpi_match[] = {
@@ -144,7 +142,7 @@ static struct platform_driver a64fx_diag_driver = {
 		.acpi_match_table = ACPI_PTR(a64fx_diag_acpi_match),
 	},
 	.probe = a64fx_diag_probe,
-	.remove = a64fx_diag_remove,
+	.remove_new = a64fx_diag_remove,
 };
 
 module_platform_driver(a64fx_diag_driver);
-- 
2.40.1

