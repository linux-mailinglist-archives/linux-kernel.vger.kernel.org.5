Return-Path: <linux-kernel+bounces-15727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E50B8230F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2A21C23AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091861C69D;
	Wed,  3 Jan 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hyev5JrI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CEC1C68C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704297675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGw3FQc0MsxvF9cxW/ZiV7CdITqr1kZ41Lg1YYp8Ods=;
	b=Hyev5JrI71MCrypwih4t/R3xlh+z/Sb0+CUt75TuEUS8bcTzdkdyW4YkzpJfTqQJfHMHcJ
	Pb8lnKzVTUITGcD9WgNlmqh5W+QIE5umLyZ8ubcxxz2xHgHhkvEvo+uKYx1GlrQK5ikCn0
	NgJxTmrlXm9hj6nBa1i7GqEul2Ab0n0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-au0_v23hOIiGVBp0dQsiww-1; Wed, 03 Jan 2024 11:01:14 -0500
X-MC-Unique: au0_v23hOIiGVBp0dQsiww-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bbe965866so6292799a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297673; x=1704902473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGw3FQc0MsxvF9cxW/ZiV7CdITqr1kZ41Lg1YYp8Ods=;
        b=Vp302bg6DSNi8/8wi3A9YuTykmK9guxSrKedperVQlcmHRBIhiGwShb3LzQjdoOUvB
         xIaxUNa1Tzes6LIhE9LdjqrPpYmn30T7jPmkm7vQm1XP1QdDOZW46pSvBZqLIR5TscTx
         n0KIGhcVuZRbHzmLHvyFqbISDHPiMzTXgMtANL3jcXtIe9Ya+2NVzAaSQL28GJRJmfXh
         a0U4IopXFO0pOCpZyXlAjkmd59FBqclJG052K+fKTNgdDfd5DYLGVAIKmbO9eWfTP3JS
         xpehWyfHcMZ2hzr9qX+fz67L1McRj6pL8V/oIObh7OUF/yRvh8rXxNSZUPHXQoPRIxNK
         corw==
X-Gm-Message-State: AOJu0YwF2LRh2KsXRHoOhcp8Nala1RUf/ZhiTVvwgNTqogSsQTUae5pH
	4R7xAvXgZ9OTd+OoWLrvv0SnpfrO5SpbiCUqMx7DULbZZNm7OFH6RwUly0NPlLe8BotbFbrUYBV
	jKTd+QESCid9jjbqq6l8FKKD+FH+P1/fP
X-Received: by 2002:a17:90b:4f82:b0:28b:cf7f:3f17 with SMTP id qe2-20020a17090b4f8200b0028bcf7f3f17mr6279187pjb.77.1704297673446;
        Wed, 03 Jan 2024 08:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2RComsIUtAWCzXZpT7ImLMVrEUH4zz96VXv/Gywk03MIGNb3i0+fYpKYCJQlz+rbFDL1dHg==
X-Received: by 2002:a17:90b:4f82:b0:28b:cf7f:3f17 with SMTP id qe2-20020a17090b4f8200b0028bcf7f3f17mr6279141pjb.77.1704297672832;
        Wed, 03 Jan 2024 08:01:12 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id qc8-20020a17090b288800b0028b1fce7c01sm1922253pjb.37.2024.01.03.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:01:12 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Greg Ungerer <gerg@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Greentime Hu <greentime.hu@sifive.com>,
	Baoquan He <bhe@redhat.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 3/5] riscv: add compile-time test into is_compat_task()
Date: Wed,  3 Jan 2024 13:00:21 -0300
Message-ID: <20240103160024.70305-5-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103160024.70305-2-leobras@redhat.com>
References: <20240103160024.70305-2-leobras@redhat.com>
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
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
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
index 2278e2a8362af..d2d7ce30baf3e 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -28,7 +28,7 @@
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 || is_compat_task())			\
 		mmap_end = STACK_TOP_MAX;			\
 	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
 		mmap_end = VA_USER_SV57;			\
@@ -45,7 +45,7 @@
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


