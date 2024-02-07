Return-Path: <linux-kernel+bounces-56567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B429084CBCF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687A81F22EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B77E57A;
	Wed,  7 Feb 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxq/6dVE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BdlvPSC8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679B7A720
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313282; cv=none; b=nl9he+8QHHMczTJK5XFTX0oVeGX6LVP/RI7JFB4erDNST3J40BuqcxVGaa7i+3w5cz4V2I6lm1z7e1DrEsePoYqWpgbrWRQJQFH7lEmU4fNlukxn52iyLfH93E2xKCCZ7la5rUmkMHz/C/GqJ/9Mq90Ge2QmU+j1RX8eA5GzICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313282; c=relaxed/simple;
	bh=pLiQvlJlgDBEc8pKrVIe9E9OdNeQXjek3j2d6X2PiC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6NiKbN68y6GcYS6weManlqyZ1EAANkMGyyW+RN5nP+Ck8nYBQLxzidHmDyba7sBhkwkZa/+YBVPJqnTaFn+e1JkzxwAnk9SPH6haE2+9nsxz1Y6csaek3TX48ozu8ihgInmvkR/oYWxgaNstqznfKOBk+THdc+jF8KVJcKTeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxq/6dVE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BdlvPSC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjNlI5JonKv0m/kINdXCywSbWYOfTvFxrSFxNOQW5Ko=;
	b=uxq/6dVEvZ37HS80Hjl/vLmUowIdMGNG0hnAoQnu3K+bjeH/0sOnBtzakxA0IzW6cVNL3t
	7ZfegUL77aQJqqUviE5RemwOyw3m2rcrZ6dXNm7IaY72d7Ve7pmpl7yOcID6pKxSu8RgAv
	W8g6ZO4SU8TbWUxTHQOiohh+dF7SeZXD6uO2orChx/8vFbglOqNIXahY13nJi/OTyAojoJ
	ujBzqhCdvuycWQjX4Bmpip+8lxEiskvouWWhyYPSJ9GskpskSsG+9zxwt4nTAScZBjPqB8
	4CX492ci8Ap8YtZ7E1bMBObhd+nArjR9MI2Fn2heY1WfK06VFUTLnFosqc+Enw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjNlI5JonKv0m/kINdXCywSbWYOfTvFxrSFxNOQW5Ko=;
	b=BdlvPSC8OAZuBClMDP+9MvJQiYBjLXPNQBmQ2WX/Xsk5C//z4EHRDNcPx20FzIVugyf+WM
	Mp5PFQTn0R8jD2CQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 07/14] printk: Add this_cpu_in_panic()
Date: Wed,  7 Feb 2024 14:46:56 +0106
Message-Id: <20240207134103.1357162-8-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already panic_in_progress() and other_cpu_in_panic(),
but checking if the current CPU is the panic CPU must still be
open coded.

Add this_cpu_in_panic() to complete the set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  1 +
 kernel/printk/printk.c   | 43 +++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..ac2d9750e5f8 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,6 +130,7 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 22bb45d8f2f2..82dc2c7949b7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -347,6 +347,29 @@ static bool panic_in_progress(void)
 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
 }
 
+/* Return true if a panic is in progress on the current CPU. */
+bool this_cpu_in_panic(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
+}
+
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool other_cpu_in_panic(void)
+{
+	return (panic_in_progress() && !this_cpu_in_panic());
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2592,26 +2615,6 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Return true if a panic is in progress on a remote CPU.
- *
- * On true, the local CPU should immediately release any printing resources
- * that may be needed by the panic CPU.
- */
-bool other_cpu_in_panic(void)
-{
-	if (!panic_in_progress())
-		return false;
-
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return atomic_read(&panic_cpu) != raw_smp_processor_id();
-}
-
 /**
  * console_lock - block the console subsystem from printing
  *
-- 
2.39.2


