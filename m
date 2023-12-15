Return-Path: <linux-kernel+bounces-1052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81228149D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76307284302
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44472EB12;
	Fri, 15 Dec 2023 13:59:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C52EB0C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-0002lN-T6; Fri, 15 Dec 2023 14:59:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-00G2ZM-Fs; Fri, 15 Dec 2023 14:59:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-003cCA-6O; Fri, 15 Dec 2023 14:59:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] perf: arm-cci: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:03 +0100
Message-ID:  <70b581d58cfffdccb9fb3ed17bf3220c00f8033f.1702648124.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=OV7M65VoRPeJ8qTDzcFPkay5azPTFOLc6r+glQI271o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuogdGltz/NA/M9cJo+jkIVbz1EYKIyaZhCh 4ZCdvCuODCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbqAAKCRCPgPtYfRL+ TkIPB/9K2n7gMNOMWl/EmTYhk5IAPdnBM9fF+pHuMPwmfcFW+Wson4Ic7Y2+x7Rm/Ca/gLzRboB wEjcoZpsPJXtKRihv0dBETuhO5mGrDv/GSIv4T2hPihADs+UyBRG/AT64Igh0NiXQaRuq3LRd3L wDC+Pyry+EZcPk1PcwIGhzcXtTuOriyvJs/xeI1Rj56DlCfdHnCwmlyh2Li7HLrF1CfHnzYPQsz 03aFqQpabdqBZFHMoadpgb0BySMFm6ScfKq5b6ZcQQU3pWm6kz5ouETWEu7UuPetw98bdkJ1e1Y H1BK6h6tIus1cC4lYHZw5geWq1nw0Of3UJC4Bg2uXeaQ0T7m
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
 drivers/perf/arm-cci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 61de861eaf91..6be03f81ae5d 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1697,16 +1697,14 @@ static int cci_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cci_pmu_remove(struct platform_device *pdev)
+static void cci_pmu_remove(struct platform_device *pdev)
 {
 	if (!g_cci_pmu)
-		return 0;
+		return;
 
 	cpuhp_remove_state(CPUHP_AP_PERF_ARM_CCI_ONLINE);
 	perf_pmu_unregister(&g_cci_pmu->pmu);
 	g_cci_pmu = NULL;
-
-	return 0;
 }
 
 static struct platform_driver cci_pmu_driver = {
@@ -1716,7 +1714,7 @@ static struct platform_driver cci_pmu_driver = {
 		   .suppress_bind_attrs = true,
 		  },
 	.probe = cci_pmu_probe,
-	.remove = cci_pmu_remove,
+	.remove_new = cci_pmu_remove,
 };
 
 module_platform_driver(cci_pmu_driver);
-- 
2.42.0


