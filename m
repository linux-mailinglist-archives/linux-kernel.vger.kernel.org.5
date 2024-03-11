Return-Path: <linux-kernel+bounces-99588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181E878A61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35F31C2152B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE25811C;
	Mon, 11 Mar 2024 21:59:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFF57323
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194392; cv=none; b=dVxtcuole9KkhL7OLP2IyFe6xOxMhNLRqJV26QOgmckJuZzdmU/8a1tNkRGTudw83MCBWls3fOJpIWSwpeHrtVoixITHgIu1Zhdo9y7oCeN1RyFRkUMbKaV+byWkLv81uoM/wfVuiWb094d6oaRuAI/+/I5YrSPcGRVEoN2nhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194392; c=relaxed/simple;
	bh=sJAchNzXAv9E3hkPsb4i2oZNryNTPj084Bm1vvR01RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw6mP0pbqXuBYdgPFAGjXuF1wolt5I9wNiQXkZXbJwwazXmTtpefnMTbA3Xt4Q506UHcJhuJv6EzIoyyVHhCwnc/KhqWTgt52Yio/uRG3zUuIdsvcR1gZd64I/Y3Nx1fgFo0gUjGro2ozsuOBikz1Klmn0zfSAH85CHy4L1XqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-0006Cf-HI; Mon, 11 Mar 2024 22:59:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-005nEy-4m; Mon, 11 Mar 2024 22:59:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjngP-004JCE-0E;
	Mon, 11 Mar 2024 22:59:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] auxdisplay: cfag12864bfb: Convert to platform remove callback returning void
Date: Mon, 11 Mar 2024 22:59:22 +0100
Message-ID:  <e14f61b16189138baceb72cc3a9c34698787ea92.1710194084.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sJAchNzXAv9E3hkPsb4i2oZNryNTPj084Bm1vvR01RI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7367bct4lW/IFOLs/9zOUh9xzn0wYnWk3dwId 0a2R8FhuUaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe9+uwAKCRCPgPtYfRL+ Tu1LB/0R5hJGYy3KJDdsu0+UxjJkjj5GaMv6AwNzlXyr2F7Q0hJD1Uro8E32M/RVbaHohHydqiF PJfmzQZt1h4NcLXyO3t10XR4Y9c11gAqylaUcwiG16rKjH3tQwnE7erQ1A/WAEiR8NZ81ojWpD6 wTloPD3/UHMidkR8Lu0QPSftuPyJgnFjlNCdRnsNVZGKg/UN09lMyrNMlbp7SjGc1HNA4NPexrP cBIMYaaywW16u7NGsoVWNY0jXfg84593oolLWUOGpYSOKBWstqnlzTtXrEXm0X1rZcKo4ras6dA /v68KJGLKq1EiPyZhqf04CuLkMDC4llPAVsdSVKP9T1LyOlP
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
 drivers/auxdisplay/cfag12864bfb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 5ba19c339f08..2b74dabe7e17 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -96,7 +96,7 @@ static int cfag12864bfb_probe(struct platform_device *device)
 	return ret;
 }
 
-static int cfag12864bfb_remove(struct platform_device *device)
+static void cfag12864bfb_remove(struct platform_device *device)
 {
 	struct fb_info *info = platform_get_drvdata(device);
 
@@ -104,13 +104,11 @@ static int cfag12864bfb_remove(struct platform_device *device)
 		unregister_framebuffer(info);
 		framebuffer_release(info);
 	}
-
-	return 0;
 }
 
 static struct platform_driver cfag12864bfb_driver = {
 	.probe	= cfag12864bfb_probe,
-	.remove = cfag12864bfb_remove,
+	.remove_new = cfag12864bfb_remove,
 	.driver = {
 		.name	= CFAG12864BFB_NAME,
 	},
-- 
2.43.0


