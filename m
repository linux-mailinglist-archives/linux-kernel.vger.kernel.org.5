Return-Path: <linux-kernel+bounces-1059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573188149DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D51C2360A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD34321AB;
	Fri, 15 Dec 2023 13:59:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B763066A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-0002lL-Sz; Fri, 15 Dec 2023 14:59:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8it-00G2ZG-QJ; Fri, 15 Dec 2023 14:59:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8it-003cC2-GP; Fri, 15 Dec 2023 14:59:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] perf: alibaba_uncore_drw: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:01 +0100
Message-ID:  <e6dd47f791ddcc4cc6f7a80efcede245528220e6.1702648124.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9FC259Rv6/1RNxYI95FF5rVsM1/6UsMv70AkNQrVF1Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFulZf+lV8nfqy5ovLYczr2QJtaFXTDh+Ik2H irgtecLXjeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbpQAKCRCPgPtYfRL+ TrhnCACSDh21/DkEFLG9vdQ8DL85RDI9U9NJtmDImJCs1mt5MmHxD7nUcmXvAVxOW7SkVdNhReG MScmbD3s1L3D/usi78y8fSzSfTv4jqbCYRQrcMPStisxaxQjSlq/OwsfE7GBURPUjjT2Z6sffjr eWr+Qy1P5EcqPhiaTqlejucbGrR0qOJhppx1mkE0RpCoa/l9DOzrOZ6qK0jZ37TzjEJJL3TMO4B bkVE35ZkgAYM3iL6ovK3PXvy7NFhp5aFzjDiO0AzgVj5aWiPT/DTjl8NGF4fo2AiOgeUuVud0HO ynbJpiHs8g8kvs17Bxg+eqZj/Lp51b0Fbcr+sBs4YlBfHz7M
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
 drivers/perf/alibaba_uncore_drw_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 19d459a36be5..a9277dcf90ce 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -729,7 +729,7 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ali_drw_pmu_remove(struct platform_device *pdev)
+static void ali_drw_pmu_remove(struct platform_device *pdev)
 {
 	struct ali_drw_pmu *drw_pmu = platform_get_drvdata(pdev);
 
@@ -739,8 +739,6 @@ static int ali_drw_pmu_remove(struct platform_device *pdev)
 
 	ali_drw_pmu_uninit_irq(drw_pmu);
 	perf_pmu_unregister(&drw_pmu->pmu);
-
-	return 0;
 }
 
 static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
@@ -795,7 +793,7 @@ static struct platform_driver ali_drw_pmu_driver = {
 		   .acpi_match_table = ali_drw_acpi_match,
 		   },
 	.probe = ali_drw_pmu_probe,
-	.remove = ali_drw_pmu_remove,
+	.remove_new = ali_drw_pmu_remove,
 };
 
 static int __init ali_drw_pmu_init(void)
-- 
2.42.0


