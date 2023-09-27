Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934597AFDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjI0IMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjI0ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A4192
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:11:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-00084H-Vo; Wed, 27 Sep 2023 10:10:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-009I7h-W5; Wed, 27 Sep 2023 10:10:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-005BR0-Mr; Wed, 27 Sep 2023 10:10:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 15/27] platform/mellanox: mlxbf-tmfifo: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:28 +0200
Message-Id: <20230927081040.2198742-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CxjrzFzEkM6O7z80cNwT5EXT0bqldk5XDjLUTnuR0Y0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NuMm1KeBgObA5wqP/oMc1QGazphFC29+aTn seP42tD4gqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjbgAKCRCPgPtYfRL+ TjIwB/4xndkYpQ+BvWFG8bVLBguRWGmAkFUJDqI5N74Z2ObmukEKyraFnnmO1r1lJ2ii9Nk2lnn X8s7u/n9zMb41hlp5UfsvtmoW1yN2xj69NFrf0GL+7xtzlEHzdTgkSPQbT1nxfLIOzgfJlQiVzJ iONvs33bN909TfnUw0Ecg1J1X9kLNSCvMM5g97kzdJVqMPzTcvSRy8beyb/rA3yXWrUYVqmz7Yr qYvPnxl5RmgTAHmednfhLnZTYXJNO5jlMQU9IAaNiRwr7LrnXo/wy88P2/Y5IkYrIk31EktNflg tt95oGMo2opbb9SjOW7YpYGafkmHQXbcbFboYwjA23AcBh74
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
 drivers/platform/mellanox/mlxbf-tmfifo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index f3696a54a2bd..69729ba8f505 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1361,13 +1361,11 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 }
 
 /* Device remove function. */
-static int mlxbf_tmfifo_remove(struct platform_device *pdev)
+static void mlxbf_tmfifo_remove(struct platform_device *pdev)
 {
 	struct mlxbf_tmfifo *fifo = platform_get_drvdata(pdev);
 
 	mlxbf_tmfifo_cleanup(fifo);
-
-	return 0;
 }
 
 static const struct acpi_device_id mlxbf_tmfifo_acpi_match[] = {
@@ -1378,7 +1376,7 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_tmfifo_acpi_match);
 
 static struct platform_driver mlxbf_tmfifo_driver = {
 	.probe = mlxbf_tmfifo_probe,
-	.remove = mlxbf_tmfifo_remove,
+	.remove_new = mlxbf_tmfifo_remove,
 	.driver = {
 		.name = "bf-tmfifo",
 		.acpi_match_table = mlxbf_tmfifo_acpi_match,
-- 
2.40.1

