Return-Path: <linux-kernel+bounces-136624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A389D641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C001C2116C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27D86242;
	Tue,  9 Apr 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLSCgrRX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1118173B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657113; cv=none; b=tOilzj3V/WMNTckbPqqyCuO45BBSn9O2jquoVZJpngguJCg3LyJNWOr3X+MbTr5ZQa38LZ8sOrsAONG5cLix8pd+GPy2qHeI7QSDvkolticLIOJ969y9EE9lu+CRJ0jdezg8CbOAceCxy/HBLcQdp/wofs7E12jKskoI+Gd3Z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657113; c=relaxed/simple;
	bh=/Nb0syoqXrLtiMCAaNUxknKwFQ8hydCC1BIHa4Sg4cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf9kNY2yrXSpZpcN4s8dQ59FveX4qqbAkDT3r6TMeV4t3IoL3kUXu7ZEAOjc6URBTVJU9bh87zdSrmIL3vCcDQCtLcZArTL13C9+5EIUqg+J072ftDPRSV9n8uelnTyWZkJyEa6rOhIkIg531fb/bXebLjDe4DNU7QQUD31UmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLSCgrRX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e6282dd72so2287572a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657110; x=1713261910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JAl2q7pGidcLS0wjbtFM6lZo9cgP3O7vC63sSwKbiE=;
        b=HLSCgrRXtL1hIEWKXr21MfMw29kTtEHXLvuwDhTfXyr+wwPX/q31lLV/2PJ+dAQX5F
         Srfd/evLdmEMyZDBCbOS8vXlkODT2ozpjJSb77uNGUfJfxH93xAX4hsOOipFphyAWRHV
         WcWpLQ0BNPPo12EXNLpDYyyri1XCo9e0yhjuslue7GQHfWZA+5UB0jUh6gsWmc8Mqkf1
         I4I0xD0dLevbOeffFQBEV93C9pTB0vqjJtyrf3tTkLro/stdIXrtCMwblmJ57V7pA83l
         2HnUlQyjY98XeYebwvO2BjFeGqPsA/PZV3+2SMydx78Hyj+k+Hb3G51DWb811+Od4puY
         45yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657110; x=1713261910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JAl2q7pGidcLS0wjbtFM6lZo9cgP3O7vC63sSwKbiE=;
        b=Zz5a6qZ+SOfUnr9nHuNvg0EpWarOn2H4QiXhfQM9V+x5IKadkBe8o40RpxWJsIN+Gc
         cK5JtV7Zi6dtlP1Cv4pIHXEeON7PNRXs/TdDJ470kCMnjFOEjb1C0QpxyeahyScxQCln
         aWOwXjaHzQl12tA1kCX8FrtbzPpzPOF7gyUV1GbWBo6MBqeaOmb2hzdp9kR8T1nfeGuv
         UPrXS7xoFg4ZSLfAjGiWWadHWAlKpLZzPdNrrXzm+/Zca4ZLm2n/WuFhS3HgOaDBOMq8
         Kgq9nZVzORvnH92QwppUlbZOzA/c9YtK7hAp5bd+o6mC7Mgclr4dcj3aZmf0pkgL04HG
         b0sA==
X-Forwarded-Encrypted: i=1; AJvYcCXFbIxkTJnQr8UsZCbeOOkETYfJjb0EDkNd4gNNQyy458KTyp6BFbmkFOjyTjbo0D6L6QdbdWtFcw3ejzPVUHft7OJg2CKqbkLuB/fg
X-Gm-Message-State: AOJu0YzLY8zWfizfN+Yjtkwl93Eb7VRWB3q6LMSH28k6JwWHmLSPKInP
	e3DyE7FLIcC/eKD7mkq9AkC5zo18+HJ2DVqKceDeVo16yEECCfXl
X-Google-Smtp-Source: AGHT+IHKyj6j3YIALqLzvD/zqxAze4Rcqk7nzqdEyINEKyYh9fT9ZqY6Cq+bHIiHeEm4EtqxwV3QGw==
X-Received: by 2002:a17:906:558d:b0:a51:a09c:16a5 with SMTP id y13-20020a170906558d00b00a51a09c16a5mr6174552ejp.23.1712657109732;
        Tue, 09 Apr 2024 03:05:09 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:08 -0700 (PDT)
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
Subject: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions
Date: Tue,  9 Apr 2024 12:03:53 +0200
Message-ID: <20240409100503.274629-3-ubizjak@gmail.com>
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

Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions to
use arch_atomic64_try_cmpxchg.  This implementation avoids one extra
trip through the cmpxchg loop.

The value preload before the cmpxchg loop does not need to be atomic,
but should use READ_ONCE to prevent compiler from merging, refetching
or reordering the read.

The generated code improves from:

  1917d5:	31 c9                	xor    %ecx,%ecx
  1917d7:	31 db                	xor    %ebx,%ebx
  1917d9:	89 4c 24 3c          	mov    %ecx,0x3c(%esp)
  1917dd:	8b 74 24 24          	mov    0x24(%esp),%esi
  1917e1:	89 c8                	mov    %ecx,%eax
  1917e3:	89 5c 24 34          	mov    %ebx,0x34(%esp)
  1917e7:	8b 7c 24 28          	mov    0x28(%esp),%edi
  1917eb:	21 ce                	and    %ecx,%esi
  1917ed:	89 74 24 4c          	mov    %esi,0x4c(%esp)
  1917f1:	21 df                	and    %ebx,%edi
  1917f3:	89 de                	mov    %ebx,%esi
  1917f5:	89 7c 24 50          	mov    %edi,0x50(%esp)
  1917f9:	8b 54 24 4c          	mov    0x4c(%esp),%edx
  1917fd:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  191801:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  191805:	89 d3                	mov    %edx,%ebx
  191807:	89 f2                	mov    %esi,%edx
  191809:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
  19180d:	89 c1                	mov    %eax,%ecx
  19180f:	8b 74 24 34          	mov    0x34(%esp),%esi
  191813:	89 d3                	mov    %edx,%ebx
  191815:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  191819:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  19181d:	89 df                	mov    %ebx,%edi
  19181f:	89 54 24 44          	mov    %edx,0x44(%esp)
  191823:	89 ca                	mov    %ecx,%edx
  191825:	31 de                	xor    %ebx,%esi
  191827:	31 c8                	xor    %ecx,%eax
  191829:	09 f0                	or     %esi,%eax
  19182b:	75 ac                	jne    1917d9 <...>

to:

  1912ba:	8b 06                	mov    (%esi),%eax
  1912bc:	8b 56 04             	mov    0x4(%esi),%edx
  1912bf:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  1912c3:	89 c1                	mov    %eax,%ecx
  1912c5:	23 4c 24 34          	and    0x34(%esp),%ecx
  1912c9:	89 d3                	mov    %edx,%ebx
  1912cb:	23 5c 24 38          	and    0x38(%esp),%ebx
  1912cf:	89 54 24 40          	mov    %edx,0x40(%esp)
  1912d3:	89 4c 24 2c          	mov    %ecx,0x2c(%esp)
  1912d7:	89 5c 24 30          	mov    %ebx,0x30(%esp)
  1912db:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  1912df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  1912e3:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
  1912e7:	0f 85 f3 02 00 00    	jne    1915e0 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h | 44 ++++++++++++------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 11e817dab44a..84affd7a5d1c 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -201,69 +201,61 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = __READ_ONCE(v->counter);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c + i)) != c)
-		c = old;
-
-	return old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
+	return val;
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-- 
2.44.0


