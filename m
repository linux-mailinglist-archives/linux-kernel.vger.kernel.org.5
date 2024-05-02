Return-Path: <linux-kernel+bounces-166976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2508BA28A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0DC1C21F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3020FA9F;
	Thu,  2 May 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYyL5WEW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhhfqQ3h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F261CB304
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685938; cv=none; b=WkAFKpMdonKbrJvKrIhAsP+vAyxsGvRixHpPvLRa3qassA3k7aG86zAvQtiaz2X40bXzhLT2hWfT3XaD6KcvQ1iadCxXe9IcShDKmQcMZ5o1etAByKSgtml8WkfILIvZ7dYHs1EWlN7UvXTm0D5UJUqQRM3d/biK2mruENE9IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685938; c=relaxed/simple;
	bh=wcVMUk8/oS73vu6qaEv5wUZlhxXlDPZSrnQyQGtkoVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAJnK8cgJt4VYqn1Uy+KFCFrCbDZYcWBmauQiRK9gWKksDWEpFeC5sbzngl2QsiATQmv2Ex5JLHzpnX3h7zEKctaLL+9bN9ed+ngmSdBGh/4I/+Pzu9GIrfPEffWN4YT+OJpgj+/SS9eH9965vdUD+KaKJjHvHifPGPpwVuuV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYyL5WEW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fhhfqQ3h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15UC9Vkso+YE7CuUzdF4vgVCG9xL1mAkK0rp0AxZYSs=;
	b=kYyL5WEW+TDw2LCkbixGhFDkd9BDWgYaq+dGC/WZ70ExfEJaRooAIwq7HCA79HrSIwf96w
	+A2SF8d88ldg1oc+xEHhHUDODFjFgxDMElts/NrYB9rBXSM+N+PGhPzQaLsSq1vXI1dij2
	XSBG05TqxxvC7b8BhwACmt+CEYDmh60BDT8LXZRZUHDT4HjDzsKfYenQYJB/FW7nCK2Psf
	vTGb9Aogij/gAm0rluTT8LvxxJYtsAp17z8faklVxs0fhlpKycoGispaPQfB6064AsDipJ
	SB1SzSKOMjGt9hVKm74epaVH8agJzLHDJfQ2s263u8ptKQONqseAr5ei2ICp6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15UC9Vkso+YE7CuUzdF4vgVCG9xL1mAkK0rp0AxZYSs=;
	b=fhhfqQ3hudaUV0+lBsNeAy6ORFGolYaLe0+3/MCAUKDw5PVo3CTW1K9C2l4q1ONPoO8Av3
	p9sKk6m8j4yOXdCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH printk v5 25/30] printk: Coordinate direct printing in panic
Date: Thu,  2 May 2024 23:44:34 +0206
Message-Id: <20240502213839.376636-26-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h |  5 ++++
 kernel/panic.c         |  2 ++
 kernel/printk/printk.c | 62 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 439decc792b6..bbd00a310f6b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -195,6 +195,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_driver_try_acquire(struct console *con);
 extern void nbcon_driver_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
@@ -278,6 +279,10 @@ static inline void printk_trigger_flush(void)
 {
 }
 
+static inline void printk_legacy_allow_panic_sync(void)
+{
+}
+
 static inline bool nbcon_driver_try_acquire(struct console *con)
 {
 	return false;
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
index 31ed4450d9a6..eb1d7f0b10bf 100644
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


