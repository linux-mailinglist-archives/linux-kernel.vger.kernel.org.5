Return-Path: <linux-kernel+bounces-12269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24081F221
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC771F23187
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA64B148;
	Wed, 27 Dec 2023 21:03:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33D49F8D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3L-0000sJ-2D; Wed, 27 Dec 2023 22:02:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001wFB-HN; Wed, 27 Dec 2023 22:02:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001ZVk-1k;
	Wed, 27 Dec 2023 22:02:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 08/12] mailbox: qcom-ipcc: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:36 +0100
Message-ID:  <515f199e83af8a6295d38f0127be230bbbd6098b.1703710628.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703710628.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dQ7xAWwAr+m6oeIQoY8ovO5/17i2OHqeN97W+/12Du4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDufzD2oU8+z6pomHH+G4A8o2UtNr9z9PhPb vptCsZeZieJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ7gAKCRCPgPtYfRL+ Tq7pB/9Dmb/jKMl6/r477Ic9N1qIMXfrf4k1YWh8kVn7VLU0tzEVL5PeORJkHj5yqzysrPTJyTf G88OGmEFNY5XtxMN/p4IpCnkixdN0ZR1EWm6uCQhsLhJwwwsuGsJodiXkfDT6fSjIedCH7nDyAE dZcXeVoWOjztd+8ps5A3NYZkXGg7gAQP40tblN6PIIwMocxKsGLNhKtt71tsf61wu9SMTUMmgwl QwyWpfrV1MOUrtwmwW+DHBh2a6TvxNX7iWVBRYnzFIpdGj/OqHJURKPOdMYNXifhfstSrbWcQCI r78rzCbFkV3luWKwxJVYlsYlLH64Q9wlWKDEUgllPAHT4bMn
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
 drivers/mailbox/qcom-ipcc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index f597a1bd5684..d537cc9c4d4b 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -326,14 +326,12 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_ipcc_remove(struct platform_device *pdev)
+static void qcom_ipcc_remove(struct platform_device *pdev)
 {
 	struct qcom_ipcc *ipcc = platform_get_drvdata(pdev);
 
 	disable_irq_wake(ipcc->irq);
 	irq_domain_remove(ipcc->irq_domain);
-
-	return 0;
 }
 
 static const struct of_device_id qcom_ipcc_of_match[] = {
@@ -348,7 +346,7 @@ static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
 
 static struct platform_driver qcom_ipcc_driver = {
 	.probe = qcom_ipcc_probe,
-	.remove = qcom_ipcc_remove,
+	.remove_new = qcom_ipcc_remove,
 	.driver = {
 		.name = "qcom-ipcc",
 		.of_match_table = qcom_ipcc_of_match,
-- 
2.43.0


