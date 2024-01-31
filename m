Return-Path: <linux-kernel+bounces-46629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AE844230
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3251C26CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0985C66;
	Wed, 31 Jan 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNXKeecO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1984A41;
	Wed, 31 Jan 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712613; cv=none; b=YQgSct1hEkt24jihIp3oHFrxkz9M+/4r0zFpNceTpFV3Mc0Ba1SSl88UTLv7cMO43FWcy5162mtTL4Tu/8kwAU26kEBlf+mk7+Go7skX1ByVo8qZcGQYieaF+yzdBOQW2Vs3j1ZL0Izehq7RDEcUx+wCTLcy0xv9ysNKpXCxHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712613; c=relaxed/simple;
	bh=oiEdbYcv21i8TXa6FD7+XV83dt86UhYBkEjjIyAgpos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOtOaMSuT9LrcP2mJ0AatPg/JH4gG8igbLmIGqfB3Jj5LJDJ2ZFm2r/owKMXXIAUTbptMrhM8hMpabLMfUqltVyPTpb5gwrUsxFdNMUYQCCBoi3U7Sr+zvjhHPm+3TWuR6GafANBCRAjVDXM5xlqxQgj3ndCKBroATsCh/+oNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNXKeecO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3394b892691so569132f8f.1;
        Wed, 31 Jan 2024 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712610; x=1707317410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVYIfgnNZXAnAGrFV+qVvJtPQ32MBOSOxj+SNVTy3v0=;
        b=kNXKeecOvvI8raZvr7duvEG0V9NJ1nDWdU70wVyMw4JtrjjrK1Sxz0LzutiUg6nxgh
         1JGfHAKPnU4W9PYQV7GfKp5h5Qd66lcdN83NN7SlN78GifKcFIOoh1lfhGbDPZMi6z54
         aCqV9b3BsG8m4pCqxEKrMg3i0whgMITilXcaoVTaWU3ORT7EsQmXoRez6TyXOlY8b4k3
         88+yVpJWtHB/ZD+yL2sozegibB0IVXlanQhfIvLBE7IGcgqu+Y5NuPWdcSLFu8XHhRw7
         e1E7jpKNYbGa5Z0k06oblyiRT5g3A0zHhWmImzVf3CsHRx9nBKR9xrNu1e8gkWdCUSN4
         kbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712610; x=1707317410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVYIfgnNZXAnAGrFV+qVvJtPQ32MBOSOxj+SNVTy3v0=;
        b=aXfnCf9o5EG+BtNdpRj64myjIwjGB5UiUVOGsmyCE9wIMVdWjHup+8ex6Eyqfg2eI9
         QMbqHlefx45jL4dpxqxCwwHOug3FSc+uXEHhwJCwbQyS81QulV5tvMRPC9683Q0ccRAT
         dZop0GrMWs0QDDnpuPw1qB5Xea2z90Op31e1DNTBCW1mtVMZvIWBAF4Gcr+Zfp+n/SJA
         H6bcPx1CDgkOZeCI2xqSvChVyWpz2PAhthtuOCJV26ulyAg4Izva8wQT++908+V2/y2g
         T0MnDop3XDxyAGOLpmCyST+XDl+1dOM+twEBXd6truHC5q4GWBeznQl5voDMTKGz0RNT
         CPKw==
X-Gm-Message-State: AOJu0YyXLd4XXBE5u4AR9yv6mdIsKQ8LDahq45G1TmRCsUD+AJ/K7LmO
	O9iHBveQJP1HYV6VvK2TZ5p1Yh9QtyD4S+zQ82rtobMqZ0R96g2h
X-Google-Smtp-Source: AGHT+IGtN/fFFgD5kWlZM7o9A5tbWzODTz9z9HcCpoaArlTRJ10128W2icRy33OzgUwIaucVecHQQQ==
X-Received: by 2002:a5d:68cd:0:b0:33a:fe3b:a048 with SMTP id p13-20020a5d68cd000000b0033afe3ba048mr1822841wrw.34.1706712609631;
        Wed, 31 Jan 2024 06:50:09 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4046000000b0033b0d049c71sm419265wrp.54.2024.01.31.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:09 -0800 (PST)
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
Subject: [PATCH v4 1/4] membarrier: riscv: Add full memory barrier in switch_mm()
Date: Wed, 31 Jan 2024 15:49:33 +0100
Message-Id: <20240131144936.29190-2-parri.andrea@gmail.com>
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
index 8999497011a26..d7ed83b73cbe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14040,7 +14040,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	arch/powerpc/include/asm/membarrier.h
+F:	arch/*/include/asm/membarrier.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a0682..087abf9e51c69 100644
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
index 9116bcc903467..c4ca8085885a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6709,8 +6709,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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


