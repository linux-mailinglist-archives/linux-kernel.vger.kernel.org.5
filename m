Return-Path: <linux-kernel+bounces-161648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133E8B4EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED32B208CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC663E;
	Mon, 29 Apr 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8vP9Ks4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE67F;
	Mon, 29 Apr 2024 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351443; cv=none; b=rWos9PIvXEzsg2JH7R2aWzDSel+IKTSeCuzih4F0gH2AJw4wvmHKCIyHgwkTWavFbPhWU63ZYJKUfLihbZgW37YKwtUCGRosD6Q+M+1Zz8fOgXOqKLI0ZcqQxQaMktBo/E8oG/KZY4OWm6GQl3aDCAmtpkQGgy32YPcrhr3a4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351443; c=relaxed/simple;
	bh=eCsQRV0hk4irf8pN5ENc7ollyEldkc1hJb3/EZqJlHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BaqKRUTLrV7I48VDyvZTMPUnbzHZr4jS51pD6oEwUdJF8ZN5wtAxYycFzKns3pxzTpNfliMKVHh4nBxyb06esapBf+MhfKoFm60qmITdwHcVUZacnBsHKAZYhWxzYpboViNMHqo/+gHSPmOjf6BlQh64OluSHd9fG6sXtFsdZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8vP9Ks4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714351442; x=1745887442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eCsQRV0hk4irf8pN5ENc7ollyEldkc1hJb3/EZqJlHs=;
  b=N8vP9Ks4AwM0r00j/5xAcocMGjoSlc/+xYDY7MTak/AYkzfCG+zzEV2t
   iFJy5M7OwwOJKE8H+nUdqJUVV8T8dgJ6blrdyqLwSO+SMcTn4ZzmS4HS5
   GcoA1aXToiAEVdzFsY92Nf2mo+EHWFyhwv/HrOM19xpesV/yK93tnEN1i
   V4nmIZpBrVuEJPE8noix+9n6tam7UmxZNJYAXnLJc+PJbP2F0lzEJCPSu
   T+zWSvRYOc7npfmOV3AOwTZXYn68h4bz4juzkES8T6zOonODhKZF7rRmz
   C3WEHVSYoa3eOt1Yrh0Hdwr+N3HbCdoAQR0hMIjzVP/FObNNAvAHgFDpw
   w==;
X-CSE-ConnectionGUID: qWP8waDgTWCY5qryhyuBgg==
X-CSE-MsgGUID: IgYPaO43TGuCp/Eqb+phvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21152933"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="21152933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:01 -0700
X-CSE-ConnectionGUID: 518qLbwoQ0qrkAkY4JW/YA==
X-CSE-MsgGUID: S78SS30wQ72Vi6jLaRKe3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30423050"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:00 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 0/4] SoundWire: intel_ace2x: read DOAIS and DODS from _DSD properties
Date: Mon, 29 Apr 2024 00:43:17 +0000
Message-Id: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DOAIS, DODS, DODSE, and DOAISE fields are Intel specific and the
recommendation is to use settings read from DSD properties instead of
hard-coding the values.

Pierre-Louis Bossart (4):
  soundwire: intel_ace2x: cleanup DOAIS/DODS settings
  soundwire: intel_ace2x: use DOAIS and DODS settings from firmware
  soundwire: intel_ace2.x: add support for DODSE property
  soundwire: intel_ace2.x: add support for DOAISE property

 drivers/soundwire/intel.h           |  7 +++++++
 drivers/soundwire/intel_ace2x.c     | 18 +++++++++++++++--
 drivers/soundwire/intel_auxdevice.c | 31 +++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h       |  2 ++
 4 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.34.1


