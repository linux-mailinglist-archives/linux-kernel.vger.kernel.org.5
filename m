Return-Path: <linux-kernel+bounces-12133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E381F068
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C01B22BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DC8482ED;
	Wed, 27 Dec 2023 16:26:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4D47F41
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWk0-00059y-0b; Wed, 27 Dec 2023 17:26:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001tZc-14; Wed, 27 Dec 2023 17:26:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-001Wn5-08;
	Wed, 27 Dec 2023 17:26:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>
Cc: kernel@pengutronix.de,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] firmware: raspberrypi: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:31 +0100
Message-ID:  <5df31ef3c069f45634631c9c639bbb60ab1d4798.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8OnFnV9+Q+XjHGFocc6jyNJphVm9oGZbvop0yAJNf9o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA5eCGsDsplPuScmklfE3nyikx3e0+FJY3l8 BL3mj5KWsuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQOQAKCRCPgPtYfRL+ TrYJB/wKMxZ0dVeqePWzIe13JUFhLVI4QUjz0EFQb5Rn475cfqK+B7i3dx0wcVewGUkDahlovG2 tdfvhL//8Gt6HvqFq2H+aCEBbKA4BHa48gkArRdq6xQEZDt5z0rQld5osnTbW0IDOdPoYaNuxo5 mkLOex1INSKouwkConwu8R0j9KDoV2neCB/vd0WEhYl0KpkvNgNdCBWBvMxmtoqSGdvAjb9+zb7 qwYQ7p93oWEIF4p9nBNulGEjF14nU7UlVrhmDf7OSOreQ02WFGTaYPacVKdTH9dxk/m5za93xoD 3zuzyc/kgU28KdvmxsL8G2Y1/r2et4CQOAkdyHhWt/k34anG
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
 drivers/firmware/raspberrypi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 4cd290a60fba..322aada20f74 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -317,7 +317,7 @@ static void rpi_firmware_shutdown(struct platform_device *pdev)
 	rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_REBOOT, NULL, 0);
 }
 
-static int rpi_firmware_remove(struct platform_device *pdev)
+static void rpi_firmware_remove(struct platform_device *pdev)
 {
 	struct rpi_firmware *fw = platform_get_drvdata(pdev);
 
@@ -327,8 +327,6 @@ static int rpi_firmware_remove(struct platform_device *pdev)
 	rpi_clk = NULL;
 
 	rpi_firmware_put(fw);
-
-	return 0;
 }
 
 static const struct of_device_id rpi_firmware_of_match[] = {
@@ -406,7 +404,7 @@ static struct platform_driver rpi_firmware_driver = {
 	},
 	.probe		= rpi_firmware_probe,
 	.shutdown	= rpi_firmware_shutdown,
-	.remove		= rpi_firmware_remove,
+	.remove_new	= rpi_firmware_remove,
 };
 module_platform_driver(rpi_firmware_driver);
 
-- 
2.43.0


