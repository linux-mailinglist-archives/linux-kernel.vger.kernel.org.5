Return-Path: <linux-kernel+bounces-80171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CF7862B52
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CFD1C20D74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5594F17BB4;
	Sun, 25 Feb 2024 15:55:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAE101F2
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876517; cv=none; b=BR05nIQUmM2aT8rScYu0tVX4iAlvJiWYauOSiSO8CEuPlNG8Lr4IpmIQuc1pRGs6ZjHQVAS+PfutSHGAQ3OPu2sggS6j35d7yQVXbzPmP3FycF/jhW0AF0c7WU5aDnYnlNYuIbEmIXz19EIGIdcd86GXI4Iencm49DkgRD5+gCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876517; c=relaxed/simple;
	bh=s6vZIouknbu6Awi/o8UkPOP4WthXa1canuPxSaFlTYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgwdOOkY9En5bvAnPlPjYwZZg1pS/vzIhi0gbaRCLbNqvoT9RaRL32EG2/ux06AyC+0YIddmOCbymQlHOsNdxUV9voFLSbwz+sLIR2xSPWdM8SgIMPOvrn0tOE2ggBoLM8YAZzve5NVl4n9G8OCp2ITvzlyxbxv0wI5rELe9hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00006V-HQ; Sun, 25 Feb 2024 16:55:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqM-002pKA-NI; Sun, 25 Feb 2024 16:55:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqM-00BKos-25;
	Sun, 25 Feb 2024 16:55:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] extcon: adc-jack: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:50 +0100
Message-ID:  <14d30788ecd288b1b0983a8ea224499bbaa5de19.1708876186.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=s6vZIouknbu6Awi/o8UkPOP4WthXa1canuPxSaFlTYA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LPsxNnPL0evMcAjnNFGov2Wfat6TOeAzNCi VRiRv/W3c6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdtizwAKCRCPgPtYfRL+ Th+tCACOyFpFEjjXjtjC+3b0kCNOQPgfUCbHrBdNDdI3B87G9sx7AwukJ5lwlxG0+i0zGSytpmf VqVha3q6a6+PlveYv/YSFmc+mRh+AXvTPaJHIX+HCpyy93jl6tvcThtPiMhIu5mwc4ysvZTXB3H 3duhdIqcDfzJJT0ck7iQ+T5th8evyJWEFWOCD/1Pe3rjYa5ZUSC95JriXvD8Lsu9DegqaOMm9s6 Eu9gDS31NeIApWNsy6irC2rFqesgFlzUk6z2Vf25Yk3Wix2MGsWCb5HBF8MaDYg6IjlzBc6EMV8 WG+Zei3Yg5m+3ykaQJgvTDcH7hHrt3BTuh8nXfN7dS6XyxYd
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
 drivers/extcon/extcon-adc-jack.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index 0317b614b680..cf5050a244b2 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -158,14 +158,12 @@ static int adc_jack_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int adc_jack_remove(struct platform_device *pdev)
+static void adc_jack_remove(struct platform_device *pdev)
 {
 	struct adc_jack_data *data = platform_get_drvdata(pdev);
 
 	free_irq(data->irq, data);
 	cancel_work_sync(&data->handler.work);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -196,7 +194,7 @@ static SIMPLE_DEV_PM_OPS(adc_jack_pm_ops,
 
 static struct platform_driver adc_jack_driver = {
 	.probe          = adc_jack_probe,
-	.remove         = adc_jack_remove,
+	.remove_new     = adc_jack_remove,
 	.driver         = {
 		.name   = "adc-jack",
 		.pm = &adc_jack_pm_ops,
-- 
2.43.0


