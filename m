Return-Path: <linux-kernel+bounces-134766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086A89B69C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D14B21D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65FE57B;
	Mon,  8 Apr 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOjSCb5U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C98F4A;
	Mon,  8 Apr 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548322; cv=none; b=SA/sxGuNulcE3onoOwTSBidZi3E1VybBsff2THMQI6eczHshs6XiLiv0P9Gf7uAi4//t6EadaNN53ogLyD9HMjgL5dvCXm3t86rWneHwtMD+LSsQljvzhUb6i/lgCrBJCZQ0y73ZLHkUO2CN/1gTMZt+6jCbnluhkLalMBQF9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548322; c=relaxed/simple;
	bh=b99iJg1A5bvxRUOumWSxLIxtvCLHK+sA+lw4WRmUyxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNsybEHIXTfsVpRc+Iu/PTFdBh/YFeelnLug/vbD7emJArYRyLdpMurTvhgsrzHEsO5d/jE7rUUQLG5MZfVwY8rQDwgM94mogp0OgHKJ1yVsmNgV7plklDaSjBL8AVlWIe9kTWpZUtAV0N2OyWwHAtbeyrcNz8UOZJEP83oUDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOjSCb5U; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712548322; x=1744084322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b99iJg1A5bvxRUOumWSxLIxtvCLHK+sA+lw4WRmUyxA=;
  b=mOjSCb5U2Kt42zF7bc+eQOvryf9cRF4O3lC2dMBNYk8JMqmo9eqO7h5y
   vQ0VFueR0hx/Vp5bmicIoOgkVJ6d/y1/uRueKYSzra1Cu5EcHXZuZNpBT
   MctYWxb4dqy2JJuMJ5KZO2ithQO7ACiWD3DTbMWElu3GsPlSiZv2UXMoT
   RnSkhCPwxaRfw7NcfWA9Ebzb85eE9gozR9Sf092tCMgQhTxE1xyInHUFY
   pWU/QHAG9BctLcvoGvl9XaZtbHv40H3HQ9bfyV3A8Mp46yGnjAZnf17Cg
   XeMzqFUawxb8nkEOmW0h7vpJvpmpUKLpNOwmfdtBb+epTxG6X1geS/v3v
   Q==;
X-CSE-ConnectionGUID: XTIoPchySoamnQniAOJIPw==
X-CSE-MsgGUID: 7o7qoMyXTKyxhd7K1t+cZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7909942"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7909942"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:52:01 -0700
X-CSE-ConnectionGUID: vDongyGvQ++vYf9MoiPBsQ==
X-CSE-MsgGUID: QMAjILr8TlyXmz49YFW7Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19870377"
Received: from lihon19x-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.173.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:51:59 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V2 3/3] powercap: intel_rapl_tpmi: Enable PMU support
Date: Mon,  8 Apr 2024 11:51:41 +0800
Message-Id: <20240408035141.248644-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408035141.248644-1-rui.zhang@intel.com>
References: <20240408035141.248644-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable RAPL PMU support for TPMI RAPL driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index f6b7f085977c..947544e4d229 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -302,6 +302,8 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 		goto err;
 	}
 
+	rapl_package_add_pmu(trp->rp);
+
 	auxiliary_set_drvdata(auxdev, trp);
 
 	return 0;
@@ -314,6 +316,7 @@ static void intel_rapl_tpmi_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_rapl_package *trp = auxiliary_get_drvdata(auxdev);
 
+	rapl_package_remove_pmu(trp->rp);
 	rapl_remove_package(trp->rp);
 	trp_release(trp);
 }
-- 
2.34.1


