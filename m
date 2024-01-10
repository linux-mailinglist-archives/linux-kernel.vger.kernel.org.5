Return-Path: <linux-kernel+bounces-22443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EAE829DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689E91F27873
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7164C61D;
	Wed, 10 Jan 2024 15:43:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953D4BABE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-0007JI-A4; Wed, 10 Jan 2024 16:43:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-001jUb-B5; Wed, 10 Jan 2024 16:43:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-006c4L-0s;
	Wed, 10 Jan 2024 16:43:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] macintosh: windfarm_pm112: Convert to platform remove callback returning void
Date: Wed, 10 Jan 2024 16:42:49 +0100
Message-ID:  <eac991c7f2267237382f77bc15c016ff62e1fbb7.1704900449.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=EDHxRAEtSZEx4PMN+NHAvrn9dvdslr8ymxAgEO6mM54=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnrr6o9vZrpebD10MOZdZmw5FqvDRtlGuQv/Ny lxuC0t+3OuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ66+gAKCRCPgPtYfRL+ Tp7yB/44+RH1GGupIvmLoyJcQ16OpEyinOqC00OpPqyfAfbw3z9vVNi/5wuWHkgslkcesPpl8Ja efsFt7RPCCjg8rdtgPd4oW1Yf+6msVDzFuDp2fQ/yLPyaUhv4k2h74bYqoRkXhblqA3PNkGAjYa +s44DBpjCinsW2hbVAA15PG2s5LSIDJ5n4hVIf5/b7TwHJKi4mvgNpP6tk6zm2wDmb84SIztiVe k9dQKxbdZPgP6b1tKyasQ4ZjfKS7SnGJwH001v1DeS1AYBrD8322Skl6B6gC4DLZcW36LIfgnMO ppZKVTjOgghEXntnJ1uLoichovITKRqWsC4jJ8PhtoVc3wOK
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
 drivers/macintosh/windfarm_pm112.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfarm_pm112.c
index d1dec314ae30..876b4d8cbe37 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -662,16 +662,14 @@ static int wf_pm112_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int wf_pm112_remove(struct platform_device *dev)
+static void wf_pm112_remove(struct platform_device *dev)
 {
 	wf_unregister_client(&pm112_events);
-	/* should release all sensors and controls */
-	return 0;
 }
 
 static struct platform_driver wf_pm112_driver = {
 	.probe = wf_pm112_probe,
-	.remove = wf_pm112_remove,
+	.remove_new = wf_pm112_remove,
 	.driver = {
 		.name = "windfarm",
 	},
-- 
2.43.0


