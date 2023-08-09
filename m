Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEC7750CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHICOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHICOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93954FE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691547239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cG8axZDwBuWJQ+k2FsV81xz+WKLWi2QNSuhJ6eUeaqw=;
        b=XRqnmWPyTZYG31ea3SCYHl3lm2SMlU82Zqp23COwH9n6Ot0i1EYPjLdvcZcbjSjjxcNFkU
        MWfQ25+nVqNa5hzksLlQjSEMPBkUk68AybqxFPQujSTSsOXsJxOPUvCh0IJIjaxuBM/VWF
        ndBbvaPhP294EiqjVupEGHNrvpZumyE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-WdnLxjy4MlijCfrkKkqyEg-1; Tue, 08 Aug 2023 22:13:58 -0400
X-MC-Unique: WdnLxjy4MlijCfrkKkqyEg-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9cf208fb5so11856780a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547238; x=1692152038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG8axZDwBuWJQ+k2FsV81xz+WKLWi2QNSuhJ6eUeaqw=;
        b=hxbStUsIy3XFvyjQ23gqWiVmpxGsN7VuiCPA3O7voJmbbITR7gRTSt3TFkJh9PTjxZ
         R7oHdXQ5aklQFEdQshksQKMgUJhDp4HLTjtOutS7w0Ua1dAS9/06wOHL+C2YyJ2IE4g9
         ZiHHsMvWWaxyUZ0XNH+2j8NB0C00LUBYMbHhKHlYKL9NTIawhNeay353JDktoISGjmO9
         SKnEe6MgsJCYep9CzEH2oh5yFbY7ZVt3Se+NKepRyoD6Q09ZjOSdwD531gPeLb/nz+Hz
         aHuLZZwTt8T6atZXlw7lg3yOQIxa1faFUBnyn0VjcRuP+ued3QVItKd4TXJLx0dKjax5
         pgRw==
X-Gm-Message-State: AOJu0Yzd9Pw841GNPyovIeApTBNI67orY/FRClY+V5Q/lLEZSPUz2FRu
        zIH+kAKz4gEzEoFAd5xESAfcKYF+H5NRatTPI3GKFxAu2WKQwYb6PfbpeNCQCbMOd5HyFj8MjYh
        ANKvGw1MNUXoWUSLLgyKkOT6/
X-Received: by 2002:a05:6870:c084:b0:1bf:4f5e:55e2 with SMTP id c4-20020a056870c08400b001bf4f5e55e2mr1543844oad.53.1691547237749;
        Tue, 08 Aug 2023 19:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHukU42SPYGuHy2oEtAblgnpaB5UkpskCwb9snxi5LMKs5NyCZyz7VTISypO0xyDpTH5uoIvA==
X-Received: by 2002:a05:6870:c084:b0:1bf:4f5e:55e2 with SMTP id c4-20020a056870c08400b001bf4f5e55e2mr1543823oad.53.1691547237498;
        Tue, 08 Aug 2023 19:13:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a8c4a000000b0054fba751207sm6475518ooj.47.2023.08.08.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:13:57 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v4 1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
Date:   Tue,  8 Aug 2023 23:13:06 -0300
Message-ID: <20230809021311.1390578-3-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809021311.1390578-2-leobras@redhat.com>
References: <20230809021311.1390578-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/cmpxchg.h | 136 +++++--------------------------
 1 file changed, 22 insertions(+), 114 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..ec4ea4f3f908 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,60 +11,30 @@
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
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __new = (new);				\
 	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
+	__typeof__(ptr) __ptr = (ptr);					\
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
@@ -72,79 +42,17 @@
 	__ret;								\
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
2.41.0

