Return-Path: <linux-kernel+bounces-137846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACE89E839
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F3B1F218D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E00944E;
	Wed, 10 Apr 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0JRq96X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6D38C;
	Wed, 10 Apr 2024 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716486; cv=none; b=FMHkuNbfW67Jkg6Fcn+dL2LYR/Y94jDuN9lUzSMFVTrGdyB/hOuUKQmEVdky/hGQJFF/x6FdK4K/oMrvZxUab+gfJufYS2l2hmUYPstPwK7JyIRa4lDwKRf/yqQ4DYQUVmqPtAd+zBbUDg2UIWe/hsniELtjoazq4CX5/nryTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716486; c=relaxed/simple;
	bh=R6VBlim+71tEDZXZtiIuonlIPFwYuazstmsGh4YD41w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C80wCVeYncZlEiZS+UXpuGeV/eAcgmkCJu8gzg7ryBZPrpUAeFy1U3qd7ANxbpm1+GgwNe0t63qXr62Z6yP8QdFsgsLOsllBOMbfVLKvReL4ha3SpjRQ8G1mzQTs84Z5z6ilOtQ+DOR7m+7DUU4VcG1YNVYDWfjSAk6kNVsPbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0JRq96X; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712716485; x=1744252485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R6VBlim+71tEDZXZtiIuonlIPFwYuazstmsGh4YD41w=;
  b=W0JRq96XkAGWdt50j/56l20BGkMg7/74S81Cn0XZuuOEyn9CAEOnRq7s
   q5BsqwsKE14J03bp9nZ0AP752jmQSS8J//kri747vYS3R4xlHS4XEMr0H
   vYO5t7yZbH6CUfwa+V1btSOTv8TcrjJRVTh+ukPYHIunY4LPxuiso+Q8Z
   X1uyH3d9S8FkcSv14vBkbsLboqqV4pR+DQZ2/4lnoG82f5IOkJgWxA0dW
   B4GEulE/j3juLv5hh0MU0+Aaeakyx1Glukk+s7tkCVnyXWwwHVdVJdC+Z
   iOhvATXVXspHADx3kDpHwFHlq89pkRGJEXm3FsCOd83dlpjTjVdk1FFba
   A==;
X-CSE-ConnectionGUID: Ng21Uu6NTBOhnIxCJ9c0gQ==
X-CSE-MsgGUID: IcSk7HhrQoGdxDGXujZRvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11900164"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11900164"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:34:44 -0700
X-CSE-ConnectionGUID: fwEU+C8lRgCtj1ll65RtFQ==
X-CSE-MsgGUID: ROv5VnFdRka2SXDHB7Do5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43658571"
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
Subject: [PATCH 0/4] ASoC/soundwire: fix race conditions on remove
Date: Wed, 10 Apr 2024 02:34:34 +0000
Message-Id: <20240410023438.487017-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a possible rate condition when removing the soundwire driver.
When the manager becomes pm_runtime active in the remove procedure,
peripherals will become attached, and do the initialization process.
We have to wait until all the devices are fully resumed before the
cleanup, otherwise there is a possible race condition where asynchronous
workqueues initiate transfers on the bus that cannot complete. This
patchset fixes the issue by ensuring all devices are fully resumed and
SoundWire interrupt is disabled after all jobs are done.
The change is mainly on SoundWire. It would be better to go through
SoundWire tree.

Bard Liao (3):
  soundwire: intel_auxdevice: use pm_runtime_resume() instead of
    pm_request_resume()
  soundwire: intel: export intel_resume_child_device
  soundwire: intel_init: resume all devices on exit.

Pierre-Louis Bossart (1):
  ASoC: SOF: Intel: hda: disable SoundWire interrupt later

 drivers/soundwire/intel_auxdevice.c | 10 +++++-----
 drivers/soundwire/intel_auxdevice.h |  1 +
 drivers/soundwire/intel_init.c      | 14 ++++++++++++++
 sound/soc/sof/intel/hda.c           |  4 ++--
 4 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.34.1


