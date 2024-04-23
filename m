Return-Path: <linux-kernel+bounces-155872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636868AF83F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959881C23DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB0145B0E;
	Tue, 23 Apr 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsPp/BGb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101A1448F4;
	Tue, 23 Apr 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905191; cv=none; b=Yv9/v1q8+o5xZmQJ7jwlguP/BJrFUCl24SMFj4v2/DjuW34Ez5KX10o60vbBvgWjFErg4zqB/9vl1BhLPXxjS8TFt0kdRci7sD0Kby2d2H/OcGS1OL8ex+xG9pTdJiq56TdSnoZmNK91ZaZh/OXxE2dKIEnXmwLblI5YaCDFdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905191; c=relaxed/simple;
	bh=drkyXSjGm8GFfGPcgPvR0ybUmkf8fe6rUFnbVa6tYdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ocy2nJ+OaFWZKPRiPU8q4MxjU472/1DlNOn5Iinkbb7MAwulk0xw7BUmyEByavasQfePgwZ8Hhp8uzVSF2lypgCOaa3arzXnM5UyXWKN8nqDVvp06T5+o3hbfpm0xG+OCS1pMad6ODPrMx1E56uIcZufNfViCzinBjU5sHVKB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsPp/BGb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905190; x=1745441190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=drkyXSjGm8GFfGPcgPvR0ybUmkf8fe6rUFnbVa6tYdM=;
  b=OsPp/BGb0kpvZf33Pg4iZabnUiswJafv2fHRbhKleU+drZ8QqOqkrzYM
   MgscqZKecgD8ZfJVgt7rMzC/WAUbCGMKoSzstJEdgXUPOTtaVUgCtlw5p
   9dtL3bCyygHf7AEWDVNKNjSP7FNE3AS6vR4xut4RnTJOu5+pveFP88uoU
   aKlhZAXWPIAFAwvn0dDEHYnMJRh57XF1hKWw2b+ICX6W+zwlXf9MLBv0y
   YpjMhvn+fz3DStxYo78NBf4HW54LOaOOTwFnHu1gYQbYXFsOFX7n9rPSm
   JiRpVct8Xg/uUfd2J9ofwTnn/nKt1b4hRsgqpXiAzG7IAlek7ad+XL+5E
   A==;
X-CSE-ConnectionGUID: oGPEAOM0SjeY/XNP/B0dNA==
X-CSE-MsgGUID: kG11clBIRvuYUYnSxc1vag==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912336"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912336"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:25 -0700
X-CSE-ConnectionGUID: DMiWd+JzT0GUHjXNF5l+8A==
X-CSE-MsgGUID: /rR1nF5SQnKIvt7tmkpHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533093"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 10/10] platform/x86: ISST: Add missing MODULE_DESCRIPTION
Date: Tue, 23 Apr 2024 13:46:19 -0700
Message-Id: <20240423204619.3946901-11-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing MODULE_DESCRIPTION() to ISST modules.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c..88a17be7cb7e 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -837,4 +837,5 @@ void isst_if_cdev_unregister(int device_type)
 }
 EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
 
+MODULE_DESCRIPTION("ISST common interface module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 039333eac71a..6bcbb97b0101 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1705,4 +1705,5 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_exit, INTEL_TPMI_SST);
 MODULE_IMPORT_NS(INTEL_TPMI);
 MODULE_IMPORT_NS(INTEL_TPMI_POWER_DOMAIN);
 
+MODULE_DESCRIPTION("ISST TPMI interface module");
 MODULE_LICENSE("GPL");
-- 
2.40.1


