Return-Path: <linux-kernel+bounces-82150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB49867FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E957F1F2929B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B412F5A0;
	Mon, 26 Feb 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZmVyXiG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsamHHeC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2C5B1F2;
	Mon, 26 Feb 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973098; cv=none; b=pJ6kuQy3sfSudQa+7bRvvgHLiRfnJvEHsOqySH2FfHyXUvv3iDDWlQgYaRxh7iRvzrqpuD8RgmHyGMj2BfR02Lz3/OLsN5tS7dCYIQgbZyP1LMpjXmTlIhPcsterJGKAtyptPU3PXIhxMk5uwNOKjcQMb9NhPlOzUZIT3fgQYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973098; c=relaxed/simple;
	bh=5opxw29a0zAUSmy9tNDOLkWarbNW1U7+rcKPIipFIcc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WrdoM+8HiJPtOl5gjGMdu6pQjpodSrZmBIj44m0vTOXz+rpScKIU/KxB7J8NhIL5aKRhd6zbs4j5Q1z0bJo4jCxqc8OOsLzH+QN9NhW8AjpRSWCz8L0hG2nRjIL1wk6sRJ9OHldRlnavSlk5SzoWntnJ5VvPIl4K/XT2QPsxU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZmVyXiG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsamHHeC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 18:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708973095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1g9cKAZ/tSxf3EgjrnRT/rCnnpm3vr3MgTAd40gxhbc=;
	b=iZmVyXiGIxtB6/diS2npn2J4q0LwBZ9xopzkQlhip038mk2ei5+GlO8CvkR9+bphrDggGt
	o4uv1f4TAySD34M+SR18XBzPmnVUBB463EV1uZh8ut9plNveKoTL2qMzgADRd9l9o9jdcy
	Cn8bGk7jpnDtYTe80ftdoChGKnIKhntxsXadbEVCtYmMKeGr/u1AcwDphvoNzZ5rBP3k3O
	2P5Q6cc8dgUGXFH7d6B95HVJgWtYHPK+JMuuwYuM4rp7tKloOEjbQt2ZzcEQy4tGMlBy36
	KOa4GcDX9+YC6M83bDDnEXvXoVXU8/hMPqOwZc9jcxD8vZ5ZFa1fuvnqm+jazQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708973095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1g9cKAZ/tSxf3EgjrnRT/rCnnpm3vr3MgTAd40gxhbc=;
	b=vsamHHeCPupO8EzZvfjc21C+5YFEloDhLG+FtEarNZIrM+tU+BcD4YNRXVpNjxAgURjta/
	FX8O//sN+8r4f0Bg==
From: "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/intel: Detect TME keyid bits before setting
 MTRR mask registers
Cc: Zixi Chen <zixchen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170897309415.398.2410668420292163914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6890cb1ace350b4386c8aee1343dc3b3ddd214da
Gitweb:        https://git.kernel.org/tip/6890cb1ace350b4386c8aee1343dc3b3ddd214da
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Thu, 01 Feb 2024 00:09:02 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Feb 2024 08:16:16 -08:00

x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

MKTME repurposes the high bit of physical address to key id for encryption
key and, even though MAXPHYADDR in CPUID[0x80000008] remains the same,
the valid bits in the MTRR mask register are based on the reduced number
of physical address bits.

detect_tme() in arch/x86/kernel/cpu/intel.c detects TME and subtracts
it from the total usable physical bits, but it is called too late.
Move the call to early_init_intel() so that it is called in setup_arch(),
before MTRRs are setup.

This fixes boot on TDX-enabled systems, which until now only worked with
"disable_mtrr_cleanup".  Without the patch, the values written to the
MTRRs mask registers were 52-bit wide (e.g. 0x000fffff_80000800) and
the writes failed; with the patch, the values are 46-bit wide, which
matches the reduced MAXPHYADDR that is shown in /proc/cpuinfo.

Reported-by: Zixi Chen <zixchen@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240131230902.1867092-3-pbonzini%40redhat.com
---
 arch/x86/kernel/cpu/intel.c | 178 +++++++++++++++++------------------
 1 file changed, 91 insertions(+), 87 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8f..40dec9b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -184,6 +184,90 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+#define MSR_IA32_TME_ACTIVATE		0x982
+
+/* Helpers to access TME_ACTIVATE MSR */
+#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
+#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
+
+#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
+#define TME_ACTIVATE_POLICY_AES_XTS_128	0
+
+#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
+
+#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
+#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
+
+/* Values for mktme_status (SW only construct) */
+#define MKTME_ENABLED			0
+#define MKTME_DISABLED			1
+#define MKTME_UNINITIALIZED		2
+static int mktme_status = MKTME_UNINITIALIZED;
+
+static void detect_tme_early(struct cpuinfo_x86 *c)
+{
+	u64 tme_activate, tme_policy, tme_crypto_algs;
+	int keyid_bits = 0, nr_keyids = 0;
+	static u64 tme_activate_cpu0 = 0;
+
+	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
+
+	if (mktme_status != MKTME_UNINITIALIZED) {
+		if (tme_activate != tme_activate_cpu0) {
+			/* Broken BIOS? */
+			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: MKTME is not usable\n");
+			mktme_status = MKTME_DISABLED;
+
+			/* Proceed. We may need to exclude bits from x86_phys_bits. */
+		}
+	} else {
+		tme_activate_cpu0 = tme_activate;
+	}
+
+	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
+		pr_info_once("x86/tme: not enabled by BIOS\n");
+		mktme_status = MKTME_DISABLED;
+		return;
+	}
+
+	if (mktme_status != MKTME_UNINITIALIZED)
+		goto detect_keyid_bits;
+
+	pr_info("x86/tme: enabled by BIOS\n");
+
+	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
+	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
+		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
+
+	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
+	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
+		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
+				tme_crypto_algs);
+		mktme_status = MKTME_DISABLED;
+	}
+detect_keyid_bits:
+	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
+	nr_keyids = (1UL << keyid_bits) - 1;
+	if (nr_keyids) {
+		pr_info_once("x86/mktme: enabled by BIOS\n");
+		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
+	} else {
+		pr_info_once("x86/mktme: disabled by BIOS\n");
+	}
+
+	if (mktme_status == MKTME_UNINITIALIZED) {
+		/* MKTME is usable */
+		mktme_status = MKTME_ENABLED;
+	}
+
+	/*
+	 * KeyID bits effectively lower the number of physical address
+	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 */
+	c->x86_phys_bits -= keyid_bits;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -322,6 +406,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (detect_extended_topology_early(c) < 0)
 		detect_ht_early(c);
+
+	/*
+	 * Adjust the number of physical bits early because it affects the
+	 * valid bits of the MTRR mask registers.
+	 */
+	if (cpu_has(c, X86_FEATURE_TME))
+		detect_tme_early(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -482,90 +573,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-#define MSR_IA32_TME_ACTIVATE		0x982
-
-/* Helpers to access TME_ACTIVATE MSR */
-#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
-#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
-
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
-#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
-
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
-static void detect_tme(struct cpuinfo_x86 *c)
-{
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
-
-	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
-
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
-	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
-		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
-		return;
-	}
-
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
-	pr_info("x86/tme: enabled by BIOS\n");
-
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
-	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
-	nr_keyids = (1UL << keyid_bits) - 1;
-	if (nr_keyids) {
-		pr_info_once("x86/mktme: enabled by BIOS\n");
-		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
-	} else {
-		pr_info_once("x86/mktme: disabled by BIOS\n");
-	}
-
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
-
-	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-	 */
-	c->x86_phys_bits -= keyid_bits;
-}
-
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
@@ -702,9 +709,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_ia32_feat_ctl(c);
 
-	if (cpu_has(c, X86_FEATURE_TME))
-		detect_tme(c);
-
 	init_intel_misc_features(c);
 
 	split_lock_init();

