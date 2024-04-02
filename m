Return-Path: <linux-kernel+bounces-128764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B9895F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D90287608
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9C115EFC3;
	Tue,  2 Apr 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JmpaqF7h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="It7qU4S/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164B15ECD9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095898; cv=none; b=q250+hZ1S/60hl5ndwclzvitLdNbifQk/56BRyJ/DGcfvbgBWkZFm8vxH50Xd9k1Yd7cJHB2AZNbLwDzCghQOU1NveTjuEsAtn26C/QQvfE+OAYrDUBr0WzR5CYLTqIKGHT7z2zRVHT+Eny30Q3BKmDGrUr5zpFDMuKo4Y7MdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095898; c=relaxed/simple;
	bh=jrBdWUk0rwcYI/oiQlw6iijdJI0T4nkboPn0QdreNXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwVJwpDlYnyYT8hZC1owkeKDVAobBDOGVvVuEOaMgmXgny2S7ydZPwfDJ8sfpvW2IyzLP2CHhV6cgEi+yh8/Ymdgp19KJmSkR5Nu1kThXrZhJ38pmNT+BlRpsKEErNlz4v+KaAUkue1Oe2vHxBUv70nzccH7NS6r3OJDBt5SlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JmpaqF7h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=It7qU4S/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7f10dybj3FQO66c59r1wqvQXH3mAcKwMAOFWXgWZuw=;
	b=JmpaqF7hZ4FLu5RF6TYpoK+3EfVmWLLlR1kWZ951pqeuaLSVsruuIVzTy6aaO/tC/Dxm9d
	hFvGW0qCA4jzr8usSgmVTikp0EqQ/j+2QhvNHf6TWoN71TDBYcqiLZb5aTnNIn95gcVe/o
	tPQ1jvi88p0C5VnvaBkElqTJbKX4X/ZQbHQH1C3tPgOb3uuj3Y8bg83Pj6sH4tigHzI3K5
	4G+Hpcu8KxOKSNcfSeZVhnzpu/BvQVCjIqMmiAH73JUmRiUrOyWDANmc7Zf4RCoUqE+3u3
	+eh7DqaBWXlJzVKJ8uMd78Mkus0+6QrmGMyBHEf4uqAiEMQYs91RjCzsrD/azQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7f10dybj3FQO66c59r1wqvQXH3mAcKwMAOFWXgWZuw=;
	b=It7qU4S/vnwflESxCbemUum5nBq739Y9mSUdt7m9223da5g7xjBH38haOBKxn7mA0UQIjv
	VnrH766dSMsTngDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v4 04/27] printk: Check printk_deferred_enter()/_exit() usage
Date: Wed,  3 Apr 2024 00:17:06 +0206
Message-Id: <20240402221129.2613843-5-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Add validation that printk_deferred_enter()/_exit() are called in
non-migration contexts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h      |  9 +++++----
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk_safe.c | 12 ++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 2fde40cc9677..d8b3f51d9e98 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,15 +157,16 @@ int _printk(const char *fmt, ...);
  */
 __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
+extern void __printk_deferred_enter(void);
+extern void __printk_deferred_exit(void);
+
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
  * some code paths that need to defer all printk console printing. Interrupts
  * must be disabled for the deferred duration.
  */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
+#define printk_deferred_enter() __printk_deferred_enter()
+#define printk_deferred_exit() __printk_deferred_exit()
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..4e0edcb3c311 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -53,6 +53,9 @@ int vprintk_store(int facility, int level,
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 
+void __printk_safe_enter(void);
+void __printk_safe_exit(void);
+
 bool printk_percpu_data_ready(void);
 
 #define printk_safe_enter_irqsave(flags)	\
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 6d10927a07d8..4421ccac3113 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -26,6 +26,18 @@ void __printk_safe_exit(void)
 	this_cpu_dec(printk_context);
 }
 
+void __printk_deferred_enter(void)
+{
+	cant_migrate();
+	__printk_safe_enter();
+}
+
+void __printk_deferred_exit(void)
+{
+	cant_migrate();
+	__printk_safe_exit();
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
-- 
2.39.2


