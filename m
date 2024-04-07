Return-Path: <linux-kernel+bounces-134382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43D89B0DC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F9AB21505
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00102C1BC;
	Sun,  7 Apr 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etDGvSEY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96D2BAE7
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493918; cv=none; b=Yzw6CCr5RbXtuwNQEWcA1GU/SKkBT+GZEMty30iQx5L1Zfe4HR3V4TRN5HItUY42wfUmKN284aI8LL1mCk5w7xFjv4mr5D0Z7a+foFXD5Xi0hftx7KSdgdsLN1GTb2lUmbpixD1x3lhwRoPgZtf4Szj7ltyqpMxj/R8W89BxSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493918; c=relaxed/simple;
	bh=ZkR1EiJggDNyuzKlUoPpjBGIiqt0tELn3Ew37L5rYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFuMBWEjecvJv8krpbceXaCdhyxpr19CaUBimN8M/BQi6+tH2m9J1YkIMD3n0erSOyT0tyy3QWnZwcGgfNPS/UI1s322jZLOZ4U0S0wNdDtpBjcxt0nHrZ8icoNSZ3dyUFz71olujaabZDuaOkLgV98nsx/fn3vHGB6Awdo2/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etDGvSEY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712493917; x=1744029917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZkR1EiJggDNyuzKlUoPpjBGIiqt0tELn3Ew37L5rYo8=;
  b=etDGvSEY1DK4MTbqnRoom5fC5dF6dQRs0rpP1oEc38ra5fcYBi3FPgjm
   H6I55r6c7gZqIXzF5PB/AtFcWd4RX0KvoEz4UX3khNAY9E9VDc3Z2sTnX
   /iPFmy7seBhpR8rXHmzGSjLkpDtM5NGG0YxPQ0fYKiCXkn0vxqmgOLSrZ
   Gle+GSSUoaUQK2IXj3+s/2vkCWXfR7RoOI/UACyZWzVxn4he5L6Ok5iXY
   KFnVtQMQloPy+oYE5VoCaTsu5lWnG5kmqypJsarNTmzOvHxYRw9d4uXrk
   B8AueEXw38NIpJ6yhpYPwwyF5NBNsZ8ca3k+OSX0aFCEXtLXseds969E4
   Q==;
X-CSE-ConnectionGUID: nyIgkqk5RBKDrv8U8555kg==
X-CSE-MsgGUID: H5DHvaSZSACOuKfdylu0ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11564050"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11564050"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:17 -0700
X-CSE-ConnectionGUID: RwtkdjYzQo2uNlUaD9AIuw==
X-CSE-MsgGUID: xQXHZH8kQg6htPdnXZPDqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20185642"
Received: from mirtanji-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.14.88])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:13 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
Date: Mon,  8 Apr 2024 00:44:54 +1200
Message-ID: <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712493366.git.kai.huang@intel.com>
References: <cover.1712493366.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

Change to do unconditional WBINVD in stop_this_cpu() for bare metal
to cover kexec support for both AMD SME and Intel TDX, despite there
_was_ some issue preventing from doing so but now has it got fixed.

Long version:

Both SME and TDX can leave caches in incoherent state due to memory
encryption.  During kexec, the caches must be flushed before jumping to
the second kernel to avoid silent memory corruption to the second kernel.

Currently, for SME the kernel only does WBINVD in stop_this_cpu() when
the kernel determines the hardware supports SME.  To support TDX, one
option is to extend that specific check to cover both SME and TDX.

However, instead of sprinkling around vendor-specific checks, it's
better to just do unconditional WBINVD.  Kexec() is a slow path, and it
is acceptable to have an additional WBINVD in order to have simple
and easy to maintain code.

But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
guests will get unexpected (and yet unnecessary) #VE and may not be able
to handle (e.g., TDX guest panics when it gets #VE due to WBINVD).

Note:

Historically, there _was_ an issue preventing doing unconditional WBINVD
but that has been fixed.

When SME kexec() support was initially added in commit

  bba4ed011a52: ("x86/mm, kexec: Allow kexec to be used with SME")

WBINVD was done unconditionally.  However since then some issues were
reported that different Intel systems would hang or reset due to that
commit.

To try to fix, a later commit

  f23d74f6c66c: ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")

then changed to only do WBINVD when hardware supports SME.

While this commit made the reported issues go away, it didn't pinpoint
the root cause.  Also, it didn't handle a corner case[*] correctly, which
resulted in the reveal of the root cause and the final fix by commit

  1f5e7eb7868e: ("x86/smp: Make stop_other_cpus() more robust")

See [1][2] for more information.

Further testing of doing unconditional WBINVD based on the above fix on
the problematic machines (that issues were originally reported)
confirmed the issues couldn't be reproduced.

See [3][4] for more information.

Therefore, it is safe to do unconditional WBINVD now.

[*] The commit didn't check whether the CPUID leaf is available or not.
Making unsupported CPUID leaf on Intel returns garbage resulting in
unintended WBINVD which caused some issue (followed by the analysis and
the reveal of the final root cause).  The corner case was independently
fixed by commit

  9b040453d444: ("x86/smp: Dont access non-existing CPUID leaf")

[1]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#m300f3f9790850b5daa20a71abcc200ae8d94a12a
[2]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#ma7263a7765483db0dabdeef62a1110940e634846
[3]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#mc043191f2ff860d649c8466775dc61ac1e0ae320
[4]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#md23f1a8f6afcc59fa2b0ac1967f18e418e24347c

Signed-off-by: Kai Huang <kai.huang@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
---

v2 -> v3:
 - Change to only do WBINVD for bare metal

---
 arch/x86/kernel/process.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..5ba8a9c1e47a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
 	mcheck_cpu_clear(c);
 
 	/*
-	 * Use wbinvd on processors that support SME. This provides support
-	 * for performing a successful kexec when going from SME inactive
-	 * to SME active (or vice-versa). The cache must be cleared so that
-	 * if there are entries with the same physical address, both with and
-	 * without the encryption bit, they don't race each other when flushed
-	 * and potentially end up with the wrong entry being committed to
-	 * memory.
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Flush cache to avoid silent memory
+	 * corruption for these platforms.
 	 *
-	 * Test the CPUID bit directly because the machine might've cleared
-	 * X86_FEATURE_SME due to cmdline options.
+	 * stop_this_cpu() is not a fast path, just do unconditional
+	 * WBINVD for simplicity.  But only do WBINVD for bare-metal
+	 * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
+	 * (and unnecessary) #VE and may unable to handle.
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		native_wbinvd();
 
 	/*
-- 
2.43.2


