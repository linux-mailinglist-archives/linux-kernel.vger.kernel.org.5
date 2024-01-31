Return-Path: <linux-kernel+bounces-45916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB08437CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DF3282FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45380BF2;
	Wed, 31 Jan 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CnmSkfLl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yk+h2JpV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984E7BB13;
	Wed, 31 Jan 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685691; cv=none; b=YCmBMKOUILcxUxRQxIDWcOg1XtsAECFdyi1kRh/JgtXF7yTcZWHGI4zqKJ7lnx1Z8NhgDC2sDk7xXsNIv2R8UbBCjw0qZ4wpCnTFBhkWYoo/qKcXBpS5q50qcJSAXVrHlV2Jum/oTAF0a6eQ+HIK+MB967TbRx/RdZwsSJFeOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685691; c=relaxed/simple;
	bh=vU+FFWLqVcdQBBaiupJiKyWckQsbPRdEhgxCpB0EYkM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UsfGM3p5+zWMCaKyLyy49ckBRNqRlUALXV6bLfnuaChggjsxrVcQ+sW53K3yJJdztriEFC4Av9oIFk9ZiSmIRvWWkHnxfLyQONYXWfqKg974W9zvs2cug6VkTSEhXgFueUQhabq7K8x8IVNw89HJPevJtLYJTG+rYCH2LH9XNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CnmSkfLl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yk+h2JpV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Z174dZa3qdzY0nihdoV7aj86xcvUp7zoli59i4tzo=;
	b=CnmSkfLllz2kOOjvT6BrqDTHQLG/TLTej7Lr+FCWkr0lNpKpp/68hjVnQLFwZC228KMv+Q
	7ACfwyLKPLHjxIjEbUQ9XJlNCa4gXexQe1+dF4WNctS7n4yPBhmqrQURe/zUFdgIG2tt+V
	VhtsOsH/Zt8lOu71WIQBT/QFm8JnZOPAOaPBFWj2g4VUk/bt9xaGhqiGF+Br9mV0PTAnVF
	PG217MHF8rYxuGiQyUZDY2t7oXah/wSfzEOkR/d44lJ7cbQDoFJPwoPj0G75PeqIOUodt/
	H3ywXp8GSMbDVmDFi1hn90b76M6kYw5Zt8w/+9+rMjjhEkHhpDKoff2/5IsZNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Z174dZa3qdzY0nihdoV7aj86xcvUp7zoli59i4tzo=;
	b=Yk+h2JpVK4P2O/3I8n960NqwueqCqmiUvZUyFzuehIIFlPl/hwBiojor8xhtbxJJmAqLwa
	ajFGu939vXT3HZDw==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/ptrace: Cleanup the definition of the pt_regs structure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-14-xin3.li@intel.com>
References: <20231205105030.8698-14-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668568546.398.15347433609448979642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     ed262541af195f452c43cd4f28310a09065039ec
Gitweb:        https://git.kernel.org/tip/ed262541af195f452c43cd4f28310a09065039ec
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:02 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:34 +01:00

x86/ptrace: Cleanup the definition of the pt_regs structure

struct pt_regs is hard to read because the member or section related
comments are not aligned with the members.

The 'cs' and 'ss' members of pt_regs are type of 'unsigned long' while
in reality they are only 16-bit wide. This works so far as the
remaining space is unused, but FRED will use the remaining bits for
other purposes.

To prepare for FRED:

  - Cleanup the formatting
  - Convert 'cs' and 'ss' to u16 and embed them into an union
    with a u64
  - Fixup the related printk() format strings

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Originally-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-14-xin3.li@intel.com

---
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/include/asm/ptrace.h         | 48 ++++++++++++++++++--------
 arch/x86/kernel/process_64.c          |  2 +-
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e0ca812..a3c0df1 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -76,7 +76,7 @@ static void warn_bad_vsyscall(const char *level, struct pt_regs *regs,
 	if (!show_unhandled_signals)
 		return;
 
-	printk_ratelimited("%s%s[%d] %s ip:%lx cs:%lx sp:%lx ax:%lx si:%lx di:%lx\n",
+	printk_ratelimited("%s%s[%d] %s ip:%lx cs:%x sp:%lx ax:%lx si:%lx di:%lx\n",
 			   level, current->comm, task_pid_nr(current),
 			   message, regs->ip, regs->cs,
 			   regs->sp, regs->ax, regs->si, regs->di);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index f4db78b..b268cd2 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -57,17 +57,19 @@ struct pt_regs {
 #else /* __i386__ */
 
 struct pt_regs {
-/*
- * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
- * unless syscall needs a complete, fully filled "struct pt_regs".
- */
+	/*
+	 * C ABI says these regs are callee-preserved. They aren't saved on
+	 * kernel entry unless syscall needs a complete, fully filled
+	 * "struct pt_regs".
+	 */
 	unsigned long r15;
 	unsigned long r14;
 	unsigned long r13;
 	unsigned long r12;
 	unsigned long bp;
 	unsigned long bx;
-/* These regs are callee-clobbered. Always saved on kernel entry. */
+
+	/* These regs are callee-clobbered. Always saved on kernel entry. */
 	unsigned long r11;
 	unsigned long r10;
 	unsigned long r9;
@@ -77,18 +79,38 @@ struct pt_regs {
 	unsigned long dx;
 	unsigned long si;
 	unsigned long di;
-/*
- * On syscall entry, this is syscall#. On CPU exception, this is error code.
- * On hw interrupt, it's IRQ number:
- */
+
+	/*
+	 * orig_ax is used on entry for:
+	 * - the syscall number (syscall, sysenter, int80)
+	 * - error_code stored by the CPU on traps and exceptions
+	 * - the interrupt number for device interrupts
+	 */
 	unsigned long orig_ax;
-/* Return frame for iretq */
+
+	/* The IRETQ return frame starts here */
 	unsigned long ip;
-	unsigned long cs;
+
+	union {
+		/* The full 64-bit data slot containing CS */
+		u64		csx;
+		/* CS selector */
+		u16		cs;
+	};
+
 	unsigned long flags;
 	unsigned long sp;
-	unsigned long ss;
-/* top of stack page */
+
+	union {
+		/* The full 64-bit data slot containing SS */
+		u64		ssx;
+		/* SS selector */
+		u16		ss;
+	};
+
+	/*
+	 * Top of stack on IDT systems.
+	 */
 };
 
 #endif /* !__i386__ */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b2687..0f78b58 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -117,7 +117,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
 	       log_lvl, fs, fsindex, gs, gsindex, shadowgs);
-	printk("%sCS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
+	printk("%sCS:  %04x DS: %04x ES: %04x CR0: %016lx\n",
 		log_lvl, regs->cs, ds, es, cr0);
 	printk("%sCR2: %016lx CR3: %016lx CR4: %016lx\n",
 		log_lvl, cr2, cr3, cr4);

