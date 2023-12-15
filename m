Return-Path: <linux-kernel+bounces-1058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142F8149DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6425E1C23A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212E315A7;
	Fri, 15 Dec 2023 13:59:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65462FE3F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8ix-0002mR-BL; Fri, 15 Dec 2023 14:59:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-00G2Zp-UK; Fri, 15 Dec 2023 14:59:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-003cCc-Kk; Fri, 15 Dec 2023 14:59:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] perf: arm_spe: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:10 +0100
Message-ID:  <abfedc224eca7f4960b7ddfb6daedd47a3699ca5.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ebvrrVyODNmxG3JvaFcjW9M/wrd0jxp2bmDDzLkJNiU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuwX1T9I98FsOZp/j5NoPrWESK2E3mBg3LWt VCaiOeyYiqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbsAAKCRCPgPtYfRL+ TgtzCACm2pQyhNJ/AJgC3ETsfXRz6oWzGYTxy2234b+nUURm2k4Z5MDNXqpcVrKfleWHD6qZnOP lQLYvUeaUjudGxEGvwadRqepqSeaV54gsAtNQhtSobFMoeJ4pXVxaDuB0N1krBYmqz87ykPvhxg NVqhwz+ZHZJTAmINKAd5gDhNRqratyN9uTiOTDF/dXuD304nabaTRih3ZSycOPQH8oT6eVkq7DQ XocFHOJ7jvs3CK0yv9kp3hQDqezmVM9YpymgUM4OLmi1WFxkVHEAELS8JsKIZQcWRuW8e65zfp/ DgW8qqlGV1xUqK5F6VpYEhF5nGCCmwNl6lwcGA6uO5FNQUwd
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
 drivers/perf/arm_spe_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b622d75d8c9e..35f0de03416f 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1263,14 +1263,13 @@ static int arm_spe_pmu_device_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int arm_spe_pmu_device_remove(struct platform_device *pdev)
+static void arm_spe_pmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_spe_pmu *spe_pmu = platform_get_drvdata(pdev);
 
 	arm_spe_pmu_perf_destroy(spe_pmu);
 	arm_spe_pmu_dev_teardown(spe_pmu);
 	free_percpu(spe_pmu->handle);
-	return 0;
 }
 
 static struct platform_driver arm_spe_pmu_driver = {
@@ -1281,7 +1280,7 @@ static struct platform_driver arm_spe_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_spe_pmu_device_probe,
-	.remove	= arm_spe_pmu_device_remove,
+	.remove_new = arm_spe_pmu_device_remove,
 };
 
 static int __init arm_spe_pmu_init(void)
-- 
2.42.0


