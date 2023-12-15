Return-Path: <linux-kernel+bounces-1060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A28149DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3032B2248E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B019321B9;
	Fri, 15 Dec 2023 13:59:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046530CE1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-0002oE-Ra; Fri, 15 Dec 2023 14:59:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-00G2a5-Ek; Fri, 15 Dec 2023 14:59:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-003cCx-5M; Fri, 15 Dec 2023 14:59:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] perf: marvell_cn10k_ddr: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:14 +0100
Message-ID:  <79f48409f663f0184f03d34c6a86359ea3aa1291.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AaJsT1X2pzgRo5v0ti8PFad+Bo0hVSMW+Zt7jtXU/Pk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFu1xixSuGrOf/p7nomBMD+boDsgfkZhsVcIJ jL3+jPNtqCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbtQAKCRCPgPtYfRL+ Tiz6CACiS8xI0T+UYaD8IbsJWOu3Q5lL06rvqmuD1aiANRTc47wrYBNjHzsDwxz+vHj1i+MMOEW 9ESDSKrfsHg0U1507xoqY78JQV5B1qqgi9fN5GakPQx0XEjGhp/gwAXVDhAqcgsolhYY/LDq9IH jnk2bo35mJIH8passLkJkwKfrTyoOmpHWXVSvjgbl9r7DPfXfecidXcuDa6eUqiqe/yod94NmXZ +01OKeN6aoH0bTx14tOxYYr9rSYqd91XFO90LbvrppP/ZD6Qni7boOJZknVUpisulpSUufGxcRI cF7WmDCUCTzG8WzsG6a66pdtWVWV+J80XZAl/v9EedzAr14n
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
 drivers/perf/marvell_cn10k_ddr_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 524ba82bfce2..e2abca188dbe 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -697,7 +697,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cn10k_ddr_perf_remove(struct platform_device *pdev)
+static void cn10k_ddr_perf_remove(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = platform_get_drvdata(pdev);
 
@@ -706,7 +706,6 @@ static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 				&ddr_pmu->node);
 
 	perf_pmu_unregister(&ddr_pmu->pmu);
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -733,7 +732,7 @@ static struct platform_driver cn10k_ddr_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= cn10k_ddr_perf_probe,
-	.remove		= cn10k_ddr_perf_remove,
+	.remove_new	= cn10k_ddr_perf_remove,
 };
 
 static int __init cn10k_ddr_pmu_init(void)
-- 
2.42.0


