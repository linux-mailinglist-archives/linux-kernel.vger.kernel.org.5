Return-Path: <linux-kernel+bounces-134286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA16389AFED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C5E1F22CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58638F87;
	Sun,  7 Apr 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8N5sEYz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BF38DEC;
	Sun,  7 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480661; cv=none; b=FNuo6gIRX/c9zH7morNLEIA2PwOCt+AkL++PjdpPd7hp+WR5kQcS8TpDec7XjQlcPuUgdRzqDTvz4imt4JvxAYUpLnLdkZHnva3lUPsik8Nh3u0qfOFwaLixBxiRLMwu8t9enFb2Br3S70iQZAKXWVYkyau2owFFyZgecxbqM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480661; c=relaxed/simple;
	bh=biS7KzzHTKcOQAMJum93/nBTbQjerhk67V4BVUndbxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFvkIINNQBRGw1CmZS6wMCn7zJzicxsehnVPY0BNNQcNSpioW+qZx6OuHxgBZTFrluvMgUYy/nhDnUBDokxEN09s8YdCFJBHFctl+p/2xdqUGl5113oLidwUIdVTu/Z5rhKz2qlP5N/rDgBz418krlosv7mclnaWc6DiUdxzuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8N5sEYz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so1752574b3a.0;
        Sun, 07 Apr 2024 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480659; x=1713085459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pFdud31CO30bbz/KPNSHwu6wK19wUtd+HcNwJYEJfY=;
        b=U8N5sEYztOMLwG/sg0hjXHkBMQbgbp9eOeMEK2mkl7XE3EDtQObQ1afeIZ5kBv9vME
         3BfNA+oUm8ptdHbZcdPYlHdDPBmIZobkRsjKwX/xhphkW7sg0O65kI7aExLBZbGL0aRR
         EQCSmaqnUpIVQ1UGFTHWdQydM6IiVBAHFUazkMXxKrV2jAJMAzrUNpnL+uxBnboCaQhc
         HXiAVGOVfS4i7hycABprt5mgT91MlW5cfrVZhj9DOe81MmlbW0WeHHWU/bMzZWspYCHO
         SNEQU9jibNay/CrVXdF8i1zsRs5H0dLh6AASuadR4roLiSO4exZWDsTTKdATyOLEJbKR
         Av0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480659; x=1713085459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pFdud31CO30bbz/KPNSHwu6wK19wUtd+HcNwJYEJfY=;
        b=KIFOF9iMiXd7TdPgRxWlOpZcU79uudNDa6SQDGbjKsGNJ75gXtF70lp9Amzfj8lMoU
         5VgJ+Jk6WcjQFYexQV2B5C6ur74jbX7GLyFZNrRGILgRZlGDOUJAIDIAq/nX7wnVMu4u
         bkDatfYXUSip+Rabl1YcxgnPBS2mp7gBt88ttv2cXfHBesB+eW4o+b8NRFTyZBIa2p6v
         iRHG0dhqgXsGMPNtpbbFaSX84dybUlg9yx1JHrhN1DSoRpQqfLzoVKq5YfzaB1OXvX/F
         R9CSIIzquOl/2LS+PsxEfqGaLRFKWy0t5mSRyzFbAbQt4qNoR+/0oTd4kDIQHvBZ3QLt
         t7Xg==
X-Gm-Message-State: AOJu0YxPbsQ3oncf7vL2b/Id46mp4CC9quLdHRUSn6Fo0B4hFTxtdrPT
	UqN67OPq/j7wdh9QXV/sAcCzqbpy7tvpjLF1Pp3cOYg+fZnt8svrGhRzImRB
X-Google-Smtp-Source: AGHT+IEaKJcXHWyEbaXHBNXfVOIsKNaj3lY8ob579KruAgIbKEgl/YO0KV/ToaFfMleSxyGz42XHwA==
X-Received: by 2002:a05:6a21:329b:b0:1a7:1cb:3e20 with SMTP id yt27-20020a056a21329b00b001a701cb3e20mr7113512pzb.54.1712480659129;
        Sun, 07 Apr 2024 02:04:19 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id r6-20020aa78446000000b006eb0027f2b8sm4322191pfn.9.2024.04.07.02.04.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:04:18 -0700 (PDT)
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
	Breno Leitao <leitao@debian.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH V2 10/11] x86/rcu: Add rcu_preempt_count
Date: Sun,  7 Apr 2024 17:05:57 +0800
Message-Id: <20240407090558.3395-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
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
 arch/x86/kernel/cpu/common.c       |   4 ++
 4 files changed, 115 insertions(+)
 create mode 100644 arch/x86/include/asm/rcu_preempt.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4fff6ed46e90..e805cac3763d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -256,6 +256,7 @@ config X86
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
index 5c1e6d6be267..918b1f5cb75d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1995,6 +1995,10 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
 	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
+
+#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
+	.rcu_preempt_count	= RCU_PREEMPT_INIT,
+#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
-- 
2.19.1.6.gb485710b


