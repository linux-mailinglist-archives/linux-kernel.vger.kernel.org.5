Return-Path: <linux-kernel+bounces-12268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9C81F220
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD9E1F231D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D314AF7F;
	Wed, 27 Dec 2023 21:03:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC8498BB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-0000rD-QS; Wed, 27 Dec 2023 22:02:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3J-001wF8-9E; Wed, 27 Dec 2023 22:02:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIb3K-001ZVg-0x;
	Wed, 27 Dec 2023 22:02:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 07/12] mailbox: qcom-apcs-ipc: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 22:02:35 +0100
Message-ID:  <9e4c20de4cf16ae8cf03a1844a000a17e4ed1990.1703710628.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=05Aw79eBvCAd2KreU2oJxdpnDsDvRhiwGd7aMF2V4do=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljJDt5XSagpy/f9wKNc7ifFv9CjOCUmtb4pRYN d382lA2HM2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYyQ7QAKCRCPgPtYfRL+ Tho5B/4slMPTrECJh7cRwJNM5OG+HFXibTK9phg2cNi2f7oFi7RzX2fHVe+2AmZCnAAcbvyoCJy VbfJtdkERRfrIwYPGreUAMLJiDfwK4QezgiiIYg/1jmyxYMNL6n07/XOaxndXs1u6tKXXxzbTVa RYtrMvs6DmlFtMSAY6cuJB8tetw2vri+kr/y+yZmM0xB11VFFdQ6LjscPx9VfgNWD04zywbopch mR/QzVVI4U2sHZ1wCJZgExf4tPAyt62l25ytPz8KCYUEBkpbtxm/NmCtmrqRPK2e4lswZ3AsfuZ AiF1GElyr3260sQUDKdC/dfAIGfzSO4dZXcR8RYRiYsGBMOn
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
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 79136fb62f01..7d91e7c016ba 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -129,14 +129,12 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_apcs_ipc_remove(struct platform_device *pdev)
+static void qcom_apcs_ipc_remove(struct platform_device *pdev)
 {
 	struct qcom_apcs_ipc *apcs = platform_get_drvdata(pdev);
 	struct platform_device *clk = apcs->clk;
 
 	platform_device_unregister(clk);
-
-	return 0;
 }
 
 /* .data is the offset of the ipc register within the global block */
@@ -169,7 +167,7 @@ MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
 
 static struct platform_driver qcom_apcs_ipc_driver = {
 	.probe = qcom_apcs_ipc_probe,
-	.remove = qcom_apcs_ipc_remove,
+	.remove_new = qcom_apcs_ipc_remove,
 	.driver = {
 		.name = "qcom_apcs_ipc",
 		.of_match_table = qcom_apcs_ipc_of_match,
-- 
2.43.0


