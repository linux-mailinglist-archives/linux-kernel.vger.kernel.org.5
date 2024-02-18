Return-Path: <linux-kernel+bounces-70508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8E8598C1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D861F22F08
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5297745C0;
	Sun, 18 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJ1/Wdf4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9QfHj5ew"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628406FB86
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282677; cv=none; b=miYAzYkJaujzTcoE3WgimXqdloJ2+rC6t5E7/Osr5tjSRXu++APozVRh2SV9trmSb9RNJ/UW6FophEf9rLC3AZpz1f04QrgOJ8zLgv/C0UaAaXkbUN7EbDZNA7G/4FjqNHVGKldYwmkVOi2WjQWAwzXAbjmrvWep4TxFfPtZy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282677; c=relaxed/simple;
	bh=44GMokOuhofcbVPi1PR9Ui7+7904b0FBavmkwZ/WX3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUBl1w3al/mN1IT1Bi2CHZxDEnuuTrCip1GDUaPAWYNmQQP1sEB5qFoet0vUoJQ70fkew6aCl8vQ0Kh15cobEhijMrcowoUpdzQ1OgghTXPLuv3Aj4u072eECXOAeNJleCoTGV9/sGcOwVSLQm7ESoENFXUX3jfMe0HCHt3+Dt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJ1/Wdf4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9QfHj5ew; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA/99sNBe74Zpg0DWyhl5wv3RvxapTRr2AVbgdHNKI4=;
	b=rJ1/Wdf4YXXUQmodc7+URL0ljrOU8z6ZTYWtKB2i5KhN1BD61MJz2T+1+1cvhlgpLJwpQO
	/gbCtKVFxov4Q2DsM1zr+Me+kviqt+CDoGYOgzwqqZ4Ikf9ZRJVIf6E5btxSqpX7cAZzy1
	YUZy+4lQK0+3DNveay7/3XOWXQu4DgJH1QDUlDn/RoCiorZULjjdyofJq6xsjOPs3ek93L
	7679/EUmaZYUedbO9bv9jXkxFlBf4yL+8OrB1fzlv8hQa+D4Pnr1jGgci8IOfHhJjA0BP7
	P/uJAfRzY/GoJovcz8Umt2cb91rwFg9Kw3848oKAb+h+XsWENrq49de0SqTqsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA/99sNBe74Zpg0DWyhl5wv3RvxapTRr2AVbgdHNKI4=;
	b=9QfHj5ew/k0LsjwUvp0IoPme/gb2gFwSzUmf3FCspKkLClGC+ux0FPNIurkWNS3ZRu814F
	ocrdcs+7MlSWVvAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 15/26] printk: Track registered boot consoles
Date: Sun, 18 Feb 2024 20:03:15 +0106
Message-Id: <20240218185726.1994771-16-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately it is not known if a boot console and a regular
(legacy or nbcon) console use the same hardware. For this reason
they must not be allowed to print simultaneously.

For legacy consoles this is not an issue because they are
already synchronized with the boot consoles using the console
lock. However nbcon consoles can be triggered separately.

Add a global flag @have_boot_console to identify if any boot
consoles are registered. This will be used in follow-up commits
to ensure that boot consoles and nbcon consoles cannot print
simultaneously.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea170ade4d42..1b14159990ba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -463,6 +463,14 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a boot console is registered. If boot consoles are present,
+ * nbcon consoles cannot print simultaneously and must be synchronized by
+ * the console lock. This is because boot consoles and nbcon consoles may
+ * have mapped the same hardware.
+ */
+bool have_boot_console;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -3499,6 +3507,9 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_NBCON)
 		nbcon_init(newcon);
 
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3551,6 +3562,8 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool found_boot_con = false;
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3598,6 +3611,17 @@ static int unregister_console_locked(struct console *console)
 	if (console->exit)
 		res = console->exit(console);
 
+	/*
+	 * With this console gone, the global flags tracking registered
+	 * console types may have changed. Update them.
+	 */
+	for_each_console(c) {
+		if (c->flags & CON_BOOT)
+			found_boot_con = true;
+	}
+	if (!found_boot_con)
+		have_boot_console = false;
+
 	return res;
 }
 
-- 
2.39.2


