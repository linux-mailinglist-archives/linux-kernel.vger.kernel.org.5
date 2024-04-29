Return-Path: <linux-kernel+bounces-161950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6888B53B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03161282636
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065E3AC08;
	Mon, 29 Apr 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3apCYB1m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTLgqw/a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54225750;
	Mon, 29 Apr 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381325; cv=none; b=QQoWeIuwBl4L0MMoo/yER9Q919QMxxPaq0V5asA8vb/aCiC54/SwYDcLGbDKo1tmvQcSwcmA6iHUfXWZ3JIlZtzMPc9ArN7kpXl8zOzVat8d+WvUGQqwZke66Q4L4hs6KKkcU1oFN+oUz0bsSlfLeHXAz7bxGbTpTWWi3l+dCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381325; c=relaxed/simple;
	bh=I/lUS3ILvzQeKH/WKcIv3q5Y/VKs4bYf1oNhmDJDBvM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OHh5klI4n2/O9/ftQRaZ+HP4ZG7l0GYed6T7nUm2r9hpaB73f+HgMvPIgbtBIcPAZJM/KtEfK4g1LI8ndjhkXyzpzAIheDJuh3WctPSsXJx8a+52vtN2ixu3DE3ydrQ8fCvnOHlof20nnyH0fnYd3iOL7JTGP5HsOG7b+NYXJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3apCYB1m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTLgqw/a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dxmqiJY3dxPmmf73vWJWQhlFW14yQvGIrlB1SIjmOCY=;
	b=3apCYB1mDTlDNcNJHm1VMx+roiF+SLHXz1y12PrAox9M3sE0O6joHHDo9P3/zyPvtJUJ4a
	KMXLoYRiqV7RnxT3j0bKxd3Nx7P89g1wHrWmrsheg9MWYFP7RBD4FolGQ86JZrgcUxyjxK
	ZBMqnNpZ54d4GYekrUZis0gAt7C+j5mphHuWA0y/Mo5ZUmQ+Yq4PQ0gIFpdKQ33H5d4rMt
	aOx2zVsbtKAlFutqh2d7kL5idjnSk6a6vuB3QbCMy/YruDZforcqL5jDPr6F17B7BBdG2N
	tRQFFoPfR6zRbEVMX+dsig41RoxtHEDmpFuieDlmNok0//CUNL4yaOPm9yQFGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dxmqiJY3dxPmmf73vWJWQhlFW14yQvGIrlB1SIjmOCY=;
	b=CTLgqw/a0xxffYAtj/l7AZXcWrxlP+k6amW9w5P2ZQ0O5JZ2Q4XSdgqwIolYerqGrdQUSf
	tsMKXoo4DNvScODg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131454.10875.5005390647985843961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4a5f2dd162fd68f588784eb9b0a927e3b328736d
Gitweb:        https://git.kernel.org/tip/4a5f2dd162fd68f588784eb9b0a927e3b328736d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:11 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:23 +02:00

x86/mce: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

  [ bp: Squash *three* mce patches into one, fold in fix:
    https://lore.kernel.org/r/20240429022051.63360-1-tony.luck@intel.com ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181511.41772-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/mce/core.c     |  6 +++---
 arch/x86/kernel/cpu/mce/intel.c    | 21 ++++++++++-----------
 arch/x86/kernel/cpu/mce/severity.c | 10 +++++-----
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 771a9f1..ad0623b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -47,7 +47,7 @@
 #include <linux/kexec.h>
 
 #include <asm/fred.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
 #include <asm/tlbflush.h>
@@ -1948,14 +1948,14 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
 			cfg->bootlog = 0;
 
-		if (c->x86 == 6 && c->x86_model == 45)
+		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
 			mce_flags.snb_ifu_quirk = 1;
 
 		/*
 		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
 		 * rep movs.
 		 */
-		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+		if (c->x86_vfm == INTEL_SKYLAKE_X)
 			mce_flags.skx_repmov_quirk = 1;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 399b62e..f6103e6 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -13,7 +13,7 @@
 #include <linux/cpumask.h>
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/mce.h>
@@ -455,10 +455,10 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 {
 	u64 error_control;
 
-	switch (c->x86_model) {
-	case INTEL_FAM6_SANDYBRIDGE_X:
-	case INTEL_FAM6_IVYBRIDGE_X:
-	case INTEL_FAM6_HASWELL_X:
+	switch (c->x86_vfm) {
+	case INTEL_SANDYBRIDGE_X:
+	case INTEL_IVYBRIDGE_X:
+	case INTEL_HASWELL_X:
 		if (rdmsrl_safe(MSR_ERROR_CONTROL, &error_control))
 			return;
 		error_control |= 2;
@@ -484,12 +484,11 @@ bool intel_filter_mce(struct mce *m)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* MCE errata HSD131, HSM142, HSW131, BDM48, HSM142 and SKX37 */
-	if ((c->x86 == 6) &&
-	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
-	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
-	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
-	     (c->x86_model == INTEL_FAM6_HASWELL_G) ||
-	     (c->x86_model == INTEL_FAM6_SKYLAKE_X)) &&
+	if ((c->x86_vfm == INTEL_HASWELL ||
+	     c->x86_vfm == INTEL_HASWELL_L ||
+	     c->x86_vfm == INTEL_BROADWELL ||
+	     c->x86_vfm == INTEL_HASWELL_G ||
+	     c->x86_vfm == INTEL_SKYLAKE_X) &&
 	    (m->bank == 0) &&
 	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
 		return true;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index fc8988c..e7892f1 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -12,7 +12,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/mce.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/traps.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
@@ -45,14 +45,14 @@ static struct severity {
 	unsigned char context;
 	unsigned char excp;
 	unsigned char covered;
-	unsigned char cpu_model;
+	unsigned int cpu_vfm;
 	unsigned char cpu_minstepping;
 	unsigned char bank_lo, bank_hi;
 	char *msg;
 } severities[] = {
 #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
 #define BANK_RANGE(l, h) .bank_lo = l, .bank_hi = h
-#define MODEL_STEPPING(m, s) .cpu_model = m, .cpu_minstepping = s
+#define VFM_STEPPING(m, s) .cpu_vfm = m, .cpu_minstepping = s
 #define  KERNEL		.context = IN_KERNEL
 #define  USER		.context = IN_USER
 #define  KERNEL_RECOV	.context = IN_KERNEL_RECOV
@@ -128,7 +128,7 @@ static struct severity {
 	MCESEV(
 		AO, "Uncorrected Patrol Scrub Error",
 		SER, MASK(MCI_STATUS_UC|MCI_ADDR|0xffffeff0, MCI_ADDR|0x001000c0),
-		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4), BANK_RANGE(13, 18)
+		VFM_STEPPING(INTEL_SKYLAKE_X, 4), BANK_RANGE(13, 18)
 	),
 
 	/* ignore OVER for UCNA */
@@ -398,7 +398,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char 
 			continue;
 		if (s->excp && excp != s->excp)
 			continue;
-		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
+		if (s->cpu_vfm && boot_cpu_data.x86_vfm != s->cpu_vfm)
 			continue;
 		if (s->cpu_minstepping && boot_cpu_data.x86_stepping < s->cpu_minstepping)
 			continue;

