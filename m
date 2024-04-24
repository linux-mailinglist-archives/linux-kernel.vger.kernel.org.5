Return-Path: <linux-kernel+bounces-157507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E08B1236
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C47E28CB48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D311C8FC2;
	Wed, 24 Apr 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwHh7fcK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90761C6890;
	Wed, 24 Apr 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982540; cv=none; b=DhOxbNzYPjUQ/Hn+gherBObr6sWq7SXX+q7NeVcR4q2x5cgntlYxWLhPBYq9YlaIaV3NfPUvCFBy3SWNCphXZQzRSXrX+1Qy8Rnopue3Y5V495a65tJmp46mCKKJf02JjDSQC0V9/3HlYGX23NjVwFM2PtT2oi/yOL1w3zLHGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982540; c=relaxed/simple;
	bh=8BfI2hjYKf/TtKpPZBR8m4bVwal0XuuMnwSbzdK8eQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhvNwp8+/sjVEs0+DGGw5fNETyiJjb0Wqnd2xGQgPA5oGokweRmPopOYAbcaS+ZWJrKOsMi3WBBL7Hum9U3E57HZm6Y7u/+uqb6nvo/hda00pQhm1nHRKhlGOu+QwOyNO66U22raJ+gQXAugXK7WkubkemmJGPmxtEm4dBsyV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwHh7fcK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982538; x=1745518538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8BfI2hjYKf/TtKpPZBR8m4bVwal0XuuMnwSbzdK8eQk=;
  b=ZwHh7fcKQ02l6fEz2TDJPUTxXLpzMks+y3VpQyZBRvw1rrVJfqaKaYdO
   4NOWCegUVyYfxbtbBuY2RgNqt/m6STXaGmzlJas1BQKCBmWWXlkf/CoBS
   83Cd9UfifUBuvns0jN1gQDPbmazpizu/ET9T4bvtcd6j3ytoDGEtIiCWG
   Nt5vfRTLJpYgb0TNVs8KKwBQF48iq76ZO4QGzS/dMI8SrGWHOTwRoemDn
   nzvNgNN1jHrPLW5SNfJeu/GFE+0rgeqvJI8TaJegagbdL9Noqf9chZaAe
   SOYXHa79JcPWryBtVB8/3cBsNoWcIM99MJLNPduKnHqBml9kj6LNwnzXj
   w==;
X-CSE-ConnectionGUID: PDFIXGeWTsO4TGwzFt9h7g==
X-CSE-MsgGUID: uqNAoPHKQmqyVQ7m3kj5tQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503672"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503672"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:38 -0700
X-CSE-ConnectionGUID: 0lQNemMKRlO8JoaKAvPz6g==
X-CSE-MsgGUID: dsz4QLp2TnG9LXqqTh0Nzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750293"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:37 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 58/71] platform/x86/intel: pmc: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:37 -0700
Message-ID: <20240424181537.42273-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/pmc/pltdrv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
index ddfba38c2104..22cfcd431987 100644
--- a/drivers/platform/x86/intel/pmc/pltdrv.c
+++ b/drivers/platform/x86/intel/pmc/pltdrv.c
@@ -35,14 +35,14 @@ static struct platform_device *pmc_core_device;
  * other list may grow, but this list should not.
  */
 static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&pmc_core_device),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
-- 
2.44.0


