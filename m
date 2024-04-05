Return-Path: <linux-kernel+bounces-133004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10889899D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84AABB23EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69941649DF;
	Fri,  5 Apr 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1r6MLJ7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED381DFE4;
	Fri,  5 Apr 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320766; cv=none; b=JES9F4ebE3mgUJ3Sx9vLJMsQ8KZCswUtRXpTPMkwbkhRAOaN3rq7fi3HeM601zAPrRqu9EQfQ2Wq2iBC1087mqoAIWkJXPlher9wf1C31x16HP7hmNZy7zaGi45ceDjBJYIUNIFU5pkxFoD4tCfL6O5VUonwYSeF1Ut5TrsqwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320766; c=relaxed/simple;
	bh=ZKeANhgTUQ8MeecSfiWfk4B2eYxgbQsdvyAYyRCr27w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UAqgR3byMijVpD8kaOkKG5/G6ChBglqPosk9OgOEli73x3Z08mimnpGQz2cBgEFPuPQF2e+oAcpsE6T6VAUP9iANuM1OGW8chVA8iD/LEz3NmjdLGt9d8hjpHSxPL48O823Nj13SBkGlRBQx23/CIO9E5yU0/wPCIj1fKLpsrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1r6MLJ7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712320765; x=1743856765;
  h=from:to:cc:subject:date:message-id;
  bh=ZKeANhgTUQ8MeecSfiWfk4B2eYxgbQsdvyAYyRCr27w=;
  b=J1r6MLJ73aWEOzVTqhlk5LCx5Q3osBZcRRqb0db1KuEN5wm+KWh7mNMz
   1t5s7PlgQ5btna9/Iq1DpzfLijv9HGNUQjCoCKL/ki5wBf9maLwpdbwWL
   bi26lJN9qHDuUM8uz71T8zat0uiwtTqibjSRlVGzyXV5cE8oFnFcnVRvM
   2svvlwWGorlgLGU3J55z+Md5iguC7PKw9BZtwBIqCw62PIn2v20VbCcTQ
   5Mk4uydfmYnQI1jjtG2zr9kGIron2QbZRTDjqskKeiC42wCaHibWeTyAm
   DIAKSNDnZdOL/Yv5DOFK6Lyk81fnSjZ0uixTlcVj1q78NsWSLIAGcQNUv
   w==;
X-CSE-ConnectionGUID: DywZJ8VaTI6gCS3/j9GieQ==
X-CSE-MsgGUID: gFlIuWA8TAe1B0NmsISQmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11464018"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11464018"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 05:39:24 -0700
X-CSE-ConnectionGUID: tr50e2YESf+nmGmKkC6nTw==
X-CSE-MsgGUID: 7M8Pl57oRaC07wIT8Ns/UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19582177"
Received: from srpawnik.iind.intel.com ([10.223.107.103])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 05:39:21 -0700
From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To: alexhung@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	sumeet.r.pawnikar@intel.com
Subject: [PATCH] platform/x86/intel/hid: Add Lunar Lake and Arrow Lake support
Date: Fri,  5 Apr 2024 17:56:30 +0530
Message-Id: <20240405122630.32154-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add INTC107B for Lunar Lake and INTC10CB for Arrow Lake ACPI devices IDs.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/platform/x86/intel/hid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 7457ca2b27a6..66410ab9925d 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -49,6 +49,8 @@ static const struct acpi_device_id intel_hid_ids[] = {
 	{"INTC1076", 0},
 	{"INTC1077", 0},
 	{"INTC1078", 0},
+	{"INTC107B", 0},
+	{"INTC10CB", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
-- 
2.17.1


