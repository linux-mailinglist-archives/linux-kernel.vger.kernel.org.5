Return-Path: <linux-kernel+bounces-44936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E1842937
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B61F285F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD012F598;
	Tue, 30 Jan 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOwHBaff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ukcV1/gE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C312CD8D;
	Tue, 30 Jan 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631972; cv=none; b=LyCt/9Qbtp9qy9JvzXxWviHAoQYqlJkBCOOh7fMz/TEekpLzSJVlm7U+hrMA81rW7ux46jwwtabT3F8kaNX+taorTCqJjAhSSpW7jy7TYPr4kXkAlf2o6FlvpKw0cUBUdHui+caH6HmCc2vhubMc6NY112oSGYONpDQ5ZB1QWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631972; c=relaxed/simple;
	bh=WADDM1H92wETD+9wiEl2YfbHXXl8A+FMqf1KJYev7uk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=stDHiC4DDngyy7IN/1UQaHwPs4wTkS5MkNJ6qGae/51Q/X3aracb4RIDu77u2HRxz58H4RilDxSPzcIX4bHp9Dpyi3VWvPFrbs3rp9sHD59Afxl1vv4NXR+WdjOCSUt70iNvOIRlm03NdIEhUH1C+CQx8Y9nrsEkjkzB3lqlqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOwHBaff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ukcV1/gE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGPmg3bM0K0ziuVF/bpOWtTuv50Na0x4WowzmqJ4PB8=;
	b=tOwHBaffiUlFO5kIuXr//hbLLmbnz6Ef+a2Fb8S8dzGgdB0SolG6VRtfR0GIM3XqHKZDKp
	b4rXn/YHKOpgarsgraTIIEK1Yny6ecpGzNAXQ0F30cfRGhK0tfrD5QokfkGHmpiJA7YesQ
	gtv6k6rNZf8CbRIpOw4a9uRzWJp9iDsJWvDtwar6CE5GqTPue+TiSuPng5N8GytcIPEvfp
	N4K+7qDRpkZnm39GKeGhjJ4AP4zylSpNA4ipNJ2fT+9MMP3mF9b5Tlb0eWbkvDwa3QLVwX
	KkuzrSBhV6nXneXAAijeHg1iFLyPUq9pQmK31LBEYiRQVWBESyNFmV5Q62sigQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGPmg3bM0K0ziuVF/bpOWtTuv50Na0x4WowzmqJ4PB8=;
	b=ukcV1/gEqMWEBII8uTbHIDJibiA837km17WChHzxaxGd5hy8S4dMG8R9/44J2aaSGEgiUk
	wTbgUp0BTNqR8UDQ==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/traps: Define RMP violation #PF error code
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-9-michael.roth@amd.com>
References: <20240126041126.1927228-9-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196817.398.3820994161857678840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     54055344b232c917a9e492a8bf5864fed99ad6b8
Gitweb:        https://git.kernel.org/tip/54055344b232c917a9e492a8bf5864fed99ad6b8
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:08 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:26:56 +01:00

x86/traps: Define RMP violation #PF error code

Bit 31 in the page fault-error bit will be set when processor encounters
an RMP violation.

While at it, use the BIT() macro.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/r/20240126041126.1927228-9-michael.roth@amd.com
---
 arch/x86/include/asm/trap_pf.h | 20 ++++++++++++--------
 arch/x86/mm/fault.c            |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
index afa5243..a23a7b7 100644
--- a/arch/x86/include/asm/trap_pf.h
+++ b/arch/x86/include/asm/trap_pf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_TRAP_PF_H
 #define _ASM_X86_TRAP_PF_H
 
+#include <linux/bits.h>
+
 /*
  * Page fault error code bits:
  *
@@ -13,16 +15,18 @@
  *   bit 5 ==				1: protection keys block access
  *   bit 6 ==				1: shadow stack access fault
  *   bit 15 ==				1: SGX MMU page-fault
+ *   bit 31 ==				1: fault was due to RMP violation
  */
 enum x86_pf_error_code {
-	X86_PF_PROT	=		1 << 0,
-	X86_PF_WRITE	=		1 << 1,
-	X86_PF_USER	=		1 << 2,
-	X86_PF_RSVD	=		1 << 3,
-	X86_PF_INSTR	=		1 << 4,
-	X86_PF_PK	=		1 << 5,
-	X86_PF_SHSTK	=		1 << 6,
-	X86_PF_SGX	=		1 << 15,
+	X86_PF_PROT	=		BIT(0),
+	X86_PF_WRITE	=		BIT(1),
+	X86_PF_USER	=		BIT(2),
+	X86_PF_RSVD	=		BIT(3),
+	X86_PF_INSTR	=		BIT(4),
+	X86_PF_PK	=		BIT(5),
+	X86_PF_SHSTK	=		BIT(6),
+	X86_PF_SGX	=		BIT(15),
+	X86_PF_RMP	=		BIT(31),
 };
 
 #endif /* _ASM_X86_TRAP_PF_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09c..8805e2e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -547,6 +547,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		 !(error_code & X86_PF_PROT) ? "not-present page" :
 		 (error_code & X86_PF_RSVD)  ? "reserved bit violation" :
 		 (error_code & X86_PF_PK)    ? "protection keys violation" :
+		 (error_code & X86_PF_RMP)   ? "RMP violation" :
 					       "permissions violation");
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {

