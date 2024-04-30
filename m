Return-Path: <linux-kernel+bounces-164460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5838B7DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95AA1C23988
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28717BB16;
	Tue, 30 Apr 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2ublLKP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBB1C65E0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495911; cv=none; b=BJEmptnru+7P4FIlX2WngtLXEqCyY9uidWYgsOyvistABjigz1V9yImhp/d4RvR5ZZYTAyLdfujND8WLJTWl6SjbI7U3rOQXGZZZZ7IvSTtPgQN6xkhp0xu20SV1f9LWGWJ4HDlbBI4jTQ2j/azha6810JmonjnKfnWT+iwojvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495911; c=relaxed/simple;
	bh=KWWRdUU5f5jfluH+XjQDN6u50z+YdtCCFs2TFHrBnZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pry/yScS3phZDr7M+I3l385VCKpf5/HM+UY4NPXMmawuKHCvp7ZGRgc2pWEh3ltD+f4DnbhOQAcw5+LFyYXhnQbP34J7jc7j+yFPtb+pj1vs21LZG4YIEVm8nM2H4dD9ONiWyq2S1v5WASXV6MRrzqJ1Px9F9i2SC3kOEiSivsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2ublLKP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495909; x=1746031909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWWRdUU5f5jfluH+XjQDN6u50z+YdtCCFs2TFHrBnZg=;
  b=Z2ublLKPpIVPhmV6Ep+0kwoIpUZFNMjv2Qt5Rqz0iqlcmDPqkMjmPXW6
   Jm0In5wtc/EPDPcTj92f1RuFDViTW2z2WNgBTvMvZhGHcoNktGnsDLPV9
   ZmBzgwnkFmxiERUfHTnsglzFvDcMSe5lfNX6H/lFOLxAbnWcx9O3V7QTy
   vzleWAibw3+5CLP1UmH5FY8OqZKDlkS+CVQjxLVdRNZuhS/dC+anr0oPr
   U48vKFXhIsrshJaPKVWibl7F3VjnLDVhzvOzqNfF0FSUYqHadBN1JBxIV
   ayXtNFcG5gERmugCuWhos+p5h71Z/EtI177ggtQEoi839jk9x57UPNJRf
   w==;
X-CSE-ConnectionGUID: WnmbwCqWQeSFdhk1pmHUow==
X-CSE-MsgGUID: e5RC09FZRDK4AqsoIx8u1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075791"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075791"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:23 -0700
X-CSE-ConnectionGUID: 8p6YeWqzSna9phiURt0taQ==
X-CSE-MsgGUID: N3h3NHA9TFeDFdjFZzPeQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515496"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 30/47] x86/platform/atom: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:43 -0700
Message-ID: <20240430165100.73491-30-tony.luck@intel.com>
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
---
 arch/x86/platform/atom/punit_atom_debug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 6b9c6deca8ba..44c30ce6360a 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -165,14 +165,13 @@ static void punit_s2idle_check_register(struct punit_device *punit_device) {}
 static void punit_s2idle_check_unregister(void) {}
 #endif
 
-#define X86_MATCH(model, data)						 \
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_MWAIT, data)
+#define X86_MATCH(vfm, data)					 \
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_MWAIT, data)
 
 static const struct x86_cpu_id intel_punit_cpu_ids[] = {
-	X86_MATCH(ATOM_SILVERMONT,		&punit_device_byt),
-	X86_MATCH(ATOM_SILVERMONT_MID,		&punit_device_tng),
-	X86_MATCH(ATOM_AIRMONT,			&punit_device_cht),
+	X86_MATCH(INTEL_ATOM_SILVERMONT,	&punit_device_byt),
+	X86_MATCH(INTEL_ATOM_SILVERMONT_MID,	&punit_device_tng),
+	X86_MATCH(INTEL_ATOM_AIRMONT,		&punit_device_cht),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_punit_cpu_ids);
-- 
2.44.0


