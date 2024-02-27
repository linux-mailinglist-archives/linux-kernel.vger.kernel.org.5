Return-Path: <linux-kernel+bounces-83698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DE869D71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361F8B29D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC7149DEF;
	Tue, 27 Feb 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="baSde4sM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pqoZ+ET7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AC146908;
	Tue, 27 Feb 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054516; cv=none; b=Ixpq77wN1eJZpAQ3lYGkphudhKM+smiJakfqc493KtifJKJ2czWaowzzSgTRqozIzZD3C4x5Dgz9M/dbBU1h0GY7qc2um0FNbRJmcH3ZRa0qjuWDtgbIH4IMzXbuY2l7EY0yZ6uti9Ulvv8gvVwsyW9BbdWT+zlsuRf86Qf350w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054516; c=relaxed/simple;
	bh=y0JLCFuChGLkwaZhfLtU1K5oerT0bmx7Gx4vH0MW9nE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JrRfZY73yVZxXQEAoi7bCAnyyhR5kHtsyh7/fAqE4vMClwD1DHtsXnPT12Yf/KW6sO4J+7gQRaapgCC2hvmMAKUh+7e1clu8Pz3E6RHSO7efBHmvHWcbl81bprdKiAFzaew++QxBqoSIlDv9u4c8dZbKVhbn5KPiNKde9ZSjX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=baSde4sM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pqoZ+ET7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhM4d6dg1koTzlaPLZJTgSr0duzrY7T5QVSZ+EPXJEM=;
	b=baSde4sMpV/QQksWECdXUIDu/Tww+oA8W4LR69AVufbZdyxGkPOA0l7Xbw3fMRmmVpBOb8
	pKSnXjz8RTVdRIcrEvKmreT2OUsJHA97mFBZeJIENmM2aIXALlgapB1zDZLqCr4MVhOIbe
	NBjcfo/rDLmEdDSpna0uq7Q2Xwc0mQwCoeUM6OsJWEi7RBOMpGX+w9g3HPxFuTU8/DR582
	4G0+Mtqz2t+qEAT5Y3naksx8VZZW+3EyvMEq74YpN59L9LFTSfP3RxE8s6oUIHP+OurxUw
	U7MSbX4/n+T7LMF82ckuVH7S9q68mL3gdCFxAIF6+ovQdYqyjBbj9aWPZnIw/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhM4d6dg1koTzlaPLZJTgSr0duzrY7T5QVSZ+EPXJEM=;
	b=pqoZ+ET7HPQkFU+/aCzQfZlTSbhsc6yVlICNorbLdkfkEAj5QJmJvVUn+6EeKlqrinYGPD
	eZSb4uhym/+sqKDA==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/madera: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C64c2f79760c53f29651e7126418c407ff699317d=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C64c2f79760c53f29651e7126418c407ff699317d=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451255.398.2362250081736295349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8d0f3e7bdef44236d33ac4a5f2106602e0d4e1ea
Gitweb:        https://git.kernel.org/tip/8d0f3e7bdef44236d33ac4a5f2106602e0d=
4e1ea
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/madera: Convert to platform_driver::remove_new() callback

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
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/64c2f79760c53f29651e7126418c407ff699317d.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-madera.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index 3eb1f8c..acceb6e 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -222,7 +222,7 @@ static int madera_irq_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int madera_irq_remove(struct platform_device *pdev)
+static void madera_irq_remove(struct platform_device *pdev)
 {
 	struct madera *madera =3D dev_get_drvdata(pdev->dev.parent);
=20
@@ -232,13 +232,11 @@ static int madera_irq_remove(struct platform_device *pd=
ev)
 	 */
 	madera->irq_dev =3D NULL;
 	regmap_del_irq_chip(madera->irq, madera->irq_data);
-
-	return 0;
 }
=20
 static struct platform_driver madera_irq_driver =3D {
-	.probe	=3D &madera_irq_probe,
-	.remove =3D &madera_irq_remove,
+	.probe		=3D madera_irq_probe,
+	.remove_new	=3D madera_irq_remove,
 	.driver =3D {
 		.name	=3D "madera-irq",
 		.pm	=3D &madera_irq_pm_ops,

