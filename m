Return-Path: <linux-kernel+bounces-22384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB02829CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD431C21AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3B4CB3C;
	Wed, 10 Jan 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsn7I2wg"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A04C60E;
	Wed, 10 Jan 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so8888119a12.1;
        Wed, 10 Jan 2024 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898567; x=1705503367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzozb8iCEmtU9e7gf57P/YG6f1xRM2em8wJK2yy1xcA=;
        b=gsn7I2wgcox/JnqcGDqqDKjAm1n2m7hKnF+I3kKwWhaJquGkqcGzHWO7PfCOVyL3PO
         b+AJmpxDgvUIwvYa3PUmXdVqcnXHNruY1NnDyxiGYEyJlTIMPP8SiDJzQhsJdPewUl9d
         MNyl1ZKMUubsGhgeJvnR9K/UkXjuObLLSg42rWqJKnsnbYxq4cm6bxWgBEhAJeb+UPY6
         vJCM5hN9NLXlFAgxAtVfMgs8TB0HGJu9V/iiJiP0Kk2wzHRpHeaIM4EHHx5tiyx9ykxR
         XXGzTN2T8ZImWzOGsRxTf1FpB+ZeJWbwYEGua5xhN60EWVNGhSXrfbAZbgtSt2s94vom
         CbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898567; x=1705503367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lzozb8iCEmtU9e7gf57P/YG6f1xRM2em8wJK2yy1xcA=;
        b=Q0R26N0d7RbhlIedFcuMMU2UtZxxFGvXW6Z/bAmLFjgsvSaNUvNQWJsFCL4upS+GiY
         hNQpg1K66YkLsLc1i+dMLu9ilYi7msiu8nSAE2SvubmXdJe+yJ+4byPpcwLxEQBuGyjV
         0N+oFdAg8Qbo0l1Vr8/Zq7J7gZm0GoBHblu14SOdgkMWuftDPmXCUEvAcD/vV4n+sQjT
         hRMqOm4+PbHFKTJbPrQbuVdR3GnWUNeNbUUUgOxh5uFOfjoD5485JEud/Qa9vPBgcp/U
         JP2uQx9204WBgoKFAPTBgXtYm1tze0ZK42mGrkmLoj6ht+hiFTss4oiISE901kRz6b5V
         fHHw==
X-Gm-Message-State: AOJu0Yyc0X3/f2l661FEdkMUB/OIorr/KdpvyNrRDD0kmp+O4k5pKqZt
	R6Ilbe36XTJFbDx0DHHui8g=
X-Google-Smtp-Source: AGHT+IFbro0aX4JfenVN0CWXaIJSjNmp4LSiESS/hHcnDW060bKtIxX1WxZLBedPK80cIKSo6lwVAA==
X-Received: by 2002:a17:906:4e97:b0:a28:b7c1:7210 with SMTP id v23-20020a1709064e9700b00a28b7c17210mr217767eju.7.1704898566889;
        Wed, 10 Jan 2024 06:56:06 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id bm3-20020a170906c04300b00a2a4efe7d3dsm2161032ejb.79.2024.01.10.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:56:06 -0800 (PST)
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
Subject: [PATCH v3 2/4] membarrier: Create Documentation/scheduler/membarrier.rst
Date: Wed, 10 Jan 2024 15:55:31 +0100
Message-Id: <20240110145533.60234-3-parri.andrea@gmail.com>
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

To gather the architecture requirements of the "private/global
expedited" membarrier commands.  The file will be expanded to
integrate further information about the membarrier syscall (as
needed/desired in the future).  While at it, amend some related
inline comments in the membarrier codebase.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 Documentation/scheduler/index.rst      |  1 +
 Documentation/scheduler/membarrier.rst | 37 ++++++++++++++++++++++++++
 MAINTAINERS                            |  1 +
 kernel/sched/core.c                    |  7 ++++-
 kernel/sched/membarrier.c              |  8 +++---
 5 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/scheduler/membarrier.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 3170747226f6d..43bd8a145b7a9 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -7,6 +7,7 @@ Scheduler
 
 
     completion
+    membarrier
     sched-arch
     sched-bwc
     sched-deadline
diff --git a/Documentation/scheduler/membarrier.rst b/Documentation/scheduler/membarrier.rst
new file mode 100644
index 0000000000000..ab7ee3824b407
--- /dev/null
+++ b/Documentation/scheduler/membarrier.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+membarrier() System Call
+========================
+
+MEMBARRIER_CMD_{PRIVATE,GLOBAL}_EXPEDITED - Architecture requirements
+=====================================================================
+
+Memory barriers before updating rq->curr
+----------------------------------------
+
+The command requires each architecture to have a full memory barrier after
+coming from user-space, before updating rq->curr.  This barrier is implied
+by the sequence rq_lock(); smp_mb__after_spinlock() in __schedule().  The
+barrier matches a full barrier in the proximity of the membarrier system
+call exit, cf. membarrier_{private,global}_expedited().
+
+Memory barriers after updating rq->curr
+---------------------------------------
+
+The command requires each architecture to have a full memory barrier after
+updating rq->curr, before returning to user-space.  The schemes providing
+this barrier on the various architectures are as follows.
+
+ - alpha, arc, arm, hexagon, mips rely on the full barrier implied by
+   spin_unlock() in finish_lock_switch().
+
+ - arm64 relies on the full barrier implied by switch_to().
+
+ - powerpc, riscv, s390, sparc, x86 rely on the full barrier implied by
+   switch_mm(), if mm is not NULL; they rely on the full barrier implied
+   by mmdrop(), otherwise.  On powerpc and riscv, switch_mm() relies on
+   membarrier_arch_switch_mm().
+
+The barrier matches a full barrier in the proximity of the membarrier system
+call entry, cf. membarrier_{private,global}_expedited().
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f8cec504b2ba..6bce0aeecb4f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13815,6 +13815,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+F:	Documentation/scheduler/membarrier.rst
 F:	arch/*/include/asm/membarrier.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 711dc753f7216..b51bc86f8340c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6599,7 +6599,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	 *     if (signal_pending_state())	    if (p->state & @state)
 	 *
 	 * Also, the membarrier system call requires a full memory barrier
-	 * after coming from user-space, before storing to rq->curr.
+	 * after coming from user-space, before storing to rq->curr; this
+	 * barrier matches a full barrier in the proximity of the membarrier
+	 * system call exit.
 	 */
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
@@ -6677,6 +6679,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 *   architectures where spin_unlock is a full barrier,
 		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
 		 *   is a RELEASE barrier),
+		 *
+		 * The barrier matches a full barrier in the proximity of
+		 * the membarrier system call entry.
 		 */
 		++*switch_count;
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 2ad881d07752c..f3d91628d6b8a 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -251,7 +251,7 @@ static int membarrier_global_expedited(void)
 		return 0;
 
 	/*
-	 * Matches memory barriers around rq->curr modification in
+	 * Matches memory barriers after rq->curr modification in
 	 * scheduler.
 	 */
 	smp_mb();	/* system call entry is not a mb. */
@@ -300,7 +300,7 @@ static int membarrier_global_expedited(void)
 
 	/*
 	 * Memory barrier on the caller thread _after_ we finished
-	 * waiting for the last IPI. Matches memory barriers around
+	 * waiting for the last IPI. Matches memory barriers before
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
@@ -339,7 +339,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		return 0;
 
 	/*
-	 * Matches memory barriers around rq->curr modification in
+	 * Matches memory barriers after rq->curr modification in
 	 * scheduler.
 	 */
 	smp_mb();	/* system call entry is not a mb. */
@@ -415,7 +415,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 
 	/*
 	 * Memory barrier on the caller thread _after_ we finished
-	 * waiting for the last IPI. Matches memory barriers around
+	 * waiting for the last IPI. Matches memory barriers before
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
-- 
2.34.1


