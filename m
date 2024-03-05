Return-Path: <linux-kernel+bounces-93015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09CF872977
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7821F240BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5512BEAA;
	Tue,  5 Mar 2024 21:32:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29B12B170
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674350; cv=none; b=gP5QkZTGVPh/FqiUp574JWsSoFFzBS8t7FgsUw0RbUg0gzPQb6hkMmHwyVrAgnCsPzWZ/2wJW/RPteMEoEMTmMw5J6Pxs9819lQbef0AmbuysuByBwiVhRHVFKrZ+RzRZzGzxPZuSv31Mc62wpb2oHWP6d9nCgA8myvZBqipjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674350; c=relaxed/simple;
	bh=RJT3a4ZOwPoIbhWid5vTNbtT2kN70dCBJPBRAA1Z/9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMhfz/wJ1RGkevenR09I5+J3H5FzOt5dLwT0F269LtEm6zuvFYyJVXwyRmSj1+nNQF1JaOh1l2yMz7E+zyICu9jzE/6fni4os9ZiOh+/pUZ44Rr6bo8cjEKITvWp6CXC0UpMRZMZQBGoZ1/+7OvoMmOPV3DnGBkA/7VxZYExKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-0006r6-S3; Tue, 05 Mar 2024 22:32:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-004cmK-FY; Tue, 05 Mar 2024 22:32:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-000IT1-1J;
	Tue, 05 Mar 2024 22:32:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] reset: rzg2l-usbphy-ctrl: Convert to platform remove callback returning void
Date: Tue,  5 Mar 2024 22:32:04 +0100
Message-ID:  <e75fb1af5c7df5fc4073a26a99ba88633503910d.1709674157.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RJT3a4ZOwPoIbhWid5vTNbtT2kN70dCBJPBRAA1Z/9A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl549VQmg+RtR8EoSPs/S/N9KHg1dl76SpHxzU3 J7Nm3SftoiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeePVQAKCRCPgPtYfRL+ TkoIB/9e8T6UPxu2idafsNgeZDq9vGs5yhB9eAWO5GRlDPRAYljVprTakizUE4RDNw6+uigeMAS ewERXU34+dSOfgcYktcu6T2yx1qYywW/FwC7VqrkPi0tMh1XBMVTGgjuuvBKv/2fhu8AIeM1id/ 4fbflS9VfwVm+7WdbpDkKHuaVMVrbPtAEUTiPaSJY0eyp36aac58A/HXMPvHflxRrYRpR0B3rAU oGBGYie59oK6Rq2IiFzNiJgzL7JYbEfvl531M7Qf6HnXwu/2d3pn7krVYYfc1CjldoW85kJx8gY 3LuVXXEAT8xvuUu4R22gY3FTa5L/addOn1/0nmWJDfxtkiwu
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
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index a8dde4606360..8f6fbd978591 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -156,15 +156,13 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rzg2l_usbphy_ctrl_remove(struct platform_device *pdev)
+static void rzg2l_usbphy_ctrl_remove(struct platform_device *pdev)
 {
 	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_drvdata(&pdev->dev);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(priv->rstc);
-
-	return 0;
 }
 
 static struct platform_driver rzg2l_usbphy_ctrl_driver = {
@@ -173,7 +171,7 @@ static struct platform_driver rzg2l_usbphy_ctrl_driver = {
 		.of_match_table	= rzg2l_usbphy_ctrl_match_table,
 	},
 	.probe	= rzg2l_usbphy_ctrl_probe,
-	.remove	= rzg2l_usbphy_ctrl_remove,
+	.remove_new = rzg2l_usbphy_ctrl_remove,
 };
 module_platform_driver(rzg2l_usbphy_ctrl_driver);
 
-- 
2.43.0


