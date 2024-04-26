Return-Path: <linux-kernel+bounces-159499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003F8B2F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBD61F2242B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45108286F;
	Fri, 26 Apr 2024 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyKFRamw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170877F15
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105499; cv=none; b=byae2DAwoYy3i3AW7am7d/mXl64toNIjWqdW2Q/uzn3PM8gB+ceTFExYx+91fd1k1dxmN2hdzQxb0h2HJoer5JrI38nNR+ratwbXKy3ANwIe1qwcE0UV1m0XUJS3KvUm2++iGMzgvGJcHQLHudT++RTkfgVXn45IoR+rH0uvv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105499; c=relaxed/simple;
	bh=VdW9bdPBRWMTWRlwkRdzEvAoS7wssdCcrk8FGuTdAKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teIeTeKDZPyuh4sYokw3BTkjFLUF/vMl7xmPWOqHFllSt27bm1ocJ2bEA3pJiOMgAi/b0XsZFfmxoTWGVRmsT9xsojx754g7W5exN8J8kk2AtwEXFnb8FPhg7dv0Ri/MBGZNW+T0eiiJN/LMpBQd1xU362sy63IssMV9FkJgUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyKFRamw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714105497; x=1745641497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VdW9bdPBRWMTWRlwkRdzEvAoS7wssdCcrk8FGuTdAKE=;
  b=LyKFRamwdQVxBEu5/WuCa+MUgN2yWqwFs48C0lGAuKWdQFuVi/tMaZ1o
   pC8a8suPKDUusmjyyA4Kgr2mzn77+WGL3/Q4Kb4PwA1O/Jn5UY5yE2Mnv
   OoXyH5WNdsylnanF2KhpTZcQSNENlpBQhVa+rFrq4oFIZ1f68f1qCznyj
   1jItF7tFXFJ6VnLlX2vJonyIoyIeZ6HWOSYX4YZ8mQ2pl2bE96GQifMGD
   DXGmU6eTs2dNdTZbLVkIPR9MycMh8TYJSf5kdNgiJYNuJpRPVnojP5Bpi
   uWr4kNuwTInjervN91NYZmIapim1VOsTKDtPnupgPYX+qgJYvlWaAJe9d
   g==;
X-CSE-ConnectionGUID: eUaDpSC+SmCi+3CBTaEptA==
X-CSE-MsgGUID: 6Mc62z76Slmg9qZZnSk/4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13613168"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="13613168"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:24:56 -0700
X-CSE-ConnectionGUID: bT9pix3ETAeyiWxbIqhMKg==
X-CSE-MsgGUID: Z4ULzVupSEO8Ix75ghNlzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="30099328"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:24:55 -0700
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/cpu: Remove useless work in detect_tme_early()
Date: Thu, 25 Apr 2024 21:24:52 -0700
Message-Id: <4e159cdb00907dd7884c191acdab3a028d2f4857.1713929290.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713929290.git.alison.schofield@intel.com>
References: <cover.1713929290.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

TME (Total Memory Encryption) and MKTME (Multi-Key Total Memory
Encryption) BIOS detection were introduced together here [1] and
are loosely coupled in the Intel CPU init code.

TME is a hardware only feature and its BIOS status is all that needs
to be shared with the kernel user: enabled or disabled. The TME
algorithm the BIOS is using and whether or not the kernel recognizes
that algorithm is useless to the kernel user.

MKTME is a hardware feature that requires kernel support. MKTME
detection code was added in advance of broader kernel support for
MKTME that never followed. So, rather than continuing to emit
needless and confusing messages about BIOS MKTME status, remove
most of the MKTME pieces from detect_tme_early().

Keep one important piece: when the BIOS is configured with MKTME
'on' any BIOS defined KeyID bits do take away from the physaddr bits
available in the kernel. Add a pr_info_once() informing about the
enabled keyids so the user can address (by rebooting with MKTME off)
if the user needs to recover the MKTME consumed bits.

There is no functional change for the user, only this change in boot
messages:

Before:
[] x86/tme: enabled by BIOS
[] x86/tme: Unknown policy is active: 0x2
[] x86/mktme: No known encryption algorithm is supported: 0x4
[] x86/mktme: enabled by BIOS
[] x86/mktme: 127 KeyIDs available

After:
[] x86/tme: enabled by BIOS
[] x86/mktme: BIOS enabled 127 keyids

[1] cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 71 +++++++------------------------------
 1 file changed, 12 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3c3e7e5695ba..83865897a2a7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -190,83 +190,36 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
 #define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
 
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
 #define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
 
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
 static void detect_tme_early(struct cpuinfo_x86 *c)
 {
-	u64 tme_activate, tme_policy, tme_crypto_algs;
 	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
+	u64 tme_activate;
 
 	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
 
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
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
 		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
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
+	pr_info_once("x86/tme: enabled by BIOS\n");
 	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
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
+	if (!keyid_bits)
+		return;
 
 	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 * KeyID bits are set by BIOS and can be present regardless
+	 * of whether the kernel is using them. They effectively lower
+	 * the number of physical address bits.
+	 *
+	 * Update cpuinfo_x86::x86_phys_bits accordingly.
 	 */
 	c->x86_phys_bits -= keyid_bits;
+	nr_keyids = (1UL << keyid_bits) - 1;
+
+	pr_info_once("x86/mktme: BIOS enabled %d keyids\n", nr_keyids);
 }
 
 static void early_init_intel(struct cpuinfo_x86 *c)
-- 
2.37.3


