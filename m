Return-Path: <linux-kernel+bounces-138561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9089F3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B684D281787
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCC15D5CE;
	Wed, 10 Apr 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGJEw3SN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="arCHpNGp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255915DBA5;
	Wed, 10 Apr 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754549; cv=none; b=mACjiMBNejTSI+P8A6XjIA0DcdCwdPBv9oOI/EfhAbOR5QoBwWRJXK+yjvpOj5jr8QLtvaLbLr7zh4bFxvSp8u5F4pLku6GtdF+n53YWFxgapREhhkNwYxZ/Tx2qsV/rDLnTwr6u4sJCY4+kU3XTd+edgsvLb/wKYoQjRtKeQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754549; c=relaxed/simple;
	bh=d8Owrn2iyC3/debschkGB1Vf8duDlgxBLtdGVy2QUa8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vAfFlzvPy+vzeI6WJXlD0yLj6kV0oJo6V0dfaPm0T9HxMk8Bq5krO44zN2D0wG8l/66aExH6JySMw1W9AKzWhz9cTx+0/rUlvp23y9uYVCxl7MfO3UqtLs/9r5oKnoeuKFmHF5e82Rj+Txg+kNyvMjchfvAxDKJfNt/8G62P5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGJEw3SN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=arCHpNGp; arc=none smtp.client-ip=193.142.43.55
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
	bh=wwrpieP2dZLPPEv5VnHRSxNQVfvrK+J5eFMq7YFOeUk=;
	b=tGJEw3SNIgEErWsXp0ulX2xje3uxobCEai2MbxWrF5Au1oMb26hBsyFtp4BMu9G5Dv5cS1
	PauhuH/Dla+NIPW/OohdkFoZ6OXAQQkvCxAg7gSie/cCAkOeTPdXI2C+7O9qeoHUoKPfmF
	27Fdiqad/Aka1zoFgbG+OKAVwN+fyO13qBKTTcpXl4wGVkOJplFADiJdboIu0e0PpoNjaE
	50a+9qIoYVIWHAlR9BikLALizj9kRSef4uBB2TFhFDDEh1ddoO5YL8lF8Dy8oSKkCAOpKX
	yOfcihjrqq1BLOecON+uOD9qv1dFL2CNQBGGHjgb0fu0IG+lZCQOKtknSlf9Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712754546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwrpieP2dZLPPEv5VnHRSxNQVfvrK+J5eFMq7YFOeUk=;
	b=arCHpNGp6ZW/+ujjNlc/if1P7Nvg+mY7Gje2Oh9g7BIQ0imV1Qg/GghZyUzAXIN+MDAJMq
	77yLrGg5qzbYKpDw==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/olpc-xo1-sci: Convert to platform
 remove callback returning void
Cc: u.kleine-koenig@pengutronix.de, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C63c9d1e6b07296916e4218c63f59a2dd6c6b6b16=2E17127?=
 =?utf-8?q?32665=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C63c9d1e6b07296916e4218c63f59a2dd6c6b6b16=2E171273?=
 =?utf-8?q?2665=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275454513.10875.3338180302804381645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     801549ed6abe7586eb9ad0cf7147b0bef383ad22
Gitweb:        https://git.kernel.org/tip/801549ed6abe7586eb9ad0cf7147b0bef38=
3ad22
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Wed, 10 Apr 2024 09:16:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 14:59:31 +02:00

x86/platform/olpc-xo1-sci: Convert to platform remove callback returning void

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
Link: https://lore.kernel.org/r/63c9d1e6b07296916e4218c63f59a2dd6c6b6b16.1712=
732665.git.u.kleine-koenig@pengutronix.de
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/o=
lpc-xo1-sci.c
index 89f25af..46d42ff 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -598,7 +598,7 @@ err_ebook:
 	return r;
 }
=20
-static int xo1_sci_remove(struct platform_device *pdev)
+static void xo1_sci_remove(struct platform_device *pdev)
 {
 	free_irq(sci_irq, pdev);
 	cancel_work_sync(&sci_work);
@@ -608,7 +608,6 @@ static int xo1_sci_remove(struct platform_device *pdev)
 	free_ebook_switch();
 	free_power_button();
 	acpi_base =3D 0;
-	return 0;
 }
=20
 static struct platform_driver xo1_sci_driver =3D {
@@ -617,7 +616,7 @@ static struct platform_driver xo1_sci_driver =3D {
 		.dev_groups =3D lid_groups,
 	},
 	.probe =3D xo1_sci_probe,
-	.remove =3D xo1_sci_remove,
+	.remove_new =3D xo1_sci_remove,
 	.suspend =3D xo1_sci_suspend,
 	.resume =3D xo1_sci_resume,
 };

