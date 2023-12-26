Return-Path: <linux-kernel+bounces-11520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F41E81E79C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F4C1C20C72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470254F1E4;
	Tue, 26 Dec 2023 13:28:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAE4EB42
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Td-0006yC-Mh; Tue, 26 Dec 2023 14:28:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Tb-001ePt-Ig; Tue, 26 Dec 2023 14:28:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Tc-001FXE-1u;
	Tue, 26 Dec 2023 14:28:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dionna Glaze <dionnaglaze@google.com>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virt: sev-guest: Convert to platform remove callback returning void
Date: Tue, 26 Dec 2023 14:28:03 +0100
Message-ID:  <52826a50250304ab0af14c594009f7b901c2cd31.1703596577.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703596577.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703596577.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Z9aT60piXZDenK8RXiwhRNc00a89v5TJn3r6r5ZOBSU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlitTkkryV046r2EvM0Kp5YL+HNUQO3TXiGbD9l 2tRsZojeIGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYrU5AAKCRCPgPtYfRL+ Tm/uB/wJ+agFq/MhyVjquWnf9zywJi0+vLwwlpPo4h3nxK4oSCRQot7xQzCoKguDi69/UYxgyf2 3PIsn/U3cVNsgs0pmekTtY5A4L2XcGSQiNwKlOIrk5iYTe6JgLfMJY4oCU5MAgEY6gD6VjierdC FHuodU43E7FImEql3jDMCL2BS1MXGJ0dv+JsZJf1It/3p3IoUwhIyS3EWqn4+yL4vW+ll0MkNly 3m/bAYVsl/yzSpnZ2HDkMbity8fpz5D1scLZUsRUZW+wlE7ysbmUCiTEAJOafoumoCAh68sWU5L MQeZzUNk1NNaMMH3LhWg+h10lWzTRw8msJMmjamY3O0Yqzt3
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
 drivers/virt/coco/sev-guest/sev-guest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index bc564adcf499..87f241825bc3 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -994,7 +994,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sev_guest_remove(struct platform_device *pdev)
+static void __exit sev_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 
@@ -1003,8 +1003,6 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 	deinit_crypto(snp_dev->crypto);
 	misc_deregister(&snp_dev->misc);
-
-	return 0;
 }
 
 /*
@@ -1013,7 +1011,7 @@ static int __exit sev_guest_remove(struct platform_device *pdev)
  * with the SEV-SNP support, it is named "sev-guest".
  */
 static struct platform_driver sev_guest_driver = {
-	.remove		= __exit_p(sev_guest_remove),
+	.remove_new	= __exit_p(sev_guest_remove),
 	.driver		= {
 		.name = "sev-guest",
 	},
-- 
2.43.0


