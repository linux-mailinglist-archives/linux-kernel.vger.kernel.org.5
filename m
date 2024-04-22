Return-Path: <linux-kernel+bounces-153697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C18AD1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C311F245FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DB153BF6;
	Mon, 22 Apr 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abI9eV8l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43B153BE2;
	Mon, 22 Apr 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802863; cv=none; b=FGmUFAIfmjKU8uDZNwJe3uUOlkhJmflZrFLf6SzS6NXaDYbqCpGvqkNPVxAjg7OlV+WJ2IVC6I8VOG0UkoOXOgGO4A/jubYv2Iay1x3q4jJjCPuBzyM7acunOWPKSeulnetWZROsp8g16ovSLVDvm7eqWGwz2QfvcHvX62jzSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802863; c=relaxed/simple;
	bh=b99iJg1A5bvxRUOumWSxLIxtvCLHK+sA+lw4WRmUyxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxdbqOgnugw8nu/4JrjXBVNEILePBLKZbyPU+EcjePRFSaqrhZ6qxRx/VT6ReT6BxldTbCve0LbdENbNA3xIIQfTFdh3J3lGKcux5Yp7Nr0D/7nAOaDW+PxStE7VCYfODxMmboLP0gQ3AbxsQPrRVmPd8H4DMR/1ghJrB8d4tQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abI9eV8l; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713802862; x=1745338862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b99iJg1A5bvxRUOumWSxLIxtvCLHK+sA+lw4WRmUyxA=;
  b=abI9eV8lgrA/dP6MidSyhcQWGNX6316W4JhThR9M2sb2ZZSYce0JHJjt
   QTe4RbgLAa9hLLKmOgPkH8pht3dKaB+LqXm2yi1N+wUBdcsRDW9JSRq9g
   oIzTOfXs/tVgu8skCT6xX2//3/+N9RKkTd6Xmq6U2FG0vL2Eg3E/Cy6xy
   Gr66ZVHJJxvsZv7Cv1XAomN5huD7zqUZBFUCgnUv6UyOg0LNOrjZLjtj3
   YBus74z1iYKUtMqHxwCAuAOlSSzzLwqEOhohtIvbJ5LlAonH5ETKOkypf
   T6vXaH0oQ4OORndkh3ZsXQ2Fp+y9cj+FLZFXXfv1DEtm9RG5ootxgOYVc
   w==;
X-CSE-ConnectionGUID: 1mvpljJCSr6Thr6Bd2HQOg==
X-CSE-MsgGUID: GnwpNsDYSCWr+ivU9Q4U7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20754874"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20754874"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:21:01 -0700
X-CSE-ConnectionGUID: Gi48XVGxT1qxGkQse80rNA==
X-CSE-MsgGUID: J6n7HzKHSnyQcialVOO2Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28739005"
Received: from lxia1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.209.16])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:21:00 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V3 2/2] powercap: intel_rapl_tpmi: Enable PMU support
Date: Tue, 23 Apr 2024 00:20:40 +0800
Message-Id: <20240422162040.1502626-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422162040.1502626-1-rui.zhang@intel.com>
References: <20240422162040.1502626-1-rui.zhang@intel.com>
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


