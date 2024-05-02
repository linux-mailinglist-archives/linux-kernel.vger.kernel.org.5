Return-Path: <linux-kernel+bounces-166967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5A8BA279
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69931C2204D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD8D1C9ED0;
	Thu,  2 May 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olQiN3+1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpcfrFDh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299161C65E2
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685934; cv=none; b=AePFl/Yjh/ZB57th7UsOWImhDP6IwdP1ZrpaAFlzuG0gk8AAlRgUy5qr3QlnrNbZ3sD4bei7AQW86HmlgvJtIIduiiq10Mx/DRVSohXTfwyjNnpXW/KHPPoJxvPrqwuWhKnqzUxy2XYSp7mYy28Tajv1pWbGnJX4wqUli7xD20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685934; c=relaxed/simple;
	bh=uz9PsDDM91Md3077crOcgUldGsieRbCgfcyBWemN+Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vr+iGTBxIr1OriOe7Vrtgo0B9gFKT0ds8ufiO9lV6YeGA3qpVVVRr2hv5Z80Q3u3uSModXl7krfRA4f9ocPaYkJsqd80og3JLaa2IdjOBSoO384VqFq/W9456AZgj6x1ZGNYdtcuEbHXcW1H0GS4iA15X9TR6IVJ/BTabdSflbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olQiN3+1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpcfrFDh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJyf1SS8ltJ91fkLBiBJOqIJq9MASgB7rwQdXq0c04g=;
	b=olQiN3+1G8WaRvFcr/nxEYJT07Lj3NFtv911hXhHk5/BGbPlhGgPfz1E4kXwevrv9kGK/p
	9Tu0Zhno8uAv4yTX6ptpMoO8FfYZ0M/aivpVprngtemvSLhUnf22zIUYaR3ZuP6oSWgF0f
	f9rsdEz8ZrdpuhecH6B9L6m0BPdBS804ZbO+Oibdm3KQc3pHb5KwBUm7kE1icoz15RQKaJ
	CV8CnOivN/GwH5Hpc33N+RvRwXyrwWSdniCNDJ5F5QgLaQeS25nqNRCRLm7uGyTE+Q7PSQ
	VAN/C0PYTRQ48hbYroAqJP0QuHgkM/LBpYtGifPCEJ59B6o5LhBN5q8NTx/vww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJyf1SS8ltJ91fkLBiBJOqIJq9MASgB7rwQdXq0c04g=;
	b=HpcfrFDhbJz1GQqgnpyEtvBFfCNt7Tw8uqDTW7Jq3Bwo8bdCH63aalcimbEg/RH7Pad+4O
	HrdLtYCWbKu7DyAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 15/30] printk: Make console_is_usable() available to nbcon
Date: Thu,  2 May 2024 23:44:24 +0206
Message-Id: <20240502213839.376636-16-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move console_is_usable() as-is into internal.h so that it can
be used by nbcon printing functions as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 32 ++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 30 ------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c1d01eabf3b..339563dd60bb 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -85,6 +85,36 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_srcu_read_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	short flags = console_srcu_read_flags(con);
+
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -106,6 +136,8 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 
+static inline bool console_is_usable(struct console *con) { return false; }
+
 #endif /* CONFIG_PRINTK */
 
 extern struct printk_buffers printk_shared_pbufs;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 15d19d8461ed..b0e99ee472e1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2697,36 +2697,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
- */
-static inline bool console_is_usable(struct console *con)
-{
-	short flags = console_srcu_read_flags(con);
-
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (!con->write)
-		return false;
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 static void __console_unlock(void)
 {
 	console_locked = 0;
-- 
2.39.2


