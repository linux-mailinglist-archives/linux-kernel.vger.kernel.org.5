Return-Path: <linux-kernel+bounces-15754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC5823151
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EDE1F24819
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FAD1C2A5;
	Wed,  3 Jan 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJecUMSG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2A1C283
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704299560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfK6+G/fxpQtUcPr0UJaWEhuvxeP6ij0m8scDlFf7oE=;
	b=dJecUMSGYYED6Ub99gP3RG2KlWmVOZReXJY2YyRZCgPMeDjh7gu4ugkt5cI4ggzZ5wpMN9
	KWAIbdLLa6FZ237jQ31mZ5ePOtdDSPnPwM3/cBASG4h8ZcUgCIQ3C/KkU7h4ahmSoolxRF
	AynmKqHjBB++Q3oyImnVA3+P5LrTkeA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-KjXt99EvN_yqnemIdH6GlA-1; Wed, 03 Jan 2024 11:32:38 -0500
X-MC-Unique: KjXt99EvN_yqnemIdH6GlA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28cb44ab1cbso2281896a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299558; x=1704904358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfK6+G/fxpQtUcPr0UJaWEhuvxeP6ij0m8scDlFf7oE=;
        b=iUrjNK0ZWdh2aBVdyJlvXRDpJgzO0mbBzly0wWIqFaXi6h5462XN8sxHjPbxa0cmml
         7rPq49qTmGwuA3kmWpFv7he5TTPww6vOYKN+IjZfArAt1vIErrM6P0OfCem/cFwem+x2
         Rab2777frIdfVHNUxstboXRoRpwJAOb+FMVnC+G8/eLzYrhUCrC1LlB9aqasgW0ganvJ
         P/cn5bcE3mxep8z9WW2yr4CVdPBIHJo+OtI+xAfLM5xEBH0yOCp/UTPiuNHkacK9VRSg
         CnIDJmp6JnACUpCDS81Se1FLMDOyQSaIqtwqJx2SWBAF6gfEdecCiyYlcUfTLMmgHr/y
         5F9g==
X-Gm-Message-State: AOJu0YwDUsrd6lrlL1ve3Biy4zWuNo0Mq3uJ4TjmHNFzKEZbq96wKCTH
	nWMUiU9dTroK6ugHo3DXtVBjrilk9/v2rlE+z1fyWKbpXlk0QPd6BY2+R1CWE//A0BGry/LX/Bc
	Lek7qscezH5fp4H7yUyLbYAX1pbfAJyoT
X-Received: by 2002:a17:902:f7c9:b0:1d4:79b5:b26 with SMTP id h9-20020a170902f7c900b001d479b50b26mr6275120plw.78.1704299557738;
        Wed, 03 Jan 2024 08:32:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTQgC8TXArNxt0zw+/Ybt1FA1l3Pis1O2gQ6NIBPnJnz+swVe6KE7mMi1vmxykVrwzFBJixQ==
X-Received: by 2002:a17:902:f7c9:b0:1d4:79b5:b26 with SMTP id h9-20020a170902f7c900b001d479b50b26mr6275100plw.78.1704299557400;
        Wed, 03 Jan 2024 08:32:37 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001cfca7b8ee7sm23930425pls.99.2024.01.03.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:32:36 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
Date: Wed,  3 Jan 2024 13:31:59 -0300
Message-ID: <20240103163203.72768-3-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103163203.72768-2-leobras@redhat.com>
References: <20240103163203.72768-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this header every xchg define (_relaxed, _acquire, _release, vanilla)
contain it's own asm file, both for 4-byte variables an 8-byte variables,
on a total of 8 versions of mostly the same asm.

This is usually bad, as it means any change may be done in up to 8
different places.

Unify those versions by creating a new define with enough parameters to
generate any version of the previous 8.

Then unify the result under a more general define, and simplify
arch_xchg* generation.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 138 ++++++-------------------------
 1 file changed, 23 insertions(+), 115 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc2..48478a8eecee7 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,140 +11,48 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
-#define __xchg_relaxed(ptr, new, size)					\
+#define __arch_xchg(sfx, prepend, append, r, p, n)			\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
-
-#define arch_xchg_relaxed(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amoswap" sfx " %0, %2, %1\n"			\
+		append							\
+		: "=r" (r), "+A" (*(p))					\
+		: "r" (n)						\
+		: "memory");						\
 })
 
-#define __xchg_acquire(ptr, new, size)					\
+#define _arch_xchg(ptr, new, sfx, prepend, append)			\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
+	__typeof__(*(__ptr)) __new = (new);				\
+	__typeof__(*(__ptr)) __ret;					\
+	switch (sizeof(*__ptr)) {					\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		__arch_xchg(".w" sfx, prepend, append,			\
+			      __ret, __ptr, __new);			\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		__arch_xchg(".d" sfx, prepend, append,			\
+			      __ret, __ptr, __new);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	__ret;								\
+	(__typeof__(*(__ptr)))__ret;					\
 })
 
-#define arch_xchg_acquire(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+#define arch_xchg_relaxed(ptr, x)					\
+	_arch_xchg(ptr, x, "", "", "")
 
-#define __xchg_release(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+#define arch_xchg_acquire(ptr, x)					\
+	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
-
-#define __arch_xchg(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(ptr, x, ".aqrl", "", "")
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.43.0


