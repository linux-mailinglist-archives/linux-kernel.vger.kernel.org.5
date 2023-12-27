Return-Path: <linux-kernel+bounces-12127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5F81F061
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68BAB2276B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA046542;
	Wed, 27 Dec 2023 16:26:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5746420
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-0005A4-Te; Wed, 27 Dec 2023 17:26:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001tZj-E6; Wed, 27 Dec 2023 17:26:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-001WnF-1S;
	Wed, 27 Dec 2023 17:26:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] firmware: stratix10-svc: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:33 +0100
Message-ID:  <e574041cdce2e4e69f729dfa726a6d090762cff9.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+Yp1dgFMlCSzMuNAOCbuCl8YKa3LjfoSgbk3TSiz68M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA7vfChqYEofqwrz3YeDW1AnHg6WinguwSG1 /9J4dCFhhKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQOwAKCRCPgPtYfRL+ TuSRB/wO29Z+uGNK7yIFswymPxzBzPy/Z4n037X2YkjRXFiG9xxJbNe1VpNhCwd2OWIyxBs1+5M buXcL8F4FtbajrNFtUm42/UR/aUCI0d8gT2ISJVpzU39YarYpsYq3yXQMuR1Yqt4AUrBGsHq/BV aOhAV1+zQg4csv1YyVhO0ZmN1kWjShQd3uwz7cHmB2NPN4KD3X7OvhxMKx36Pgc3lC8kTN+bxJj Ex9RnteN/1b2ZAoA7D/sj9snV5GibE0Tw17FlC+BOKis6osHRUb+n7de+uqRnYGHVIvfyFCx3NX sOJ2To+9pfzDC3922sjuqSaf6t24I2I+DE8y0NLfubtAFO2A
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
 drivers/firmware/stratix10-svc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index c693da60e9a9..528f37417aea 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1251,7 +1251,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stratix10_svc_drv_remove(struct platform_device *pdev)
+static void stratix10_svc_drv_remove(struct platform_device *pdev)
 {
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
@@ -1267,13 +1267,11 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
 	if (ctrl->genpool)
 		gen_pool_destroy(ctrl->genpool);
 	list_del(&ctrl->node);
-
-	return 0;
 }
 
 static struct platform_driver stratix10_svc_driver = {
 	.probe = stratix10_svc_drv_probe,
-	.remove = stratix10_svc_drv_remove,
+	.remove_new = stratix10_svc_drv_remove,
 	.driver = {
 		.name = "stratix10-svc",
 		.of_match_table = stratix10_svc_drv_match,
-- 
2.43.0


