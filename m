Return-Path: <linux-kernel+bounces-39083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54F83CAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995FDB252F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39168134733;
	Thu, 25 Jan 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TTxtzNn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvfv2sRZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF9133983;
	Thu, 25 Jan 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206880; cv=none; b=R7wB+Q0WB8RQCWORD+LfKtfY5PKn4L/WCHBkDlTTJ/MQ8DVvSdlWkQ+p+AL51WzgcjBzBL/Ji+WV6rPjBZhUt23taCpQsqWHkAKC1rsi7OnV9wK+9v4V5bwuRR84P3uQi24jmHwTvmZwo1B5atQazJqKGWrp8DmFY9vcVg0P+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206880; c=relaxed/simple;
	bh=9/i3bkP68fhQln9ksOZI+1RMoK9UoRvjJg6qLLKUDKY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aqlGdqgOfJuFuJn4kdFz9cfnMoZYELR+6j1vMqv+k0gBPIySarXONaA5XjmCXwsSv67ftMZwb9jMAmdHjcBot4SZ95DkVfd8d9yacQU74j3fkduodP4nMdvgK78Wxbjr9lV3+v5OHc0DGAJ4yzx8B5SrKN8tFSwk8SIOJ2rcuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TTxtzNn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvfv2sRZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odfmItu9ii7bshFD1zgZ+iKaiIffEG96qGJUw2rFCu0=;
	b=1TTxtzNnhMjx/WSHc6VEFrR1Z3CpUKgAAtorBBFYtNbP+F3MwBOpmJ0TWsJ+7elBLvW/pR
	iJIYyWodnKC1gmU3STBwFZ/WdTCsT1z9mqte5M1uyjdBANiv3uDNZq1eqbJUuyNAfNDSW1
	RJ48ERjoZBrn+JYEPl+3F09rsEfBmwF7hz6dpHaDd7qW6JSDpSuVenrYli+uVaT6L74tdT
	uIqUoREkU9q2vRBDvg+KvRmDLK01gHDfmuz/MWr5w/9m19Dt+frGZUIXHbYxwqGqaDAUoa
	DYrvuDH6uu7S3ls5RSXhYQS9/pbILW3Y+XV0CiNUudJhMYlGprFnBNIf5BTBfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odfmItu9ii7bshFD1zgZ+iKaiIffEG96qGJUw2rFCu0=;
	b=gvfv2sRZXSvabSyxszFwm5S1rvYHwVip73+qCVYU3YZgV2eTs+/msXfOErNIL3K9DNDbK7
	7d541SuMzn4xOYDQ==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/syscall: Split IDT syscall setup code into
 idt_syscall_init()
Cc: Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-34-xin3.li@intel.com>
References: <20231205105030.8698-34-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620687560.398.9888968561553903874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     10e6d5d2a44789e1a4e57b9fd45c511b4187749b
Gitweb:        https://git.kernel.org/tip/10e6d5d2a44789e1a4e57b9fd45c511b4187749b
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:22 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:33 +01:00

x86/syscall: Split IDT syscall setup code into idt_syscall_init()

Because FRED uses the ring 3 FRED entrypoint for SYSCALL and SYSENTER and
ERETU is the only legit instruction to return to ring 3, there is NO need
to setup SYSCALL and SYSENTER MSRs for FRED, except the IA32_STAR MSR.

Split IDT syscall setup code into idt_syscall_init() to make it easy to
skip syscall setup code when FRED is enabled.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-34-xin3.li@intel.com

---
 arch/x86/kernel/cpu/common.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 204f4c7..399f0d0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2069,10 +2069,8 @@ static void wrmsrl_cstar(unsigned long val)
 		wrmsrl(MSR_CSTAR, val);
 }
 
-/* May not be marked __init: used by software suspend */
-void syscall_init(void)
+static inline void idt_syscall_init(void)
 {
-	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 	if (ia32_enabled()) {
@@ -2106,6 +2104,15 @@ void syscall_init(void)
 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
+/* May not be marked __init: used by software suspend */
+void syscall_init(void)
+{
+	/* The default user and kernel segments */
+	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
+
+	idt_syscall_init();
+}
+
 #else	/* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR

