Return-Path: <linux-kernel+bounces-83693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A952A869D63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64C41C2209B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CF4EB32;
	Tue, 27 Feb 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1aplKX5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mI/wE+cz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8348CE0;
	Tue, 27 Feb 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054511; cv=none; b=NdnxBpOvveTZu7OrIzaBEy5tq4ycn611udwI/jtIFjJI4sy41fKHpLaqHXl66iHGVA4RdCTI/cIoXJfxhz1dJf+qOsvGmYuu2K7KWXNqhITA/I3z0qRcLy4bs31GsMAvK2aKHq/0QaqKL2A2XMFRbE95Wp66sWxLF9kcgnPwlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054511; c=relaxed/simple;
	bh=crRSDyUcRNih9RNoO7caZys8N49MIAPdYlrIsUrFTQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L9HW8mqRL6RJZhhuTvbK0g0/yxETOoVlGOACfcjwsQNz9lul8KCs6uLYG59rxfiKbehjM2xMjg9sFAKYNLdBalbZwIObqRJ6yj4dqX9wVqsHElOAcH01DOAqZcB+3Wx2Nqnsxf3Zv95IWfIEjpf993m8uIBJowcnEc6Ve4nN8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1aplKX5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mI/wE+cz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfxgDGK0xBwEewYjCEk/8OY+bH24FMkQkosYu1RWHbI=;
	b=V1aplKX5XtRjeLh8G/pc4iXCU9UDQ6lgdmccPEnptaBGN1mcS0/xa2QvoT8XlA4ZMUlhZ8
	KADZ5wg44t10LVfqnXm+9Pcl/34BWYM+p+wRIDKktUdYbuYmhr8DaNgRSEyk9G445taR6s
	pry+ogk2y5RLQhA9kXr3Xm8aB2eCEp64N6LAILtDy8XxxTB3CkEioNkk491ND+NobS+MgG
	3n0kNVgfbIut2pviSTSWe7VxC33mK10YcrbloXOiR5QbH3H9CGnXgTUKk66skqTXc75w5j
	SazPGlF6zclH/g5GdE2sfD5KGqYpojJ+Mai+txIEDkQsFlwow06r8enXTXNDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfxgDGK0xBwEewYjCEk/8OY+bH24FMkQkosYu1RWHbI=;
	b=mI/wE+czPxbVTdEGuyOQuPjoOOacc6iXYKfxjjdBtkYZwzmoqyhV0kVL7HXtZD9r1/R4rp
	vzNoMFvQZ9hfpPCA==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rza1: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C1a80e31525d0b02063d2ff1baaaa5e87418f54b6=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C1a80e31525d0b02063d2ff1baaaa5e87418f54b6=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905450796.398.10039345298320762354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d1c762d93a3bcb42ba3a6b8b09324c7863feef33
Gitweb:        https://git.kernel.org/tip/d1c762d93a3bcb42ba3a6b8b09324c7863f=
eef33
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/renesas-rza1: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/1a80e31525d0b02063d2ff1baaaa5e87418f54b6.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-renesas-rza1.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index e4c99c2..f05afe8 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -244,12 +244,11 @@ out_put_node:
 	return ret;
 }
=20
-static int rza1_irqc_remove(struct platform_device *pdev)
+static void rza1_irqc_remove(struct platform_device *pdev)
 {
 	struct rza1_irqc_priv *priv =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(priv->irq_domain);
-	return 0;
 }
=20
 static const struct of_device_id rza1_irqc_dt_ids[] =3D {
@@ -260,9 +259,9 @@ MODULE_DEVICE_TABLE(of, rza1_irqc_dt_ids);
=20
 static struct platform_driver rza1_irqc_device_driver =3D {
 	.probe		=3D rza1_irqc_probe,
-	.remove		=3D rza1_irqc_remove,
+	.remove_new	=3D rza1_irqc_remove,
 	.driver		=3D {
-		.name	=3D "renesas_rza1_irqc",
+		.name		=3D "renesas_rza1_irqc",
 		.of_match_table	=3D rza1_irqc_dt_ids,
 	}
 };

