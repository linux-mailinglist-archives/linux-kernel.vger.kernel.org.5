Return-Path: <linux-kernel+bounces-83701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607C869D83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25CAB2C0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A514AD02;
	Tue, 27 Feb 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGCv5zMw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahxP/0/V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF0149DF3;
	Tue, 27 Feb 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054519; cv=none; b=MtT13nmfINl/NPOJA813q5XRdLx7mpnrwXh9PNQlS8jaIw5dHhGbVah4WMsXW+ucnvQ0ld6/QG3T8+ZanTXaWyerpe29Ycs+N9oD5kyimIJakJgTaVYHmlWhxWu8lMBhQt50eZFMTVTJkH8Y96ZfDt8VARcFs5se7UYyMa7TI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054519; c=relaxed/simple;
	bh=yBia7iFXnSkBkPGE5Bmhn6YjuNem06IVGXexDC03CnA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QaqkpV4ybkuHTvnSjxhFFf7bRUcP8DOA8EysCDs9C6ZEqgi3JOnHx0QmKBWXeaYtl1KxWr2N0z1MZKls819mWJ2mkWHHe83+1pZihRVco5KUoa7dknhnzzFW4yCKxaCLswDDwmsHI2SgGCWfu1pd11oZ882o1U9GviagnWwoYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGCv5zMw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahxP/0/V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgOnFrCZwQRBYgC32DiNVf4dHEsJCOH2FKLwFRaMliM=;
	b=mGCv5zMw0zkwzYWox2buCSjkQ1QGSRVWID8gLgvwdIxTVfhmL5e7NA4Kfq4On5zC39NR4l
	QgDKHrYXD5h6y4NxcSgQTYL5uMuyHectN6DumRC4kzx915/np5vm9Rtd2TJ65/TEUxOMoL
	v+Si3erRwdHtbuY8xWx5tL8b2fLBZ10tk+1LcgKMIBfnQb+sipvkg9krDGYFHenQk1/6I0
	yyQNQ2WAdkqDZyyOyhxVgM4Tbh+L0tTRdT0BeYN6PE+cwgalWHKb385qtl05alWff5nfQG
	CZxD23upAcCAQnGJQDJZQH+uzc6oMLWOZ5XYzZnd/iJkwbHq+yntEDgckiLKPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgOnFrCZwQRBYgC32DiNVf4dHEsJCOH2FKLwFRaMliM=;
	b=ahxP/0/V/9n9gK2lqdDYeyIdTvGJjDZ7m1vO/h5e3dJAPhAY/Ku3WIAZZcAhQG9FMIuEY3
	HQMVi6yedpfG2yBA==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx-irqsteer: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3Cc0e5afe62256860150d25bcf644f2b8d62794c86=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc0e5afe62256860150d25bcf644f2b8d62794c86=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451528.398.16822133116774035735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5fcf3688e8755cb81fa48fc0fe724cde877491c3
Gitweb:        https://git.kernel.org/tip/5fcf3688e8755cb81fa48fc0fe724cde877=
491c3
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:09 +01:00

irqchip/imx-irqsteer: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/c0e5afe62256860150d25bcf644f2b8d62794c86.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-imx-irqsteer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index bd95433..20cf7a9 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -231,7 +231,7 @@ out:
 	return ret;
 }
=20
-static int imx_irqsteer_remove(struct platform_device *pdev)
+static void imx_irqsteer_remove(struct platform_device *pdev)
 {
 	struct irqsteer_data *irqsteer_data =3D platform_get_drvdata(pdev);
 	int i;
@@ -243,8 +243,6 @@ static int imx_irqsteer_remove(struct platform_device *pd=
ev)
 	irq_domain_remove(irqsteer_data->domain);
=20
 	clk_disable_unprepare(irqsteer_data->ipg_clk);
-
-	return 0;
 }
=20
 #ifdef CONFIG_PM
@@ -307,11 +305,11 @@ static const struct of_device_id imx_irqsteer_dt_ids[] =
=3D {
=20
 static struct platform_driver imx_irqsteer_driver =3D {
 	.driver =3D {
-		.name =3D "imx-irqsteer",
-		.of_match_table =3D imx_irqsteer_dt_ids,
-		.pm =3D &imx_irqsteer_pm_ops,
+		.name		=3D "imx-irqsteer",
+		.of_match_table	=3D imx_irqsteer_dt_ids,
+		.pm		=3D &imx_irqsteer_pm_ops,
 	},
-	.probe =3D imx_irqsteer_probe,
-	.remove =3D imx_irqsteer_remove,
+	.probe		=3D imx_irqsteer_probe,
+	.remove_new	=3D imx_irqsteer_remove,
 };
 builtin_platform_driver(imx_irqsteer_driver);

