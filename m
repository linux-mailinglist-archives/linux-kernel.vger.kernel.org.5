Return-Path: <linux-kernel+bounces-12259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118281F212
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4396D1C22699
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039B481A4;
	Wed, 27 Dec 2023 21:03:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547A47F79
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-0000mc-Nc; Wed, 27 Dec 2023 22:02:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-001wEw-7j; Wed, 27 Dec 2023 22:02:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001ZVU-0m;
	Wed, 27 Dec 2023 22:02:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 04/12] mailbox: mailbox-test: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:32 +0100
Message-ID:  <919a9e77958e3a9fee3e473fd714c4add2991b33.1703710628.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=2Acds6dO5piUOAVFehlpJWz3DbSbQSTHBdOgG/XhSGc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDqNnoboat7qdmB2aD1OkkF8K0e5IDZbr7Lb NgGvZfkKPKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ6gAKCRCPgPtYfRL+ TrtbB/kBNSNYr6CiYZ5+Iqb+3kPQ5dPw3J3J17sxWCdHG2fK1X3m7VoIK6/E2QiRHQDMjthjFdg 1HDhwGWDkklLUXI5okyKPtdeWPHixZXx1joX8U9Zfm3AqmUlPen+bl6HypkPDENKqwUn9Z78Cwp skP7eDM0aCZ3zWk2G5u4rY6GlO7vtvTJLQTAADtS2ein/bi2V3KJixCQ96ss87nXXE72jR4QGyS /Gu0AuWDVay78xUapUcBsladtb7IzUNGmn4Y1PnjTwThtNx6ZtRiLf/+IeJFK9HUyYPGLJP9yTi z0dKoLmKwQOCsR+jxXlUMd8NBSZDrxR/Svh1b35sSKK+DUvE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

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
 drivers/mailbox/mailbox-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 22d6018ceec3..3386b4e72551 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -418,7 +418,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mbox_test_remove(struct platform_device *pdev)
+static void mbox_test_remove(struct platform_device *pdev)
 {
 	struct mbox_test_device *tdev = platform_get_drvdata(pdev);
 
@@ -428,8 +428,6 @@ static int mbox_test_remove(struct platform_device *pdev)
 		mbox_free_channel(tdev->tx_channel);
 	if (tdev->rx_channel)
 		mbox_free_channel(tdev->rx_channel);
-
-	return 0;
 }
 
 static const struct of_device_id mbox_test_match[] = {
@@ -444,7 +442,7 @@ static struct platform_driver mbox_test_driver = {
 		.of_match_table = mbox_test_match,
 	},
 	.probe  = mbox_test_probe,
-	.remove = mbox_test_remove,
+	.remove_new = mbox_test_remove,
 };
 module_platform_driver(mbox_test_driver);
 
-- 
2.43.0


