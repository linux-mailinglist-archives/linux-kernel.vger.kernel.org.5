Return-Path: <linux-kernel+bounces-157489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2A8B121C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1C81F22160
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207E9199EB6;
	Wed, 24 Apr 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7Q3+AvA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB54181CE5;
	Wed, 24 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982527; cv=none; b=sfc36+2m2TAWomfR2owIyJy2ivxxf3cvRn9OChXYJi/oGMIDH+SQ6RRu6DC7HZdS3TUbzHGikcTvbTqIIWjwj2TzR4TsImDlim+NCscoYDjta2+h7pePrQd9xdxZ7nspslBoIMtB0nbM/gArTtxL/UO72LX1LdLtTMwig6mAgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982527; c=relaxed/simple;
	bh=iFfVDMwRelTPhBugxwSRQJDD52d9QsnZEZNpB2fnYgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThHv8uvXaR6kg9IhqxI5GS4w8Evm1UqdJTyoS2medeqH5ezahNsH0yEZvHN4FrvAeBxt7a4OuzjiSdshxFgTo8uEEn1fKrAV/XyfQNKUVFgsOyIbbJ4I5byUomgeo6NpRhh+6Hdsh6uO6WYe2M3NL7KVG1rBb8Djt2X26qQ/LEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7Q3+AvA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982523; x=1745518523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFfVDMwRelTPhBugxwSRQJDD52d9QsnZEZNpB2fnYgc=;
  b=d7Q3+AvATS+jKQFlPqrtfVT95NxnMkoneuGa+uX+qD4LUkT66GYFKHbN
   M5XzpsYCcs2aUP5HE5SdbTg75e3TOB12FGWHc87o4sL4oxXRHuBF1zXov
   NUNm+FwY1fuawrZL1cpdPgjYiU4P5loFJ57YykX01hWd/ItYhZcnC8Blx
   ZJxY2rLV9AHu0aRHmNPjLugV+euwhhqC0w2n8aIDsB6kTVxn7/fQTQHEd
   3Dbjcp9f7H5shosL5V9xFVvFfRjQgsqx3Cz2o23kFqfzQRhbnzT0DoY3p
   kicwp+/g9E5UM2au8N3QLWaypfGKr9WQ5oBXm9VVdgAXSY0z7ej24A1hE
   A==;
X-CSE-ConnectionGUID: ZmFasxx6SH2Uep9SNahmtg==
X-CSE-MsgGUID: nia1bv8VQuKMZSm4c67G8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482013"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:13 -0700
X-CSE-ConnectionGUID: 3Me6owXQQ8yo33zZQJIkew==
X-CSE-MsgGUID: hGlTsOXjSqaC+Kej4mCGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262754"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:13 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 34/71] x86/mce: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:13 -0700
Message-ID: <20240424181513.41810-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index fc8988cfe1c3..7293a1c49050 100644
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
+		if (s->cpu_vfm && boot_cpu_data.x86_model != s->cpu_vfm)
 			continue;
 		if (s->cpu_minstepping && boot_cpu_data.x86_stepping < s->cpu_minstepping)
 			continue;
-- 
2.44.0


