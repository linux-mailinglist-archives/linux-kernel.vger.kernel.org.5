Return-Path: <linux-kernel+bounces-51323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D615D8489CC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F631C222EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218D4168D2;
	Sat,  3 Feb 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PkoY5khO"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA516419;
	Sat,  3 Feb 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707004379; cv=none; b=FKr+QChgmXHJIKSQWvqItiEuDsTOyNhrCs7y5kO81E85FRASQtTt5r67dndLxaSZ6EFiumEU+KzsuA7JKWDkhutAvt/qPmeCzumPfj5FKMjnrG59hTvAeoA/ifUUQS0FrYYFGYbDig08aWZcqr+82OZ/JnB6racf/WCicqVAUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707004379; c=relaxed/simple;
	bh=fz3j3T6QBp4Co5opmQJUwlfOz3/9l9WqB/vGWuczmJE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KYAW8r1NDCfkUde6/QRZmDJa87DxbVlnI0UDJFtubcOqJ6azbnL2hKsGqk6fou1im2zUKb8Ny2tn/jb42RtWR8+OmhulRx5/FrCs9Qp8lWyT2NIMY5MP+EcF9AF0WLR9zok4N8MwWVGf5dwo6yGwv2jv7+DIZWpI537kM9g/s5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PkoY5khO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 413Nq5HW1146943
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 3 Feb 2024 15:52:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 413Nq5HW1146943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1707004327;
	bh=YF/9iFZbpkbzabBhj9h8rnC37CjWzXFTXAyjgT+GBTg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PkoY5khOBtvim52E7ockk/qEKs2cw2L0Ru8WUrNPV0WR3n79gOxxguuiJTMhuzvrD
	 17dm2oobT+TtLFsVMfliXUlgyfo/KuA9iMIZynfFOVUR5KyzNdmBolfL1t0hCMS5S1
	 9qTftaox1Pj+jWIl+ULeI1zWGdbs5bAiO06vjW51WxUz4yqO1ZtsLintORHpEPRCia
	 7aV+xevQqi2gV8qawcrE8m6AdDzSAdCryQMntD6hFu2gzwPce4NM7RkAg3CP0iyRf/
	 9S8c3ESa7fY0RFEWrvVxMLjxGvoZDmF+HfjcHQiIQIgkyJ31fvZBch4UXAPfRDFNNm
	 I2KgvPuzjf13g==
Date: Sat, 03 Feb 2024 15:52:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, tip-bot2 for Xin Li <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Shan Kang <shan.kang@intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/fred=5D_x86/ptrace=3A_Cleanup?= =?US-ASCII?Q?_the_definition_of_the_pt=5Fregs_structure?=
User-Agent: K-9 Mail for Android
In-Reply-To: <170673569232.398.15041548048531772130.tip-bot2@tip-bot2>
References: <20231205105030.8698-14-xin3.li@intel.com> <170673569232.398.15041548048531772130.tip-bot2@tip-bot2>
Message-ID: <2A59D51B-0AA0-4DFC-9957-67CC0C9E37B3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 31, 2024 1:14:52 PM PST, tip-bot2 for Xin Li <tip-bot2@linutroni=
x=2Ede> wrote:
>The following commit has been merged into the x86/fred branch of tip:
>
>Commit-ID:     ee63291aa8287cb7ded767d340155fe8681fc075
>Gitweb:        https://git=2Ekernel=2Eorg/tip/ee63291aa8287cb7ded767d3401=
55fe8681fc075
>Author:        Xin Li <xin3=2Eli@intel=2Ecom>
>AuthorDate:    Tue, 05 Dec 2023 02:50:02 -08:00
>Committer:     Borislav Petkov (AMD) <bp@alien8=2Ede>
>CommitterDate: Wed, 31 Jan 2024 22:01:13 +01:00
>
>x86/ptrace: Cleanup the definition of the pt_regs structure
>
>struct pt_regs is hard to read because the member or section related
>comments are not aligned with the members=2E
>
>The 'cs' and 'ss' members of pt_regs are type of 'unsigned long' while
>in reality they are only 16-bit wide=2E This works so far as the
>remaining space is unused, but FRED will use the remaining bits for
>other purposes=2E
>
>To prepare for FRED:
>
>  - Cleanup the formatting
>  - Convert 'cs' and 'ss' to u16 and embed them into an union
>    with a u64
>  - Fixup the related printk() format strings
>
>Suggested-by: Thomas Gleixner <tglx@linutronix=2Ede>
>Originally-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>Signed-off-by: Thomas Gleixner <tglx@linutronix=2Ede>
>Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>Tested-by: Shan Kang <shan=2Ekang@intel=2Ecom>
>Link: https://lore=2Ekernel=2Eorg/r/20231205105030=2E8698-14-xin3=2Eli@in=
tel=2Ecom
>---
> arch/x86/entry/vsyscall/vsyscall_64=2Ec |  2 +-
> arch/x86/include/asm/ptrace=2Eh         | 48 ++++++++++++++++++--------
> arch/x86/kernel/process_64=2Ec          |  2 +-
> 3 files changed, 37 insertions(+), 15 deletions(-)
>
>diff --git a/arch/x86/entry/vsyscall/vsyscall_64=2Ec b/arch/x86/entry/vsy=
scall/vsyscall_64=2Ec
>index e0ca812=2E=2Ea3c0df1 100644
>--- a/arch/x86/entry/vsyscall/vsyscall_64=2Ec
>+++ b/arch/x86/entry/vsyscall/vsyscall_64=2Ec
>@@ -76,7 +76,7 @@ static void warn_bad_vsyscall(const char *level, struct=
 pt_regs *regs,
> 	if (!show_unhandled_signals)
> 		return;
>=20
>-	printk_ratelimited("%s%s[%d] %s ip:%lx cs:%lx sp:%lx ax:%lx si:%lx di:%=
lx\n",
>+	printk_ratelimited("%s%s[%d] %s ip:%lx cs:%x sp:%lx ax:%lx si:%lx di:%l=
x\n",
> 			   level, current->comm, task_pid_nr(current),
> 			   message, regs->ip, regs->cs,
> 			   regs->sp, regs->ax, regs->si, regs->di);
>diff --git a/arch/x86/include/asm/ptrace=2Eh b/arch/x86/include/asm/ptrac=
e=2Eh
>index f4db78b=2E=2Eb268cd2 100644
>--- a/arch/x86/include/asm/ptrace=2Eh
>+++ b/arch/x86/include/asm/ptrace=2Eh
>@@ -57,17 +57,19 @@ struct pt_regs {
> #else /* __i386__ */
>=20
> struct pt_regs {
>-/*
>- * C ABI says these regs are callee-preserved=2E They aren't saved on ke=
rnel entry
>- * unless syscall needs a complete, fully filled "struct pt_regs"=2E
>- */
>+	/*
>+	 * C ABI says these regs are callee-preserved=2E They aren't saved on
>+	 * kernel entry unless syscall needs a complete, fully filled
>+	 * "struct pt_regs"=2E
>+	 */
> 	unsigned long r15;
> 	unsigned long r14;
> 	unsigned long r13;
> 	unsigned long r12;
> 	unsigned long bp;
> 	unsigned long bx;
>-/* These regs are callee-clobbered=2E Always saved on kernel entry=2E */
>+
>+	/* These regs are callee-clobbered=2E Always saved on kernel entry=2E *=
/
> 	unsigned long r11;
> 	unsigned long r10;
> 	unsigned long r9;
>@@ -77,18 +79,38 @@ struct pt_regs {
> 	unsigned long dx;
> 	unsigned long si;
> 	unsigned long di;
>-/*
>- * On syscall entry, this is syscall#=2E On CPU exception, this is error=
 code=2E
>- * On hw interrupt, it's IRQ number:
>- */
>+
>+	/*
>+	 * orig_ax is used on entry for:
>+	 * - the syscall number (syscall, sysenter, int80)
>+	 * - error_code stored by the CPU on traps and exceptions
>+	 * - the interrupt number for device interrupts
>+	 */
> 	unsigned long orig_ax;
>-/* Return frame for iretq */
>+
>+	/* The IRETQ return frame starts here */
> 	unsigned long ip;
>-	unsigned long cs;
>+
>+	union {
>+		/* The full 64-bit data slot containing CS */
>+		u64		csx;
>+		/* CS selector */
>+		u16		cs;
>+	};
>+
> 	unsigned long flags;
> 	unsigned long sp;
>-	unsigned long ss;
>-/* top of stack page */
>+
>+	union {
>+		/* The full 64-bit data slot containing SS */
>+		u64		ssx;
>+		/* SS selector */
>+		u16		ss;
>+	};
>+
>+	/*
>+	 * Top of stack on IDT systems=2E
>+	 */
> };
>=20
> #endif /* !__i386__ */
>diff --git a/arch/x86/kernel/process_64=2Ec b/arch/x86/kernel/process_64=
=2Ec
>index 33b2687=2E=2E0f78b58 100644
>--- a/arch/x86/kernel/process_64=2Ec
>+++ b/arch/x86/kernel/process_64=2Ec
>@@ -117,7 +117,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs=
_mode mode,
>=20
> 	printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
> 	       log_lvl, fs, fsindex, gs, gsindex, shadowgs);
>-	printk("%sCS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
>+	printk("%sCS:  %04x DS: %04x ES: %04x CR0: %016lx\n",
> 		log_lvl, regs->cs, ds, es, cr0);
> 	printk("%sCR2: %016lx CR3: %016lx CR4: %016lx\n",
> 		log_lvl, cr2, cr3, cr4);

Incidentally, the comment about callee-saved registers is long since both =
obsolete and is now outright wrong=2E

The next version of gcc (14 I think) will have an attribute to turn off sa=
ving registers which we can use for top-level C functions=2E

