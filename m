Return-Path: <linux-kernel+bounces-138562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B7889F3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC37B295AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179715E801;
	Wed, 10 Apr 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gs5F/vhy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sosrCBFO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76506154BE7;
	Wed, 10 Apr 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754550; cv=none; b=oCEwAB5XUL+IOcV7sF1hET3UNm7zEZxT9UGcTFCc5Daw0GyLgLZxV6b6oAqRWj7iLBg1bkGhouGl91xUZpLIvybUcV/gaCCgpKomkP0Rd+RvZtu2xECR23J5r7sp+IU4DiFjMJilZsbsqu1YIevvV0KqOfxFk3Y91Y1Id7Y3xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754550; c=relaxed/simple;
	bh=NpRnwbPxIxQH5ztMfIu0tp0WXKB+mapXPNQQpso5Msw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mGAJPY82x9Z537PXJeutO+Z7kF6C31y5HziecbLyePtxych3I3/duPknnJHfJMBwfphem4yP39L8pOTzSc38eSirRfZyFEEuz3A7tiU/2KpAaFOCmIQ6nhj/UqwuRp09+9+TO+eB5WgH8C2ZUlJNrbElUX38y/lcubM8Hb39adU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gs5F/vhy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sosrCBFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:09:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712754546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnt8TGUujKQOiVgfavui8nqXAaimrnyUHMWQy+HOFb8=;
	b=gs5F/vhyAAaU3Qq8oz5Kpahu83xCGfq1ZmhTPEhqyeWTufvfcrJt0E4hym+8u8eOzalY70
	PeyylzIraIEqhmXYsWbJ3s8W+/I3bxXKqaYLivLrUTkhIv2zXYWnyTFAONuOxjDjBCYG9F
	J81QizXvqBudrO5LdpbxDRXFU+DhZTHXE10i6HMLZUu+OWWnAPR65RWWMu9DHomF0Zudym
	L0QkM6j4pwS0UrmEhpC1wH74SyeUEu84iBlGjrrzLGtK515J2HqLhrARHEHnnPR8YZyNXf
	AChagiXBOETWgkb7c0aQQOPS3Hn1xzVdN7rL/R5Ph29SQokm3Po1kTUD+0GozA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712754546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnt8TGUujKQOiVgfavui8nqXAaimrnyUHMWQy+HOFb8=;
	b=sosrCBFO2xFl280bZ7/eh85G7NRDWaGcujr0aHlzLERKixMOhfjNJ0wWqo8/tUdJ9Id+rl
	6WJ2LjT62iDlWmDA==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/olpc-x01-pm: Convert to platform
 remove callback returning void
Cc: u.kleine-koenig@pengutronix.de, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc7d669d8b0c994c77fb4c3bc7bec78aeb8659c74=2E17127?=
 =?utf-8?q?32665=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc7d669d8b0c994c77fb4c3bc7bec78aeb8659c74=2E171273?=
 =?utf-8?q?2665=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275454595.10875.1370059849479086206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     c741ccfdc0b3447a40a1c81447e22ae2c2fec54d
Gitweb:        https://git.kernel.org/tip/c741ccfdc0b3447a40a1c81447e22ae2c2f=
ec54d
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Wed, 10 Apr 2024 09:16:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 14:59:31 +02:00

x86/platform/olpc-x01-pm: Convert to platform remove callback returning void

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/c7d669d8b0c994c77fb4c3bc7bec78aeb8659c74.1712=
732665.git.u.kleine-koenig@pengutronix.de
---
 arch/x86/platform/olpc/olpc-xo1-pm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/ol=
pc-xo1-pm.c
index f067ac7..6a9c42d 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -144,7 +144,7 @@ static int xo1_pm_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int xo1_pm_remove(struct platform_device *pdev)
+static void xo1_pm_remove(struct platform_device *pdev)
 {
 	if (strcmp(pdev->name, "cs5535-pms") =3D=3D 0)
 		pms_base =3D 0;
@@ -152,7 +152,6 @@ static int xo1_pm_remove(struct platform_device *pdev)
 		acpi_base =3D 0;
=20
 	pm_power_off =3D NULL;
-	return 0;
 }
=20
 static struct platform_driver cs5535_pms_driver =3D {
@@ -160,7 +159,7 @@ static struct platform_driver cs5535_pms_driver =3D {
 		.name =3D "cs5535-pms",
 	},
 	.probe =3D xo1_pm_probe,
-	.remove =3D xo1_pm_remove,
+	.remove_new =3D xo1_pm_remove,
 };
=20
 static struct platform_driver cs5535_acpi_driver =3D {
@@ -168,7 +167,7 @@ static struct platform_driver cs5535_acpi_driver =3D {
 		.name =3D "olpc-xo1-pm-acpi",
 	},
 	.probe =3D xo1_pm_probe,
-	.remove =3D xo1_pm_remove,
+	.remove_new =3D xo1_pm_remove,
 };
=20
 static int __init xo1_pm_init(void)

