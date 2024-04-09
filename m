Return-Path: <linux-kernel+bounces-136628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D589D646
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E165B1F22498
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41012AAF0;
	Tue,  9 Apr 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC6p1iHW"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D578129A7B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657120; cv=none; b=o9I+C0NJg37FDxDIrdqJvkoIlfeO/wh7JLI47si4IF2Ewt70WUYi9ezUudc5HUNjmdOTvrTdPkgY+tAB/lzcI4Oel7y/OEUFBoeennmk+fAduH5/7IqC9/twx/71mWDL5YH33Pvl9CPSD0b++2IKLEwVeo2b5XZLeNQaAxo6Y9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657120; c=relaxed/simple;
	bh=+IJA9+/LkDO3Qh/z4ZzTDQ69ze3J+3wDzxu13Sj1clQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QykGzBAqdV6cYzvbgGolW358DBpdUjVzGLCj7HgpMuVSbfBXYLd4+TqdhAH4kAtcwSFF6OKa1eQoHHAtbbWB04GU8akjycUZe29D5MwcJgtrKGYK1CuSbr9waf+DA9Yqhw0bWysOBQEJRAFgmNdtNkN2Z1zCF0CK6dzoRM67UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC6p1iHW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5200202c1bso26184666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657117; x=1713261917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyHz56u/iO9/FgsI4q0cP6V/rorpyyesh7+7+zlmKI8=;
        b=bC6p1iHW8rZgqBzJSrEDMfsBA8aTO0wbFgbYcGVyKUpUB4JNc/tKHr2S8OdXpgabDz
         2DMYFlMzl25nixcs6I64S795bRhd5dhCO2cuYQVQXKHuGN6ZDSNrdez3VQf+PXqcTzpI
         r2iF9EzOAMSHbUB61JpiLH48+Fn/ee0pp34JuSEp8NipWxg7YS/N60ZWLSvvFQVu+vVE
         GUYszspOjp9Ar/f0j4pQV9gQdOtcFhX7zLWuDdUljn/fQA3VdkgghI6lwKsIIn6phpiG
         8PijcE2aRcLEjmxGl4wA2l5LtSlMrEPBHDY0Wk5WcLKVkoajljBHjb87Qwt4NNLHx0Ep
         5x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657117; x=1713261917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyHz56u/iO9/FgsI4q0cP6V/rorpyyesh7+7+zlmKI8=;
        b=qAxiTrTRMziYMLl4vF6x9+3ftV7pTJ5FP/pqSNPX6Cpj5RQgLMPbwXHr49tf4UMQWD
         WCpB+NUOrh3FcSXZtR+SYx4dXeBljV9TRoTcLqfYGRkp0etzto/2+GlRSVLbGyqKiqbs
         xGKJn1biRgHedCUzWW7+0jvtKi28NbAoLQhREyHVwoiXBnUMcFY+3XM+q4OMgVBZ2ayx
         VrdfJBEA31KMh+jOooArfUUCsn17shSNfw6/T+avI+UsE31ZSDZRviZWG49udNL9OabD
         3VhHdK8kglUfjwzAAMa9vjqoCfin7J+RuhCjMat5fbD28M8FG3tv9FPXt5mxA/3Tf9Km
         Z/9w==
X-Forwarded-Encrypted: i=1; AJvYcCWefhON1LfgyPf+vo98S3HXbwUUo45X0BK99CIL4LcBolKAIeE/YqgLI9wGkWcVVsj06HEB1dlEmEub51WG+ZKWqpdKYcHreK12SoKc
X-Gm-Message-State: AOJu0YwGJ6efaJq3NQ0f+qaO4uXrdL6WdlOvyKnyl1xtWeZk8jh+4LVI
	KR7uxmJo6rQshTxz7SGLTVwOGG9yRioD8PLWtLrh/V9yOJNH9iq4
X-Google-Smtp-Source: AGHT+IH4uESLV606lHisWITKlS8BD5JNspBkRmUwN0p7WVc2Hamq61jeR9aVU0Fl23GolotFpGbE+A==
X-Received: by 2002:a17:907:7ea4:b0:a4e:5676:417d with SMTP id qb36-20020a1709077ea400b00a4e5676417dmr12020143ejc.58.1712657116669;
        Tue, 09 Apr 2024 03:05:16 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:15 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6/6] locking/atomic/x86: Reorder a couple of arch_atomic64 functions
Date: Tue,  9 Apr 2024 12:03:57 +0200
Message-ID: <20240409100503.274629-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409100503.274629-1-ubizjak@gmail.com>
References: <20240409100503.274629-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder a couple of arch_atomic64 functions in
arch/x86/include/asm/atomic64_32.h to better match
their sequence of declarations between x86_32 and x86_64.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h | 46 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 862448db1207..3864d82a9339 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -12,7 +12,7 @@ typedef struct {
 	s64 __aligned(8) counter;
 } atomic64_t;
 
-#define ATOMIC64_INIT(val)	{ (val) }
+#define ATOMIC64_INIT(i)	{ (i) }
 
 #define __ATOMIC64_DECL(sym) void atomic64_##sym(atomic64_t *, ...)
 #ifndef ATOMIC64_EXPORT
@@ -61,17 +61,21 @@ ATOMIC64_DECL(add_unless);
 #undef __ATOMIC64_DECL
 #undef ATOMIC64_EXPORT
 
-static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
-	return arch_cmpxchg64(&v->counter, old, new);
+	s64 r;
+	alternative_atomic64(read, "=&A" (r), "c" (v) : "memory");
+	return r;
 }
-#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
-	return arch_try_cmpxchg64(&v->counter, old, new);
+	unsigned high = (unsigned)(i >> 32);
+	unsigned low = (unsigned)i;
+	alternative_atomic64(set, /* no output */,
+			     "S" (v), "b" (low), "c" (high)
+			     : "eax", "edx", "memory");
 }
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
 static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
@@ -85,22 +89,6 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
-{
-	unsigned high = (unsigned)(i >> 32);
-	unsigned low = (unsigned)i;
-	alternative_atomic64(set, /* no output */,
-			     "S" (v), "b" (low), "c" (high)
-			     : "eax", "edx", "memory");
-}
-
-static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
-{
-	s64 r;
-	alternative_atomic64(read, "=&A" (r), "c" (v) : "memory");
-	return r;
-}
-
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
@@ -199,6 +187,18 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 #undef alternative_atomic64
 #undef __alternative_atomic64
 
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return arch_cmpxchg64(&v->counter, old, new);
+}
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
+
+static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_try_cmpxchg64(&v->counter, old, new);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 val = __READ_ONCE(v->counter);
-- 
2.44.0


