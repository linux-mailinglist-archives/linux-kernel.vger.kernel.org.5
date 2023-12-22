Return-Path: <linux-kernel+bounces-9461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACD81C5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9906284F88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B4FC09;
	Fri, 22 Dec 2023 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOqgnlPb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB0FBF2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703231204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fChu8SySxAk9bR4FCWD8rViiukJB4FWPqrqCbBPM0wY=;
	b=VOqgnlPb7koRbqdmNp7zwu4MFdgWKsXehtMUmpNMvOac54cUPnSl/uTy5tLGf9Y7RqzRKb
	wkIddCPpfTGOYVY22/9SvoHv96YJWg8M1sIeV4spTUWg28A7C5M0nyV62OvRiGA9qALJTv
	i6Agmad/bUVySI3vGrIsFSTyBQuRvuk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ov2EwXhaOC6oJINNVIaiXQ-1; Fri, 22 Dec 2023 02:46:43 -0500
X-MC-Unique: ov2EwXhaOC6oJINNVIaiXQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9dff5942fso1730067b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703231202; x=1703836002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fChu8SySxAk9bR4FCWD8rViiukJB4FWPqrqCbBPM0wY=;
        b=fuD38Irh04LN21FU7P9Y8saUaoEOQ0P6CJ1fsZGulplvuYiS9oxdsMnd66Qyp1mrgv
         hcIxSuozNpwBteZKwuDpUTYxvIQ37VJPNs8k2KwtFwXavQopQXGNAfcEjHxXwMQwehKY
         LrPxWjIzmNn/8WT1ZAHoo+CvnHfIKjOPzXCQ/MZ0xZpEH/y+qnBJ+nmMyopFo7pKrhcw
         7u3KU+jelJ8zs9zrmUIyv47+RxaxUhpmjEcSaawDEv283p7N5i5m5nF+n1rOheJcEOMG
         7r8wisiJOBi6pf58vD/eio6CQtYcSh2O+k+/zEFquqzrEt6zB8GgPOo3BicMdQ7r+nS5
         CKXw==
X-Gm-Message-State: AOJu0YwuNXEyrMquWHQIoIJJIIgCr/QiJLKmOx8pzoUiBt+SPpDKbcmo
	kiL9mxN7Suat7HvCZw15G790Nv8X7W/va2FBR9PPvaYcOAoeSowuBs+ZkpE9BbmsihPOwSu84RD
	myTk/ZH+Jtk3rpruXf93L3oquZuFtKv5U
X-Received: by 2002:a05:6808:199e:b0:3af:9838:8494 with SMTP id bj30-20020a056808199e00b003af98388494mr1174140oib.20.1703231202597;
        Thu, 21 Dec 2023 23:46:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfty2NP0/+vK/Z37DtQxU8NTNsz0hOUOMzPkaafOkXIkbGg41CPwcD8fDjKPqNGVFT8AzCRw==
X-Received: by 2002:a05:6808:199e:b0:3af:9838:8494 with SMTP id bj30-20020a056808199e00b003af98388494mr1174135oib.20.1703231202376;
        Thu, 21 Dec 2023 23:46:42 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm1527015pfh.21.2023.12.21.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:46:41 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greg Ungerer <gerg@kernel.org>,
	Vincent Chen <vincent.chen@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] riscv: add compile-time test into is_compat_task()
Date: Fri, 22 Dec 2023 04:46:02 -0300
Message-ID: <20231222074605.452452-3-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222074605.452452-1-leobras@redhat.com>
References: <20231222074605.452452-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently several places will test for CONFIG_COMPAT before testing
is_compat_task(), probably in order to avoid a run-time test into the task
structure.

Since is_compat_task() is an inlined function, it would be helpful to add a
compile-time test of CONFIG_COMPAT, making sure it always returns zero when
the option is not enabled during the kernel build.

With this, the compiler is able to understand in build-time that
is_compat_task() will always return 0, and optimize-out some of the extra
code introduced by the option.

This will also allow removing a lot #ifdefs that were introduced, and make
the code more clean.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/compat.h    | 3 +++
 arch/riscv/include/asm/elf.h       | 4 ----
 arch/riscv/include/asm/pgtable.h   | 6 ------
 arch/riscv/include/asm/processor.h | 4 ++--
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index 2ac955b51148f..91517b51b8e27 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -14,6 +14,9 @@
 
 static inline int is_compat_task(void)
 {
+	if (!IS_ENABLED(CONFIG_COMPAT))
+		return 0;
+
 	return test_thread_flag(TIF_32BIT);
 }
 
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 59a08367fddd7..2e88257cafaea 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -53,13 +53,9 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
 #define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
 
 #ifdef CONFIG_64BIT
-#ifdef CONFIG_COMPAT
 #define STACK_RND_MASK		(is_compat_task() ? \
 				 0x7ff >> (PAGE_SHIFT - 12) : \
 				 0x3ffff >> (PAGE_SHIFT - 12))
-#else
-#define STACK_RND_MASK		(0x3ffff >> (PAGE_SHIFT - 12))
-#endif
 #endif
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1d472b31e0cfe..ea5b269be223a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -127,16 +127,10 @@
 #define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
 #define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
 
-#ifdef CONFIG_COMPAT
 #define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
 #define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
 #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
 #define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN_VA_BITS_64)
-#else
-#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
-#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
-#endif /* CONFIG_COMPAT */
-
 #else
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda549..ed32e53e55999 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -22,7 +22,7 @@
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 || is_compat_task())			\
 		mmap_end = STACK_TOP_MAX;			\
 	else if ((_addr) >= VA_USER_SV57)			\
 		mmap_end = STACK_TOP_MAX;			\
@@ -39,7 +39,7 @@
 	typeof(addr) _addr = (addr);				\
 	typeof(base) _base = (base);				\
 	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 || is_compat_task())			\
 		mmap_base = (_base);				\
 	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
 		mmap_base = VA_USER_SV57 - rnd_gap;		\
-- 
2.43.0


