Return-Path: <linux-kernel+bounces-56574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2484CBD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8F01C23A05
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA497FBB4;
	Wed,  7 Feb 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cKTByp08";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZo+Xyev"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B107CF14
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313284; cv=none; b=tJ4oMBD+nS2CnYIOEgFJLflhGDOSTK/3KUjCFRxbV3K0pUO+v8ni5F/kAZ75bq363AbTFYhETNNA5l+PVtSmqFDoxB5EYVHV4d5mdmsCWAf1yJqvAz0/QXtY73RLYQrqaDaCaoVtlsDYLQcnBpWVjGbeVoO0s14rmeYQd0UT/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313284; c=relaxed/simple;
	bh=CEW+1jm4Jjbzfoy5qe5W0Jz6zUqG9fMl4RYmnU5hdu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ET86fwTN5phYFMr8g1mgJhlj4378Debrnrz3MkK/XmU9j5rqgQDxdqB8lS32sou9ReYRZ6naUXCgxPK6b3uJiMNCMUoYAWFx1P6qd3FGlA6J4EC/7iQ4z8YULJB0TnuK8PgNw4jzul91qPDhOQSEg0eyKKaOz9wtoXAcTfM/GQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKTByp08; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZo+Xyev; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dglETRzgeJkpvG6OhED1NA4N4r3adrKLfLIWNwh3o/w=;
	b=cKTByp08JTA4mBNGvjF+r3B+h3oDP2A/bF0kIDK3Of7rFF9xt19VJNvJ0cjRPTf4coBWLt
	xhneAgT1tON2UttA0t02eGIP02a8XH73ZdtOx454Km/3hruinbPpjpev802RB0kGNMsUgt
	spWQbaUob+Q81Ih2+sfFcDyzZ37e2xcY+FyUUT22Pwc7w51ZlTXoedt7bc/pRF3y3O2Hu/
	123aPrBb/FvH89xuwHWR/soP9zpojd7iaE+VQI1vPEFJc4Vzty3J7009D1pVc4avWYiYQs
	xTPqfwc38+1XZtET4wKjpxiD2Ohk+29ALcehkBstaM3XiGrX8FQRR/HuKP1Myw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dglETRzgeJkpvG6OhED1NA4N4r3adrKLfLIWNwh3o/w=;
	b=dZo+XyevsHtdYpqiRG8A+vejgzxI/quf3igei9fqL+qYK7ZnuJx9XroTnlhM7muuJQPKqJ
	o3H+KoZfFQN8xNBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v4 13/14] panic: Flush kernel log buffer at the end
Date: Wed,  7 Feb 2024 14:47:02 +0106
Message-Id: <20240207134103.1357162-14-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the kernel crashes in a context where printk() calls always
defer printing (such as in NMI or inside a printk_safe section)
then the final panic messages will be deferred to irq_work. But
if irq_work is not available, the messages will not get printed
unless explicitly flushed. The result is that the final
"end Kernel panic" banner does not get printed.

Add one final flush after the last printk() call to make sure
the final panic messages make it out as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2807639aab51..f22d8f33ea14 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -446,6 +446,14 @@ void panic(const char *fmt, ...)
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
+
+	/*
+	 * The final messages may not have been printed if in a context that
+	 * defers printing (such as NMI) and irq_work is not available.
+	 * Explicitly flush the kernel log buffer one last time.
+	 */
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
-- 
2.39.2


