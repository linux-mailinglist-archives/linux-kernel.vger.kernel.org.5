Return-Path: <linux-kernel+bounces-165690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF948B8FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A770D1F2239C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD61607AC;
	Wed,  1 May 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTaZraSH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342912F395;
	Wed,  1 May 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588834; cv=none; b=pfxOVOGXxIMphNu9dz6wD2yrx4q/ERxizFrG5i2TqHru88iIi03ivCXulD6aey1UDqJzm5J0txeQ/XbcwM669RaEkirfzkGsWB8E2IapaVJMo1BNo/2IJq06EfcHpN1LTLUgkt2LugGfGpbvvzfZSi7G4zH/4flQjKzdyYu4fG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588834; c=relaxed/simple;
	bh=Mzgv9pzl4+hs8G726Lz4maLhlKFliw7RLIHFVXczfgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LOxDKYemBJvquYW+l7hRFhr/0d1VE5H28vBducUv6tYNacbs9FdjT09Fmh1DCrGFLYF1TbJ/UQsuRcGfzkSZylZgB1c7Fx3Ye+bo5fmYE6mirVG1Em1QlLvtiti5JmPwyRify90mu4r24Wg+BQwVXUlzlKpqGRuxLorcJuH/RJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTaZraSH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714588832; x=1746124832;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Mzgv9pzl4+hs8G726Lz4maLhlKFliw7RLIHFVXczfgI=;
  b=MTaZraSHF17mmT28GoqVTn0HRTa1n2rbQHzhVp2A/AQ03/FDJOwzlU2R
   h0I0lHyCXxoqhAm3FM5yshNJTqXg6gPqSWbTsz0L5vl5OI8vxraf7zUoY
   RIWPST2KKcghMCcrSF8D8MMiD0Eio+u2vhCZ59MVpvPPoh3o1noeQWpEB
   ElGkae65DMaxLHQlIL/V3PFNjW/yTD+7U9/LOQtXqzdcai1RKufuUAx28
   Mnv2FEDv+dZu1uMv+aR+sOnqocppJtXWK/jfQ7cXH8D9QFUYzmGId319I
   XXnKHLapfu8XtLSbvUdZXLxTYKfSC084S86UmZWGVGb55htL0Wy9wZhaX
   Q==;
X-CSE-ConnectionGUID: P9w2venFREy4KkAsPi0OYg==
X-CSE-MsgGUID: s5jg0wIBStihxZUBmmDNrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10185858"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="10185858"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 11:40:31 -0700
X-CSE-ConnectionGUID: Ckai+5VxSsqFj9YRS1mJpQ==
X-CSE-MsgGUID: /uN/ZNZOTvyDOiK+9irPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31348092"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.82.114])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 11:40:31 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 01 May 2024 11:40:23 -0700
Subject: [PATCH] cxl/cper: Fix non-ACPI-APEI-GHES build
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-cper-fix-0day-v1-1-c0b0056eafbc@intel.com>
X-B4-Tracking: v=1; b=H4sIAJaMMmYC/x2MQQqAIBAAvyJ7bmHViugr0cF0q71YKEQh/T3pO
 AwzBTIn4QyjKpD4kixHrKAbBX53cWOUUBkMmZY60uhPTrjKjRTcg56sC0Ovl8VbqM2ZuLr/N83
 v+wHbPxw9XwAAAA==
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714588831; l=1181;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Mzgv9pzl4+hs8G726Lz4maLhlKFliw7RLIHFVXczfgI=;
 b=5t1ueDJnE6x+j+9ekOG12qu6ugjSPoamFqnOoF/ury2/1DDeq23OhIKWoTlUK1x5+qvkhNUgA
 cybnde75kDlCq0h5ILqKipfEKPEyVbWoO3W4VtK5vbjgdci2pPPkJBC
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

If ACPI_APEI_GHES is not configured the [un]register work functions are
not properly declared.

Fix copy paste error.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/cxl-event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index a0067c49e2ca..13090857c066 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -152,12 +152,12 @@ int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
 #else
-static inline int cxl_cper_register_work(struct work_struct *work);
+static inline int cxl_cper_register_work(struct work_struct *work)
 {
 	return 0;
 }
 
-static inline int cxl_cper_unregister_work(struct work_struct *work);
+static inline int cxl_cper_unregister_work(struct work_struct *work)
 {
 	return 0;
 }

---
base-commit: c19ac30eda3a1d14d4883de0ea214b6c5c96a9b4
change-id: 20240501-cper-fix-0day-c03ad861bbc3

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


