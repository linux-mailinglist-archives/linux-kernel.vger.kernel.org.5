Return-Path: <linux-kernel+bounces-158946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF88B2739
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9381C23CED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367EB14D718;
	Thu, 25 Apr 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBjKE466"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064B14D712;
	Thu, 25 Apr 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064948; cv=none; b=u59ZO5tMxAWaLT35zFBLW/nmHBM4r1tx67byVkfOHSu1lkB8IrJ4t8aAbxK0HLVPtO4fedocRBw1pWMG2UL31Ecxvs/bvAV4yAqfba6XpMKageoLBkE45Au0TmkPVkDQA78PKe5OQ4Vkm5D6i4RL3Ks9mun7INsv0RAMS4nc1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064948; c=relaxed/simple;
	bh=LUmBuiTPCpuoP9GA3Fh0URX/lzsRO0Lx/ToLVC7HoAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jh8gb4USs73/UZRJbRrPO9ASbmkBSFDyVYtQCofoQJVWYtmtiGX4cRDRDC2BPMka/9yGPg9hGXA1ohZ4gQqiPEDCNSIAfqMVUAVCMReO2AbW/V48uc4vUd3ueUUqW5PCaa8u/2ZoTGXhM86bKBhNDzv4kmwoRl4iPSOWAsIJ2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBjKE466; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064947; x=1745600947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LUmBuiTPCpuoP9GA3Fh0URX/lzsRO0Lx/ToLVC7HoAM=;
  b=gBjKE466sikYlw77vRuQFNG64NIMegdDvN6UfdxCPTNz62FtPwgONg+B
   oEyj4UCoDAWZUMXcveH40o20WzngEMBplv+w8ERlzncFFy8u4az3d2u9k
   KEqW5c4Lsw6CfTf/Et73dEcu/Nzn5lmpLjzzkoiE4QccMzDyT7Eav8A3C
   InXHlVMeG/DeIvOfHhII8FA/D7chIkoOxobiqNHhNUHtbRyFh2SUOviv+
   ge0EYMfiT+8QLzdrHk8igCV31sRz1OfK+biP20wQlsbHyTcs77yZ2R1b8
   DJ7RGKdJP7d/jcgaG5ZaL2USDEaQEwy6Yx+aezUXSVEZBSUwFalOHJCvP
   w==;
X-CSE-ConnectionGUID: slri80CvTjWNB8b0r8X+cw==
X-CSE-MsgGUID: qItOAcdwSNG+l8j5lNiV7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13554454"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="13554454"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:09:05 -0700
X-CSE-ConnectionGUID: UcbMNhXLSkGenNFAfdS2QA==
X-CSE-MsgGUID: 7vPWFdT8RT2VDXptYaxVLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29595991"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 25 Apr 2024 10:09:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6FFA5136; Thu, 25 Apr 2024 20:09:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v2 0/2] mmc: atmel-mci: Get rid of leftovers and clean up
Date: Thu, 25 Apr 2024 20:08:43 +0300
Message-ID: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I used to have some patches against the driver, but it appears that part
of it has been applied (in different form as done by someone else).
However, there is still room to improve, hence this spring cleanup series.

In v2:
- dropped applied patches
- fixed kernel-doc issue (LKP)

Andy Shevchenko (2):
  mmc: atmel-mci: Incapsulate used to be a platform data into host
    structure
  mmc: atmel-mci: Switch to use dev_err_probe()

 drivers/mmc/host/atmel-mci.c | 72 ++++++++++++++----------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


