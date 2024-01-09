Return-Path: <linux-kernel+bounces-20346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AFB827D88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C08D1C212B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B122063;
	Tue,  9 Jan 2024 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjuUvOaz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FE1D682
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704772185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9pcW2dMN2ZTTnbNrLvy1EmevrgR/jRo6sIe8/KvAytk=;
	b=GjuUvOazyXLNoy/6msZw9IREua6PKK+ce0V5uTPctYP9zVjApFyh2QwYuv8hKOK7M0dHB+
	GquyLnx/RbUPxf/EbVsLyqSOOca6jP7C6zrUow3yqlHAWtIuBfmq16kuUCPDgKvFuvYYIp
	ybHcpME+nqv4LzPpg8qYzfbgru5X+qg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-lUvvM_PhP4aXcr1wFC-03w-1; Mon, 08 Jan 2024 22:49:38 -0500
X-MC-Unique: lUvvM_PhP4aXcr1wFC-03w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6800e52d47aso65921606d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704772178; x=1705376978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pcW2dMN2ZTTnbNrLvy1EmevrgR/jRo6sIe8/KvAytk=;
        b=JRJ560UYI3PGPRdYZXHA55zX8y062lFSzDxuuM5t8GM2bWDAiJOzVr3DVfEPHDvGs1
         chXjbAxMD1ovLHvZXYb++4B3LYVtNNjogxy5Xt39KFrJNtIjwLrNjOw8DrqbspMDjuS/
         7L2o7+xuMArYncrVPX+Vx3Ui9b2kxy6siMceqLiGpxLDJvcYTZkHAN57rJbujDetjWgi
         9uaLHDI3zE2KQCBSW+ABh27Yg0hyb0l7xzsK+9haHIaDU6dNdzZNLnIE6PqV7KyBWK5U
         ZOreoRO9phCtfznWlY/UIJyYFyhYTe0fNRLBHj1S8NjKbUxuRuIUsZR+yb0i4yFnBCsU
         EJ2Q==
X-Gm-Message-State: AOJu0Yy8zZ1cQBKlKMdG4JDEd6Y/tU0Q+xR7LGBvexvGXVBRSPZfcEih
	WJpk5t1K6ZATsZluub12xZjXKGAx9jrqZ1KezA9PDDo7UNr/CSH/iCUyaBI1bP+49Vaj8Ep5Ld+
	NqQV0mb/7aFdCNG02YHkz4f9smRMm9I7h
X-Received: by 2002:a05:6214:e67:b0:680:d06b:6734 with SMTP id jz7-20020a0562140e6700b00680d06b6734mr157673qvb.4.1704772178012;
        Mon, 08 Jan 2024 19:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgO6lHdt9lUqFyrJyBCNn6MpcN9eeknRp+QwwMqF1QJVBsyy9aCS5Siiq8Ba4VTJaFfMSnWg==
X-Received: by 2002:a05:6214:e67:b0:680:d06b:6734 with SMTP id jz7-20020a0562140e6700b00680d06b6734mr157669qvb.4.1704772177747;
        Mon, 08 Jan 2024 19:49:37 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id b4-20020a056214114400b0067f7c11651esm545117qvt.128.2024.01.08.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:49:37 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Guo Hui <guohui@uniontech.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Date: Tue,  9 Jan 2024 00:46:50 -0300
Message-ID: <20240109034651.478462-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently some parts of the codebase will test for CONFIG_COMPAT before
testing is_compat_task().

is_compat_task() is a inlined function only present on CONFIG_COMPAT.
On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:

 #define is_compat_task() (0)

Since we have this define available in every usage of is_compat_task() for
!CONFIG_COMPAT, it's unnecessary to keep the ifdefs, since the compiler is
smart enough to optimize-out those snippets on CONFIG_COMPAT=n

This requires some regset code as well as a few other defines to be made
available on !CONFIG_COMPAT, so some symbols can get resolved before
getting optimized-out.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
Changes since v2:
- Added Reviewd-by from Arnd
Link: https://lore.kernel.org/all/20240108174330.472996-2-leobras@redhat.com/

Changes since v1:
- Move some regset code and other defines outside of CONFIG_COMPAT
- Closes: https://lore.kernel.org/oe-kbuild-all/202401061219.Y2LD7LTx-lkp@intel.com/
Link: https://lore.kernel.org/all/20240105041458.126602-3-leobras@redhat.com/

Changes since RFCv1:
- Removed unnecessary new inlined is_compat_task() for arm64
- Adjusted commit text and title
Link: https://lore.kernel.org/all/20240104192433.109983-2-leobras@redhat.com/

 arch/arm64/include/asm/elf.h    | 10 +++++-----
 arch/arm64/include/asm/fpsimd.h |  2 --
 arch/arm64/kernel/ptrace.c      |  8 +++-----
 arch/arm64/kernel/syscall.c     |  5 +----
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 97932fbf973d1..3f93f4eef9530 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -201,16 +201,16 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define COMPAT_ELF_PLATFORM		("v8l")
 #endif
 
-#ifdef CONFIG_COMPAT
-
-/* PIE load location for compat arm. Must match ARM ELF_ET_DYN_BASE. */
-#define COMPAT_ELF_ET_DYN_BASE		0x000400000UL
-
 /* AArch32 registers. */
 #define COMPAT_ELF_NGREG		18
 typedef unsigned int			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
+#ifdef CONFIG_COMPAT
+
+/* PIE load location for compat arm. Must match ARM ELF_ET_DYN_BASE. */
+#define COMPAT_ELF_ET_DYN_BASE		0x000400000UL
+
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
 int compat_elf_check_arch(const struct elf32_hdr *);
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50e5f25d3024c..94c7ed82fbada 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -21,7 +21,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_COMPAT
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
 #define VFP_FPSCR_STAT_MASK	0xf800009f
 #define VFP_FPSCR_CTRL_MASK	0x07f79f00
@@ -30,7 +29,6 @@
  * control/status register.
  */
 #define VFP_STATE_SIZE		((32 * 8) + 4)
-#endif
 
 static inline unsigned long cpacr_save_enable_kernel_sve(void)
 {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 20d7ef82de90a..27efd66fc1e93 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -173,7 +173,6 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
 	const char *desc = "Hardware breakpoint trap (ptrace)";
 
-#ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
 		int si_errno = 0;
 		int i;
@@ -195,7 +194,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 						  desc);
 		return;
 	}
-#endif
+
 	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT, bkpt->trigger, desc);
 }
 
@@ -1594,7 +1593,6 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_COMPAT
 enum compat_regset {
 	REGSET_COMPAT_GPR,
 	REGSET_COMPAT_VFP,
@@ -1851,6 +1849,7 @@ static const struct user_regset_view user_aarch32_ptrace_view = {
 	.regsets = aarch32_ptrace_regsets, .n = ARRAY_SIZE(aarch32_ptrace_regsets)
 };
 
+#ifdef CONFIG_COMPAT
 static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 				   compat_ulong_t __user *ret)
 {
@@ -2112,7 +2111,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
 	/*
 	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
 	 * user_aarch32_view compatible with arm32. Native ptrace requests on
@@ -2123,7 +2121,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 		return &user_aarch32_view;
 	else if (is_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
-#endif
+
 	return &user_aarch64_view;
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a70d9746b661..ad198262b9817 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -20,14 +20,11 @@ long sys_ni_syscall(void);
 
 static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
-#ifdef CONFIG_COMPAT
-	long ret;
 	if (is_compat_task()) {
-		ret = compat_arm_syscall(regs, scno);
+		long ret = compat_arm_syscall(regs, scno);
 		if (ret != -ENOSYS)
 			return ret;
 	}
-#endif
 
 	return sys_ni_syscall();
 }
-- 
2.43.0


