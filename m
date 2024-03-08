Return-Path: <linux-kernel+bounces-97605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A8876C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9251F21DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B2604C2;
	Fri,  8 Mar 2024 21:31:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4E6025A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933474; cv=none; b=h1avMjGRqhO3OVb5E1jZHW+KPwcZAUNs8A+h1QC+5A+IyG2g7Y2o0RR9dI9tfcZHF5vrjiDCDhmVAg2XZKzrrxeCGl0P1WOlNcfI+SKlE4i7H3bMD5pTCJe/vK/yynXyzRY2MfCZCu4rG7+VWa0d8IcbEiipdq8E7jA+N7Mtx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933474; c=relaxed/simple;
	bh=TaaqNOWSJkXy0F7IVf1n1RlIVD1t1MB7sGe+8dh1j5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuTvfzjHco+w9pAq/MUjBV1qUj84KsB38MaoTM6i4v9TR1oJocWuG1rbZU74GMpZe+ThdS+84bmiKc8oXK3GX5cEOaahBi4tdVW5Da+R8NYC3ENIAqrY50fMV4S5WzCoR5u/ifjqNKIvKEyuubugCkISCaLZjbAeatwa0xXKysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho6-0004g3-2Y; Fri, 08 Mar 2024 22:31:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho5-005D0L-JU; Fri, 08 Mar 2024 22:31:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho5-002WXI-1h;
	Fri, 08 Mar 2024 22:31:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] uio: fsl_elbc_gpcm: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 22:31:01 +0100
Message-ID:  <ca99d4e71054e8452f3cee6c016bf4f89bfc7eaa.1709933231.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TaaqNOWSJkXy0F7IVf1n1RlIVD1t1MB7sGe+8dh1j5c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl64OX5hGi8U+O8ERDHKk5tBdjHmB1RtxmODPI3 c5O+zpssPWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeuDlwAKCRCPgPtYfRL+ ThvXB/4kRwJH5O6Hz7qioa4qf5+hLEFdR42Y0OXbKcCcA0oxiZuFrnnmzbDI4GnwE9OBSaaRSqW 8/U2QXE8Oh26byjqShSXRO8z4nnKbnzm1l6mJJCdx7ubY6k4jA0weNZphR8RmD9oRZJnqGM+LW+ sq/k1bbH/vUR+jHdk9PAvMHg7xc2JBIRR2Ws58dFwt8Ih/Hxb6uuwxWoJ3+izRGIyd5fndfAMPz pR54KNAf4f1ArVnXsLnDMQfLuYFgMOcu/V4dcsFvitYS7RCtZynT1u44rVzj4k587YJDohC4kay detX9m1Ho5bv7ATQvfQJiWgtsDC6CJNDB4KODn9kz4rUf1Hy
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
 drivers/uio/uio_fsl_elbc_gpcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 82dda799f327..496caff66e7e 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -427,7 +427,7 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uio_fsl_elbc_gpcm_remove(struct platform_device *pdev)
+static void uio_fsl_elbc_gpcm_remove(struct platform_device *pdev)
 {
 	struct uio_info *info = platform_get_drvdata(pdev);
 	struct fsl_elbc_gpcm *priv = info->priv;
@@ -438,8 +438,6 @@ static int uio_fsl_elbc_gpcm_remove(struct platform_device *pdev)
 		priv->shutdown(info, false);
 	iounmap(info->mem[0].internal_addr);
 
-	return 0;
-
 }
 
 static const struct of_device_id uio_fsl_elbc_gpcm_match[] = {
@@ -455,7 +453,7 @@ static struct platform_driver uio_fsl_elbc_gpcm_driver = {
 		.dev_groups = uio_fsl_elbc_gpcm_groups,
 	},
 	.probe = uio_fsl_elbc_gpcm_probe,
-	.remove = uio_fsl_elbc_gpcm_remove,
+	.remove_new = uio_fsl_elbc_gpcm_remove,
 };
 module_platform_driver(uio_fsl_elbc_gpcm_driver);
 
-- 
2.43.0


