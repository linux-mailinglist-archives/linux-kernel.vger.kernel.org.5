Return-Path: <linux-kernel+bounces-70518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1068598CE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8921C2040E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66693763F5;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lh2fhBGX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JfHPw2o3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0D73168
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282680; cv=none; b=PcMyacDuDXGNX3b/yePeBt4YduGU8jL9B5PEKlrlTdL9/Jld22cEESEg+25QeZOmE7zHR3EKtUSzB7wwple5E0J3Bp3lGAnqaTDeHNC9Q48lMwDULzCsMSd0K85gPafeGSVj0CS/jrugISUzWUHxvW5j0ghOYceOFms+gN68fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282680; c=relaxed/simple;
	bh=pfK9qq9Tq8FSQB42rxPrvRkgcIJuLdvvsicEAYeKWHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owuA/VnO8X1PE/Qtt9I38T0bSGEzxI1lhFJU8ejO7uRmDRqbJhJYYLvtjlT7WM9TC/RcaPAyoQV/OMv+xEw/A457hnLggxwoQavOCXLwWYBDiHqeLjRwZmkEhHzWcagu3Pzdeh85cX4dakcmGJ8eto3rM/Ka1OqHY9zWNz860Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lh2fhBGX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JfHPw2o3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPQBcPF1TwjA3+5rOjGCeC1igurDrs1roxu0N8F4XyM=;
	b=Lh2fhBGXPEgFw0mxMWnVOm8TVECrZ8oSZeW1DqPuvyLg1K6EOxJ1YltQR3GFeVffPmLeEz
	UJsPBSJjeoYDTAOwY3CAQ7VT1dppthLr3OfLwstrC22Wk7QYtL5fulgWq93PIyyJSdvocr
	vNG6MNRG8TjgMqNiVuVLYAc4uHTirPbRvwCF/Kep93cVgxH5x62PiwBzGqV+KsZJFr/F1t
	tTOn2DCCr0uVyohozvfp7oV9IiHgSKuPM/t4FEkO0HORUloe3kWwEo5814T2Z5xIN4QFeK
	k85YZxNRhU5XYFWCWBavSCSwyz9TBgoy77P/3Htcopis1b4HlDOiG9TEhpLe+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPQBcPF1TwjA3+5rOjGCeC1igurDrs1roxu0N8F4XyM=;
	b=JfHPw2o3dPQ75TjOWAnNmUeoHWZOYo4xQfB2ra+PsaPjxjR4/cXbQzuej3vXFNHdr0KSDB
	ciyVw65Fm4ESxhBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v2 21/26] printk: Coordinate direct printing in panic
Date: Sun, 18 Feb 2024 20:03:21 +0106
Message-Id: <20240218185726.1994771-22-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perform printing by nbcon consoles on the panic CPU from the
printk() caller context in order to get panic messages printed
as soon as possible.

If legacy and nbcon consoles are registered, the legacy consoles
will no longer perform direct printing on the panic CPU until
after the backtrace has been stored. This will give the safe
nbcon consoles a chance to print the panic messages before
allowing the unsafe legacy consoles to print.

If no nbcon consoles are registered, there is no change in
behavior (i.e. legacy consoles will always attempt to print
from the printk() caller context).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h |  5 ++++
 kernel/panic.c         |  2 ++
 kernel/printk/printk.c | 53 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe37395af9e2..a2d40a637226 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -197,6 +197,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void printk_legacy_allow_panic_sync(void);
 extern void uart_nbcon_acquire(struct uart_port *up);
 extern void uart_nbcon_release(struct uart_port *up);
 void nbcon_atomic_flush_unsafe(void);
@@ -280,6 +281,10 @@ static inline void printk_trigger_flush(void)
 {
 }
 
+static inline void printk_legacy_allow_panic_sync(void)
+{
+}
+
 static inline void uart_nbcon_acquire(struct uart_port *up)
 {
 }
diff --git a/kernel/panic.c b/kernel/panic.c
index c039f8e1ddae..86813305510f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -370,6 +370,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	printk_legacy_allow_panic_sync();
+
 	panic_print_sys_info(false);
 
 	kmsg_dump(KMSG_DUMP_PANIC);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2c4ab717c110..109cfdd988aa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2329,12 +2329,23 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
+static bool legacy_allow_panic_sync;
+
+/*
+ * This acts as a one-way switch to allow legacy consoles to print from
+ * the printk() caller context on a panic CPU.
+ */
+void printk_legacy_allow_panic_sync(void)
+{
+	legacy_allow_panic_sync = true;
+}
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
+	bool do_trylock_unlock = printing_via_unlock;
 	int printed_len;
-	bool in_sched = false;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -2350,15 +2361,43 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		in_sched = true;
+		/* If called from the scheduler, we can not call up(). */
+		do_trylock_unlock = false;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && printing_via_unlock) {
+	if (!have_boot_console && have_nbcon_console) {
+		bool is_panic_context = this_cpu_in_panic();
+
+		/*
+		 * In panic, the legacy consoles are not allowed to print from
+		 * the printk calling context unless explicitly allowed. This
+		 * gives the safe nbcon consoles a chance to print out all the
+		 * panic messages first. This restriction only applies if
+		 * there are nbcon consoles registered.
+		 */
+		if (is_panic_context)
+			do_trylock_unlock &= legacy_allow_panic_sync;
+
+		/*
+		 * There are situations where nbcon atomic printing should
+		 * happen in the printk() caller context:
+		 *
+		 * - When this CPU is in panic.
+		 *
+		 * Note that if boot consoles are registered, the
+		 * console_lock/console_unlock dance must be relied upon
+		 * instead because nbcon consoles cannot print simultaneously
+		 * with boot consoles.
+		 */
+		if (is_panic_context)
+			nbcon_atomic_flush_all();
+	}
+
+	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2378,10 +2417,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (in_sched)
-		defer_console_output();
-	else
+	if (do_trylock_unlock)
 		wake_up_klogd();
+	else
+		defer_console_output();
 
 	return printed_len;
 }
-- 
2.39.2


