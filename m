Return-Path: <linux-kernel+bounces-56571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38184CBD3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77F6B260E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D97E77E;
	Wed,  7 Feb 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOWZLETl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZVlsQJP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22BB7C092
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313283; cv=none; b=AVVdvwThAN6fVYiuxQnVjck3a+1LXihHiSp9ORXumOdCjwg0rUMSAbZRJe5yyWPngXCa2AdZBMbJUToFliAgDxyO3+Uigr3DtYaaSgYYVNPcCVpmeBjIYrPsgNYzZwevyG/hguIAwajeR8qLBz2edC7Fh5UXhE9dJxXT4+/C8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313283; c=relaxed/simple;
	bh=LgqHmaayiIBzXTCRVfuLGbNqvjVYRa0vasgGK+33Hc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GfMj6HJnxD1Ko6IJjlTPSp7+53JX65JIjNX3FH1WPWGVOm0TngV1du6lVOjkTGgMg3WV7HIJnXbS+fLzKe0ptFAeXmJ6UM73ix/MixTCfMyofS/P+/oB/hHN9J3aEWff6Y18gFNfXb1w3opWds03AaGa4JbAb6ED6ScoBSaj/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOWZLETl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZVlsQJP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qr6+1j81aENvGfbCAyeGtVP3cfgAJxlpbRhW4IiDqto=;
	b=UOWZLETl5J68nJmWxOfvORvekRjA8gunoQq/j/rMaDOPt3K+o5KHeH9r+cdhcPw3p+iWGE
	y/yzKHYlXvEr74Z8VkYqkvjWy80B7Sz+hz/CFoy9IjTlLFB7ceKhB8NH0KTDvll4yInx/Z
	T2yRNLQnZZ20LIC3wH/CfUr+ihk442zy3anpH4vyzrO3ztDR3g2lylP0N2fqybBegyPrin
	MxIlixqUaW6ompHY7BpseLDGuusmJE6/R7dQ236hronWGNXG+e2oABU5bubwmOQE6+/mJ2
	UfEpBtaNS33gjbIxF76bCYGHEdQeiLiTiI0Er5ZYcoJKLjvnsnHNFnq5E3EcTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qr6+1j81aENvGfbCAyeGtVP3cfgAJxlpbRhW4IiDqto=;
	b=8ZVlsQJPNIK7aih4qE1pCWt2uBXwc7crk6HrxBoNG0qJi1dAqhS7aXEood5IQVdiN/gXK9
	1myip7bxPQrnY+Bw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 12/14] printk: Avoid non-panic CPUs writing to ringbuffer
Date: Wed,  7 Feb 2024 14:47:01 +0106
Message-Id: <20240207134103.1357162-13-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 13fb0f74d702 ("printk: Avoid livelock with heavy printk
during panic") introduced a mechanism to silence non-panic CPUs
if too many messages are being dropped. Aside from trying to
workaround the livelock bugs of legacy consoles, it was also
intended to avoid losing panic messages. However, if non-panic
CPUs are writing to the ringbuffer, then reacting to dropped
messages is too late.

Another motivation is that non-finalized messages already might
be skipped in panic(). In other words, random messages from
non-panic CPUs might already get lost. It is better to ignore
all to avoid confusion.

To avoid losing panic CPU messages, silence non-panic CPUs
immediately on panic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cb99c854a648..1685a71f3f71 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -462,12 +462,6 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
-/*
- * During panic, heavy printk by other CPUs can delay the
- * panic and risk deadlock on console resources.
- */
-static int __read_mostly suppress_panic_printk;
-
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -2322,7 +2316,12 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
+	/*
+	 * The messages on the panic CPU are the most important. If
+	 * non-panic CPUs are generating any messages, they will be
+	 * silently dropped.
+	 */
+	if (other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
@@ -2799,8 +2798,6 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_suppress)
 {
-	static int panic_console_dropped;
-
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2828,17 +2825,6 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 
-	/*
-	 * Check for dropped messages in panic here so that printk
-	 * suppression can occur as early as possible if necessary.
-	 */
-	if (pmsg->dropped &&
-	    panic_in_progress() &&
-	    panic_console_dropped++ > 10) {
-		suppress_panic_printk = 1;
-		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
-	}
-
 	/* Skip record that has level above the console loglevel. */
 	if (may_suppress && suppress_message_printing(r.info->level))
 		goto out;
-- 
2.39.2


