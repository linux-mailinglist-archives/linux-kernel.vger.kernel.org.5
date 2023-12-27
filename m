Return-Path: <linux-kernel+bounces-12130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B981F063
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D509F280FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE647F48;
	Wed, 27 Dec 2023 16:26:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD246437
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjz-00059m-UU; Wed, 27 Dec 2023 17:26:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjw-001tZK-Lv; Wed, 27 Dec 2023 17:26:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjx-001Wmg-2E;
	Wed, 27 Dec 2023 17:26:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: kernel@pengutronix.de,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] firmware: arm_scmi: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:25 +0100
Message-ID:  <86165c8ccd0bb47000a29e711102795b36c8df41.1703693980.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JK/CSDYjlDzz8/Ko2zYkIZLw829LGnskJHP4zrb3nSc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFAzHGKIj+U2X2/VquNqcN62INqnmVrFKeBUV waVRlMvMSiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQMwAKCRCPgPtYfRL+ To+6CACSdd6ebXHEHuZH278GDpN/34UYlQyumgf05hEYLn7eStz0mwZTNZNBViswZLobbkbPjvj TUoGFM03/AvIKHgJVHzZmivM8csSsF18pCdURQ/26QNnv4XEItA9q6KOOGze54yeGKt4ir7mRwo H1syPHLrzQLDrf00QPIvhRj3sJoRF6FHV8HfYI7nGpnextDyr6+zTkcfxOC1vUvY+TIUXgHMk3A J41YL+ZRdcpMZEH7qFNq9icFrtCTVzqpNTLBT7x0xMmtWYCvS6o5xqwpQLeDOadis6WNhBrmRIR jH3lsv1OVKlzE+oq89AayWxMuMsgh1FqBuumXnYiubyQyRqf
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
 drivers/firmware/arm_scmi/driver.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a9f70e6e58ac..3ea64b22cf0d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2834,7 +2834,7 @@ static int scmi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int scmi_remove(struct platform_device *pdev)
+static void scmi_remove(struct platform_device *pdev)
 {
 	int id;
 	struct scmi_info *info = platform_get_drvdata(pdev);
@@ -2868,8 +2868,6 @@ static int scmi_remove(struct platform_device *pdev)
 	scmi_cleanup_txrx_channels(info);
 
 	ida_free(&scmi_id, info->id);
-
-	return 0;
 }
 
 static ssize_t protocol_version_show(struct device *dev,
@@ -2947,7 +2945,7 @@ static struct platform_driver scmi_driver = {
 		   .dev_groups = versions_groups,
 		   },
 	.probe = scmi_probe,
-	.remove = scmi_remove,
+	.remove_new = scmi_remove,
 };
 
 /**
-- 
2.43.0


