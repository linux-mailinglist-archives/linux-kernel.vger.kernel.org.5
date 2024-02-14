Return-Path: <linux-kernel+bounces-65493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6D854DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EB51F27ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB455FF03;
	Wed, 14 Feb 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+lMtMe9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nNf5TFdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E535FDAC;
	Wed, 14 Feb 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927097; cv=none; b=DKf/qsAGf4zdahK8UBt3EmEIp2xECMc0nl/hHP27Qyh+2xw7txDYcD+nDIQMpoyvYnXCoAzGKc+3WHlBgugQbGMFNmWgotxfgoYefD6exk9rM4vV5gxnMvTXAVzfoQWH9QF3cX15Ip+2gALORPaZWLWYXPBZbhMdXuQABybaf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927097; c=relaxed/simple;
	bh=QX94IMLSftleX6tSdfR7VBPO1aPQ5pLDxK63w7oIxho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=edJkejsyUtZwugocXvtIOi9W0Vn9P93y6j0WfvP107+nIfwGUbHqziPND8IKJXG01plT8R9eQkkM5J5eXrzrx2TsPH+JTzKvYpOQnXNMIQ44cIH6NHJyHeEFgaT6wg9flOCpjKNAGrCvewJOYZYUtAR6ffLo2/u+MjYZ4GCK79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+lMtMe9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nNf5TFdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Feb 2024 17:11:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707927092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AqBFxnFBHh9gm3YjzrfnvS86lN8AtsJRekhZQNDFPn4=;
	b=D+lMtMe9dyz0TUqsasAH5MRO/4ohyZRGdgm1osnh4WM5GLucusOxRidSTR97FS/WPJfQqf
	R8Xamd2W9nCNt8zIuclozguSS0e0iuqtn0djaGUB+hO24jRida48XAE4sISW3iJD2SVrOA
	oSHSRu0V6Ay2eld5e48qj7qAU37//GQ0jHIPfzZQfEY7Nk0to7aSkk4u6OngTOh812AXW+
	+Twe8TK20yYB1gOXauCJG+Yyrycy6HDoh1t7zts2axW7VPyDJgooZOoSsaNObsPWu3N9fc
	A7x6p2YYMZzUBjvKtEd1/K4kvLG3dFk8w9JeK9ay+XsqkWggqVr9/6pU7JaccQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707927092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AqBFxnFBHh9gm3YjzrfnvS86lN8AtsJRekhZQNDFPn4=;
	b=nNf5TFdA+xcF8xEfEzVuu48zjbcrkFzLyDHFCd9vRKjYZBRJ5UmFXcnPMggsj4C7kW1ILn
	qu09JCF5Of8f0VDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8-rc4-rt4
Message-ID: <20240214161130.ZT9RSWDc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8-rc4-rt4 patch set. 

Changes since v6.8-rc4-rt3:

  - The previous releases introduced a compiler warning for i915 driver
    in the !i915 case. Reported by the kernel test robot.

  - An update to the printk series by John Ogness:

    - document new nbcon console callbacks:
    
    - add "threadprintk" boot argument for !PREEMPT_RT users that want a
      fully threaded printk.
    
    - use thread callback (instead of atomic callback) for legacy printing
      in task context.
    
    - sync with recently reviewed printk series.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.8-rc4-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/incr/patch-6.8-rc4-rt3-rt4.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8-rc4-rt4

The RT patch against v6.8-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8-rc4-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8-rc4-rt4.tar.xz

Sebastian

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d08..b77aa4b1674d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6487,6 +6487,18 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
+	threadprintk	[KNL]
+			Force threaded printing of all legacy consoles. Be
+			aware that with this option, the shutdown, reboot, and
+			panic messages may not be printed on the legacy
+			consoles. Also, earlycon/earlyprintk printing will be
+			delayed until a regular console or the kthread is
+			available.
+
+			Users can view /proc/consoles to see if their console
+			driver is legacy or not. Non-legacy (NBCON) console
+			drivers are already threaded and are shown with 'N'.
+
 	topology=	[S390]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index 5bcb3536967fb..a3c3faa8f305a 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -281,7 +281,7 @@ static void intel_vblank_section_enter_irqsave(struct drm_i915_private *i915, un
 #ifdef I915
 	spin_lock_irqsave(&i915->uncore.lock, *flags);
 #else
-	*flags = NULL;
+	*flags = 0;
 #endif
 }
 
@@ -292,7 +292,7 @@ static void intel_vblank_section_exit_irqrestore(struct drm_i915_private *i915,
 	spin_unlock_irqrestore(&i915->uncore.lock, flags);
 #else
 	if (flags)
-		;
+		return;
 #endif
 }
 static void intel_vblank_section_enter(struct drm_i915_private *i915)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3b26105f01570..f799c34f1603c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3293,6 +3293,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->nbcon_locked_port = false;
 	port->ctrl_id = 0;
 	port->pm = NULL;
 	port->ops = &serial8250_pops;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3d4decd5676f7..c9c914bc033c9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3568,10 +3568,8 @@ static ssize_t show_cons_active(struct device *dev,
 		if (!c->device)
 			continue;
 		if (c->flags & CON_NBCON) {
-			if (!c->write_atomic &&
-			    !(c->write_thread && c->kthread)) {
+			if (!c->write_atomic && !c->write_thread)
 				continue;
-			}
 		} else {
 			if (!c->write)
 				continue;
diff --git a/include/linux/console.h b/include/linux/console.h
index 467dee94f73a5..02d6cabbe5009 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -139,7 +139,7 @@ static inline int con_debug_leave(void)
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -220,7 +220,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
@@ -287,7 +287,7 @@ struct nbcon_write_context {
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
- * @write:		Write callback to output messages (Optional)
+ * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
  * @device:		The underlying TTY device driver (Optional)
  * @unblank:		Callback to unblank the console (Optional)
@@ -304,10 +304,6 @@ struct nbcon_write_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
- * @write_atomic:	Write callback for atomic context
- * @write_thread:	Write callback for non-atomic context
- * @driver_enter:	Callback to begin synchronization with driver code
- * @driver_exit:	Callback to finish synchronization with driver code
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -335,12 +331,110 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	bool			(*write_atomic)(struct console *con,
-						struct nbcon_write_context *wctxt);
-	bool			(*write_thread)(struct console *con,
-						struct nbcon_write_context *wctxt);
-	void			(*driver_enter)(struct console *con, unsigned long *flags);
-	void			(*driver_exit)(struct console *con, unsigned long flags);
+
+	/**
+	 * @write_atomic:
+	 *
+	 * NBCON callback to write out text in any context. (Optional)
+	 *
+	 * This callback is called with the console already acquired. The
+	 * callback can use nbcon_can_proceed() at any time to verify that
+	 * it is still the owner of the console. In the case that it has
+	 * lost ownership, it is no longer allowed to go forward. In this
+	 * case it must back out immediately and carefully. The buffer
+	 * content is also no longer trusted since it no longer belongs to
+	 * the context.
+	 *
+	 * If the callback needs to perform actions where ownership is not
+	 * allowed to be taken over, nbcon_enter_unsafe() and
+	 * nbcon_exit_unsafe() can be used to mark such sections. These
+	 * functions are also points of possible ownership transfer. If
+	 * either function returns false, ownership has been lost.
+	 *
+	 * If the driver must reacquire ownership in order to finalize or
+	 * revert hardware changes, nbcon_reacquire() can be used. However,
+	 * on reacquire the buffer content is no longer available. A
+	 * reacquire cannot be used to resume printing.
+	 *
+	 * This callback can be called from any context (including NMI).
+	 * Therefore it must avoid usage of any locking and instead rely
+	 * on the console ownership for synchronization.
+	 *
+	 * Returns true if all text was successfully written out and
+	 * ownership was never lost, otherwise false.
+	 */
+	bool (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
+
+	/**
+	 * @write_thread:
+	 *
+	 * NBCON callback to write out text in task context. (Optional)
+	 *
+	 * This callback is called with the console already acquired. Any
+	 * additional driver synchronization should have been performed by
+	 * driver_enter().
+	 *
+	 * This callback is always called from task context but with migration
+	 * disabled.
+	 *
+	 * The same criteria for console ownership verification and unsafe
+	 * sections applies as with write_atomic(). The difference between
+	 * this callback and write_atomic() is that this callback is used
+	 * during normal operation and is always called from task context.
+	 * This provides drivers with a relatively relaxed locking context
+	 * for synchronizing output to the hardware.
+	 *
+	 * Returns true if all text was successfully written out, otherwise
+	 * false.
+	 */
+	bool (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
+
+	/**
+	 * @driver_enter:
+	 *
+	 * NBCON callback to begin synchronization with driver code.
+	 * (Required for NBCON if write_thread is provided)
+	 *
+	 * Console drivers typically must deal with access to the hardware
+	 * via user input/output (such as an interactive login shell) and
+	 * output of kernel messages via printk() calls. This callback is
+	 * called before the kernel begins output via the write_thread()
+	 * callback due to printk() calls. The driver can use this
+	 * callback to acquire some driver lock in order to synchronize
+	 * against user input/output (or any other driver functionality).
+	 *
+	 * This callback is always called from task context. It may use any
+	 * synchronization method required by the driver. BUT this callback
+	 * MUST disable migration. The console driver may be using a
+	 * sychronization mechanism that already takes care of this (such as
+	 * spinlocks). Otherwise this function must explicitly call
+	 * migrate_disable().
+	 *
+	 * The flags argument is provided as a convenience to the driver. It
+	 * will be passed again to driver_exit() when printing is completed
+	 * (for example, if spin_lock_irqsave() was used). It can be ignored
+	 * if the driver does not need it.
+	 */
+	void (*driver_enter)(struct console *con, unsigned long *flags);
+
+	/**
+	 * @driver_exit:
+	 *
+	 * NBCON callback to finish synchronization with driver code.
+	 * (Required for NBCON if write_thread is provided)
+	 *
+	 * This callback is called after the kernel has finished printing a
+	 * printk message. It is the counterpart to driver_enter().
+	 *
+	 * This callback is always called from task context. It must
+	 * appropriately re-enable migration (depending on how driver_enter()
+	 * disabled migration).
+	 *
+	 * The flags argument is the value of the same variable that was
+	 * passed to driver_enter().
+	 */
+	void (*driver_exit)(struct console *con, unsigned long flags);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 7a942e987b165..a2d40a6372266 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -198,8 +198,8 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void printk_legacy_allow_panic_sync(void);
-extern void nbcon_acquire(struct uart_port *up);
-extern void nbcon_release(struct uart_port *up);
+extern void uart_nbcon_acquire(struct uart_port *up);
+extern void uart_nbcon_release(struct uart_port *up);
 void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
@@ -285,11 +285,11 @@ static inline void printk_legacy_allow_panic_sync(void)
 {
 }
 
-static inline void nbcon_acquire(struct uart_port *up)
+static inline void uart_nbcon_acquire(struct uart_port *up)
 {
 }
 
-static inline void nbcon_release(struct uart_port *up)
+static inline void uart_nbcon_release(struct uart_port *up)
 {
 }
 
@@ -299,6 +299,8 @@ static inline void nbcon_atomic_flush_unsafe(void)
 
 #endif
 
+bool this_cpu_in_panic(void);
+
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4d45b8f9ec9ee..4446af2ec09c0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -596,7 +596,7 @@ struct uart_port {
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
-	nbcon_acquire(up);
+	uart_nbcon_acquire(up);
 }
 
 /**
@@ -606,7 +606,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
-	nbcon_acquire(up);
+	uart_nbcon_acquire(up);
 }
 
 /**
@@ -617,7 +617,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
-	nbcon_acquire(up);
+	uart_nbcon_acquire(up);
 }
 
 /**
@@ -631,7 +631,7 @@ static inline bool uart_port_trylock(struct uart_port *up)
 	if (!spin_trylock(&up->lock))
 		return false;
 
-	nbcon_acquire(up);
+	uart_nbcon_acquire(up);
 	return true;
 }
 
@@ -647,7 +647,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
 	if (!spin_trylock_irqsave(&up->lock, *flags))
 		return false;
 
-	nbcon_acquire(up);
+	uart_nbcon_acquire(up);
 	return true;
 }
 
@@ -657,7 +657,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
-	nbcon_release(up);
+	uart_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -667,7 +667,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
-	nbcon_release(up);
+	uart_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -678,7 +678,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
-	nbcon_release(up);
+	uart_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7db6992c54f38..1abb4207186f0 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,6 +4,7 @@
  */
 #include <linux/percpu.h>
 #include <linux/console.h>
+#include <linux/jump_label.h>
 #include "printk_ringbuffer.h"
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
@@ -20,6 +21,13 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 		(con->flags & CON_BOOT) ? "boot" : "",		\
 		con->name, con->index, ##__VA_ARGS__)
 
+#ifdef CONFIG_PREEMPT_RT
+# define force_printkthreads()		(true)
+#else
+DECLARE_STATIC_KEY_FALSE(force_printkthreads_key);
+# define force_printkthreads()		(static_branch_unlikely(&force_printkthreads_key))
+#endif
+
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
@@ -92,7 +100,8 @@ void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_all(void);
-bool nbcon_atomic_emit_next_record(struct console *con, bool *handover, int cookie);
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie, bool use_atomic);
 void nbcon_kthread_create(struct console *con);
 void nbcon_wake_threads(void);
 void nbcon_legacy_kthread_create(void);
@@ -116,7 +125,7 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 			if (!con->write_atomic)
 				return false;
 		} else {
-			if (!con->write_thread || !con->kthread)
+			if (!con->write_thread)
 				return false;
 		}
 	} else {
@@ -182,8 +191,8 @@ static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_all(void) { }
-static inline bool nbcon_atomic_emit_next_record(struct console *con, bool *handover,
-						 int cookie) { return false; }
+static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+						 int cookie, bool use_atomic) { return false; }
 
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
@@ -219,7 +228,6 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
-bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index b53d93585ee71..f2d59a0a93e58 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -934,9 +934,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		done = con->write_atomic(con, wctxt);
 
 	} else if (!use_atomic &&
-		   con->write_thread &&
-		   con->kthread) {
-		WARN_ON_ONCE(con->kthread != current);
+		   con->write_thread) {
 		done = con->write_thread(con, wctxt);
 	}
 
@@ -1166,10 +1164,11 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 }
 
 /**
- * nbcon_atomic_emit_one - Print one record for an nbcon console using the
- *				write_atomic() callback
+ * nbcon_emit_one - Print one record for an nbcon console using the
+ *			specified callback
  * @wctxt:	An initialized write context struct to use
  *		for this context
+ * @use_atomic:	True if the write_atomic callback is to be used
  *
  * Return:	False if the given console could not print a record or there
  *		are no more records to print, otherwise true.
@@ -1177,7 +1176,7 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
  */
-static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
@@ -1189,7 +1188,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * handed over or taken over. In both cases the context is no
 	 * longer valid.
 	 */
-	if (!nbcon_emit_next_record(wctxt, true))
+	if (!nbcon_emit_next_record(wctxt, use_atomic))
 		return false;
 
 	nbcon_context_release(ctxt);
@@ -1220,53 +1219,55 @@ enum nbcon_prio nbcon_get_default_prio(void)
 }
 
 /**
- * nbcon_atomic_emit_next_record - Print one record for an nbcon console
- *					using the write_atomic() callback
+ * nbcon_legacy_emit_next_record - Print one record for an nbcon console
+ *					in legacy contexts
  * @con:	The console to print on
  * @handover:	Will be set to true if a printk waiter has taken over the
  *		console_lock, in which case the caller is no longer holding
  *		both the console_lock and the SRCU read lock. Otherwise it
  *		is set to false.
  * @cookie:	The cookie from the SRCU read lock.
+ * @use_atomic:	True if the write_atomic callback is to be used
  *
  * Context:	Any context which could not be migrated to another CPU.
  * Return:	True if a record could be printed, otherwise false.
  *
  * This function is meant to be called by console_flush_all() to print records
- * on nbcon consoles using the write_atomic() callback. Essentially it is the
- * nbcon version of console_emit_next_record().
+ * on nbcon consoles from legacy context (printing via console unlocking).
+ * Essentially it is the nbcon version of console_emit_next_record().
  */
-bool nbcon_atomic_emit_next_record(struct console *con, bool *handover, int cookie)
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie, bool use_atomic)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	unsigned long driver_flags;
 	bool progress = false;
 	unsigned long flags;
 
 	*handover = false;
 
-	/* Use the same locking order as console_emit_next_record(). */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	ctxt->console = con;
+
+	if (use_atomic) {
+		/* Use the same procedure as console_emit_next_record(). */
 		printk_safe_enter_irqsave(flags);
 		console_lock_spinning_enable();
 		stop_critical_timings();
-	}
 
-	con->driver_enter(con, &driver_flags);
-	cant_migrate();
+		ctxt->prio = nbcon_get_default_prio();
+		progress = nbcon_emit_one(&wctxt, use_atomic);
 
-	ctxt->console	= con;
-	ctxt->prio	= nbcon_get_default_prio();
-
-	progress = nbcon_atomic_emit_one(&wctxt);
-
-	con->driver_exit(con, driver_flags);
-
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		start_critical_timings();
 		*handover = console_lock_spinning_disable_and_check(cookie);
 		printk_safe_exit_irqrestore(flags);
+	} else {
+		con->driver_enter(con, &flags);
+		cant_migrate();
+
+		ctxt->prio = nbcon_get_default_prio();
+		progress = nbcon_emit_one(&wctxt, use_atomic);
+
+		con->driver_exit(con, flags);
 	}
 
 	return progress;
@@ -1323,7 +1324,7 @@ static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 
 			ctxt->prio = nbcon_get_default_prio();
 
-			any_progress |= nbcon_atomic_emit_one(&wctxt);
+			any_progress |= nbcon_emit_one(&wctxt, true);
 
 			local_irq_restore(irq_flags);
 		}
@@ -1473,7 +1474,7 @@ static int __init printk_setup_threads(void)
 	printk_threads_enabled = true;
 	for_each_console(con)
 		nbcon_kthread_create(con);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && printing_via_unlock)
+	if (force_printkthreads() && printing_via_unlock)
 		nbcon_legacy_kthread_create();
 	console_list_unlock();
 	return 0;
@@ -1566,7 +1567,7 @@ static inline bool uart_is_nbcon(struct uart_port *up)
 }
 
 /**
- * nbcon_acquire - The second half of the port locking wrapper
+ * uart_nbcon_acquire - The second half of the port locking wrapper
  * @up:		The uart port whose @lock was locked
  *
  * The uart_port_lock() wrappers will first lock the spin_lock @up->lock.
@@ -1578,7 +1579,7 @@ static inline bool uart_is_nbcon(struct uart_port *up)
  * nbcon consoles acquired via the port lock wrapper always use priority
  * NBCON_PRIO_NORMAL.
  */
-void nbcon_acquire(struct uart_port *up)
+void uart_nbcon_acquire(struct uart_port *up)
 {
 	struct console *con = up->cons;
 	struct nbcon_context ctxt;
@@ -1599,10 +1600,10 @@ void nbcon_acquire(struct uart_port *up)
 
 	up->nbcon_locked_port = true;
 }
-EXPORT_SYMBOL_GPL(nbcon_acquire);
+EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
 
 /**
- * nbcon_release - The first half of the port unlocking wrapper
+ * uart_nbcon_release - The first half of the port unlocking wrapper
  * @up:		The uart port whose @lock is about to be unlocked
  *
  * The uart_port_unlock() wrappers will first call this function to implement
@@ -1615,7 +1616,7 @@ EXPORT_SYMBOL_GPL(nbcon_acquire);
  * nbcon consoles acquired via the port lock wrapper always use priority
  * NBCON_PRIO_NORMAL.
  */
-void nbcon_release(struct uart_port *up)
+void uart_nbcon_release(struct uart_port *up)
 {
 	struct console *con = up->cons;
 	struct nbcon_context ctxt = {
@@ -1631,7 +1632,7 @@ void nbcon_release(struct uart_port *up)
 
 	up->nbcon_locked_port = false;
 }
-EXPORT_SYMBOL_GPL(nbcon_release);
+EXPORT_SYMBOL_GPL(uart_nbcon_release);
 
 /**
  * printk_kthread_shutdown - shutdown all threaded printers
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 90e951bd02524..e29f77f4f8b46 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -195,6 +195,17 @@ static int __init control_devkmsg(char *str)
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
+#if !defined(CONFIG_PREEMPT_RT)
+DEFINE_STATIC_KEY_FALSE(force_printkthreads_key);
+
+static int __init setup_forced_printkthreads(char *arg)
+{
+        static_branch_enable(&force_printkthreads_key);
+        return 0;
+}
+early_param("threadprintk", setup_forced_printkthreads);
+#endif
+
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
@@ -2348,7 +2359,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	bool do_trylock_unlock = printing_via_unlock &&
-				 !IS_ENABLED(CONFIG_PREEMPT_RT);
+				 !force_printkthreads();
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
@@ -2761,7 +2772,7 @@ void resume_console(void)
 static int console_cpu_notify(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen && printing_via_unlock &&
-	    !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	    !force_printkthreads()) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -2824,8 +2835,6 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
-static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
-
 #ifdef CONFIG_PRINTK
 
 /*
@@ -2939,6 +2948,33 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	return true;
 }
 
+/*
+ * Legacy console printing from printk() caller context does not respect
+ * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
+ * false positive. For PREEMPT_RT the false positive condition does not
+ * occur.
+ *
+ * This map is used to establish LD_WAIT_SLEEP context for the console write
+ * callbacks when legacy printing to avoid false positive lockdep complaints,
+ * thus allowing lockdep to continue to function for real issues.
+ */
+#ifdef CONFIG_PREEMPT_RT
+static inline void printk_legacy_lock_map_acquire_try(void) { }
+static inline void printk_legacy_lock_map_release(void) { }
+#else
+DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+
+static inline void printk_legacy_lock_map_acquire_try(void)
+{
+	lock_map_acquire_try(&printk_legacy_map);
+}
+
+static inline void printk_legacy_lock_map_release(void)
+{
+	lock_map_release(&printk_legacy_map);
+}
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Used as the printk buffers for non-panic, serialized console printing.
  * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
@@ -2990,10 +3026,10 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 
 	/* Write everything out to the hardware. */
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (force_printkthreads()) {
 		/*
-		 * On PREEMPT_RT this function is either in a thread or
-		 * panic context. So there is no need for concern about
+		 * With forced threading this function is either in a thread
+		 * or panic context. So there is no need for concern about
 		 * printk reentrance, handovers, or lockdep complaints.
 		 */
 
@@ -3016,9 +3052,9 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		/* Do not trace print latency. */
 		stop_critical_timings();
 
-		lock_map_acquire_try(&printk_legacy_map);
+		printk_legacy_lock_map_acquire_try();
 		con->write(con, outbuf, pmsg.outbuf_len);
-		lock_map_release(&printk_legacy_map);
+		printk_legacy_lock_map_release();
 
 		start_critical_timings();
 
@@ -3090,16 +3126,13 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			if ((flags & CON_NBCON) && con->kthread)
 				continue;
 
-			if (!console_is_usable(con, flags, true))
+			if (!console_is_usable(con, flags, !do_cond_resched))
 				continue;
 			any_usable = true;
 
 			if (flags & CON_NBCON) {
-
-				lock_map_acquire_try(&printk_legacy_map);
-				progress = nbcon_atomic_emit_next_record(con, handover, cookie);
-				lock_map_release(&printk_legacy_map);
-
+				progress = nbcon_legacy_emit_next_record(con, handover, cookie,
+									 !do_cond_resched);
 				printk_seq = nbcon_seq_read(con);
 			} else {
 				progress = console_emit_next_record(con, handover, cookie);
@@ -3199,10 +3232,10 @@ static void console_flush_and_unlock(void)
 void console_unlock(void)
 {
 	/*
-	 * PREEMPT_RT relies on kthread and atomic consoles for printing.
-	 * It never attempts to print from console_unlock().
+	 * Forced threading relies on kthread and atomic consoles for
+	 * printing. It never attempts to print from console_unlock().
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (force_printkthreads()) {
 		__console_unlock();
 		return;
 	}
@@ -3496,7 +3529,7 @@ void nbcon_legacy_kthread_create(void)
 
 	lockdep_assert_held(&console_mutex);
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (!force_printkthreads())
 		return;
 
 	if (!printk_threads_enabled || nbcon_legacy_kthread)
@@ -4094,7 +4127,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	 * Otherwise this function will just wait for the threaded printers
 	 * to print up to @seq.
 	 */
-	if (printing_via_unlock && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (printing_via_unlock && !force_printkthreads()) {
 		console_lock();
 		console_unlock();
 	}
@@ -4202,8 +4235,8 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
-		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			wake_up_interruptible(&legacy_wait);
+		if (force_printkthreads()) {
+			wake_up_legacy_kthread();
 		} else {
 			/*
 			 * If trylock fails, some other context
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index e7b808b829a04..88e8f3a619229 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1857,8 +1857,6 @@ static bool copy_data(struct prb_data_ring *data_ring,
  * descriptor. However, it also verifies that the record is finalized and has
  * the sequence number @seq. On success, 0 is returned.
  *
- * For the panic CPU, committed descriptors are also considered finalized.
- *
  * Error return values:
  * -EINVAL: A finalized record with sequence number @seq does not exist.
  * -ENOENT: A finalized record with sequence number @seq exists, but its data
@@ -1877,25 +1875,16 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
 
 	/*
 	 * An unexpected @id (desc_miss) or @seq mismatch means the record
-	 * does not exist. A descriptor in the reserved state means the
-	 * record does not yet exist for the reader.
+	 * does not exist. A descriptor in the reserved or committed state
+	 * means the record does not yet exist for the reader.
 	 */
 	if (d_state == desc_miss ||
 	    d_state == desc_reserved ||
+	    d_state == desc_committed ||
 	    s != seq) {
 		return -EINVAL;
 	}
 
-	/*
-	 * A descriptor in the committed state means the record does not yet
-	 * exist for the reader. However, for the panic CPU, committed
-	 * records are also handled as finalized records since they contain
-	 * message data in a consistent state and may contain additional
-	 * hints as to the cause of the panic.
-	 */
-	if (d_state == desc_committed && !this_cpu_in_panic())
-		return -EINVAL;
-
 	/*
 	 * A descriptor in the reusable state may no longer have its data
 	 * available; report it as existing but with lost data. Or the record
@@ -2035,8 +2024,8 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 	last_finalized_seq = desc_last_finalized_seq(rb);
 
 	/*
-	 * @head_id is loaded after @last_finalized_seq to ensure that it is
-	 * at or beyond @last_finalized_seq.
+	 * @head_id is loaded after @last_finalized_seq to ensure that
+	 * it points to the record with @last_finalized_seq or newer.
 	 *
 	 * Memory barrier involvement:
 	 *
@@ -2069,25 +2058,20 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 	if (err == -EINVAL) {
 		if (last_finalized_seq == 0) {
 			/*
-			 * @last_finalized_seq still contains its initial
-			 * value. Probably no record has been finalized yet.
-			 * This means the ringbuffer is not yet full and the
-			 * @head_id value can be used directly (subtracting
-			 * off the id value corresponding to seq=0).
-			 */
-
-			/*
-			 * Because of hack#2 of the bootstrapping phase, the
-			 * @head_id initial value must be handled separately.
+			 * No record has been finalized or even reserved yet.
+			 *
+			 * The @head_id is initialized such that the first
+			 * increment will yield the first record (seq=0).
+			 * Handle it separately to avoid a negative @diff
+			 * below.
 			 */
 			if (head_id == DESC0_ID(desc_ring->count_bits))
 				return 0;
 
 			/*
-			 * The @head_id is initialized such that the first
-			 * increment will yield the first record (seq=0).
-			 * Therefore use the initial value +1 as the base to
-			 * subtract from @head_id.
+			 * One or more descriptors are already reserved. Use
+			 * the descriptor ID of the first one (@seq=0) for
+			 * the @diff below.
 			 */
 			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
 		} else {
@@ -2096,10 +2080,7 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 		}
 	}
 
-	/*
-	 * @diff is the number of records beyond the last record available
-	 * to readers.
-	 */
+	/* Diff of known descriptor IDs to compute related sequence numbers. */
 	diff = head_id - last_finalized_id;
 
 	/*
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a7..222c6d6c8281a 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -96,15 +96,25 @@ static void __dump_stack(const char *log_lvl)
  */
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
+	bool in_panic = this_cpu_in_panic();
 	unsigned long flags;
 
 	/*
 	 * Permit this cpu to perform nested stack dumps while serialising
-	 * against other CPUs
+	 * against other CPUs, unless this CPU is in panic.
+	 *
+	 * When in panic, non-panic CPUs are not permitted to store new
+	 * printk messages so there is no need to synchronize the output.
+	 * This avoids potential deadlock in panic() if another CPU is
+	 * holding and unable to release the printk_cpu_sync.
 	 */
-	printk_cpu_sync_get_irqsave(flags);
+	if (!in_panic)
+		printk_cpu_sync_get_irqsave(flags);
+
 	__dump_stack(log_lvl);
-	printk_cpu_sync_put_irqrestore(flags);
+
+	if (!in_panic)
+		printk_cpu_sync_put_irqrestore(flags);
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4

