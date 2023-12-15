Return-Path: <linux-kernel+bounces-1057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B08149D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D11F2432A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A393067D;
	Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156C2EB1A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-0002mJ-Tn; Fri, 15 Dec 2023 14:59:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-00G2Zl-Gk; Fri, 15 Dec 2023 14:59:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-003cCY-7L; Fri, 15 Dec 2023 14:59:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] perf: arm_smmuv3: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:09 +0100
Message-ID:  <23bfd1a73ce819ffce6137c237608684a3cdfda6.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=WoUmgvDx6FwJTMCVD5BbKw0j9xOmLxz1U/nwD6WKOcw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuvsCq62C9qwNvQCGzRX11jvZolyVoVwJoOU 2Pmd6ixFyyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbrwAKCRCPgPtYfRL+ Tko8B/4gczEX6cq/EpSayum0gjAC6YWceqcQyx+h3VFIm0jNwy1lr8d0iDJMRDqEeDZN0MEuCCh a+KRJiDm1t4J7zO8axMAreV6sCCMdL9vi8wLNJhphHuxDUaSu2CCmcKqkU7u/R4vXYf7D0qTAIM JhblkMgyhjTfzeqLNET/vGatSow+qjW5KWUVlH4cBNTVUWjk4t8nuxg5++dtTrUGnof6bo0Ivcn BPfniPiTdoBEE23U6vHSnp55tep/W0h9rqokLUZdRBE3F4r99Dvp8DqAKS5kQIuK+2E4dTadnFt Iv57KcGOAQZschzGKhWvvkv9JJigxUJemXGDPKAvp9NttgOz
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
 drivers/perf/arm_smmuv3_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 6303b82566f9..af3ab3eb944e 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -965,14 +965,12 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int smmu_pmu_remove(struct platform_device *pdev)
+static void smmu_pmu_remove(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&smmu_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
-
-	return 0;
 }
 
 static void smmu_pmu_shutdown(struct platform_device *pdev)
@@ -997,7 +995,7 @@ static struct platform_driver smmu_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = smmu_pmu_probe,
-	.remove = smmu_pmu_remove,
+	.remove_new = smmu_pmu_remove,
 	.shutdown = smmu_pmu_shutdown,
 };
 
-- 
2.42.0


