Return-Path: <linux-kernel+bounces-96700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D120B876034
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5151F27943
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4952F8B;
	Fri,  8 Mar 2024 08:51:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58D5103F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887915; cv=none; b=Zs8FiZ3ssdb1iY9zBAgwyQbC0ZtTWVFfZBWLyPa9uPrnzNnrpsl/FBodCBqYkFkqZDuZSJM+gpT/Sbx3MAepVDW8Na8MH9pEoxpreqVFdMVmdfehbsR0lNteAG9mojGZkRGqK/9EQocu4fLrQwN6/bSK5eK4GbUQChwRtXCDJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887915; c=relaxed/simple;
	bh=bXTUAD/5Ef+bIeniaAlqgSyRSIEvLwy0ovseKODq3i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rlA1NYkKGCYw8dHymGKDOeTCnwzQVRcDv/8m8dCfQliqIlBTuXqG5FMhOXh52hylhY3gZwzveJ1gPl22+KTG4wqC5iwXQ000yO7UHksu3nT2stQu6LqZa2mZ0kmXknXR0Frk9FBJEnTN2LTLgwXKaGDtMWBFYduwMaY3KDXQNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxH-00073j-Sk; Fri, 08 Mar 2024 09:51:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxH-0056Nx-5O; Fri, 08 Mar 2024 09:51:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxH-00246P-0I;
	Fri, 08 Mar 2024 09:51:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] samples: qmi: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:21 +0100
Message-ID:  <d30beb557e0e97ea194028f62d3c4c10841d3e7c.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bXTUAD/5Ef+bIeniaAlqgSyRSIEvLwy0ovseKODq3i8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tGO18vTryUJtclGEEMpIKZ9qDtq9+ldnz29d VcJe0/82u2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRjgAKCRCPgPtYfRL+ TnceCACGO3+fevZv1U8RPVO43YLiBVFMzkzQUWnRwJQh8RC6wKHyRi1iJ7tZ2BSDGmtoktntbBV 6PpSd2kUSYSTFhD/XDJW3fL0YOJcoQUjgP7dZgyNffAw6+9q2wmIdjYvKxQF8mvW2D/ATVKid9P yOVGF7pIjrldUpLAffho2UMbm2onyCW+wnjjp757CfcIEgL3MXF6VK0uWRJ2SRt4fdAvzkeTu6f iU8sHEPWovJWdilQ3+KSP8kMBQHXiX+62EJ1j0epP2uSau/Rr4HTUm8+HYQfxLTRkP6yY4XqUsw qirMdAsUmV9/YX/xEC5h31zfk7Y1n5hQzKggs6EVadsMxhaJ
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
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 samples/qmi/qmi_sample_client.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index c045e3d24326..a42892523d3b 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -511,7 +511,7 @@ static int qmi_sample_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qmi_sample_remove(struct platform_device *pdev)
+static void qmi_sample_remove(struct platform_device *pdev)
 {
 	struct qmi_sample *sample = platform_get_drvdata(pdev);
 
@@ -520,13 +520,11 @@ static int qmi_sample_remove(struct platform_device *pdev)
 	debugfs_remove(sample->de_dir);
 
 	qmi_handle_release(&sample->qmi);
-
-	return 0;
 }
 
 static struct platform_driver qmi_sample_driver = {
 	.probe = qmi_sample_probe,
-	.remove = qmi_sample_remove,
+	.remove_new = qmi_sample_remove,
 	.driver = {
 		.name = "qmi_sample_client",
 	},

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


