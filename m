Return-Path: <linux-kernel+bounces-12261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974981F215
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902CB1C226C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B03482E2;
	Wed, 27 Dec 2023 21:03:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684B47F78
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-0000mE-6J; Wed, 27 Dec 2023 22:02:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3H-001wEo-Md; Wed, 27 Dec 2023 22:02:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3I-001ZVM-2I;
	Wed, 27 Dec 2023 22:02:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 02/12] mailbox: bcm-pdc: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:30 +0100
Message-ID:  <44de4bb380b6af0be33eaf8cf96d767ed7608a36.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jveChMb3h44uByjcawnGUpyLJqMmp76ass0nnH1hY1A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDn9BM0ryFt/JmZOCM418wpd3Zmu3v/321/P Jf/1Sq+17qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ5wAKCRCPgPtYfRL+ TnbMB/4+AiEoxUh4Rj3VweDs+RMtUOGfU48l2YhH2whN8mjFzIAIUrGWD1FPU1pWsVgejCeGcur ++/ur4Y+cw1CSQX1UXjG4Bh6GtrMxxHxX9c/j0ElXYRi3MkKKZDL7j60owkY2jJiTOZo86hMLie osli7TD/G2Wc9455gUr+hYc2xeMT5i/ZpHCakvPGNXDQ9tb+42b3h9qyWzsmcvyKgW8Xk10+yB4 4ccmNxkf6rg7U/kZnsZM6sxNiGryMiNuqdUlgq3XMwtSkJBAiwjbAV98aZTPFK8aL+yU/3dAOvs n/KCoRFLdmXgVVqQMxv/hI2lED7vfaXec4jFRRa3dGLaJX39
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
 drivers/mailbox/bcm-pdc-mailbox.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 778faeced81e..1768d3d5aaa0 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1605,7 +1605,7 @@ static int pdc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int pdc_remove(struct platform_device *pdev)
+static void pdc_remove(struct platform_device *pdev)
 {
 	struct pdc_state *pdcs = platform_get_drvdata(pdev);
 
@@ -1617,12 +1617,11 @@ static int pdc_remove(struct platform_device *pdev)
 
 	dma_pool_destroy(pdcs->rx_buf_pool);
 	dma_pool_destroy(pdcs->ring_pool);
-	return 0;
 }
 
 static struct platform_driver pdc_mbox_driver = {
 	.probe = pdc_probe,
-	.remove = pdc_remove,
+	.remove_new = pdc_remove,
 	.driver = {
 		   .name = "brcm-iproc-pdc-mbox",
 		   .of_match_table = pdc_mbox_of_match,
-- 
2.43.0


