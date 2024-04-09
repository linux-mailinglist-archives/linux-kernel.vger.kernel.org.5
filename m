Return-Path: <linux-kernel+bounces-136626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC5189D643
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDEB21BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF4281724;
	Tue,  9 Apr 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmAaHBaR"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3F86AC8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657117; cv=none; b=C6RdZxvdFY4MdNIvf3qe6disakToHY1NdchInsO87vRjfpm/gAmRkXWVo3xdUpH3to9enyBLKmoORn+eR0v4lAM26fwxTLs2wIp6grCEH9UpLht2BmAHMBWI9ZtBr+/F0j5nGCVaxNWhpiJtw7kpaNp0FZLShj46y+m18ZX47bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657117; c=relaxed/simple;
	bh=+yDCeMsqfwL99gW6SvVlG/j6+165sentyxdZBx5xZYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRSr7YiiH1uZON4MfCjt7l4AJ1eRD7VHuPAQCDJIRWMEacc29ghuQiRkN0tpqOqxYGr7/kb1vqHDprRvPCVvJgi7xsNcvRcOKhVJS5BOWSC013/6pOtmJSf6HDJ8uW61bYtQVbFv4McrrcJrtlPVqxwMvtVIdWCHZvdZ3OtQpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmAaHBaR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso7293865a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657113; x=1713261913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDyjDITii34VI9lPR5N4ADo94eAWkADYksZtESuAH2M=;
        b=cmAaHBaRBau+V4wS41q9e1Me4Z1ncnlzOwLEr6gtoAToynmhJDJBm1LZTmQ+G4N8Q4
         FwhiZyTnL3PHq7kVaaQMv08wtI8hB7/4aCkF91qY19rleWgZntwVITlWNUQVA2ZR5zwU
         1iowEKO90dlFLYwVza1h1fCTxX5GRyGdCixLvHwCZVR4LHoOp3QqG52SXfVG8+E57b9W
         HELwpgXZwGJljk+Toe0tksKoIzf/VRiRWoxxVxuZ0jOoJc7qq5PpvN14SPyv4hmZ7fwL
         FNSw2gXOi/jsBZ88nTQgkVa7WPNbrsJctZHE0xjkEhz6wUBZ0qv0mSg9oHk0I3iBoDoP
         tofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657113; x=1713261913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDyjDITii34VI9lPR5N4ADo94eAWkADYksZtESuAH2M=;
        b=aHX37WNmyjWyq/kJjBvonwCk8R2MuRslRB5g2kmXgKg52la/qmzeqN6F56U0UeXOfK
         X5pMT8AITpIlixNI1SzzDLPur9pdTDWeiCoss+e6PIrQjWBGATHXWMMYYbJeUYnS1tQK
         l8jO3BUNOR8RpFCnj6w/puqaYbRGrYEAyCLuVgkwEJ9zks92FUGKe/YCquImnp5K+3AZ
         rNYB6CHypMEyMq5ceyyRTfXy2sPzzEKIzekR1QuIBJENY9UE1fQKtVEyWNXkRmSjHMKj
         dX6hcf9XhCNsnZ5JR3zW7DgoS4KjCvAA/oLfaCIlKVjefIlK0nSPRdCkIcuuD0YEx6/o
         4LIg==
X-Forwarded-Encrypted: i=1; AJvYcCWsGCd71fVIgvdCXrtlBg4QHrTayutX3EQJRw8A/5LYDI7mclN+5ZWcBtyhDScTdu3C4gXAir1m0VU8A2ulP+wLO1m1TaoZHxt+YHVY
X-Gm-Message-State: AOJu0YxB9ejEG8mfxGhGK+1OfsNyfSJqIVYXsHNFH4kJbyJ7tdqfqkbC
	8UES1NX6GkGxeCDfoIdpoQhwOplajM2Z0iYQGjIXFl/0h+Q9BDnL
X-Google-Smtp-Source: AGHT+IFTksx4G/lsKVJ4YE2wR0cuLbVAbVcz3Q/Es4sHPwEpArtufxPn41aChi9fHjXL3E1KWRa3gQ==
X-Received: by 2002:a17:906:694f:b0:a51:b228:9282 with SMTP id c15-20020a170906694f00b00a51b2289282mr5619021ejs.44.1712657113240;
        Tue, 09 Apr 2024 03:05:13 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:12 -0700 (PDT)
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
Subject: [PATCH 4/6] locking/atomic/x86: Merge x86_32 and x86_64 arch_atomic64_fetch_{and,or,xor}() functions
Date: Tue,  9 Apr 2024 12:03:55 +0200
Message-ID: <20240409100503.274629-5-ubizjak@gmail.com>
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

Move the same definitions of arch_atomic64_fetch_{and,or,xor}() from
x86/include/asm/atomic64_32.h and x86/include/asm/atomic64_64.h
to the common place in arch/x86/include/asm/atomic.h

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      | 30 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/atomic64_32.h | 30 ------------------------------
 arch/x86/include/asm/atomic64_64.h | 30 ------------------------------
 3 files changed, 30 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index b166da21ee98..b2e44de36934 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -182,4 +182,34 @@ static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
+static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
+
+	return val;
+}
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
+
+static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
+
+	return val;
+}
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
+
+static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
+
+	return val;
+}
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
+
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 84affd7a5d1c..4f79198da98e 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -206,16 +206,6 @@ static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 }
 
-static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
-
-	return val;
-}
-#define arch_atomic64_fetch_and arch_atomic64_fetch_and
-
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
 	s64 val = __READ_ONCE(v->counter);
@@ -223,16 +213,6 @@ static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 }
 
-static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
-
-	return val;
-}
-#define arch_atomic64_fetch_or arch_atomic64_fetch_or
-
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
 	s64 val = __READ_ONCE(v->counter);
@@ -240,16 +220,6 @@ static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 }
 
-static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
-
-	return val;
-}
-#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
-
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 val = __READ_ONCE(v->counter);
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index e7b12a48fecb..b2c9974ba971 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -124,16 +124,6 @@ static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 			: "memory");
 }
 
-static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
-
-	return val;
-}
-#define arch_atomic64_fetch_and arch_atomic64_fetch_and
-
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "orq %1,%0"
@@ -142,16 +132,6 @@ static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 			: "memory");
 }
 
-static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
-
-	return val;
-}
-#define arch_atomic64_fetch_or arch_atomic64_fetch_or
-
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "xorq %1,%0"
@@ -160,14 +140,4 @@ static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 			: "memory");
 }
 
-static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
-
-	return val;
-}
-#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
-
 #endif /* _ASM_X86_ATOMIC64_64_H */
-- 
2.44.0


