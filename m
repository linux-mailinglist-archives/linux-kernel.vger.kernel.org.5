Return-Path: <linux-kernel+bounces-147572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5F8A764B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8868D1F22B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB513B2B0;
	Tue, 16 Apr 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMjZ+Mn7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246812AAD9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302404; cv=none; b=gnQnxkFijdgafxEt+uf0qG7xVP8F1adwSrUf6XtG+onBPGBiQ2PX4gENsAsLG+/2jpGKHnrrf42QaRwYT6Dv2kTP6MtTAdiqVw1FO2s3lNfxQJjoODvczsaDneGHW6xGyW5GI4Ws0CADd7YjcOZ5b4pSXUIbegrWVEfzx8BjlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302404; c=relaxed/simple;
	bh=SHMkDQNhLJVSbQAhNMfggf+iNz/SzZPr73nQsNDr5PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1/KfCUjjrbxH41AJbZbHKBm6uCQtdG1zatT8GJ9SXyQ6SYDAnsgskERQaK5aBDuw3bqLyjJghBvGGsZ7899lhSqTb0BiL/xgB374lQctvkSwUrvHoOGmMCdUvBVa6mDx07CpsQQRyZEF69eFedH3r8dLT+t5aIonMDxxO9eZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMjZ+Mn7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302403; x=1744838403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SHMkDQNhLJVSbQAhNMfggf+iNz/SzZPr73nQsNDr5PA=;
  b=mMjZ+Mn73AdwOV09gp2pvWGG61EruPoF5AYniphiJduSqmhtaPOdZumh
   6VAVom2xKr8u1O/hFWISiF9OiskhvhDOr3WT3TAoc4VRBqMOxh3Lr6WaC
   rjRhi3UVTLxGR+WeitfERkA9KAGtBjZgEgK2cJWdNRKT6HwC/m538MOjz
   pMrAjChiWT8e/1v8doMASdTYjwK7AjN4DUomOeY9hS+QX/35fgjOp8ZuU
   cQA2LC4AmyBzpF6hWa0dZayr5tD5sE1z6tJ/gEQc5XpFp14Zr2znvYNqf
   sTu+2mUFyjhbcG5Z05V0YrjaEhSUy4KFQLeAMkuBGi2DplXOPKGCVh34r
   g==;
X-CSE-ConnectionGUID: SKaJsiCSQ92ISv5EDWtc7g==
X-CSE-MsgGUID: evOQxQ5uRwGfPLWcB8RxiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914714"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914714"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
X-CSE-ConnectionGUID: vi0hrBCvQbeBzeAzoE3L2w==
X-CSE-MsgGUID: pJpM6/XKQEWICrasbKIn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871910"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 11/74] x86/cpu/vfm: Update arch/x86/events/intel/uncore_snbep.c
Date: Tue, 16 Apr 2024 14:19:13 -0700
Message-ID: <20240416211941.9369-12-tony.luck@intel.com>
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
 arch/x86/events/intel/uncore_snbep.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2eaf0f339849..74b8b21e8990 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
+#include <asm/cpu_device_id.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
 
@@ -3285,7 +3286,7 @@ void bdx_uncore_cpu_init(void)
 	uncore_msr_uncores = bdx_msr_uncores;
 
 	/* Detect systems with no SBOXes */
-	if ((boot_cpu_data.x86_model == 86) || hswep_has_limit_sbox(BDX_PCU_DID))
+	if (boot_cpu_data.x86_vfm == INTEL_BROADWELL_D || hswep_has_limit_sbox(BDX_PCU_DID))
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
 
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
@@ -5394,7 +5395,7 @@ static int icx_iio_get_topology(struct intel_uncore_type *type)
 static void icx_iio_set_mapping(struct intel_uncore_type *type)
 {
 	/* Detect ICX-D system. This case is not supported */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_D) {
+	if (boot_cpu_data.x86_vfm == INTEL_ICELAKE_D) {
 		pmu_clear_mapping_attr(type->attr_update, &icx_iio_mapping_group);
 		return;
 	}
-- 
2.44.0


