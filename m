Return-Path: <linux-kernel+bounces-112861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90DD887F21
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238A3B20F92
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8FC1C292;
	Sun, 24 Mar 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeArdLdk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE1101E6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711315226; cv=none; b=qosSjX+kLimhyZzxeYBv0v6Hj/B8/hyIIDToHYyP00Y7Jlhc1RhXYFq4S5Rk6GHy8IX2VoAjOgyENzI67TUS/ao312WnjRBqMJ7GocH1xRx0eUhF71UM8wfvCr1/p5XnwVFMKb2r+4W+UT7lgbTbAhuYdV4hmKiUtpeSgAZeQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711315226; c=relaxed/simple;
	bh=t6RgMbQuFwYBOzqxUOSe7Vsk05XtF5E+0zD79Avmkec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3JHcjJ+YVx4WJ9Tp6kbVMNoG8PkgtbxQCI5JCN1Ody4pGZaxXWlb4hWV36+dEwTYHF149pk9K5MiSG2qIbP0xHpJK794of2pN+08kJKg1w9FXTjwcrIgRqkJqnLRjYNhL4nd4HaLu2eU58fpwl/ioxlDfKHPc+NEykDraxeCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeArdLdk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a468226e135so442812266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711315223; x=1711920023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qF1RsKVO6ZLPhS9Y03A3EI4O6qFxAObAj5GT0U8NRhc=;
        b=YeArdLdkAoxzjeTjkMD47Fq70TCcNJyHe3USewwLZq/cROhAi27ys8K369tdBfnbNm
         jOzr+qEDOhQ40nbI8rfY+SfoVSFkBBBr3xdG440B0ZY9OSb/RhXo3XnhBomyQZDjA6+G
         9sKxhB6g6EEc8O5sOZFydzQsn7UhfBb/2GkwrJKP9FxIqgCi/jMXqt2dvM8MR7iwpoUF
         d/f2GyLjk5irIdAd2uQOt8uBn6MIGEZe8nLIa4Bc8OK9ZzRuaQ9FpCTfHTbCkzojqGyN
         dAvlWpU2OuA15PkgblzkQO3RBHcQIgkyIyoPPpjefeKA60M2ANCXFbfs/VjhY41rvPAp
         ItlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711315223; x=1711920023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qF1RsKVO6ZLPhS9Y03A3EI4O6qFxAObAj5GT0U8NRhc=;
        b=VbmmHcXbGLHRE1anWQElWEUYZrYwJZJJcRDOOCmuQ3mYu2itGGEYHpdf1zNhUrBGay
         cPLGmnqzO2DOqrwofFwg4S8T0f1883l4ZC0+P/50qnsOI5t8BsVCcHZnf0Yc/rGWRvcE
         8aFQtn4yZ0KHQV2Y9r8EM9P24mnlsIXDpf/I0zKHlfRnxdLlBjFxO45qLJsRN6Y06un3
         Pk+0mW7Um5/dTE81r109yMOn4eqEQyXX4Tw0S96unoOmp3Bj32TMhidPsa8st5EJW4Cm
         lzzMzIwxSmTDx+2vMV2nDn+zlU45JPiL26PocLBtpTtOMJP1+P0e0E+IOzaDjmIYlvIp
         FbDw==
X-Forwarded-Encrypted: i=1; AJvYcCVTXfn1OvikSIKKo+FlB9Uhec6Z63+We052hu5/6IXWVhY+tnjsrFx3xCfQoGjWCEDY1bHPVnvWTs7L0Kdbz69oz3OJ7sYX5e/xC8gg
X-Gm-Message-State: AOJu0YxgyDm863+dizRbNLMXHIbwgqYXDP6plUfXVTw/yEXL03A7M3lY
	o4XJyvdUPmPbFDZZfk4mCAjuRtfYEkZW6e2qbtm9epovRFBBQXoh
X-Google-Smtp-Source: AGHT+IG+NXgtAOFTuMD8sUi/FN9UVivknYu0Qyq7HpobZftbODTTgrtyHlAYGht12C+WOlOt1shlQA==
X-Received: by 2002:a17:906:250a:b0:a47:623:120a with SMTP id i10-20020a170906250a00b00a470623120amr3409206ejb.71.1711315222926;
        Sun, 24 Mar 2024 14:20:22 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id mc2-20020a170906eb4200b00a47152e6d10sm2318448ejb.134.2024.03.24.14.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:20:22 -0700 (PDT)
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
Subject: [PATCH] x86/percpu: Do not use this_cpu_read_stable_8() for 32 bit targets
Date: Sun, 24 Mar 2024 22:19:45 +0100
Message-ID: <20240324212014.310189-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this_cpu_read_stable() macro uses __pcpu_size_call_return()
that unconditionally calls this_cpu_read_stable_8() also for
32 bit targets. This usage is ivalid as it will result in the
generation of 64 bit MOVQ instruction on 32 bit targets via
percpu_stable_op() macro.

Since there is no generic support for this_cpu_read_stable_8() for
32 bit targets, the patch defines this_cpu_read_stable_8() to
BUILD_BUG() when CONFIG_X86_64 is not defined. This way, we are
sure that this_cpu_read_stable_8() won't actually be used for
32 bit targets, but it is still defined to prevent build failure.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index f6ddbaaf80bc..1f6404e0c428 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -423,10 +423,6 @@ do {									\
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
-#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
-#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
-#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
-#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
@@ -495,6 +491,10 @@ do {									\
 #define this_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
+#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
+#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
+#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
+
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
@@ -546,6 +546,8 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
+#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
+
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
@@ -561,6 +563,9 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
+#else
+/* There is no generic 64 bit read stable operation for 32 bit targets. */
+#define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
 #endif
 
 static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
-- 
2.42.0


