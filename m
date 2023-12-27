Return-Path: <linux-kernel+bounces-12128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B081F060
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6BC1C213BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42646547;
	Wed, 27 Dec 2023 16:26:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB346430
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-0005A2-NZ; Wed, 27 Dec 2023 17:26:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001tZf-7y; Wed, 27 Dec 2023 17:26:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-001WnB-0q;
	Wed, 27 Dec 2023 17:26:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] firmware: stratix10-rsu: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:32 +0100
Message-ID:  <06df45c697a747cb6543800a4613db6e1f5462b4.1703693980.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6lAFjA5yiszFloMYI5qzwPntohv2cozrx2dH/FwaD6s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA6uGEchezFuteKgpv7rVwlJjuBW7qQizAIb F8CKXZq1nSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQOgAKCRCPgPtYfRL+ TkKAB/wNqVOLInJA6P/jvSiLEyPTYDGW0rx8IlWU5cUStwjy0D3Rje8+JpchpcR5tb9pXUv9t1W ac2YENF8QcnS7ANBmdkC29mfmfyXZMrgdeTjG6lJZNR4Sz1QNDOL9s+pQAmZqS4CWWK+SmMNkEZ ojZkPxPMuIf7WJlS9b3IzQEOyGX1/ewLDgJHzEy2vyFsFMwt6bWP3uIjjluRq56SqTzw950nSuK X8uYMtNSdvir5kAH9fMIWCar4LGKQrBAbfl5t1zRKgFAdy21Fo/AGRIoNzj4Z8aCDaWLmxusYrT c/L/B7MzLUqe+JDZeQaRG1inrUTG9OVlRJGb4E+Zk2xq4lSJ
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
 drivers/firmware/stratix10-rsu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 4f7a7abada48..e20cee9c2d32 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -793,17 +793,16 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stratix10_rsu_remove(struct platform_device *pdev)
+static void stratix10_rsu_remove(struct platform_device *pdev)
 {
 	struct stratix10_rsu_priv *priv = platform_get_drvdata(pdev);
 
 	stratix10_svc_free_channel(priv->chan);
-	return 0;
 }
 
 static struct platform_driver stratix10_rsu_driver = {
 	.probe = stratix10_rsu_probe,
-	.remove = stratix10_rsu_remove,
+	.remove_new = stratix10_rsu_remove,
 	.driver = {
 		.name = "stratix10-rsu",
 		.dev_groups = rsu_groups,
-- 
2.43.0


