Return-Path: <linux-kernel+bounces-159589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E782A8B30A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40772834C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17413AD12;
	Fri, 26 Apr 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gigzEAy/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4F13A89E;
	Fri, 26 Apr 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113644; cv=none; b=XB6JIp3iFYYbB/XEdcEzGEilPfentXS/M0LaxwR/XM/NlIOvzslKI/itLXoSBBpbAIisHZfBA0CAgVG0a9x02LrKho6lEV5U4GrmOq9FPRQPPnOCT0/ThH4QpcvNishJBz+K22ZMYxrDDhkvJ7HzeozCv3HlaqSV3Fpw6PQPV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113644; c=relaxed/simple;
	bh=ZIspi8clGiP50VSdKvNSyq/srgSrGFIwQqkLXlyIljI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdGGW2e1XYJu2FsBp4eq7ZeEAax5UR7NqS6T+xnwmCTbTXemaWjepO+B+SOr/mwg7+/sTIAXrBlYWCUTVbylM9hN40MobuQZqlOHmD+W2rfNr4YKAas2NS6pzz1KKkTAZrHh76lBrehXMopAitPlnzig1at4FpWYg2oecm4VqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gigzEAy/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714113642; x=1745649642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZIspi8clGiP50VSdKvNSyq/srgSrGFIwQqkLXlyIljI=;
  b=gigzEAy/oXw+q2YDL5oLFyMJdoIj/rAk2uE+HF76zgVgEXT5MpPXi0xM
   7IE7QAF6IGFu/L84IhbU8rxqqDZV92Mw2j2VLjPRy1gb1YiyQ1VIZO5mz
   sFIKNRQfRuoGCv/d0C7QATPHsJlVTjW5h3wIR4YqY3rLZJfAEMEkC6tBs
   KR96tAUPpc3iC9fx0AB/BqlIeDX43guP0WIAgwf1VEb+Cu2Sf1qUXMtTH
   mm138b+J9UxZq37Ar0GKmsCUPNeF6HESQeWcN4U731ued3MwpgNyqMBWn
   Nw6Nm6meTtBySKcCBgWiT1cY5rtZkKVflnLmx5qkHGczXpcrFUMEyLVbG
   A==;
X-CSE-ConnectionGUID: i3kkmEt9RseRvnv1SlBXBg==
X-CSE-MsgGUID: jJccSGKlSLWcnT0m4xqdbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20526094"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="20526094"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:40:40 -0700
X-CSE-ConnectionGUID: XullkMkIQhKPCK1hde+lNw==
X-CSE-MsgGUID: t9yY24KvRRSk8LHtX1St8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25399051"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:40:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH RESEND 1/2] soundwire: intel_ace2x: fix wakeup handling
Date: Fri, 26 Apr 2024 06:40:29 +0000
Message-Id: <20240426064030.2305343-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426064030.2305343-1-yung-chuan.liao@linux.intel.com>
References: <20240426064030.2305343-1-yung-chuan.liao@linux.intel.com>
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
index 22afaf055227..8812527af4a8 100644
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


