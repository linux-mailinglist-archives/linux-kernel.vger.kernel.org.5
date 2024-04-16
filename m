Return-Path: <linux-kernel+bounces-147625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164E8A76A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3392F1F21BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF2154435;
	Tue, 16 Apr 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaczheMY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98536153BFB;
	Tue, 16 Apr 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302558; cv=none; b=Si7BNFm4VhPF5mKgDh8LNqMzR1Y1EaqhFrrNiPT2IhYbsHpmO2ApU3zO3AIxumFSdCQK+vMrYZie3/irR0B0GdV6WKxsTZTzybH6l45KCoSWnDO5v0zOHNCe9jLKZ0kJdIAq2HMQTW7hoGaSsrEI0eRJ8bWkGG1DVt0rhx+zs30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302558; c=relaxed/simple;
	bh=lGxY6/fpKVjagJiMiQslsjgDFgL5ZPdXodSr7eR0UbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQgD9YY70e0sONbeRvfUFqus4buaokoykkxDEYZ3mUsEBH3Hs/QHk3xyihHW1SLWewFVBVBLr3rVQGCYE2dISPgJT+mFuXA8KqJL6k6hQ9iccBlZlaUWMCPsRwSAPWXFxuf4ACLJxUuaN/zCyVH73XR/thWy5ixRUr3M2wbVs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaczheMY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302558; x=1744838558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGxY6/fpKVjagJiMiQslsjgDFgL5ZPdXodSr7eR0UbE=;
  b=NaczheMY6VIdLlpyFFT8VvlR2r6hqVsRS2/epw0vG0Dz2wZHZ2Isc3vl
   bU49K4/9wO13Np2mngZQzEjErbBkdkhX40fyEKt/9yMgBwRMqt8zRv7Eu
   lIDZyjoNL0CpjOJcYIrUjBVSeSwRg+Ksyv81nq1fdbZCYSF704zbjAxI6
   z4wszAF8LHuxHEp8JWuk7UDLUt/Cjep66mYY3uZbnC++65PaNGf1siJIl
   uIBqMKA0UINO8BnrLVEXsWhw3aFTqbVEpKQ/d/0OmrCPSyfPDio4Eh0GF
   B6xc4Oowjf3T8Bz+nj4/5szJsY90R6mSdCZAUuyEjgIVRjO/O51V2VRDi
   A==;
X-CSE-ConnectionGUID: 1tCjNwrATr2crVOypBM9YQ==
X-CSE-MsgGUID: JpVC5+iaQf2T2RmBI6fJfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234966"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234966"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:38 -0700
X-CSE-ConnectionGUID: U9YR2isZRIqmsi2OYOxMnA==
X-CSE-MsgGUID: fRcW4r7DQ92SvU/O4Q18ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267160"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:37 -0700
From: Tony Luck <tony.luck@intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 62/74] x86/cpu/vfm: Update drivers/platform/x86/intel/telemetry/pltdrv.c
Date: Tue, 16 Apr 2024 14:22:36 -0700
Message-ID: <20240416212236.9833-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/telemetry/pltdrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/telemetry/pltdrv.c b/drivers/platform/x86/intel/telemetry/pltdrv.c
index 06311d0e9451..767a0bc6c7ad 100644
--- a/drivers/platform/x86/intel/telemetry/pltdrv.c
+++ b/drivers/platform/x86/intel/telemetry/pltdrv.c
@@ -177,8 +177,8 @@ static struct telemetry_plt_config telem_glk_config = {
 };
 
 static const struct x86_cpu_id telemetry_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&telem_apl_config),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&telem_glk_config),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&telem_apl_config),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&telem_glk_config),
 	{}
 };
 
-- 
2.44.0


