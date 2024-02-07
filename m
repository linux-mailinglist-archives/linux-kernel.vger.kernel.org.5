Return-Path: <linux-kernel+bounces-56570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A911384CBD2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F3B287200
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206F1E48C;
	Wed,  7 Feb 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x8lxGR+u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1kvO3lbU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1B7C088
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313283; cv=none; b=hKtSDrNTMIxjvUdrv7IEKi3971J4hP+gSxXtUVf7VW7rauA9XyGaJ/MLe4PJlJElpPCQf2yYYUlnbGL0J7V0Att6r8jclmGaV4fo7stydLz95gS4mJ8sySTvLQS8Nj8zzAuFVIJbgAaT4hLNofV8YMcjirnYoKqMUe3BruWHfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313283; c=relaxed/simple;
	bh=X5giHqYzbgyJiLPkgkBV/8/LIFlyXyt3ukrqvKCTf3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBhLjGA9wftFxmrYDY9+wBVi8+cssghhNYXbNSSejcFTKwZvb2df86YBFA4ZRpLNcjK/8DqEIq1COZdUS+Ale74St6U4lwkyX6EfrXe4zDcbckfW6meoGwzvHBSejGJT/QVM3XUv5eVYWbx+EWxPUxrM0Z3KItiXYqErfNSPYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x8lxGR+u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1kvO3lbU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gccnnm0QINuqJ5Q69vjwoN8uCr8tb4sBQoCznhnpik=;
	b=x8lxGR+uYndcXzOVgqTC99FKpgrOa+Ve0hYCCQTZr8nMUp8o6jEr0CKjipw/qU6mff9vnR
	GYnvTuS/uUEwKT/Py48VSZuf7qs6nowKKprCFFgYiSsYaBHSDebswtd41/jYFRvxNDLrxr
	uL+HxAZ0LyuFhMEVurzGth+cUjWys2b0xyAEBSIwbjVp25Ef6ZjVPfeCX2VSJP7fmjBkG7
	JV+NO13i4cDJanV3HqwGJoU4Owp2JA2KT+nUdBGO4MirmaQzbNCe3wFTvx2OeXwNCe1bYO
	QNReJYQ/prxuI0w8SOj7UIKvXlR+TQIMkLEGDdWGhJGUiOOWDhyhCI0v3aQI6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gccnnm0QINuqJ5Q69vjwoN8uCr8tb4sBQoCznhnpik=;
	b=1kvO3lbU1l2I7wX/zd4wnLhnyT7Bl5WP1W8cWsnqchY0kftxTd8CcDmfCYYLTwPQmR0BIA
	/ZFOD0cHPPltwFAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 11/14] printk: Disable passing console lock owner completely during panic()
Date: Wed,  7 Feb 2024 14:47:00 +0106
Message-Id: <20240207134103.1357162-12-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Mladek <pmladek@suse.com>

The commit d51507098ff91 ("printk: disable optimistic spin
during panic") added checks to avoid becoming a console waiter
if a panic is in progress.

However, the transition to panic can occur while there is
already a waiter. The current owner should not pass the lock to
the waiter because it might get stopped or blocked anytime.

Also the panic context might pass the console lock owner to an
already stopped waiter by mistake. It might happen when
console_flush_on_panic() ignores the current lock owner, for
example:

CPU0                                CPU1
----                                ----
console_lock_spinning_enable()
                                    console_trylock_spinning()
                                      [CPU1 now console waiter]
NMI: panic()
  panic_other_cpus_shutdown()
                                    [stopped as console waiter]
  console_flush_on_panic()
    console_lock_spinning_enable()
    [print 1 record]
    console_lock_spinning_disable_and_check()
      [handover to stopped CPU1]

This results in panic() not flushing the panic messages.

Fix these problems by disabling all spinning operations
completely during panic().

Another advantage is that it prevents possible deadlocks caused
by "console_owner_lock". The panic() context does not need to
take it any longer. The lockless checks are safe because the
functions become NOPs when they see the panic in progress. All
operations manipulating the state are still synchronized by the
lock even when non-panic CPUs would notice the panic
synchronously.

The current owner might stay spinning. But non-panic() CPUs
would get stopped anyway and the panic context will never start
spinning.

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f3a7f5a6f6f8..cb99c854a648 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1869,10 +1869,23 @@ static bool console_waiter;
  */
 static void console_lock_spinning_enable(void)
 {
+	/*
+	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
+	 * Non-panic CPUs abandon the flush anyway.
+	 *
+	 * Just keep the lockdep annotation. The panic-CPU should avoid
+	 * taking console_owner_lock because it might cause a deadlock.
+	 * This looks like the easiest way how to prevent false lockdep
+	 * reports without handling races a lockless way.
+	 */
+	if (panic_in_progress())
+		goto lockdep;
+
 	raw_spin_lock(&console_owner_lock);
 	console_owner = current;
 	raw_spin_unlock(&console_owner_lock);
 
+lockdep:
 	/* The waiter may spin on us after setting console_owner */
 	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
 }
@@ -1897,6 +1910,22 @@ static int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
+	/*
+	 * Ignore spinning waiters during panic() because they might get stopped
+	 * or blocked at any time,
+	 *
+	 * It is safe because nobody is allowed to start spinning during panic
+	 * in the first place. If there has been a waiter then non panic CPUs
+	 * might stay spinning. They would get stopped anyway. The panic context
+	 * will never start spinning and an interrupted spin on panic CPU will
+	 * never continue.
+	 */
+	if (panic_in_progress()) {
+		/* Keep lockdep happy. */
+		spin_release(&console_owner_dep_map, _THIS_IP_);
+		return 0;
+	}
+
 	raw_spin_lock(&console_owner_lock);
 	waiter = READ_ONCE(console_waiter);
 	console_owner = NULL;
-- 
2.39.2


