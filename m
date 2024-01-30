Return-Path: <linux-kernel+bounces-44935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCFC842935
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1792428720E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B512DDB9;
	Tue, 30 Jan 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTC43VoZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K2+AEAhT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27E12C55D;
	Tue, 30 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631972; cv=none; b=qYbyp9ZRb7MR9KE55+lVezZ9vFiY1zy47BxFNNmJbvQEncwspTc28V2acdsndjK7EAdSdALS4WCcNTJH6V/nD2Of/2B06BsxogjIO182IshNOQAAqEPyfXhEKI1A4KW2gRde+1spw7rd9D4KEUM61Arfl426JUBKCbQ649wa950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631972; c=relaxed/simple;
	bh=tcKCLnvHtvkmfg+UErQpEFfMalWobr5GzMqM/kkERSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l7lnm545ttdA94ml99On0WEy33W1RXq0mnQgGbIbvAkPXSVV/stuqGkxGL0OSzKi9wwslwZor+ARfubUnIz24x9aBgHgxt6lpP3I3rtoNq6H/kmz+0kCxMpdrXq4k7uHOkePPTaoQYlhPjl/LSw6VBDZUhcV6nafKIkrg0fJiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTC43VoZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K2+AEAhT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YRXGLgfg3ZbM5YYYP3t2aMeDNRtj+vKjmLz2BjMsYI=;
	b=RTC43VoZn4IPYJSk1KO2hdZ5mypN7oVtMfKGb78VOGm66i/dlBoXi4sxGG7Lyi9eE9snAF
	8i1zOYw+8ZN7rdf8TNBQV6UOcP4KGtr9bmRxDa35t1LNfgDLlzr8yWROWaSihNi3oB4oJS
	i/A0yqp73GiHWdtcumewOJOLoHz1fVhgOcIKGo6YxX+nPrjrPENbWf52SGI5DzE1C9eMJd
	AfT2cUzEVp0ZflPO+OgnRwgX2DSbnK5CVWDuvxIPz1jOPDlmzrbCnE4rjNB/3U7e+qUq2P
	AKSDjqaQ5DD+StTFwgb1O+Rs4gWFGitrx20tgCcvOOIP0uYhPQMehhLlNXK14A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YRXGLgfg3ZbM5YYYP3t2aMeDNRtj+vKjmLz2BjMsYI=;
	b=K2+AEAhTpl5BrRxTgy7GFvEL7vbUH/2ZvKKy5BaiBV/YhK6ffPEbGivUPjwFL9jsZOtTM9
	H39uYE+JEERPUDBA==
From: "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/fault: Dump RMP table information when RMP page
 faults occur
Cc: Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-10-michael.roth@amd.com>
References: <20240126041126.1927228-10-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196762.398.11962253377329116323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e8bbd303d7de3fb32be1434a5d5ce3e1cb182018
Gitweb:        https://git.kernel.org/tip/e8bbd303d7de3fb32be1434a5d5ce3e1cb182018
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:09 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:27:25 +01:00

x86/fault: Dump RMP table information when RMP page faults occur

RMP faults on kernel addresses are fatal and should never happen in
practice. They indicate a bug in the host kernel somewhere. Userspace
RMP faults shouldn't occur either, since even for VMs the memory used
for private pages is handled by guest_memfd and by design is not
mappable by userspace.

Dump RMP table information about the PFN corresponding to the faulting
HVA to help diagnose any issues of this sort when show_fault_oops() is
triggered by an RMP fault.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-10-michael.roth@amd.com
---
 arch/x86/mm/fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8805e2e..859adcd 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/sev.h>			/* snp_dump_hva_rmpentry()	*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -580,6 +581,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 	}
 
 	dump_pagetable(address);
+
+	if (error_code & X86_PF_RMP)
+		snp_dump_hva_rmpentry(address);
 }
 
 static noinline void

