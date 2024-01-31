Return-Path: <linux-kernel+bounces-47131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27138449AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85361C23321
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C13BB32;
	Wed, 31 Jan 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tirqsuFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6HF5g5B1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769D39ACB;
	Wed, 31 Jan 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735692; cv=none; b=QrZN5caVWsw1uDfAnoeHPgO9Ag3mVREfJITLbeqTfMzW7y3VhGJy0GNMwuLUcx44Z5g2BhkuhAZB8Wdt9yQ762WHP3sMOHkODpbx739zwo6077eOeue2U1qd3WT0emMpXf4VGblH6UI6wpXrmPGg0ox+BQNN8Wp6zEAXSMxbH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735692; c=relaxed/simple;
	bh=FNNQ4v5en5QQA9wJHLquxcQTcybBQRxDpzmgCR8zsds=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bn+h2sEa/PaOnmnDICnEHChYBho7p/3/tdAiaULZs9P05YPDvNeqitMDLvZEJBg8JqVdxYpt49sCCLUvgYHFevgNo8k+DMCmDSr1sg4LBVeVywun5JgdlI4rCHMzJQ1DT/CHGMntE4/NRouEeeddQ8TKlRnJUlyr1Evvod6wkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tirqsuFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6HF5g5B1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB1GFWsHKuSTUsV5DHwObFwR+52c5Y/OuUx5Al7VURY=;
	b=tirqsuFvwer57NHQkI6+6NWo/P17qIfrLInUfAPfHISFzmQUc3oo6HkZ9mtYDuFjDRPExh
	FFm7a1ViA4sz4QD0P+YLk61PfVK1js5gxQjc2H+qC9dvw+vlVwNymtkz5312IXpxT6gOg4
	nu6MrIAtouyp/PkVQdLFYNHqSWwMwxhm3a0x4+EoRPujleAqt/IVeajWLc+nDmWawNfMZV
	f9kZYlX/k1K62QHo5Wk3bKYZ3RpkI2kz2haSkqWGuxKbNDCScycmpwBfFKDwvvcZRiwTHD
	ugpJ+vWXiFGbt1WtKPZ87Vni5ZwoQY0g6EZqw4v1ga290dWuOcxKz49OIueC2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB1GFWsHKuSTUsV5DHwObFwR+52c5Y/OuUx5Al7VURY=;
	b=6HF5g5B1GXM2UMgKhjDKBXqrPiaOQynPDDFoiyr56joStvQZ9oSxvOIi03eTAZAuqgDb5w
	Q1/PDUZ0rAHO7LAA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Make exc_page_fault() work for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-22-xin3.li@intel.com>
References: <20231205105030.8698-22-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568749.398.7045347279493145706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     58c80cc55e079933205597ecf846583c5e6e4946
Gitweb:        https://git.kernel.org/tip/58c80cc55e079933205597ecf846583c5e6e4946
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:10 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:02:05 +01:00

x86/fred: Make exc_page_fault() work for FRED

On a FRED system, the faulting address (CR2) is passed on the stack,
to avoid the problem of transient state.  Thus the page fault address
is read from the FRED stack frame instead of CR2 when FRED is enabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-22-xin3.li@intel.com
---
 arch/x86/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09c..fa2d699 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/fred.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1518,8 +1519,10 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
-	unsigned long address = read_cr2();
 	irqentry_state_t state;
+	unsigned long address;
+
+	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
 	prefetchw(&current->mm->mmap_lock);
 

