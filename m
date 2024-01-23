Return-Path: <linux-kernel+bounces-35265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5D838EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDE51C22B66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2685F55F;
	Tue, 23 Jan 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FAfpbnaM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OwA8CbOf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B375F541
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014415; cv=none; b=K4y+6SPdAT+T1GYZB8u/dJxzGK3e208Y9A3QVUCw+TWfJ0J3cO3xylPV/Xt9XP3rKTWB5ozTIT579MmMGjyjd8W7vLwfAHIfk8QGpvYtmLF6mJHnZpdrohWxjT1nREHqaVspwjbFtZ/HDEapuZ30umyeUuwkuPw2Bj5Y4gxXWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014415; c=relaxed/simple;
	bh=NE38U5sSq0KEn81KCUffHn/ZAXWYI8/Ra1pEbVF+fpk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=G3fL9G0iU6u/qogcrcMWZLV0CZDQPzbw7SLj7AJDG3dhzt8QSuSeVHP0mIieiX7qe2/ovmWk1j5QVVZ2vwhmtedRrdR4IZclkDR7Hfsujf2MlJT1DhAg2tQwKpmB38TPKP/JdqwbiNGIw5o9AzTVo4E59Tez5DQX0Ougc7OA9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FAfpbnaM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OwA8CbOf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.344295552@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CHwg68P1vAZsPhjQ3yDPqQ0OD7LrrKUWUxcHvl79YxM=;
	b=FAfpbnaM66ByOQaVXjI9rCfUS1eMQPfzpTR08osAdyKX1ioK/p+OAFj97+Wd2dcHFCrLEh
	J6HQrCw2hTCTXQ8LeUfg+hwtgEoc2c/kED1xSbqayzUbfC+VA+EeiVTmsAPJCJqzDNkgUD
	uVrNlyRH1hbFZ5PGcnoGExUbzpHFk8RzNIedBTtvk2+I6IBF8GmRtlSTNmaxn/V2fZwa20
	axOs5esqRYywB+mIFE+qo8y3CRX3twbxwk8LPzUtT9Z0/d+kcQqo+xmU67auZDGxbhgcBF
	24maN2ACq+RzqPKrpOsFVhxmtD9n0BvyE48g/oWDfL4iqO9GCgc+nOa+7Ldetw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CHwg68P1vAZsPhjQ3yDPqQ0OD7LrrKUWUxcHvl79YxM=;
	b=OwA8CbOfTHWs1se1A3pSZMnJP84bPpNl3gY+gkKnrNG+TmOfV1qf0s23rNHZUQnQJN8Z34
	6M/IP8M9c2Qc0ZBg==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 01/19] x86/cpu: Provide cpuid_read() et al.
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:30 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Provide a few helper functions to read CPUID leafs or individual registers
into a data structure without requiring unions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
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


