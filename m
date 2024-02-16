Return-Path: <linux-kernel+bounces-68858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B8858104
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81182856BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB641153BFF;
	Fri, 16 Feb 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSgL6RW/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpZmpcL+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B31152E0F;
	Fri, 16 Feb 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096659; cv=none; b=p/AzsVXk5E2xpG3wlClmxN9G10RMydgmuLxdPsdZZIKqfhtJt6kckXP3IgZL9YQiWE6SWfOyL+Eii0Seuzj3KX4ULOolQ5a/mLzTvsiFCNlcUQwhDK1ARLW8UneKI1hzHjVWH51v0Ej+H3uAlY+YYD3p3/pwXvm0nOy6fJnrdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096659; c=relaxed/simple;
	bh=2Et24KRbuDqzvHBTFMWDv8mnNWk3fvHCoCbvHd2PIeU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U7wJ7fs45y/dX67v8aKCMmjaq/5IwbE+svtJILWCOF1pfcF162IUs2pEK0TxrTHz8OelBDqaUGcAXMJ+AW9Tt7fqIb5C8S1C2MzrugeIPAOGJTOWwNyuOeptH/F8AtfP3oH3Ll5qXFkeBf09n/Y6hlZ/tTwjevEoxDAJ1UWtWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSgL6RW/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fpZmpcL+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wJe8jnRPrT4OkbnNnqnp8A62zft8jLio3jBT8JZtW8=;
	b=sSgL6RW/bG68er7/qcnmP15ilM6Eh0kaU98cKZMBLNRXHU50GAUBEWxTitHp4biKfIhBTT
	4Tpw59uu82MraVM+vJpDhX0ovMxnB1qN00JdLgDhHgOJJagqyhaG4OgUdbyVHmHdHwVDA+
	cDJERDOhpxqQrp1pWT0DnAbjQWwzG7Bcz8+sb1LhqZuMhSf3w/SlIFGvF/fgCaxEgRxHg2
	wQ92GOLpl0ujAfy+Z6rV4yxvxfdYR7R8NKkcYm9W3YAQNF+pEpq6NVuq2KHLPFajVPOkaN
	nf7Sb15YDW+RQVsTMgWE9sGWjMiAlD2rVo129Zph5fiXg+LuYoGxEl1p8kDZSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wJe8jnRPrT4OkbnNnqnp8A62zft8jLio3jBT8JZtW8=;
	b=fpZmpcL+aTIetu9TZRtWJZzKcc1JbXFAmr98taK00+pl9Ocw1XqfWmdEPaTKp+9+A8ibXI
	fQHgeDlUQXdgUbAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Add legacy topology parser
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153624.644448852@linutronix.de>
References: <20240212153624.644448852@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665504.398.13728389473007181111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     bda74aae20086c044b31ca0dcdab7deaaf23d0e8
Gitweb:        https://git.kernel.org/tip/bda74aae20086c044b31ca0dcdab7deaaf23d0e8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/cpu: Add legacy topology parser

The legacy topology detection via CPUID leaf 4, which provides the number
of cores in the package and CPUID leaf 1 which provides the number of
logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
is not set, is shared for Intel, Centaur and Zhaoxin CPUs.

Lift the code from common.c without the early detection hack and provide it
as common fallback mechanism.

Will be utilized in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153624.644448852@linutronix.de

---
 arch/x86/kernel/cpu/common.c          |  3 ++-
 arch/x86/kernel/cpu/topology.h        |  3 ++-
 arch/x86/kernel/cpu/topology_common.c | 46 +++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d674e7b..004ae9c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -892,6 +892,9 @@ void detect_ht(struct cpuinfo_x86 *c)
 #ifdef CONFIG_SMP
 	int index_msb, core_bits;
 
+	if (topo_is_converted(c))
+		return;
+
 	if (detect_ht_early(c) < 0)
 		return;
 
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 99c94c5..934a100 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -6,6 +6,9 @@ struct topo_scan {
 	struct cpuinfo_x86	*c;
 	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
+
+	/* Legacy CPUID[1]:EBX[23:16] number of logical processors */
+	unsigned int		ebx1_nproc_shift;
 };
 
 bool topo_is_converted(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 873d7c3..b0ff1fc 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -24,6 +24,48 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
+static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
+{
+	struct {
+		u32	cache_type	:  5,
+			unused		: 21,
+			ncores		:  6;
+	} eax;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	cpuid_subleaf_reg(4, 0, CPUID_EAX, &eax);
+	if (!eax.cache_type)
+		return 1;
+
+	return eax.ncores + 1;
+}
+
+static void __maybe_unused parse_legacy(struct topo_scan *tscan)
+{
+	unsigned int cores, core_shift, smt_shift = 0;
+	struct cpuinfo_x86 *c = tscan->c;
+
+	cores = parse_num_cores_legacy(c);
+	core_shift = get_count_order(cores);
+
+	if (cpu_has(c, X86_FEATURE_HT)) {
+		if (!WARN_ON_ONCE(tscan->ebx1_nproc_shift < core_shift))
+			smt_shift = tscan->ebx1_nproc_shift - core_shift;
+		/*
+		 * The parser expects leaf 0xb/0x1f format, which means
+		 * the number of logical processors at core level is
+		 * counting threads.
+		 */
+		core_shift += smt_shift;
+		cores <<= smt_shift;
+	}
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
+}
+
 bool topo_is_converted(struct cpuinfo_x86 *c)
 {
 	/* Temporary until everything is converted over. */
@@ -47,7 +89,7 @@ static bool fake_topology(struct topo_scan *tscan)
 	 * which has useless CPUID information.
 	 */
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
-	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 1, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
 	return tscan->c->cpuid_level < 1 || xen_pv_domain();
 }
@@ -88,6 +130,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	/* The above is sufficient for UP */
 	if (!IS_ENABLED(CONFIG_SMP))
 		return;
+
+	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 }
 
 static void topo_set_ids(struct topo_scan *tscan)

