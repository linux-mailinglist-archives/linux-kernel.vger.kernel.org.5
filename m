Return-Path: <linux-kernel+bounces-157463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C908B11EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2482528E412
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D3179950;
	Wed, 24 Apr 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEnXdl/G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA116DECC;
	Wed, 24 Apr 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982511; cv=none; b=renLRuxwQEGwy8ScUCS9fFuAwAvnOEiUnkz7/yTtOCMlOOVcEDsxtuzfgImXr1bpNoR0dcAuLy3g99tKEFvK0GxRGjdjeLb5snmQBjwgfzpLpyFBa/kPMv+M3ho08CcWqNhYSmPFs8c8IEstzRIFnOpBVqZJN1vA7gEFAjjjhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982511; c=relaxed/simple;
	bh=sNx6nxhHZv+F6DxdU5u7m6Mfq8h17NXlRvSdlpt7fxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdC1zoVLAP0iEQVoqWcuyJxSunXCwKvndaro5LDpznAEEULgVodqI4IT2C8pu/hIb894RgJ9q8OD4Kzs/k4CzWrNr14G5i+FTssdARiug9qG1PrjAwLN1JyP7f52RAqa+WjbosuGAJV1ZRzAOtLMUgMBHlX2CymNkNdHSaldgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEnXdl/G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982510; x=1745518510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNx6nxhHZv+F6DxdU5u7m6Mfq8h17NXlRvSdlpt7fxI=;
  b=ZEnXdl/GG6GE6uLABEIZSS4uXYw/1tfz42OunpKl7jOnGw1KLZNippDY
   5IAaDGwyIW7Umcj6Eo7ZgMzoWE1pOIxrWU9g229EvPzmvU5s5VNdWD6/N
   NMU+4VqBcFlDsZKygHtzDFeEY4nZFJUYipXhQsmhutbLD62FWjstwTMFY
   RtIkIQzwq9VYfkCBQ21J3MjgN0KMyuzvIgfXCpBA76OmWiEZp2KRveDkR
   ZMZ7ctU4IvTasSSaa2yAwCRkt74rRM2xrEbWg/JE4RPfkbwSv92Ap2CaF
   gDRo9Rz3IL8go2XdFlgs+5vqIWFV5hPUdBC0OhEBV2K6WSBDqM5ifKcTq
   g==;
X-CSE-ConnectionGUID: uWll+EzDSoCH0gMAoBFDNQ==
X-CSE-MsgGUID: hhZ0ZWKGRkGROSuY2SlE0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481815"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:57 -0700
X-CSE-ConnectionGUID: 0AbnEi7OQd+FrmJxDs8yYA==
X-CSE-MsgGUID: yAHssfhiSBq62zGao0DWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262611"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-pm@vger.kernel.org,
	patches@lists.linux.dev,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 14/71] thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:56 -0700
Message-ID: <20240424181456.41424-1-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 6c392147e6d1..63696e7d7b3c 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -49,21 +49,21 @@ static const struct thermal_cooling_device_ops tcc_cooling_ops = {
 };
 
 static const struct x86_cpu_id tcc_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
 	{}
 };
 
-- 
2.44.0


