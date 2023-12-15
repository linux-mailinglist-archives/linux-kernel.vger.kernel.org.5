Return-Path: <linux-kernel+bounces-1067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA18149E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707E72842EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED3381BA;
	Fri, 15 Dec 2023 13:59:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C8347CB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8j0-0002rC-Ed; Fri, 15 Dec 2023 14:59:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8j0-00G2aM-0W; Fri, 15 Dec 2023 14:59:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-003cDE-Md; Fri, 15 Dec 2023 14:59:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] perf: xgene: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:18 +0100
Message-ID:  <75dda01b2ad6e17f726830094bd38cb8faab5cbe.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1D3m60kbnUksK/WuWQHSRAl7TZysqOiH8RstEIIaHz8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFu6lmqjVGVsA8r8JJiVanp1hayMpcamEY8We UV3o/A1jOSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbugAKCRCPgPtYfRL+ ToLzB/9+s5OjzXe6GfBT4NB0Anrnt5XQvyWxHodZTkqso/txn8S20jxyKZBgbZEm40n6bByfE9Z Y5jY7X9eMilOhnD61sfIzpIOBqWx6Z/SLI1WMWtd511mmdFDYmIBfDfIaApfpdfHmnZo+rQG6mt UX9FuzjlqJzZzX0MXek0fZNGli/bUd9tryph6bZXAfcH823yujJWnWMTdYsBVOleq76Le5kEMFx 0mhhu7w2A+Hb4nKFzzdjyJEm3zhVdqhXpvu9f2Za2x4j9Ux4pNnzcC9QKwUrc7tlX77YTu4akFy CViUrNEh4DxQWjE4KTbRzMb+iGxv5nVA7/nsi4N1BMPw4JIF
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
 drivers/perf/xgene_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 7ce344248dda..0d49343d704b 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1937,7 +1937,7 @@ xgene_pmu_dev_cleanup(struct xgene_pmu *xgene_pmu, struct list_head *pmus)
 	}
 }
 
-static int xgene_pmu_remove(struct platform_device *pdev)
+static void xgene_pmu_remove(struct platform_device *pdev)
 {
 	struct xgene_pmu *xgene_pmu = dev_get_drvdata(&pdev->dev);
 
@@ -1947,13 +1947,11 @@ static int xgene_pmu_remove(struct platform_device *pdev)
 	xgene_pmu_dev_cleanup(xgene_pmu, &xgene_pmu->mcpmus);
 	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 				    &xgene_pmu->node);
-
-	return 0;
 }
 
 static struct platform_driver xgene_pmu_driver = {
 	.probe = xgene_pmu_probe,
-	.remove = xgene_pmu_remove,
+	.remove_new = xgene_pmu_remove,
 	.driver = {
 		.name		= "xgene-pmu",
 		.of_match_table = xgene_pmu_of_match,
-- 
2.42.0


