Return-Path: <linux-kernel+bounces-45905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A18437B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1359D28A742
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6273174;
	Wed, 31 Jan 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUv6cc7r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxnaCJQ9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CE6A01E;
	Wed, 31 Jan 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685682; cv=none; b=fjtzdCXKclir+rxgPmP1No1IjdPybJPNp6mMMiCKFZa3tRtY9Dt8y/FDHE1nfdbhZx/u+cAYtHWFqVpNOpsFf0ogceU+n+CoL+joUqnwMEedwMR2QFKVIAj+RJSd6L9EXlSl9zZM1oh7kmTERuL0Tk39konitwZMqUfIUVXpJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685682; c=relaxed/simple;
	bh=Bf2ntj5gomkiyY0MKA+i9LAy2ku+tcf9RD+fOMZGwSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d4zwVWeJkv7SylS8+puzvsnSQyDKXiroRH07r2k4pY1y+QUHEQ6DkGz/Mch18Awxoh6ukuhehKHvjeG2ptIrDLN+2a895p1kRzz/y7QyKp4+5dZ+Nj3SUEOT1Daj6KL+Joj0RXr+PeSiJhHrkK/oe0zGH+4s50grTxn8xDwJoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUv6cc7r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxnaCJQ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FnLl2VW6ausIT9tJbTpQZYvUrpNFT33gSeEto3/nr0=;
	b=SUv6cc7rxJ4gOeMKw5mhtlnKoNXSU0RlucSfIAg/1UFW7gLZ/CSGjv8OmH5A/zyAg9AlvU
	kuoV8rVsoPOUrs5S9hPOYC0LGb5wm65jGGy+OPosg80RXUJ66yspUABjPYe2khe6SLbxUc
	e6zMY1zzpYzjS332Gvvy6pBNAj3h/yYndZ6sA8vxm69PfOD8QTW0weC+GJ2Z+QEcRzUKoK
	53Hu9km4deFrTLTL9E/Ve56+EGW9+x+i2JalTtAi+aVrRhYwF74aRC5pvk+JhaPyhdAOsL
	BCAD8wkTufvOREk2VzJsa3D63eY0nbojm1fk97hb4VCUSU5WhyU0792eXHg56w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FnLl2VW6ausIT9tJbTpQZYvUrpNFT33gSeEto3/nr0=;
	b=FxnaCJQ9r0ChqE6Ds5MfF91av2UuCdcD5jQweCXYL+/DUXbdJBupGCSLtGm+Hf8zw4/DzV
	0TbvigNCJyWLQEAQ==
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
Message-ID: <170668567825.398.12991014894719583005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     9f6870bafc183644d20cba702168e37b48e291a7
Gitweb:        https://git.kernel.org/tip/9f6870bafc183644d20cba702168e37b48e291a7
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:10 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

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
 

