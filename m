Return-Path: <linux-kernel+bounces-135800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4F89CB81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF271C2168F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CB14430E;
	Mon,  8 Apr 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYC1pa/g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F411442F3;
	Mon,  8 Apr 2024 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599793; cv=none; b=LmkFZ6zY5GoN1ZsNErvNbyV45kKOiqxoAjmDpDWxRR5iIm50e5uDnBcVmnnjswWjF67er68jZQaDk+LZWzZJ8GYPxd/Kwsh6CK3waV0hJZ3bZaXOwqRbWJnyaREZyABnmMbo1Cqu3lA4oFnvRKR1ez1h/kx4GUMgf3KlfFx8MLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599793; c=relaxed/simple;
	bh=RkoEUk6pO/u+YR/CXpMCXKkEmbizOoOkGt2cpPUNcJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsAR+lCneWT3kNeWxxtVZNSR9Lyh2RqaZcOSrtAffetvu+yHs0hkQtgEwMe8hqHeASvIzKH/Zx8X5IJoGcPimf5Hp5XKEgt3ainOVL37pLBeG+Buy8lxTadfGZUxKOdnft4IC6q9lx0WKEfYA7bsVpzkjiMQQHzRWUTcODiY4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYC1pa/g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712599792; x=1744135792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RkoEUk6pO/u+YR/CXpMCXKkEmbizOoOkGt2cpPUNcJw=;
  b=VYC1pa/g4mPJsQ7K6U2Jwsskg6WrpNVKUMQm05vJriWWv/3oR7WkostC
   Yhihk3TJ+30Foa/hHcl/EsqqiA3LDuA1SyNxznvheUG9dZMcBzUl00acE
   9/JVWXjFgh+GEBVbjz9mkOA3pqBDENuHO1KeAVjHRWwnVG49IkiiWDq+d
   AYQOcTOr1AzCFA615/KBlwMXNu/ssDkSdplRxCrNywtTyfSQS4N8t2BDq
   5gMa8Xwck7WqBlRtFN9uuFNmI6G/tlZWaIsBaQ3LmwxG9d6Ru2FEYD46k
   vzCA24Islz+20GQllaB5Mj37+inuDVhRE7xOpgjoIvXaTo6Ua6GNSBFXb
   Q==;
X-CSE-ConnectionGUID: EUdDhDdfSjyxNSD09v9tCg==
X-CSE-MsgGUID: KqjKxrymR0yubLrideP3yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8055873"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8055873"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:09:51 -0700
X-CSE-ConnectionGUID: wHVS94GMQC2YOYIw8d4wVQ==
X-CSE-MsgGUID: izCZq3L/QO60q9bhwJ0+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20050531"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:09:50 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/mce: Implement recovery for errors in TDX/SEAM non-root mode
Date: Mon,  8 Apr 2024 11:09:44 -0700
Message-ID: <20240408180944.44638-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Machine check SMIs (MSMI) signaled during SEAM operation (typically
inside TDX guests), on a system with Intel eMCA enabled, might eventually
be reported to the kernel #MC handler with the saved RIP on the stack
pointing to the instruction in kernel code after the SEAMCALL instruction
that entered the SEAM operation. Linux currently says that is a fatal
error and shuts down.

There is a new bit in IA32_MCG_STATUS that, when set to 1, indicates
that the machine check didn't originally occur at that saved RIP, but
during SEAM non-root operation.

Add new entries to the severity table to detect this for both data load
and instruction fetch that set the severity to "AR" (action required).

Increase the width of the mcgmask/mcgres fields in "struct severity"
from unsigned char to unsigned short since the new bit is in position 12.

Action required for these errors is just mark the page as poisoned and
return from the machine check handler.

Backport note. Little value in backporting this patch to stable or LTS
kernels as this is only relevant with support for TDX, which I assume
won't be backported. But for anyone taking this to v6.1 or older, you
also need commit a51cbd0d86d3 ("x86/mce: Use severity table to handle
uncorrected errors in kernel")

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
The SEAM_NR bit in IA32_MCG_STATUS hasn't yet made it into the Intel
Software Developers' Manual. But it is described in section 16.5.2
of "Intel(R) Trust Domain Extensions (Intel(R) TDX) Module Base
Architecture Specification" downloadable from:
https://cdrdv2.intel.com/v1/dl/getContent/733575
---
 arch/x86/include/asm/mce.h         |  2 ++
 arch/x86/kernel/cpu/mce/core.c     | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/mce/severity.c | 16 ++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de3118305838..dfd2e9699bd7 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -13,6 +13,7 @@
 #define MCG_CTL_P		BIT_ULL(8)   /* MCG_CTL register available */
 #define MCG_EXT_P		BIT_ULL(9)   /* Extended registers available */
 #define MCG_CMCI_P		BIT_ULL(10)  /* CMCI supported */
+#define MCG_SEAM_NR		BIT_ULL(12)  /* MCG_STATUS_SEAM_NR supported */
 #define MCG_EXT_CNT_MASK	0xff0000     /* Number of Extended registers */
 #define MCG_EXT_CNT_SHIFT	16
 #define MCG_EXT_CNT(c)		(((c) & MCG_EXT_CNT_MASK) >> MCG_EXT_CNT_SHIFT)
@@ -25,6 +26,7 @@
 #define MCG_STATUS_EIPV		BIT_ULL(1)   /* ip points to correct instruction */
 #define MCG_STATUS_MCIP		BIT_ULL(2)   /* machine check in progress */
 #define MCG_STATUS_LMCES	BIT_ULL(3)   /* LMCE signaled */
+#define MCG_STATUS_SEAM_NR	BIT_ULL(12)  /* Machine check inside SEAM non-root mode */
 
 /* MCG_EXT_CTL register defines */
 #define MCG_EXT_CTL_LMCE_EN	BIT_ULL(0) /* Enable LMCE */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 84d41be6d06b..771a9f183260 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1593,6 +1593,24 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		else
 			queue_task_work(&m, msg, kill_me_maybe);
 
+	} else if (m.mcgstatus & MCG_STATUS_SEAM_NR) {
+		/*
+		 * Saved RIP on stack makes it look like the machine check
+		 * was taken in the kernel on the instruction following
+		 * the entry to SEAM mode. But MCG_STATUS_SEAM_NR indicates
+		 * that the machine check was taken inside SEAM non-root
+		 * mode.  CPU core has already marked that guest as dead.
+		 * It is OK for the kernel to resume execution at the
+		 * apparent point of the machine check as the fault did
+		 * not occur there. Mark the page as poisoned so it won't
+		 * be added to free list when the guest is terminated.
+		 */
+		if (mce_usable_address(&m)) {
+			struct page *p = pfn_to_online_page(m.addr >> PAGE_SHIFT);
+
+			if (p)
+				SetPageHWPoison(p);
+		}
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..fc8988cfe1c3 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -39,8 +39,8 @@ static struct severity {
 	u64 mask;
 	u64 result;
 	unsigned char sev;
-	unsigned char mcgmask;
-	unsigned char mcgres;
+	unsigned short mcgmask;
+	unsigned short mcgres;
 	unsigned char ser;
 	unsigned char context;
 	unsigned char excp;
@@ -173,6 +173,18 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
 		USER
 		),
+	MCESEV(
+		AR, "Data load error in SEAM non-root mode",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
+		MCGMASK(MCG_STATUS_SEAM_NR, MCG_STATUS_SEAM_NR),
+		KERNEL
+		),
+	MCESEV(
+		AR, "Instruction fetch error in SEAM non-root mode",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
+		MCGMASK(MCG_STATUS_SEAM_NR, MCG_STATUS_SEAM_NR),
+		KERNEL
+		),
 	MCESEV(
 		PANIC, "Data load in unrecoverable area of kernel",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),

base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.44.0


