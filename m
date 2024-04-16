Return-Path: <linux-kernel+bounces-147584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930B8A7659
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A9A1F22144
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742713CABC;
	Tue, 16 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BO/1mXrR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374813B79F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302410; cv=none; b=cnc/PVVdvqyGeqpPUe1GsTONDbbI80jMt1p0OgVV8umSKPNu7jhq7UA//j3urbawTVThfsQZxToJvhTgxBKokCmIogkU5K/4fgEBKro1NTxAnLnvKwhPx96lI/zXrWGn1CnhM1By0W+lAxFBY7vwftkDMufsInIx+/jG+Q/72ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302410; c=relaxed/simple;
	bh=kl4BWoKNzmqLiy/g3wM2ev5Gf0696Je9BfnGHGdGncs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoeBiQX5NHIdljAWjwjujLsrJpc9z6tsXgwg+LG1EnP2IEQreUnouTbjuJA0fmS3ysAgiEmJ56oMi6EbCohs83bMMBbmvAgsAFRb+6uxC8UpRkSitFaTXEteiw+xkr6cxOF1C1aPXUnuHI80EKTvtA31CkGyuVkRhSvUyjn8FPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BO/1mXrR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302408; x=1744838408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kl4BWoKNzmqLiy/g3wM2ev5Gf0696Je9BfnGHGdGncs=;
  b=BO/1mXrR6RN7DW03jCLmeoaBXrVf35b7K+IsVRsOvXO+01E2pZEq4lJg
   fONXjPDsucvYoPj2S8NHAh3YtaozuOPKUe6PY2/uw5l6ZFQo2H2ATIVc4
   BDjQdSPY+1322FnWPiVBs3+sM4/KX3bTi8Hs5xqgg4uA8TVRIPvVi3DX+
   4iK+Ee4Vp57cnw92hI56Nb89ZpVihkoH3EtaRhtV7jX5dSa+y962rBM98
   ueeixWSPauxLmgNG/KNcAALYr2gWQ5qS0iib3TbJfpbaq2PRZj30CHnLk
   l17tEWxXN1sO7D8eqFRrQAE4x7lQQ5KNzWvJ12MVvHH3mfAz9eBMWE8sZ
   A==;
X-CSE-ConnectionGUID: N4cccQgLQwSTYMkPHBOMvQ==
X-CSE-MsgGUID: CaX9QZzJRaeNHpbs+EfFvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914775"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914775"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
X-CSE-ConnectionGUID: JK4NaIOMRji5M2t9henXWA==
X-CSE-MsgGUID: Tf1QsGLYRDGiRwhCHU05uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871956"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 23/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/severity.c
Date: Tue, 16 Apr 2024 14:19:25 -0700
Message-ID: <20240416211941.9369-24-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/mce/severity.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index ee85fe2ccf65..85f5de718725 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/mce.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/traps.h>
 #include <asm/insn.h>
@@ -45,14 +46,14 @@ static struct severity {
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
@@ -128,7 +129,7 @@ static struct severity {
 	MCESEV(
 		AO, "Uncorrected Patrol Scrub Error",
 		SER, MASK(MCI_STATUS_UC|MCI_ADDR|0xffffeff0, MCI_ADDR|0x001000c0),
-		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4), BANK_RANGE(13, 18)
+		VFM_STEPPING(INTEL_SKYLAKE_X, 4), BANK_RANGE(13, 18)
 	),
 
 	/* ignore OVER for UCNA */
@@ -397,7 +398,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
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


