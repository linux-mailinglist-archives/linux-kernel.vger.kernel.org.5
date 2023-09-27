Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344277AFDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjI0ILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjI0IK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:10:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD512A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:10:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-00083Z-EP; Wed, 27 Sep 2023 10:10:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-009I7a-Jm; Wed, 27 Sep 2023 10:10:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdA-005BQs-Am; Wed, 27 Sep 2023 10:10:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 13/27] platform/goldfish: goldfish_pipe: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:26 +0200
Message-Id: <20230927081040.2198742-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QeacHySmLaSZwS4xv2VjUTNG5lxJx5Ahhg2kUai976k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+NskI5magjLJvAzI649X2BCIEtkDSx9kzDxw Pked5WH/TyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjbAAKCRCPgPtYfRL+ TvS7B/9uwhB8OnSp/LX4SLmiltKqjgHDbHyxd2lEVp/8ay4EsFwAYgYIp4sJ86zBenBFAeUT1hv mTnubm0CozLwHWyTaXvPGsK6QAvp+3WrW0eJQzhDucSxa+fO0RC2lgrnMsiW4GBFUCX2pCo9FGA gaakqKVWyZQsuVRYK2heRKEf25FYOmEwpImWPA4r5/vfIo9L55xjKsPkTaZ87os0gRtLBg4/vpX vdd1TjzXFA57MmvqXUZm9WgtmqCMUhfVKvF7tQSiuf/pOZ9GuRD1gamadVpDtMc8bFch9dlCREp 6+b7wmy1iBp3BnMnNyRrghmIM6A6n29geO9QpQGdOPJzEXGN
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/platform/goldfish/goldfish_pipe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 7737d56191d7..061aa9647c19 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -915,12 +915,11 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	return goldfish_pipe_device_init(pdev, dev);
 }
 
-static int goldfish_pipe_remove(struct platform_device *pdev)
+static void goldfish_pipe_remove(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
 
 	goldfish_pipe_device_deinit(pdev, dev);
-	return 0;
 }
 
 static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
@@ -937,7 +936,7 @@ MODULE_DEVICE_TABLE(of, goldfish_pipe_of_match);
 
 static struct platform_driver goldfish_pipe_driver = {
 	.probe = goldfish_pipe_probe,
-	.remove = goldfish_pipe_remove,
+	.remove_new = goldfish_pipe_remove,
 	.driver = {
 		.name = "goldfish_pipe",
 		.of_match_table = goldfish_pipe_of_match,
-- 
2.40.1

