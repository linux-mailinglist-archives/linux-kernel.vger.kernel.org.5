Return-Path: <linux-kernel+bounces-94544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C757F87412F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C7288D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB757143C7D;
	Wed,  6 Mar 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu1a2O/q"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19214373E;
	Wed,  6 Mar 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755552; cv=none; b=rNNdJgwaXZun7LqJeET6tPNBWjeCMzIz6XhaP5DkYwGDb9BulxgtPROrwrPYa1BJ3zViFoO5vPRb91CKhPQJWlWy+kjbJ137nqp/cG9EeoynJ+QbPfIzMyrtFQyib/NH9GAzqkvMzkJEOJkMNIYQs57hBm38JrakQF2MA7xW6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755552; c=relaxed/simple;
	bh=plb56a5rhyamjhuFzBgg3vJIKSYIbdnXKncSM6kqvIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSy6lM3l4AVYu5a4H0adjab5YKor7TWyl9hcOMfzyCp3u0cPIoDUrZ/cSAY94do0t3q6o3fZInAwAFnLphOTRkw1EyatNEDf6nWzlokWlo+Z9+ivKWqMoLrC0xAR6PhmGmwoaBeYcJyX5ZXOkhXEO7lcY9vQxpITusVR/cm9VRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu1a2O/q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd2dca2007so932025ad.2;
        Wed, 06 Mar 2024 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709755550; x=1710360350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXTKoLXqIrz4+7SOUgtyLjrSNsVHgUbwLacVV55lgdc=;
        b=eu1a2O/q0bN7//Bbb14Qr4gXMAIvb709kIX4hrk76lgNDhVX0HQNYzi5HByDk4ponA
         2nj7FpTtjDJQrNYHxxmbN3dacBL6hKSuEES7tivholWkCXaEkJ39w+2CpHo6D1UcE/+r
         XaY8z3rhOgze1qUsDKKwU1wIRB1N6TrYZzounKKkg67hDqi2Ps/Ql5JOKBwZK3SGVzOI
         e3r84r/08YA/Fm7SXAhXI0xStJ0EvvETbEv/2e8Bma75QPTEPvCOW3YtLFjDrCjnZA/1
         +vP0EBvaXHP6JLMwaGKYi5YfwuwB7DqJJ+UrnrgXYWznVuU/4VP+NHPl9d58DjWH/mdk
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755550; x=1710360350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXTKoLXqIrz4+7SOUgtyLjrSNsVHgUbwLacVV55lgdc=;
        b=s6HtjbRNHY6TeefpJGxwpvlxbi/fVGHQAHoLmm0yxHWmRQVv4FHiRVzwmzN4FTTLJS
         nypt1Q09HyMFbuxgT2qNQM62Q9nhhWYcpzz313QsivQldEuucBRPzIa+BPwQLGXysJ9a
         AvWzYApNRR/iUzTZ4cXOtW6nM24oL1lfTgSYuxhTTQHcAkLmiZdHlfcwq4rjh6FOpOvE
         SR/ESaTz117q/4Z2400Ipc8z4O8hvh0XF7s6vgrpilxJDLxcAPnOMABgRDec5/crpRvd
         mZhxbs+ReP6LFuzrI77q2VEIUTxl7QNi6s1tczVvmpdogp8urpkmW7ZIN/QT9gAi5A7u
         4hEw==
X-Forwarded-Encrypted: i=1; AJvYcCXpNA8Ie2DQmI2i3kHzk4uS0RHvHTTmKTzOgLc7Reeu//RHI9upkZk1gLix8rM2ba6ynEDdB6d3hB3/MqTja70uTpa5lhs+kmxDB/1eT9VO+sLsE5b1Mu4M5wdK1voS115cs1IwmgMA7eM9je7xtdu+FtqEvmDnzeLc/JtJekE0ug==
X-Gm-Message-State: AOJu0Yzq5qt/szKJcaW/3w0HU8xsp4fBQcYAY4Ai6cTbj2rzzLlrV/Do
	7oTxurxjEMV/bdLJmyAWTsH2d9tmwMS3+ozn3cGJB4IPbivf3pOL
X-Google-Smtp-Source: AGHT+IEiJ2roCAI40K2a3VrS8d+2SDADw8E/cXlaEZMQDwqlxjJ7wW9UFJ/Gb5WylySCIDRIqvZdnA==
X-Received: by 2002:a17:903:22c6:b0:1dc:fadb:4b1a with SMTP id y6-20020a17090322c600b001dcfadb4b1amr6868463plg.54.1709755549717;
        Wed, 06 Mar 2024 12:05:49 -0800 (PST)
Received: from mozart.vkv.me ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001dcfc88ccf6sm8869341plf.263.2024.03.06.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:05:49 -0800 (PST)
From: Calvin Owens <jcalvinowens@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Calvin Owens <jcalvinowens@gmail.com>,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Date: Wed,  6 Mar 2024 12:05:10 -0800
Message-ID: <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709676663.git.jcalvinowens@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If something like this is merged down the road, it can go in at leisure
once the module_alloc change is in: it's a one-way dependency.

Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
---
 arch/Kconfig                |  2 +-
 kernel/kprobes.c            | 22 ++++++++++++++++++++++
 kernel/trace/trace_kprobe.c | 11 +++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index cfc24ced16dd..e60ce984d095 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,8 +52,8 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
 	depends on HAVE_KPROBES
+	select MODULE_ALLOC
 	select KALLSYMS
 	select TASKS_RCU if PREEMPTION
 	help
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..194270e17d57 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 		str_has_prefix("__pfx_", symbuf);
 }
 
+#if IS_ENABLED(CONFIG_MODULES)
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
+#else
+static int check_kprobe_address_safe(struct kprobe *p)
+#endif
 {
 	int ret;
 
@@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
+#if IS_ENABLED(CONFIG_MODULES)
 	/* Check if 'p' is probing a module. */
 	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
@@ -1603,6 +1608,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			ret = -ENOENT;
 		}
 	}
+#endif
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -1614,7 +1621,9 @@ int register_kprobe(struct kprobe *p)
 {
 	int ret;
 	struct kprobe *old_p;
+#if IS_ENABLED(CONFIG_MODULES)
 	struct module *probed_mod;
+#endif
 	kprobe_opcode_t *addr;
 	bool on_func_entry;
 
@@ -1633,7 +1642,11 @@ int register_kprobe(struct kprobe *p)
 	p->nmissed = 0;
 	INIT_LIST_HEAD(&p->list);
 
+#if IS_ENABLED(CONFIG_MODULES)
 	ret = check_kprobe_address_safe(p, &probed_mod);
+#else
+	ret = check_kprobe_address_safe(p);
+#endif
 	if (ret)
 		return ret;
 
@@ -1676,8 +1689,10 @@ int register_kprobe(struct kprobe *p)
 out:
 	mutex_unlock(&kprobe_mutex);
 
+#if IS_ENABLED(CONFIG_MODULES)
 	if (probed_mod)
 		module_put(probed_mod);
+#endif
 
 	return ret;
 }
@@ -2482,6 +2497,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_MODULES)
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
@@ -2499,6 +2515,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
 {
 	kprobe_remove_area_blacklist(entry, entry + 1);
 }
+#endif
 
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
@@ -2564,6 +2581,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#if IS_ENABLED(CONFIG_MODULES)
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2665,6 +2683,7 @@ static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
 	.priority = 0
 };
+#endif /* IS_ENABLED(CONFIG_MODULES) */
 
 void kprobe_free_init_mem(void)
 {
@@ -2724,8 +2743,11 @@ static int __init init_kprobes(void)
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
+
+#if IS_ENABLED(CONFIG_MODULES)
 	if (!err)
 		err = register_module_notifier(&kprobe_module_nb);
+#endif
 
 	kprobes_initialized = (err == 0);
 	kprobe_sysctls_init();
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c4c6e0e0068b..dd4598f775b9 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -102,6 +102,7 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 	return kprobe_gone(&tk->rp.kp);
 }
 
+#if IS_ENABLED(CONFIG_MODULES)
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 						 struct module *mod)
 {
@@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#else
+static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
+{
+	return true;
+}
+#endif
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_MODULES)
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -704,6 +712,7 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
 	.priority = 1	/* Invoked after kprobe module callback */
 };
+#endif /* IS_ENABLED(CONFIG_MODULES) */
 
 static int count_symbols(void *data, unsigned long unused)
 {
@@ -1897,8 +1906,10 @@ static __init int init_kprobe_trace_early(void)
 	if (ret)
 		return ret;
 
+#if IS_ENABLED(CONFIG_MODULES)
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
+#endif
 
 	return 0;
 }
-- 
2.43.0


