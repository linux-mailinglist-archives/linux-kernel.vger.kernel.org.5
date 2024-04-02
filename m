Return-Path: <linux-kernel+bounces-128782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AC895F81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8641C21553
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418316A1CD;
	Tue,  2 Apr 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRgXxmbm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7xNycNcW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CE161906
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095910; cv=none; b=BaqKuQECuv9lvQDDFevIpevXhSOQBCFzfGAKxW1XSWjfjS2scqZozvzpK2QUYz+HmqpkZvz0WhJc1IcZ4iORCGt2bdEKxt6ppeywf7B/pqqRnep5GgncKWUT06z1l043cvxOYEyTz1Whmjanh6BPTsUnCPI2rn/zmioktJmv4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095910; c=relaxed/simple;
	bh=/2YalWiH5b5qa5L7GAkkMCFr2Ysu3vUqBpGiqlFgVfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LINGhQsIH76Ue3NrYImEs8P7fBVoXTg2cNLNJk1fxB8QvLAqvVNvnHlctPnrYGDv4f9ZkDSsBkNojBSmkjjjZVjyVkO8AO2kI2zsZgJHE7yTUEhuk0d+2rlPl4suPH6bb3BcZa71cyJeQ4ZUncIJ6U6IxYawFonN7UhkV79MTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRgXxmbm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7xNycNcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBm4KPhB7O3k5Gk9a5QvVeFiJpUE5tPuhtoHD45poAY=;
	b=NRgXxmbmdlQIWzJaevplzFtZf1eAAv9Z4nN0ehQuhwmsp9xpwmnIzSEm8ikRISAvJ9daFf
	jXr3gvfoAAWn5qEoe+NtZH61f9ee4NJ3A/NSK9EZK48orLPv4Olc0EfX/N2ec3adbGLMBE
	zfZeD8TSUb8pkk4HGMYgVNszYxPQss0vTz2v3sLr1Jrf20tkxF0zxXQK6qjbXqgAoyXuA5
	NctN1K8VFoUwsuGIEPi5Mx5BDRT6PejlNtmdF+8CV1e8lTb7MDZYs7h9sUXkbyAmuRSFGM
	a1Gn0Nzwk5C+VX+7C38pWtDPe0Y7cQB/Yuarjcl04dKD1/ctWk9bEFW0M0+QOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBm4KPhB7O3k5Gk9a5QvVeFiJpUE5tPuhtoHD45poAY=;
	b=7xNycNcWDMJ2UxvHeUlAsHtpUQh2P7m5Jl7GVkVRxbXxeF/nOea4DOHFsMvAuAnFc8mN4k
	0hL5mMqyzRabFADQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v4 22/27] printk: Coordinate direct printing in panic
Date: Wed,  3 Apr 2024 00:17:24 +0206
Message-Id: <20240402221129.2613843-23-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 62 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 866683a293af..2aa7c302d616 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -195,6 +195,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void printk_legacy_allow_panic_sync(void);
 extern void nbcon_driver_acquire(struct console *con);
 extern void nbcon_driver_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
@@ -278,6 +279,10 @@ static inline void printk_trigger_flush(void)
 {
 }
 
+static inline void printk_legacy_allow_panic_sync(void)
+{
+}
+
 static inline void nbcon_driver_acquire(struct console *con)
 {
 }
diff --git a/kernel/panic.c b/kernel/panic.c
index c039f8e1ddae..de8115c829cf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -364,6 +364,8 @@ void panic(const char *fmt, ...)
 
 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
 
+	printk_legacy_allow_panic_sync();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 329b8507f8a0..e3fd157d7ba3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -471,7 +471,9 @@ static DEFINE_MUTEX(syslog_lock);
 static bool have_legacy_console;
 
 /*
- * Specifies if an nbcon console is registered.
+ * Specifies if an nbcon console is registered. If nbcon consoles are present,
+ * synchronous printing of legacy consoles will not occur during panic until
+ * the backtrace has been stored to the ringbuffer.
  */
 static bool have_nbcon_console;
 
@@ -2330,12 +2332,29 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
+static bool legacy_allow_panic_sync;
+
+/*
+ * This acts as a one-way switch to allow legacy consoles to print from
+ * the printk() caller context on a panic CPU. It also attempts to flush
+ * the legacy consoles in this context.
+ */
+void printk_legacy_allow_panic_sync(void)
+{
+	legacy_allow_panic_sync = true;
+
+	if (printing_via_unlock && !in_nmi()) {
+		if (console_trylock())
+			console_unlock();
+	}
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
@@ -2351,15 +2370,42 @@ asmlinkage int vprintk_emit(int facility, int level,
 
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
+	if (have_nbcon_console && !have_boot_console) {
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
+		 * Note that if boot consoles are registered, the console
+		 * lock/unlock dance must be relied upon instead because nbcon
+		 * consoles cannot print simultaneously with boot consoles.
+		 */
+		if (is_panic_context)
+			nbcon_atomic_flush_pending();
+	}
+
+	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2379,10 +2425,10 @@ asmlinkage int vprintk_emit(int facility, int level,
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


