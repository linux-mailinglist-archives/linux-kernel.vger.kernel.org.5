Return-Path: <linux-kernel+bounces-135465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6B89C444
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85CB28259A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481886AF4;
	Mon,  8 Apr 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cguiKLxp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KptT8UAe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E79126F1C;
	Mon,  8 Apr 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583828; cv=none; b=hvEyM2o0WbxngDA2ikcJsFf43c8ntapeqKecsoRGoG8S3tgMzgrOSpN1ygQd51n5dQl60hAoZg0F1SPYWqvQJ9gG2XHQvcQUBzMEuKpUsjbdvTu2N2lO2PbD93zlhfEXp3xnkd1pNi8S7Jo0cDNEXQB3t+dnsw7Ty3EKBEHEWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583828; c=relaxed/simple;
	bh=Ht9+braf5DRdwXMp5BNshCyyK7j7FT6PjFBX4CjhN5g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cOW5Oo0quxVncnM94LGqU8rz7EMf8qGDihVWAZY2RyMOxTI6W0XJW+cHfgF9j8Z1BTgiO04kE7iAz282Q+XCopBJ3uqfE454VH5xnvcE8CNnLKRVJTYDsh6oZSLGscZRzUx/RY2Rte7Yu71r44ZXCAtt99wQXuBr0A/NoAkCnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cguiKLxp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KptT8UAe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712583825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cx7hvmoBnbU6N4Biz/cWNGxgHUtup3NQEcMZo3BfAaU=;
	b=cguiKLxpfgVs+nPq5DM8i3kzpkPgs9RbSwrAWncdxSmf1ocP2pgsFdgr2ayb6AYT4dZDeT
	S+79OVifH7HTXwQrPSQsYhdrVuGQytY9fRhGqissbKP4KYoOZIro3g3ffG0GKEwfrdAXxY
	Mtqq8L+9j4K4TEdzCoMsLr1FuHAHlKNvgLKTabL+zBsYC3+F0xub0UjDpgW2tGanl2XYBZ
	7XY42fSTJDi9mcSXfKsXA/cKwnFT/AtywxHhBcrZq/G0Qw/y/8XA5icgRfHHPFrgy6kdr1
	YOM/TxeTsDCde3Y2nNxopMZ+ywyaIs9pQ3ygAZbf/VC1rlk38LHj9Zc4UjK5lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712583825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cx7hvmoBnbU6N4Biz/cWNGxgHUtup3NQEcMZo3BfAaU=;
	b=KptT8UAejTmusaOA1epx9SlTCvdN1NkcUlkoe5oYbkBknQtSZ5TxCdrhU2qTTvd2frpAz5
	5/J6XBOjD4k94EBQ==
From: "tip-bot2 for Adam Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Force native_apic_mem_read() to use the
 MOV instruction
Cc: Adam Dunlap <acdunlap@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>,
 Kevin Loughlin <kevinloughlin@google.com>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240318230927.2191933-1-acdunlap@google.com>
References: <20240318230927.2191933-1-acdunlap@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258382395.10875.3450595381344943404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5ce344beaca688f4cdea07045e0b8f03dc537e74
Gitweb:        https://git.kernel.org/tip/5ce344beaca688f4cdea07045e0b8f03dc537e74
Author:        Adam Dunlap <acdunlap@google.com>
AuthorDate:    Mon, 18 Mar 2024 16:09:27 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 Apr 2024 15:37:57 +02:00

x86/apic: Force native_apic_mem_read() to use the MOV instruction

When done from a virtual machine, instructions that touch APIC memory
must be emulated. By convention, MMIO accesses are typically performed
via io.h helpers such as readl() or writeq() to simplify instruction
emulation/decoding (ex: in KVM hosts and SEV guests) [0].

Currently, native_apic_mem_read() does not follow this convention,
allowing the compiler to emit instructions other than the MOV
instruction generated by readl(). In particular, when the kernel is
compiled with clang and run as a SEV-ES or SEV-SNP guest, the compiler
would emit a TESTL instruction which is not supported by the SEV-ES
emulator, causing a boot failure in that environment. It is likely the
same problem would happen in a TDX guest as that uses the same
instruction emulator as SEV-ES.

To make sure all emulators can emulate APIC memory reads via MOV, use
the readl() function in native_apic_mem_read(). It is expected that any
emulator would support MOV in any addressing mode as it is the most
generic and is what is usually emitted currently.

The TESTL instruction is emitted when native_apic_mem_read() is inlined
into apic_mem_wait_icr_idle(). The emulator comes from
insn_decode_mmio() in arch/x86/lib/insn-eval.c. It's not worth it to
extend insn_decode_mmio() to support more instructions since, in theory,
the compiler could choose to output nearly any instruction for such
reads which would bloat the emulator beyond reason.

  [0] https://lore.kernel.org/all/20220405232939.73860-12-kirill.shutemov@linux.intel.com/

  [ bp: Massage commit message, fix typos. ]

Signed-off-by: Adam Dunlap <acdunlap@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Kevin Loughlin <kevinloughlin@google.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240318230927.2191933-1-acdunlap@google.com
---
 arch/x86/include/asm/apic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 94ce0f7..e6ab0cf 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -13,6 +13,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -98,7 +99,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 static inline void native_apic_mem_eoi(void)

