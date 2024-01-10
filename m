Return-Path: <linux-kernel+bounces-22442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE1829DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3BE1F2785F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A544C3D4;
	Wed, 10 Jan 2024 15:43:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957C4C3AC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-0007Jm-KW; Wed, 10 Jan 2024 16:43:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-001jUn-7t; Wed, 10 Jan 2024 16:43:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-006c4b-0Y;
	Wed, 10 Jan 2024 16:43:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] macintosh: windfarm_pm91: Convert to platform remove callback returning void
Date: Wed, 10 Jan 2024 16:42:53 +0100
Message-ID:  <398f9079cacd5b87a930181c250aad2ad4d31424.1704900449.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
References: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8aZfpoH5lzS55ahHLTUxaDk7/GZmD/HxONs4PkUDUl0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnrr/7dIK9PJJ+nUZAKGCKE1x+4eq/t9mns0qt c/Kvyw1SU+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ66/wAKCRCPgPtYfRL+ Tj1fCACs0Dowfmv5ewZRIzj9K3M5xLJmeqHgYzUwMO4KqHsHOhLiDckbm3XJGhShydspUs6ANCD V3zLTHecUbbipJ3AzGv6XK+hHji+AIIMU+JI9CAfx8p0hypPUgsIqgCfpqWWuB58At22Z039AM9 /w8vV1uSQ9MXuGvxV68mFpm5yXf2w31t7l+3v/Nfs2ZTgjMsnXz5nBdf+mVbq3uZouNdvD6AnnZ wLlISOAkYE3fU1nk5U4nQh3SatJlZ2ruocIoZasV7cLT4aGr/cQPxmForu/QiWu2TnYUqg1JRwI YhU1U8xq/i/OFIhfs6DNXjL3sG0kmlIhjKhaP1FEcQSWWZpW
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
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/macintosh/windfarm_pm91.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 120a9cfba0c5..fba02a375435 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -647,7 +647,7 @@ static int wf_smu_probe(struct platform_device *ddev)
 	return 0;
 }
 
-static int wf_smu_remove(struct platform_device *ddev)
+static void wf_smu_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&wf_smu_events);
 
@@ -691,13 +691,11 @@ static int wf_smu_remove(struct platform_device *ddev)
 	kfree(wf_smu_slots_fans);
 	kfree(wf_smu_drive_fans);
 	kfree(wf_smu_cpu_fans);
-
-	return 0;
 }
 
 static struct platform_driver wf_smu_driver = {
-        .probe = wf_smu_probe,
-        .remove = wf_smu_remove,
+	.probe = wf_smu_probe,
+	.remove_new = wf_smu_remove,
 	.driver = {
 		.name = "windfarm",
 	},
-- 
2.43.0


