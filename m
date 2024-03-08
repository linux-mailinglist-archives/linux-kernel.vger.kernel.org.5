Return-Path: <linux-kernel+bounces-96699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A1876033
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4750B1F2798F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958D52F79;
	Fri,  8 Mar 2024 08:51:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD3208AD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887915; cv=none; b=LdObgf5rxYDM/mljOqc5UBZRyZN0Wsakk5BEXZLEMGvNTme2r9rlm/iVNhyCn+hor+acvLBNn/PlC2b52OmKyUo3u8vWMEsiYR3I4MxVwnQHTgQPD7wR/bi23pPw4vNm3JMMOj+vsxiym+aRKp/hFuByMOiVbGAWXoT3aGw72ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887915; c=relaxed/simple;
	bh=HzOOKlpotdcI4Imwhan0hrJ+1oJIJUGTngvX/AL6Wcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jn0XicmweeXu8agNeTmAXIKoYr47YL4ieYTQY6Ky48m9lSpvrSzpCfD5JEYhfbJEmEhf+414laV+YAwEVB8LWMRIgu0bFiNgb4DJCbKq2Z7H/jRRKgUp27TJPUQDUWsRWlukI8utEveSzTPhHHrChB8r0jSezxORcLYVrlugwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0006wq-P2; Fri, 08 Mar 2024 09:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0056NZ-9v; Fri, 08 Mar 2024 09:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-002461-0j;
	Fri, 08 Mar 2024 09:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pps: clients: gpio: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:15 +0100
Message-ID:  <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HzOOKlpotdcI4Imwhan0hrJ+1oJIJUGTngvX/AL6Wcg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tGHbMsTnW17uf5+4SvPsxJFSDzF+Dl208lOm 2GKBhUaY9GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRhwAKCRCPgPtYfRL+ Tl8UCACsNaPthQnjjFLTic8e7Wd6XXK331cMPf1nNJRI3S/3KkOZACY0GxQDFUF/Gt8E/HuVby9 e2TTt/9VJCibfbtRtAq3ofI1y7mbnFQCqC66LMtlJf+cOYMDJ+ryXThL7bcNi9x2EhJCHESN8LK konjpcOClYJ9fsBEkpQIanLdN7mdChP16SIUZps/mklOe6zzN4SugiziWhs0tvM1afs6fYIX24L uinMPcRBgvjPZhwfOacqhu35zmL7LMgFZmKKt86W+m8+wqNvCwUnXfC98ig8JVA6ywAfqH/7Sqb izCX4lI12vj7eJU1MaJvpygNrRbsf78b2rnLomaR6poU3u/C
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
 drivers/pps/clients/pps-gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..791fdc9326dd 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -220,7 +220,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pps_gpio_remove(struct platform_device *pdev)
+static void pps_gpio_remove(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 
@@ -229,7 +229,6 @@ static int pps_gpio_remove(struct platform_device *pdev)
 	/* reset echo pin in any case */
 	gpiod_set_value(data->echo_pin, 0);
 	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
-	return 0;
 }
 
 static const struct of_device_id pps_gpio_dt_ids[] = {
@@ -240,7 +239,7 @@ MODULE_DEVICE_TABLE(of, pps_gpio_dt_ids);
 
 static struct platform_driver pps_gpio_driver = {
 	.probe		= pps_gpio_probe,
-	.remove		= pps_gpio_remove,
+	.remove_new	= pps_gpio_remove,
 	.driver		= {
 		.name	= PPS_GPIO_NAME,
 		.of_match_table	= pps_gpio_dt_ids,

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


