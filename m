Return-Path: <linux-kernel+bounces-46633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02996844236
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822321F26B33
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ED284A3E;
	Wed, 31 Jan 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsJyhtC9"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1384A37;
	Wed, 31 Jan 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712620; cv=none; b=UKS+HOtZtFpKojUTE09X5UKqWQMb/eqdfkMnfrkvQsj8ZVDbV571Ew0XikyBqny3J21FYYL7uIN3JrNiMTkTSybsVd/r0mdyvk5ww/v6TtSOhXhRKc/nlgeccUgo7HdwqtTBywmJ2F/GV2Ba5Pa4AWrq7hNtBlMFCLonhW4xOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712620; c=relaxed/simple;
	bh=ZeThyH6Cpys9NnMjdPKX+tPptgscAKO5k2YHnbhZmao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abhj8WVVMmaVuQvryZVHjcc3wUndpTY82avkC9bHT8XCYI5UWF1uLm7R9yzvLc5dWcYRYOPQbWn8fwU/Qzv4c3hHWMa48XTCFfQH2onvq0mtyvk4oCQfLKK/hDohb6hP1I2YqAXKNgBsjneore9u2kSo+Q7XZ70yJOTi6Bj1W0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsJyhtC9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ae7681d03so2583584f8f.1;
        Wed, 31 Jan 2024 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712616; x=1707317416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBtYOBqzah2COc6Cv21eJlyQjax7AL2k8qugBY856Dk=;
        b=WsJyhtC9HvMMFTfTTA+HcR4ON3sK7p+x564Xkej2q6Ti9j+CeygmJCJ3mu6q3a+B4L
         BcPnvjubkGRxB9P/KHiRT+2aE5WmTgO27c3qGtqR73fWtVsxjKyskHScDOEVooAAAF70
         r7lhdoZQgI0PkEhSq25FJ5aVlxUJ0qgOWybKOfdDquAZ958H/VAi3Vk2g1iW+K/BxvLF
         iuhFWhs8GivxNXSicFhpXjRB6T/6foMtSthbuP2Sykj4q889JqtRP6hpZmuTsxNRnGM/
         U3WxzToPRZJAhvIEAaTNFjDCkti7k86p8WFXGwPaHTfufsd7BVudNVBoLZv3RO8zU/GV
         afsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712616; x=1707317416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBtYOBqzah2COc6Cv21eJlyQjax7AL2k8qugBY856Dk=;
        b=tY8qccZUm369KvLK24scyLFdngz8Ck6+OkLlmfbqIWS5pzsm9FD0MC8QsczYVsmHim
         kvoCAZyJFUl0IwdXEEAXlPBy+AD4Eh/Nb/gKlzx4LtLo1PVlA3iEsMB31wx68hNronAp
         /eH5bsrWdHKkP1DW//0vzAVB2FoABcjLTw5UsFMZpZNyd8/KdaAf606yws4hYhxtSSsm
         Iw5ZoQBVb6niIF31nCoSYUvkTfoIccHK0XxV4S7p6HS9n5otK7LIQ2DV5LqzJeuT9sa5
         IPhrZCND2jRJnwMOrObqzODX3zTZEfcMLzzmnDG7zXoIX63OMSFWxMxp0IbuCw+q32p/
         UGwg==
X-Gm-Message-State: AOJu0YzIh0CDFITAkrFy1yTcqsciWszO2lKbnk9xf/8SKg2yqS6mdQS3
	8nwwGq/8ZiF2pYMQC9T77I6ddZXfQDU2Ei+2clcnPIx4joC84AZ3
X-Google-Smtp-Source: AGHT+IFzHyII0E803YFcr2LWchdZp3gu+YQKrnRRDpAoCqkSNmvsjur8XaGr+luL1UtHCiX8h+kWWA==
X-Received: by 2002:a05:6000:12c2:b0:33a:ff90:68eb with SMTP id l2-20020a05600012c200b0033aff9068ebmr1309832wrx.26.1706712616480;
        Wed, 31 Jan 2024 06:50:16 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4046000000b0033b0d049c71sm419265wrp.54.2024.01.31.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:16 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	corbet@lwn.net
Cc: mmaas@google.com,
	hboehm@google.com,
	striker@us.ibm.com,
	charlie@rivosinc.com,
	rehn@rivosinc.com,
	rdunlap@infradead.org,
	sorear@fastmail.com,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v4 4/4] membarrier: riscv: Provide core serializing command
Date: Wed, 31 Jan 2024 15:49:36 +0100
Message-Id: <20240131144936.29190-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131144936.29190-1-parri.andrea@gmail.com>
References: <20240131144936.29190-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V uses xRET instructions on return from interrupt and to go back
to user-space; the xRET instruction is not core serializing.

Use FENCE.I for providing core serialization as follows:

 - by calling sync_core_before_usermode() on return from interrupt (cf.
   ipi_sync_core()),

 - via switch_mm() and sync_core_before_usermode() (respectively, for
   uthread->uthread and kthread->uthread transitions) before returning
   to user-space.

On RISC-V, the serialization in switch_mm() is activated by resetting
the icache_stale_mask of the mm at prepare_sync_core_cmd().

Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 .../membarrier-sync-core/arch-support.txt     | 18 +++++++++++-
 MAINTAINERS                                   |  1 +
 arch/riscv/Kconfig                            |  3 ++
 arch/riscv/include/asm/membarrier.h           | 19 ++++++++++++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++++++++++
 kernel/sched/core.c                           |  4 +++
 kernel/sched/membarrier.c                     |  4 +++
 7 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/sync_core.h

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index d96b778b87ed8..7425d2b994a39 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -10,6 +10,22 @@
 # Rely on implicit context synchronization as a result of exception return
 # when returning from IPI handler, and when returning to user-space.
 #
+# * riscv
+#
+# riscv uses xRET as return from interrupt and to return to user-space.
+#
+# Given that xRET is not core serializing, we rely on FENCE.I for providing
+# core serialization:
+#
+#  - by calling sync_core_before_usermode() on return from interrupt (cf.
+#    ipi_sync_core()),
+#
+#  - via switch_mm() and sync_core_before_usermode() (respectively, for
+#    uthread->uthread and kthread->uthread transitions) before returning
+#    to user-space.
+#
+#  The serialization in switch_mm() is activated by prepare_sync_core_cmd().
+#
 # * x86
 #
 # x86-32 uses IRET as return from interrupt, which takes care of the IPI.
@@ -43,7 +59,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/MAINTAINERS b/MAINTAINERS
index 628f3762d97cd..8373ce3e4350a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14042,6 +14042,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/scheduler/membarrier.rst
 F:	arch/*/include/asm/membarrier.h
+F:	arch/*/include/asm/sync_core.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 087abf9e51c69..70836381b9482 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,14 +28,17 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
+	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/riscv/include/asm/membarrier.h b/arch/riscv/include/asm/membarrier.h
index 6c016ebb5020a..47b240d0d596a 100644
--- a/arch/riscv/include/asm/membarrier.h
+++ b/arch/riscv/include/asm/membarrier.h
@@ -22,6 +22,25 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 	/*
 	 * The membarrier system call requires a full memory barrier
 	 * after storing to rq->curr, before going back to user-space.
+	 *
+	 * This barrier is also needed for the SYNC_CORE command when
+	 * switching between processes; in particular, on a transition
+	 * from a thread belonging to another mm to a thread belonging
+	 * to the mm for which a membarrier SYNC_CORE is done on CPU0:
+	 *
+	 *   - [CPU0] sets all bits in the mm icache_stale_mask (in
+	 *     prepare_sync_core_cmd());
+	 *
+	 *   - [CPU1] stores to rq->curr (by the scheduler);
+	 *
+	 *   - [CPU0] loads rq->curr within membarrier and observes
+	 *     cpu_rq(1)->curr->mm != mm, so the IPI is skipped on
+	 *     CPU1; this means membarrier relies on switch_mm() to
+	 *     issue the sync-core;
+	 *
+	 *   - [CPU1] switch_mm() loads icache_stale_mask; if the bit
+	 *     is zero, switch_mm() may incorrectly skip the sync-core.
+	 *
 	 * Matches a full barrier in the proximity of the membarrier
 	 * system call entry.
 	 */
diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
new file mode 100644
index 0000000000000..9153016da8f14
--- /dev/null
+++ b/arch/riscv/include/asm/sync_core.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_SYNC_CORE_H
+#define _ASM_RISCV_SYNC_CORE_H
+
+/*
+ * RISC-V implements return to user-space through an xRET instruction,
+ * which is not core serializing.
+ */
+static inline void sync_core_before_usermode(void)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
+
+#ifdef CONFIG_SMP
+/*
+ * Ensure the next switch_mm() on every CPU issues a core serializing
+ * instruction for the given @mm.
+ */
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+	cpumask_setall(&mm->context.icache_stale_mask);
+}
+#else
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+}
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_SYNC_CORE_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a972628e77567..e4a87bcf28d40 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6721,6 +6721,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 *
 		 * The barrier matches a full barrier in the proximity of
 		 * the membarrier system call entry.
+		 *
+		 * On RISC-V, this barrier pairing is also needed for the
+		 * SYNC_CORE command when switching between processes, cf.
+		 * the inline comments in membarrier_arch_switch_mm().
 		 */
 		++*switch_count;
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 6d1f31b3a967b..703e8d80a576d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -342,6 +342,10 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	/*
 	 * Matches memory barriers after rq->curr modification in
 	 * scheduler.
+	 *
+	 * On RISC-V, this barrier pairing is also needed for the
+	 * SYNC_CORE command when switching between processes, cf.
+	 * the inline comments in membarrier_arch_switch_mm().
 	 */
 	smp_mb();	/* system call entry is not a mb. */
 
-- 
2.34.1


