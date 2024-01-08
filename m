Return-Path: <linux-kernel+bounces-19912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C5827693
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D881F20E38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408555C12;
	Mon,  8 Jan 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OX6Udo8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882855C0A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704735831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t/y+PG9wgXubwHyUj1TLPJKxwJGWndNGxiIdKZ4D+Io=;
	b=OX6Udo8IIp4+pA4NWfZeeHmq9ocH+GsyAr8bvtWr10NxnA/GjynS/WVQ3iqmG4I3rBRmuV
	XDMBDj0zc9FFAMb+1ckBiZX/bfKPsdR+WtwFWdc/21Uj4oPH6KbdK9wMtp1wz3RKjeONB6
	PaCUAyjVMI1B7iXmbTUROeY19HDEXdI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-lfmVdxd-ONSBrFKlmTE0rw-1; Mon, 08 Jan 2024 12:43:48 -0500
X-MC-Unique: lfmVdxd-ONSBrFKlmTE0rw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d455b34723so20176825ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735827; x=1705340627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/y+PG9wgXubwHyUj1TLPJKxwJGWndNGxiIdKZ4D+Io=;
        b=QRzt0pCuvcO+57xWmUIiLooiJ6+EbKjeCcqVHVyPT8/wO4MaA9lOFCVVELkWE7oowU
         YqJG1HvN5jWDQV3oWZuv3hsUwFHEIVGRAfUTZTVhx0LuYBoIH20/mcWoMP9dqSxtqWPs
         fCZ354R1bp5QK6aIbKZDamJv59PIQ8uB/DdL3ZNrm1ONoyP6q1igVMxc6pR7AD9s58sf
         DU99QE251a9W+otJe0DfBXtzwGqykP4t7t1BJ1B9JTGTQXDUrMpPFBHiG9aalg/TIUVi
         ZN7yFOGszwSCr+rHtnv9ZGXHdo1SYn8uvrdlgKM94Z8Z8envS8UUMR4wLCEhd/kLxsK3
         bo6A==
X-Gm-Message-State: AOJu0Yxz5EAyalNlxjB1ZRyr0sBkdBK6SHEBwZJLIaPm4s2hCgq41AaI
	6d9cmZWdlMxJlVnarW7GVBENp2rfRvK1DpVvEbfz/8a52wiKk8vnOPSb9CCyIQnysfPNn9Zvgik
	ovfyqZGgbtzUjcL/8mHVhGsKiLIRDUGtF
X-Received: by 2002:a17:902:ec88:b0:1d4:e234:2a20 with SMTP id x8-20020a170902ec8800b001d4e2342a20mr4880711plg.67.1704735827398;
        Mon, 08 Jan 2024 09:43:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4CTdkRDEAC6hi56wa8KiLF9soDYufPpJbegkIWWFOdvjj5P1vTKeh78U57k/4CJ10BnT+kQ==
X-Received: by 2002:a17:902:ec88:b0:1d4:e234:2a20 with SMTP id x8-20020a170902ec8800b001d4e2342a20mr4880699plg.67.1704735827135;
        Mon, 08 Jan 2024 09:43:47 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902864700b001c755810f89sm161905plt.181.2024.01.08.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:43:46 -0800 (PST)
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
Subject: [PATCH v2 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Date: Mon,  8 Jan 2024 14:43:30 -0300
Message-ID: <20240108174330.472996-2-leobras@redhat.com>
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
---
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


