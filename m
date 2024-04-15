Return-Path: <linux-kernel+bounces-145956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19F8A5D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E675B22864
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649F157A45;
	Mon, 15 Apr 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1UQX5Vl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628091EF1A;
	Mon, 15 Apr 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217943; cv=none; b=beL6lKDJdJZmVBMkQPPk718T43jkmmRt/iAXhV7p0LWnC1HmShdNlFzQ6Q64Wn1KQUO02TZXgOp1gnbn/M8CPLy8NrBEcEiaXLzR+sTIDaGDaJy7th8BXdL27Upt4MlsKlK5SFoGVHVeQZTbLR4+4h/SQQJU7L+J6XpRZDPKthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217943; c=relaxed/simple;
	bh=KJ52F3vvXnDFFDYcpRHY11CkLnLJ7fh/q+VR/api2QU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMi9sfxOTCbMKcs44WCY9+WiXI+i/dtullqxutML3T/ZTRC3YedTQ3Zkh+nB1rpsWCK86t13G1M4VnaNQiLguJkHWJ/nG/09AYsHZugUAkz9UzZL/PnDf4oe7gyU15WqVZkBx01YzGNdYzU5unSXEcCqaT3poZxljXnfvTfyQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1UQX5Vl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713217942; x=1744753942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KJ52F3vvXnDFFDYcpRHY11CkLnLJ7fh/q+VR/api2QU=;
  b=D1UQX5VlXRNaXGres5M51FohKdsvh3DR/FKz59xZVgFVCwgJIS6OCyL6
   JZHaTRoUYkiyFpFsuyIxGbShG9ChLjXk5xHfahP6S2lnwOXcJ55y5TPS6
   rIpUqSokF3OAI/6Casy+s8CIb8MUZSAgGEpU8Es+Qv+xLFBuSSEFLPE5n
   MwQwzeuQfmlPskPPGeshdgvC0vXCGIoIcmkC/hrqSjhQx2dkbO4wgw8t8
   p/A/12FD4vFc1e7hBPsm7x8+uMXXjo30n7HRPIGYCU/t1YOtW2TheUDL2
   yiiTUyCnLx5/WbhGrsRwoWGmQTSL3oR1QgiIzrPHZKumW7WsJXYHqXJAq
   w==;
X-CSE-ConnectionGUID: U0IP5gVbTp2uQ/GXq8PtaA==
X-CSE-MsgGUID: VWW6hZ1BQ2a8sCMeQd7Faw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12420708"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="12420708"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 14:52:21 -0700
X-CSE-ConnectionGUID: UWZ5JvWRQcuqI0TvjinHSQ==
X-CSE-MsgGUID: 5GauRyGPRGCHQv12s/w8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26845113"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa005.jf.intel.com with ESMTP; 15 Apr 2024 14:52:21 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel-uncore-freq: Don't present root domain on error
Date: Mon, 15 Apr 2024 14:52:10 -0700
Message-Id: <20240415215210.2824868-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If none of the clusters are added because of some error, fail to load
driver without presenting root domain. In this case root domain will
present invalid data.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 01c10f88c9b7 ("platform/x86/intel-uncore-freq: tpmi: Provide cluster level control")
Cc: <stable@vger.kernel.org> # 6.5+
---
This error can be reproduced in the pre production hardware only.
So can go through regular cycle and they apply to stable.

 .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index bd75d61ff8a6..587437211d72 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -240,6 +240,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
 	struct tpmi_uncore_struct *tpmi_uncore;
+	bool uncore_sysfs_added = false;
 	int ret, i, pkg = 0;
 	int num_resources;
 
@@ -384,9 +385,15 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			}
 			/* Point to next cluster offset */
 			cluster_offset >>= UNCORE_MAX_CLUSTER_PER_DOMAIN;
+			uncore_sysfs_added = true;
 		}
 	}
 
+	if (!uncore_sysfs_added) {
+		ret = -ENODEV;
+		goto remove_clusters;
+	}
+
 	auxiliary_set_drvdata(auxdev, tpmi_uncore);
 
 	tpmi_uncore->root_cluster.root_domain = true;
-- 
2.40.1


