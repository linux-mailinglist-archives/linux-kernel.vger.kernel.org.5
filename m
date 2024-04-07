Return-Path: <linux-kernel+bounces-134662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAC89B496
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C5F281358
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2E4642B;
	Sun,  7 Apr 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6N5VUnc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233EC45951;
	Sun,  7 Apr 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712532040; cv=none; b=N/nrTWkL6K758rf7qC4DGni2JHY37kxgh/PuuzXuHjf8i7S+mwOm5/AzLEvfWqLeohBC7y2BVJbh8s9gcRa7oZniPFUGzPKtBqlvk1ZpqmxagyLdfg5+q+nivSJ0vNznQl0a+/BG4LISEPInxjCozcjM+FIsrAWE2mGl9mHsTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712532040; c=relaxed/simple;
	bh=9QDRwKQcp+Etmkpf3eb7UKBNnIpkotHX2gTPqHqq1G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPaT7DFI3qzVj2MzqseS4Vv3rGFRdjClxjNBOGwMERDxlggIG0++Kl8mUAIkWUiDH1OfARWtTuMyHSG9Lsy1hlnLwqrbZyZhyqrPU03AJEcR8qxh5trAgNuTNPLQ/0Kx3fgQ0jtcHboEOGfOrBV1kdTHrQH1S1kvMx15rDQYQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6N5VUnc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712532038; x=1744068038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9QDRwKQcp+Etmkpf3eb7UKBNnIpkotHX2gTPqHqq1G4=;
  b=m6N5VUncNf7XJKl1gxknbYz1/+zhY4/xBZTHl3x6yXPTu2XfqsqV93lA
   +xl9y8ZGrmwi9ZafStyUJ8Uy8Cb+bMZMk+pbeKZxiX5bP6if7ylKj6720
   A8Aas6ztVP1nOdJqkiYBeWGyd+bbCb3hDil2sThznBAjgkV1e4Qd7emwH
   QSnu2Rq8RO7jBGUuwQoIE/a7KyTazY5Q+opmLHFx/+oj//DqDZXMz1kyd
   g7+7eyan205SNry67Co5rcy/ruCN/PFHqJIR5w87jVY3UoqYv31rLyBnZ
   ppQV78QK1I/CwNHTN1bkF4bZkN0b00FJUe8anqScwKLzryrRZwounnsG+
   g==;
X-CSE-ConnectionGUID: cnGsA71lQTaLNxKoBC6voQ==
X-CSE-MsgGUID: H+/RGCBgRZeWvtYKb/IiFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11570820"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11570820"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 16:20:37 -0700
X-CSE-ConnectionGUID: AXJleEeiRaqTLCoYOQ1O5A==
X-CSE-MsgGUID: jigVE6a0TSylKehw1XiG/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20269689"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa008.jf.intel.com with ESMTP; 07 Apr 2024 16:20:35 -0700
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
Subject: [PATCH v9a 11/14] x86/cpu/keylocker: Check Register File Data Sampling mitigation
Date: Sun,  7 Apr 2024 16:04:43 -0700
Message-Id: <20240407230443.912306-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329062057.kt5dkoffbkkxdt7x@desk>
References: <20240329062057.kt5dkoffbkkxdt7x@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Register File Data Sampling vulnerability may allow malicious
userspace programs to infer stale kernel register data, potentially
exposing sensitive key values, including AES keys.

To address this vulnerability, a microcode update needs to be applied to
the CPU, which modifies the VERW instruction to flush the affected CPU
buffers.

Reference the 'rfds_mitigation' variable to check the mitigation status.
Do not enable Key Locker on CPUs affected by the vulnerability but
lacking mitigation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Changes from v9:
* Remove the helper function and simplify the code by directly reading
  the status variable. (Pawan Gupta)

Note that this code change aligns with mitigation guidance, which
recommends:
  "Software loading Key Locker keys using LOADIWKEY should execute a VERW
   to clear registers before transitioning to untrusted code to prevent
   later software from inferring the loaded key."

For more information, refer to Intel's guidance on Register File Data
Sampling:
  https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/register-file-data-sampling.html
---
 arch/x86/include/asm/processor.h | 8 ++++++++
 arch/x86/kernel/cpu/bugs.c       | 8 +-------
 arch/x86/kernel/keylocker.c      | 3 +++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 74eaa3a2b85b..b823163f4786 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -728,6 +728,14 @@ enum mitigation_info {
 
 extern bool gds_ucode_mitigated(enum mitigation_info mitg);
 
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+extern enum rfds_mitigations rfds_mitigation;
+
 /*
  * Make previous memory operations globally visible before
  * a WRMSR.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 80f6e70619cb..a2ba1a0ef872 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -483,14 +483,8 @@ early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)	"Register File Data Sampling: " fmt
 
-enum rfds_mitigations {
-	RFDS_MITIGATION_OFF,
-	RFDS_MITIGATION_VERW,
-	RFDS_MITIGATION_UCODE_NEEDED,
-};
-
 /* Default mitigation for Register File Data Sampling */
-static enum rfds_mitigations rfds_mitigation __ro_after_init =
+enum rfds_mitigations rfds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
 
 static const char * const rfds_strings[] = {
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 23cf4a235f11..09876693414c 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -119,6 +119,9 @@ static bool __init secure_keylocker(void)
 	if (boot_cpu_has_bug(X86_BUG_GDS) && !gds_ucode_mitigated(MITG_LOCKED))
 		return false;
 
+	if (boot_cpu_has_bug(X86_BUG_RFDS) && rfds_mitigation != RFDS_MITIGATION_VERW)
+		return false;
+
 	return true;
 }
 
-- 
2.40.1


