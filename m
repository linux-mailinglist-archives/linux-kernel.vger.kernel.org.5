Return-Path: <linux-kernel+bounces-1055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B528149D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839C1284627
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84C3035F;
	Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4502EAE6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-0002lz-8X; Fri, 15 Dec 2023 14:59:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-00G2Zd-RV; Fri, 15 Dec 2023 14:59:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-003cCQ-Hw; Fri, 15 Dec 2023 14:59:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] perf: arm_dmc620: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:07 +0100
Message-ID:  <20cc24ede88f5e000991dfe6f4cf1222b819e337.1702648125.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lrV81L2OU/dvTSZ+m0J3yiXdNzi3SVAwtIWN5qo5KWw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFutwo9RDJJfKqAgN3OJB85XfTtj7FOxqzbbo dBmPHTBK9+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbrQAKCRCPgPtYfRL+ Tq9aB/98q4eICU9u2Q8WbuK24DRNwAR7/EYcGfG1LYDS2Wn1ZDjBkadAlR6sAmTwHAmBsbpEoWx ikFeZHGtwu8wy8va+x8OsWplfaYy87dON9XMRWhsTMswN3jbRRFmUwTuwkmnNn9s8PL8Be1t1gm 6YzUoYZpe3a4G3xPzqxJvFrUoSfYYTjoA1tsRR4rg0NOf8BrrJBHuPqCUtk/bqbHICiPYx6ZZQK GAoZ9sz+qxK25T+Jh5dDid9YjmJwCTPsMY9zP9skHdLaW2vo/uDCBKfpNLOmisknHzw24/DjZe2 VOqpLt1C8WXi53xpHtr7UDEH8dvUZk+J88g+f+lCVxNbJ2eA
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
 drivers/perf/arm_dmc620_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 30cea6859574..8a81be2dd5ec 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -724,7 +724,7 @@ static int dmc620_pmu_device_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dmc620_pmu_device_remove(struct platform_device *pdev)
+static void dmc620_pmu_device_remove(struct platform_device *pdev)
 {
 	struct dmc620_pmu *dmc620_pmu = platform_get_drvdata(pdev);
 
@@ -732,8 +732,6 @@ static int dmc620_pmu_device_remove(struct platform_device *pdev)
 
 	/* perf will synchronise RCU before devres can free dmc620_pmu */
 	perf_pmu_unregister(&dmc620_pmu->pmu);
-
-	return 0;
 }
 
 static const struct acpi_device_id dmc620_acpi_match[] = {
@@ -748,7 +746,7 @@ static struct platform_driver dmc620_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe	= dmc620_pmu_device_probe,
-	.remove	= dmc620_pmu_device_remove,
+	.remove_new = dmc620_pmu_device_remove,
 };
 
 static int __init dmc620_pmu_init(void)
-- 
2.42.0


