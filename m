Return-Path: <linux-kernel+bounces-164433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655A8B7DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAE0288296
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E72180A65;
	Tue, 30 Apr 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ln+SKqrk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687F17B505
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495895; cv=none; b=SBUSdCt4wCES8rxDmpkVjce4Br/E+6MUcCsDDQDV2ftYSrb11W9Wf2KkHoZrJPahjm9DfsTiGT54GgS3uikRyr6LNKBGXRdT/ryQVVPv3h74+rLUki1WjYShMGFIDNhFiGbZ6eV/K99k/uzV+a1PxHXMya4HsyKBLneDYw5Sd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495895; c=relaxed/simple;
	bh=jo++POGDkJ0iaXLFXLmreRUhlhBEdY5sKB13LHFpdWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZok5wh888tgEGQuXwITC4SwA0/Zoy7vOeRDsck11ndQAmRaau4/U2HqMBtFieIItKtEGhVpyG9xIx4Dn9y4Xo12kw33SW1YipivWGlFNoSJvFwsxZy+k79Eqf9vYY28otM+cPt1+qTHtp2W2Xs1wzd5FjDRkgyws0urOoYxnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ln+SKqrk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495894; x=1746031894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jo++POGDkJ0iaXLFXLmreRUhlhBEdY5sKB13LHFpdWE=;
  b=ln+SKqrkVIoOG++USVkOOun7MBY516WahOBDu0S7J33KwIKf1SZIVhgs
   1RkqWjCeuWGd44f6OrExAEzP/OoT2yHvYUDmZxN2HoS2TIwnRlzOAQp6C
   ppqGera4vgmRUiAKPRAVVmCT9Dwq9+yvfkTtlD87X34yO2Nmc+xOnpxdl
   Iib46Owvymh8GDIPYeHBPLx9Q6hD6R8v+j6lE43hAxESyrB3ewHHrHbg+
   uBbStWv6i/sSeXMdCIyybRfBiQ90hFs3+HtaeGnMnlPBgk3fQ9fyuOO1V
   NkjsfsI/tXEFIEc0tm4Z3hEY7HJATlb85i2kIdZGwQ+b5KkJYCFEzPZwf
   g==;
X-CSE-ConnectionGUID: GHROf7FHSAO1seX5Rc8jww==
X-CSE-MsgGUID: Ujqbon1VSImuA7Ssddp+Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075604"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075604"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
X-CSE-ConnectionGUID: bFd93eraSY+BgwNbeuNM5w==
X-CSE-MsgGUID: J4b7pbRsTfiOVnW5F48FJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515410"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 02/47] platform/x86/intel/ifs: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:15 -0700
Message-ID: <20240430165100.73491-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/ifs/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 7b11198d85a1..33412a584836 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -11,16 +11,15 @@
 
 #include "ifs.h"
 
-#define X86_MATCH(model, array_gen)				\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
-		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, array_gen)
+#define X86_MATCH(vfm, array_gen)				\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_CORE_CAPABILITIES, array_gen)
 
 static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
-	X86_MATCH(SAPPHIRERAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(EMERALDRAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(GRANITERAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(GRANITERAPIDS_D, ARRAY_GEN0),
-	X86_MATCH(ATOM_CRESTMONT_X, ARRAY_GEN1),
+	X86_MATCH(INTEL_SAPPHIRERAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_EMERALDRAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_GRANITERAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
+	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
-- 
2.44.0


