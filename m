Return-Path: <linux-kernel+bounces-12267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCA81F21D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E91C226A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98649F75;
	Wed, 27 Dec 2023 21:03:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0021481A8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3L-0000sW-8N; Wed, 27 Dec 2023 22:02:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001wFF-OL; Wed, 27 Dec 2023 22:02:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001ZVo-2S;
	Wed, 27 Dec 2023 22:02:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 09/12] mailbox: stm32-ipcc: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:37 +0100
Message-ID:  <3189b81c29e185e76e87a150051e5e73047b76ea.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3bDUjGjP7wzxKyoJxgukH0hU9Cj6FBrYyYL2xQFaSUY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDvHB8PRK2f+cN/dTeaPhGdhFq1chpZPlaNJ Nus1qGLwfuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ7wAKCRCPgPtYfRL+ TnzaCACaIsH1woq68S42H2f/RVHXYiWQHTDmhEhk9nRfPyPMnH/LTY8QR4960J3vS3E4YlzpXD4 e8Fb9Pdn1otwdBaCiCKQ+jFxD5fN3gs8DxO1augzsYhBFFAbiOSlc9dTXbVwVSuISPIxv2eoz5S NBKQsfEydrR5UQymLJYcXo8qJSBg9XGyLpacTXFoTAx1ip1ShhIXCruPrt6bD3uWj3E7NQW8Fre oqDT36vI+j2waULDBWz24J47yHOTscUVw6D5s07bXWglA8P7CAsV/OSDSI94I0AVfnQLBr0rkzi /l1jNsQFzbe93BCZEb8sEpXrBKcYUp6KjT19THwhl5UaysP0
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
 drivers/mailbox/stm32-ipcc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 4ad3653f3866..1442f275782b 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -331,7 +331,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_ipcc_remove(struct platform_device *pdev)
+static void stm32_ipcc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
@@ -339,8 +339,6 @@ static int stm32_ipcc_remove(struct platform_device *pdev)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
 	device_set_wakeup_capable(dev, false);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -381,7 +379,7 @@ static struct platform_driver stm32_ipcc_driver = {
 		.of_match_table = stm32_ipcc_of_match,
 	},
 	.probe		= stm32_ipcc_probe,
-	.remove		= stm32_ipcc_remove,
+	.remove_new	= stm32_ipcc_remove,
 };
 
 module_platform_driver(stm32_ipcc_driver);
-- 
2.43.0


