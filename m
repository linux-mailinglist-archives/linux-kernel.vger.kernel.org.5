Return-Path: <linux-kernel+bounces-166970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C68BA280
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD71C20987
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006DB201263;
	Thu,  2 May 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWmd+jZE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhE/TxHH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9B1C6898
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685935; cv=none; b=o/7oWtLGbhTQZdSQtx0bNQ4AyyEJmfybXHEa1zbzK2ETj2QgW+bHPWaVNT09YxS6X3I0JsHPpe0Ie+Ih7T4DC4ShkvRXvlOysUGguduojIkAIzcPwDnMiT0RNKZN3eihlKLL3SVEchicOB3Z0//XjDehQjO/i55siwmSudqC9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685935; c=relaxed/simple;
	bh=eBpAe0m3jkrciUtpy/gK/+A8yIKAuwbXb+fVieGeCys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qr2kuATVtuhxsO/l1MMkpWfHDMQfcyYZWDa8ekMQt/NP15H1VtLHFp5o1YYeyeo5yjclQwkgAQecSl2/vXTcQHImLhW8JHXObf9PfaChLa3AqKS610yiC1W4fnq18TRJ9AGigjRdr8Un7Uc/jYYNy8GrQk63BlJyzmyvNmp2MVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWmd+jZE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhE/TxHH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5pjl5Q+p+FjfYSMKXRHKDtD1jLA4O0osbygvWzIAZM=;
	b=KWmd+jZEX4WhqnFPiNK65pGiYeOZgEKMu5AN/162/WiCwuXYdbqJKLQD/QnKltRlnnAij0
	izyHNlaCOX6J915DvELmtYN0aAR676WhEdcNF1vwDsQkUxG9eEXqCsrT+zboj5k1lsWarH
	dnMdcnUDhHxYGyKMuPareTD3HevuWnine+dmb/QpmGVuEyJ8Z9EAkqxki9Ok1tnQ7XJCGk
	MkJoAPw50nUdDLYQfJeB9tVboRhG3gyrjcRnzLtsRNtg3jAv15QCjm+MpeYuRUuZD2fZcE
	MbJRD3xxDzsOfELsOpPn/67uCARkb2ZaeuV7jMpV2CPfSTG1Cc56EuzgsU55gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5pjl5Q+p+FjfYSMKXRHKDtD1jLA4O0osbygvWzIAZM=;
	b=dhE/TxHHWlXSAOSf/vIr/B7q/57V05gpNTEy9NIuwTae6RV1k1g+RjVvd3jXRhhcwMV59k
	yweaT8HI61w/T1Bw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 20/30] printk: Track registered boot consoles
Date: Thu,  2 May 2024 23:44:29 +0206
Message-Id: <20240502213839.376636-21-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8c93ef6292ac..e1cf0f7d6ff2 100644
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
+static bool have_boot_console;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -3511,6 +3519,9 @@ void register_console(struct console *newcon)
 		newcon->seq = init_seq;
 	}
 
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -3580,7 +3591,9 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool found_boot_con = false;
 	unsigned long flags;
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3638,6 +3651,17 @@ static int unregister_console_locked(struct console *console)
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
+		have_boot_console = found_boot_con;
+
 	return res;
 }
 
-- 
2.39.2


