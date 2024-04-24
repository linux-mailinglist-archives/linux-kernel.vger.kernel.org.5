Return-Path: <linux-kernel+bounces-157652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42738B1407
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6180728A973
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B758145340;
	Wed, 24 Apr 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTfv5PWu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k43vECvE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BB143C5A;
	Wed, 24 Apr 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989056; cv=none; b=lcBH70cg6qseZcy01bMj3ji5WYb2ZSZ+Mkjv/nCETVF2xFlsEISUebSlq69h9oEvsEjiEN0erdj3+8Z6LKLBbMYfGpbh/avOTv6HtKI3pfcLYJIUL/iUNb7GuDQraNSfL0aucimpUwu0gWL97waMVX7HHL1KYkvADjN3DYvW2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989056; c=relaxed/simple;
	bh=tJaUYhyR6gQweoog88TjkZBTj5uT7xjIlUIQAj2YIcw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AEgwLBcgyleQ2biuidt0omY8Jz/716thVHHATQHilK+ERTQrzjDdDNHx1Q3KYoDkZeB2Ll9EwIT1qqcXzJmaeseCXpNus7YZ9NOeoNh91MpNadc3ZT4Rr5rzbEEWj/B3fAn8aGZ90bASCC7m0dEUsGh3e+GM4aRC0FX9GolJmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTfv5PWu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k43vECvE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iItQc4w+NZqDaeNu10psZYVHMhWDkTFJZCM1bZhMdW0=;
	b=TTfv5PWuJHvJPvZ74B7Rq0pC2T+q1LNlml5ANWMa0n9Hzx0arlB4YsEFmT0qHryekb5jZM
	zoklznt0ZBEGfvDtmOGi/Jhtxx06e3iGsRbiojzs7H4cCF0yynkPXZqbFOJWIR/LiuaetH
	L2o7o2Z+JswRWoEH0PDvey1iBAtG6nJ6SxymzHEywCxQqNlcsy/ijVLT42F02fWJilyLhA
	eumGUv0tljclmz7yfU1VM3HKzXHWS6BollzXeFQ9ga5E1Sb1RNn43tHh9dDXjPmmEfEszb
	q1LV+kuE5e7Xg4sgtrJT+LElYVQHte/FiBI2/CSdlIk/TkEGUBhdAUM8btqwTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iItQc4w+NZqDaeNu10psZYVHMhWDkTFJZCM1bZhMdW0=;
	b=k43vECvEOhX5ar7wSOCfNqL+Q5kaISE7hZ+rfqyQdcIigJVDHiA7z0e9XPR5V09jNcQjt8
	EOjSevXknTZ/MZBg==
From: "tip-bot2 for David Stevens" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/cpuhotplug: Skip suspended interrupts when
 restoring affinity
Cc: David Stevens <stevensd@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240424090341.72236-1-stevensd@chromium.org>
References: <20240424090341.72236-1-stevensd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904821.10875.12381201257490919108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a60dd06af674d3bb76b40da5d722e4a0ecefe650
Gitweb:        https://git.kernel.org/tip/a60dd06af674d3bb76b40da5d722e4a0ecefe650
Author:        David Stevens <stevensd@chromium.org>
AuthorDate:    Wed, 24 Apr 2024 18:03:41 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 20:42:57 +02:00

genirq/cpuhotplug: Skip suspended interrupts when restoring affinity

irq_restore_affinity_of_irq() restarts managed interrupts unconditionally
when the first CPU in the affinity mask comes online. That's correct during
normal hotplug operations, but not when resuming from S3 because the
drivers are not resumed yet and interrupt delivery is not expected by them.

Skip the startup of suspended interrupts and let resume_device_irqs() deal
with restoring them. This ensures that irqs are not delivered to drivers
during the noirq phase of resuming from S3, after non-boot CPUs are brought
back online.

Signed-off-by: David Stevens <stevensd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240424090341.72236-1-stevensd@chromium.org
---
 kernel/irq/cpuhotplug.c | 11 ++++++++---
 kernel/irq/manage.c     | 12 ++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b17..43340e0 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -195,10 +195,15 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
 
-	if (irqd_is_managed_and_shutdown(data)) {
-		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+	/*
+	 * Don't restore suspended interrupts here when a system comes back
+	 * from S3. They are reenabled via resume_device_irqs().
+	 */
+	if (desc->istate & IRQS_SUSPENDED)
 		return;
-	}
+
+	if (irqd_is_managed_and_shutdown(data))
+		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 
 	/*
 	 * If the interrupt can only be directed to a single target
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ad3eaf2..29c378d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -800,10 +800,14 @@ void __enable_irq(struct irq_desc *desc)
 		irq_settings_set_noprobe(desc);
 		/*
 		 * Call irq_startup() not irq_enable() here because the
-		 * interrupt might be marked NOAUTOEN. So irq_startup()
-		 * needs to be invoked when it gets enabled the first
-		 * time. If it was already started up, then irq_startup()
-		 * will invoke irq_enable() under the hood.
+		 * interrupt might be marked NOAUTOEN so irq_startup()
+		 * needs to be invoked when it gets enabled the first time.
+		 * This is also required when __enable_irq() is invoked for
+		 * a managed and shutdown interrupt from the S3 resume
+		 * path.
+		 *
+		 * If it was already started up, then irq_startup() will
+		 * invoke irq_enable() under the hood.
 		 */
 		irq_startup(desc, IRQ_RESEND, IRQ_START_FORCE);
 		break;

