Return-Path: <linux-kernel+bounces-108619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB62880D10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C6B239AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC739AF2;
	Wed, 20 Mar 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzc2zfi4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5839AC7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923495; cv=none; b=iuMzxYSOP1NQrR6eSKkLwcaxtjFU4gOJzYrMSKUG5tIVX6V+Gt4D7B9Zn9OA7UMFNv8wkk/RiYS0wtMgLG0Hv2ToizQBOyZh750GxyIXpEB1IGvPWL5xIxOOfWfaetHkjjz4QgqQoQQ//QujF8ZxzC/wHQciNnHm/Goib3BqcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923495; c=relaxed/simple;
	bh=2gItDXZJGQHo8Mg0E3k4W+lrWdFzWtPXNUkvUUIfVRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSWy0W35xcQZbwJ8zDWdHlOZ4Z5IU6RRpxenQPbh+wn2uDf5blw1HNmAiKxvWrrwqOLiSv4+z7uuBT7KeB+QVjkdgFyfQMHG5M2hR6q8S/eP54pvY7wcXTD9ZtBbWo/Q2OuQwSe+ufDIrWh1f2avFKSflUtJMShEuTZf8D0NALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzc2zfi4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46ba1a05e0so424307966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710923491; x=1711528291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8x6eiY7ZcIzOZGBmPdvL8XgY7mCZT6eT1G6y3XtGvPo=;
        b=jzc2zfi4jBeYkwg/WZajpnoC2+LZiMGUxB2gjI39ZurioIJ7ePbeBhIUw3fhPkxVr8
         ATnZWSRBS+7dM+Q3U8WdeVW+uG2q5QPqCwtic0eELFSBmBE2+H1pl3wbXYHHEv+mJ1OV
         YAY6QNzLcWjeNzY0pVagvHEJrb375IvLbibqnWUld9X5ERt5kHKU53ptmSOzasLqmRgx
         TCyfC5xVmyEW7+/MdCx1hhghvQKC6TDObTDi/NYaQl4DvPXZhZRC5nRTz1p+yxrTG77D
         JUOjtfQqlNYfCcG7UKJ8PsjUO43IRgYNhfjwJW4DSAENON1FUbmvFoylySgyiRzO1hyC
         Stwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923491; x=1711528291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8x6eiY7ZcIzOZGBmPdvL8XgY7mCZT6eT1G6y3XtGvPo=;
        b=kfqMVdrZ4OasnKsTn38F7H4v1YsZ1nRJnw09onzN+QSJOb5ijpQ1rfOtDjxolLt4Mx
         73MFAxgxr0JFjPohdqQFHYjXowc4TTL3PQS/4PcBR/jPiOkv1WolRpk5kYVgrj9AE+cM
         BW96OzTTlXlAKMbSpcP4Ss/+YCMdgeN7uNKbadnANoIkihcenXrOSaGQGGsskopr0FJq
         wtmhN1LRnL9jppLzB2MBRa/Lk4M95oeiXAVSOQ6fYoeCBC5b7ZyhPulFRdIn4nVS9SKS
         S7UGamhE2GjIA4NqRRkk4+FV++L51DwMD9IPDcbYcDw+xkjqvxjMuMKxWDs9lTq3Yu6x
         RkPg==
X-Forwarded-Encrypted: i=1; AJvYcCXbd0CC3ITJ8fgBZVyUFX4zAzFC4c3rRTza1GsM2O+DmXrsqJwVWClPYJNR6Z9ljHCSOuWfMGiP0fc3i/zPGND9bYSZ5V0zISHjLBg2
X-Gm-Message-State: AOJu0Yzhdj+/WNlA2dyokV5d1O/ffnkQI8byQYQvwk7SleiYjI/mfgQ/
	AQ9ULYZCfPkDgJxer0dNXWxjJJrkQ6V8s+/B2Lcfya4OhGzSSYih
X-Google-Smtp-Source: AGHT+IHzXa8bZzz1mi+t3E6yuzkgZm3Yz9/2/q65ioQfQC/xnLXkWcYHB7r6ux/Q2Rk321cq8ZuzYA==
X-Received: by 2002:a17:906:79c9:b0:a45:f705:777c with SMTP id m9-20020a17090679c900b00a45f705777cmr2864659ejo.40.1710923491208;
        Wed, 20 Mar 2024 01:31:31 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ci20-20020a170906c35400b00a46e92e583bsm1170769ejb.149.2024.03.20.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 01:31:30 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/percpu: Define this_percpu_xchg_op()
Date: Wed, 20 Mar 2024 09:30:40 +0100
Message-ID: <20240320083127.493250-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite percpu_xchg_op() using generic percpu primitives instead
of using asm. The new implementation is similar to local_xchg() and
allows the compiler to perform various optimizations (e.g. the
compiler is able to create fast path through the loop, according
to likely/unlikely annotations in percpu_try_cmpxchg_op).

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 44958ebaf626..de991e6d050a 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -230,25 +230,15 @@ do {									\
 })
 
 /*
- * xchg is implemented using cmpxchg without a lock prefix. xchg is
- * expensive due to the implied lock prefix.  The processor cannot prefetch
- * cachelines if xchg is used.
+ * this_cpu_xchg() is implemented using cmpxchg without a lock prefix.
+ * xchg is expensive due to the implied lock prefix. The processor
+ * cannot prefetch cachelines if xchg is used.
  */
-#define percpu_xchg_op(size, qual, _var, _nval)				\
+#define this_percpu_xchg_op(_var, _nval)				\
 ({									\
-	__pcpu_type_##size pxo_old__;					\
-	__pcpu_type_##size pxo_new__ = __pcpu_cast_##size(_nval);	\
-	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]),		\
-				    "%[oval]")				\
-		  "\n1:\t"						\
-		  __pcpu_op2_##size("cmpxchg", "%[nval]",		\
-				    __percpu_arg([var]))		\
-		  "\n\tjnz 1b"						\
-		  : [oval] "=&a" (pxo_old__),				\
-		    [var] "+m" (__my_cpu_var(_var))			\
-		  : [nval] __pcpu_reg_##size(, pxo_new__)		\
-		  : "memory");						\
-	(typeof(_var))(unsigned long) pxo_old__;			\
+	typeof(_var) pxo_old__ = this_cpu_read(_var);			\
+	do { } while (!this_cpu_try_cmpxchg(_var, &pxo_old__, _nval));	\
+	pxo_old__;							\
 })
 
 /*
@@ -534,9 +524,9 @@ do {									\
 #define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
 #define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
 #define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(1, volatile, pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(2, volatile, pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(4, volatile, pcp, nval)
+#define this_cpu_xchg_1(pcp, nval)	this_percpu_xchg_op(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)	this_percpu_xchg_op(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)	this_percpu_xchg_op(pcp, nval)
 
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
@@ -575,7 +565,7 @@ do {									\
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
+#define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 #endif
-- 
2.44.0


