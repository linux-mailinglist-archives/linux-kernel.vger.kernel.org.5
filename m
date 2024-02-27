Return-Path: <linux-kernel+bounces-83700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5E869D72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E468B288116
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049CF14A4F0;
	Tue, 27 Feb 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aN13lyFC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrHOunMM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA198149019;
	Tue, 27 Feb 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054518; cv=none; b=i5jOQOI0oPbzfrCF4HauNR7TyNUcRLplF8844CfYvazOubbAs3dT/kS4Ro1kQk2j/2hfSPdywueKrUPRQn7Wdzj+gdswakUBf5WpyuCbyN5dSyuxgsoBKCK/2IENkK9wcqQ9PRSGm1W2gHOdNNMMPdn9BSq2q18GE0fhHXR1/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054518; c=relaxed/simple;
	bh=0/pVB9EZEXoJoZ+6Jjm5qijRu3AN1iKN11txN7tPars=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jjw7N1kuk782WH5S+SzaY7kI3ZXOFhSm5yIKj8hMfWhBZFGffubFQiMHA7dFBsRO4+zfFQNpJMjCGkKhDxoILbZHgxOa/4jgQ+akk0V/SBixA8Al0+RdlhTsHoFWbBWNI7NXHo0mkdxD0UaT6ExpM30jZKwjDb2Se7j9lcj/hCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aN13lyFC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrHOunMM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjEjUqo4UiNhBKNUZvXJz6TB81Ch3kHkG/dRiGcl7bo=;
	b=aN13lyFCEkIIw5visMXasmo2HFqQDHPGHrPIKMckcScnOTKCLsEwLCiJ4tEMo9dJsJjGcK
	xiQhu95HMD4PcA5CTk49kVSETK2BaXgD7Kkap02J7OlsJIgS9x+9wUal+pAyEck+ZSvoSl
	IeWd6gbrig2NSv/z90sEj5R/BMnMXMG6JeyCPvA2OIAad0MQyc7/ATffQbI117e/cLg5hi
	ypxeB+8GforlWOV6J/dISSBVH5ZruGGeUtLj/jpDc4RWGqe6XbtPPR2c06kqgpqG9VVGfn
	xvtjuZrzHWVThxtf+eLjVEeM+crV2E8hs9JamYEqbVMSKoIu4SzYrM0k1byTsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjEjUqo4UiNhBKNUZvXJz6TB81Ch3kHkG/dRiGcl7bo=;
	b=rrHOunMManewCDPqv3uUZBALSzX5iLF0yWFqfftILynmSRPEOZ1tJ0EgfxZuXkmqvIEEcR
	iCitJECsP4cqUhDg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/keystone: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C4c852a3359aa06bedcf3a10f3fd8c1e008cc5a3a=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C4c852a3359aa06bedcf3a10f3fd8c1e008cc5a3a=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451437.398.10908785391629055095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e58e0b5290bfb3ae022d95794499ae62e38c73b5
Gitweb:        https://git.kernel.org/tip/e58e0b5290bfb3ae022d95794499ae62e38=
c73b5
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:09 +01:00

irqchip/keystone: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/4c852a3359aa06bedcf3a10f3fd8c1e008cc5a3a.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-keystone.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index a36396d..30f1979 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -190,7 +190,7 @@ static int keystone_irq_probe(struct platform_device *pde=
v)
 	return 0;
 }
=20
-static int keystone_irq_remove(struct platform_device *pdev)
+static void keystone_irq_remove(struct platform_device *pdev)
 {
 	struct keystone_irq_device *kirq =3D platform_get_drvdata(pdev);
 	int hwirq;
@@ -201,7 +201,6 @@ static int keystone_irq_remove(struct platform_device *pd=
ev)
 		irq_dispose_mapping(irq_find_mapping(kirq->irqd, hwirq));
=20
 	irq_domain_remove(kirq->irqd);
-	return 0;
 }
=20
 static const struct of_device_id keystone_irq_dt_ids[] =3D {
@@ -212,7 +211,7 @@ MODULE_DEVICE_TABLE(of, keystone_irq_dt_ids);
=20
 static struct platform_driver keystone_irq_device_driver =3D {
 	.probe		=3D keystone_irq_probe,
-	.remove		=3D keystone_irq_remove,
+	.remove_new	=3D keystone_irq_remove,
 	.driver		=3D {
 		.name	=3D "keystone_irq",
 		.of_match_table	=3D of_match_ptr(keystone_irq_dt_ids),

