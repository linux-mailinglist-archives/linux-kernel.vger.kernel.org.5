Return-Path: <linux-kernel+bounces-166961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839E8BA273
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9873EB23CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B51C688B;
	Thu,  2 May 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJfuKLmN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTqSDxmT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6A1BED8F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685931; cv=none; b=d23DjOjbR+bOktP3AedJP1XfA65Z+9uNS2fGNwoP3yN4RFCJ51wpOCpuv4zRCMj9u+Q5cvboyVwFEkGVVWUKB6unpq8aq/+QJaePhzeKPTWLZ13/HS82HZYvhCXi55t+mtu/mpEi3a35DNJv0Mn4t7Sc1pu22u6NxWBSSx8V4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685931; c=relaxed/simple;
	bh=nzXHdmgGHM2QSq1RQgJ659dlvXdtfhLYf/m9dCbBats=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+i/ng6coSUcfk5XMcJLA7S/cZZaQn1t0DUWniyHceGUFj39Yyk4Xvj5nGeSInYdlY9phsD+kF4FA4zjjpqh//8Si5tg99NtR0xCrldNQYQAHg2KPz10c2MY76HwU9vERAB9ho5XqQJ4vNYowUVHE9ytjRjzpc+s7632GQP/uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJfuKLmN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTqSDxmT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SspE94wEVwK1yFu/e9otElRRg8AlYMKwqViOUc8d8w4=;
	b=mJfuKLmNTjK4pgFYAss3hLTLyB1zfj0nHGCUtoj+5jSLaBgG1ZbNN6BDxiPwaKjfnruNob
	ivrP0+5Y+gl+pMBdAkhN6sGmwy+3lZ5l3YT+TWm5rRY9z1Am8gPua72Wj+raTXrTr+9sNu
	Wajxvhlh+uNeNMWfw0owhevElikx5/Y121AURJkciqxuYhYmnPIMigmht+FODetBhM2oKd
	ac4RnvhmIJLYWxOLPFj8tibSx4ZHb8KHQ2XgWWm1jTmGWECdxkigixb6ImEWicdHgXYNsd
	xMO0rvUWe93Ds5u2Bcg2n0Ioh/UXZ0BleyqglqQGrQJNVXVzFTWmIoT8OqFCuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SspE94wEVwK1yFu/e9otElRRg8AlYMKwqViOUc8d8w4=;
	b=xTqSDxmTEAdynqiThYO1tnJXr3Gh2+hDN/rIFMuwWIG0OWlukLMQhpnBPXn6XkDhZnxAS/
	3ocP/2usEwamLiDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 10/30] console: Improve console_srcu_read_flags() comments
Date: Thu,  2 May 2024 23:44:19 +0206
Message-Id: <20240502213839.376636-11-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was not clear when exactly console_srcu_read_flags() must be
used vs. directly reading @console->flags.

Refactor and clarify that console_srcu_read_flags() is only
needed if the console is registered or the caller is in a
context where the registration status of the console may change
(due to another context).

The function requires the caller holds @console_srcu, which will
ensure that the caller sees an appropriate @flags value for the
registered console and that exit/cleanup routines will not run
if the console is in the process of unregistration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 33a029d976c3..aea4f5aa4a45 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -428,28 +428,34 @@ extern void console_list_unlock(void) __releases(console_mutex);
 extern struct hlist_head console_list;
 
 /**
- * console_srcu_read_flags - Locklessly read the console flags
+ * console_srcu_read_flags - Locklessly read flags of a possibly registered
+ *				console
  * @con:	struct console pointer of console to read flags from
  *
- * This function provides the necessary READ_ONCE() and data_race()
- * notation for locklessly reading the console flags. The READ_ONCE()
- * in this function matches the WRITE_ONCE() when @flags are modified
- * for registered consoles with console_srcu_write_flags().
+ * Locklessly reading @con->flags provides a consistent read value because
+ * there is at most one CPU modifying @con->flags and that CPU is using only
+ * read-modify-write operations to do so.
  *
- * Only use this function to read console flags when locklessly
- * iterating the console list via srcu.
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
+ * and that no exit/cleanup routines will run if the console is currently
+ * undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
+ * @con->flags directly instead.
  *
  * Context: Any context.
+ * Return: The current value of the @con->flags field.
  */
 static inline short console_srcu_read_flags(const struct console *con)
 {
 	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
 
 	/*
-	 * Locklessly reading console->flags provides a consistent
-	 * read value because there is at most one CPU modifying
-	 * console->flags and that CPU is using only read-modify-write
-	 * operations to do so.
+	 * The READ_ONCE() matches the WRITE_ONCE() when @flags are modified
+	 * for registered consoles with console_srcu_write_flags().
 	 */
 	return data_race(READ_ONCE(con->flags));
 }
-- 
2.39.2


