Return-Path: <linux-kernel+bounces-22383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E46829CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9B1C21465
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F44C614;
	Wed, 10 Jan 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MteIaRGu"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FD4BAA0;
	Wed, 10 Jan 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28fb463a28so426528666b.3;
        Wed, 10 Jan 2024 06:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898564; x=1705503364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C63BDPk/7WHx0usrsZtg8+fUN103VfNMkfDwnaCswfU=;
        b=MteIaRGu5giZh8Saaib2gtY6NDuPusXuxzw3+mJLbVVhKeV6VMOTgwXuo4WNjgPT9+
         ZgoGURRqUXcnTwdUjbq2wdkwpk3UZ6AhDtlxgD3UNTvfQBBCcEguF09qnF+OuKh6jkZm
         URV6kyPBviqje15BlSoYXT0XAjDrmQagClFBnoZseqoH1TiL9yUMw9nOrjiEKMoER3kJ
         GO+imJpv6GxEoM8rsT6MiMKHmyaBmxQunqFe1TEJyt5goMCggpaElmkMcBnhbI8OhrsX
         9a9ZePxZDHLU8uQeRnEXHUv7520dMO2bj5y5Hcb1NFF2BfQSFVB+QvPIXV+T/CZ5SXNU
         0ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898564; x=1705503364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C63BDPk/7WHx0usrsZtg8+fUN103VfNMkfDwnaCswfU=;
        b=K5T6YaFGoJ3BdCt08wGsXztu70S8FAywA3byJ/FAQL5E6AuXx4Axpeyy1oZG8NLIng
         a58b1RrWSdTVB1D2jUCPqWmFgrf07kauGCFX+BxVU1HNSt/uuJ5a/Kvreff8gqcqi1dI
         XRz5wuMYphVeFiE1xq3xPnh6HmWX/RM8z9IBN5k/DqxKgU4jDwgQwmAXroQ9MqW4IdDb
         TKnVtx1xob11YIV1isM2VN9tcc6LosAHDVKFtAhUhBQNW3IsfTW81byGNr/ukJNDx9zW
         3iFss/2Pwv7nT8npmWlw83H3G4sExnSsj+rRzpfYrlhVkimmI15qrhWnBNz0N3TqapST
         noVA==
X-Gm-Message-State: AOJu0Yxig3WsMqCzthkt7e28dMQIGX1QGHTap78d6jAJxs7Fxy/HFiXB
	JQbIDwFvyeMUXgd+n8d7bIQ=
X-Google-Smtp-Source: AGHT+IEfQ0aiJnEbthSrMkSjQB/zdjUuuUCY/fvSQUuGh/Yx6TJvuSg9tAQCv4MEbcccXdr1VJhfyA==
X-Received: by 2002:a17:906:189:b0:a28:da0f:b7b4 with SMTP id 9-20020a170906018900b00a28da0fb7b4mr691778ejb.13.1704898564560;
        Wed, 10 Jan 2024 06:56:04 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id bm3-20020a170906c04300b00a2a4efe7d3dsm2161032ejb.79.2024.01.10.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:56:04 -0800 (PST)
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
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 1/4] membarrier: riscv: Add full memory barrier in switch_mm()
Date: Wed, 10 Jan 2024 15:55:30 +0100
Message-Id: <20240110145533.60234-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110145533.60234-1-parri.andrea@gmail.com>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The membarrier system call requires a full memory barrier after storing
to rq->curr, before going back to user-space.  The barrier is only
needed when switching between processes: the barrier is implied by
mmdrop() when switching from kernel to userspace, and it's not needed
when switching from userspace to kernel.

Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
architecture, to insert the required barrier.

Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 MAINTAINERS                         |  2 +-
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/membarrier.h | 31 +++++++++++++++++++++++++++++
 arch/riscv/mm/context.c             |  2 ++
 kernel/sched/core.c                 |  5 +++--
 5 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/membarrier.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e01..0f8cec504b2ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13815,7 +13815,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	arch/powerpc/include/asm/membarrier.h
+F:	arch/*/include/asm/membarrier.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index cd4c9a204d08c..33d9ea5fa392f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
diff --git a/arch/riscv/include/asm/membarrier.h b/arch/riscv/include/asm/membarrier.h
new file mode 100644
index 0000000000000..6c016ebb5020a
--- /dev/null
+++ b/arch/riscv/include/asm/membarrier.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_MEMBARRIER_H
+#define _ASM_RISCV_MEMBARRIER_H
+
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+					     struct mm_struct *next,
+					     struct task_struct *tsk)
+{
+	/*
+	 * Only need the full barrier when switching between processes.
+	 * Barrier when switching from kernel to userspace is not
+	 * required here, given that it is implied by mmdrop(). Barrier
+	 * when switching from userspace to kernel is not needed after
+	 * store to rq->curr.
+	 */
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    likely(!(atomic_read(&next->membarrier_state) &
+		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
+		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) || !prev))
+		return;
+
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * after storing to rq->curr, before going back to user-space.
+	 * Matches a full barrier in the proximity of the membarrier
+	 * system call entry.
+	 */
+	smp_mb();
+}
+
+#endif /* _ASM_RISCV_MEMBARRIER_H */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de61342..ba8eb3944687c 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -323,6 +323,8 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	if (unlikely(prev == next))
 		return;
 
+	membarrier_arch_switch_mm(prev, next, task);
+
 	/*
 	 * Mark the current MM context as inactive, and the next as
 	 * active.  This is at least used by the icache flushing
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e8..711dc753f7216 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6670,8 +6670,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 *
 		 * Here are the schemes providing that barrier on the
 		 * various architectures:
-		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
-		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
+		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC,
+		 *   RISC-V.  switch_mm() relies on membarrier_arch_switch_mm()
+		 *   on PowerPC and on RISC-V.
 		 * - finish_lock_switch() for weakly-ordered
 		 *   architectures where spin_unlock is a full barrier,
 		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
-- 
2.34.1


