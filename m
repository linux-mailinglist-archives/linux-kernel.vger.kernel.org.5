Return-Path: <linux-kernel+bounces-164449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349E8B7DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632771C21490
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3671C0DF1;
	Tue, 30 Apr 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFV8g8AI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B51C0DD5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495906; cv=none; b=krL4ScVtTIxpAjDFzuW/lB6+zNIvuBHUfOfELAR6klX57YxAFQqcihx9lspZ5KrO7GWhk+cE+j1NoV+b6UY16OVFUJk+sa0+ynHDcsMXYUJyP5f/RX0fE57QpjiL44X6edtQo2UB+EQXPVZK0nFiZIu5eicLmOpiRk8h0pGMeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495906; c=relaxed/simple;
	bh=RFOl+tI1RaXxPq5UkqcZKS9SbhVF1gS/RaejBldIMK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxz9kLpaR0OxAylKeUBfSeMPe8piIzyU6cyvTGKvG0UVkm36Dymnmij+ij/iGi9UwjFr9imzLYbfLxWPSCMawwYxS02f3/bDs8ptkdt+BCsycyO2wswxCzXDdW0XH0PDjxWxdZ7hM2Gehx6wBCblAa7OsQmP+H6h+WZFPRt8MmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFV8g8AI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495905; x=1746031905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFOl+tI1RaXxPq5UkqcZKS9SbhVF1gS/RaejBldIMK8=;
  b=CFV8g8AISwktYsbTFkv4Jk/noOYHpKO8gDFfw5dINnxTH6cnYGG2DlZ4
   akSHgMVrK1252W7/KVNkM2GTFQt3MeRXAkW0ePJETeLOB0sToA48puMLt
   6X2lU4uO9vTKr6fw7D3MhqDu7U6LzfpRWhNZP3SJF2XPQAjv4tj8PgVVl
   8V+1r559I6lxqoU7dE8TAzgEH6XyAPTu0leSSo4dLXXmsSDEFvtjrGqCc
   7mZjvucDf3y+qXpKlrlLz45/6DLZpWKfkNw/P5q6zKdX8QiK+cbjJeLXZ
   Mu4uMbgxTExSil8XzXuylY9qgf/3I4hq3aRJERXaUN0hS0sqH9Tw+oOEF
   A==;
X-CSE-ConnectionGUID: kZMjtG54S1aKIXaI4h1OfA==
X-CSE-MsgGUID: jyrFe/AQTIGtl27tTIuQ4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075723"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075723"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:22 -0700
X-CSE-ConnectionGUID: 8NNy6mRaRp6nZSDHBeB6zQ==
X-CSE-MsgGUID: rK3BgU5fT1ynQedv0f4sfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515475"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 23/47] platform/x86/intel/pmc: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:36 -0700
Message-ID: <20240430165100.73491-23-tony.luck@intel.com>
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
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/pmc/core.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10c96c1a850a..054a56532e23 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1255,29 +1255,29 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		arl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,         lnl_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		spt_core_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		spt_core_init),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	cnp_core_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		icl_core_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	icl_core_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		cnp_core_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	cnp_core_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		tgl_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	icl_core_init),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		tgl_core_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		adl_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		adl_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
 	{}
 };
 
-- 
2.44.0


