Return-Path: <linux-kernel+bounces-83702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E6869D75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9741C246FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C914D420;
	Tue, 27 Feb 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZ4RuptK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2811RZK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA514A4C1;
	Tue, 27 Feb 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054520; cv=none; b=tk4TlxoUF2vHXeumwR/i9usfad4d3qj7PT2i1gg3SxOMI+Ufcg+tCZ2490StiaIY9NrMU4+VNp6qyiiwIrQTI1IG0/oSvLi+bN9IGfbeQNNnf+c/vQclGZmgR+jQKMQ/1OhlnLqMFrquUfB062kfniJKFeC1lKfr5gn3GX6bCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054520; c=relaxed/simple;
	bh=1iiDPzJozphdnqBKrUNW5T1GsPEdcqNsY1H40tAw/ys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p5wtog8Ec+CAsVi1wTAmNhrSt8QYr6f+wzVb7onVXKQmfP3ZSNkJaDo9zOWKrvnYXn07ly3cSAYiTv5j5cjZxr6mbv902EC87wxP6plsv3u3yWbyNmmklRZNBboaqM17MMDkOmTC0Hc/FQfLPelBqPuzm/J8vyvyzRXC07xSodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZ4RuptK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B2811RZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oG4eRUOhm1pZBqeC5OyksUkg7giQd8I2oWRN9y//bwQ=;
	b=cZ4RuptKO0Knm7byEcwVbYWKaVVzyjMgVXLCDi1+/t09POi9SSKE9ioJNIxG3EffGLokrB
	MvbfvXhgBoDjnBJhwDBg2Hn/pTjco6HAt0av5Ax3hGrIDcqD3fsYVELVz93i9Xikq6qh1S
	/rd6236MtVb2ARUYsdW/51rvlvgLDN7DWpUwl7w1NmqOHTbstro0d7siTGQRB8ykxvT17X
	gezylwwn380uthuWkjGznG9/jauT1/u4sHtIf7DuTS+1XbmkiETOMZdjrfzbb4jIgiwZ2S
	uMe0Jw1PwmtZ2mY1zJgFBPsOza47/SiP4CuaOhtlJ7dl12X+i2ixjdihyGVH3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oG4eRUOhm1pZBqeC5OyksUkg7giQd8I2oWRN9y//bwQ=;
	b=B2811RZKjGoT7QhmEuLFpkgXlzFmbsvMF9kJINt7caED4TFVkrDR3PotBuJf73xR1E9776
	eKN809MjLXxM9CAg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx-intmux: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3Cedeee074956dd943d3c67da894a01dc5f0d33bd7=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3Cedeee074956dd943d3c67da894a01dc5f0d33bd7=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451619.398.9350689553970478944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     984e5c7b8d7bac9efd3818e06dcf1f7aab7701b2
Gitweb:        https://git.kernel.org/tip/984e5c7b8d7bac9efd3818e06dcf1f7aab7=
701b2
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:09 +01:00

irqchip/imx-intmux: Convert to platform_driver::remove_new() callback

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

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/edeee074956dd943d3c67da894a01dc5f0d33bd7.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-imx-intmux.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index aa041e4..656eab2 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -282,7 +282,7 @@ out:
 	return ret;
 }
=20
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data =3D platform_get_drvdata(pdev);
 	int i;
@@ -298,8 +298,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
=20
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
=20
 #ifdef CONFIG_PM
@@ -354,11 +352,11 @@ static const struct of_device_id imx_intmux_id[] =3D {
=20
 static struct platform_driver imx_intmux_driver =3D {
 	.driver =3D {
-		.name =3D "imx-intmux",
-		.of_match_table =3D imx_intmux_id,
-		.pm =3D &imx_intmux_pm_ops,
+		.name		=3D "imx-intmux",
+		.of_match_table	=3D imx_intmux_id,
+		.pm		=3D &imx_intmux_pm_ops,
 	},
-	.probe =3D imx_intmux_probe,
-	.remove =3D imx_intmux_remove,
+	.probe		=3D imx_intmux_probe,
+	.remove_new	=3D imx_intmux_remove,
 };
 builtin_platform_driver(imx_intmux_driver);

