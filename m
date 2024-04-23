Return-Path: <linux-kernel+bounces-155869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C38AF839
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95441F250F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF4144D2D;
	Tue, 23 Apr 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsAOrce8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9813E02C;
	Tue, 23 Apr 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905189; cv=none; b=I0w/DXUxWc7eJqG3wbxO/TKyw/X1s2cgBB10v9RXBPc5xmHhpwPXKKuCJ6x9VrhPOvtTEX1FQ1AlcN0NEusKa5LqRiO3Ivp2/q5lcHlvlwe1AM2MEs+E1Je8IGxdXP2tw5dIr4tzS2QkIMYkk1IZ+cY/fI/HEaeY9DWtGeLIhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905189; c=relaxed/simple;
	bh=I8WlCO7J0Bkb/d2OhXTFjWUNzIGy1ipush1doJz1FUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htj8LtOb+anjG2nPNJpWImFN215p1hiGjEoF5D/BWMo95mtdZAt5HiaKCT5dFHhgKGG3YwbeleVk2FXZX+XIe1NXvODfswjBmxZYcCp2FX6kOUNoJfKuPuNM9dfgUKygttkgUU7fO+VPtSFs1UVYaVZ7t083zPXHaI58HakVngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsAOrce8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905188; x=1745441188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I8WlCO7J0Bkb/d2OhXTFjWUNzIGy1ipush1doJz1FUY=;
  b=MsAOrce8enKHod35wZ6qMkQP3YAnt91qKn0Cls35W0r/gunZN/GRAAN7
   hpoGeuC5whh7FdMMcy4LpHruh5+bQ9HDamzWa5E/ZaW4iXlxN29kyfgqb
   KYZKkPnG42LRjuDq+AFagOyBnU+9vI/jdMUecaqodMoOuEPzL3ftjKJgb
   p4dzntGz97LEtKDPMbwbHQ2WlZYNkzJT23QRrgkH1594I7NfM6sHAMMmE
   AyiO3btSQeIvpcp2/nifZvliU3ohXYyaYC9W+6kyBntYrfE+AeDl+RPnc
   gqwQy8u96Dvb1I1pVx0/fWfkUlMV1wkX+jgAyRx9g1p8lL0+f/v5g10Lx
   g==;
X-CSE-ConnectionGUID: R3blV5sKSWK+jFpWAPcY3Q==
X-CSE-MsgGUID: CIHJZ+CMSeKZI8ODNlJO6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912332"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912332"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:25 -0700
X-CSE-ConnectionGUID: OsTMaS0AQdKUURh0e7oLDw==
X-CSE-MsgGUID: Sz08ig30S+21tyyoFhL86Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533091"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 08/10] platform/x86: ISST: Use in_range() to check package ID validity
Date: Tue, 23 Apr 2024 13:46:17 -0700
Message-Id: <20240423204619.3946901-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use in_range() macro to simplify range check.

No functional impact is expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index b8da6847622b..e75fb9eba598 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -531,8 +531,7 @@ static struct tpmi_per_power_domain_info *get_instance(int pkg_id, int power_dom
 	struct tpmi_sst_struct *sst_inst;
 	u8 part;
 
-	if (pkg_id < 0 || pkg_id > isst_common.max_index ||
-	    pkg_id >= topology_max_packages())
+	if (!in_range(pkg_id, 0, topology_max_packages()) || pkg_id > isst_common.max_index)
 		return NULL;
 
 	sst_inst = isst_common.sst_inst[pkg_id];
-- 
2.40.1


