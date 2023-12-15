Return-Path: <linux-kernel+bounces-1064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3A8149E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28D8B22235
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F4358BF;
	Fri, 15 Dec 2023 13:59:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41F321B2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-0002mw-7C; Fri, 15 Dec 2023 14:59:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8ix-00G2Zx-Oe; Fri, 15 Dec 2023 14:59:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8ix-003cCp-F9; Fri, 15 Dec 2023 14:59:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] perf: fsl_imx9_ddr: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:12 +0100
Message-ID:  <bd12035ca467d7f4cd5edcfd6febda56600caacd.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NXdhdQQKZ6b1dcEG52uoPa64FeprMMqzZeyISKSgu6o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuzTqXZWOR+jvLxMzxn/N3EohQwIej9USNDY 81tT77OLbSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbswAKCRCPgPtYfRL+ TsMDCACbYsOrWMQZTfj5ByGoS2/B+xJSE88BfpXrdNEUrS5LY2vhmwYMlX1NbyFGP0DpYKUDqZC c7LDp1ZSXl2iLIjp9Thh3zsRes5DIjXq/tqCUwMIMyyh7JkHwZg5xcbjcsKrWiU/huql2AaryPH l51ZpPkIW6xq31eVovns+UQGQFnHKo1BTlZ8r7aGkuYjIn9J33uu1eTvqM1/e1mx1fxvHH5US6e sBKjLsP0K/dYgyOfYCQ5Jq2wb9e1yiLR9olQpEqjd6aAbHw1tCKWJcL+ZXWONA3ryjMdANvZdYk omhE20yAo7ThOBtHe0scaUjv2wgRUeQfMZMFK+c53Wyo0DDi
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
 drivers/perf/fsl_imx9_ddr_perf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..72c2d3074cde 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -679,7 +679,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ddr_perf_remove(struct platform_device *pdev)
+static void ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
@@ -689,8 +689,6 @@ static int ddr_perf_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&pmu->pmu);
 
 	ida_free(&ddr_ida, pmu->id);
-
-	return 0;
 }
 
 static struct platform_driver imx_ddr_pmu_driver = {
@@ -700,7 +698,7 @@ static struct platform_driver imx_ddr_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe          = ddr_perf_probe,
-	.remove         = ddr_perf_remove,
+	.remove_new     = ddr_perf_remove,
 };
 module_platform_driver(imx_ddr_pmu_driver);
 
-- 
2.42.0


