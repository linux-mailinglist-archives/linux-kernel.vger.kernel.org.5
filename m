Return-Path: <linux-kernel+bounces-142475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918448A2C07
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EC285F34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0D53E0E;
	Fri, 12 Apr 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QOVnwDdQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6aQi0+q+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D1537EE;
	Fri, 12 Apr 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916757; cv=none; b=OpAKpnHgSTAi62q6dU696J7XC/l+N8SiPhzctIZKZvRuf7TAYqWAd9uLtcd16KwKTNXmOr1oJKhw3ZPfk8RNV1a8+V9UGCCCgd/REHiamzACPR2ab4dzBBPK534LghxT21DWFsGOAKOzNLPqFZkIhGnU8gYpk3vAuABUcI8TY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916757; c=relaxed/simple;
	bh=389xDfQ+YdT8g+EzdAzz4ua5nJgcI8z7Tnf5PdrqHDo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qGk+HwvgoXn7hLadIDWB6AOgNK8Sx5Y6zPh/AxBUUGhFlM7H8s+KuK5UJ22brKFRyaqnKWnx6s/GA0FX7ZsIPmu7a8+pehkBt7jwgRzT7VfWBJ3fudFfBvK23t1G9H4p515zmdTfHdSnC5JHYt1+QyXkQwDUMhwEWPEm5gH/BJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QOVnwDdQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6aQi0+q+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAezHJAublcS64zsif1TeIpiiaR9r2KrmO6ijIdtc2E=;
	b=QOVnwDdQI26EnSMnJKjQvBE2CleeDCM/q9BIV0s+PillL2UVjiSXins1tTctEwdR1xqHrv
	/1xop0gqIObDhpVs/XIkW1r3vTp8D/Bzjyhx1NV1fRsMHj/7eq5qc6320Np+jrkLOOe/JV
	da9OMsIacO7tYdtXHArY8pTmP+sY9TyJAuy08S0MI52IL1GGRJgcrXqm0nUL7bRkpkNPZ2
	09Oc7ZiE9YeS264mSglke+zonIesjMOBkc3wilD8lYIVdgzoDe6KzYLLn3kTqvszWD3u5v
	Q1kinE5sdWlNQnFq8EpqK/z/JEHd1xLUc3m9YmcyYwKGJEKMCjnBIKBMxAb1+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAezHJAublcS64zsif1TeIpiiaR9r2KrmO6ijIdtc2E=;
	b=6aQi0+q+V9vIsRBtKv51ju+5Fx2cKuWDbyct24GwjMJE0m41KTkQIH39V1DRRIWLDkiaEP
	bFxT7ItrSWqS+pAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/amd: Move TOPOEXT enablement into the
 topology parser
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <878r1j260l.ffs@tglx>
References: <878r1j260l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291675328.10875.12326043004561033703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7211274fe0ee352332255e41ab5e628b86e83994
Gitweb:        https://git.kernel.org/tip/7211274fe0ee352332255e41ab5e628b86e83994
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 11 Apr 2024 18:55:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 12:05:54 +02:00

x86/cpu/amd: Move TOPOEXT enablement into the topology parser

The topology rework missed that early_init_amd() tries to re-enable the
Topology Extensions when the BIOS disabled them.

The new parser is invoked before early_init_amd() so the re-enable attempt
happens too late.

Move it into the AMD specific topology parser code where it belongs.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/878r1j260l.ffs@tglx
---
 arch/x86/kernel/cpu/amd.c          | 15 ---------------
 arch/x86/kernel/cpu/topology_amd.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9bf17c9..cb9eece 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -535,7 +535,6 @@ clear_sev:
 
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
-	u64 value;
 	u32 dummy;
 
 	if (c->x86 >= 0xf)
@@ -603,20 +602,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_detect_mem_encrypt(c);
 
-	/* Re-enable TopologyExtensions if switched off by BIOS */
-	if (c->x86 == 0x15 &&
-	    (c->x86_model >= 0x10 && c->x86_model <= 0x6f) &&
-	    !cpu_has(c, X86_FEATURE_TOPOEXT)) {
-
-		if (msr_set_bit(0xc0011005, 54) > 0) {
-			rdmsrl(0xc0011005, value);
-			if (value & BIT_64(54)) {
-				set_cpu_cap(c, X86_FEATURE_TOPOEXT);
-				pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
-			}
-		}
-	}
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 7f999ae..a7aa6ef 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -147,6 +147,26 @@ static void legacy_set_llc(struct topo_scan *tscan)
 	tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
 }
 
+static void topoext_fixup(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c = tscan->c;
+	u64 msrval;
+
+	/* Try to re-enable TopologyExtensions if switched off by BIOS */
+	if (cpu_has(c, X86_FEATURE_TOPOEXT) || c->x86_vendor != X86_VENDOR_AMD ||
+	    c->x86 != 0x15 || c->x86_model < 0x10 || c->x86_model > 0x6f)
+		return;
+
+	if (msr_set_bit(0xc0011005, 54) <= 0)
+		return;
+
+	rdmsrl(0xc0011005, msrval);
+	if (msrval & BIT_64(54)) {
+		set_cpu_cap(c, X86_FEATURE_TOPOEXT);
+		pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
+	}
+}
+
 static void parse_topology_amd(struct topo_scan *tscan)
 {
 	bool has_0xb = false;
@@ -176,6 +196,7 @@ static void parse_topology_amd(struct topo_scan *tscan)
 void cpu_parse_topology_amd(struct topo_scan *tscan)
 {
 	tscan->amd_nodes_per_pkg = 1;
+	topoext_fixup(tscan);
 	parse_topology_amd(tscan);
 
 	if (tscan->amd_nodes_per_pkg > 1)

