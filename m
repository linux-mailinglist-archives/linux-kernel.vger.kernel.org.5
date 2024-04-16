Return-Path: <linux-kernel+bounces-147613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B98A7687
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489C71C22AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C7150995;
	Tue, 16 Apr 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sdj/G/4D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61914EC5A;
	Tue, 16 Apr 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302539; cv=none; b=OUcKDYyUyHVG38HpaRkvtVYl06nR5dNQjlkDJQIEzo1Za7AIG0kB/H2lQ1r/8HeP0cB5e8jXclRKSfGuYSBfmdhAqjElbQxCMr4/8Y4+sUUkbvc9epAeuJGO3+SGGqebZ8VJjo14v9+/1PqJfaGoud4jWVMuFKIBEEcXs4FbSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302539; c=relaxed/simple;
	bh=TH6/8w9pkWktCUcxRMlnQFc4unYcczUDErtWtr3bsHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDqv40eaNo0aM0oDwSjjrLfXTnZ+9J2Qv4MCFy8S2CL1R30MctFvOB/fvK5a95mrkGuZv7dh/gNte/xeoIdFtS9+3FsCvqwL7ntXjM48hYTsMXyx02Kr5ER++mouvPuCvxELv2jOGkSulgB88Jff1W3C/wLSHrZ2FzbJmnVZjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sdj/G/4D; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302538; x=1744838538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TH6/8w9pkWktCUcxRMlnQFc4unYcczUDErtWtr3bsHw=;
  b=Sdj/G/4Dxe91wesBDAj96cDVjLV04lGXFTa6RdO+nyfZh9bT2uMYVQi9
   nUV5Qk0D0TBJEVzwsV0j9BMchal+fQ4CRRZDWV3t1Hwr2og2J9DK6Gn3m
   DUDrmCbYmXSUq+1rSD+8VUIcmToYIM+id/LBoqLyInb13mVTaQM/O+p6M
   0w7ZGA56NctlqW5wSmq3VaDSxzQQM2O7y7O3xDN+B5AgJlM7yp/61W8r6
   tUoqJcsY6amjNqHEpXJbyJpof0BcbpP9Cqxplopyq7lfOa8Fkrf1151kK
   uh15P+fweruP1B0OVI+T9LpAFq/ccFWey6hBK0Qe75Cz9mQiDfcc3Rwtt
   g==;
X-CSE-ConnectionGUID: JwGVbOn4TK+mvoR+2tA+WQ==
X-CSE-MsgGUID: H9Y6s+26RzmIJ+3OIpNJ5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234911"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:18 -0700
X-CSE-ConnectionGUID: hTy9SK5eSamZQKFrVmcg8w==
X-CSE-MsgGUID: 9JDhzo0QSLeGlvnVyKw/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267083"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:17 -0700
From: Tony Luck <tony.luck@intel.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Date: Tue, 16 Apr 2024 14:22:16 -0700
Message-ID: <20240416212216.9605-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/hwmon/peci/cputemp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index a812c15948d9..28cec5c318d4 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -11,6 +11,7 @@
 #include <linux/peci-cpu.h>
 #include <linux/units.h>
 
+#include <asm/cpu_device_id.h>
 #include "common.h"
 
 #define CORE_NUMS_MAX		64
@@ -361,9 +362,9 @@ static int init_core_mask(struct peci_cputemp *priv)
 
 	/* Get the RESOLVED_CORES register value */
 	switch (peci_dev->info.model) {
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case VFM_MODEL(INTEL_ICELAKE_X):
+	case VFM_MODEL(INTEL_ICELAKE_D):
+	case VFM_MODEL(INTEL_SAPPHIRERAPIDS_X):
 		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
 					     reg->func, reg->offset + 4, &data);
 		if (ret)
-- 
2.44.0


