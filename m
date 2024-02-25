Return-Path: <linux-kernel+bounces-80174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097B862B55
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D061F2817F7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA01B59A;
	Sun, 25 Feb 2024 15:55:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADBF1799F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876519; cv=none; b=TzZGRwxJJPgWdmyuWGNYzo465TBBDMBd8Qqy7TLOTjxTHTqUpKOQ3OB/SFyyfD+VY8TXmmuoxxXP7HtdhGnM3CoLoJ59A3QZ0eoTYnTJQqwCvMqeS0nv3zAQSrSNMfwmnLzoYC34i+o7jYsisdNJUb88usG2ag+eSy/YQhbz4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876519; c=relaxed/simple;
	bh=UuZYWOa89eHlHR4UPrFuYfV6ZZKmYfISpH6emRmR32Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecFONfOhe5XaK5iLhO2QLPDZs0l+0BGGmFVdVRXf6KF9ECIvM4Z9kBVMXdHj2n6zp58R4ynhQQ5F/PoRrU9bHnED+MGQ8IohCGjd5BjewQiYS89TXBmp+w6L0dRBHYn9okTZSMvFW+T/ZFsc1SreC16I0a+KvvnddBx2lLf0fJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00006W-HQ; Sun, 25 Feb 2024 16:55:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqM-002pKF-W4; Sun, 25 Feb 2024 16:55:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqM-00BKow-2w;
	Sun, 25 Feb 2024 16:55:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] extcon: intel-cht-wc: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:51 +0100
Message-ID:  <87f0b8f158565cb9ea68b42db2bb018f82a7ee27.1708876186.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UuZYWOa89eHlHR4UPrFuYfV6ZZKmYfISpH6emRmR32Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LRMs74IYM8KRHlBfQXhdldwEVVxjWhCHuZm RiEsmGOlpeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdti0QAKCRCPgPtYfRL+ Ts38CACjV8KO4l/kx+h6REYW4CyVrftN7YTwT/P0yw1bDYD9Z1G2pFm+Cj7nDHK1oPCRKuyyoK1 2JiC4gDn1T9eR7ZA5amZcpMqAOEwtlaxruP8A50FFGvWrCOPIjSXjnp0ukRWkIrpA4aswI+5V7n ZB1vB3Ou8gKeDBuiFlW+P9vB14pd3hX1Y8A30RUvjaTlndh5eggF1xc01bUecMoZzPwWNC9/55m PY74KaL1dMcwI6lW7xBfbk6oqc5GOd4xxK/ev6TftR+MBOrgFum+9r7Jz04BROX9YCgAi2a8gU5 W7jyM4fQFvxhpTOTDsISooBOtt0O77nE23T2DsbhHAPq3syA
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
 drivers/extcon/extcon-intel-cht-wc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 2c55f06ba699..733c470c3102 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -617,13 +617,11 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cht_wc_extcon_remove(struct platform_device *pdev)
+static void cht_wc_extcon_remove(struct platform_device *pdev)
 {
 	struct cht_wc_extcon_data *ext = platform_get_drvdata(pdev);
 
 	cht_wc_extcon_sw_control(ext, false);
-
-	return 0;
 }
 
 static const struct platform_device_id cht_wc_extcon_table[] = {
@@ -634,7 +632,7 @@ MODULE_DEVICE_TABLE(platform, cht_wc_extcon_table);
 
 static struct platform_driver cht_wc_extcon_driver = {
 	.probe = cht_wc_extcon_probe,
-	.remove = cht_wc_extcon_remove,
+	.remove_new = cht_wc_extcon_remove,
 	.id_table = cht_wc_extcon_table,
 	.driver = {
 		.name = "cht_wcove_pwrsrc",
-- 
2.43.0


