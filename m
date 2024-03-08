Return-Path: <linux-kernel+bounces-97606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B729876C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A272821FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD2605C8;
	Fri,  8 Mar 2024 21:31:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB175FB8F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933475; cv=none; b=vEj8gYR2opEIOUYoHNjcjr1sk2GcrFiBHUctg/gIOEexyZdWrvNZU16Fk84s1kUSAZ7HnfKv71uOlI4YDdUjuJiVb5R/iBvRQ9GRxX/vwSH//bv6Y+3mK/IjOtd2L9gPU8RjHVdkU9muHd3uhQKurR8eD5v3adO3xFZH+BM6gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933475; c=relaxed/simple;
	bh=e4QWWPA5Cs+kCP0dOK0A8iAqYDs/2ITiIBiXdA0C+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZIcDNEiS8GnxtMu2qgXfUalYNJqVw+WBbIGFV3ipzVVCqG4BSfUUAALMr++jIC/u61feeeL+bv7XZDegejwUx9cIrEvk0GZIFtMl233kqTP8PDHe7DHBJslh4a4yJBoH9kZl3vFjfzVslvyMad1UxqlK9TK/YNF38ZhbgHeXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho6-0004iK-6x; Fri, 08 Mar 2024 22:31:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho5-005D0O-PQ; Fri, 08 Mar 2024 22:31:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho5-002WXM-2H;
	Fri, 08 Mar 2024 22:31:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] uio: pruss: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 22:31:02 +0100
Message-ID:  <c57a6d6c9842d2905c0cd3d8ae83ab6ed8a57a41.1709933231.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=e4QWWPA5Cs+kCP0dOK0A8iAqYDs/2ITiIBiXdA0C+tY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl64OY/Mhq2wkRNkJmOkndodCTyVS0sWAaKJ5sh kluygqQVVyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeuDmAAKCRCPgPtYfRL+ ThfYB/9JdOTSOwytRG7bQS8eB2ewlp/5ERnj+Ys5xSPLKA8Q1u5EJavym3by61+9NLtkirXIM6f p27Y1+DGx3axEo64PXgz2drYdPnvJHTu2g+MvyIHqzKt7LDlxMWu9fO2HjGAfw6ZePlm2S+cFQ5 JzfeL9KBhRh/+dI14tNV4nzNztvG/4mkI9UnIiaHsbjg5LBPZxBJH19m3oJqD3YFXYghXevQlDt j+wFDk3OlCO/bPl8j2h5emRgsAMyGzu0NAnDEfjPUWm7HWzgFTev/wGZbF5ra8+UweFlVLObx0f XXrxxHbae416EvN2ElnrDvuAyhxd4AUFf7kVCQkXe/h8ellF
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
 drivers/uio/uio_pruss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 77e2dc404885..fb9f26468ae4 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -229,17 +229,16 @@ static int pruss_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pruss_remove(struct platform_device *dev)
+static void pruss_remove(struct platform_device *dev)
 {
 	struct uio_pruss_dev *gdev = platform_get_drvdata(dev);
 
 	pruss_cleanup(&dev->dev, gdev);
-	return 0;
 }
 
 static struct platform_driver pruss_driver = {
 	.probe = pruss_probe,
-	.remove = pruss_remove,
+	.remove_new = pruss_remove,
 	.driver = {
 		   .name = DRV_NAME,
 		   },
-- 
2.43.0


