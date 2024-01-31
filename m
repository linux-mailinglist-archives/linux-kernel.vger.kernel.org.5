Return-Path: <linux-kernel+bounces-46630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368BE844233
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E8E28D612
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AFF128388;
	Wed, 31 Jan 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL3w59yS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7708612C;
	Wed, 31 Jan 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712616; cv=none; b=PoztpLOmtrue42ONaxuY2rNVduAiKcLm9w4M4VJMjXF+QCGHipvm7xBmTMIBgrllfulGJCO8RDJ9d1Ep76a+bDNC2p/1gJyvAW82leUqWVt3RXvt8STwb4EYteBY1Ay/oCCYqWsj079ioe8BEkRKSuwZDTB9t7K2A38D197yDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712616; c=relaxed/simple;
	bh=Y3NgUBGXdUV4dhmvAwvFzGCehZ9jDBvemYvr/RxFKHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/Ia58lIyDKgkw2eDyCae8oDSkTqEbNwDp1s8TH5wvxYzujGbtbSf42L+tsDr4dV1fdO1yPhEOIJAdI2G+il61sD1RQv5gNz82qbafj9wv0e0ZVgGC3sK+25aQG6bY2A55eHrKQmZzMQk2wKHHxQL4XwvmBmIZYaSxPdIGD7VKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL3w59yS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5102a877d50so5982578e87.0;
        Wed, 31 Jan 2024 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712612; x=1707317412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IlmVFOYTS7aecT5TyzaoLng2Pb3mBf2n8I/n2NMhv8=;
        b=QL3w59yS3ILEgf4DXHeoEeWpnmLPMM02ZBKD+pUt8yldFHHkW5DiRnlc63nDVoWPNd
         xmtwpeNGNrh1hiIl79R5WuSRG/oSffwjzdyvm41XqdaQaEUZlS2beDDXK/0J2Whq0s4B
         2rzt1TjOOX+QLjw2g/Q9UzwXlwY+o42j6q+RwOi6bFJX4oUN7PV+tj1pxyYUBRXbQoS8
         M+HHl41uJfKptkJ+bThczvsFLXVpIf9ZeKb+IU46NTJiRM0yF78u8wWLgK6ySSvur9lw
         cy7OPwq4jUE2srpKyUVzhvBa1cKNq19EOdyRM1t5+L8S7hRZ6Y/hB2v7huvS3zQ9U8GU
         x6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712612; x=1707317412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IlmVFOYTS7aecT5TyzaoLng2Pb3mBf2n8I/n2NMhv8=;
        b=WgiizwrZN2epIUp/+qH8LxSJc0tJ0EtNDYGf8ZIbjOZpIPc0uolzUNKzDfXj9RjYLo
         orlsYfOaWJncuWGwmpkevz6uMO93xHihBJ2dptkWIM8ZWgU6LPAa8h/6YBLZRWRPubVD
         OPIVmljRiYKcPcHnlHIxr0QPZqwxS7Pj2RgVzpXzN4/PxOPh9lhs0EcsdGOITtMyBel+
         7TABuBltOrfnVjhnk0qNsOAAtALRq93nG3aqVAd13TkUX31kEH/xn1misGtozBT/s8PY
         Hml+rrqFyTt6CxSaVSY/37sOSm+YAK5VHIKCk3NIYB9Gh1Q30H3GOUHa+dwqx8ej+LVl
         QiJw==
X-Gm-Message-State: AOJu0YzdEP3KYQ/rDk5ChR+WsyYTqcJz9hj7ZG/nov79UtDrqdqFDG+1
	pLrUHkEUUrdM//HQ5J4wMw3FzDXCLPDthDkq9MvU+o0iqZsHqtIF
X-Google-Smtp-Source: AGHT+IGrkog/qhZGfuQC5VscYem/7+Dnb/2LHjHr6AKiylercaEQE/FyzttVwRS81d3a/pjOtyBwJQ==
X-Received: by 2002:a05:6512:6ce:b0:510:f52:648c with SMTP id u14-20020a05651206ce00b005100f52648cmr1623894lff.51.1706712612052;
        Wed, 31 Jan 2024 06:50:12 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4046000000b0033b0d049c71sm419265wrp.54.2024.01.31.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:11 -0800 (PST)
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
Subject: [PATCH v4 2/4] membarrier: Create Documentation/scheduler/membarrier.rst
Date: Wed, 31 Jan 2024 15:49:34 +0100
Message-Id: <20240131144936.29190-3-parri.andrea@gmail.com>
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

To gather the architecture requirements of the "private/global
expedited" membarrier commands.  The file will be expanded to
integrate further information about the membarrier syscall (as
needed/desired in the future).  While at it, amend some related
inline comments in the membarrier codebase.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Documentation/scheduler/index.rst      |  1 +
 Documentation/scheduler/membarrier.rst | 39 ++++++++++++++++++++++++++
 MAINTAINERS                            |  1 +
 kernel/sched/core.c                    |  7 ++++-
 kernel/sched/membarrier.c              |  8 +++---
 5 files changed, 51 insertions(+), 5 deletions(-)
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
index 0000000000000..2387804b1c633
--- /dev/null
+++ b/Documentation/scheduler/membarrier.rst
@@ -0,0 +1,39 @@
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
+The commands MEMBARRIER_CMD_PRIVATE_EXPEDITED and MEMBARRIER_CMD_GLOBAL_EXPEDITED
+require each architecture to have a full memory barrier after coming from
+user-space, before updating rq->curr.  This barrier is implied by the sequence
+rq_lock(); smp_mb__after_spinlock() in __schedule().  The barrier matches a full
+barrier in the proximity of the membarrier system call exit, cf.
+membarrier_{private,global}_expedited().
+
+Memory barriers after updating rq->curr
+---------------------------------------
+
+The commands MEMBARRIER_CMD_PRIVATE_EXPEDITED and MEMBARRIER_CMD_GLOBAL_EXPEDITED
+require each architecture to have a full memory barrier after updating rq->curr,
+before returning to user-space.  The schemes providing this barrier on the various
+architectures are as follows.
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
+The barrier matches a full barrier in the proximity of the membarrier system call
+entry, cf. membarrier_{private,global}_expedited().
diff --git a/MAINTAINERS b/MAINTAINERS
index d7ed83b73cbe4..628f3762d97cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14040,6 +14040,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+F:	Documentation/scheduler/membarrier.rst
 F:	arch/*/include/asm/membarrier.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4ca8085885a3..a972628e77567 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6638,7 +6638,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
@@ -6716,6 +6718,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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


