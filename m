Return-Path: <linux-kernel+bounces-40349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA783DEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B3E1F24A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9953D1DDE9;
	Fri, 26 Jan 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jcz5+gQl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ZpWjxSA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0B1DFEA;
	Fri, 26 Jan 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287051; cv=none; b=BXw4abH4GJTrdBQzzUji+Cg0JwvTAEOHBYJJBNfyNqVggm7ddFfpcLnHPDK08+tCs+Lp1M4HYONHpihaQbo3HcE2esOYyx+gimUBaZCfJd9Q0R7uu+QgdR82W/ASCeZLc662LrqnIWbQi2POFHNU5GYAImlvu+dDFzAsNZF+CYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287051; c=relaxed/simple;
	bh=+Xme+ikfMEKMTsKLOA+gQptcLYSTs2t0fjbp0qPxyW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f3ovrXtg7JsW1eIOH1Iz/GK2Z/4YQghxkIQLl1est7YxzIkl+RYAKfqDRA2bHYkYA1cEX7mG3JB3CHotpHHCVdat4pmdOY44A/GEeL73PifmKdDkitpKOwncv6F5ljtvNepB/+CgDU1nlc8kuZOHA3saRqvZ9if0z5tfRGeLVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jcz5+gQl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ZpWjxSA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 17:37:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706287047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ESlukLMkM/rsc2x1VVf3cll5G9fPHn1HY7uNw+yziRs=;
	b=Jcz5+gQl+Sc+KwAviV8VDgCniva/xd5/TrQ591Hlz6VHEZYZ38FM4a9o4aT5WuUTUbe6Yi
	63KKIk0xmDcbXnerYCz9exDoAoCPdKDoWR5Ojte9Az1tcP8IyLevXMz6DbTi6W4zzJsSmZ
	2hjYbGDtanhLWaV3EHAUsTtzmLS2NZ2V2GwfpmSpd0Jwm3SFfsxEvzYJFlhZok/LxN5wne
	yacvYkk0xB66ZXmhLxltmHrEpOqmv2Qd6cCsOcg+012ve+73fbH9bOZlccc6Isu3y25jpP
	Gr+UXBs4SOLD/Krjrq4PoS4nTdAeUQdIMmA0H+4BFt6b3MuUvjXLkPic4BkJrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706287047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ESlukLMkM/rsc2x1VVf3cll5G9fPHn1HY7uNw+yziRs=;
	b=6ZpWjxSAwE7n7UO/l8Sb7qAy+zJcvA2Qok2jbwkuQBu5wninAJOUtFx0lcDA880YkgOImI
	Xg8ojX4aKZJwxtAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8-rc1-rt2
Message-ID: <20240126163725.kQgJktTk@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8-rc1-rt2 patch set. 

Changes since v6.8-rc1-rt1:

  - Junxiao Chang reported an unbalanced invocation of the acquire/
    release functions for the non-BLK console. Only the 8250 serial
    driver is affected if more than one ttyS console is passed as boot
    argument to console=. Patch by Junxiao Chang.

  - On ARM with HIGHMEM, HIGHPTE and LPAE enabled a sleeping while
    atomic warning can be triggered from the FUTEX code (and other
    users).

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.8-rc1-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/incr/patch-6.8-rc1-rt1-rt2.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8-rc1-rt2

The RT patch against v6.8-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8-rc1-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8-rc1-rt2.tar.xz

Sebastian

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24709aee69ee0..25424a7468d95 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -99,7 +99,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
-	select HAVE_FAST_GUP if ARM_LPAE
+	select HAVE_FAST_GUP if ARM_LPAE && !(PREEMPT_RT && HIGHPTE)
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/include/linux/console.h b/include/linux/console.h
index 79ef2fd2bd155..467dee94f73a5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -311,7 +311,6 @@ struct nbcon_write_context {
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
- * @locked_port:	True, if the port lock is locked by nbcon
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
  * @irq_work:		Defer @kthread waking to IRQ work context
@@ -345,7 +344,6 @@ struct console {
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-	bool			locked_port;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
 	struct irq_work		irq_work;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 04e9b12d22002..4d45b8f9ec9ee 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -488,6 +488,7 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
+	bool			nbcon_locked_port;	/* True, if the port is locked by nbcon */
 	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 1b1b585b1675b..b53d93585ee71 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1586,7 +1586,7 @@ void nbcon_acquire(struct uart_port *up)
 	if (!uart_is_nbcon(up))
 		return;
 
-	WARN_ON_ONCE(con->locked_port);
+	WARN_ON_ONCE(up->nbcon_locked_port);
 
 	do {
 		do {
@@ -1597,7 +1597,7 @@ void nbcon_acquire(struct uart_port *up)
 
 	} while (!nbcon_context_enter_unsafe(&ctxt));
 
-	con->locked_port = true;
+	up->nbcon_locked_port = true;
 }
 EXPORT_SYMBOL_GPL(nbcon_acquire);
 
@@ -1623,13 +1623,13 @@ void nbcon_release(struct uart_port *up)
 		.prio		= NBCON_PRIO_NORMAL,
 	};
 
-	if (!con->locked_port)
+	if (!up->nbcon_locked_port)
 		return;
 
 	if (nbcon_context_exit_unsafe(&ctxt))
 		nbcon_context_release(&ctxt);
 
-	con->locked_port = false;
+	up->nbcon_locked_port = false;
 }
 EXPORT_SYMBOL_GPL(nbcon_release);
 
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2

