Return-Path: <linux-kernel+bounces-160547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCF8B3F05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FC8B2496A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9DF172BA4;
	Fri, 26 Apr 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AO1HxGyp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVW4DBlQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FF16F839;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155137; cv=none; b=XO+Jyeg9iehuHwzn+O3pMWAop6LMh0PLiqZfiKRH/wudsfzJWRQQzfEryLuWNBnd/pFNKoHPrXfZSkopalHbtNE+0GUAz1TIeGPyNfvow4gqq+UQxZIFwkWSM3JrdaAn1+eRGufZyijM3sM075wbqwqG/8dUjnO0XQ4Rq7BcWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155137; c=relaxed/simple;
	bh=vEokVevjxObrIwxYe2TMwBNdcl1+5t6QMX84O0TWiOk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=c84kAJX+xboczoLpfMrdPHh0OK9QqGTGBkSmvpNtH1vi6ND035PK3mBCvXM2unIREd7u5X+WvX+N5fUAodI3kd3TLUyhnHCTwHYuGG3pkGvKZC37BdyseBBPFc72zXONg2lRYyNt+KMhjKoKbtSHo32Vx9Z1sPXRoIn28Vf6DEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AO1HxGyp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVW4DBlQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FRJji59JOV1p+9r+KsZFRs6MSvI2uFfRDM8yeDubvKE=;
	b=AO1HxGypiyB0xaXDPbiOgmdKwFH2wB0kIa/ttUCeMP+BwEMtXKZjk6yP1x+EFaBPqMWdE5
	RL0NN5QCbUzQgO8YLdnXp1OR7o2KqT9wSgFKomc1f7440Nviq+5NjS/jOVXDD3G0Sf2g2H
	cyBjIY/vvD8jaIcehBmhv+1OOmbTmCWfgxLE3hHhEElcg0H2OWSGC5orAmMiIBHCL/cwCO
	/Hhmn14l66F6sx/m+Y1yOePCIPSj8HeQN1brUeSP3fcfqwcNspbGcOy770snymbPTEDnT9
	wr0eThBK6a6n7EacD4gjRALQ8GvIHFRtKQL0O83kWzDULO5y7orgVkxX0Vu4Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FRJji59JOV1p+9r+KsZFRs6MSvI2uFfRDM8yeDubvKE=;
	b=oVW4DBlQmVb9XDE/V0ZSet0D+4MAyDD4r9HUU2AFRO5/s290wdYDoopYVStRBZFCSMGm2V
	f6zmAp+th4GdhOAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513131.10875.5529445404964250839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8a5943977900e2044c7ce183e32bddd05fb9b058
Gitweb:        https://git.kernel.org/tip/8a5943977900e2044c7ce183e32bddd05fb9b058
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:12 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/mce: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181512.41791-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/mce/intel.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

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

