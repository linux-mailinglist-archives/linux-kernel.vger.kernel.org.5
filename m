Return-Path: <linux-kernel+bounces-158947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B958B273E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279D91F25B24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA714E2CB;
	Thu, 25 Apr 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="meYuRNU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hJNhkX5Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC0149C41;
	Thu, 25 Apr 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065041; cv=none; b=L6SpkT+rQduSxvF8isgYIKCsjt2i1MpIShsAqGryh2OVGdigR8TbgpH8tDhRZPq+GXB96V1GWCSiA7owyop2Npl+beOAIaJ9hMUG/6npwJmnesNpYvgTFzf74Op4Z8ZmAb+7ayMTL/dxfSQgFbApdeySrb47VYQNkhj+dbQAky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065041; c=relaxed/simple;
	bh=tXU3irorOo1XMSTox1sHKsdUBFcvEBxl2r+osifQUMU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SrZY9ukvZG/bhTcXzHuS44UENUMYFV5TQv0OBza7a9R1+jYzIn8/rcY99+YYM3lQCEb3T/S6uptAJK74fNARYq5HKHB+9lcAbxucZJ9qWDIT5s2/yG63WzKgXd9jne2BfNDmRBhriMYeXLCPVA0JiM2cseX2AEDiskNeezIvGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=meYuRNU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hJNhkX5Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 17:10:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714065037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jOPRF0wt/BZCZ+lgW593az2GM7U6utSE1IgkdElMnQ8=;
	b=meYuRNU/0Q91fpB7G1zlUfKGvL3Ph6yocfILUA2DXMIfQ05iENgcnBt7oUJ2TqtsKTsexE
	3UDgMCRd3kQI3VHmw4h0wRM4TJf4g/rzFxaq1xLLJPAUPfXR3nimf6EoPNcfGLLLBUig3C
	MVOdQbIw1ZnGLndsjlDN8Yf9lMlsKFp+1qVmeGWDIOrZFXWW+MHpliQtwDzYWxVnvZOk3X
	ZxkT1Qgr2NgqaiHC+2Q510R1om4NjRWT3xcudmGR/nUsHsHrLF/IZuOCI3CjpeOjyVbIJ1
	gCi68tHBgljeYHClLkHmyHGBmkX0cP31MASgZ/kXuNyKycnCdu8pTdb6oPp+SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714065037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jOPRF0wt/BZCZ+lgW593az2GM7U6utSE1IgkdElMnQ8=;
	b=hJNhkX5ZOL20FhLvXCI2FZstTwIIrLZ57JNBUyEO1RW+/+S/WkAGhBLVyYMkamsA9VvmAT
	T5tN6G4rKjV+rqBQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] perf/x86/intel/pt: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171406503667.10875.13533038691665121015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a7011b852a30ab0fdb469991037613407e49f2cb
Gitweb:        https://git.kernel.org/tip/a7011b852a30ab0fdb469991037613407e49f2cb
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:00 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 Apr 2024 09:04:32 -07:00

perf/x86/intel/pt: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181500.41538-1-tony.luck%40intel.com
---
 arch/x86/events/intel/pt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a122..14db6d9 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -22,7 +22,7 @@
 #include <asm/insn.h>
 #include <asm/io.h>
 #include <asm/intel_pt.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 
 #include "../perf_event.h"
 #include "pt.h"
@@ -211,11 +211,11 @@ static int __init pt_pmu_hw_init(void)
 	}
 
 	/* model-specific quirks */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_BROADWELL:
-	case INTEL_FAM6_BROADWELL_D:
-	case INTEL_FAM6_BROADWELL_G:
-	case INTEL_FAM6_BROADWELL_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_BROADWELL:
+	case INTEL_BROADWELL_D:
+	case INTEL_BROADWELL_G:
+	case INTEL_BROADWELL_X:
 		/* not setting BRANCH_EN will #GP, erratum BDM106 */
 		pt_pmu.branch_en_always_on = true;
 		break;

