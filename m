Return-Path: <linux-kernel+bounces-128778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B23895F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FB22863A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3F161907;
	Tue,  2 Apr 2024 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVqydypU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFndZ9+h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C316079C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095907; cv=none; b=cGljrNoOl7zGV1TBg4dNYa6CHfhBE26lV+dYCD4aLiTuPt3AOkP6dtHsaUT/uPObuLjW3NFMP02BfkmPEZ7NA1ffhGm6I/6lHs7KUf0LSglDwWfQh7ggU4IurAFjaDty1bpFWYuGb9uydkbM2lufOSPPDpjutNF2917H3gi/MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095907; c=relaxed/simple;
	bh=/yzLu1pIIII3CwMbKuTCCS8fK4EldDhvROOaEuVQjWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kau4q9xgeGatmizdiZHBw9ako/DblJNX+tukknNOaLxpt0EUE8mM26rhYxys5bEAXRWwqLS0j0PxwQf+AhJb7JUL2G0k2tc3+pMmNei1qLIOkvCr/MS7ql5n5KTPG3yKHCY1xVOJzbYzR935LBv5ihgG1rXwdOxp+ZyYlGgUS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVqydypU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFndZ9+h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJEBBwWx+7a9Zf6U00LLvkq51McCiYjQLaxDLROSFw4=;
	b=iVqydypUc7tJSDm6VB9QaXe/HXQ5DEwl210/4AxLpwljFtDmsSN//45eB0hNGYdxPPPPf6
	ZW4tVFFVt7Wb4wEfjk+JXJ+v3KyMDR64Gc4ANWk5O/lYRu9/OPA1U7UCJbtiTcFGVkAwUp
	y+bgkmFe0fN0fLnTW52dX3+cK+/V2kOlF+6ySyulcwjujOi6UVwYBUBGBQSNNDTAb5//bd
	hEQilKsodOpvulQrvVDtE3Fu2DivKoDpwg2/ptrIqrwnuA+TgF62Ogu8p6Y4nhSLASzHq2
	hEDjTSfN5dYN7kjvYUIRfBR+wTwRsZSk5uW5AHlFYLBVwl3sCSiN0HgRVrwL2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJEBBwWx+7a9Zf6U00LLvkq51McCiYjQLaxDLROSFw4=;
	b=zFndZ9+h4vcpEiCP4WGOKnhKSrlI9j9E+NdpsnYdNYmJgrGqOTD4vBUNhvwy1EG1OKAGHu
	P3LjnK4RZMIRECDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 18/27] printk: nbcon: Assign priority based on CPU state
Date: Wed,  3 Apr 2024 00:17:20 +0206
Message-Id: <20240402221129.2613843-19-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the current state of the CPU to determine which priority to
assign to the printing context.

The EMERGENCY priority handling is added in a follow-up commit.
It will use a per-CPU variable.

Note: nbcon_driver_acquire(), which is used by console drivers
      to acquire the nbcon console for non-printing activities,
      will always use NORMAL priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index acf53c35b7a0..bcf2105a5c5c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,6 +86,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie);
@@ -143,6 +144,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie) { return false; }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 599fff3c0ab3..fe5a96ab1f40 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -967,6 +967,22 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	return ctxt->backlog;
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
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts
@@ -1001,7 +1017,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 	stop_critical_timings();
 
 	ctxt->console	= con;
-	ctxt->prio	= NBCON_PRIO_NORMAL;
+	ctxt->prio	= nbcon_get_default_prio();
 
 	progress = nbcon_atomic_emit_one(&wctxt);
 
@@ -1032,7 +1048,7 @@ static bool __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
 
 	ctxt->console			= con;
 	ctxt->spinwait_max_us		= 2000;
-	ctxt->prio			= NBCON_PRIO_NORMAL;
+	ctxt->prio			= nbcon_get_default_prio();
 
 	if (!nbcon_context_try_acquire(ctxt))
 		return false;
-- 
2.39.2


