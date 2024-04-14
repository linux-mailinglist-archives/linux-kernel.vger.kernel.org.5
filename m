Return-Path: <linux-kernel+bounces-144119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B228A420F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F1B20F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87439364DF;
	Sun, 14 Apr 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIzC8sbF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTeZcQiu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96F1862C;
	Sun, 14 Apr 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713094650; cv=none; b=HHvz+LR9FNkyA7Q7eQr8QbbblYGWsKi0P5W+0Xz2KPrtdkwX3xx/29lmf9bPrI++Ie8GDSIysbxoaRGMKmQL6mIUh+ct4XXHg2VpZBMEo2tVRnPcFgv3UG29w3e31tBZ7G+AZbV3WSCSIUiSPMsm9qsjYCmda6YbN1QSh3Qik2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713094650; c=relaxed/simple;
	bh=AY5Fivk8a0Rx9jrCmv12Ek/I0yWidCC0MhU+Nz89jG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kPSpwgZAhkX6O9qaLoPZYFt/qGoAxh02MHcb+d+WV2fOMpZNyoXIfC5xI67r0mqBm1lURUCeXT17Lh/TiHTPisy3tZS87VQguB9C1ugfqVEPmgK9GcUNIrtD+RnkUnt1LHHkjZz+0e62xWmcLeWzY1USgV6+B5vhieg2HptNIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIzC8sbF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTeZcQiu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 11:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713094641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR/76s3TsfNyIB8f1jn+YfZlCitYZdaIbEKAGruJNl0=;
	b=NIzC8sbF5G31e+AA1g6XtpeRj3iznJQSAU43nrmni5AJNyzrIV6oosyhlMns0nn9qMBKV4
	gFY5gmVrvS4dd7aX2LBqPlR8huADzDhnUbjxynX5aexWzOWgER5QBS4W+DdGVxsSZt7E0n
	HIdcUI8IiFe9kOM/73zRN6t9nvjE83J/l1elb4xs5iUKiyLYfICxf4dENpuO52VUcHTI/W
	l1+8tMQbfBY+qw4DkuOzj7Z0KaU4vCKsbxhexty40Gu6egLfpWI4X0fqCV1mWeiN0qk9mE
	oT2ZEiwuV6UTcygMkls6JEuenKKyIjWQoERc6/HSIqvE62bNcmy9GflhaFxh/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713094641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR/76s3TsfNyIB8f1jn+YfZlCitYZdaIbEKAGruJNl0=;
	b=MTeZcQiugw+dObMzPf52+7Cd10r9PJMXLJz5wbENn9hdOuZVRs8mJ1pVlKuEuzz14Z6UGY
	+NSvY3cGN+3wIxDg==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-imsic: Fix boot time update effective
 affinity warning
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240413065210.315896-1-apatel@ventanamicro.com>
References: <20240413065210.315896-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171309464069.10875.16937650258122631172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     35d77eb7b974f62aaef5a0dc72d93ddb1ada4074
Gitweb:        https://git.kernel.org/tip/35d77eb7b974f62aaef5a0dc72d93ddb1ada4074
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Sat, 13 Apr 2024 12:22:10 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 14 Apr 2024 13:28:49 +02:00

irqchip/riscv-imsic: Fix boot time update effective affinity warning

Currently, the following warning is observed on the QEMU virt machine:
genirq: irq_chip APLIC-MSI-d000000.aplic did not update eff. affinity mask of irq 12

The above warning is because the IMSIC driver does not set the initial
value of effective affinity in the interrupt descriptor. To address this,
initialize the effective affinity in imsic_irq_domain_alloc().

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240413065210.315896-1-apatel@ventanamicro.com

---
 drivers/irqchip/irq-riscv-imsic-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 1e6dddf..11723a7 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -157,6 +157,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			    handle_simple_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
+	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->cpu));
 
 	return 0;
 }

