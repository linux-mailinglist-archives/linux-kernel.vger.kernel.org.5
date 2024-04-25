Return-Path: <linux-kernel+bounces-158676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22928B23BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA19284AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593414A0B2;
	Thu, 25 Apr 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q4MqD9wR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgucjH9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3980149C79;
	Thu, 25 Apr 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054690; cv=none; b=PXFhIRR6Psrc74gQojskBju9BM0mg+b0UZroKQ2wETaKnEUEl8TsQCFSh1ng/+/xgAi9nFSjMBwhH94a2PiR+buiX2ToVvQeuGpOtbGXjH9w3on0T3cfO1LDmamh8ZqJjOH5rQN11GgyUXVPsi+QdZ6FJ9XdLPLUCvdbqJm3LxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054690; c=relaxed/simple;
	bh=QTumG+fyB+e46BMNdp8ZDq/uo8u6Cl2dzh2DX+47E00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ti/nxziGglNdzOX3Cz0WhhrQrUV9+6gOvbrnIEolm7qO29vauJ41KmS26bA/OoW2Pv2EdlIP/GgzTP5tcTJF8J42Shk2XS7tJCHdteh+tNOec0JRwRIeNVygzh+2xuSQOtk7uI1NiTFrRQFcfbkNGIO3VYCRAdWKN0atX+UUSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q4MqD9wR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgucjH9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 14:18:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714054686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0Lf75TZT9W7/+Dl8xMC8kTVtJogeNXRyR54t0M0Frg=;
	b=Q4MqD9wRx9UKwiJrXw5OP9kbtx1iyhq0DqBEuDNTlmhmK5rBjjYDift83uZxYlIltBrjOd
	xdVxcvl35Xhybt2n3tN4zlEGr/qekzebH33vIRUPiaelN/trBDF7JlWJQHC8qSZlD3YwgC
	okaEslQANFsKzKdU/a1P7BZzUnF2GZQjRTs9RBQYd/kJdU1wRAdIQATOxYehdPFfOAR1Qv
	M8t7EJzYabvc6zR7A0QKVicqpZcf+XKjRytkIybsiorHaOXLzIYklR689ASdggeEHSCnGf
	5RQALUsVoIv+62vClWpviUJcPO+w3gAfKXHvdUPUNSBHP5kF/iLB8ClUD5igcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714054686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0Lf75TZT9W7/+Dl8xMC8kTVtJogeNXRyR54t0M0Frg=;
	b=VgucjH9HLqVMY8kC1IZNR/7bNrfoDF2lZNO/cU9xUhsYABxF2lC0S8nfPy3p4LexXIR4CL
	YAAfWnZZu2HiDICg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] cpu: Re-enable CPU mitigations by default for !X86
 architectures
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240420000556.2645001-2-seanjc@google.com>
References: <20240420000556.2645001-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171405468579.10875.6342946389832974542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fe42754b94a42d08cf9501790afc25c4f6a5f631
Gitweb:        https://git.kernel.org/tip/fe42754b94a42d08cf9501790afc25c4f6a5f631
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 19 Apr 2024 17:05:54 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Apr 2024 15:47:35 +02:00

cpu: Re-enable CPU mitigations by default for !X86 architectures

Rename x86's to CPU_MITIGATIONS, define it in generic code, and force it
on for all architectures exception x86.  A recent commit to turn
mitigations off by default if SPECULATION_MITIGATIONS=n kinda sorta
missed that "cpu_mitigations" is completely generic, whereas
SPECULATION_MITIGATIONS is x86-specific.

Rename x86's SPECULATIVE_MITIGATIONS instead of keeping both and have it
select CPU_MITIGATIONS, as having two configs for the same thing is
unnecessary and confusing.  This will also allow x86 to use the knob to
manage mitigations that aren't strictly related to speculative
execution.

Use another Kconfig to communicate to common code that CPU_MITIGATIONS
is already defined instead of having x86's menu depend on the common
CPU_MITIGATIONS.  This allows keeping a single point of contact for all
of x86's mitigations, and it's not clear that other architectures *want*
to allow disabling mitigations at compile-time.

Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240420000556.2645001-2-seanjc@google.com
---
 arch/Kconfig     |  8 ++++++++
 arch/x86/Kconfig | 11 ++++++-----
 kernel/cpu.c     |  4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 65afb1d..30f7930 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,14 @@
 #
 source "arch/$(SRCARCH)/Kconfig"
 
+config ARCH_CONFIGURES_CPU_MITIGATIONS
+	bool
+
+if !ARCH_CONFIGURES_CPU_MITIGATIONS
+config CPU_MITIGATIONS
+	def_bool y
+endif
+
 menu "General architecture-dependent options"
 
 config ARCH_HAS_SUBPAGE_FAULTS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf3..619a04d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -62,6 +62,7 @@ config X86
 	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
@@ -2488,17 +2489,17 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
+menuconfig CPU_MITIGATIONS
+	bool "Mitigations for CPU vulnerabilities"
 	default y
 	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
+	  Say Y here to enable options which enable mitigations for hardware
+	  vulnerabilities (usually related to speculative execution).
 
 	  If you say N, all mitigations will be disabled. You really
 	  should know what you are doing to say so.
 
-if SPECULATION_MITIGATIONS
+if CPU_MITIGATIONS
 
 config MITIGATION_PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07ad53b..bb0ff27 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3207,8 +3207,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {

