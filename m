Return-Path: <linux-kernel+bounces-164769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B18B829F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC202848D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6091BF6CF;
	Tue, 30 Apr 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFFlQNpw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B31802D8;
	Tue, 30 Apr 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515064; cv=none; b=C0FGs5VwCKygba4ojJdDJYhhr2KpGptdhFQmDa9hrWFPjE3kYg3drinhnHm+0wRmNMpBgFjJ40Aa7gW/8vzOENJzou/EU2Vm0Lokhc0hKqlbgaWkLhLIxDmg0rkDY2nazYVy50wC18xH9AagDs0ud2Q6cYjKDWixuzSnDl5ncXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515064; c=relaxed/simple;
	bh=q/H6nqXJsWNoKU9TwbxDMKCb3eBjRvO7RNFWS3ZQZho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqUdcxDpjqboNeOa46+DaAiUToeW6rXWciFp7b+SHMzjcNsYLr33R/ysyraYrJZ0hRMCUQP6jKc3jc+z5/lmenhEZTo0QIncHvM6ci67cy7VtKS4DWBuht/oNnaER1wlsZMy8locMjYZunccqtOxDiiBGv8/mCoeGE2B5/b9ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFFlQNpw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714515063; x=1746051063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q/H6nqXJsWNoKU9TwbxDMKCb3eBjRvO7RNFWS3ZQZho=;
  b=cFFlQNpwDPbrvRKMu1i00ESZVVOaJTZhuuL7QxiPjc8x3ZrR/9aUl30D
   fiXXBHUaFTWDGRTD+A0cqJPYarBHGWaj66x3DrNRQZRRT1TYdouAHXtpr
   9sRCuZXfHW+yduBMwAYmoN2iprTSZ8gKDyFdXHq2cFTeSw4X5SqfZ+3Se
   HjLBdrLLv6UCZb0KjyNbkvgsl3s+rzN0JEOWSLGWDWMo1U/vIW3Aj2xj6
   e7RqzO2CosmN7D3h+M/4QwqSusN+YvKypSNLKzmgb+3iivLyKsWWoR2I1
   YQpnGG7VXtsDadbUJdpCBYNBAeUhx5Z2IEieI7DSobdzeDCSWjZpk0heU
   g==;
X-CSE-ConnectionGUID: Yotv3XfZRtyOIPKCcbt4LQ==
X-CSE-MsgGUID: 4IG1l+zpR/isXSzCGSJ2+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10077471"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10077471"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 15:11:03 -0700
X-CSE-ConnectionGUID: 7NIs8La3SrWCF1+5d08o/g==
X-CSE-MsgGUID: 2QK4/CVVS8qD+l43BSNN3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26631480"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa009.jf.intel.com with ESMTP; 30 Apr 2024 15:11:02 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] platform/x86: ISST: Support SST-BF and SST-TF per level
Date: Tue, 30 Apr 2024 15:10:52 -0700
Message-ID: <20240430221052.15825-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SST SST-BF and SST-TF can be enabled/disabled per SST-PP level. So return
a mask of all levels, where the feature is supported, instead of just for
level 0.

Since the return value returns all levels mask, not just level 0, update
API version.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 38 +++++++++++++++----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 6bcbb97b0101..7bac7841ff0a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -847,6 +847,8 @@ static int isst_if_get_perf_level(void __user *argp)
 {
 	struct isst_perf_level_info perf_level;
 	struct tpmi_per_power_domain_info *power_domain_info;
+	unsigned long level_mask;
+	u8 level, support;
 
 	if (copy_from_user(&perf_level, argp, sizeof(perf_level)))
 		return -EFAULT;
@@ -866,12 +868,34 @@ static int isst_if_get_perf_level(void __user *argp)
 		      SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH, SST_MUL_FACTOR_NONE)
 	perf_level.enabled = !!(power_domain_info->sst_header.cap_mask & BIT(1));
 
-	_read_bf_level_info("bf_support", perf_level.sst_bf_support, 0, 0,
-			    SST_BF_FEATURE_SUPPORTED_START, SST_BF_FEATURE_SUPPORTED_WIDTH,
-			    SST_MUL_FACTOR_NONE);
-	_read_tf_level_info("tf_support", perf_level.sst_tf_support, 0, 0,
-			    SST_TF_FEATURE_SUPPORTED_START, SST_TF_FEATURE_SUPPORTED_WIDTH,
-			    SST_MUL_FACTOR_NONE);
+	level_mask = perf_level.level_mask;
+	perf_level.sst_bf_support = 0;
+	for_each_set_bit(level, &level_mask, BITS_PER_BYTE) {
+		/*
+		 * Read BF support for a level. Read output is updated
+		 * to "support" variable by the below macro.
+		 */
+		_read_bf_level_info("bf_support", support, level, 0, SST_BF_FEATURE_SUPPORTED_START,
+				    SST_BF_FEATURE_SUPPORTED_WIDTH, SST_MUL_FACTOR_NONE);
+
+		/* If supported set the bit for the level */
+		if (support)
+			perf_level.sst_bf_support |= BIT(level);
+	}
+
+	perf_level.sst_tf_support = 0;
+	for_each_set_bit(level, &level_mask, BITS_PER_BYTE) {
+		/*
+		 * Read TF support for a level. Read output is updated
+		 * to "support" variable by the below macro.
+		 */
+		_read_tf_level_info("tf_support", support, level, 0, SST_TF_FEATURE_SUPPORTED_START,
+				    SST_TF_FEATURE_SUPPORTED_WIDTH, SST_MUL_FACTOR_NONE);
+
+		/* If supported set the bit for the level */
+		if (support)
+			perf_level.sst_tf_support |= BIT(level);
+	}
 
 	if (copy_to_user(argp, &perf_level, sizeof(perf_level)))
 		return -EFAULT;
@@ -1648,7 +1672,7 @@ void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, INTEL_TPMI_SST);
 
-#define ISST_TPMI_API_VERSION	0x02
+#define ISST_TPMI_API_VERSION	0x03
 
 int tpmi_sst_init(void)
 {
-- 
2.44.0


