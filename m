Return-Path: <linux-kernel+bounces-63681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECD85332E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040C528617A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF01E523;
	Tue, 13 Feb 2024 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrFyut31"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C01B299
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834673; cv=none; b=AjHTFrnsrDysh3tmMotmHi4zRawBShROKNEVuaJGVFRD01bp3+g1PzrycJ0XrUCXuz2/ln9u/ysq6c//FPjB3JhfUBJDrWg2Ac393p5W0uqQjSxLGsrRsiz18ZNVFJzTQpgZZUQB4C/jwkDsi3TX9yvyA12X9WvMMSq8JFchaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834673; c=relaxed/simple;
	bh=rrWnxdsH1CziNhGL/0F0LfG64Dd4dLh/dmkAJ8Bk+XM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fSafWOcnUp7P7cRe9Hlt7O97FFGlvyPUVtrp4SWpO98Ym0If9QP2Kq1gRgn0k123M8aknWF9L5ShpCKcZioXxPn0M2SqAbn43JFtSDyhq5KBtu1wgx+UvUf+HGCAYOPCH4Gr/l0No5iKF/jdz4Gr0YJ1k6PKZXMr3NdA0zWe86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrFyut31; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso1394076276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834671; x=1708439471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzWDY0mBU7/wSOckVTmjGeC7uR6OHBXvGcRFd04Rqsk=;
        b=OrFyut31hnbrihCcQ8PKwOaaMdAmj7PpBrQ+vhfT6/0dNVfZkUCy4QuieutiyWmder
         qVzYxF/jdmE0pAQXff2YXUixAPQZXZXhfFg2SVP4VvWI6wgjjH9sq3lG5WXMpOX9X8L2
         sRmmJouWf9ETEN2BCT9eZ0D1QZ2eZYq9lqTSiDolna64HgfcCYTSjqJbtvzk6zmaoq60
         md6HRCqHXbu+HV4+4qCYEj1F/E9v3vAZ2cx11SvNhkvYjmwEBF7Eni03SXa4OtMe4bbm
         tnJTdGbCHpd3wVY/OFjkIZ75duC5EeM1sQrspNbM5io7s0pSxq/plYFdReEm6zWmuX9F
         YkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834671; x=1708439471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzWDY0mBU7/wSOckVTmjGeC7uR6OHBXvGcRFd04Rqsk=;
        b=Q40Zh6sCHmSmGa8gDKRBLC9u+Bx92Un7Laowuvo009/V7SoSoOsOI4koehnbp7RVQw
         JzjgsrYuufCaxYcukn0p5ROwPhaVScIkBmlGPklUvhsN3E77HTP45kA+9X/FAmzCdcA7
         LypED5oiZ96xo+uu+tGLljNxgjTpYyD2xJ2TbbULa9KnUIpVUF/Y7dvZ8sBWAp3n3NlP
         0zbTJ0MGv9rmyAqoDjllqiRlL4VUxZX4BY5KeWHeOw0YPWrrZV9y921PKDDd7Fed9cYF
         9IiulHyJHxDDqABlWS8TCwjFu7rlsRcxOH3WJyFeaoKzxCsKybXIanuOEa53s+n18U3N
         O6gw==
X-Forwarded-Encrypted: i=1; AJvYcCX9z5c6VJNolB6+eTZlg7AcuogxJMRywVa2bXq2vBwm39/UI/VV5yg4YeGQ9GA4pbveZcr4xR9ogDtED6G9K8xkWWy/i+E2MRStuYlc
X-Gm-Message-State: AOJu0Yxhaqf05ut63D5oEU6LxMp1ug03gsefsYaURLBZDREu/NJxDBSN
	nSeRKpNPOjvQQ4Ya6wtsGwBJdVDplSMQAz0L3N5NTsFFN+Zaie7ZM2pijjAIl1erew1tAAjr1FR
	hDlnCnsKd3qmmQR4RRA==
X-Google-Smtp-Source: AGHT+IG1EP97jJJl0nKHqVDmwFVseRqKM6YlcjU/nrMn/gsTAqxMXErcgrlGclTN3Km1NnzLTpHhZiOxV5OTsuBX
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1027:b0:dc6:207c:dc93 with
 SMTP id x7-20020a056902102700b00dc6207cdc93mr345253ybt.2.1707834671075; Tue,
 13 Feb 2024 06:31:11 -0800 (PST)
Date: Tue, 13 Feb 2024 14:31:05 +0000
In-Reply-To: <20240213142632.2415127-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213142632.2415127-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213143105.2418044-1-ericchancf@google.com>
Subject: [PATCH v3 4/4] riscv/barrier: Resolve checkpath.pl error
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

The original form would cause checkpath.pl to issue a error.
The error message is as follows:
ERROR: space required after that ',' (ctx:VxV)
+#define __atomic_acquire_fence()       RISCV_FENCE(r,rw)
                                                     ^
correct the form of RISCV_FENCE and RISCV_FENCE_ASM even if they
already exist.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/atomic.h  |  4 ++--
 arch/riscv/include/asm/barrier.h | 18 +++++++++---------
 arch/riscv/include/asm/fence.h   |  6 +++---
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  4 ++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 1b2ae3259f1d..19050d13b6c1 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -18,8 +18,8 @@
 
 #include <asm/cmpxchg.h>
 
-#define __atomic_acquire_fence()	RISCV_FENCE(r,rw)
-#define __atomic_release_fence()	RISCV_FENCE(rw,r)
+#define __atomic_acquire_fence()	RISCV_FENCE(r, rw)
+#define __atomic_release_fence()	RISCV_FENCE(rw, r)
 
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 4f4743d7440d..880b56d8480d 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -19,19 +19,19 @@
 
 
 /* These barriers need to enforce ordering on both devices or memory. */
-#define __mb()		RISCV_FENCE(iorw,iorw)
-#define __rmb()		RISCV_FENCE(ir,ir)
-#define __wmb()		RISCV_FENCE(ow,ow)
+#define __mb()		RISCV_FENCE(iorw, iorw)
+#define __rmb()		RISCV_FENCE(ir, ir)
+#define __wmb()		RISCV_FENCE(ow, ow)
 
 /* These barriers do not need to enforce ordering on devices, just memory. */
-#define __smp_mb()	RISCV_FENCE(rw,rw)
-#define __smp_rmb()	RISCV_FENCE(r,r)
-#define __smp_wmb()	RISCV_FENCE(w,w)
+#define __smp_mb()	RISCV_FENCE(rw, rw)
+#define __smp_rmb()	RISCV_FENCE(r, r)
+#define __smp_wmb()	RISCV_FENCE(w, w)
 
 #define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(rw,w);						\
+	RISCV_FENCE(rw, w);						\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
@@ -39,7 +39,7 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(r,rw);						\
+	RISCV_FENCE(r, rw);						\
 	___p1;								\
 })
 
@@ -68,7 +68,7 @@ do {									\
  * instances the scheduler pairs this with an mb(), so nothing is necessary on
  * the new hart.
  */
-#define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
+#define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)
 
 #include <asm-generic/barrier.h>
 
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index ca094d72ec20..5b46f96a3ec8 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -6,9 +6,9 @@
 	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
 
 #ifdef CONFIG_SMP
-#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r,rw)
-#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw,r)
-#define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw,rw)
+#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r, rw)
+#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw, r)
+#define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw, rw)
 #else
 #define RISCV_ACQUIRE_BARRIER
 #define RISCV_RELEASE_BARRIER
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index afb5ead7552e..1c5c641075d2 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -47,10 +47,10 @@
  * sufficient to ensure this works sanely on controllers that support I/O
  * writes.
  */
-#define __io_pbr()	RISCV_FENCE(io,i)
-#define __io_par(v)	RISCV_FENCE(i,ior)
-#define __io_pbw()	RISCV_FENCE(iow,o)
-#define __io_paw()	RISCV_FENCE(o,io)
+#define __io_pbr()	RISCV_FENCE(io, i)
+#define __io_par(v)	RISCV_FENCE(i, ior)
+#define __io_pbw()	RISCV_FENCE(iow, o)
+#define __io_paw()	RISCV_FENCE(o, io)
 
 /*
  * Accesses from a single hart to a single I/O address must be ordered.  This
diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index a708968d4a0f..06cadfd7a237 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -132,8 +132,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	RISCV_FENCE(i,ir)
-#define __io_bw()	RISCV_FENCE(w,o)
+#define __io_ar(v)	RISCV_FENCE(i, ir)
+#define __io_bw()	RISCV_FENCE(w, o)
 #define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
index 3bcae97d4803..52ce4a399d9b 100644
--- a/arch/riscv/include/asm/mmiowb.h
+++ b/arch/riscv/include/asm/mmiowb.h
@@ -7,7 +7,7 @@
  * "o,w" is sufficient to ensure that all writes to the device have completed
  * before the write to the spinlock is allowed to commit.
  */
-#define mmiowb()	RISCV_FENCE(o,w)
+#define mmiowb()	RISCV_FENCE(o, w)
 
 #include <linux/smp.h>
 #include <asm-generic/mmiowb.h>
-- 
2.43.0.687.g38aa6559b0-goog


