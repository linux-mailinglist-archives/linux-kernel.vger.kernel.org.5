Return-Path: <linux-kernel+bounces-83692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54F869D61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA561F24D86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B94E1C3;
	Tue, 27 Feb 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/uensmX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhXQyuqI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B3487BF;
	Tue, 27 Feb 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054511; cv=none; b=s3EvV57e0FFWkyv9bSDfsKOMzDgrQV/1wW294Yrg33yBHLugKNj9akcdCzCxT5hL80VQYXVE2oDXxbqjrUv/6i4PJy9VhDfkLdQCcMFkPO1zxEaqbIAIg+MlfAFQxSxJFGuLmzn2Txg4a2WQA6DnQaXV9kvC6889JqLiTeltTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054511; c=relaxed/simple;
	bh=DzTD68zEDvhLvLxHiXxBJuv3hxzGjOVaeWvtnpxutzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q4VTQURE+wAQw47RLZZh1G2LnfwQB6LkY79RD87HoSpGI+yOkgbDTMwN5y9TWgEwAJPcz+grvgB4/rtRz92Ic5DOYngnzVO205PbZW3X5la/JFpOgDB+aqyYpGKph4D3y2RH1mm5xd7CidLTCnBVKsMBh8FRwBarUkEDeh2/n4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/uensmX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yhXQyuqI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=id6NycFhFwY6HehodIjnCrrOzXGMEt7BHkAhNvK7AlE=;
	b=e/uensmX6AnBIaCVMb6f5Lg3WWsNbtu+WRPcHhD5Hk3StPpnPE0Kn40BpH/FMsdoK4jz6J
	EKEzEru5OSPU4x9qp0GaKeG9uyf/AtQEQTIEF+1UnlLAjNzJr6vh46NMzEonfYfO1FVu1C
	tZW2klXWfaPEa3/oy2dPGdnFaUGzcmjMwdqXNEdVSTsU9JIjlqfrzs4xD+7VLo1iId4U8O
	B5Owp8eO6tc5r6oX+BFW0xt3NKvdZV+C/WvIOYR7luGGieQWxsrk2YY0Mpx5ezuVYqIKkW
	KNdGyNzS9YShCQYSEQh7wuScfW0HZO0OberTbfFOTc3eSftz79pYFHJL2Ws5cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=id6NycFhFwY6HehodIjnCrrOzXGMEt7BHkAhNvK7AlE=;
	b=yhXQyuqI61Jc/bjwLq+aa2JDy94XvOLTQeqVdHDFGq2bD4qa9JGmariXAQdJPQonR58hZG
	zmIl+6oOs3nGMjAw==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Antonio Borneo <antonio.borneo@foss.st.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3Cac551b89025bafadce05102b94596f8cd3564a32=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3Cac551b89025bafadce05102b94596f8cd3564a32=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905450706.398.17494117981857072821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     935603e8199991ac1f72c47a41a558f43f1a6004
Gitweb:        https://git.kernel.org/tip/935603e8199991ac1f72c47a41a558f43f1=
a6004
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/stm32-exti: Convert to platform_driver::remove_new() callback

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
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Link: https://lore.kernel.org/r/ac551b89025bafadce05102b94596f8cd3564a32.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-stm32-exti.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 971240e..26a5193 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -898,10 +898,9 @@ static void stm32_exti_remove_irq(void *data)
 	irq_domain_remove(domain);
 }
=20
-static int stm32_exti_remove(struct platform_device *pdev)
+static void stm32_exti_remove(struct platform_device *pdev)
 {
 	stm32_exti_h_syscore_deinit();
-	return 0;
 }
=20
 static int stm32_exti_probe(struct platform_device *pdev)
@@ -991,10 +990,10 @@ MODULE_DEVICE_TABLE(of, stm32_exti_ids);
=20
 static struct platform_driver stm32_exti_driver =3D {
 	.probe		=3D stm32_exti_probe,
-	.remove		=3D stm32_exti_remove,
+	.remove_new	=3D stm32_exti_remove,
 	.driver		=3D {
-		.name	=3D "stm32_exti",
-		.of_match_table =3D stm32_exti_ids,
+		.name		=3D "stm32_exti",
+		.of_match_table	=3D stm32_exti_ids,
 	},
 };
=20

