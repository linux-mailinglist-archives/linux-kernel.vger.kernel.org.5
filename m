Return-Path: <linux-kernel+bounces-1056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8288149D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1130B2306B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE430661;
	Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F32EB13
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-0002m9-KH; Fri, 15 Dec 2023 14:59:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-00G2Zh-6a; Fri, 15 Dec 2023 14:59:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-003cCU-T8; Fri, 15 Dec 2023 14:59:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] perf: arm_dsu: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:08 +0100
Message-ID:  <1eda5e216afcb0e26a50e9be112d4514ffd0844a.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gKSz5agc738Ao0P2osYXM1UoZoFjy/rLUQ5L4iZFmyI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuu4w/8xSjfL5Jy4Q+gBWkJl5quzF8u2c9EF ZSuJkFazxuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbrgAKCRCPgPtYfRL+ TnOwCACE2E0Wcd9duOUJS8zMVcNOKoztafxCDtZwFHXmU9Uad7QEAI0yl4pvEb5PKqJKWNqFfRO B3u9lOiEFQy6jStJIZMkq0RR5R0h4wwib+AX5JzwbARfq8QHxivZkuE8A/kcq5YaXJ50hkCSejm LWFWQEEFRBvD6lF52g6PwP7sEp9r5tBXGuNVh8tyzHqpUavxP9H1OesP84ffBqqhT++Y7VGllmu 5q19d8J7n3Zj1WZuDQWpwBP2m0dL7lc0c7eBSQY+1JX56nCLCCdUF+KwT+OidYq50NOcykRSCRR BlAt53FRc+G0RUFizKpv0L30X/+WSHiL0tpEFmZNWJSs0Q0v
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
 drivers/perf/arm_dsu_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 7ec4498e312f..bae3ca37f846 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -774,14 +774,12 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int dsu_pmu_device_remove(struct platform_device *pdev)
+static void dsu_pmu_device_remove(struct platform_device *pdev)
 {
 	struct dsu_pmu *dsu_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&dsu_pmu->pmu);
 	cpuhp_state_remove_instance(dsu_pmu_cpuhp_state, &dsu_pmu->cpuhp_node);
-
-	return 0;
 }
 
 static const struct of_device_id dsu_pmu_of_match[] = {
@@ -806,7 +804,7 @@ static struct platform_driver dsu_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = dsu_pmu_device_probe,
-	.remove = dsu_pmu_device_remove,
+	.remove_new = dsu_pmu_device_remove,
 };
 
 static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
-- 
2.42.0


