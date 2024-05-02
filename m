Return-Path: <linux-kernel+bounces-166955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF28BA26B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA23B1C20EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503419DF72;
	Thu,  2 May 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHVEbyNa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tdV4BBLA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03518132D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685928; cv=none; b=gdlDkKh/jmWcX2PEOGwiH3mFqrnaNetNriQiSqb1Cw8q0O7tAX9G99KHu2U3Clk/HssKv1mDtheV59qPJ97gN2Br9/98+AkLaDnbS7owVK78dwax1eoS0IMrP5BsY3fE1MjVTxt51W6VrJBD5RSE3mMF+Lcyz0HEl6J08A9lxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685928; c=relaxed/simple;
	bh=NbX9KqSu+VKC9sOzIh/s7S68iv2vejeD4ejGhNdGI1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXGa/37Jjtmypn5BKtF3/dpksK0AvJIGezqwokHPVsQxCidsQ7jbLHnrTSRHcJ71PNnotX+W2mc2OWwrAnjgHVHt3gtkaW6kWW3CVg6MWOVF4w+Qoao1+xJlklA/HZXVSBGeJ/HFsRhePyV1v4O/iXA/vbS4eEmshFnFe0bnLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHVEbyNa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tdV4BBLA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGNvVJcsNgc3jll4nDoPF6g4hs94SRVjeR/SV60Zi28=;
	b=mHVEbyNadP/y1Aos7cR+kyTwG2WXBYdr8zim+Ij95yqUPwx6QXNQxyleYFc2zrkmmGhdVW
	vOmnUG0r/5prUSrKhwh3UIfggbBnjvJtw7vRaYUuaDKRonp+K/a6bFHyRk6O0YfOcFrDkL
	59VqfLSWbH9DIb/62uQ9s+PGFiSgU7avdjgtVQxgJ0ILBCehAPCBgEWI0rAS2ycnjLY0Q6
	tEB1j/WqhJ81rPRc1e+aAYmjP/7aTCQRKLrZLwKheHQdluicbuEQpF7IakMWUU6G4ji4TR
	Sphs4L3GeGiL33C8Eso/uXs5xPjF9wsasW8pZ4F8+b6VlDu856phRvMto2O40w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGNvVJcsNgc3jll4nDoPF6g4hs94SRVjeR/SV60Zi28=;
	b=tdV4BBLA7zeb6GnBsc/iksSNwSqxn2/A5A0Hj8cJEN8Qlx3pEaJZejdQjtpdTBvFTCfMLr
	s4uskHnUNj9VDQCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v5 04/30] printk: Check printk_deferred_enter()/_exit() usage
Date: Thu,  2 May 2024 23:44:13 +0206
Message-Id: <20240502213839.376636-5-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
index 739b82adc383..831f95f26d48 100644
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


