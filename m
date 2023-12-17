Return-Path: <linux-kernel+bounces-2642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C71815FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308D21C21EC2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62888481D5;
	Sun, 17 Dec 2023 14:30:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855646445
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-0006W7-5x; Sun, 17 Dec 2023 15:30:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-00GUhV-Lt; Sun, 17 Dec 2023 15:30:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9d-004hzL-CW; Sun, 17 Dec 2023 15:30:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] memory: omap-gpmc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:34 +0100
Message-ID:  <019d9dc31af9b30a6b675fec219e64b667475efd.1702822744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=U5CGeCdz6QSAvrFQlhj98hj1wRRaTXzuJdwPMd0OWnY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXOgeJ/I+MLCCzaRR2S0hAuUidKX2H7fnV+l jyp10wIe56JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FzgAKCRCPgPtYfRL+ Th6oCACtPZCoIo+uH4FSx41yvLOR8wWQbzWGm9FpXYZXVzaWiiGYx6ommIRZqHHnhfz8L/bsbOJ /L6QVHQUGm+FaQFwgHndv3F0h30XiAbDgT7+z+7WSo8fntdsBhUJPgfjcI4TNt4Avcjt0cMf36j nJ23HdfmZqiQm3psRAgSdfkGn8FjYu+6KeeBqC/1asWM0dHPj041s24BJ52kZfif8R8fwE0VWbr h+/zdtOCNgWAE8TndXGCrkz9FbNpD0d0EMBpUnkMZfDmK+4qKVIqD/Cj7HuoQc6cJLsL+4reqzV UilU2v/he3wH8BxMi2LOUcFhFqg6cbMvAF0VVyIeUucdVK11
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
 drivers/memory/omap-gpmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index d78f73db37c8..80d038884207 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2690,7 +2690,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int gpmc_remove(struct platform_device *pdev)
+static void gpmc_remove(struct platform_device *pdev)
 {
 	int i;
 	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
@@ -2702,8 +2702,6 @@ static int gpmc_remove(struct platform_device *pdev)
 	gpmc_mem_exit();
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2747,7 +2745,7 @@ MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
 
 static struct platform_driver gpmc_driver = {
 	.probe		= gpmc_probe,
-	.remove		= gpmc_remove,
+	.remove_new	= gpmc_remove,
 	.driver		= {
 		.name	= DEVICE_NAME,
 		.of_match_table = of_match_ptr(gpmc_dt_ids),
-- 
2.42.0


