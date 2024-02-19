Return-Path: <linux-kernel+bounces-71968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507C85AD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11078284A41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52415537E5;
	Mon, 19 Feb 2024 20:29:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644D51037
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374559; cv=none; b=h0jeQHJe1pHZP809H4qZO7PrK/Hksd3HwDoXUmYNmz03qSDINszHyStXyh79ZTtXfYnwbC1uj1g0hzxyqSIYgf7G1/eK4skSpJmRuorN6wy0nDcgaStgFiSVIo+31BVAaSdlLjheoEhfsx/gXaPr+tqyVp2NqxwQX8kUB6DCoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374559; c=relaxed/simple;
	bh=r+zd/WCnRKZ1ONNCYG3jHdIcJHBF1vRFZXywT0FOEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmguTpoMvEfchMSnUgA1YxqfWFtGYMdqqNfeBp0uda66ufzYxTN+2euWT3afCiHM0m1n9fjjjKfpnD3mIVn146mbdhPHEgaoRTb9jkzqi0VcuFVw8omSMiIEszhlVKO+bI+iHgNDF4HMs7dW4gXOcsmYZqxfFzML0RU9io3hBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcAGK-0007M9-3F; Mon, 19 Feb 2024 21:29:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcAGJ-001iQT-Mi; Mon, 19 Feb 2024 21:29:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcAGJ-0084Bu-20;
	Mon, 19 Feb 2024 21:29:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] w1: sgi_w1: Convert to platform remove callback returning void
Date: Mon, 19 Feb 2024 21:28:36 +0100
Message-ID:  <68632fffa01f69eeaddfc0ad9de8f067b164e4fb.1708340114.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=r+zd/WCnRKZ1ONNCYG3jHdIcJHBF1vRFZXywT0FOEl8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl07n1a5bnLeQQUvLb7aYKJVGTC5kvi7axNWf7o DBld7ZvJF+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdO59QAKCRCPgPtYfRL+ TrvOB/9MbNwxgiXhhyVH1fI+1ItOQu9GdpyL20nbCPk/yVCfJglCdW52nnr2MLrzer5RDxBB6Hn hcrKt9LSEa5ZmlmAfE8Ucxs2nedsNtQ0MwA7YQYA4dWBFioFdIGkhLh5hikAC6zYJfMBziXhpvI hTc05rVo5xjoGi/JN1agSehutA8PbPFbtyc23God70nUF3sUpCtSgFGYJzgKXcCLL0lC6y2vCmy Sm7oISEAxcvlz2qbEI66K0wQiH3EWrKa2t6zfSQskRcZAW9VTI3CKMC8znOyLDVlt7Wxsa/G8Cn 5FFLNhHlIaqYwKvq0k470aoVP0V+hhDOjVXEGkzrbLwePb0u
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
 drivers/w1/masters/sgi_w1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/sgi_w1.c b/drivers/w1/masters/sgi_w1.c
index d7fbc3c146e1..7bb7876aa70e 100644
--- a/drivers/w1/masters/sgi_w1.c
+++ b/drivers/w1/masters/sgi_w1.c
@@ -105,13 +105,11 @@ static int sgi_w1_probe(struct platform_device *pdev)
 /*
  * disassociate the w1 device from the driver
  */
-static int sgi_w1_remove(struct platform_device *pdev)
+static void sgi_w1_remove(struct platform_device *pdev)
 {
 	struct sgi_w1_device *sdev = platform_get_drvdata(pdev);
 
 	w1_remove_master_device(&sdev->bus_master);
-
-	return 0;
 }
 
 static struct platform_driver sgi_w1_driver = {
@@ -119,7 +117,7 @@ static struct platform_driver sgi_w1_driver = {
 		.name = "sgi_w1",
 	},
 	.probe = sgi_w1_probe,
-	.remove = sgi_w1_remove,
+	.remove_new = sgi_w1_remove,
 };
 module_platform_driver(sgi_w1_driver);
 
-- 
2.43.0


