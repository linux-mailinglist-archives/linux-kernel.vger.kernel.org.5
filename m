Return-Path: <linux-kernel+bounces-111333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0780886ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38251C218FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DF3FB87;
	Fri, 22 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1gaTx8W5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWxVU9Ai"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF103E49C;
	Fri, 22 Mar 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105104; cv=none; b=g7dlYbn4vtiaDqgVqVnapm83GBz8zRwdrKxA+wxSUhRODysp3gSxA0QBVuvs4nGDFsxMensGoW/2bCmaw6wuhPXq7WcGKEAzHTXp6Af1cMWkwogjOgbu1IXdoU5uyzPNxWM+rtMwrcvwsaARa3xqPO3iNs7VnV9TS9qCu7vBpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105104; c=relaxed/simple;
	bh=ZYiFn8k5HAsh7bCNbYcd6mIHSct42QlY/3NWX7DDd9s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i/u5vXvB1Py8Zqibj9ioqhfYOmMjcHDr4AQFtPnItnQrTugNcUGNyiNkc9gs08cVQOEOhZGIy4Q4V7IL2EljtTHdfhVNK5rJkz/A4qTlT+atACC8t5xM2iNTNrb81R5Dh9Q6sWvAevsdgUDP+9Yq8sEdOhjx0IIC1lL1rioQa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1gaTx8W5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWxVU9Ai; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:58:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/Ob1rCtnNJBYYrC2ve+lrueUgiBu72sPQjKt7MpWY=;
	b=1gaTx8W5dCAVJDPZ/t4eloANEjIiaWkRgMU5M8gABSGpRN/DsIcQfAzXbbjjtxaEYZ3JRT
	yxOcMbBWgt77JfbJFSVhcu1m7l5wli5JnmbO38AsSqlhmikoCZ4CVGiMWdQ59rO+mSwyb7
	cWa6zz4yaiYpWyhuBk7lSRkR/Ghs//zqiXLNe1jk/xH48BLY+cZ0my1GtLlyKcfg2WKh4a
	b3waRlFhGD2bZrI4KqEH917RJHFLKqY5UXyleRcQqoe2BHqIkNfJZSHxjXUONbBNFEwr5o
	FaBuNllmLKNSOyKE7dA8FeZlDrjJt9geZud2vooZRoTifiKVoNOYXVq0qB+ocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9D/Ob1rCtnNJBYYrC2ve+lrueUgiBu72sPQjKt7MpWY=;
	b=jWxVU9Aid0hmP4wT5wBue/+jINgSPBqEfDUIQj0+yN0I7drfMh3gA7GRkO8Xt9zozU9hR7
	i6cQMLm1CYPSHoAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label,module: Don't alloc static_key_mod for
 __ro_after_init keys
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240313180106.2917308-2-vschneid@redhat.com>
References: <20240313180106.2917308-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110509398.10875.5547526128005717476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     91a1d97ef482c1e4c9d4c1c656a53b0f6b16d0ed
Gitweb:        https://git.kernel.org/tip/91a1d97ef482c1e4c9d4c1c656a53b0f6b16d0ed
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 13 Mar 2024 19:01:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:18:16 +01:00

jump_label,module: Don't alloc static_key_mod for __ro_after_init keys

When a static_key is marked ro_after_init, its state will never change
(after init), therefore jump_label_update() will never need to iterate
the entries, and thus module load won't actually need to track this --
avoiding the static_key::next write.

Therefore, mark these keys such that jump_label_add_module() might
recognise them and avoid the modification.

Use the special state: 'static_key_linked(key) && !static_key_mod(key)'
to denote such keys.

jump_label_add_module() does not exist under CONFIG_JUMP_LABEL=n, so the
newly-introduced jump_label_init_ro() can be defined as a nop for that
configuration.

[ mingo: Renamed jump_label_ro() to jump_label_init_ro() ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240313180106.2917308-2-vschneid@redhat.com
---
 include/asm-generic/sections.h |  5 +++-
 include/linux/jump_label.h     |  3 ++-
 init/main.c                    |  1 +-
 kernel/jump_label.c            | 53 +++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index db13bb6..c768de6 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -180,6 +180,11 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+static inline bool is_kernel_ro_after_init(unsigned long addr)
+{
+	return addr >= (unsigned long)__start_ro_after_init &&
+	       addr < (unsigned long)__end_ro_after_init;
+}
 /**
  * is_kernel_inittext - checks if the pointer address is located in the
  *                      .init.text section
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f0a949b..f5a2727 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -216,6 +216,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
+extern void jump_label_init_ro(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -265,6 +266,8 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
+static __always_inline void jump_label_init_ro(void) { }
+
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	if (unlikely_notrace(static_key_count(key) > 0))
diff --git a/init/main.c b/init/main.c
index 2ca5247..6c3f251 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1408,6 +1408,7 @@ static void mark_readonly(void)
 		 * insecure pages which are W+X.
 		 */
 		flush_module_init_free_work();
+		jump_label_init_ro();
 		mark_rodata_ro();
 		debug_checkwx();
 		rodata_test();
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822b..3218fa5 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -530,6 +530,45 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
+static inline bool static_key_sealed(struct static_key *key)
+{
+	return (key->type & JUMP_TYPE_LINKED) && !(key->type & ~JUMP_TYPE_MASK);
+}
+
+static inline void static_key_seal(struct static_key *key)
+{
+	unsigned long type = key->type & JUMP_TYPE_TRUE;
+	key->type = JUMP_TYPE_LINKED | type;
+}
+
+void jump_label_init_ro(void)
+{
+	struct jump_entry *iter_start = __start___jump_table;
+	struct jump_entry *iter_stop = __stop___jump_table;
+	struct jump_entry *iter;
+
+	if (WARN_ON_ONCE(!static_key_initialized))
+		return;
+
+	cpus_read_lock();
+	jump_label_lock();
+
+	for (iter = iter_start; iter < iter_stop; iter++) {
+		struct static_key *iterk = jump_entry_key(iter);
+
+		if (!is_kernel_ro_after_init((unsigned long)iterk))
+			continue;
+
+		if (static_key_sealed(iterk))
+			continue;
+
+		static_key_seal(iterk);
+	}
+
+	jump_label_unlock();
+	cpus_read_unlock();
+}
+
 #ifdef CONFIG_MODULES
 
 enum jump_label_type jump_label_init_type(struct jump_entry *entry)
@@ -650,6 +689,15 @@ static int jump_label_add_module(struct module *mod)
 			static_key_set_entries(key, iter);
 			continue;
 		}
+
+		/*
+		 * If the key was sealed at init, then there's no need to keep a
+		 * reference to its module entries - just patch them now and be
+		 * done with it.
+		 */
+		if (static_key_sealed(key))
+			goto do_poke;
+
 		jlm = kzalloc(sizeof(struct static_key_mod), GFP_KERNEL);
 		if (!jlm)
 			return -ENOMEM;
@@ -675,6 +723,7 @@ static int jump_label_add_module(struct module *mod)
 		static_key_set_linked(key);
 
 		/* Only update if we've changed from our initial state */
+do_poke:
 		if (jump_label_type(iter) != jump_label_init_type(iter))
 			__jump_label_update(key, iter, iter_stop, true);
 	}
@@ -699,6 +748,10 @@ static void jump_label_del_module(struct module *mod)
 		if (within_module((unsigned long)key, mod))
 			continue;
 
+		/* No @jlm allocated because key was sealed at init. */
+		if (static_key_sealed(key))
+			continue;
+
 		/* No memory during module load */
 		if (WARN_ON(!static_key_linked(key)))
 			continue;

