Return-Path: <linux-kernel+bounces-159590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E6C8B30A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D4228487D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA113AD34;
	Fri, 26 Apr 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKi8CvVx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FFC13AA31;
	Fri, 26 Apr 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113644; cv=none; b=ef3x9QNVbMqeeKDUn0uBrDHoWgIgCejtKNXHRSDgk/4ABNdy010ERb17XEKd0M9jA31bNcpijHKjbN1deKjJ5ckS8rkG0s2KzQQ1zXvMFhLt8fpjYdVPRB1XwuU69ofpkvvTKEHyuxGUy8qM614hVNs4o4elnAs8dPHbi/yFYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113644; c=relaxed/simple;
	bh=10H4S20sO62kKq9BD7lzNSalZU2xlXNz9QAxvCzyf9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wfl7iEvJA0OjYYDXXCdRsKI1ALSREhgEhew4rVmxU9pyGvlYxo8uS7S5eo9zXK0AEpUg/aDP6dtR1YZMNTdcFVBFJDFwD+Dmx+XqM96d6K/MDg1Uqm7QKTQabM2ZnMkvGhraGFrG8lVTAocYo5dTs3vkf/jiUL/AAOt8vY7guO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKi8CvVx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714113643; x=1745649643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10H4S20sO62kKq9BD7lzNSalZU2xlXNz9QAxvCzyf9k=;
  b=UKi8CvVxXNEtzzmZPG/sg/MNagXjVIiIWu/FV8H5gQ0yGlGXMWlpyneh
   AGDdwXUxQOXJC5DPCPjgrNKlja0P6XKh+wAFs6YFXKOyYfc0h2woDCe5N
   PwodYYMF64/heXI3bbg0aEMnZLc1ybNLdqqQeAVAp0QqsKJtD15jM5HDs
   fEY+G7yZ1oBm03YSJZCtv8nCohENsa89pc5txsXnOsh+anIPrngUUydNL
   kq28ep1JvGX1SZupIq+gr6FfJKxBWGefij4Ms1TGHGtmeJM4xA0n0LqDF
   i2t2RRtuJ2AajMeQAYaTGhjirhfQqJNDa5xan+/Ja1yQtgvvaftGB+/wU
   g==;
X-CSE-ConnectionGUID: kZkXFkl8TnucxuuE/vrAhg==
X-CSE-MsgGUID: FciQic7fS1iF4pmpi0/+xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20526098"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="20526098"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:40:40 -0700
X-CSE-ConnectionGUID: g5wA7+IwTRWzOAoaud2ppw==
X-CSE-MsgGUID: XYGWmrzNQCqq1s+iIVQ13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="25399054"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 23:40:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH RESEND 2/2] soundwire: intel_ace2x: simplify check_wake()
Date: Fri, 26 Apr 2024 06:40:30 +0000
Message-Id: <20240426064030.2305343-3-yung-chuan.liao@linux.intel.com>
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
index 8812527af4a8..75e629c938dc 100644
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


