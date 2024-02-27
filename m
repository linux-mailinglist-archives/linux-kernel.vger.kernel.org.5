Return-Path: <linux-kernel+bounces-83697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D3869D69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDABA1C22BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A793148FEB;
	Tue, 27 Feb 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugUttNfp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYcDdY4P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096C4F88E;
	Tue, 27 Feb 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054515; cv=none; b=OLqLMJmTJ/fn4XT14rf4I1h49qRdEv132A3bw0d341voDv8QMeHNtqTurATxjIt56QggsHNyLLjPz5ZFMBFJBqim2QvB+C4qXhiJ04+0JhiutQx9m4abq78nsJwsyrHH9N/2+1OrkMi1ZD3Pitc0TI/Ypc0ox4IuSqYxgpPtM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054515; c=relaxed/simple;
	bh=auIPyEBnf9ErcAdx4eZFBluozZQSAGoztMKtzTNkaUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UeVuWdCv3saEQhK6+YGYHjZlMHAxXi/KsDZYHkEvbVeMetzkORgzqRP3LH7tqQHqG1q83MQaaLPZl8EWKRJgCbjW4Bb9oPd5fxxkfCoepLM9+nnllScqNwTtDy3PvbM0g4A2/W4wlZ5Igp/IzBvdpHlnEZ2QbOj3/jEOYCBcGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugUttNfp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYcDdY4P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYdll+dqDDCneWK2zxJs1G/do0WBLWyVZ49tIn5GQMI=;
	b=ugUttNfpJMUQSNE+WZZfLwIlRds+HXxykmfwvHaRMxfYU0yNzXAy7AGRBJQAlJMMXRQbb3
	PxY01KvWHHNWA1Xbg8jVoTZkpwxSSukgh3clqs7WbctgFv0qWClWZx7QteSs8VE/apoUxU
	M+7IDc9m9cQT4Ft05Upm7/1Aq+im7U/r0RWDCK+V0zQJDCKLJDIUS1AmqiMlDhg4Gtb4Bd
	Fse+U5YlyiKqRuq3wQexNl/VkygaCyRl2Wzf6ouNU2dX2dPx9/viBwjsuzNvMsHEFCiWRG
	RCiPY5vfb+FTe6UXkALvVuuldaKcxWeDnBZmTe1567Qc+5Me4GUiCG4oFtFB0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYdll+dqDDCneWK2zxJs1G/do0WBLWyVZ49tIn5GQMI=;
	b=MYcDdY4PrjoAiibG1Wf/vl0RuuOCR6ECCYmgV52wJtp8Ut0ZfBzWYjH9LhQt3ZkwtaLqfG
	4UomCPsjTVE4wmBg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mvebu-pic: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3Cdf977ad4c02ff913b01cdd6c348e7fae3e08e651=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3Cdf977ad4c02ff913b01cdd6c348e7fae3e08e651=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451163.398.10638506921918938694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b7b58085a5b57bbe83194e12c31977f345c87cce
Gitweb:        https://git.kernel.org/tip/b7b58085a5b57bbe83194e12c31977f345c=
87cce
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/mvebu-pic: Convert to platform_driver::remove_new() callback

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
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/df977ad4c02ff913b01cdd6c348e7fae3e08e651.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-mvebu-pic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d364..d17d9c0 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -167,14 +167,12 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int mvebu_pic_remove(struct platform_device *pdev)
+static void mvebu_pic_remove(struct platform_device *pdev)
 {
 	struct mvebu_pic *pic =3D platform_get_drvdata(pdev);
=20
 	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
 	irq_domain_remove(pic->domain);
-
-	return 0;
 }
=20
 static const struct of_device_id mvebu_pic_of_match[] =3D {
@@ -184,11 +182,11 @@ static const struct of_device_id mvebu_pic_of_match[] =
=3D {
 MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
=20
 static struct platform_driver mvebu_pic_driver =3D {
-	.probe  =3D mvebu_pic_probe,
-	.remove =3D mvebu_pic_remove,
+	.probe		=3D mvebu_pic_probe,
+	.remove_new	=3D mvebu_pic_remove,
 	.driver =3D {
-		.name =3D "mvebu-pic",
-		.of_match_table =3D mvebu_pic_of_match,
+		.name		=3D "mvebu-pic",
+		.of_match_table	=3D mvebu_pic_of_match,
 	},
 };
 module_platform_driver(mvebu_pic_driver);

