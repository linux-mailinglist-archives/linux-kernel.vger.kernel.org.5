Return-Path: <linux-kernel+bounces-122539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35888F927
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C01D1C22D54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8F54908;
	Thu, 28 Mar 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmXBrK4l"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A30548FC;
	Thu, 28 Mar 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612292; cv=none; b=EmWRRoHODtu6zgkFd8NOfQ/r0VB3nlznIycNEDo6BOCJfvgR9qwc6HFAHy8NVTMBF3KgsAy/VvyXTw7yg+uRKODE22sVb6mxYk/NjOmgHS2Yl9ewki6Nb1jLs6OWVKxTMXfsdMIf6VRh7UR/QRx1v4vNfsgTK6CcnvvDEpYYaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612292; c=relaxed/simple;
	bh=7bkBKLnD77zEWrwezIeGk/jY1nL8DIDPDOCksC6gLzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2AdACTUprAcH+DwRFxXP/1c2npHUGqhQ51SWB74KxHj2VD6OYt7+MUDQywASfJ7UXT7TgOlkBpu/mAGV6xKfmqOvUzp8W63LyyYUqhVH2IbhQuVYiNLxot7QZIJveI572MolIE3y8aLcBS/kkbm+McpSg7+z8Bzrv/x2goiiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmXBrK4l; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e152c757a5so404467a12.2;
        Thu, 28 Mar 2024 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612289; x=1712217089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Fu9XbKPcpXhQXu1sKcZUeWcfqfg6wDFC9Zk5mwxGOY=;
        b=ZmXBrK4lB5+xwebUa8/R5c0/kIvTKbmfc/Rpd+KPtYdD2PAqswruXa+FlnhwWFxAE3
         D91qt6RwsWFasVzdjxo6Smd1kGUIAKB71cbJVc92/SHpT5iggE62BfU/NGTcLhJbm3nO
         CdB2W8EBW6rvnjVgHElKDhiwr9KgzUu/HTq9ecckzgCHQ5AFtYoeKzepuLLDc8cJXfC5
         za66ni3WNLOyjNTWCyC45ePsHZovqqO53rugV9J9F1asb7KOEXYZC1drmZ3MmBswZRTu
         +sgVAlGSAp8FNjUbGeqxQvlNIEiUVyk+GhJ494QflZDweNYds2GtlUIy7Yj8rRQqd15B
         PJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612289; x=1712217089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fu9XbKPcpXhQXu1sKcZUeWcfqfg6wDFC9Zk5mwxGOY=;
        b=sfU3Q5vhWuH+rdBbW2gVCRoTtzn6soXeCfY0SND9fXq+rdIMlqrPw9geeXxIX6zlqC
         bw2HSuZrg9y1BfRZQrvfLs4qcC5DvHkmN4IJzmVtIEJhoIbLHcxXTCKj9DCiBfHojLNA
         7eCLYXwvrW9rmNKVef+Pkd+Wx9tLhF1GK/9rkkQrqv8jpa5YokTuieTXMoCpLI5f0QRu
         KKl+QA/qriKlTPOHTXWdLQFpND9ta5fAsyeuhkp6sfMl15VSx3yOvu5j0WGvjrxci8gN
         DOhF0VNLpiypZYY44wZND2pkw8KePVSmqnI6H4qp4ZMlmW8rP7SEp9n72cIXOv5rYU+E
         63uQ==
X-Gm-Message-State: AOJu0Yy9yEtYrGWHJPehzhC1jweS+LMMgAvaFl3cpXIShirzN9RE1Z/0
	+pEPruLilTw1QgA8ey/cHq/YDGgRakYdYjAbMkdLLBLR/lOgsyLQ22PMYcZ4
X-Google-Smtp-Source: AGHT+IFHruU5tg3ltPttVZMCiIjCktbE25klSko7+N6nSsI7NgeSJznZIu5AsRBpBKsVYWkexqhY8w==
X-Received: by 2002:a05:6a20:4c1e:b0:1a3:dfd2:949c with SMTP id fm30-20020a056a204c1e00b001a3dfd2949cmr1882329pzb.54.1711612289629;
        Thu, 28 Mar 2024 00:51:29 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001e0b863b815sm865604plf.96.2024.03.28.00.51.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:29 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nadav Amit <namit@vmware.com>,
	Breno Leitao <leitao@debian.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 09/10] x86/rcu: Add rcu_preempt_count
Date: Thu, 28 Mar 2024 15:53:17 +0800
Message-Id: <20240328075318.83039-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Implement PCPU_RCU_PREEMPT_COUNT for x86.
Mainly copied from asm/preempt.h

Make rcu_read_[un]lock() inlined for rcu-preempt.
Make rcu_read_lock() only one instruction.
Make rcu_read_unlock() only two instructions in the fast path.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/current.h     |   3 +
 arch/x86/include/asm/rcu_preempt.h | 107 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c       |   7 +-
 4 files changed, 115 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/rcu_preempt.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 78050d5d7fac..7eb17c12f7b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -257,6 +257,7 @@ config X86
 	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
 	select HAVE_PAGE_SIZE_4KB
+	select HAVE_PCPU_RCU_PREEMPT_COUNT
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec3..dcc2ef784120 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -24,6 +24,9 @@ struct pcpu_hot {
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
 			u16			softirq_pending;
+#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
+			int			rcu_preempt_count;
+#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
 #ifdef CONFIG_X86_64
 			bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rcu_preempt.h
new file mode 100644
index 000000000000..cb25ebe038a5
--- /dev/null
+++ b/arch/x86/include/asm/rcu_preempt.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RCU_PREEMPT_H
+#define __ASM_RCU_PREEMPT_H
+
+#include <asm/rmwcc.h>
+#include <asm/percpu.h>
+#include <asm/current.h>
+
+#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
+
+/* We use the MSB mostly because its available */
+#define RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED	0x80000000
+
+/*
+ * We use the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit as an inverted
+ * current->rcu_read_unlock_special.s such that a decrement hitting 0
+ * means we can and should call rcu_read_unlock_special().
+ */
+#define RCU_PREEMPT_INIT	(0 + RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED)
+
+/*
+ * We mask the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit so as not to
+ * confuse all current users that think a non-zero value indicates we
+ * are in a critical section.
+ */
+static inline int pcpu_rcu_preempt_count(void)
+{
+	return raw_cpu_read_4(pcpu_hot.rcu_preempt_count) & ~RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED;
+}
+
+static inline void pcpu_rcu_preempt_count_set(int count)
+{
+	int old, new;
+
+	old = raw_cpu_read_4(pcpu_hot.rcu_preempt_count);
+	do {
+		new = (old & RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED) |
+			(count & ~RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
+	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.rcu_preempt_count, &old, new));
+}
+
+/*
+ * We fold the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit into the RCU
+ * preempt count such that rcu_read_unlock() can decrement and test for
+ * the need of unlock-special handling with a single instruction.
+ *
+ * We invert the actual bit, so that when the decrement hits 0 we know
+ * we both reach a quiescent state (no rcu preempt count) and need to
+ * handle unlock-special (the bit is cleared), normally to report the
+ * quiescent state immediately.
+ */
+
+static inline void pcpu_rcu_preempt_special_set(void)
+{
+	raw_cpu_and_4(pcpu_hot.rcu_preempt_count, ~RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
+}
+
+static inline void pcpu_rcu_preempt_special_clear(void)
+{
+	raw_cpu_or_4(pcpu_hot.rcu_preempt_count, RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
+}
+
+static inline bool pcpu_rcu_preempt_special_test(void)
+{
+	return !(raw_cpu_read_4(pcpu_hot.rcu_preempt_count) & RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
+}
+
+static inline void pcpu_rcu_preempt_switch(int count, bool special)
+{
+	if (likely(!special))
+		raw_cpu_write(pcpu_hot.rcu_preempt_count, count | RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
+	else
+		raw_cpu_write(pcpu_hot.rcu_preempt_count, count);
+}
+
+/*
+ * The various rcu_preempt_count add/sub methods
+ */
+
+static __always_inline void pcpu_rcu_preempt_count_add(int val)
+{
+	raw_cpu_add_4(pcpu_hot.rcu_preempt_count, val);
+}
+
+static __always_inline void pcpu_rcu_preempt_count_sub(int val)
+{
+	raw_cpu_add_4(pcpu_hot.rcu_preempt_count, -val);
+}
+
+/*
+ * Because we keep RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED set when we do
+ * _not_ need to handle unlock-special for a fast-path decrement.
+ */
+static __always_inline bool pcpu_rcu_preempt_count_dec_and_test(void)
+{
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.rcu_preempt_count), e,
+			       __percpu_arg([var]));
+}
+
+#define pcpu_rcu_read_unlock_special()						\
+do {										\
+	rcu_read_unlock_special();						\
+} while (0)
+
+#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
+
+#endif /* __ASM_RCU_PREEMPT_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e9ce56..0b204a649442 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1992,9 +1992,10 @@ static __init int setup_clearcpuid(char *arg)
 __setup("clearcpuid=", setup_clearcpuid);
 
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
-	.current_task	= &init_task,
-	.preempt_count	= INIT_PREEMPT_COUNT,
-	.top_of_stack	= TOP_OF_INIT_STACK,
+	.current_task		= &init_task,
+	.preempt_count		= INIT_PREEMPT_COUNT,
+	.top_of_stack		= TOP_OF_INIT_STACK,
+	.rcu_preempt_count	= RCU_PREEMPT_INIT,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
-- 
2.19.1.6.gb485710b


