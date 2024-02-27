Return-Path: <linux-kernel+bounces-83696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01C869D68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B991F24D93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959951487D5;
	Tue, 27 Feb 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoWXSU/H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsgN2KUO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3B4EB4E;
	Tue, 27 Feb 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054514; cv=none; b=J8Aza+SHLM4wiPhVlNRk8PKO0rgDIxvegHsWaLHKjm3inaY6LIESWhyo8sjQLJVmLcslQOvEkFUhU4AuFsjY3zgOVEW+JBAnhdkg/K9BNsOwLYAnwEwIKiReDtZewm7aP1NKyzkPDtHlGcZruITxLv76/3AgOX1x0rqHrthpnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054514; c=relaxed/simple;
	bh=wXSRP+BHN+/pMFrsM7zD5sI1Tvll7OsuB4BxkszN2ac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mp17Uiad8ohWci9s5j2t4BvMW/y2RBns3vHW9TUAIZz1xFpFGXTAH82e549OA+f9naAdv0KSWJdZ20ScS2MqKjl/RR6ULcxWjtZqf4incGOxBP/vs2az5/TzyI0O7Q28eyKK/1awN11ayuBNmEPToXgkux64JfKm3owrCFYw0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoWXSU/H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsgN2KUO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UEpTiWN8p/eebA1mr6/y9VP7tc5URW8/HJyewEG8QE=;
	b=uoWXSU/H1ll/fOtv8dkVYbfS4wbW3NcBo5kc3P6GfFI2X8dvIWUEnYCKlS26mLiC03Wfmh
	s5kjw8AY3pJ49q8ThsuSFuW6mfWJOMw1MWWW1KaX71kNR6jHrsmEGNAkN7sebxYkO+yYBK
	nrjp5qQOy+B7IimYQxy5YQrcrUIEMHUI/cz0LPYTiraF03HqAyGYiG0JclCmeIBOm6wBh3
	gqXwetL9u4PKlwhP1hoC91Q2eq2eAO220eIjYvV0uQLQDoPCMOXlusdXoztX2g7RQv+lT+
	F7dM0PG5TN3MLPKqGmLRrzSIijJuFzQloKNsOlMevGewS5qnkd7Bb1p1l5EpDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UEpTiWN8p/eebA1mr6/y9VP7tc5URW8/HJyewEG8QE=;
	b=xsgN2KUO7uINdeTy42cfvtoD1fjKDSWnnj0PQMS1Ut9MwtiazRClwT/XnB/GlPCcK+LTad
	WQ+boRo257NMXBAw==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/pruss-intc: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C071057cfdc0bc52c574f74156b410c0337adb69c=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C071057cfdc0bc52c574f74156b410c0337adb69c=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905451071.398.9047545733346141596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     abe9da4056bc6f13ab96c1511d23bd4635bb0bf0
Gitweb:        https://git.kernel.org/tip/abe9da4056bc6f13ab96c1511d23bd4635b=
b0bf0
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/pruss-intc: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/071057cfdc0bc52c574f74156b410c0337adb69c.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-pruss-intc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-int=
c.c
index 0f64ecb..060eb00 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -599,7 +599,7 @@ fail_irq:
 	return ret;
 }
=20
-static int pruss_intc_remove(struct platform_device *pdev)
+static void pruss_intc_remove(struct platform_device *pdev)
 {
 	struct pruss_intc *intc =3D platform_get_drvdata(pdev);
 	u8 max_system_events =3D intc->soc_config->num_system_events;
@@ -616,8 +616,6 @@ static int pruss_intc_remove(struct platform_device *pdev)
 		irq_dispose_mapping(irq_find_mapping(intc->domain, hwirq));
=20
 	irq_domain_remove(intc->domain);
-
-	return 0;
 }
=20
 static const struct pruss_intc_match_data pruss_intc_data =3D {
@@ -645,12 +643,12 @@ MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
=20
 static struct platform_driver pruss_intc_driver =3D {
 	.driver =3D {
-		.name =3D "pruss-intc",
-		.of_match_table =3D pruss_intc_of_match,
-		.suppress_bind_attrs =3D true,
+		.name			=3D "pruss-intc",
+		.of_match_table		=3D pruss_intc_of_match,
+		.suppress_bind_attrs	=3D true,
 	},
-	.probe  =3D pruss_intc_probe,
-	.remove =3D pruss_intc_remove,
+	.probe		=3D pruss_intc_probe,
+	.remove_new	=3D pruss_intc_remove,
 };
 module_platform_driver(pruss_intc_driver);
=20

