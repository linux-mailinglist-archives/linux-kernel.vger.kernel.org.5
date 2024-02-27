Return-Path: <linux-kernel+bounces-84040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023B86A1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27CB1C25868
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6E158D8F;
	Tue, 27 Feb 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsWJYbi+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F238158D65
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069115; cv=none; b=K4/eNE5BnBwMJ0iHxSnc8zCLIFdedqZ3x7WS8/KhlX8pAfgOVwWE6Bn8ciH14H5azRGub5xTvPwWrJUe/dQ5z3ku/GB1H9OzWTR+LgV1v/CZgkz2mYUX19/ZID08K5oTuzOtrj6vQb72SC5x9rFGqBQ/SwBrC74sLWwIOX5f7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069115; c=relaxed/simple;
	bh=D4SysnZaXorUFc+XF+aGbS1csNj7xK6JLwiHqGE+3Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8eSUqofGfm5axrLOQk972VPxbAcI/RK1Uz7jbgKkdhb7Fcjy30g1j6oQDrgCAd7nFwvoHApmZ4xHcfR2x73qgRHRYxkiN9nQRdDbFvABVhmM1IinZGYZCsEjnzwAxYeLTLR+eqvUsU3qF9+lqFeknEQ9c336YAO9GbzbKBclig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsWJYbi+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069115; x=1740605115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4SysnZaXorUFc+XF+aGbS1csNj7xK6JLwiHqGE+3Sk=;
  b=ZsWJYbi+NT1lZjnRH7rmr1RX2o6Shk+rJr2QMexGHQ6rq/Gkgv6cZ2Gp
   ztCM9m5cQGxLUy27BSQ0z0rsGgjJZiC/Tt6xkK7HYTMUiBRoR1/Y6CzG6
   u2QrIwvVpWVZeRlUxE/5ELm3xIAT3Nb9/6qNcNrB+jLGqsOgm9T0XNE+c
   FJ9Vw6FA91Cd3t+wfPzr5TVr6/cshgFDp/5vBqlVc3Ih24Bbjz0iw/q7f
   CQme8TOgEI/FK/pvDs2N2FxMf++wMBcO16qkROlvnO4k+YGSsJKGWgfs+
   j7nRhpi3xiZHg6RPnPTtOBgSHQMM50RqcYmnNRPjJvH5mvw+QZSxdO6co
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3567045"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3567045"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032914"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032914"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:25:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9E2D31033; Tue, 27 Feb 2024 23:24:56 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 14/17] x86/smp: Add smp_ops.stop_this_cpu() callback
Date: Tue, 27 Feb 2024 23:24:49 +0200
Message-ID: <20240227212452.3228893-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the helper is defined, it is called instead of halt() to stop the CPU
at the end of stop_this_cpu() and on crash CPU shutdown.

ACPI MADT will use it to hand over the CPU to BIOS in order to be able
to wake it up again after kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/process.c  | 7 +++++++
 arch/x86/kernel/reboot.c   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..390d53fd34f9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,6 +38,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*stop_this_cpu)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..00c1b957476d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+#ifdef CONFIG_SMP
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+#endif
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0574d4ad6b41..0a75efe579c0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -880,6 +880,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
+
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+
 	/* Assume hlt works */
 	halt();
 	for (;;)
-- 
2.43.0


