Return-Path: <linux-kernel+bounces-130107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B8897424
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F9B1C22459
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DDB14A4CD;
	Wed,  3 Apr 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LmL6YUBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8hrMjnw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F5149DF5;
	Wed,  3 Apr 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158690; cv=none; b=l4ojS7lGR5tOdwkTO+Z2Y1IWU48PMGmgIAyniubJ9Ny/VmFA7mXqtBexPfMrrdtFLcFi6xS+vn/4a4NmLGJ6gtqpRDYWbILH9BuUz3UKG0wq7U3YuTou8btcE+/OJMNcublGiFNvEjaTEDA7KpH8dygkJKShf69bR+9dCk9Vdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158690; c=relaxed/simple;
	bh=7ozh/crUcFOFSFxYpDbzQG+1k9UMq89IgLckyB+RD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m4X7a/yp6mJll7hdGeZM9DDfovyioirNBqkPjrPMdMbJFleZFkjBg7BDkdJdu/WCxyYWkmMIHzbUIR35o5EARq0XWUSko+BvG8fwOQIzYrBWIEsOm3jl73pxqH+rwHPADIhE4SqK0mf5XYH2v1bFLfMeBziYOg2fTD8/1fdUJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LmL6YUBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8hrMjnw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Apr 2024 17:38:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712158687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vhmQs1D7TtZLS8seK0nHN0vIuPyBIrdPbVti7p503Sk=;
	b=LmL6YUBzOz1LAlOQTn1JUHosjCoANzUsgFt8p6Lmcndztvd1DGia2PUJZYJuU1JTNw+7Qe
	eXCC2NyFHsJjsjDzw3NgRGh+C9JKfKWTyyKt57QXV6oDQIygg0URPHHXqu9PmTPyJ9gJJV
	EtcqAL5yuRSASA/DmnsArrxVESsYijICzuUICF7SYZJyXKYmvHtxfOmiX8IINUxJSsH200
	enS8ZG5ycyOSB8f3Fuw4MiOWAiOYOHGu5UAO9l69PVHZgPg/htVOpVRgbDHVOKKVZRtLjS
	f9J4XsGoerBChgqu5oBEqvazOUimSXmKSg+u3xih6Zo3cFCu8n9XvPfvEwQ8sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712158687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vhmQs1D7TtZLS8seK0nHN0vIuPyBIrdPbVti7p503Sk=;
	b=i8hrMjnwLzjNIDsudR8epcKw0c+m2q6E4iLJbzAl1YzGfLGujsk46ph1fGaztzpSjF/55M
	bJvOT6Jw8/qpAyBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8.2-rt11
Message-ID: <20240403153806.0WFY9XS2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8.2-rt11 patch set. 

Changes since v6.8.2-rt10:

  - Update of the printk series by John Ogness:

    - fix usage of port lock before initialization.
    
    - adjust pr_flush() compiler barrier to ensure proper local variable
      usage.

Known issues
    None.

The delta patch against v6.8.2-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/incr/patch-6.8.2-rt10-rt11.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8.2-rt11

The RT patch against v6.8.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8.2-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8.2-rt11.tar.xz

Sebastian

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2652b4d5c944d..0c13ea6a3afaa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3145,6 +3145,13 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->uart_port = uport;
 	uport->state = state;
 
+	/*
+	 * If this port is in use as a console then the spinlock is already
+	 * initialised.
+	 */
+	if (!uart_console_registered(uport))
+		uart_port_spin_lock_init(uport);
+
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
@@ -3155,13 +3162,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 		goto out;
 	}
 
-	/*
-	 * If this port is in use as a console then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_registered(uport))
-		uart_port_spin_lock_init(uport);
-
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 0b6c122918174..1eb2d1e58b1c7 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -424,9 +424,8 @@ struct console {
 	 * migrate_disable().
 	 *
 	 * The flags argument is provided as a convenience to the driver. It
-	 * will be passed again to device_unlock() when printing is completed
-	 * (for example, if spin_lock_irqsave() was used). It can be ignored
-	 * if the driver does not need it.
+	 * will be passed again to device_unlock(). It can be ignored if the
+	 * driver does not need it.
 	 */
 	void (*device_lock)(struct console *con, unsigned long *flags);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 92d59c85d43a3..932b888aa4c30 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1392,7 +1392,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 			 * lock for uart consoles). Therefore IRQs must be
 			 * disabled to avoid being interrupted and then
 			 * calling into a driver that will deadlock trying
-			 * acquire console ownership.
+			 * to acquire console ownership.
 			 */
 			local_irq_save(irq_flags);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2be1157e8169c..8ee6c60b47c4b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -476,7 +476,7 @@ static DEFINE_MUTEX(syslog_lock);
 
 /*
  * Specifies if a legacy console is registered. If legacy consoles are
- * present, it is necessary to perform the console_lock/console_unlock dance
+ * present, it is necessary to perform the console lock/unlock dance
  * whenever console flushing should occur.
  */
 bool have_legacy_console;
@@ -2354,8 +2354,10 @@ void printk_legacy_allow_panic_sync(void)
 {
 	legacy_allow_panic_sync = true;
 
-	if (printing_via_unlock && !in_nmi() && console_trylock())
-		console_unlock();
+	if (printing_via_unlock && !in_nmi()) {
+		if (console_trylock())
+			console_unlock();
+	}
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
@@ -2413,10 +2415,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * - During shutdown, since the printing threads may not get
 		 *   a chance to print the final messages.
 		 *
-		 * Note that if boot consoles are registered, the
-		 * console_lock/console_unlock dance must be relied upon
-		 * instead because nbcon consoles cannot print simultaneously
-		 * with boot consoles.
+		 * Note that if boot consoles are registered, the console
+		 * lock/unlock dance must be relied upon instead because nbcon
+		 * consoles cannot print simultaneously with boot consoles.
 		 */
 		if (is_panic_context ||
 		    !printk_threads_enabled ||
@@ -4174,7 +4175,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	u64 last_diff = 0;
 	u64 printk_seq;
 	short flags;
-	bool locked;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -4196,11 +4196,18 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	for (;;) {
 		unsigned long begin_jiffies;
 		unsigned long slept_jiffies;
+		bool use_console_lock = printing_via_unlock;
+
+		/*
+		 * Ensure the compiler does not optimize @use_console_lock to
+		 * be @printing_via_unlock since the latter can change at any
+		 * time.
+		 */
+		barrier();
 
-		locked = false;
 		diff = 0;
 
-		if (printing_via_unlock) {
+		if (use_console_lock) {
 			/*
 			 * Hold the console_lock to guarantee safe access to
 			 * console->seq. Releasing console_lock flushes more
@@ -4208,16 +4215,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * usable consoles.
 			 */
 			console_lock();
-			locked = true;
 		}
 
-		/*
-		 * Ensure the compiler does not optimize @locked to be
-		 * @printing_via_unlock since the latter can change at any
-		 * time.
-		 */
-		barrier();
-
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			if (con && con != c)
@@ -4238,7 +4237,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
-				WARN_ON_ONCE(!locked);
+				WARN_ON_ONCE(!use_console_lock);
 				printk_seq = c->seq;
 			}
 
@@ -4250,7 +4249,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		if (locked)
+		if (use_console_lock)
 			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11

