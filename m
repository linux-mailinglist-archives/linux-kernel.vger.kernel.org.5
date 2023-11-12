Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9573E7E8D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjKLAAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjKLAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:00:42 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2A71991
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:00:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1xu0-00012C-62; Sun, 12 Nov 2023 01:00:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1xtz-008Mi1-EU; Sun, 12 Nov 2023 01:00:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1xtz-0000yo-5O; Sun, 12 Nov 2023 01:00:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH RESEND] platform/goldfish: goldfish_pipe: Convert to platform remove callback returning void
Date:   Sun, 12 Nov 2023 01:00:30 +0100
Message-ID: <20231112000029.151117-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=aOJ8qiepFTNPlUt0Vzbc7ieu9ixr9dvNvLgionZx45o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlUBWdlscZNB7DWPiDOYFsbgIJo20jGwfXcFBu5 qWNKVyGjbyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVAVnQAKCRCPgPtYfRL+ TkRFB/9Q8hFPnlPkI8ubGbFObHpVy176Qby2SURD2dwsy83Xrj6Hx+39gJeKVzzjOU9QJPmU3jn 264AhfFLOnSX1bD4jO7tcQZvdeMPCThN+te6evQiQzhhP3uahXJHn4HyTE3JA5ISC5VwoWaHBgp xp19NH/Tr8edBFSXjt4IcOsvw+4pt3zkH14HD2FyV5xzoMlnAuqERS33WD25cVVi7knbnK7UJ/B lP+lFKNzIk1LtrVRvfApHGAJfabJNuUj3Ra5/NKVqwzHjMFWUOBokv+Tuz2rdys1PviY7ObDIfV 4fsiVxLk3NMrYACW6qerIJVITMpXTdmxnVdSscntxN5q7C+1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Hello,

this patch was part for a series containing 27 patches and the only one
that wasn't applied. Probably it was missed because it was only Cc:d to
lkml and had no other recipient.

Greg, you were the one accepting patches to this driver since 2021 (all
two! :-), could you please pick up this patch, too?

Best regards
Uwe

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

base-commit: 3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
-- 
2.42.0

