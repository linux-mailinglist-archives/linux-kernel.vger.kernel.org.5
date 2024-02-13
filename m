Return-Path: <linux-kernel+bounces-63679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80F853320
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FE41F2624B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A253C58AD2;
	Tue, 13 Feb 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMgCyUXL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C058ACC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834581; cv=none; b=ehEBxwEQpNM8fbAn1smCO+lnsBH8I/UxB6pfXR2S8cRNfYNc4N2/A1ugp+YYKu4WlJM/AlalDKVFkWGbFQrVn/BM3hw4+27WM+m9xjR/fG9wO2kssHJNJJ1LEx9AhaOjBJZiZ7uOZLo+W1qAWixIh2wQBGoJ5+dQP/E2XWuL3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834581; c=relaxed/simple;
	bh=Y8B6+9PWQ2Jg0ExHxf/PCV6wz1kRahsPJJH3t6LStkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+UxU/I3k0E9pCu3GeIi57HO1xjcB/PmyUiPftl6fFXxv3m1tpA+soEPfEWQoDUf0adFHJwSiWO36LWcU2X9TiKy5S3Y1Zxn1V0a4wgYbhf1+PwS6VFl3jYyT99P/ACyzJAu2VNkz15A5h45DAEfD1f1WTSvvozrROjaA7/vPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMgCyUXL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so7975250276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834579; x=1708439379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjHBvtVzi/tC9ODHchdE1QaPBdrPAE+kD8d5Z9zVo4E=;
        b=WMgCyUXLX8iqyT0zJnxGyHhLuOVS3O17LXbWXaaCkChOIBwVCK5siIcQIp1h4TDt4y
         /MWX80CQzSyf+i4oxhqZxWijENmprBOoKfQkMbYtgshmYq0oR0GIJGQyx1q46dPdkvOy
         wbgS3xWALBDstWySOYZJDO54KaHChCkk3LV8xaYnqK3pITEk9yEa04G2/CtKWUNdqJ18
         +sYaK3x8IQFqAAXxymacFAZr3TbWxzdZDRtAIzB64Vm79f2GMQHTqoqutSljZtA+GqLO
         u0+VuXq4TNQKXjthfHow5nBH7u2cV32s/idT/o5AQz/X7iuHu0YVWu2LuMjtl9FLL9D4
         SArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834579; x=1708439379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjHBvtVzi/tC9ODHchdE1QaPBdrPAE+kD8d5Z9zVo4E=;
        b=WsW0hM2j7y5mY9Ci3Ke4fs+e4fm7DUyf7gDqkZQbGLbXRIcS88vq21lPEtqCLozKix
         abnfIiOYjLoNfPgUHaqi5rG4+4ni7UGByfG9jqAnauiqzO8chkYdH0Ujfv+vFrxiU4un
         ymiTR5k1bwp7d/0jB3/CLO2cmpOlkjOCFCYDbFE7zpe6KVHztQ96yEFyzGIfDtlRImfA
         KGHWkPdtDKUHM9s8ljj+kVtS9a7flBg+PJKHNz3ZSJqHNRM7z4RkIs+SizLlE1xLlRwC
         U/TEBdciPpvfMxiBJaPl8fZRCXYc7dHQVHueIl3j36xuvYj3YNiUMGJeaXiTXdsFo1T/
         KuNw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1rcqMx090d7F3clZeYoVtjF6SuYYVMJJ/XY/n/MTRFWtwDErYIOagx66nvxvEAhT2lgYIZ+8F6lz+dzHQ3bJ3akhGNbrFXsHy/8Y
X-Gm-Message-State: AOJu0YzU590wg9QvbsNJu2JxOoVIGTtTHz15s5pLuRpvS3e7pixI35Oe
	2h6ALnPeY8T/lhCsh5QHuN9+w+hcmkpmZd+3C9vymAreZ8iI0lL9HibIl9+Qel25SxMR+tJza6y
	sm1DQ6e2EmAttDM9jyw==
X-Google-Smtp-Source: AGHT+IEnRJCLwueO7eGhQ0rGhmrv6mGsg0TspHtOVgdQaw4v/YUHbGoNtQMQmcFS8B1QPArMjVa90Vp9ttsYRXQZ
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1884:b0:dc7:68b5:4f3d with
 SMTP id cj4-20020a056902188400b00dc768b54f3dmr2393690ybb.11.1707834578969;
 Tue, 13 Feb 2024 06:29:38 -0800 (PST)
Date: Tue, 13 Feb 2024 14:29:33 +0000
In-Reply-To: <20240213142632.2415127-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213142632.2415127-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213142933.2417154-1-ericchancf@google.com>
Subject: [PATCH v3 3/4] riscv/barrier: Consolidate fence definitions
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Disparate fence implementations are consolidated into fence.h.
And align with the existing form.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/atomic.h  |  8 ++------
 arch/riscv/include/asm/barrier.h |  3 +--
 arch/riscv/include/asm/cmpxchg.h |  1 -
 arch/riscv/include/asm/fence.h   | 10 +++++++---
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  5 +++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 31e6e2e7cc18..1b2ae3259f1d 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -17,13 +17,9 @@
 #endif
 
 #include <asm/cmpxchg.h>
-#include <asm/barrier.h>
 
-#define __atomic_acquire_fence()					\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
-
-#define __atomic_release_fence()					\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
+#define __atomic_acquire_fence()	RISCV_FENCE(r,rw)
+#define __atomic_release_fence()	RISCV_FENCE(rw,r)
 
 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 4c49a8ff2c68..4f4743d7440d 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -11,13 +11,12 @@
 #define _ASM_RISCV_BARRIER_H
 
 #ifndef __ASSEMBLY__
+#include <asm/fence.h>
 
 #define nop()		__asm__ __volatile__ ("nop")
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		__asm__ __volatile__ (__nops(n))
 
-#define RISCV_FENCE(p, s) \
-	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
 
 /* These barriers need to enforce ordering on both devices or memory. */
 #define __mb()		RISCV_FENCE(iorw,iorw)
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index a608e4d1a0a4..2fee65cc8443 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -8,7 +8,6 @@
 
 #include <linux/bug.h>
 
-#include <asm/barrier.h>
 #include <asm/fence.h>
 
 #define __xchg_relaxed(ptr, new, size)					\
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 6c26c44dfcd6..ca094d72ec20 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -1,10 +1,14 @@
 #ifndef _ASM_RISCV_FENCE_H
 #define _ASM_RISCV_FENCE_H
 
+#define RISCV_FENCE_ASM(p, s)		"\tfence " #p "," #s "\n"
+#define RISCV_FENCE(p, s) \
+	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
+
 #ifdef CONFIG_SMP
-#define RISCV_ACQUIRE_BARRIER		"\tfence r , rw\n"
-#define RISCV_RELEASE_BARRIER		"\tfence rw,  w\n"
-#define RISCV_FULL_BARRIER		"\tfence rw, rw\n"
+#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r,rw)
+#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw,r)
+#define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw,rw)
 #else
 #define RISCV_ACQUIRE_BARRIER
 #define RISCV_RELEASE_BARRIER
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 42497d487a17..afb5ead7552e 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -47,10 +47,10 @@
  * sufficient to ensure this works sanely on controllers that support I/O
  * writes.
  */
-#define __io_pbr()	__asm__ __volatile__ ("fence io,i"  : : : "memory");
-#define __io_par(v)	__asm__ __volatile__ ("fence i,ior" : : : "memory");
-#define __io_pbw()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
-#define __io_paw()	__asm__ __volatile__ ("fence o,io"  : : : "memory");
+#define __io_pbr()	RISCV_FENCE(io,i)
+#define __io_par(v)	RISCV_FENCE(i,ior)
+#define __io_pbw()	RISCV_FENCE(iow,o)
+#define __io_paw()	RISCV_FENCE(o,io)
 
 /*
  * Accesses from a single hart to a single I/O address must be ordered.  This
diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index 4c58ee7f95ec..a708968d4a0f 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -12,6 +12,7 @@
 #define _ASM_RISCV_MMIO_H
 
 #include <linux/types.h>
+#include <asm/fence.h>
 #include <asm/mmiowb.h>
 
 /* Generic IO read/write.  These perform native-endian accesses. */
@@ -131,8 +132,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
-#define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
+#define __io_ar(v)	RISCV_FENCE(i,ir)
+#define __io_bw()	RISCV_FENCE(w,o)
 #define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
index 0b2333e71fdc..3bcae97d4803 100644
--- a/arch/riscv/include/asm/mmiowb.h
+++ b/arch/riscv/include/asm/mmiowb.h
@@ -7,7 +7,7 @@
  * "o,w" is sufficient to ensure that all writes to the device have completed
  * before the write to the spinlock is allowed to commit.
  */
-#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
+#define mmiowb()	RISCV_FENCE(o,w)
 
 #include <linux/smp.h>
 #include <asm-generic/mmiowb.h>
-- 
2.43.0.687.g38aa6559b0-goog


