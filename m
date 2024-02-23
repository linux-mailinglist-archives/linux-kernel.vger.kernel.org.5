Return-Path: <linux-kernel+bounces-78050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4EE860E67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BF1C24C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1015CDEF;
	Fri, 23 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gg/PoHNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60tgeRYV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4441B95F;
	Fri, 23 Feb 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681443; cv=none; b=CCbacUpjyeLI3icUm88qPg+aHNvG6+XaVZOal7gPP8ClIIRt726w1wzfcF37XssVw4IQeYsMRFFpAtcaRrLyKOwskSgQj5gjKCqj2D902ZBcNMZq3/7MRr5qAQeBg6opL5jn0Ha8yYNPrQ1kfqaGldYj5yRWukGWhnUzVrq233Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681443; c=relaxed/simple;
	bh=K6iTE+xJM1EFGUUUJE+LSXTOL2WKs5Lx0Ug3OvJoDS0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vCLYrtH9ZQ2it0RxOiPeflyVmFF9xa23sVapk78atbw/HdfAc1ZaTZ168Cpx31ShZZEMdfozAD9dufUl5x/zoT8OkvgrB1FVqgnilQw9apVBhfHGu2xEqbcOxxQcPvfeRRjsww6fwb3NpeSTcc6I8BlG8gYN6I1msGLW+wYoYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gg/PoHNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60tgeRYV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yliOwDKgxVKyXOR3dJiBLIsg9Fm+gub39pL3agee2lQ=;
	b=Gg/PoHNFc8UoMi4iQp79NIk5saVc3lty6ESxmJNFfTgR64xlAedr+oG7TA3wRJcXcXArop
	OPmsXI4Zq8BbjqatRI8ok0kP6WuxFdR7Oe+LawqmxrGpZ8+cPXgwcxKqjoS/t6FNagRJPi
	3e3tUF5jTuyTCIGZwCTj9TIuLRXzF6WV1a4nqXd3rqJPpeBGwVYapP9VYD9OhTuJxuQ4F+
	HhR3s6VJsrhTLaHqDue7t3gb7R9dBGWTzntQozW2styIe1Y1iIYFVvJIozVA8FyeLw0+MO
	DkcfD4Lr0MzKr/vIF+n0LIk+l16sCXGy2K1hAvfEJT0mTZlgv8Js60xM3lPitA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yliOwDKgxVKyXOR3dJiBLIsg9Fm+gub39pL3agee2lQ=;
	b=60tgeRYVL12zYN1mFqlo438P9wo53XDnSMbIOnoEcaiI3xx++MwqSV8QQnuv1UbVBIzgl4
	puopABLTsvMd9gBg==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/sifive-plic: Improve locking safety by using
 irqsave/irqrestore
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-8-apatel@ventanamicro.com>
References: <20240222094006.1030709-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143311.398.4569180081884119404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     abb7205794900503d6358ef1fb645373753a794d
Gitweb:        https://git.kernel.org/tip/abb7205794900503d6358ef1fb645373753a794d
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:55 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:44 +01:00

irqchip/sifive-plic: Improve locking safety by using irqsave/irqrestore

Now that PLIC driver is probed as a regular platform driver, the lock
dependency validator complains about the safety of handler->enable_lock
usage:

[    0.956775]  Possible interrupt unsafe locking scenario:

[    0.956998]        CPU0                    CPU1
[    0.957247]        ----                    ----
[    0.957439]   lock(&handler->enable_lock);
[    0.957607]                                local_irq_disable();
[    0.957793]                                lock(&irq_desc_lock_class);
[    0.958021]                                lock(&handler->enable_lock);
[    0.958246]   <Interrupt>
[    0.958342]     lock(&irq_desc_lock_class);
[    0.958501]
                *** DEADLOCK ***

To address above, use raw_spin_lock_irqsave/unlock_irqrestore() instead
of raw_spin_lock/unlock().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-8-apatel@ventanamicro.com

---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 474ddc3..601000d 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -103,9 +103,11 @@ static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
-	raw_spin_lock(&handler->enable_lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&handler->enable_lock, flags);
 	__plic_toggle(handler->enable_base, hwirq, enable);
-	raw_spin_unlock(&handler->enable_lock);
+	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
 
 static inline void plic_irq_toggle(const struct cpumask *mask,
@@ -236,6 +238,7 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 static int plic_irq_suspend(void)
 {
 	unsigned int i, cpu;
+	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
 
@@ -253,12 +256,12 @@ static int plic_irq_suspend(void)
 		if (!handler->present)
 			continue;
 
-		raw_spin_lock(&handler->enable_lock);
+		raw_spin_lock_irqsave(&handler->enable_lock, flags);
 		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg = handler->enable_base + i * sizeof(u32);
 			handler->enable_save[i] = readl(reg);
 		}
-		raw_spin_unlock(&handler->enable_lock);
+		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 	}
 
 	return 0;
@@ -267,6 +270,7 @@ static int plic_irq_suspend(void)
 static void plic_irq_resume(void)
 {
 	unsigned int i, index, cpu;
+	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
 
@@ -284,12 +288,12 @@ static void plic_irq_resume(void)
 		if (!handler->present)
 			continue;
 
-		raw_spin_lock(&handler->enable_lock);
+		raw_spin_lock_irqsave(&handler->enable_lock, flags);
 		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg = handler->enable_base + i * sizeof(u32);
 			writel(handler->enable_save[i], reg);
 		}
-		raw_spin_unlock(&handler->enable_lock);
+		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 	}
 }
 

