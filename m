Return-Path: <linux-kernel+bounces-70501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E78598B9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7746B1F22320
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64EC6F51E;
	Sun, 18 Feb 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/8tYXT2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9pMn/EB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867256F09A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282674; cv=none; b=i17QdP1VY/RTZXJDka9/mDBWz5zavUzQZZ+rs1x6oSy/3UnayIQLh8RkVriMG6LfYg2SeWVeDAts1/qiT+eyS+mRSHqCBTesZ0OOYx2EQ1gLj+pkQImwHhSr5aDnJX3XkJ9KrbDPqYO82m926+lkZMDsNYAp/fJbfJPF9iF5gSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282674; c=relaxed/simple;
	bh=QUm3HonFr4bI9kdM8sLrYXTcDYUW2kypDJWENyu683c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjCMBKPat0XMtGHi0sO76J4FnPHFGwYZ3L7KbJRzLJYMKyeN1PI+eE86YXrSaMlVEVcr0Ovcjj7uxugMK8AvnsjaJCGtXCdJ4K/pscVYgPp9gAzz4KawjsgGTXxJ5ZsAKRPL08YiMbxFaQFW0X5VCqZHCfsIuybl0ofOv4Uex8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/8tYXT2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9pMn/EB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhiYAxJ52E/enQP4Ayf/MIif8Xm2i96p2VSKi7x6/pk=;
	b=Z/8tYXT2WSDAy/oWuJCJWbFDqgYvMv1StysN1afFGWiaizrs1Sey8dbHymursqMg64AOxu
	8y3QmJDsjKSQsXAg9Xq7OL35hf0l20OSbsFDRS1bpet71gqBMKUzO23Nft/f2TZkFaCQQJ
	1VTKQ4aEuBfNEMI3CmjUMOzSEDx7WFjsaU8jEf4gxH+EKyJcEPpDplzpU3P9MHt2cm5/jO
	gg4482yTJPtLbcRrLt+gJOCyqWS3gjRtuBMfK1Jr6J3j2lS2//JhLt19l/q3Onn9y6fIzD
	6uinp4xNsIoaOBEk34ufZOFS/TEUy33xfgohPM1mPd+IXv8IWmDIPngc13shyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhiYAxJ52E/enQP4Ayf/MIif8Xm2i96p2VSKi7x6/pk=;
	b=i9pMn/EB1LeNHwwoyZzphndAhEQPz7vVuj1gMJibIlEhslNTv+R6kLlQ5h+5I24cS/nFdG
	v5uWCEVLIW/zfIBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v2 07/26] printk: Check printk_deferred_enter()/_exit() usage
Date: Sun, 18 Feb 2024 20:03:07 +0106
Message-Id: <20240218185726.1994771-8-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
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
---
 include/linux/printk.h      |  7 +++++--
 kernel/printk/printk_safe.c | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 955e31860095..8d5c5588eec9 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -159,13 +159,16 @@ __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 
 extern void __printk_safe_enter(void);
 extern void __printk_safe_exit(void);
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
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 6d10927a07d8..8d9408d653de 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -26,6 +26,18 @@ void __printk_safe_exit(void)
 	this_cpu_dec(printk_context);
 }
 
+void __printk_deferred_enter(void)
+{
+	cant_migrate();
+	this_cpu_inc(printk_context);
+}
+
+void __printk_deferred_exit(void)
+{
+	cant_migrate();
+	this_cpu_dec(printk_context);
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
-- 
2.39.2


