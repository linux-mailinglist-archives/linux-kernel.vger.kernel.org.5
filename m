Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622B7AFDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjI0IMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239ACE9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:11:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdD-0008AS-W5; Wed, 27 Sep 2023 10:10:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdD-009I8R-Dx; Wed, 27 Sep 2023 10:10:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdD-005BRi-4g; Wed, 27 Sep 2023 10:10:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 26/27] platform/x86/siemens: simatic-ipc-batt-elkhartlake: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:39 +0200
Message-Id: <20230927081040.2198742-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=atKDlgH5RJpKWqL6VwqbwRwC4qoK6wHDECsivGMaAKw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+N7B83ZmEZGbV1cN3PT09dXprrKhuV4blhZP s19OFSZpM2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjewAKCRCPgPtYfRL+ TslTB/47Z6/d9rro1h89YQz4mgs2/rhQEbsr8CzoF1mhAUWVk3qJxwDREL+8WcUcRH1Hvkuxous E/FCzpKFOFHlKjZkeDgSvFZy0WUr9Ci96pIS/IR5zqzc3KmhVCgCgmKa+lwc6x1LKI2JAjXanvL Jk7xNsvu32oQsC2rOhUiktn3F1FDmK+/4WV4xLLZY7X16HdDnJlh5ykzy0rwMzveHzyZ+XYx1yo 5FHvjvhg/nBFcH8mcuMtJ9emPl6D+Puz2cJXKQvkcpJdAyJyYgwyfnOtwDwxr2g1vjz/DTZ9Yt/ /XecXtw7nkfFLete3YlLL/bF1v/CHvu8jYIlH/+HAGsAKntZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
index 9e08c659f27d..a7676f224075 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt-elkhartlake.c
@@ -25,11 +25,9 @@ static struct gpiod_lookup_table simatic_ipc_batt_gpio_table_bx_21a = {
 	},
 };
 
-static int simatic_ipc_batt_elkhartlake_remove(struct platform_device *pdev)
+static void simatic_ipc_batt_elkhartlake_remove(struct platform_device *pdev)
 {
 	simatic_ipc_batt_remove(pdev, &simatic_ipc_batt_gpio_table_bx_21a);
-
-	return 0;
 }
 
 static int simatic_ipc_batt_elkhartlake_probe(struct platform_device *pdev)
@@ -39,7 +37,7 @@ static int simatic_ipc_batt_elkhartlake_probe(struct platform_device *pdev)
 
 static struct platform_driver simatic_ipc_batt_driver = {
 	.probe = simatic_ipc_batt_elkhartlake_probe,
-	.remove = simatic_ipc_batt_elkhartlake_remove,
+	.remove_new = simatic_ipc_batt_elkhartlake_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
-- 
2.40.1

