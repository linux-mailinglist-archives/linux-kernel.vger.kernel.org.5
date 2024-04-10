Return-Path: <linux-kernel+bounces-137848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC0089E83B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29458B26063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCAC8E2;
	Wed, 10 Apr 2024 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGhePdET"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088A8F6C;
	Wed, 10 Apr 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716488; cv=none; b=d5SlACCQ5E1qPW9GkBg8ZnMf6sRlNoP2srSsLGzHQgmBrN/4QoT0l6frg2AzZSeSSwonOpG7+BltoUFWS6EDeeHBMZlL6IvMBFZlCw/LLxwW/3HGStftopGjZkSOnewIDNxTtlHvh8fC52xoYFgNPzV3BA4BPHg+ztYR0jfaXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716488; c=relaxed/simple;
	bh=+bbMHOAF08ZcNLfeOm1aEmYLRv5ZcZsPcqoJH5RcMNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKrzx7c1rlcCN4iJ7rFAUmP9uTZJTipsCPAHYYpGIr1SYsaZPlf80dBbhtSNVRMpD+hWze8JdLxOBdoCTldAmGobOCjRUHalZ5hjQhpN3LafqAYg8PdhPNgvQxWhuIG9VXGoKGNQ5SjtHg1yBMGpaH3A1W1Er+utSStzeohUAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGhePdET; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712716487; x=1744252487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bbMHOAF08ZcNLfeOm1aEmYLRv5ZcZsPcqoJH5RcMNE=;
  b=NGhePdETB52Q6+hq2wJbHv0P0a/VFWoEJ2fX7AXtryZTuWHmJI/QWJSQ
   bSq7VVlUsASyvdYcA8A66ybCiQ4ZbrtX1Owlhrp3xP/1n7MLrJdflx3B5
   lrN6nlso3tNYlFBOsRkSdQ6vJlzs1dyFXDcI4i367Qs3Goa1uBz09C/Xz
   BKGd1/PNpA8zO1aEdKHj9njqyI5oDGYePovD5QRX3ZQ6z0DI/O6lmesYH
   l2kM0wJyr/tDu/MamXx/IRCE4lA/DL24PmJxkCKpXthjHZ2BFvn/yXitV
   HMYWj56MwmvL+4jwAvOtx17zCuJHPs/BcypQgepHKa5yIgV0ZLwOLOWoU
   w==;
X-CSE-ConnectionGUID: ecvsHdQ8SWmgoImVzW0W6w==
X-CSE-MsgGUID: bA7xFgDjQ1iCM1yBvWof/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11900168"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11900168"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:44 -0700
X-CSE-ConnectionGUID: qtxdygQ0SYaBgvkefi6Y/Q==
X-CSE-MsgGUID: aqZN1BA0QMiVbMJYGmbyog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43658574"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 1/4] ASoC: SOF: Intel: hda: disable SoundWire interrupt later
Date: Wed, 10 Apr 2024 02:34:35 +0000
Message-Id: <20240410023438.487017-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
References: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire interrupts can be masked at two levels
a) in the Cadence IP
b) at the HDaudio controller level

We have an existing mechanism with cancel_work_sync() and status flags
to make sure all existing interrupts are handled in the Cadence IP,
and likewise no new interrupts can be generated before turning off the
links.

However on remove we first use the higher-level mask at the controller
level, which is a sledgehammer preventing interrupts from all
links. This is very racy and not necessary. We can disable the
SoundWire interrupts after all the cleanups are done without any loss
of functionality.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 7fe72b065451..ecfdb8f882d2 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -384,12 +384,12 @@ static int hda_sdw_exit(struct snd_sof_dev *sdev)
 
 	hdev = sdev->pdata->hw_pdata;
 
-	hda_sdw_int_enable(sdev, false);
-
 	if (hdev->sdw)
 		sdw_intel_exit(hdev->sdw);
 	hdev->sdw = NULL;
 
+	hda_sdw_int_enable(sdev, false);
+
 	return 0;
 }
 
-- 
2.34.1


