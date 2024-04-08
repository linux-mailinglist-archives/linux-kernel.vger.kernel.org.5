Return-Path: <linux-kernel+bounces-134827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77E89B786
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D606B21C51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90C171B0;
	Mon,  8 Apr 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaW0/pPo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB58827;
	Mon,  8 Apr 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557038; cv=none; b=KwP6toej4MVg05E/35/f9iXuxW+5xBKLb84qe7G3G1eQgQz6bQIhGtH4/qqqAyLGZTavlJS/poI0DEOSNTzsoAARC9FkOYK60e/Tnvnep4PDor1Gcc98C7mnWP/AKFERcf5xVWcZR/9SBJjU2Psz3Of31XMmSGwKRRu+YOzSAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557038; c=relaxed/simple;
	bh=BVO25ii86k6Vyr75+LHLBzTqlO1r919XfPw4uhYB7n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INuaPm2UBi6l+6peFTTUYluFwFiRPLbvphjYpKhKRMMoXdjx5pFIdqiCDN8uBJDLlnaFiPOuWkb0we3aNGwTs36K2Cc3Wo45XerU2Z5TOHfDOaOSz3t8xjz7GS23Vcdo4Bt0d09T5pPY37DzoC3E9ArBLskMZ650xax4+GrMPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaW0/pPo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712557037; x=1744093037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVO25ii86k6Vyr75+LHLBzTqlO1r919XfPw4uhYB7n8=;
  b=gaW0/pPoXVXXnzSNceJtgUzzdK4+sAPNr89JBFyMlWicG6LYIij39kxI
   iop+ilB8SoHEFQDNEBPO1NX9wUERz8vvNVxjL0gW4JplLJNexTHFYm+bp
   oE7zPR1OcHYWkWjuqffNf16LTBpANIeC6q3SySpPu3I4MsR0iYDS9ncjo
   8p5ZlOtGSH7O9QU7JPevTTAgBXRxLigoSzJ5TV4r8h8QfPkfdVcyxJWoK
   CfiXOnFRNem8EczL4OHGja+FTp0IQ9nN9Um9Z1zE26w8pcx9VLRJEI3gI
   t7BaE3UOdBNzSpyv58j45vlsRWKCoPWMXGquIC0C8MzcV8k27re46BivQ
   Q==;
X-CSE-ConnectionGUID: AutZOnMLRr2kd+lMJsGd3A==
X-CSE-MsgGUID: ZA4WJtWiRTWUUWqubonaMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7675332"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7675332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:17:14 -0700
X-CSE-ConnectionGUID: 30H7Ti21QZapI4lEdtAYLA==
X-CSE-MsgGUID: M2AxKJvuRK+YN9gAtqQwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24511956"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 23:17:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: intel_ace2x: fix wakeup handling
Date: Mon,  8 Apr 2024 06:16:42 +0000
Message-Id: <20240408061643.420916-2-yung-chuan.liao@linux.intel.com>
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

The initial programming sequence only worked in the case where the
OFLEN bit is set, i.e. the DSP handles the SoundWire interface. In the
Linux integration, the interface is owned by the host. This disconnect
leads to wake-ups being routed to the DSP and not to the host.

The suggested update is to rely on the global HDAudio WAKEEN/STATESTS
registers, with the SDI bits used to program the wakeups and check the
status.

Note that there is no way to know which peripheral generated a
wake-up. When the hardware detects a change, it sets all the bits
corresponding to LSDIIDx. The LSDIIDx information can be used to
figure out on which link the wakeup happened, but for further details
the software will have to check the status of each peripheral.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 49 +++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 43a348db83bf..f26d4e5c2c7a 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -10,8 +10,10 @@
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
-#include <sound/pcm_params.h>
+#include <sound/hdaudio.h>
 #include <sound/hda-mlink.h>
+#include <sound/hda_register.h>
+#include <sound/pcm_params.h>
 #include "cadence_master.h"
 #include "bus.h"
 #include "intel.h"
@@ -49,37 +51,56 @@ static void intel_shim_vs_set_clock_source(struct sdw_intel *sdw, u32 source)
 
 static int intel_shim_check_wake(struct sdw_intel *sdw)
 {
-	void __iomem *shim_vs;
+	u16 lsdiid = 0;
 	u16 wake_sts;
+	int ret;
 
-	shim_vs = sdw->link_res->shim_vs;
-	wake_sts = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_WAKESTS);
+	/* find out which bits are set in LSDIID for this sublink */
+	ret = hdac_bus_eml_sdw_get_lsdiid_unlocked(sdw->link_res->hbus, sdw->instance, &lsdiid);
+	if (ret < 0)
+		return ret;
 
-	return wake_sts & SDW_SHIM2_INTEL_VS_WAKEEN_PWS;
+	/*
+	 * we need to use the global HDaudio WAKEEN/STS to be able to detect
+	 * wakes in low-power modes
+	 */
+	wake_sts = snd_hdac_chip_readw(sdw->link_res->hbus, STATESTS);
+
+	return wake_sts & lsdiid;
 }
 
 static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 {
-	void __iomem *shim_vs = sdw->link_res->shim_vs;
+	u16 lsdiid = 0;
 	u16 wake_en;
 	u16 wake_sts;
+	int ret;
 
-	wake_en = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_WAKEEN);
+	mutex_lock(sdw->link_res->shim_lock);
+
+	ret = hdac_bus_eml_sdw_get_lsdiid_unlocked(sdw->link_res->hbus, sdw->instance, &lsdiid);
+	if (ret < 0)
+		goto unlock;
+
+	wake_en = snd_hdac_chip_readw(sdw->link_res->hbus, WAKEEN);
 
 	if (wake_enable) {
 		/* Enable the wakeup */
-		wake_en |= SDW_SHIM2_INTEL_VS_WAKEEN_PWE;
-		intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_WAKEEN, wake_en);
+		wake_en |= lsdiid;
+
+		snd_hdac_chip_writew(sdw->link_res->hbus, WAKEEN, wake_en);
 	} else {
 		/* Disable the wake up interrupt */
-		wake_en &= ~SDW_SHIM2_INTEL_VS_WAKEEN_PWE;
-		intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_WAKEEN, wake_en);
+		wake_en &= ~lsdiid;
+		snd_hdac_chip_writew(sdw->link_res->hbus, WAKEEN, wake_en);
 
 		/* Clear wake status (W1C) */
-		wake_sts = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_WAKESTS);
-		wake_sts |= SDW_SHIM2_INTEL_VS_WAKEEN_PWS;
-		intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_WAKESTS, wake_sts);
+		wake_sts = snd_hdac_chip_readw(sdw->link_res->hbus, STATESTS);
+		wake_sts |= lsdiid;
+		snd_hdac_chip_writew(sdw->link_res->hbus, STATESTS, wake_sts);
 	}
+unlock:
+	mutex_unlock(sdw->link_res->shim_lock);
 }
 
 static int intel_link_power_up(struct sdw_intel *sdw)
-- 
2.34.1


