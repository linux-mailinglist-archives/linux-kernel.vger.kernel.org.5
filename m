Return-Path: <linux-kernel+bounces-157475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9717F8B1205
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D091C238CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420AF180A9A;
	Wed, 24 Apr 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRIlfN8y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542917F39E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982519; cv=none; b=R0xZNqAb2JYnb7uuFTdbIPCB5DE2HcOjn/WMBbjh1qqEQjA6eGrmO4TEZktV9GO4p7gIHCJxjGTecdNHKeVjpH/pSA/zxR8AIdRNdPl4o6+PtS/S4Usp4FAnBJUV2dHmih749XzICYGSGJ3PUCTbEA3dLBneuwf2KYKTIM1CnJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982519; c=relaxed/simple;
	bh=fKW7Hebo/mjNQBGgGrh7VgSx16cw2WCfuxGWQqV9SBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDPMNrcit8ZMV31ftW964OknmY2ToEnma1X0oKvCtvUp5WS6UXDQq/Zsv/i3gVChXxFlzdpMfGiVvaCfwNzQ22l0i/n/bF87hjXKfuiYiXfp4fuwkPNJl9BTPcrTPvuImfFNEgQmuWrU+orO+g0xbcs49J5u+ekMspidANv+Xh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRIlfN8y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982517; x=1745518517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fKW7Hebo/mjNQBGgGrh7VgSx16cw2WCfuxGWQqV9SBM=;
  b=RRIlfN8yOVdT2Y2iVCjX4kTR32Wu3kr+JlipTk4JXbHuWt6UU/7mpGka
   PaH+C4oUeNGErlOkahB0qCQG0UdK6GbGVKoeELAQLom3NGrBWvF+0XxSq
   Yh98ZpkbOogjJ6piEzUWOgTz8gSbe3nWsHwUBXh23JT58iarvlS4EjuhM
   tEiPMji/UemTEqTtgSUAgXGeNM65JsZ5KycGd9goAzABwVFj9+jOWoMmZ
   uY1f/bAbwxh4WrxKmJg6cFD9e3wCPhZoQ6/uMIvpNSCOGjQsQ0W+HnAIp
   athVqF6Jyl0SV1Don9Zt8WytGr2mdjV1n8DZ02xS3hEju6FbfTUDRW+P+
   A==;
X-CSE-ConnectionGUID: 5F8LTdoOSHiRDf10gftlZQ==
X-CSE-MsgGUID: Nws+7YUdRFSRKjWLeoE8Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481933"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:05 -0700
X-CSE-ConnectionGUID: Ws0Wt8ZnTPm9OfnsvgRtzg==
X-CSE-MsgGUID: +yBwUMi0Q2GQCgsU2hkWHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262682"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:05 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 25/71] x86/apic: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:04 -0700
Message-ID: <20240424181504.41634-1-tony.luck@intel.com>
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
 arch/x86/kernel/apic/apic.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c342c4aa9c68..f76aaf5216f3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -497,32 +497,32 @@ static struct clock_event_device lapic_clockevent = {
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
 static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
 
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	0x0b000020),
 
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
 
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
 
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_G,		0x17),
+	X86_MATCH_VFM(INTEL_HASWELL,		0x22),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		0x20),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		0x17),
 
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL,		0x25),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_G,	0x17),
+	X86_MATCH_VFM(INTEL_BROADWELL,		0x25),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	0x17),
 
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_L,		0xb2),
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE,		0xb2),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		0xb2),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		0xb2),
 
-	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE_L,		0x52),
-	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE,		0x52),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		0x52),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		0x52),
 
 	{},
 };
-- 
2.44.0


