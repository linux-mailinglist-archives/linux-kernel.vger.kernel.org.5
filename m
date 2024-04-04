Return-Path: <linux-kernel+bounces-131676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFB898AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94051C23241
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE80224DE;
	Thu,  4 Apr 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tEsCeRxJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yfaZbJHJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE18462;
	Thu,  4 Apr 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243406; cv=none; b=qZ/eqYi95RI/8BmjJixcKBkaswDbs2bd8arqEDZ2Ci73A56B0YrnfuTRxxpZ4rvKBKPw+A8vPyf8pMnT68THrZUjOiQvIkwixHFJbAEmROTKHZhniQtQO5DGJSozBXJUYkF8y+YgzHOX7mfeql2OrUwxXQDptVQ8sJcTxFhdGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243406; c=relaxed/simple;
	bh=sImcZy9gzsz7Ui+Tzrvagua+22Z8PK2Sf/87AIAuMK4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MEbPLTjKkkMcP+oPs10Rn5t+xj++GQoxUX5qLQPeLlxdpwIxu24yGyh/EIPel/0LE0sKk2niv9PgfPazIVp8r/Oxbb4cSvWIDagCgn5C05g5rJgP1DDAvU7Xi5vfJuLVWERhGvWaqzP8CVW7nHL6swHv1WSPSJiZimvHojZkBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tEsCeRxJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yfaZbJHJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 15:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712243400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZKvnRETMwp3vRHbubTwJKIHeHj7/93DuJZEp8NapvE=;
	b=tEsCeRxJ9ogbrtTv4gSSeqZ32cSN6gGo7pJ0Sw95hjPKCH46oG1XaJki8LchUKIfnjurSD
	jxJNI04Ozuuy3AC4HlbX4lv0qsPKWaLRDJmGWtZT9jXMjUk1nx623QsrVOzRwNgnWe1p61
	nVCS4BIDJ97sVzsgd1tXF+kTd19UY/eUFlR9mskhd7h7nHwGfi5+lPWovkX05vs12P2k+E
	YmfEC/FsfaQx17Bk6fLu+gurMOXlnYrZSukSgmopFw8zFWtUqimg/hKDKId54AvWrdQEYd
	VE1K7QiP9IRRniB4Tg3OppmMZ/F57ZwvGfdQcPjCeu58No5+0l7e/dYbFTgDTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712243400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZKvnRETMwp3vRHbubTwJKIHeHj7/93DuJZEp8NapvE=;
	b=yfaZbJHJOxxfQrkAJK3vepWEOKrwlj7KH083xj5JuEUrd7tD9u2UUHofhldTjvm4PoUDqR
	z8wf1cQpozFNsaBA==
From: "tip-bot2 for Tong Tiangen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/extable: Remove unused fixup type EX_TYPE_COPY
Cc: Tong Tiangen <tongtiangen@huawei.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240204082627.3892816-2-tongtiangen@huawei.com>
References: <20240204082627.3892816-2-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171224339947.10875.6370842297740311104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     cb517619f96718a4c3c2534a3124177633f8998d
Gitweb:        https://git.kernel.org/tip/cb517619f96718a4c3c2534a3124177633f8998d
Author:        Tong Tiangen <tongtiangen@huawei.com>
AuthorDate:    Sun, 04 Feb 2024 16:26:25 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Apr 2024 17:01:40 +02:00

x86/extable: Remove unused fixup type EX_TYPE_COPY

After

  034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")

rewrote __copy_user_nocache() to use EX_TYPE_UACCESS instead of the
EX_TYPE_COPY exception type, there are no more EX_TYPE_COPY users, so
remove it.

  [ bp: Massage commit message. ]

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240204082627.3892816-2-tongtiangen@huawei.com
---
 arch/x86/include/asm/asm.h                 |  3 ---
 arch/x86/include/asm/extable_fixup_types.h |  2 +-
 arch/x86/kernel/cpu/mce/severity.c         |  1 -
 arch/x86/mm/extable.c                      |  9 ---------
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index ca8eed1..2bec0c8 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -229,9 +229,6 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_UACCESS)
 
-#define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_COPY)
-
 #define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
 
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 7acf038..906b0d5 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -36,7 +36,7 @@
 #define	EX_TYPE_DEFAULT			 1
 #define	EX_TYPE_FAULT			 2
 #define	EX_TYPE_UACCESS			 3
-#define	EX_TYPE_COPY			 4
+/* unused, was: #define EX_TYPE_COPY	 4 */
 #define	EX_TYPE_CLEAR_FS		 5
 #define	EX_TYPE_FPU_RESTORE		 6
 #define	EX_TYPE_BPF			 7
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c447716..bca780f 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -290,7 +290,6 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
-	case EX_TYPE_COPY:
 		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b522933..51986e8 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -164,13 +164,6 @@ static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
-static bool ex_handler_copy(const struct exception_table_entry *fixup,
-			    struct pt_regs *regs, int trapnr)
-{
-	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_fault(fixup, regs, trapnr);
-}
-
 static bool ex_handler_msr(const struct exception_table_entry *fixup,
 			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
@@ -341,8 +334,6 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
 		return ex_handler_uaccess(e, regs, trapnr, fault_addr);
-	case EX_TYPE_COPY:
-		return ex_handler_copy(e, regs, trapnr);
 	case EX_TYPE_CLEAR_FS:
 		return ex_handler_clear_fs(e, regs);
 	case EX_TYPE_FPU_RESTORE:

