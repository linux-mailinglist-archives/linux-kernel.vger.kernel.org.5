Return-Path: <linux-kernel+bounces-147629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2D8A76A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69FB1F2293A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A715535A;
	Tue, 16 Apr 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkGcWCG2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CE155336;
	Tue, 16 Apr 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302567; cv=none; b=QTOwyQ9HbtYrDTSoGp8QM60yg2PHdcY+7a3pUbyYXuNZrxwiM1KLTB+6Etv+YMSaWpS5M5GtVfUcrM8WLGcVOloKy3RVIAmJ7RmyIJxOQCmXd1w6DgE1gmj+Ff377HnhgcNwHPRTfEIkvdIrNqIN7ZynS4wDZMF+0sNFzzDlQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302567; c=relaxed/simple;
	bh=TEzhvkvCuOTK927VLY77j87rDedjjUqKcpM9RnTh430=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpcBb44CJDn7Kn99r1yU0akQ+U996wfOgRvQG+pLDYFo/ZIOHYfmXruv0XFMfu23kGxVjq7Hahn4VX3zE+mKfNmDcp2dpo4IdKnoSLzYNJXkGN3cDze8WaeSdXt2Y8xKr4cq0PueNsZLrORhIiEgopPsHp7el2syBWF9k9kqsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkGcWCG2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302565; x=1744838565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TEzhvkvCuOTK927VLY77j87rDedjjUqKcpM9RnTh430=;
  b=NkGcWCG2kmsyF4UiXq/mWW5Gv/QSATP8L4f5xxxuCibAG0XpXGdA7Zlf
   5kNGW0oLyGj4Bv2CA4MMXGT8o5FjYQKpXs/DrijxNUG2NxdELl4XTF2se
   cCXh358psv5Fj1s8WkiBQZ0qDGNtpqCiIeU94jT3ESRi29IiWH8GB7r2V
   qUZRHgULmB8iI/0fdO82NG59cn76iDn+jw6oUYi2XJtT+3SHbtb9LEmPR
   7s/GB9qXl4EoV0IYshkEngZQte7Awtjm0BPtTayVCsIEBNqEo6ZxLdX5H
   RcIaKWlI7DphuBhDqq4LvpBAYN0CURrR/jeptvG64Cr+EoU5VtAt1R95h
   g==;
X-CSE-ConnectionGUID: sD6N5AqFS1iYf8i5VsZdgw==
X-CSE-MsgGUID: KeqSY+niRce2Pp7UefeK7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12548593"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12548593"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:45 -0700
X-CSE-ConnectionGUID: hpr1FKtpRseFbPDWjgiLXQ==
X-CSE-MsgGUID: o5AKEqbEQiOmgQH4J7gpKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22453814"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:45 -0700
From: Tony Luck <tony.luck@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 66/74] x86/cpu/vfm: Update drivers/powercap/intel_rapl_common.c
Date: Tue, 16 Apr 2024 14:22:43 -0700
Message-ID: <20240416212243.9910-1-tony.luck@intel.com>
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
 drivers/powercap/intel_rapl_common.c | 118 +++++++++++++--------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a28d54fd5222..59c36ea55712 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1220,65 +1220,65 @@ static const struct rapl_defaults rapl_defaults_amd = {
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&rapl_defaults_ann),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
-- 
2.44.0


