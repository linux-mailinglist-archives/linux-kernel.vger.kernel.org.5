Return-Path: <linux-kernel+bounces-68857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA9858103
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2165C1C21020
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A2153BF3;
	Fri, 16 Feb 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvlKVI56";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vhl8YMag"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55244152E0B;
	Fri, 16 Feb 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096659; cv=none; b=mD8o71LLki46RFOlwdowxoitrfkytJZR99wtYB1OXuYLpoBVoR+IYCV/e+8ZcVIwMcQgx2vQmaOvB99aXRCbrcMHsSrPjW6k3OzX070HNXqznoNvxZJxXDUsWu5iU4gC9+XgBzaXAplzttT7UTcP6PC+ql5RCIR5pYApfDIPk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096659; c=relaxed/simple;
	bh=pLQ8NVBs/W/5Zl0wLDFXk84yjutvU7nrtgum8XRgefI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rXZIcClfn06c1BwiM2QjE+OOrekiNr8F7GM6VUwgW72ddzEV9xTogrI3AsdXHLSxBBNkWwgJXGHqMGcF4mvhIG4PqISFH/EUop86PxPNUJgT2weajSUOJathQhVMgrBmQ9jcvKJz0ljeak0teBj0loEZLeVylJuojgHc1mNwr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvlKVI56; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vhl8YMag; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppElOOh1voY9s6y5YhNHy0NrVl8Hi+XoefTfmZlR2pA=;
	b=ZvlKVI56AJavAZhRg5sZMcgpI2dX5sVUXGFSYzhLNl5Kielor1wepgHtnw+35ADXDnzMft
	+1gv5vpS+Nlp7lImtTtIMDS+coyWpTUT6MNUzqt3Uu01sqyTVy0F7E3EIYeq/u0JYxNjpa
	H2POpRIDn8l4nPeQp86ol3iq1GVwN1SaY5XwyORuDrak+b+v74ppZ4+q2iCeSXIUA6QPzZ
	CqGk/ZQRiiJiMmZuIF7Fdwo9f88Rzww4MDrUPOPoeRqXSHg4wt1dERICH6rT2Aq35Le7LS
	TKsSYtRykNIyjeeToylHNr8Bhf7+3gihyfma3MypDWoFqiujEuBMj7k38Oassw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppElOOh1voY9s6y5YhNHy0NrVl8Hi+XoefTfmZlR2pA=;
	b=Vhl8YMagBQOlrTZSxMENroINiVtCamCUCQJRooccND7o0cSl5DucJIlpdNU6HkFSTCf/rM
	ZSa4UJHZu/GdcbBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu: Use common topology code for Centaur and Zhaoxin
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153624.706794189@linutronix.de>
References: <20240212153624.706794189@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665440.398.12477444758059436776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     598e719c40d67b1473d78423e941bed4ea6c726d
Gitweb:        https://git.kernel.org/tip/598e719c40d67b1473d78423e941bed4ea6c726d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/cpu: Use common topology code for Centaur and Zhaoxin

Centaur and Zhaoxin CPUs use only the legacy SMP detection. Remove the
invocations from their 32bit path and exclude them from the 64-bit call
path.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153624.706794189@linutronix.de

---
 arch/x86/kernel/cpu/centaur.c         |  4 ----
 arch/x86/kernel/cpu/topology_common.c | 11 ++++++++---
 arch/x86/kernel/cpu/zhaoxin.c         |  4 ----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 345f7d9..a3b55db 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -128,10 +128,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #endif
 	early_init_centaur(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index b0ff1fc..bcaaeec 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -42,7 +42,7 @@ static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 	return eax.ncores + 1;
 }
 
-static void __maybe_unused parse_legacy(struct topo_scan *tscan)
+static void parse_legacy(struct topo_scan *tscan)
 {
 	unsigned int cores, core_shift, smt_shift = 0;
 	struct cpuinfo_x86 *c = tscan->c;
@@ -71,10 +71,8 @@ bool topo_is_converted(struct cpuinfo_x86 *c)
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_HYGON:
-	case X86_VENDOR_ZHAOXIN:
 		return false;
 	default:
 		/* Let all UP systems use the below */
@@ -132,6 +130,13 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		return;
 
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
+		parse_legacy(tscan);
+		break;
+	}
 }
 
 static void topo_set_ids(struct topo_scan *tscan)
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 415564a..90eba7e 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -71,10 +71,6 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	early_init_zhaoxin(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);

