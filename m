Return-Path: <linux-kernel+bounces-167650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6D88BACBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AB51C212C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7715357A;
	Fri,  3 May 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcXK+zgH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmVdpL8j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3ECA62;
	Fri,  3 May 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740345; cv=none; b=rh9zw/m+fNvQ1F4SfCsPcG5eHFZVoULKHnXypPZ6InKCdJnRiQZvHxiuTdQCPvuMKp7rf/RVp0JSbqA0oZ38+1G5y8+R/dUWIebb+z202z5mqdACUjf+wIFQTngP8njSFRnk6BWCydE7z2PSwDJvVmNObBnHnyQ0lnp9t+GLKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740345; c=relaxed/simple;
	bh=SX0aMM0nN9bU76EMDVgLk/nhKeBKODPw18MSP8KMVPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VGHnvv6q0KZ7d0NKehGaAvH2HjDiXXKHub4J/hLhj6KrUJ30/HFZ/fK+1rB1Ps0Ro8tsoBCKMHHtOtNX5HvoqhVPr6baBLlqDgx7zXmGIDtChqNc/EfyJeH3Ro/+FuySOowrTDlv0y61VTTUNoyZkDXVmkieIGGC1EyHyJnca0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mcXK+zgH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmVdpL8j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 3 May 2024 14:45:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714740333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kyt3RlhOFsepId+uoF1ZnWf6LZ+ZXSd88nzvFd8XxRI=;
	b=mcXK+zgHR3V6oUBdRelKjVDXYdST73KSzHoFcW5joCfgsFAd1D80ImjuiPhBOPEIsZZEAa
	7fGQtfJEFVybPkbAbgW0G9PskgUdpoT5cHfjtXHj/ICbZqoLIWXMXhVu8IAcPzwTMCeJ+o
	A8ghi0znTIlgwx2jYWR9/lXDukDj+jo1CwczhIPvgl02Eyu5nq8A46TmOSTYpGIGr+H+mD
	9cNNJCLmXmUyKA/qeen0zxASj1z9fS/9xcSOteY1mHrw1ybE0tFJHu5hy9vfzO9LwxvQTM
	huqOc8k8o40Ih3gHtzu2VO6Mgm/Cn9BKvmCFIo9bddsNeFTC92sJ6AKR6Rnj4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714740333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kyt3RlhOFsepId+uoF1ZnWf6LZ+ZXSd88nzvFd8XxRI=;
	b=AmVdpL8jZfpSYAeyIy3yMmm2ZLwVI7YszK0wVl9Q5f5tqPPAE+ZZSUBvDzGB2b7Pk2DtGC
	cWCSqZ0puL7ZPRCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.9-rc6-rt4
Message-ID: <20240503124532.xSzXnM6Z@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.9-rc6-rt4 patch set. 

Changes since v6.9-rc6-rt3:

  - Update printk to the version currently posted for review. Update
    provided by John Ogness:

    - Perform intermediate flushing if there are many printk records
      produced within an emergecy section.
    
    - Remove emergency sections for lockdep functions triggered by
      sysrq.

Known issues
    None.

The delta patch against v6.9-rc6-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/incr/patch-6.9-rc6-rt3-rt4.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.9-rc6-rt4

The RT patch against v6.9-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/older/patch-6.9-rc6-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/older/patches-6.9-rc6-rt4.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 4e4f5501d81da..42b3f5f6eaa3e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -630,8 +630,6 @@ static void univ8250_console_device_unlock(struct console *con, unsigned long fl
 
 	__uart_port_unlock_irqrestore(up, flags);
 }
-
-static struct nbcon_drvdata serial8250_nbcon_drvdata;
 #endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
 
 static int univ8250_console_setup(struct console *co, char *options)
@@ -741,7 +739,6 @@ static struct console univ8250_console = {
 	.device_lock	= univ8250_console_device_lock,
 	.device_unlock	= univ8250_console_device_unlock,
 	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
-	.nbcon_drvdata	= &serial8250_nbcon_drvdata,
 #endif
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 2703676549f5e..c3c01ec2273c5 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -76,6 +76,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
+	__acquires(&console_mutex)
 {
 	struct console *con;
 	loff_t off = 0;
@@ -102,6 +103,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 }
 
 static void c_stop(struct seq_file *m, void *v)
+	__releases(&console_mutex)
 {
 	console_list_unlock();
 }
diff --git a/include/linux/console.h b/include/linux/console.h
index e82fe94109924..23d51531950f5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -302,25 +302,6 @@ struct nbcon_write_context {
 	bool			unsafe_takeover;
 };
 
-/**
- * struct nbcon_drvdata - Data to allow nbcon acquire in non-print context
- * @ctxt:		The core console context
- * @srcu_cookie:	Storage for a console_srcu_lock cookie, if needed
- * @owner_index:	Storage for the owning console index, if needed
- * @locked:		Storage for the locked state, if needed
- *
- * All fields (except for @ctxt) are available exclusively to the driver to
- * use as needed. They are not used by the printk subsystem.
- */
-struct nbcon_drvdata {
-	struct nbcon_context	__private ctxt;
-
-	/* reserved for driver use */
-	int			srcu_cookie;
-	short			owner_index;
-	bool			locked;
-};
-
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -343,6 +324,7 @@ struct nbcon_drvdata {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
+ * @nbcon_driver_ctxt:	Context available for driver non-printing operations
  * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
@@ -375,26 +357,28 @@ struct console {
 	 *
 	 * NBCON callback to write out text in any context.
 	 *
-	 * This callback is called with the console already acquired. The
-	 * callback can use nbcon_can_proceed() at any time to verify that
-	 * it is still the owner of the console. In the case that it has
-	 * lost ownership, it is no longer allowed to go forward. In this
-	 * case it must back out immediately and carefully. The buffer
-	 * content is also no longer trusted since it no longer belongs to
-	 * the context.
+	 * This callback is called with the console already acquired. However,
+	 * a higher priority context is allowed to take it over by default.
 	 *
-	 * If the callback needs to perform actions where ownership is not
-	 * allowed to be taken over, nbcon_enter_unsafe() and
-	 * nbcon_exit_unsafe() can be used to mark such sections. These
-	 * functions are also points of possible ownership transfer. If
-	 * either function returns false, ownership has been lost.
+	 * The callback must call nbcon_enter_unsafe() and nbcon_exit_unsafe()
+	 * around any code where the takeover is not safe, for example, when
+	 * manipulating the serial port registers.
+	 *
+	 * nbcon_enter_unsafe() will fail if the context has lost the console
+	 * ownership in the meantime. In this case, the callback is no longer
+	 * allowed to go forward. It must back out immediately and carefully.
+	 * The buffer content is also no longer trusted since it no longer
+	 * belongs to the context.
+	 *
+	 * The callback should allow the takeover whenever it is safe. It
+	 * increases the chance to see messages when the system is in trouble.
 	 *
 	 * If the driver must reacquire ownership in order to finalize or
 	 * revert hardware changes, nbcon_reacquire() can be used. However,
 	 * on reacquire the buffer content is no longer available. A
 	 * reacquire cannot be used to resume printing.
 	 *
-	 * This callback can be called from any context (including NMI).
+	 * The callback can be called from any context (including NMI).
 	 * Therefore it must avoid usage of any locking and instead rely
 	 * on the console ownership for synchronization.
 	 */
@@ -434,12 +418,13 @@ struct console {
 	 * use whatever synchronization mechanism the driver is using for
 	 * itself (for example, the port lock for uart serial consoles).
 	 *
-	 * This callback is always called from task context. It may use any
-	 * synchronization method required by the driver. BUT this callback
-	 * MUST also disable migration. The console driver may be using a
-	 * synchronization mechanism that already takes care of this (such as
-	 * spinlocks). Otherwise this function must explicitly call
-	 * migrate_disable().
+	 * The callback is always called from task context. It may use any
+	 * synchronization method required by the driver.
+	 *
+	 * IMPORTANT: The callback MUST disable migration. The console driver
+	 *	may be using a synchronization mechanism that already takes
+	 *	care of this (such as spinlocks). Otherwise this function must
+	 *	explicitly call migrate_disable().
 	 *
 	 * The flags argument is provided as a convenience to the driver. It
 	 * will be passed again to device_unlock(). It can be ignored if the
@@ -465,22 +450,9 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
+	struct nbcon_context	__private nbcon_driver_ctxt;
 	atomic_long_t           __private nbcon_prev_seq;
 
-	/**
-	 * @nbcon_drvdata:
-	 *
-	 * Data for nbcon ownership tracking to allow acquiring nbcon consoles
-	 * in non-printing contexts.
-	 *
-	 * Drivers may need to acquire nbcon consoles in non-printing
-	 * contexts. This is achieved by providing a struct nbcon_drvdata.
-	 * Then the driver can call nbcon_driver_acquire() and
-	 * nbcon_driver_release(). The struct does not require any special
-	 * initialization.
-	 */
-	struct nbcon_drvdata	*nbcon_drvdata;
-
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
@@ -522,8 +494,13 @@ extern struct hlist_head console_list;
  * read-modify-write operations to do so.
  *
  * Requires console_srcu_read_lock to be held, which implies that @con might
- * be a registered console. If the caller is holding the console_list_lock or
- * it is certain that the console is not registered, the caller may read
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
+ * and that no exit/cleanup routines will run if the console is currently
+ * undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
  * @con->flags directly instead.
  *
  * Context: Any context.
@@ -615,6 +592,7 @@ static inline bool console_is_registered(const struct console *con)
 #ifdef CONFIG_PRINTK
 extern void nbcon_cpu_emergency_enter(void);
 extern void nbcon_cpu_emergency_exit(void);
+extern void nbcon_cpu_emergency_flush(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
@@ -622,6 +600,7 @@ extern void nbcon_reacquire(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
+static inline void nbcon_cpu_emergency_flush(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f2074b458d801..25e453c326f56 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -196,7 +196,7 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void printk_legacy_allow_panic_sync(void);
-extern void nbcon_driver_acquire(struct console *con);
+extern bool nbcon_driver_try_acquire(struct console *con);
 extern void nbcon_driver_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
 #else
@@ -283,8 +283,9 @@ static inline void printk_legacy_allow_panic_sync(void)
 {
 }
 
-static inline void nbcon_driver_acquire(struct console *con)
+static inline bool nbcon_driver_try_acquire(struct console *con)
 {
+	return false;
 }
 
 static inline void nbcon_driver_release(struct console *con)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index badcf440a5665..5b4db46bd241e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -8,7 +8,6 @@
 #define LINUX_SERIAL_CORE_H
 
 #include <linux/bitops.h>
-#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
@@ -631,62 +630,56 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 }
 
 /* Only for internal port lock wrapper usage. */
-static inline void __uart_port_nbcon_acquire(struct uart_port *up)
+static inline bool __uart_port_using_nbcon(struct uart_port *up)
 {
 	lockdep_assert_held_once(&up->lock);
 
 	if (likely(!uart_console(up)))
+		return false;
+
+	/*
+	 * @up->cons is only modified under the port lock. Therefore it is
+	 * certain that it cannot disappear here.
+	 *
+	 * @up->cons->node is added/removed from the console list under the
+	 * port lock. Therefore it is certain that the registration status
+	 * cannot change here, thus @up->cons->flags can be read directly.
+	 */
+	if (hlist_unhashed_lockless(&up->cons->node) ||
+	    !(up->cons->flags & CON_NBCON) ||
+	    !up->cons->write_atomic) {
+		return false;
+	}
+
+	return true;
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_nbcon_try_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return true;
+
+	return nbcon_driver_try_acquire(up->cons);
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
 		return;
 
-	if (up->cons->nbcon_drvdata) {
-		/*
-		 * If @up->cons is registered, prevent it from fully
-		 * unregistering until this context releases the nbcon.
-		 */
-		int cookie = console_srcu_read_lock();
-
-		/* Ensure console is registered and is an nbcon console. */
-		if (!hlist_unhashed_lockless(&up->cons->node) &&
-		    (console_srcu_read_flags(up->cons) & CON_NBCON)) {
-			WARN_ON_ONCE(up->cons->nbcon_drvdata->locked);
-
-			nbcon_driver_acquire(up->cons);
-
-			/*
-			 * Record @up->line to be used during release because
-			 * @up->cons->index can change while the port and
-			 * nbcon are locked.
-			 */
-			up->cons->nbcon_drvdata->owner_index = up->line;
-			up->cons->nbcon_drvdata->srcu_cookie = cookie;
-			up->cons->nbcon_drvdata->locked = true;
-		} else {
-			console_srcu_read_unlock(cookie);
-		}
-	}
+	while (!nbcon_driver_try_acquire(up->cons))
+		cpu_relax();
 }
 
 /* Only for internal port lock wrapper usage. */
 static inline void __uart_port_nbcon_release(struct uart_port *up)
 {
-	lockdep_assert_held_once(&up->lock);
+	if (!__uart_port_using_nbcon(up))
+		return;
 
-	/*
-	 * uart_console() cannot be used here because @up->cons->index might
-	 * have changed. Check against @up->cons->nbcon_drvdata->owner_index
-	 * instead.
-	 */
-
-	if (unlikely(up->cons &&
-		     up->cons->nbcon_drvdata &&
-		     up->cons->nbcon_drvdata->locked &&
-		     up->cons->nbcon_drvdata->owner_index == up->line)) {
-		WARN_ON_ONCE(!up->cons->nbcon_drvdata->locked);
-
-		up->cons->nbcon_drvdata->locked = false;
-		nbcon_driver_release(up->cons);
-		console_srcu_read_unlock(up->cons->nbcon_drvdata->srcu_cookie);
-	}
+	nbcon_driver_release(up->cons);
 }
 
 /**
@@ -731,7 +724,11 @@ static inline bool uart_port_trylock(struct uart_port *up)
 	if (!spin_trylock(&up->lock))
 		return false;
 
-	__uart_port_nbcon_acquire(up);
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock(&up->lock);
+		return false;
+	}
+
 	return true;
 }
 
@@ -747,7 +744,11 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
 	if (!spin_trylock_irqsave(&up->lock, *flags))
 		return false;
 
-	__uart_port_nbcon_acquire(up);
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock_irqrestore(&up->lock, *flags);
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 80cfbe7b340e3..c06842e037d89 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -785,8 +785,6 @@ static void lockdep_print_held_locks(struct task_struct *p)
 {
 	int i, depth = READ_ONCE(p->lockdep_depth);
 
-	nbcon_cpu_emergency_enter();
-
 	if (!depth)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
@@ -797,13 +795,11 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	 * and it's not the current task.
 	 */
 	if (p != current && task_is_running(p))
-		goto out;
+		return;
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
 		print_lock(p->held_locks + i);
 	}
-out:
-	nbcon_cpu_emergency_exit();
 }
 
 static void print_kernel_ident(void)
@@ -6688,7 +6684,6 @@ void debug_show_all_locks(void)
 		pr_warn("INFO: lockdep is turned off.\n");
 		return;
 	}
-	nbcon_cpu_emergency_enter();
 	pr_warn("\nShowing all locks held in the system:\n");
 
 	rcu_read_lock();
@@ -6696,6 +6691,7 @@ void debug_show_all_locks(void)
 		if (!p->lockdep_depth)
 			continue;
 		lockdep_print_held_locks(p);
+		nbcon_cpu_emergency_flush();
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
 	}
@@ -6703,7 +6699,6 @@ void debug_show_all_locks(void)
 
 	pr_warn("\n");
 	pr_warn("=============================================\n\n");
-	nbcon_cpu_emergency_exit();
 }
 EXPORT_SYMBOL_GPL(debug_show_all_locks);
 #endif
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index fdf455c890338..467a0b1dccbb1 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -93,7 +93,7 @@ int console_lock_spinning_disable_and_check(int cookie);
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
+void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
@@ -183,7 +183,7 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con) { }
+static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 932b888aa4c30..99818b819e417 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -545,7 +545,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
- * Context:	Any context which could not be migrated to another CPU.
+ * Context:	Under @ctxt->con->device_lock() or local_irq_save().
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -1201,38 +1201,6 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
 }
 
-/**
- * nbcon_emit_one - Print one record for an nbcon console using the
- *			specified callback
- * @wctxt:	An initialized write context struct to use for this context
- * @use_atomic:	True if the write_atomic callback is to be used
- *
- * Return:	False if it is known there are no more records to print,
- *		otherwise true.
- *
- * This is an internal helper to handle the locking of the console before
- * calling nbcon_emit_next_record().
- */
-static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
-{
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
-
-	if (!nbcon_context_try_acquire(ctxt))
-		return true;
-
-	/*
-	 * nbcon_emit_next_record() returns false when the console was
-	 * handed over or taken over. In both cases the context is no
-	 * longer valid.
-	 */
-	if (!nbcon_emit_next_record(wctxt, use_atomic))
-		return true;
-
-	nbcon_context_release(ctxt);
-
-	return ctxt->backlog;
-}
-
 /**
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
@@ -1255,6 +1223,46 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
+/*
+ * nbcon_emit_one - Print one record for an nbcon console using the
+ *			specified callback
+ * @wctxt:	An initialized write context struct to use for this context
+ * @use_atomic:	True if the write_atomic callback is to be used
+ *
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 *
+	 * The higher priority printing context takes over responsibility
+	 * to print the pending records.
+	 */
+	if (!nbcon_emit_next_record(wctxt, use_atomic))
+		return false;
+
+	nbcon_context_release(ctxt);
+
+	return ctxt->backlog;
+}
+
 /**
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts
@@ -1267,8 +1275,13 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * @use_atomic:	True if the write_atomic callback is to be used
  *
  * Context:	Any context except NMI.
- * Return:	False if the given console has no next record to print,
- *		otherwise true.
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
  *
  * This function is meant to be called by console_flush_all() to print records
  * on nbcon consoles from legacy context (printing via console unlocking).
@@ -1282,8 +1295,6 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	unsigned long flags;
 	bool progress;
 
-	*handover = false;
-
 	ctxt->console = con;
 
 	if (use_atomic) {
@@ -1299,6 +1310,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 		*handover = console_lock_spinning_disable_and_check(cookie);
 		printk_safe_exit_irqrestore(flags);
 	} else {
+		*handover = false;
+
 		con->device_lock(con, &flags);
 		cant_migrate();
 
@@ -1318,18 +1331,29 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * @stop_seq:			Flush up until this record
  * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  *
- * Return:	True if taken over while printing. Otherwise false.
+ * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
+ *		failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		Unable to acquire console ownership.
+ *
+ *	-EAGAIN:	Another context took over ownership while printing.
+ *
+ *	-ENOENT:	A record before @stop_seq is not available.
  *
  * If flushing up to @stop_seq was not successful, it only makes sense for the
- * caller to try again when true was returned. When false is returned, either
- * there are no more records available to read or this context is not allowed
- * to acquire the console.
+ * caller to try again when -EAGAIN was returned. When -EPERM is returned,
+ * this context is not allowed to acquire the console. When -ENOENT is
+ * returned, it cannot be expected that the unfinalized record will become
+ * available.
  */
-static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
-					     bool allow_unsafe_takeover)
+static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					    bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	int err = 0;
 
 	ctxt->console			= con;
 	ctxt->spinwait_max_us		= 2000;
@@ -1337,7 +1361,7 @@ static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
 	if (!nbcon_context_try_acquire(ctxt))
-		return false;
+		return -EPERM;
 
 	while (nbcon_seq_read(con) < stop_seq) {
 		/*
@@ -1346,15 +1370,64 @@ static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 		 * longer valid.
 		 */
 		if (!nbcon_emit_next_record(&wctxt, true))
-			return true;
+			return -EAGAIN;
 
-		if (!ctxt->backlog)
+		if (!ctxt->backlog) {
+			if (nbcon_seq_read(con) < stop_seq)
+				err = -ENOENT;
 			break;
+		}
 	}
 
 	nbcon_context_release(ctxt);
+	return err;
+}
 
-	return false;
+/**
+ * nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
+ *
+ * This will stop flushing before @stop_seq if another context has ownership.
+ * That context is then responsible for the flushing. Likewise, if new records
+ * are added while this context was flushing and there is no other context
+ * to handle the printing, this context must also flush those records.
+ */
+static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
+					   bool allow_unsafe_takeover)
+{
+	unsigned long flags;
+	int err;
+
+again:
+	/*
+	 * Atomic flushing does not use console driver synchronization (i.e.
+	 * it does not hold the port lock for uart consoles). Therefore IRQs
+	 * must be disabled to avoid being interrupted and then calling into
+	 * a driver that will deadlock trying to acquire console ownership.
+	 */
+	local_irq_save(flags);
+
+	err = __nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
+
+	local_irq_restore(flags);
+
+	/*
+	 * If flushing was successful but more records are available this
+	 * context must flush those remaining records if the printer thread
+	 * is not available to do it.
+	 */
+	if (!err && !con->kthread && prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		stop_seq = prb_next_reserve_seq(prb);
+		goto again;
+	}
+
+	/*
+	 * If there was a new owner, that context is responsible for
+	 * completing the flush.
+	 */
 }
 
 /**
@@ -1366,42 +1439,24 @@ static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct console *con;
-	bool should_retry;
 	int cookie;
 
-	do {
-		should_retry = false;
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags = console_srcu_read_flags(con);
 
-		cookie = console_srcu_read_lock();
-		for_each_console_srcu(con) {
-			short flags = console_srcu_read_flags(con);
-			unsigned long irq_flags;
+		if (!(flags & CON_NBCON))
+			continue;
 
-			if (!(flags & CON_NBCON))
-				continue;
+		if (!console_is_usable(con, flags, true))
+			continue;
 
-			if (!console_is_usable(con, flags, true))
-				continue;
+		if (nbcon_seq_read(con) >= stop_seq)
+			continue;
 
-			if (nbcon_seq_read(con) >= stop_seq)
-				continue;
-
-			/*
-			 * Atomic flushing does not use console driver
-			 * synchronization (i.e. it does not hold the port
-			 * lock for uart consoles). Therefore IRQs must be
-			 * disabled to avoid being interrupted and then
-			 * calling into a driver that will deadlock trying
-			 * to acquire console ownership.
-			 */
-			local_irq_save(irq_flags);
-
-			should_retry |= __nbcon_atomic_flush_pending_con(con, stop_seq,
-									 allow_unsafe_takeover);
-			local_irq_restore(irq_flags);
-		}
-		console_srcu_read_unlock(cookie);
-	} while (should_retry);
+		nbcon_atomic_flush_pending_con(con, stop_seq, allow_unsafe_takeover);
+	}
+	console_srcu_read_unlock(cookie);
 }
 
 /**
@@ -1431,7 +1486,7 @@ void nbcon_atomic_flush_unsafe(void)
 
 /**
  * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
- *	messages for that CPU are only stored
+ *				messages for that CPU are only stored
  *
  * Upon exiting the emergency section, all stored messages are flushed.
  *
@@ -1454,7 +1509,7 @@ void nbcon_cpu_emergency_enter(void)
 
 /**
  * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
- *	stored messages
+ *				stored messages
  *
  * Flushing only occurs when exiting all nesting for the CPU.
  *
@@ -1467,16 +1522,24 @@ void nbcon_cpu_emergency_exit(void)
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 
-	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
-
+	/*
+	 * Flush the messages before enabling preemtion to see them ASAP.
+	 *
+	 * Reduce the risk of potential softlockup by using the
+	 * flush_pending() variant which ignores messages added later. It is
+	 * called before decrementing the counter so that the printing context
+	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
+	 */
 	if (*cpu_emergency_nesting == 1) {
 		nbcon_atomic_flush_pending();
 		do_trigger_flush = true;
 	}
 
-	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
 	(*cpu_emergency_nesting)--;
 
+	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
+		*cpu_emergency_nesting = 0;
+
 	preempt_enable();
 
 	if (do_trigger_flush)
@@ -1484,6 +1547,31 @@ void nbcon_cpu_emergency_exit(void)
 }
 
 /**
+ * nbcon_cpu_emergency_flush - Explicitly flush consoles while
+ *				within emergency context
+ *
+ * Both nbcon and legacy consoles are flushed.
+ *
+ * It should be used only when there are too many messages printed
+ * in emergency context, for example, printing backtraces of all
+ * CPUs or processes. It is typically needed when the watchdogs
+ * need to be touched as well.
+ */
+void nbcon_cpu_emergency_flush(void)
+{
+	/* The explicit flush is needed only in the emergency context. */
+	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
+		return;
+
+	nbcon_atomic_flush_pending();
+
+	if (printing_via_unlock && !in_nmi()) {
+		if (console_trylock())
+			console_unlock();
+	}
+}
+
+/*
  * nbcon_kthread_stop - Stop a printer thread
  * @con:	Console to operate on
  */
@@ -1588,11 +1676,12 @@ bool nbcon_alloc(struct console *con)
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
+ * @init_seq:	Sequence number of the first record to be emitted
  *
  * nbcon_alloc() *must* be called and succeed before this function
  * is called.
  */
-void nbcon_init(struct console *con)
+void nbcon_init(struct console *con, u64 init_seq)
 {
 	struct nbcon_state state = { };
 
@@ -1601,7 +1690,7 @@ void nbcon_init(struct console *con)
 
 	rcuwait_init(&con->rcuwait);
 	init_irq_work(&con->irq_work, nbcon_irq_work);
-	nbcon_seq_force(con, 0);
+	nbcon_seq_force(con, init_seq);
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 	nbcon_kthread_create(con);
@@ -1626,51 +1715,69 @@ void nbcon_free(struct console *con)
 }
 
 /**
- * nbcon_driver_acquire - Acquire nbcon console and enter unsafe section
+ * nbcon_driver_try_acquire - Try to acquire nbcon console and enter unsafe
+ *				section
  * @con:	The nbcon console to acquire
  *
- * Context:	Any context which could not be migrated to another CPU.
+ * Context:	Under the locking mechanism implemented in
+ *		@con->device_lock() including disabling migration.
  *
  * Console drivers will usually use their own internal synchronization
  * mechasism to synchronize between console printing and non-printing
  * activities (such as setting baud rates). However, nbcon console drivers
  * supporting atomic consoles may also want to mark unsafe sections when
- * performing non-printing activities.
+ * performing non-printing activities in order to synchronize against their
+ * atomic_write() callback.
  *
  * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
  * and marks it unsafe for handover/takeover.
- *
- * Console drivers using this function must have provided @nbcon_drvdata in
- * their struct console, which is used to track ownership and state
- * information.
  */
-void nbcon_driver_acquire(struct console *con)
+bool nbcon_driver_try_acquire(struct console *con)
 {
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
 
 	cant_migrate();
 
-	do {
-		do {
-			memset(ctxt, 0, sizeof(*ctxt));
-			ctxt->console	= con;
-			ctxt->prio	= NBCON_PRIO_NORMAL;
-		} while (!nbcon_context_try_acquire(ctxt));
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console	= con;
+	ctxt->prio	= NBCON_PRIO_NORMAL;
 
-	} while (!nbcon_context_enter_unsafe(ctxt));
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	return true;
 }
-EXPORT_SYMBOL_GPL(nbcon_driver_acquire);
+EXPORT_SYMBOL_GPL(nbcon_driver_try_acquire);
 
 /**
  * nbcon_driver_release - Exit unsafe section and release the nbcon console
- * @con:	The nbcon console acquired in nbcon_driver_acquire()
+ * @con:	The nbcon console acquired in nbcon_driver_try_acquire()
  */
 void nbcon_driver_release(struct console *con)
 {
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con->nbcon_drvdata, ctxt);
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
+	int cookie;
 
-	if (nbcon_context_exit_unsafe(ctxt))
-		nbcon_context_release(ctxt);
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return;
+
+	nbcon_context_release(ctxt);
+
+	/*
+	 * This context must flush any new records added while the console
+	 * was locked. The console_srcu_read_lock must be taken to ensure
+	 * the console is usable throughout flushing.
+	 */
+	cookie = console_srcu_read_lock();
+	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
+	    !con->kthread &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
+	}
+	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_driver_release);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5453593eba7fd..eec098aa1f008 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3679,20 +3679,21 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-/* Set @newcon->seq to the first record this console should print. */
-static void console_init_seq(struct console *newcon, bool bootcon_registered)
+/* Return the starting sequence number for a newly registered console. */
+static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
 	bool handover;
+	u64 init_seq;
 
 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		newcon->seq = syslog_seq;
+		init_seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
 		/* Begin with next message added to ringbuffer. */
-		newcon->seq = prb_next_seq(prb);
+		init_seq = prb_next_seq(prb);
 
 		/*
 		 * If any enabled boot consoles are due to be unregistered
@@ -3713,7 +3714,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(true, &init_seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
@@ -3726,12 +3727,12 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 				if (handover)
 					console_lock();
 
-				newcon->seq = prb_next_seq(prb);
+				init_seq = prb_next_seq(prb);
 				for_each_console(con) {
 					u64 seq;
 
-					if (!((con->flags & CON_BOOT) &&
-					      (con->flags & CON_ENABLED))) {
+					if (!(con->flags & CON_BOOT) ||
+					    !(con->flags & CON_ENABLED)) {
 						continue;
 					}
 
@@ -3740,14 +3741,16 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 					else
 						seq = con->seq;
 
-					if (seq < newcon->seq)
-						newcon->seq = seq;
+					if (seq < init_seq)
+						init_seq = seq;
 				}
 			}
 
 			console_unlock();
 		}
 	}
+
+	return init_seq;
 }
 
 #define console_first()				\
@@ -3780,6 +3783,7 @@ void register_console(struct console *newcon)
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
 	unsigned long flags;
+	u64 init_seq;
 	int err;
 
 	console_list_lock();
@@ -3857,21 +3861,14 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon, bootcon_registered);
+	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
 		have_nbcon_console = true;
-		nbcon_init(newcon);
-
-		/*
-		 * nbcon consoles have their own sequence counter. The legacy
-		 * sequence counter is reset so that it is clear it is not
-		 * being used.
-		 */
-		nbcon_seq_force(newcon, newcon->seq);
-		newcon->seq = 0;
+		nbcon_init(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
+		newcon->seq = init_seq;
 		nbcon_legacy_kthread_create();
 	}
 
@@ -3951,6 +3948,7 @@ static int unregister_console_locked(struct console *console)
 	bool found_legacy_con = false;
 	bool found_nbcon_con = false;
 	bool found_boot_con = false;
+	unsigned long flags;
 	struct console *c;
 	int res;
 
@@ -3970,8 +3968,18 @@ static int unregister_console_locked(struct console *console)
 	if (!console_is_registered_locked(console))
 		return -ENODEV;
 
+	/*
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this console transitions to being unregistered.
+	 */
+	if ((console->flags & CON_NBCON) && console->write_atomic)
+		console->device_lock(console, &flags);
+
 	hlist_del_init_rcu(&console->node);
 
+	if ((console->flags & CON_NBCON) && console->write_atomic)
+		console->device_unlock(console, flags);
+
 	/*
 	 * <HISTORICAL>
 	 * If this isn't the last console and it has CON_CONSDEV set, we
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0a135e94da084..bc1d8733c08f3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -616,6 +616,7 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 			pr_cont("\n");
 		}
+		nbcon_cpu_emergency_flush();
 		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
@@ -799,6 +800,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
+		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index f4d73ca20c768..1ca0826545c1e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -261,6 +261,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
+		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
@@ -523,6 +524,7 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 
 	print_cpu_stat_info(cpu);
+	nbcon_cpu_emergency_flush();
 }
 
 /* Complain about starvation of grace-period kthread.  */
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4

