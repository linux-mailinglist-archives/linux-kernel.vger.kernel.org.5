Return-Path: <linux-kernel+bounces-47119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4533B844991
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011AF2863AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC839AE0;
	Wed, 31 Jan 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owgDdNTY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ie/k3Wit"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA439AC4;
	Wed, 31 Jan 2024 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735684; cv=none; b=XtoZ5axqAs/yzrhTVEwfYGHC5lgSMsxp0Hj9b/pF/TwClHjt3+gxhz4o+m3YcveVFD1qcv1DfWC9Xr3uOL/IU6/iziugIAPkA1zf8UW2s7wDebCG43H6qeAa9wvR+gU9gVAnAKZWPHO5qfSQdyTYpLxbX6+Ed0uTzmenFGoy/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735684; c=relaxed/simple;
	bh=1M7vKg5/n4IZMXS9oIodFBZYjSx6j7zZWYCaOuydzhw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JZb37VCwmqIO33VuXY6X8CzxgSyJx1edX0X1IeE+S1rIvPJ7f/Fb0wSvWwjqJL7L4fos99G/CpABdXc1Dvpw3HaDzaO0offuIckv+bSB+gfXXJWLuZZF33yJR9NR7TsKrhVNfQj72iEnTlNVphwwfXmcvvd/VzlLKUG0RfDAZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owgDdNTY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie/k3Wit; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhaC+iV2gf1ylvkDk4qpde6TEuwsgkVlMwuZKh2PwKY=;
	b=owgDdNTYrM1f9HDVVG+HP0Znmi74jj89LZ6feVnBa9+a8wx3WyFGJ57OtOkK7x0gymi1de
	7DwfKx4H7ttsvS0Ho10HVGDGhlHUitC3xyjGNJ3WkS2yeOYTxKa6LMobLNwfYineuQAv6L
	NYnYn//d9iGKLoBKygZyVMSuHmJvin3HDfFi70dz9xisIkE6agcRichLEV3wkxPeZyPGvt
	goX+b+twI8ZNsx9ulQ0nSTfI3MW2/zuCfHRfNRxLwwVRuplIKzYOQ0xaHbcR68eiNKGaOF
	i5PFmZpNbmJUR2fRDB09JlESnwSWDiV4OC5fdQ1gCg3Ab5b5Fi4qg8MC6Nvr1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhaC+iV2gf1ylvkDk4qpde6TEuwsgkVlMwuZKh2PwKY=;
	b=Ie/k3Wit08zQQwrFG7r+1ifs/a9EegQMNPgIkXNnryZu60Jcqh7d07+3scTi2DJT2d3osf
	rnoaAOPBRC01ytDQ==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/syscall: Split IDT syscall setup code into
 idt_syscall_init()
Cc: Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-34-xin3.li@intel.com>
References: <20231205105030.8698-34-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568020.398.4624847793309222365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     530dce278afffd8084af9a23493532912cdbe98a
Gitweb:        https://git.kernel.org/tip/530dce278afffd8084af9a23493532912cdbe98a
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:22 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:03:27 +01:00

x86/syscall: Split IDT syscall setup code into idt_syscall_init()

Because FRED uses the ring 3 FRED entrypoint for SYSCALL and SYSENTER and
ERETU is the only legit instruction to return to ring 3, there is NO need
to setup SYSCALL and SYSENTER MSRs for FRED, except the IA32_STAR MSR.

Split IDT syscall setup code into idt_syscall_init() to make it easy to
skip syscall setup code when FRED is enabled.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-34-xin3.li@intel.com
---
 arch/x86/kernel/cpu/common.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c3a1757..4f5e4aa 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2066,10 +2066,8 @@ static void wrmsrl_cstar(unsigned long val)
 		wrmsrl(MSR_CSTAR, val);
 }
 
-/* May not be marked __init: used by software suspend */
-void syscall_init(void)
+static inline void idt_syscall_init(void)
 {
-	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 	if (ia32_enabled()) {
@@ -2103,6 +2101,15 @@ void syscall_init(void)
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

