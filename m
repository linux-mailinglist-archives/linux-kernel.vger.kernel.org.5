Return-Path: <linux-kernel+bounces-64240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB854853C99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A87E1C23272
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92D61674;
	Tue, 13 Feb 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJZpU80A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjtaT4nt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A361667
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858244; cv=none; b=cpgkKVggEaeksZmWYX0KWC6FUcc/mF+lFRiPjKV3LegjQDhFd5r3oNxP2gH4fqBRE9iyfxDIE/X+ZEWOdQ+B7kCPK0UynwvvO6KPChsbDnIo4a/bn52TeUhv7x47gbrt30hV5CVq40SJqJJMYMXpYveJY4Ik1VVjffRzPha7VDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858244; c=relaxed/simple;
	bh=NsdvmTXdQOEAcTe8BH4orT/Rt3CQ5Hp6MYfQha9qhRw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=WlNay15wEjIscWHkhdFWPC32At6z6eHDMtkEnjEy0vZISi2eYXAFnUEluD7bfXbaOfha7ud55CZIltrBwZONucgCoeUbobTpfXH7aiAKgcwWuE8gAtrR/r310ycRMiuzG1Up5FW+04lEO0SWVy//wopL4L95RXdSD6bVUe5IRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJZpU80A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjtaT4nt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153624.516965279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=POkOPr2xnUjR9qaFo3XT8NSa9LY45PY9NSX9q3xq04M=;
	b=WJZpU80AM+0zTcisR+tQshP4J32JDsv0HJxayl6DhfkXVNYJWDEYUxPozZHsVpIt6s7wJg
	Ny3NZVpIbzMl8Cbzin397wrUz3Tha166670s5fpzGIgRVoZh2yrmIgLYxQlGVgkgZ0hEZb
	01xgNm6KxVQCLwSWNUNuH7A/7YoJ+RregUJXaDWtLUnBaGs8oAqU+iJmFWdXvIA3aKLWFQ
	9CGjomTB8HEV/Zuq5Gks5Pg7yDE57XM5OPOlFhZyLx97qd8afV2yLIvG7F1vOPQdK99BoE
	3yrIfnB9hRLesrqeyZ+dlV9YLJ5bsN6ErpXOGrJORjVkwHoWx6q6oZnqn/8qTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=POkOPr2xnUjR9qaFo3XT8NSa9LY45PY9NSX9q3xq04M=;
	b=bjtaT4ntD5roAOEKcqJx5a2m43epaxATRzOPSRT8ELBv7ps3lxctmWaxVTwEPJ0gabEuxy
	C/V2Gw+NAZkAm6Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 01/19] x86/cpu: Provide cpuid_read() et al.
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:00 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Provide a few helper functions to read CPUID leafs or individual registers
into a data structure without requiring unions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>



---
 arch/x86/include/asm/cpuid.h |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
---

--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -127,6 +127,42 @@ static inline unsigned int cpuid_edx(uns
 	return edx;
 }
 
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+{
+	regs[CPUID_EAX] = leaf;
+	regs[CPUID_ECX] = subleaf;
+	__cpuid(regs, regs + 1, regs + 2, regs + 3);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs) {		\
+	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
+}
+
+#define cpuid_leaf(leaf, regs) {			\
+	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs));		\
+}
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg = regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
+	BUILD_BUG_ON(sizeof(*(reg)) != 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
+}
+
+#define cpuid_leaf_reg(leaf, regidx, reg) {			\
+	BUILD_BUG_ON(sizeof(*(reg)) != 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
+}
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {




