Return-Path: <linux-kernel+bounces-45891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B701484379D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754571F26169
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438655764;
	Wed, 31 Jan 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcWvyQ5d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFWHaeN8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356475024D;
	Wed, 31 Jan 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685671; cv=none; b=pZO0z7/fuMILsOT3dV8TYD89eK5K/yM3DVDBI58O7i+TXcWjUcQv9fGDrZ6JHCsCQE5rLX4ZdGyFFdBWDW39zFExUheNNq8AnPvHVipjMXeNJWkqnlkbef/+PPBn0SF85bcxrNmutmMAzybAYY2vF7OcTBeoxERiyjLzV96UvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685671; c=relaxed/simple;
	bh=5B4XxpE7BFkb5epemDLCRZir6hrVpFKrMhQQI3jMzfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gu0ren8fDxhKVu9Sh2kVGk3e9TQV3YSPSF4plSRQaifGYjNvQeTknL/jU2pmQhhbSgGtWOpXJgcmtEk21aWb4m803hQevsC34BXNRNICwDq8pPqgZPdz41bXLIyuEQjityTIErC5xmMpjzBEusFzTjxgG2W+FlJ/DyvA6wZ2gEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcWvyQ5d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFWHaeN8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2dB0bQNI8TQ5FCEGQ4jdKzUAJaB0VSGEjyZQOGhhwg=;
	b=CcWvyQ5dHPDlh0xR2YTiacqX0SHR5pvJqo5TLuj555tu5NRCQaAtI7o2bRVtturzwLeglf
	yz/YjnNKIUtM/rDbEKWud4mI4Mp+SiZ+L3W4iT55jBT1YMF6vXuU6wXCXxRpiw6ykKe6XQ
	aCMVTrHSKlDG2PKs/G+Jft+ZyYeZiWA9flRwgBTMesDTC6PxpqniTjjLU+NjeJzXeIFYUA
	TwQyHEEO/HaHA7EMsA1uWN2YSRHwogFYmniM6urPSCvzqAvlCz+Qs1xxJd2R4KWaiCWBYY
	9a1WB12ecu3mYCAey4/5Bxk4zsQrRZf3DVL/FbIZCdId4xACZkJFjalOf3GVFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2dB0bQNI8TQ5FCEGQ4jdKzUAJaB0VSGEjyZQOGhhwg=;
	b=zFWHaeN8OOb6J4LRWEdofslzUPoNk4s7fADBoS8z29mDrE5yXVdXyHdwQ+3VQ89wCQfuaS
	ZGALmMp8OzgTyADw==
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
Message-ID: <170668566746.398.6148981179388974383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     ae46f3978ae4eb9da013ff9963f105de2db2f8ec
Gitweb:        https://git.kernel.org/tip/ae46f3978ae4eb9da013ff9963f105de2db2f8ec
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:22 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:36 +01:00

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

