Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FB7AFDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjI0ILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjI0ILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B35B1BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-0007w7-Nv; Wed, 27 Sep 2023 10:10:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-009I7D-Ah; Wed, 27 Sep 2023 10:10:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd9-005BQT-1m; Wed, 27 Sep 2023 10:10:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/27] platform/chrome: cros_typec_switch: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:20 +0200
Message-Id: <20230927081040.2198742-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=apwdajEkBtcz1JyrpEsZ4Sy0crzZ/8cLvtcXTlSY44Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NlOZvTbEbzfEvNTwTHvGtIkJoSZGWTHt9rb yc/d3LGIRKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjZQAKCRCPgPtYfRL+ TlUXB/4l0vgezcHrQ+T7WnUcbW5ahMqeimC7Cp1K+nnAcKjZnaC7Z0kznQrT4O5kdE9fdPJIblD FovOU+zgMs/AMd4bv9tFYBwwgVK8TWFsBSILh/h2hU1YJ0DBtRtYvWv3IjQPvTjSj9PLpVbUHZx /98pDno9jyifGThEAoB16/yLQMDK5JDN6qlCSTtLuTDmZf09dbsBpTd6O4K+P5oucwJOcithevI m7x2Wi8fY8Eqw8w3rlbvPiY7vfJz1b0rfcr3hat1yTn4BNhluGTMq1fuXdH2lfmYe49mKMXdCIA YjBnlei/N6jb6saikr4H+Sorw24Kp40LRS429Q54rpypTedD
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/platform/chrome/cros_typec_switch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 0eefdcf14d63..07a19386dc4e 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -297,12 +297,11 @@ static int cros_typec_switch_probe(struct platform_device *pdev)
 	return cros_typec_register_switches(sdata);
 }
 
-static int cros_typec_switch_remove(struct platform_device *pdev)
+static void cros_typec_switch_remove(struct platform_device *pdev)
 {
 	struct cros_typec_switch_data *sdata = platform_get_drvdata(pdev);
 
 	cros_typec_unregister_switches(sdata);
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -319,7 +318,7 @@ static struct platform_driver cros_typec_switch_driver = {
 		.acpi_match_table = ACPI_PTR(cros_typec_switch_acpi_id),
 	},
 	.probe = cros_typec_switch_probe,
-	.remove = cros_typec_switch_remove,
+	.remove_new = cros_typec_switch_remove,
 };
 
 module_platform_driver(cros_typec_switch_driver);
-- 
2.40.1

