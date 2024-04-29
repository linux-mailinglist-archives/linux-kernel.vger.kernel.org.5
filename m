Return-Path: <linux-kernel+bounces-161649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E008B4EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6972813B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5553A1;
	Mon, 29 Apr 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CS+7mB/k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2038D;
	Mon, 29 Apr 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351444; cv=none; b=NwPJD+12zv3NSB7GYqi53cDq53Yl7Wp0IqDaLH8TU8zxM+gY+FhSbPHFeyUTyZBhwxz7I5kMdrIaAQbDMItXZ2wr6gwNHsRGOqwQnEZRRSGmZE7Kk8767uHKME+l8Rv4E6k048kKHrFcTk0HDiybQJEutPY8zgz7zsXYmpRqjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351444; c=relaxed/simple;
	bh=SOxXfekRZP6hwK5s/sf0CEq5o469FfcGNrWL6RZdNCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVGekdchYVCO/PaxqilWGORtpRsXGIM6yzQAn60N/oxUXrWnjyTD7ZIN8BRVA5zptUH0MhoOYbpZud6Lh32SS36pj0hIE11I6lo1hSW1pk1efonlECBIO/i+Fr9LvMGOXETANcDyBRbrTq7D3TxH/Q4FKRuaMih8rO0q48u2my8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CS+7mB/k; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714351444; x=1745887444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOxXfekRZP6hwK5s/sf0CEq5o469FfcGNrWL6RZdNCw=;
  b=CS+7mB/kw2WGkRhMdcWId600WtSPjWxdhBfljjwg17D+Ez8Ro4xKYXa8
   OU142Y0zwQUfZswVEez/Z4CAbbzRqh9gy/aelXU7ur00zgScAElZvZ8PN
   w4bPaSdUEZSisfSzRNtVmea21xWg8sduNGfVQ0ImdFSrjATICk+7vn3qb
   wYHvB0x0mIkS9kZ58TbhHEMpdmJchgKENY2Iu52u5IilHhfql+R+CY+bm
   V5diL4kQ4IU6Wp271b3PQyAnqTUpcIRF5WMUMgjjIE67T52j6wDB2DALa
   SBOrGUaLvArj/SF1y0FOhr/tm6xbBafpBhgsBtcMygeI1bhtKBcYQwgNA
   g==;
X-CSE-ConnectionGUID: pdeNUMDXRHWmYpBG+ADkQQ==
X-CSE-MsgGUID: sWY+fHGgQiOeZfmDN7hGHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21152936"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="21152936"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:01 -0700
X-CSE-ConnectionGUID: YT/Zsf/gQ06BxDX9ia6R/g==
X-CSE-MsgGUID: qTsTCm5ASByWcblvW0vQeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30423054"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:00 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 1/4] soundwire: intel_ace2x: cleanup DOAIS/DODS settings
Date: Mon, 29 Apr 2024 00:43:18 +0000
Message-Id: <20240429004321.2399754-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
References: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use two variables to save the settings, in preparation of a follow-up
change to read values from _DSD properties.

Starting with this patch, the bitfields will be reordered and listed
MSB-first, as shown in the hardware documentation.

Also note that the default for DOAIS is changed from 0x1 (copy-pasted
value?) to 0x3 (hardware default).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 75e629c938dc..32b538cd6d66 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -25,12 +25,17 @@
 static void intel_shim_vs_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
+	u16 doais;
+	u16 dods;
 	u16 act;
 
+	doais = 0x3;
+	dods = 0x1;
+
 	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
-	u16p_replace_bits(&act, 0x1, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
+	u16p_replace_bits(&act, doais, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
+	u16p_replace_bits(&act, dods, SDW_SHIM2_INTEL_VS_ACTMCTL_DODS);
 	act |= SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE;
-	act |=  SDW_SHIM2_INTEL_VS_ACTMCTL_DODS;
 	intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL, act);
 	usleep_range(10, 15);
 }
-- 
2.34.1


