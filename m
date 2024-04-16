Return-Path: <linux-kernel+bounces-147627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94168A76A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D314B23B36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E0155312;
	Tue, 16 Apr 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ac2JBQYj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCF154C0C;
	Tue, 16 Apr 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302563; cv=none; b=TqSFTzQ55YfFyqXPSLoWMBa/c+m55VjPNLIJewrmQyIQ454BxJgZyoEQcZTBL0stOFixBuJyJeRwGGSL1aaIGYISCWk+f9//7N+kB2C8ICGyfZAdpBdkTjr4GfdD0zZAtmVzWNjBVpL9e18jmV5TnX+QHAm2/KMqafFQ3VQzs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302563; c=relaxed/simple;
	bh=LOzsD5IsD59gKdeksTuIW83sAKQTK/XFVhkG9cKUAsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1Odx4rpnDEBeMs6/wAQEpkokZkZd5qmlmWa7REv3gr3CuXfSjzJfOgxGdhc9e6MCjsGnvk1+pBQEDdykOTktiEIvYE6hOVKLAckafpt22rxn79EcCW8++Wd39Du7LZ6qCH9PvPb8GpKxitktt3AvRe1xdoHTMfXt4O2a9XbpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ac2JBQYj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302562; x=1744838562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOzsD5IsD59gKdeksTuIW83sAKQTK/XFVhkG9cKUAsU=;
  b=ac2JBQYjKmkVNte+NaGd5Sm7xA3yVwCxxuIXly2doeQFwYvzbqXg9iEv
   nsp6wlyimHRlgavqiCEIN8jcYvoI5Vbc/WSJLlYJ/Az7jwDNZzgsKgcaq
   nZaAdIxyHHBDTEGNbwglXUJUnVSXUIRisdNzcQVpvALxlK2qSBTM1HJq+
   Ig4r46Ms9FNLrMb3/MipvvJpGNUzIRUpcX/qYJU5YMUPkR+dwSkrwdaPk
   XqIF7fEm+Kr96x0GDsX0vE7LPHalPRBZot46MSxAU1Uvs+GQRrw+5mY2K
   GLmwweXwUQ/f0WPMyc3kHz9rACH2dNETr3bwMwV4kZR/DfHVXJf1oPpVj
   g==;
X-CSE-ConnectionGUID: Qt1vHScUTzq9ls6SY9X+Lg==
X-CSE-MsgGUID: bRQz0py+Tpq96YVA8a17RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234977"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:42 -0700
X-CSE-ConnectionGUID: UV9GmOVUQk60QprN1Uwptg==
X-CSE-MsgGUID: aPh8PptFTwW+6X0ROnlMmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267171"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:41 -0700
From: Tony Luck <tony.luck@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 64/74] x86/cpu/vfm: Update drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
Date: Tue, 16 Apr 2024 14:22:40 -0700
Message-ID: <20240416212240.9872-1-tony.luck@intel.com>
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
 .../intel/uncore-frequency/uncore-frequency.c | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index b89c0dda9e5d..b80feaf5828f 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -197,34 +197,34 @@ static struct notifier_block uncore_pm_nb = {
 };
 
 static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M, NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,	NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
-- 
2.44.0


