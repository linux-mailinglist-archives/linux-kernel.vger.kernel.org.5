Return-Path: <linux-kernel+bounces-134661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C57689B494
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900421C20BCA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F88446B7;
	Sun,  7 Apr 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEHELQS3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852C1E893;
	Sun,  7 Apr 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712532030; cv=none; b=X+3+V7z0vp0TAunwUIttnkMfxw41iS++kx4JOxi9JLAg1uoylGRlvcSkHhWk8Fi0YLG2/0lAVeVh/39jwBzAczLIK3b4IqnKwLy3VGAedv0vzsQNR131oBOxahcPORL6QOdGxpoCUsLc27WqAQyhge3WMZrp1qsCdM3rYvTApM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712532030; c=relaxed/simple;
	bh=Y/j0qNmFRDBaKOS+TGqHbCS5rou+RE1grg9TlB3OhyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGd9S1N4tTL8fLab3w2mC5v5G9Rz0U4eXgfImTTaWg2GW1d+v4JEg5JlBubeM10FNtLySafXapu9xFrptQEclZWjpMnYqKxZGLEb/fxUzcI4cc20547kwoxjxVZfiRE49qXfNohj36QFujvDiFtvGcHI7cAWkPV7koI3MUtVGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEHELQS3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712532027; x=1744068027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/j0qNmFRDBaKOS+TGqHbCS5rou+RE1grg9TlB3OhyY=;
  b=jEHELQS3IPTwloyjvcSlcY1zjF2ldljFZvTOrz25AVLWoADg5YdTADOm
   hY+22hLFP60coBEg4YSORfjvVahMSYkL4Ko61eIrY1hPc25WuRqYV4ltl
   9MgGa4Jv27Fmz0ezUxSNmsZE97h8GNvE0Jx+HQGLmjgu/f2uEjBO+9nt3
   8XIlIcvlaNq9lAc4/vtWGZK33moB5kBSR4jC9gqM9QzqqOutxTHi+H0d8
   Fw/ECofzBVDC6NCx3IesSGjRTBrTqjpoBFfxaXWUfNzGWgs1Pj5INPfn5
   4DfWn8lDvua93IIdA6RTywL15stgbFWKAS5NZ0JDKPC/jVCRgyPcb7q9O
   w==;
X-CSE-ConnectionGUID: QR732DZOQ82jVky8OYvo1g==
X-CSE-MsgGUID: rT5Z06ylTGuZTak04ViHsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7704012"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7704012"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 16:20:27 -0700
X-CSE-ConnectionGUID: 9waKUil4QDaN6QUvkUIM5g==
X-CSE-MsgGUID: i9QBSZRrQ4Sg4FoWsI7k0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="50678941"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2024 16:20:27 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com,
	Dave Hansen <dave.hansen@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v9a 10/14] x86/cpu/keylocker: Check Gather Data Sampling mitigation
Date: Sun,  7 Apr 2024 16:04:32 -0700
Message-Id: <20240407230432.912290-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329065742.fc5of75e776y2g4b@desk>
References: <20240329065742.fc5of75e776y2g4b@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gather Data Sampling is a transient execution side channel issue in some
CPU models. The stale data in registers is not guaranteed as secure when
this vulnerability is not addressed.

In the Key Locker usage during AES transformations, the temporary storage
of the original key in registers poses a risk. The key material can be
staled in some implementations, leading to susceptibility to leakage of
the AES key.

To mitigate this vulnerability, a qualified microcode image must be
applied. Add code to ensure that the mitigation is installed and securely
locked. Disable the feature, otherwise.

Expand gds_ucode_mitigated() to examine the lock state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Changes from v9:
* Removed MSR reads and utilized the helper function. (Pawan Gupta)

Alternatively, 'gds_mitigation' can be exported and referenced directly.
Using 'gds_mitigation == GDS_MITIGATION_FULL_LOCKED' may also be
readable. However, it was opted to expand gds_ucode_mitigated() for
consistency, as it is already established.

Note that this approach aligns with Intel's guidance, as the bugs.c code
checks the following MSR bits:
  "Intel recommends that system software does not enable Key Locker (by
   setting CR4.KL) unless the GDS mitigation is enabled
   (IA32_MCU_OPT_CTRL[GDS_MITG_DIS] (bit 4) is 0) and locked
   (IA32_MCU_OPT_CTRL [GDS_MITG_LOCK](bit 5) is 1)."

For more information, refer to Intel's technical documentation on Gather
Data Sampling:
  https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/gather-data-sampling.html
---
 arch/x86/include/asm/processor.h |  7 ++++++-
 arch/x86/kernel/cpu/bugs.c       |  5 ++++-
 arch/x86/kernel/keylocker.c      | 12 ++++++++++++
 arch/x86/kvm/x86.c               |  2 +-
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..74eaa3a2b85b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -721,7 +721,12 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
-extern bool gds_ucode_mitigated(void);
+enum mitigation_info {
+	MITG_FULL,
+	MITG_LOCKED,
+};
+
+extern bool gds_ucode_mitigated(enum mitigation_info mitg);
 
 /*
  * Make previous memory operations globally visible before
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e7ba936d798b..80f6e70619cb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -752,8 +752,11 @@ static const char * const gds_strings[] = {
 	[GDS_MITIGATION_HYPERVISOR]	= "Unknown: Dependent on hypervisor status",
 };
 
-bool gds_ucode_mitigated(void)
+bool gds_ucode_mitigated(enum mitigation_info mitg)
 {
+	if (mitg == MITG_LOCKED)
+		return gds_mitigation == GDS_MITIGATION_FULL_LOCKED;
+
 	return (gds_mitigation == GDS_MITIGATION_FULL ||
 		gds_mitigation == GDS_MITIGATION_FULL_LOCKED);
 }
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 1e81d0704eea..23cf4a235f11 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -113,6 +113,15 @@ void restore_keylocker(void)
 	valid_wrapping_key = false;
 }
 
+/* Check if Key Locker is secure enough to be used. */
+static bool __init secure_keylocker(void)
+{
+	if (boot_cpu_has_bug(X86_BUG_GDS) && !gds_ucode_mitigated(MITG_LOCKED))
+		return false;
+
+	return true;
+}
+
 static int __init init_keylocker(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -126,6 +135,9 @@ static int __init init_keylocker(void)
 		goto clear_cap;
 	}
 
+	if (!secure_keylocker())
+		goto clear_cap;
+
 	cr4_set_bits(X86_CR4_KEYLOCKER);
 
 	/* AESKLE depends on CR4.KEYLOCKER */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47d9f03b7778..4ab50e95fdb5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1675,7 +1675,7 @@ static u64 kvm_get_arch_capabilities(void)
 		 */
 	}
 
-	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated())
+	if (!boot_cpu_has_bug(X86_BUG_GDS) || gds_ucode_mitigated(MITG_FULL))
 		data |= ARCH_CAP_GDS_NO;
 
 	return data;
-- 
2.40.1


