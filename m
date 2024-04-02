Return-Path: <linux-kernel+bounces-128776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5322895F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022321C21F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4116131D;
	Tue,  2 Apr 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUDQJHLm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bklhxsNR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12C15ECCF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095906; cv=none; b=cHcxvXtJ+7DBFf5nKpbmgbiRGkBhDUlRiYfoFmFrQsjHIvIB37jjmmYgv5JaFMUg+Z/runJPZdUlR2yNnzwzLzND0sXlEbngI81JQCLqncMWJjvr/LZW5a7xw/s2b4MT//JdeYdA5y0xh+kaP8QVwhUUgcBytWQgIl6MHNyV3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095906; c=relaxed/simple;
	bh=TS4bAdNkoZ+0goSa9kqRyHujH5ai41OqMG6rA/WUJxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLaVntAAvs4HUGVQzufYQDCPJKBKpb++6c/uHmMyazlZeJPvcst9ZAVZZw/5sA4yolu36ymp3Hfy2eDYvmT62ASif85yi0mm9viugMXsiaYn9yrrIki2cDlV5mE3N0/l/ltQI9qXWxG8XhXHI+x8YwMBNmAogkUEk6ZsX82Kx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUDQJHLm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bklhxsNR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njd4JtOG9TQM4vCbEz3L/KsWtYnSSvFEDH3F97Q//58=;
	b=oUDQJHLm2ib2I/FfRr3s6EIt5CFGaFnPfmLAjOYeOgER719S7bCNEZSqXodJGd+QQ7MkI1
	Mm9F4nTZYdYo/EYOgGiQUI7Y0OaVAkDa/wUaXt4avKJGQBbngUXylfrFlvgdFP3i5qpn16
	//hAUqQCH0Sbs2lQOTMVau5nybDQFcAOMqZ1YBHANOGaHvcXw9g88ExRzlkuAeDJ4jI9Gi
	LuR56qyhOJJdulY8Irs3y//e3q3PbDdVEGRogbnFZKp9SNQbMt/68SsjQ6FmIiU56mfCXC
	EcgADShu3whSz0ktlkIlXPE77LVX1h6dipYiADyVrDmSqpZF+XDphdrDev8a2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njd4JtOG9TQM4vCbEz3L/KsWtYnSSvFEDH3F97Q//58=;
	b=bklhxsNRc3GcgoRf7Iw9i5tJmE28nuMOZh/IhzyF2ChlZYZM/hUHOQWHXE4DYNic45ayGz
	ButLixT4+AjAMfDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 16/27] printk: Track registered boot consoles
Date: Wed,  3 Apr 2024 00:17:18 +0206
Message-Id: <20240402221129.2613843-17-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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
index 6404f2044ceb..a1b3309e12c1 100644
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
@@ -3513,6 +3521,9 @@ void register_console(struct console *newcon)
 		newcon->seq = 0;
 	}
 
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -3582,6 +3593,8 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool found_boot_con = false;
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3629,6 +3642,17 @@ static int unregister_console_locked(struct console *console)
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


