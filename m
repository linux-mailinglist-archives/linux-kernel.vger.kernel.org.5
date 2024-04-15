Return-Path: <linux-kernel+bounces-145963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA58A5D99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813331C22277
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63F157A61;
	Mon, 15 Apr 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jocyVbEi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3325601;
	Mon, 15 Apr 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218799; cv=none; b=HFvvSI77XyLs6o0jaowG5KN7HWvP6wq2KhDh9K/SEUP0FOnk5LWWiSKaqFv2BkwXpYEmtZfpXIc3aSUM8tY4fMrNZOCvzi0YTswSVToDx5w2rkPIUmCeFJfRnCMZ8TxuANvEYUKPDR9jSJnBElkViPOeNsUjubfoRoD6+S3NDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218799; c=relaxed/simple;
	bh=cfgrhk9pYDpOtV2H39ercNHeZSILx4+hGmgX0aJINjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C44XzKCXJTb3u707sOvsrTNnVLRUYu2e5lg5LZCKaWkjAVPYoq32MrwS1+SmjQyKMTb9BYpRoHh/g9duCMqpm/inaXXnWcuwtQYSJJDXz2/y/BMlh0Yu+8f7/3fLUWd1qg+UBsaQlz6IOeC1SsL8LTavTvNVdKCmquIOsm3HIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jocyVbEi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713218798; x=1744754798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cfgrhk9pYDpOtV2H39ercNHeZSILx4+hGmgX0aJINjw=;
  b=jocyVbEiuEv4+FfgN8a9ByetnnTI1rzkApUxCEvW8/ANdlsCw364Kv65
   Ounmjpwo9QsrFZcnpk5vwStNuymplqQkH+zqfpCEDJRb3bPppCwtLpdE/
   7u2mjhj7vInyO8ps9ArOkg1sJQEcWnDzu1AW9ph6Zs4/48SRUFpEWkV7M
   yXoX8DQvinZT9XbnDLiLJpMEE3fCELxAjSIcBjr2jJBAduLsXjNqasB5X
   /wZTrJo9dbBUAXbgR77xKDC358Pk2cYpfJ6RzmWIKGVh1byYu0wr7+oed
   fHcmCz2za5vZ24U7JBX6sfjrBd0lO24Uh80z+57sY//fblHXDEWcMgqd4
   Q==;
X-CSE-ConnectionGUID: kscx6EoSTgOeijg5ke+IJw==
X-CSE-MsgGUID: MtxVCn9TQReXDIT4Dl2cbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="20021977"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="20021977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 15:06:37 -0700
X-CSE-ConnectionGUID: ZdO8/rfUTyyrWSXRPlALMw==
X-CSE-MsgGUID: JflKa/FqRW+xvBIwNzsRUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26847205"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa005.jf.intel.com with ESMTP; 15 Apr 2024 15:06:36 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Increase minor number support
Date: Mon, 15 Apr 2024 15:06:25 -0700
Message-Id: <20240415220625.2828339-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No new changes will be added for minor version 2. Change the minor
version number to 2 and stop displaying log message for unsupported
minor version 2.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 587437211d72..bb8e72deb354 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -29,7 +29,7 @@
 #include "uncore-frequency-common.h"
 
 #define	UNCORE_MAJOR_VERSION		0
-#define	UNCORE_MINOR_VERSION		1
+#define	UNCORE_MINOR_VERSION		2
 #define UNCORE_HEADER_INDEX		0
 #define UNCORE_FABRIC_CLUSTER_OFFSET	8
 
@@ -330,7 +330,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			goto remove_clusters;
 		}
 
-		if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) != UNCORE_MINOR_VERSION)
+		if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) > UNCORE_MINOR_VERSION)
 			dev_info(&auxdev->dev, "Uncore: Ignore: Unsupported minor version:%lx\n",
 				 TPMI_MINOR_VERSION(pd_info->ufs_header_ver));
 
-- 
2.40.1


