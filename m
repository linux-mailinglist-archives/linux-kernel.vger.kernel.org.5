Return-Path: <linux-kernel+bounces-166968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409C8BA27D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00A0B21FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE31CB318;
	Thu,  2 May 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLAB//lY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eUdzEyLe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A751C660C
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685934; cv=none; b=DEJsxzH7M3EfI5QRhHQkebayWnPLnMN0F/r5yw1dTHcj+LOstj36ZPcD3hanzuvlyn0ZBn3PbB+2CCZ31uJugIqF9rFroFcNA58kjbRPMp9PLccv0FTRmJHVTRg5NFnFY7ErOxM3qjPkH/oKVEXfj2nm+LFjSPSiCiOSSQvhagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685934; c=relaxed/simple;
	bh=tOlb55GZsIaT9cynpsyj5UhAczLLhu/zc6LG7enM9MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsdDEtblRzkSmHOmoWcH48dQeeCkuqGnek8A0IF8+rEgoYgDK7AInxRZ3kJEwSyAIf9LwuCf7okPMuxVzbHYTjVfLgO6FqQAV31/xetEwi4PbNkDMhOBvWfaZsxhN5J8COw3CsdSHlCy9jjSn0jxPNmoX4Umw86poe1atwgSX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLAB//lY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eUdzEyLe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZtMTVl1yOdxUwgi1uSJ5RX46gAn8gugProPBvxHrmg=;
	b=yLAB//lYOLxA2VBr+Fmj4UrmcxxotVzWo6MUxgq9r9uOU5+EB8PBuFZiseZ+Ug6U5CQ39f
	QlhvNuf+72txiBwIe08ugIsqv+IzCUzYNs+YDW9BH8hGxjHJwLXOWovzY4QXOvvuq6p0xk
	FaO9+sL4sqtl9qgZg62T8pUWR8mkzR1A5IBhdKp3bSj5NfzPHtZqiKdoh+8tyLY6CML7tQ
	g76jFSS2AVa6CXROmo6t3gqsIC/l0MDs9wLylZ1r8icHZYrwwFnJoO/knQH2fyvqN3qS2+
	QoL8C020KapG9y4S9cVohx7dHm39/XUyMHVT0IfRWXHkAATKrGn/Rs+tSWBNtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZtMTVl1yOdxUwgi1uSJ5RX46gAn8gugProPBvxHrmg=;
	b=eUdzEyLepH2X4yDnXVKEbC3+f7t8Wp3naT1xcOCcJAY2ZHMAUqswcFhlm3BDJxnhGsj+5x
	XzZ/FmwwUzt5HKCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 18/30] printk: nbcon: Add helper to assign priority based on CPU state
Date: Thu,  2 May 2024 23:44:27 +0206
Message-Id: <20240502213839.376636-19-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to use the current state of the CPU to
determine which priority to assign to the printing context.

The EMERGENCY priority handling is added in a follow-up commit.
It will use a per-CPU variable.

Note: nbcon_driver_try_acquire(), which is used by console
      drivers to acquire the nbcon console for non-printing
      activities, will always use NORMAL priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index e2de2d262db4..5826cd4eed58 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -138,6 +139,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c429f4cfbb2d..e37af5c72d38 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -937,6 +937,22 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
+ *				printing on the current CPU
+ *
+ * Context:	Any context which could not be migrated to another CPU.
+ * Return:	The nbcon_prio to use for acquiring an nbcon console in this
+ *		context for printing.
+ */
+enum nbcon_prio nbcon_get_default_prio(void)
+{
+	if (this_cpu_in_panic())
+		return NBCON_PRIO_PANIC;
+
+	return NBCON_PRIO_NORMAL;
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
-- 
2.39.2


