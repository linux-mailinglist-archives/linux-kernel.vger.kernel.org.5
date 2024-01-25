Return-Path: <linux-kernel+bounces-39113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2783CAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDF01C25EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EAC1420B2;
	Thu, 25 Jan 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ott5QImr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1nYAqt0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E213EFE4;
	Thu, 25 Jan 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206903; cv=none; b=mJwwSXlw7B9Smm+PNG3Ka1AGUp1clty84j0nryPGMp1jUxpC/xoz1VAuxO8tKKkb0uAAihtE508s2S8+gtMSut2ixjt5gamaFnWSckwwL5c4xW2RaUaOfg7VnmHt8lI+4hkWeglLE352pJu0++CwvGcnHaweql+RKayGlLGR40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206903; c=relaxed/simple;
	bh=tP+RtK3KGlDtU2n9Hz6fyToQQQhH7l9u6RLL/rUJN8U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HEUzeTTj0a/94/iUSku0NFybCCFMChlqKHHXj1Pqg8rEhvl8+KG58UF3kXfeoJO/imsMNhmO75Ytioj5rFdNFRy7uRWeDf+gSeW6KW14rwUjx3JtJ+YTo5WK6wDUMk339Sv2UBLYpzRO4gOYttVOvQm/FHJfL3lF8uuTgcjnBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ott5QImr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1nYAqt0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNoeFfqkZRiYsWsg8X53S1d/fSk6ZpmrreWObpdwhdU=;
	b=Ott5QImrLd0e1gO2l35TRKFotL0aL4Eq+rNYRtloWmlJYf+3o5/IpwYHDTDi3+P8fkt06g
	hKlszGZ9tVnfNZmhbBz+0znNzEi8unZXdrZrx6sgpcXvgIaCh6fF1Wob4nlY8iaGG3AJkl
	NXkma2jOn7jyoKXBUtLGIZX7G+FoJ542vMBps/95MHD6hdH0YfiutX2GH3ESq8mafl/dDV
	ho/qxCIAEFgWxhOSZlDZLLf0RucFarYdBJjdvXOseRDMNnX/xtnYRJXFPCkxnsQqckpNZf
	YqG17d5zSo5QaimRZnHEAeZAkPg87oLDWK5iZqEs/cfT6AlUmGapCrk76yoBwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNoeFfqkZRiYsWsg8X53S1d/fSk6ZpmrreWObpdwhdU=;
	b=O1nYAqt0wpughfmuTfCO2Iyx8Ma8yBy9zre0o/PDqdmaYVwQ/3rQcZflnHZzrJvErVOL+L
	caD0y5RO9AxYanBw==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/trapnr: Add event type macros to <asm/trapnr.h>
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-4-xin3.li@intel.com>
References: <20231205105030.8698-4-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689849.398.17892249218854161455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     8df719341e8556f1e2bfa0f78fc433db6eba110b
Gitweb:        https://git.kernel.org/tip/8df719341e8556f1e2bfa0f78fc433db6eba110b
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:52 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:29 +01:00

x86/trapnr: Add event type macros to <asm/trapnr.h>

Intel VT-x classifies events into eight different types, which is inherited
by FRED for event identification. As such, event types becomes a common x86
concept, and should be defined in a common x86 header.

Add event type macros to <asm/trapnr.h>, and use them in <asm/vmx.h>.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-4-xin3.li@intel.com

---
 arch/x86/include/asm/trapnr.h | 12 ++++++++++++
 arch/x86/include/asm/vmx.h    | 17 +++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
index f5d2325..8d1154c 100644
--- a/arch/x86/include/asm/trapnr.h
+++ b/arch/x86/include/asm/trapnr.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_X86_TRAPNR_H
 #define _ASM_X86_TRAPNR_H
 
+/*
+ * Event type codes used by FRED, Intel VT-x and AMD SVM
+ */
+#define EVENT_TYPE_EXTINT	0	// External interrupt
+#define EVENT_TYPE_RESERVED	1
+#define EVENT_TYPE_NMI		2	// NMI
+#define EVENT_TYPE_HWEXC	3	// Hardware originated traps, exceptions
+#define EVENT_TYPE_SWINT	4	// INT n
+#define EVENT_TYPE_PRIV_SWEXC	5	// INT1
+#define EVENT_TYPE_SWEXC	6	// INTO, INT3
+#define EVENT_TYPE_OTHER	7	// FRED SYSCALL/SYSENTER, VT-x MTF
+
 /* Interrupts/Exceptions */
 
 #define X86_TRAP_DE		 0	/* Divide-by-zero */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 0e73616..4dba173 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 #include <uapi/asm/vmx.h>
+#include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
@@ -374,14 +375,14 @@ enum vmcs_field {
 #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
 #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
 
-#define INTR_TYPE_EXT_INTR              (0 << 8) /* external interrupt */
-#define INTR_TYPE_RESERVED              (1 << 8) /* reserved */
-#define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
-#define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
-#define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
-#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
-#define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
-#define INTR_TYPE_OTHER_EVENT           (7 << 8) /* other event */
+#define INTR_TYPE_EXT_INTR		(EVENT_TYPE_EXTINT << 8)	/* external interrupt */
+#define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
+#define INTR_TYPE_NMI_INTR		(EVENT_TYPE_NMI << 8)		/* NMI */
+#define INTR_TYPE_HARD_EXCEPTION	(EVENT_TYPE_HWEXC << 8)		/* processor exception */
+#define INTR_TYPE_SOFT_INTR		(EVENT_TYPE_SWINT << 8)		/* software interrupt */
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(EVENT_TYPE_PRIV_SWEXC << 8)	/* ICE breakpoint */
+#define INTR_TYPE_SOFT_EXCEPTION	(EVENT_TYPE_SWEXC << 8)		/* software exception */
+#define INTR_TYPE_OTHER_EVENT		(EVENT_TYPE_OTHER << 8)		/* other event */
 
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
 #define GUEST_INTR_STATE_STI		0x00000001

