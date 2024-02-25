Return-Path: <linux-kernel+bounces-80172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E9862B54
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D10B216A4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59E17BC9;
	Sun, 25 Feb 2024 15:55:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F611CBD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876517; cv=none; b=Ey849Gc6Zjiq7I4V/Z45KN2vA+m3xogNydIbTcDuhyGyqQN72y/7AmtTIAZu6/xORIAgttdIiDpyJoskUdHLcWbxd2TPapVpWZN9oujqj7Ta4cwIZga3Wq2P8ffOF+7mPdUWMGOqqQ0yUzQuzLfTkbupKBjkGV1ErimQQ1sJtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876517; c=relaxed/simple;
	bh=bT3FPuKGfu5sg2ALrqyc+CPGB75k/LYeCfj/omk7rCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icAuhlhD1APGNIXTDzzPxXfrFB+QTg2wxnbllUYU+Q3f8IsMracgA8roSYSsLyM9Wp0yzOD1EyPRpxA27VfrbAWVUQMn73AOglUu+Ct68NTw8vyiQEVq7qvZL8IYaS9Fo7sdaDee4pz8zDvI7Aef12WGWfRGiAiAoGdOlSDhmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqO-00007K-8l; Sun, 25 Feb 2024 16:55:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-002pKU-ST; Sun, 25 Feb 2024 16:55:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00BKpC-2b;
	Sun, 25 Feb 2024 16:55:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] extcon: usb-gpio: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:55 +0100
Message-ID:  <8914cd71b32e1f6298e65b84fb84370c73b4fe37.1708876186.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bT3FPuKGfu5sg2ALrqyc+CPGB75k/LYeCfj/omk7rCE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LVgQQFCb4WwvMybozyNiyBwLzv2oMOJQDhd xa90QPLIdaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdti1QAKCRCPgPtYfRL+ ThNxCACUdOqD9UjEpa6woQDAlgPLPi/jUt2ART8HxYgqCyy5haCEq/+LUhyR7QY8KaPmLC+eGLQ Bb5c3NE1gFQyZfZbj99A7o1j7e0Mgmq8eEW8oyZlZhL3SNVtzhYhU0vVv2bkpCO34aGbhlICgw1 /4o8e9imO8sbvI4+oTwoCzeiuafn+nxxl/qoLGHo6TQ0uw96w/axiNmihVKY0nqSYvwY3w3KAk7 YGU6Oyn/Aszzr5MkRzLItaTmoXeT0dDUBKoYeP7hvcuitu0eS5tVvulVyPs/cHelbDQHiT+655q Mbb+lHN6WA4UF3PPNCNNgIMD6PdXPhDIBhZIFLLwt4MN1lrv
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
 drivers/extcon/extcon-usb-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
index 40d967a11e87..9b61eb99b7dc 100644
--- a/drivers/extcon/extcon-usb-gpio.c
+++ b/drivers/extcon/extcon-usb-gpio.c
@@ -193,14 +193,12 @@ static int usb_extcon_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int usb_extcon_remove(struct platform_device *pdev)
+static void usb_extcon_remove(struct platform_device *pdev)
 {
 	struct usb_extcon_info *info = platform_get_drvdata(pdev);
 
 	cancel_delayed_work_sync(&info->wq_detcable);
 	device_init_wakeup(&pdev->dev, false);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -281,7 +279,7 @@ MODULE_DEVICE_TABLE(platform, usb_extcon_platform_ids);
 
 static struct platform_driver usb_extcon_driver = {
 	.probe		= usb_extcon_probe,
-	.remove		= usb_extcon_remove,
+	.remove_new	= usb_extcon_remove,
 	.driver		= {
 		.name	= "extcon-usb-gpio",
 		.pm	= &usb_extcon_pm_ops,
-- 
2.43.0


