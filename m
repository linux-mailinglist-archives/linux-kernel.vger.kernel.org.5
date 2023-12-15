Return-Path: <linux-kernel+bounces-1070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515EB8149EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D325E1F23334
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81233D976;
	Fri, 15 Dec 2023 13:59:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F93C46A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-0002nD-JB; Fri, 15 Dec 2023 14:59:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-00G2a1-4C; Fri, 15 Dec 2023 14:59:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8ix-003cCt-RA; Fri, 15 Dec 2023 14:59:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] perf: hisilicon: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:13 +0100
Message-ID:  <33a8be0641b9447469fb7f6af0a10fb65efa97a3.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7525; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dBrvfcbHwf9YFBIy44YHlg/Q1c5X8IaEDYgph7Wakac=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSa6C1fM6zVmn2PH2BmNO2Yyslosue3hvrUOZau1157d nzJyDzayWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBExC6x/1Ot6H8lPtlz4sYQ x0kF0uVPH34W3yM+R4OD48jU96XCd2S5GXdEli5YqqRbfsTsaOmjFlWVwpRfX5T25a17cD3G0UT DcvqU8+ye7w9teR60ptJYcMPUJNv+D18F5rW81ps3+2Ls5r7j62c2dMeJ2LIveHKVaV/2q6b9rQ d6Em15xVMDfTeKTA7mePG4wT/B9MAflycF3YtfCX713PTm3S6/rOifTMcOMR421jqa8J9TWfGwJ Hufr/2thFPv2O6Ernhev/hGZFaljRNTHsuVVZO6n8eK1N5WUVfx6pBtv250Q2RPznmmqBf3dDhm RwS68d9z0N5eNveQaaFxNR83V2qanchy6zqZ9pIqDZ2/AA==
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

Trivially convert these drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 5 ++---
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 5 ++---
 6 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
index 40f1bc9f9b91..0e923f94fa5b 100644
--- a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
@@ -341,7 +341,7 @@ static int hisi_cpa_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_cpa_pmu_remove(struct platform_device *pdev)
+static void hisi_cpa_pmu_remove(struct platform_device *pdev)
 {
 	struct hisi_pmu *cpa_pmu = platform_get_drvdata(pdev);
 
@@ -349,7 +349,6 @@ static int hisi_cpa_pmu_remove(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_CPA_ONLINE,
 					    &cpa_pmu->node);
 	hisi_cpa_pmu_enable_pm(cpa_pmu);
-	return 0;
 }
 
 static struct platform_driver hisi_cpa_pmu_driver = {
@@ -359,7 +358,7 @@ static struct platform_driver hisi_cpa_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_cpa_pmu_probe,
-	.remove = hisi_cpa_pmu_remove,
+	.remove_new = hisi_cpa_pmu_remove,
 };
 
 static int __init hisi_cpa_pmu_module_init(void)
diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index ffb039d05d07..b804e3738113 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -531,14 +531,13 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_ddrc_pmu_remove(struct platform_device *pdev)
+static void hisi_ddrc_pmu_remove(struct platform_device *pdev)
 {
 	struct hisi_pmu *ddrc_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&ddrc_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
 					    &ddrc_pmu->node);
-	return 0;
 }
 
 static struct platform_driver hisi_ddrc_pmu_driver = {
@@ -548,7 +547,7 @@ static struct platform_driver hisi_ddrc_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_ddrc_pmu_probe,
-	.remove = hisi_ddrc_pmu_remove,
+	.remove_new = hisi_ddrc_pmu_remove,
 };
 
 static int __init hisi_ddrc_pmu_module_init(void)
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 15caf99e1eef..21e69b1cdd4d 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -534,14 +534,13 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_hha_pmu_remove(struct platform_device *pdev)
+static void hisi_hha_pmu_remove(struct platform_device *pdev)
 {
 	struct hisi_pmu *hha_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&hha_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
 					    &hha_pmu->node);
-	return 0;
 }
 
 static struct platform_driver hisi_hha_pmu_driver = {
@@ -551,7 +550,7 @@ static struct platform_driver hisi_hha_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_hha_pmu_probe,
-	.remove = hisi_hha_pmu_remove,
+	.remove_new = hisi_hha_pmu_remove,
 };
 
 static int __init hisi_hha_pmu_module_init(void)
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 794dbcd19b7a..51ba76871097 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -568,14 +568,13 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_l3c_pmu_remove(struct platform_device *pdev)
+static void hisi_l3c_pmu_remove(struct platform_device *pdev)
 {
 	struct hisi_pmu *l3c_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&l3c_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
 					    &l3c_pmu->node);
-	return 0;
 }
 
 static struct platform_driver hisi_l3c_pmu_driver = {
@@ -585,7 +584,7 @@ static struct platform_driver hisi_l3c_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_l3c_pmu_probe,
-	.remove = hisi_l3c_pmu_remove,
+	.remove_new = hisi_l3c_pmu_remove,
 };
 
 static int __init hisi_l3c_pmu_module_init(void)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 797cf201996a..3cdb35c741f9 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -514,14 +514,13 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_pa_pmu_remove(struct platform_device *pdev)
+static void hisi_pa_pmu_remove(struct platform_device *pdev)
 {
 	struct hisi_pmu *pa_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&pa_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
 					    &pa_pmu->node);
-	return 0;
 }
 
 static const struct acpi_device_id hisi_pa_pmu_acpi_match[] = {
@@ -539,7 +538,7 @@ static struct platform_driver hisi_pa_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_pa_pmu_probe,
-	.remove = hisi_pa_pmu_remove,
+	.remove_new = hisi_pa_pmu_remove,
 };
 
 static int __init hisi_pa_pmu_module_init(void)
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index e706ca567676..765bbd61db26 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -460,14 +460,13 @@ static int hisi_sllc_pmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_sllc_pmu_remove(struct platform_device *pdev)
+static void hisi_sllc_pmu_remove(struct platform_device *pdev)
 {
 	struct hisi_pmu *sllc_pmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&sllc_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
 					    &sllc_pmu->node);
-	return 0;
 }
 
 static struct platform_driver hisi_sllc_pmu_driver = {
@@ -477,7 +476,7 @@ static struct platform_driver hisi_sllc_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = hisi_sllc_pmu_probe,
-	.remove = hisi_sllc_pmu_remove,
+	.remove_new = hisi_sllc_pmu_remove,
 };
 
 static int __init hisi_sllc_pmu_module_init(void)
-- 
2.42.0


