Return-Path: <linux-kernel+bounces-56573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49584CBD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E89C2855AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F987F7FD;
	Wed,  7 Feb 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zayr+TMU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEnRLdtz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5879DB5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313284; cv=none; b=IIzg8Tm5ng1Uh/BxbwlLZXwjGLGIN2QJ4uajTaOozttR3fwZfuDOGJzbBg7gDV/upJxtoExyXSR9fEQeLFOVWMH8zsFT3BXpSREHSSfwX5gZwwByzo142Qez5vdWsRsAJTrjXtSanwe4dr0An42K0baOfGaitqZA9zDNnzvxf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313284; c=relaxed/simple;
	bh=rCdB1Pa4Tv7uSe3TR4FRXyAZD0vHyhOKHq0ldmSv8k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/B3krhaaehSr6dtC2Dk3qH15OiAqyUNcvXv10tlaqkR6fLpiMtle1aCvatBwOYZmyNp4yBu2/uZijreTNj0ajSBjoHAO2/4fPPHWzdxSgFeYDdUcSStV4vUe5JWAOHimmzpWOApK7KJqiu3WmpjU/CoKyArZQ2BYKNiI3QzsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zayr+TMU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEnRLdtz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tOC9aXvX0QnLyHAZSaZBIUXi3xE4WWmBQ6mB2/+B2Y=;
	b=Zayr+TMUy9c3T9cpC6eEj8Guy8iVZTBL0nRC/wsEBkxwClxISj9Y0K7hevXpYyXb9mSEfs
	fEa5b1XLAks7cSplbX1mKiPG9xRCkrGQhUrIa8vWkMlaCOedn43B018fDlF3Q3Kgwl6sWw
	yrghjQydHqV7B2GXQ05yMYMGS93JIOCOrxQiIWT+2xLgjVdqJ7NP4fJ9au+F/WrCZ6k86I
	rrrj4G138i+eKrdzhWfsBFrbyNe4PI8AMukgM5T0yYpyoSCpQm7KOgqz2A13ZzOHMyrCpB
	8LzxmahywVV2coZTzWbZsW8Y7ARLSAY4/wpbrddoIr23kY4QZ4QGO+X3K0Dwxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tOC9aXvX0QnLyHAZSaZBIUXi3xE4WWmBQ6mB2/+B2Y=;
	b=KEnRLdtzeybX5PwNYbgVrbGJe7LkxghZpjkKSvisgJ7mF5EhQRLRsx9T2aUMrRL7OkBTMU
	hd61myZeEmQTN/Ag==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 14/14] dump_stack: Do not get cpu_sync for panic CPU
Date: Wed,  7 Feb 2024 14:47:03 +0106
Message-Id: <20240207134103.1357162-15-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dump_stack() is called in panic(). If for some reason another CPU
is holding the printk_cpu_sync and is unable to release it, the
panic CPU will be unable to continue and print the stacktrace.

Since non-panic CPUs are not allowed to store new printk messages
anyway, there is no need to synchronize the stacktrace output in
a panic situation.

For the panic CPU, do not get the printk_cpu_sync because it is
not needed and avoids a potential deadlock scenario in panic().

Link: https://lore.kernel.org/lkml/ZcIGKU8sxti38Kok@alley
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h   |  2 ++
 kernel/printk/internal.h |  1 -
 lib/dump_stack.c         | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..955e31860095 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -273,6 +273,8 @@ static inline void printk_trigger_flush(void)
 }
 #endif
 
+bool this_cpu_in_panic(void);
+
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ac2d9750e5f8..6c2afee5ef62 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,7 +130,6 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
-bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a..222c6d6c8281 100644
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
 
-- 
2.39.2


