Return-Path: <linux-kernel+bounces-83699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF010869D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8001C2370F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA043149E15;
	Tue, 27 Feb 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6i3I4PN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMtEeZCp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06721487D7;
	Tue, 27 Feb 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054517; cv=none; b=j7mAmdRsnEt0kC/ggXPQTZ/ERZSavMAexWPVvX0J9ITvrxBDKA8W3rm1KmbFAztqoDwlIYhix9QBeXb+IJ9YFrj0ZplmV5lVgmKd9yzWWrVn0Ukl06wmjAg3Jo5Vhu1ljil2K5I2xU+zLy/yVq8oACLkmxx0qWb0GQDFr6Wiw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054517; c=relaxed/simple;
	bh=UUN3bTJlKouXHowRj3DuhyKJ7IctiTP0nxUFVd3hllk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bf1GMiYSxnxLNoIbLpu8pgbtoWKvNIvqomggmZEIEs8/nHdv6bOPWVKJd9ATI8bWfi0UjGjY3BbucCvT97kmyYkaYfM3BBZ7GYkc0EslDmGBPnw+ELSNJqiOkfqUyk4lS1FlWpuwCK9c5/9QMrLBV6mq0gcYAFpGveY8+PMQtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6i3I4PN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMtEeZCp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Quieapy62bYYBgQNwKPbRKQY0Jft3FB3roRy08PDa8M=;
	b=N6i3I4PNgEB/xfW5Ir405EQji6BWGNAQY04CePEK9vevP0fDGJfR5Lh/S/sdRNGc8u+Idh
	2BS1MLM862uSy3rvsxVxej5wb3wEhh7iMSGVTpx+jFubAWFpUfDTDfyWzOWylao8g3AuhU
	UQxIwvM/gRdz/zT4J779bvU4IAcLJqGzPZUsdle2qC1oI8WuI0qTrXFxgFoo7voeFvYBsy
	kaVx6+nP2x5Q0a+oNv+6OYQ9xGQkZDPOuu1hpnqC8I5vnL4l0cx33gWbEYzOXExudjxpaX
	HcTv049V15Nmdrh1hax1o85NBd47yrHyWPIZ/4H6jY2Rtcv5ac4IakQ3iTrOZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Quieapy62bYYBgQNwKPbRKQY0Jft3FB3roRy08PDa8M=;
	b=iMtEeZCptvcgPUvHjlowCQzVRQ1+lUTELpexEwkUM7ErIZ3SlrBJW61WfceQSJE7bS222x
	bHKZ6+MzZMcsl7CQ==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ls-scfg-msi: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C1e7143ca68ff0715e0f954504e750fc92e8c6d80=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C1e7143ca68ff0715e0f954504e750fc92e8c6d80=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451348.398.2765510725554792008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f62c5be8a63add3b807230287488fc8a9a3b9c34
Gitweb:        https://git.kernel.org/tip/f62c5be8a63add3b807230287488fc8a9a3=
b9c34
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/ls-scfg-msi: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/1e7143ca68ff0715e0f954504e750fc92e8c6d80.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-ls-scfg-msi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index 15cf80b..1aef5c4 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -398,7 +398,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int ls_scfg_msi_remove(struct platform_device *pdev)
+static void ls_scfg_msi_remove(struct platform_device *pdev)
 {
 	struct ls_scfg_msi *msi_data =3D platform_get_drvdata(pdev);
 	int i;
@@ -410,17 +410,15 @@ static int ls_scfg_msi_remove(struct platform_device *p=
dev)
 	irq_domain_remove(msi_data->parent);
=20
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
=20
 static struct platform_driver ls_scfg_msi_driver =3D {
 	.driver =3D {
-		.name =3D "ls-scfg-msi",
-		.of_match_table =3D ls_scfg_msi_id,
+		.name		=3D "ls-scfg-msi",
+		.of_match_table	=3D ls_scfg_msi_id,
 	},
-	.probe =3D ls_scfg_msi_probe,
-	.remove =3D ls_scfg_msi_remove,
+	.probe		=3D ls_scfg_msi_probe,
+	.remove_new	=3D ls_scfg_msi_remove,
 };
=20
 module_platform_driver(ls_scfg_msi_driver);

