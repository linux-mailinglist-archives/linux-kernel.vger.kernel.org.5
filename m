Return-Path: <linux-kernel+bounces-12265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7158B81F21A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E8B22A62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF233495D4;
	Wed, 27 Dec 2023 21:03:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C397481BB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3L-0000tA-SH; Wed, 27 Dec 2023 22:02:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001wFR-BB; Wed, 27 Dec 2023 22:02:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3L-001ZW0-1A;
	Wed, 27 Dec 2023 22:02:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 12/12] mailbox: zynqmp-ipi: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:40 +0100
Message-ID:  <d3343eec618fde99b47b12f792dc415d66b3d7a1.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=2b4lUlitkOljYy3sRlFRPbTFvrd9xaqPFryNUK1ZN6s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDzqFtl2kmovE8iqyRfcBJPoRlc6qiRy4eJR F/jvpWQQLmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ8wAKCRCPgPtYfRL+ TquyB/438vvpPAS3YP4QZzU/Aul2i7Mo5ML2J494dFbYViAl7ltgPfwkDcmca92QlWMEgpAV5VJ 0Yz+wQ4sKk2dWxYStXrFjG9Tniz39LdfLE8wxN7CY6gZ0YYN4kQOYzxQ88/KhvJhCqcsR1L20uu v6y5zySpr2H55+n20BfVMLgJ7NjH7/wmJl2ljlB7J/hDAykGUaA6UN1qk/CYrpcGZiVrr5QeMJE TuwlgdrzNYzx896y0DL9yWRv5PhOM523C9tHqBl1tC4zyWIFTeFR1Lxr+LiEQEcH6Quta3/fz7A z2bSAusqvyIraXRkdrL/bHAFB+Didj4tkwikvO/HJUZX+a3O
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
 drivers/mailbox/zynqmp-ipi-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 7fa533e80dd9..610a92f9c0b2 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -688,19 +688,17 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int zynqmp_ipi_remove(struct platform_device *pdev)
+static void zynqmp_ipi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_ipi_pdata *pdata;
 
 	pdata = platform_get_drvdata(pdev);
 	zynqmp_ipi_free_mboxes(pdata);
-
-	return 0;
 }
 
 static struct platform_driver zynqmp_ipi_driver = {
 	.probe = zynqmp_ipi_probe,
-	.remove = zynqmp_ipi_remove,
+	.remove_new = zynqmp_ipi_remove,
 	.driver = {
 		   .name = "zynqmp-ipi",
 		   .of_match_table = of_match_ptr(zynqmp_ipi_of_match),
-- 
2.43.0


