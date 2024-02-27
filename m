Return-Path: <linux-kernel+bounces-83694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A07869D65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E70E1F22374
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860A4F1E6;
	Tue, 27 Feb 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIQ7pkv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="69Zp3hJd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01E4DA0C;
	Tue, 27 Feb 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054513; cv=none; b=QuEcwXyfteGxmcg/HNulmel3UgmqJPQ26V4bRC07jVXxzImtMf9eijqLqtivbVOaI1ACSR9cFb+49mgaCCsy99/g+zM1zgnlDxjEMj4DDzUijwUV7T6SXgEQq+VM72oMs6ya2ihPuV50ZhL887UHGSmRjfvEfE/EZP8m7ECy36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054513; c=relaxed/simple;
	bh=ZDMZNMBVmcOnabX2LLDwj241TDa566ufyAI1yq1DIS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LuOBFVDoUEHrdXjBCb2lEinNdD5Vo55DdT2NIK5uVU3VHv0l2UySyPeM7bnFfXdmSeADLrhLIIQuNmchzamC+XzolEVbJ3JH9rGWqNZKSZhGzzZxC2JhHVM325OBW/Pi3ozL7+rkwK3RTcz8q36wusGEVIl72kCm2bMsM7RwjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIQ7pkv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=69Zp3hJd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wm06dIdSkYXtx36LEbu12p51mk8dC/UVyDnkHCaLm7E=;
	b=tIQ7pkv59P2VZPqj6zz9QtMsWZWpNMnx6qqDcqUlRTLFmiE7wZa54BLwxoIZfTmwK11RnO
	WamwF8yXldjRIpIED/d7Vk4o2/0fzVN3qvQrqQHY898gtFcXRbq+smk2iK91UG/ZcKnnkO
	4IIRf1lPQy5oXxdZUVkPJdvS1np4DZWiXHa/ihaIE5RebDwgV1wuLuvxSYt5nMqky02M8o
	egcUTrSGx0Mc9fwXvNdHb0fypLeXdk7LaGaTT8VJb1bdIuAWEJE+1ZxvdnQ8UjP97gTBZu
	+EndX8AKJ6fZxtGG0gDo3gLf+eLEAIiiZSE+kNGX4zC/L/dB7hZu8GOXW0afPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wm06dIdSkYXtx36LEbu12p51mk8dC/UVyDnkHCaLm7E=;
	b=69Zp3hJdKgwZ5uObTZzY6d46lBBF3oPsmtpJVX7UILrU1C9rg6W2ytLF3YnfJy8gBp7Dnl
	DPlozZ3TN0v1ZpBQ==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-irqc: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C2d367ab738ed2e4cf58cffc10d64b0cbe8a1322c=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C2d367ab738ed2e4cf58cffc10d64b0cbe8a1322c=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905450886.398.7426592820378676052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     127806dc0b2aacd4355a977a6d8ba5cc6d64f55e
Gitweb:        https://git.kernel.org/tip/127806dc0b2aacd4355a977a6d8ba5cc6d6=
4f55e
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/renesas-irqc: Convert to platform_driver::remove_new() callback

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
Link: https://lore.kernel.org/r/2d367ab738ed2e4cf58cffc10d64b0cbe8a1322c.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-renesas-irqc.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas=
-irqc.c
index 49b446b..76026e0 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -218,14 +218,13 @@ err_runtime_pm_disable:
 	return ret;
 }
=20
-static int irqc_remove(struct platform_device *pdev)
+static void irqc_remove(struct platform_device *pdev)
 {
 	struct irqc_priv *p =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(p->irq_domain);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
=20
 static int __maybe_unused irqc_suspend(struct device *dev)
@@ -248,11 +247,11 @@ MODULE_DEVICE_TABLE(of, irqc_dt_ids);
=20
 static struct platform_driver irqc_device_driver =3D {
 	.probe		=3D irqc_probe,
-	.remove		=3D irqc_remove,
+	.remove_new	=3D irqc_remove,
 	.driver		=3D {
-		.name	=3D "renesas_irqc",
+		.name		=3D "renesas_irqc",
 		.of_match_table	=3D irqc_dt_ids,
-		.pm	=3D &irqc_pm_ops,
+		.pm		=3D &irqc_pm_ops,
 	}
 };
=20

