Return-Path: <linux-kernel+bounces-39094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75C83CAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEBD1C25FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006413AA4A;
	Thu, 25 Jan 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V3blTszB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="69MkmGpP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE9137C51;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206894; cv=none; b=INDYCtTl0ARagaheRWyrxNyUPbr44QW6VNG+DMBdglbw+eL3nJm5qSwHkllDRMAeZLAbyH7aa+xt8pYnLKTLVZggx2FF5yuSkrffNAGZ+CMg6LDIATUJiA0OhQIQ3f1hwFb23ufXBwqckEhIM23u6J/iXFrdlt/Yy8JbK69Sh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206894; c=relaxed/simple;
	bh=WSirhDU+3nC4wC9TfgT8TNeulRXQ5reMckx6s69Civk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GfflvJbapasIwKPaW5kpum3jBRf1UM1Zt8ILBjpv1Rown/mU9kCmhL0qa37ehW2HshXNtbiG93TKazONv/ZRqjv5j0w294hGu+2hY1I+miS/vU6i1zs5UXqGAycwkSbFFAM4k2glSqZ56p0q/erjO+5y/kyGaA1EP6yQTjy3Blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V3blTszB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=69MkmGpP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSgpVMRprTvrE715OzBvsjq7Tf/kNqsXBZ7NclaV1XA=;
	b=V3blTszB0jh/vnLUdhozLa3z0fVxTxN75BCBP/IMfm6dzPGkgecdH/4QEoZOVobNt91l1o
	X9kEwPe2fu4BMZhmhuy3QY0JpJQC0jCmIgnV7dSQcKxcyi5oWBwnZKR9M+jOOxh/Qla3UG
	0PuryKCOQWaLcYarvvWGohu2YaNyB519pLqG/1hjkEBLYg5MFBY/xEqiw0l+yA0cE3HKJU
	0Rg5A/2MKng4jYBUjywizfHZ/shbcQLUR5vEM343kjq+pyKoX1shbc24q3nQ1fZxIxQLxV
	Xki2agnyZh2ZW2unp1wwq5+sR4gQxXgHhBuyenW3S+aEqdyJSRgq5irgtTEB5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSgpVMRprTvrE715OzBvsjq7Tf/kNqsXBZ7NclaV1XA=;
	b=69MkmGpP/hD1J3cAvDEo/OFuSfajhXejNQ9HUeNOajvE1A/nC/mxeLnIQ4wxsm3v8/FD0x
	ly/VaPEty7bH55AA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Make exc_page_fault() work for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-22-xin3.li@intel.com>
References: <20231205105030.8698-22-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620688548.398.18235681806393352031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     56d86ae082ba7030b4df0b365bf102c9a63826b2
Gitweb:        https://git.kernel.org/tip/56d86ae082ba7030b4df0b365bf102c9a63826b2
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:10 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:32 +01:00

x86/fred: Make exc_page_fault() work for FRED

On a FRED system, the faulting address (CR2) is passed on the stack,
to avoid the problem of transient state.  Thus the page fault address
is read from the FRED stack frame instead of CR2 when FRED is enabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 

