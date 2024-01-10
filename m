Return-Path: <linux-kernel+bounces-22445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08017829DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F421F27806
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0F4CB47;
	Wed, 10 Jan 2024 15:43:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3DE4BAAB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajS-0007JJ-A4; Wed, 10 Jan 2024 16:43:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-001jUe-JE; Wed, 10 Jan 2024 16:43:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNajR-006c4P-1e;
	Wed, 10 Jan 2024 16:43:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] macintosh: windfarm_pm121: Convert to platform remove callback returning void
Date: Wed, 10 Jan 2024 16:42:50 +0100
Message-ID:  <36f421f845449a9700f704379105aa5f5db5dd9e.1704900449.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ahSfaLmJWp+gaXOKoxuCz1P0tq1CJb3CsTzJGUZXrFg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnrr7FqpOPEO32kCs+/cZZvDnptqWO72wpcelD /JB3p5/NgqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ66+wAKCRCPgPtYfRL+ Th2LCACT1HQcveropFDIDsahtIYtsDE+XV6WXUevICZiD0pzKxhcxb3akPORbEQXzEYUTvloubq wcZbyc7YSBvYeIRo/d5IAUoKT5HNb9dnuHBw8y0A+imiBj3+R1YYgzqU6Was6bqm/qaRP6f10K5 5dr1nVae+0DS4MSFFfMe+H35GenT2N7UjSJBoZHlMyCfjGJI34MnKuTG7zZ1kbIU53tjcFzjBFK EAdF9k+89qA5rY2fN+p89azvsOfnEgtAFANmxUenuxiZaMFSnKALUXhAXJaFOoB8uljmRkKMhNt jYyvxfjW3NhYMGpoIyScrnLV7JBDKcqyfZNPH2PisvlxqL3B
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
 drivers/macintosh/windfarm_pm121.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index 82500417ebee..cd45fbc4fe1c 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -992,15 +992,14 @@ static int pm121_probe(struct platform_device *ddev)
 	return 0;
 }
 
-static int pm121_remove(struct platform_device *ddev)
+static void pm121_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&pm121_events);
-	return 0;
 }
 
 static struct platform_driver pm121_driver = {
 	.probe = pm121_probe,
-	.remove = pm121_remove,
+	.remove_new = pm121_remove,
 	.driver = {
 		.name = "windfarm",
 		.bus = &platform_bus_type,
-- 
2.43.0


