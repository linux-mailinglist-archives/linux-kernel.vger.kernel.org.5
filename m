Return-Path: <linux-kernel+bounces-138441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA989F154
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67BBB236C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD515ECCB;
	Wed, 10 Apr 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqMCVXwZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D615B118;
	Wed, 10 Apr 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749752; cv=none; b=K4rm22i3WnjDsb7FuuwT96xw2Ysq+1ZLm/oG2H5Cub+XZn+HujzV6waszOcmlzzc9vd/XhphsOXak8k7dwI2m90ODmGW3N64ocZQKi8Wlo7efoUchUwxGapQsB0pF7JrKy3av1ULrovjLDFV3fx1s0SizD8Tbdu/nD4g2mFFUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749752; c=relaxed/simple;
	bh=lrwNQNbX+WXy0lfMMpmVqKt2xS86UNsIcJDE0QsIpSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ft1OMIMUHL69OicyelnY5GqN1y2Yk0oy/veS53IDicwuSNRu6aXE6SL7pcgHHZBnAXL4pHOskGcFtQZ7aaz5oqsmKS2iC1nkz5bpHonEnQF219SvHRDtzASDWVotQQWgsdZS96iy4CryGS4wYSlmTO2mOC9vAjJwFH8B38dsR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqMCVXwZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749751; x=1744285751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrwNQNbX+WXy0lfMMpmVqKt2xS86UNsIcJDE0QsIpSg=;
  b=hqMCVXwZ2uY+bZAj684qoED1ViXgU2UUD+Q4FC1810hMzFsQXrrH1qbl
   4VNlTvpxRwbhx1PewaabYRYIsP48Jdoib4/4LOHaM1E4p/4VDf9feScK6
   3hdlXpNInKbeBT9Rnw6MkrPlKCipAxiZBg1MO6S+hRKJ5CNO0Nsr5lG76
   Y087cG3Rlmf86e+bzbyLZuMQ5ByMggUlzg8EIgHhjFh5Pqu52aicvLsUy
   slAZJy6uWWxzwe8DgQFFmp4eJ8UimURTRxSh+P07gVmpQzKwgr+7Wodbf
   tK8+zP+yLHKi1NUsXM6q1WGLB3vFFUy2NzXK/PasqmA5m6nxNJU/pMF5O
   A==;
X-CSE-ConnectionGUID: 2q7NO7ZzSK6WS41cJ0U5lw==
X-CSE-MsgGUID: eRpzKH5ZRMu5wJS94N0ndw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11944134"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11944134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:49:10 -0700
X-CSE-ConnectionGUID: CPy+j/t/T/aJT9389dDQcA==
X-CSE-MsgGUID: 7d+OO9KrQT21fLhg+OKhiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43769266"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2024 04:49:03 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v6 05/11] ALSA: hda: remove convert_art_to_tsc()
Date: Wed, 10 Apr 2024 17:18:22 +0530
Message-Id: <20240410114828.25581-6-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Remove convert_art_to_tsc() function call, Pass system clock cycles and
clocksource ID as input to get_device_system_crosststamp().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 sound/pci/hda/hda_controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 206306a0eb82..6f648fae7a7b 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -463,7 +463,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


