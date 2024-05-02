Return-Path: <linux-kernel+bounces-166962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0938BA275
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B831B289BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21871C68AF;
	Thu,  2 May 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLlpGNdG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKodxfWh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51B1BF6DD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685932; cv=none; b=EMAkA59XUScSUmKiuDNPadz2tfRXVzIvAbeVQ++wkbtvNdb9jxXGEHvyb00axC3B09RSjhhRLdbbtIoo+eO+0aYyXFgjMn5Kd6KqRV86MJp06WRBqqD8riGyL9orGwQTN4W64myrCeTSpszUSXnSqLy+q04QearH6S9UlNhuYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685932; c=relaxed/simple;
	bh=V5mxrRSekt1IFCanlpGWcpd6IZlLeeHC7Umzth2wwT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEYL5qlBrgnunR+gPatdmY3BDu089F1+J0isz7kk+lMlKfCdHFwwxC4zRpcMxtkSet0GZklOoaizHRebMyLO+ckaXptr2m3A918dbTqLMXH3gFImv6VhelwfpeADMTEn0rx8KDmbttzurxoa5CNuKp9aqSpNIYE5Xcg9pLcZn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLlpGNdG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKodxfWh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9DvvEOPQaKJAiNHj9V1cPMF/dPZtPshaTQ4VubjDeI=;
	b=nLlpGNdGe/OTfuVowh0Mr2DmsUboCRFrCjWGT8lEin7RIooN9m+ydrp/nnPHk61VFG1/xO
	jASLVKqog55kMhugDjewPpTKfFkBe5zapnFctVMZ2NVsRSRiMGaRhsf2DotUttONd/w+CQ
	57my5sp5e8DJBJ1VjbB3SgwOreCsG1Lim0iC3wsLVORfJlWDRXXVFtpOJzLKFtuWD2HiSo
	Jx4uQUS9g44M8JSkpec/EUHzHm3GO2j25GMqRIsBMT7kU7UXoewJ6w8Qof3V18+sVZvpMZ
	95BP0xeXRhtsOHlV8ev/EFCr9uTEBtTKN1AuvmOFcXw463BsxMlLRjHRXfmJ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9DvvEOPQaKJAiNHj9V1cPMF/dPZtPshaTQ4VubjDeI=;
	b=LKodxfWhxpWyIDKiMK4KuldsgVPy4jzQeRd9d94+PzXyOq7DRRvCxJbSA+jPobfkLx6D3O
	1aYScOgKPWsly9CQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 11/30] nbcon: Provide functions for drivers to acquire console for non-printing
Date: Thu,  2 May 2024 23:44:20 +0206
Message-Id: <20240502213839.376636-12-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide functions nbcon_driver_try_acquire() and
nbcon_driver_release() to allow drivers to acquire the nbcon
console and mark it unsafe for handover/takeover.

These functions are to be used by nbcon drivers when performing
non-printing activities that should be synchronized with their
atomic_write() callback.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  2 ++
 include/linux/printk.h  | 14 +++++++++++
 kernel/printk/nbcon.c   | 55 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index aea4f5aa4a45..3c20938f3676 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -304,6 +304,7 @@ struct nbcon_write_context {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
+ * @nbcon_driver_ctxt:	Context available for driver non-printing operations
  * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
@@ -399,6 +400,7 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
+	struct nbcon_context	__private nbcon_driver_ctxt;
 	struct printk_buffers	*pbufs;
 };
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index d8b3f51d9e98..d0a1106388d1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,6 +9,8 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
+struct console;
+
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
@@ -193,6 +195,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern bool nbcon_driver_try_acquire(struct console *con);
+extern void nbcon_driver_release(struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -272,6 +276,16 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline bool nbcon_driver_try_acquire(struct console *con)
+{
+	return false;
+}
+
+static inline void nbcon_driver_release(struct console *con)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index dd7c3180b335..b8a7e3e136d3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -5,7 +5,9 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles which does not depend
@@ -528,6 +530,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
+ * Context:	Under @ctxt->con->device_lock() or local_irq_save().
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -535,7 +538,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -989,3 +991,54 @@ void nbcon_free(struct console *con)
 
 	con->pbufs = NULL;
 }
+
+/**
+ * nbcon_driver_try_acquire - Try to acquire nbcon console and enter unsafe
+ *				section
+ * @con:	The nbcon console to acquire
+ *
+ * Context:	Under the locking mechanism implemented in
+ *		@con->device_lock() including disabling migration.
+ *
+ * Console drivers will usually use their own internal synchronization
+ * mechasism to synchronize between console printing and non-printing
+ * activities (such as setting baud rates). However, nbcon console drivers
+ * supporting atomic consoles may also want to mark unsafe sections when
+ * performing non-printing activities in order to synchronize against their
+ * atomic_write() callback.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
+ * and marks it unsafe for handover/takeover.
+ */
+bool nbcon_driver_try_acquire(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
+
+	cant_migrate();
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console	= con;
+	ctxt->prio	= NBCON_PRIO_NORMAL;
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(nbcon_driver_try_acquire);
+
+/**
+ * nbcon_driver_release - Exit unsafe section and release the nbcon console
+ * @con:	The nbcon console acquired in nbcon_driver_try_acquire()
+ */
+void nbcon_driver_release(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
+
+	if (nbcon_context_exit_unsafe(ctxt))
+		nbcon_context_release(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_driver_release);
-- 
2.39.2


