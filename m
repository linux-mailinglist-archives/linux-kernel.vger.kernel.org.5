Return-Path: <linux-kernel+bounces-68819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429158580AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D68285CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA9145336;
	Fri, 16 Feb 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sjzcg43U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekKHoTQr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831C213A88C;
	Fri, 16 Feb 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096634; cv=none; b=lnm9puRqsVdWZJ3kBBxSqfv8bpg/ICXokS4EoMFZx/bf2cIn8uHMfM45/bMm8kcCQedOwQzXJs14Tgc022A/1YKgzN/Dy5yHfCV4iUfCkDNCeswgFQUr1nHnYNVGfGwIdAVoXiuAb0AgZQC+YGw1DpZV0W2qLARwzuf6Buo0Eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096634; c=relaxed/simple;
	bh=jWOyp2RH84Aso2hP4IA3ByCgY3cMVQ0jNGNDPNGC+yQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nKHQT65JMxqiYJ8g947KnrkjcNJGuE7fqLpAQimKFAvCkDJcaJk23b932xcdcQyJuVQPPSYENnLNqF9k+w5uP0ENNCGGPwak00EIuReYi+rKhKXrvCbWZpjwC99r8mQ4vlL0sOFyDmbXcfvZRdnXhym8SgKcd82w1SnUnLlANSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sjzcg43U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekKHoTQr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4J22mhRRPiCEEG8pXqzuGGhJ6KeBwgEkZTDcWzAMqk=;
	b=Sjzcg43U3HdM4TjJAw5sLFEvwAuMK8iz1WEFKry33VtEOA6hgrUVFGgOvuq9tyNC1NGDTl
	CGwf6rSyTwLQcA7SLNzRea4969HngyG95YTTb+yGECtx151R0YPSc9dvtGWt5w+AmWm8A5
	/0ZhMDeQ0fRQRZtRVTLwwkpGu19Nm78dqru9sP5bIOhzMPR0rq11yVNctIs1x5FU1Q5ems
	FaCspWLCPDfTkk8oV+rECDntuaHVlRLqFOp96oC8PNHsFSDYwv5IkwNGpBuza+hGJVYdVY
	J+H47KCWGVxXtMeIPkiEeb99q1/ETnDn80PxfHydwj8CadTnqoJZeXpUaysURg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4J22mhRRPiCEEG8pXqzuGGhJ6KeBwgEkZTDcWzAMqk=;
	b=ekKHoTQr15Nd299S/C5duDE6phmdwtQJukVsaq7V3qWV7ctT9l9jFiOGUWcLzyAWUWQCy0
	canEGHofUS2NEYDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Use a proper define for invalid ACPI CPU ID
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154640.177504138@linutronix.de>
References: <20240212154640.177504138@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663042.398.18233953458036064393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1a5d0f62d10d5da44c2b6a97b6600dea8a7519fb
Gitweb:        https://git.kernel.org/tip/1a5d0f62d10d5da44c2b6a97b6600dea8a7519fb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/apic: Use a proper define for invalid ACPI CPU ID

The ACPI ID for CPUs is preset with U32_MAX which is completely non
obvious. Use a proper define for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154640.177504138@linutronix.de



---
 arch/x86/include/asm/apic.h  | 3 +++
 arch/x86/kernel/apic/apic.c  | 2 +-
 arch/x86/xen/enlighten_hvm.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index ba219d6..109f980 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -48,7 +48,10 @@ static inline void x86_32_probe_apic(void) { }
 
 extern u32 cpuid_to_apicid[];
 
+#define CPU_ACPIID_INVALID	U32_MAX
+
 #ifdef CONFIG_X86_LOCAL_APIC
+
 extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 68767a9..fa11e25 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -111,7 +111,7 @@ static inline bool apic_accessible(void)
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 3f8c347..99a68fa 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -168,7 +168,7 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	 */
 	xen_uninit_lock_cpu(cpu);
 
-	if (cpu_acpi_id(cpu) != U32_MAX)
+	if (cpu_acpi_id(cpu) != CPU_ACPIID_INVALID)
 		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
 	else
 		per_cpu(xen_vcpu_id, cpu) = cpu;

