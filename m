Return-Path: <linux-kernel+bounces-12266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A081F21C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE47C283F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9749F6D;
	Wed, 27 Dec 2023 21:03:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3525481B3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3L-0000t1-Me; Wed, 27 Dec 2023 22:02:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001wFN-4t; Wed, 27 Dec 2023 22:02:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3L-001ZVw-0V;
	Wed, 27 Dec 2023 22:02:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 11/12] mailbox: tegra-hsp: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:39 +0100
Message-ID:  <8e00bbc23e1115d9ff185d4b98c6d764607036df.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=PYLOV0x2mjDrqYc2WOt4MZWPAGaq8meNv350E++Xqz4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDxKf9dkG1I03uOMN9mSF6cbRm7XcpAFwVg0 hQObdda4w2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ8QAKCRCPgPtYfRL+ ToRJB/9LAqLeEDXl6LyRgrBJMUDfPV5gfr4iqzE2TfwlmQtMY9VVZgSzBclmKAp67Bbm/0T/UDQ WQhJApBRY3tDJ6nbdJRiM+X2RqemRskrEpDlrgs8TeSBp+kSzc1D2Vt6mGNLc1z/r/gZrbTFt1o vBbYu411RH9zW7g92zneQxlLLwATK7Pd6poTrBDIWJr8hKPxA/zut4gUqsqzrnID55PyUzK8rn5 huukRLE4HTpWVspSJFxgep0Gz2FiTTPsJt4i9c/NhPq1txhd50cf++t/+yDYPPq9TtoNAE9zbER ey/05V7M2b7TcaR1mlbT1iDSAlnr97gMhjSr9UTe7LvbM0Zz
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
 drivers/mailbox/tegra-hsp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index fe29fc2ca526..19ef56cbcfd3 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -868,13 +868,11 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_hsp_remove(struct platform_device *pdev)
+static void tegra_hsp_remove(struct platform_device *pdev)
 {
 	struct tegra_hsp *hsp = platform_get_drvdata(pdev);
 
 	lockdep_unregister_key(&hsp->lock_key);
-
-	return 0;
 }
 
 static int __maybe_unused tegra_hsp_resume(struct device *dev)
@@ -953,7 +951,7 @@ static struct platform_driver tegra_hsp_driver = {
 		.pm = &tegra_hsp_pm_ops,
 	},
 	.probe = tegra_hsp_probe,
-	.remove = tegra_hsp_remove,
+	.remove_new = tegra_hsp_remove,
 };
 
 static int __init tegra_hsp_init(void)
-- 
2.43.0


