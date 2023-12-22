Return-Path: <linux-kernel+bounces-10096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDC81CFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84780283C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AF3399E;
	Fri, 22 Dec 2023 22:51:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E482EAE2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-0005b4-L1; Fri, 22 Dec 2023 23:51:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoMK-000qv8-4a; Fri, 22 Dec 2023 23:51:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGoML-000FfK-0V;
	Fri, 22 Dec 2023 23:51:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 05/13] irqchip/ls-scfg-msi: Convert to platform remove callback returning void
Date: Fri, 22 Dec 2023 23:50:36 +0100
Message-ID:  <1e7143ca68ff0715e0f954504e750fc92e8c6d80.1703284359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=T1s6nZ+UFXNsHF/tEsghgxMk/3MV7Hfp5CW/lu69Rfk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhhK8rTA2Zo9mskRHVQ0jTz8KMEyB9ljzLNQoN +Gi3RlkZuCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYYSvAAKCRCPgPtYfRL+ Tvv0B/9h2A9o02TYkvoJ0+giW51E20iTqIUiYdsuoDmXjeHFnDtbR299IamdAInCPp+yIfyGuRA VsaWsYzr/A0+PLFJ+woG/PPCNyNhZCGSfjzsKZ6NqujBynxImio642zaas+u4O74nSTkdD8rxKN ASM+shm9aa+jn337GejBExGpd6Kl4wBO8aTCkbKZrwx6D2B4uHrL/YRy6O1m4ZB9JxzkFazRUAh J/UNcGrak8aKpWszKNPOl3M9WJ88sbxhFyd7WGl7r5Br8L1dCMowGOMnr6GcZIfBW9C/C1IfHiu DKM/VlQbxce3QjIqoW9ma9qGJ0k3lJ/hb9Djkz56O04eOzZt
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
 drivers/irqchip/irq-ls-scfg-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 15cf80b46322..0b9b598b206f 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -398,7 +398,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ls_scfg_msi_remove(struct platform_device *pdev)
+static void ls_scfg_msi_remove(struct platform_device *pdev)
 {
 	struct ls_scfg_msi *msi_data = platform_get_drvdata(pdev);
 	int i;
@@ -410,8 +410,6 @@ static int ls_scfg_msi_remove(struct platform_device *pdev)
 	irq_domain_remove(msi_data->parent);
 
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_driver ls_scfg_msi_driver = {
@@ -420,7 +418,7 @@ static struct platform_driver ls_scfg_msi_driver = {
 		.of_match_table = ls_scfg_msi_id,
 	},
 	.probe = ls_scfg_msi_probe,
-	.remove = ls_scfg_msi_remove,
+	.remove_new = ls_scfg_msi_remove,
 };
 
 module_platform_driver(ls_scfg_msi_driver);
-- 
2.42.0


