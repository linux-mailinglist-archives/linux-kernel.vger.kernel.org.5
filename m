Return-Path: <linux-kernel+bounces-134828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2C89B787
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21D2B21DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C81A5A2;
	Mon,  8 Apr 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6F4gv4b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36BFBF3;
	Mon,  8 Apr 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557039; cv=none; b=H5ov3A1FQfp6VO/lYvzEbx0sHzwtqMLqIpB36H5ZeX1ZRQI8IszUdaqLYVYSZJEIaUsU6qnR9vKNs2QOlrMA8hJkVadlc3MQOurcGeWgKRmlMnI7IqRmDfWBzS4BAhlMEvXi+g1sLBYQE5Ix98dxxZHvrObzuFQfYOhXP/ibjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557039; c=relaxed/simple;
	bh=HayizR85O3Km2MOiVmMTORWLWeXez6YbxUFmVO85i3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+QYHyMxVQOT/hQihLADPv4HX/qDW5EsHoyMEGLJR+57Qpaur30irrqlCVa9W7GdRgwHWIH7AL7TlnrPxbl139eRve3z/yWYJfC3cAnsvb6LrA+5XW3pq5Si4RDYRvijnzvdIJ3RxL0Q/4VHLyyszJZawazP6ItAtM56oetBr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6F4gv4b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712557037; x=1744093037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HayizR85O3Km2MOiVmMTORWLWeXez6YbxUFmVO85i3w=;
  b=X6F4gv4b7FcfErTfW9MFUddpZgQ4LjECy1/EXNtP7y0YWev8MByCHLmS
   VGs4usFFiPVVIffgbRAFcj1/oDmjEe6Wv6gj37HmNTS/+WiDIIsSbJt5f
   9FPRqNrWuMNAtSzL01zaERhXAdqfplpBQ4G9VOfQzE0GipLcHkqGOXbOg
   74VADHFgSWtwRdTdKbzhZ/qSFlyTFIvzVMp4k2kGW6/aYrd10IY4ItnVV
   oYojipd8VxPu5Xk6ayjIIMjBZKIw2BI97cuhaJuHVILftMUAnI5lHsekx
   LR3N5ib693rAnA2x5agXy1IqjG26PkJmgpjAIY1a4whdZ68Uzl1P9gWx9
   Q==;
X-CSE-ConnectionGUID: CqJn3q24To2RaSY48s5AmA==
X-CSE-MsgGUID: KZiW/GmlSmWs5GArKCeeyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7675333"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7675333"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:17:14 -0700
X-CSE-ConnectionGUID: 50Sc3ctCTwOJGyhsxU6fxg==
X-CSE-MsgGUID: XcvWTN2aRCaFRshX/rQfnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24511959"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:17:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: intel_ace2x: simplify check_wake()
Date: Mon,  8 Apr 2024 06:16:43 +0000
Message-Id: <20240408061643.420916-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408061643.420916-1-yung-chuan.liao@linux.intel.com>
References: <20240408061643.420916-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Since LunarLake, we use the HDadio WAKEEN/WAKESTS to detect wakes for
SoundWire codecs. This patch follows the HDaudio example and
simplifies the behavior on wake-up by unconditionally waking up all
links.

This behavior makes a lot of sense when removing the jack, which may
signal that the user wants to start rendering audio using the local
amplifiers. Resuming all links helps make sure the amplifiers are
ready to be used. Worst case, the pm_runtime suspend would kick-in
after several seconds of inactivity.

Closes: https://github.com/thesofproject/linux/issues/4687
Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Keqiao Zhang <keqiao.zhang@intel.com>
---
 drivers/soundwire/intel_ace2x.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index f26d4e5c2c7a..4910cab22273 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -51,22 +51,12 @@ static void intel_shim_vs_set_clock_source(struct sdw_intel *sdw, u32 source)
 
 static int intel_shim_check_wake(struct sdw_intel *sdw)
 {
-	u16 lsdiid = 0;
-	u16 wake_sts;
-	int ret;
-
-	/* find out which bits are set in LSDIID for this sublink */
-	ret = hdac_bus_eml_sdw_get_lsdiid_unlocked(sdw->link_res->hbus, sdw->instance, &lsdiid);
-	if (ret < 0)
-		return ret;
-
 	/*
-	 * we need to use the global HDaudio WAKEEN/STS to be able to detect
-	 * wakes in low-power modes
+	 * We follow the HDaudio example and resume unconditionally
+	 * without checking the WAKESTS bit for that specific link
 	 */
-	wake_sts = snd_hdac_chip_readw(sdw->link_res->hbus, STATESTS);
 
-	return wake_sts & lsdiid;
+	return 1;
 }
 
 static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
-- 
2.34.1


