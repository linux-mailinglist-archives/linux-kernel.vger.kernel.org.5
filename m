Return-Path: <linux-kernel+bounces-20613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF77828269
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AF71C22C54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE7B360B9;
	Tue,  9 Jan 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCTKaDwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5QN0I8h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD9BA38;
	Tue,  9 Jan 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jan 2024 08:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704789891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GNNKALJWGEQ+WL9sfA5PJJAOcKbXtkYS0Lz2+98RA60=;
	b=lCTKaDwWEm6t+oYnJFz/+KOmUt/aCVJCIJAnEDqo/y+/3+yDNpIQeDtFsWzN+JNlXZiuLP
	x//t940TJd61ywLZWgpEInDwjmV4X6mKGAsXIUJ3ACqXTNObzG6nJz+tiek0/XWNqneCfP
	wkKsGQZepGJDAaPC8dFeuvt2HDlKXAi19C3+x7ht8zdE61QbLUbjJRNKWCiwwFqmZ5ZVt4
	iXtWu2TX8HuGBvHPVUbfNuGneiwb1xvB2+9fMo+f+rBmRA6FEg8gFit1+HVE6zJglJp+KF
	QU3I2f9mELw7C2qxNCVGnrygx99xR1sQIVzUyXhc+HKh83I594cB3A+bLCqrNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704789891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GNNKALJWGEQ+WL9sfA5PJJAOcKbXtkYS0Lz2+98RA60=;
	b=Q5QN0I8hftQOOq+S70hrlOs+2OeJUoISVCqBWKbYUFdimldljpUVOCIGM+4mr1VIkyPpqi
	WAQHaTlM/GxTSBCg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Use %RIP-relative address in untagged_addr()
Cc: Uros Bizjak <ubizjak@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradaed.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170478989066.398.5617937863599879172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     de8c6a352131f642b82474abe0cbb5dd26a7e081
Gitweb:        https://git.kernel.org/tip/de8c6a352131f642b82474abe0cbb5dd26a7e081
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 13 Dec 2023 16:03:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Jan 2024 09:39:15 +01:00

x86/percpu: Use %RIP-relative address in untagged_addr()

%RIP-relative addresses are nowadays correctly handled in alternative
instructions, so remove misleading comment and improve assembly to
use %RIP-relative address.

Also, explicitly using %gs: prefix will segfault for non-SMP builds.
Use macros from percpu.h which will DTRT with segment prefix register
as far as SMP/non-SMP builds are concerned.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/20231213150357.5942-1-ubizjak%40gmail.com
---
 arch/x86/include/asm/uaccess_64.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4..01455c0 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -11,6 +11,7 @@
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
+#include <asm/percpu.h>
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -18,14 +19,10 @@
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	/*
-	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
-	 * in alternative instructions. The relocation gets wrong when gets
-	 * copied to the target place.
-	 */
 	asm (ALTERNATIVE("",
-			 "and %%gs:tlbstate_untag_mask, %[addr]\n\t", X86_FEATURE_LAM)
-	     : [addr] "+r" (addr) : "m" (tlbstate_untag_mask));
+			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	     : [addr] "+r" (addr)
+	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 
 	return addr;
 }

