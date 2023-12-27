Return-Path: <linux-kernel+bounces-12262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBE81F214
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0135E1F22FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC1482E1;
	Wed, 27 Dec 2023 21:03:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681147F53
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-0000m3-U9; Wed, 27 Dec 2023 22:02:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3H-001wEl-Dx; Wed, 27 Dec 2023 22:02:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-001ZVH-1S;
	Wed, 27 Dec 2023 22:02:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 01/12] mailbox: bcm-flexrm: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:29 +0100
Message-ID:  <0350a37650c27dddd81514627f51ce8278979428.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FFehYL1Gn3qYjpBCEFKip15UQ3w2S8PSDK17hMiB7oo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDmW5WaRVDaTExhDJ2dHaJ0e/+Dtkte2R0Sk UcrLi9+EYeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ5gAKCRCPgPtYfRL+ TgTTB/sF8nPHGkF89/EAWpe4KhSmfHU92qIjexhsoHCpltQJKdVDYAWXYP1cLRYgyM8FBlGuSDy pgTiX/bzMpQpWvlafPN6DdE0nDqA0ix7J5HFh3V4IPNDCriCjDG2l19h3IBz80p+poBdNgpXmuA 69mz/ep4fooRJRQVLdmOI4WnyEktgWjdpf3mYij6lIdCWFXYZvKuRjCfpnUeDLjjUOKneVkQ5gc 8sJe/aIFhWSfTrS5dChE9W4MTSHD0FvJw/K2Cmh/oJIkUSCjP/qTQ0RDzXpAv5wQkkwU3hwOErQ F+dNjjSzrJfg5dhJtcadg8SySzyYwx73I3ZO2hm1V8jT+zxE
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
 drivers/mailbox/bcm-flexrm-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index a2b8839d4e7c..e3e28a4f7d01 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1650,7 +1650,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int flexrm_mbox_remove(struct platform_device *pdev)
+static void flexrm_mbox_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
@@ -1661,8 +1661,6 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
 
 	dma_pool_destroy(mbox->cmpl_pool);
 	dma_pool_destroy(mbox->bd_pool);
-
-	return 0;
 }
 
 static const struct of_device_id flexrm_mbox_of_match[] = {
@@ -1677,7 +1675,7 @@ static struct platform_driver flexrm_mbox_driver = {
 		.of_match_table = flexrm_mbox_of_match,
 	},
 	.probe		= flexrm_mbox_probe,
-	.remove		= flexrm_mbox_remove,
+	.remove_new	= flexrm_mbox_remove,
 };
 module_platform_driver(flexrm_mbox_driver);
 
-- 
2.43.0


