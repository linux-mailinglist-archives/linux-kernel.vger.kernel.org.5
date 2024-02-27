Return-Path: <linux-kernel+bounces-83691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73B1869D60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D67B2346B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A04D9EC;
	Tue, 27 Feb 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iksg/yK+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9acEZk+u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4612836D;
	Tue, 27 Feb 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054510; cv=none; b=UAbRbeYqhgMqrTIcKaLKa/+yTvuyAZhwqBognxOWtz3qkbuKQcAVBmWvLeFTJLXNJT41I9Qvoc3+uxlLPETrZSSgGb5EgnUGOQD2jHC1VcXi7RCCrFjgHKtCiWpU3rb+t7riNVnR50hnoQI6fRxoN1TLH2npiWRmxxz3lj4g8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054510; c=relaxed/simple;
	bh=A1cMB+TPPPLwcjr1NhHzuL5MkmL/S48pr898cP86taM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iQs/mWkcEps5mjBqjbOcKYJ/sFGM0EtQsiP9olwH5yfEJnkPAvVU5dtkSWGQVNGra6AD3BJa9dGZZ3Kyyi5iIRk3xxyh2IQd4gC7FnQAJe64OlMzKlRq3sfzERyip9odvPKgsbpkfDUROrB/bwAy/dTVNJbrOlrFPPcrrC7rk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iksg/yK+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9acEZk+u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFoal968ggd6tjH8ED7KKl31UD4EYrF7TaI8Zw+iGIM=;
	b=iksg/yK+FPKFBHiJwwc+jvOOeTGj/CNpEcIowg/BjifeaDA1xhEvk5TNHXbcVhz079tN8I
	MEUe7hhIENgGlykv+sAoNKJTXTcPu9Iqzka19GCZgQ+a1BS2dfvkTGKB3bhLqjGloL1G0N
	fskj+OjxSeWQLIeZTtfio5Nhz9gH4xP8Kejc9+r42T7q1i+vIzKJ6332OqsKW64/9niLsF
	Zieo2ZdFl6er8AYt70/ywD/NCxzSYBK0zKb6RmEpLpHBa8o05UqkalUEFjWSwGI1rRmatZ
	pp1b4OzWDlhVY47SbAOKQX+161Wy1UIss3MyzfTKK7Cl+hBQiifEbaxZUNWZ+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFoal968ggd6tjH8ED7KKl31UD4EYrF7TaI8Zw+iGIM=;
	b=9acEZk+uIwwG/YMTEQoVutyvklY5TzYUbU0J226I99pSphlBCdn+ca2iL8FEW/GamfKfgT
	t3GJKswMEGEF+gAg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ts4800: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C0bdce86b50e5aa50cffbc4add332cbfbad87521e=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C0bdce86b50e5aa50cffbc4add332cbfbad87521e=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905450603.398.11750562948344568900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f7f56d59a3923e95bad2c49615a4d7313ed78314
Gitweb:        https://git.kernel.org/tip/f7f56d59a3923e95bad2c49615a4d7313ed=
78314
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:11 +01:00

irqchip/ts4800: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/0bdce86b50e5aa50cffbc4add332cbfbad87521e.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-ts4800.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index b2d61d4..57f610d 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -139,13 +139,11 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int ts4800_ic_remove(struct platform_device *pdev)
+static void ts4800_ic_remove(struct platform_device *pdev)
 {
 	struct ts4800_irq_data *data =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(data->domain);
-
-	return 0;
 }
=20
 static const struct of_device_id ts4800_ic_of_match[] =3D {
@@ -155,11 +153,11 @@ static const struct of_device_id ts4800_ic_of_match[] =
=3D {
 MODULE_DEVICE_TABLE(of, ts4800_ic_of_match);
=20
 static struct platform_driver ts4800_ic_driver =3D {
-	.probe  =3D ts4800_ic_probe,
-	.remove =3D ts4800_ic_remove,
+	.probe		=3D ts4800_ic_probe,
+	.remove_new	=3D ts4800_ic_remove,
 	.driver =3D {
-		.name =3D "ts4800-irqc",
-		.of_match_table =3D ts4800_ic_of_match,
+		.name		=3D "ts4800-irqc",
+		.of_match_table	=3D ts4800_ic_of_match,
 	},
 };
 module_platform_driver(ts4800_ic_driver);

