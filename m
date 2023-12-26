Return-Path: <linux-kernel+bounces-11519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F281E79B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624032830DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC84EB4C;
	Tue, 26 Dec 2023 13:28:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C644EB25
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Td-0006yB-Ok; Tue, 26 Dec 2023 14:28:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Tb-001ePq-CM; Tue, 26 Dec 2023 14:28:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rI7Tc-001FXA-1G;
	Tue, 26 Dec 2023 14:28:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dov Murik <dovmurik@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Cc: kernel@pengutronix.de,
	Gerd Hoffmann <kraxel@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virt: efi_secret: Convert to platform remove callback returning void
Date: Tue, 26 Dec 2023 14:28:02 +0100
Message-ID:  <4a97c8e6996c9c95244715310b57ce5af6ccb1ad.1703596577.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HZawbBGN4ZeoKoNwMa9p/anf72qdPDLDyflq3XBOU2g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlitTiF7Q6LPTBILQzLPFujFV4KCr1bTgHzw6NW OwjGqfEtpaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYrU4gAKCRCPgPtYfRL+ TkBkCACeaJNlG6+8zgivZjAdP0unbo7IwQwQBaiq7ypeRCwzJCDAqGQwyMju5tlx3ArltRsdnqH ZRU1TbnKe14zmg09+lFYV3ix30OhcDomGQvKoVwstNquuHPOkiRZA+8rtGXQzMxtWz8Fz706qqm 8utEqC6IgubmAlTwkETt9DpBgVc+a7dUD1YkS4s8fl04qIJICkNACClyT58nsruiNOdfvQxEpyt 1ANnl1yiWrSVeLMgAcfxISqwosqYib2fhYqG/poy6UmM928lcu5cup2b/rS959RvgmLdMeecgJH S8IJ70jrNPuEXdncItYBFgvHKb+33dZ8/Sgp0t//wPAfZQQm
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
 drivers/virt/coco/efi_secret/efi_secret.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coco/efi_secret/efi_secret.c
index e700a5ef7043..cd29e66b1543 100644
--- a/drivers/virt/coco/efi_secret/efi_secret.c
+++ b/drivers/virt/coco/efi_secret/efi_secret.c
@@ -326,16 +326,15 @@ static int efi_secret_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int efi_secret_remove(struct platform_device *dev)
+static void efi_secret_remove(struct platform_device *dev)
 {
 	efi_secret_securityfs_teardown(dev);
 	efi_secret_unmap_area();
-	return 0;
 }
 
 static struct platform_driver efi_secret_driver = {
 	.probe = efi_secret_probe,
-	.remove = efi_secret_remove,
+	.remove_new = efi_secret_remove,
 	.driver = {
 		.name = "efi_secret",
 	},
-- 
2.43.0


