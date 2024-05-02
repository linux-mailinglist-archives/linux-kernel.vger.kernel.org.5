Return-Path: <linux-kernel+bounces-166953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F868BA26A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD259B24635
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3F18413F;
	Thu,  2 May 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etpRiIm0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="50GssRTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8B172BCB
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685928; cv=none; b=slAhdlqa4lEUydVvbMxspq/uYPOOg3stJJb6EOUhFWT8m5e73D2SrTWIKaIBYMYUXEusCuD9ApAoL7cZ+bs4LTa/+MzNazMeZ/8ZsfEbAgdLEYgKBzHH66JzuXDNRkiFdZhR0VUUfXtQixSrETIcsllvJ/xC8ho3sC6DKvRYsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685928; c=relaxed/simple;
	bh=B9z0Do1Q1k86KsBEBPg78+535DgVuorMENKSK2N91PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHWIFzjjVpS30VkP7SOgosJPM7yhQT8Rw1lmCpTOhAJ1aIsHP6EHotR3bpZBYdm+/Mqt2hVzDP5aH34rLEAiqazBRsPDBGT/4DSENQHDduhj3V/OB2hRLGAHxSd77IkVx7nLQgzKooEc2l+ORbsJp8DxVrZBkM1xeIvLkA7iejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etpRiIm0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=50GssRTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6ESpqnB9vRJCiZCln55bmHgvujrBmLHD5zot49QaRE=;
	b=etpRiIm0V8TejGggDaTvhgf68fxkb8dZqJlAcZRuzbu74ykrVI9ru7c6NxpvEanmFt/DK7
	elezdEBI0/prCAvNHR2IUU0C5nlYCqOjOcsiG4PPv3+E0TgIDXOUTpxPG1oN9Hrso3OYym
	l+4TV0GLC91l7lfSZK4n7cL7hJurWa4WzIvFuMoShiwotUFLxx5NWuNJfvUI0SJsBkzvo6
	5NbJm6twoWhye+g5Gg0D/IMGjmV1VMBk+wegUi7ogbAdXZi2/8QMgLcPfnqD9QaM0BxZjB
	XqLdfJjUoGLcHfqyRa2vl0oxrWZW6RTnjv2CLSq4pH6tryFqkovcGnMKx8Pgrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6ESpqnB9vRJCiZCln55bmHgvujrBmLHD5zot49QaRE=;
	b=50GssRTK0qJQethWFSYAqUfdmiE+zwgWEuxvIz/WBEhU5skIzwl7UjL1xbPyupzSmW7102
	abJo070DyjHZyGAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 02/30] printk: Properly deal with nbcon consoles on seq init
Date: Thu,  2 May 2024 23:44:11 +0206
Message-Id: <20240502213839.376636-3-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Mladek <pmladek@suse.com>

If a non-boot console is registering and boot consoles exist,
the consoles are flushed before being unregistered. This allows
the non-boot console to continue where the boot console left
off.

If for whatever reason flushing fails, the lowest seq found from
any of the enabled boot consoles is used. Until now con->seq was
checked. However, if it is an nbcon boot console, the function
nbcon_seq_read() must be used to read seq because con->seq is
not updated for nbcon consoles.

Check if it is an nbcon boot console and if so call
nbcon_seq_read() to read seq.

Also, avoid usage of con->seq as temporary storage of the
starting record. Instead, rename console_init_seq() to
get_init_console_seq() and just return the value. For nbcon
consoles set the sequence via nbcon_init(), for legacy consoles
set con->seq.

The cleaned design should make sure that the value stays and is
set before the printing kthread is created.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  4 ++--
 kernel/printk/nbcon.c    | 10 +++-------
 kernel/printk/printk.c   | 41 ++++++++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..739b82adc383 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,7 +75,7 @@ u16 printk_parse_prefix(const char *text, int *level,
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
+void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 
 #else
@@ -96,7 +96,7 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con) { }
+static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bcc01fe..de260531b0da 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -172,9 +172,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
-
-	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
-	con->seq = 0;
 }
 
 /**
@@ -961,20 +958,19 @@ bool nbcon_alloc(struct console *con)
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
+ * @init_seq:	Sequence number of the first record to be emitted
  *
  * nbcon_alloc() *must* be called and succeed before this function
  * is called.
- *
- * This function expects that the legacy @con->seq has been set.
  */
-void nbcon_init(struct console *con)
+void nbcon_init(struct console *con, u64 init_seq)
 {
 	struct nbcon_state state = { };
 
 	/* nbcon_alloc() must have been called and successful! */
 	BUG_ON(!con->pbufs);
 
-	nbcon_seq_force(con, con->seq);
+	nbcon_seq_force(con, init_seq);
 	nbcon_state_set(con, &state);
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c7c0ee2b47eb..e6b91401895f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3348,19 +3348,21 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
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
@@ -3381,7 +3383,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(true, &init_seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
@@ -3394,19 +3396,30 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 				if (handover)
 					console_lock();
 
-				newcon->seq = prb_next_seq(prb);
+				init_seq = prb_next_seq(prb);
 				for_each_console(con) {
-					if ((con->flags & CON_BOOT) &&
-					    (con->flags & CON_ENABLED) &&
-					    con->seq < newcon->seq) {
-						newcon->seq = con->seq;
+					u64 seq;
+
+					if (!(con->flags & CON_BOOT) ||
+					    !(con->flags & CON_ENABLED)) {
+						continue;
 					}
+
+					if (con->flags & CON_NBCON)
+						seq = nbcon_seq_read(con);
+					else
+						seq = con->seq;
+
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
@@ -3438,6 +3451,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	u64 init_seq;
 	int err;
 
 	console_list_lock();
@@ -3515,10 +3529,13 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon, bootcon_registered);
+	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
-	if (newcon->flags & CON_NBCON)
-		nbcon_init(newcon);
+	if (newcon->flags & CON_NBCON) {
+		nbcon_init(newcon, init_seq);
+	} else {
+		newcon->seq = init_seq;
+	}
 
 	/*
 	 * Put this console in the list - keep the
-- 
2.39.2


