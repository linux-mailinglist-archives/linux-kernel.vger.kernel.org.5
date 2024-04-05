Return-Path: <linux-kernel+bounces-132381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA28993D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CB11C23369
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DCE286BF;
	Fri,  5 Apr 2024 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3DP2uwe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD4219FC;
	Fri,  5 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287519; cv=none; b=k8IiOlIwxtmczPpBFCNUJKZ9P7Rld8zqB4/mMvHpt3LwX/V+5ZG93lJRDqlmQzbFWaA4Xjg09BBbrwMSzTEDK7Rbya02O3MTB18XvgVAPjCsltQ9YhzA9RYHmBSME6T1Zfe/et6OLERdkFZ88OWurt5yXbRVAGKa3uGh/QjpQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287519; c=relaxed/simple;
	bh=Qvg5RVrUDranDSeYRI0HQG8F+ZoiW29zPcZUdHgKobs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9Olnk7yhTaVxPQjQleOti/8OILiAx5IAHZLjGOClV4iJh6686elCwyfJPV1JT4iTEH/1W8/3Jx2UejFL6VozKkm2wd8WcbmJ5lKrrdeGYz0FDsWqpdT+EoTGaMzFVFidgqhvc9rMfX92ap1JXhObqmGoxnxBXnFaZ8OZ8GR0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3DP2uwe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287518; x=1743823518;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Qvg5RVrUDranDSeYRI0HQG8F+ZoiW29zPcZUdHgKobs=;
  b=H3DP2uweAMVACxG9uYvSMKbK3q/MFkXvNsM+LVZk+lj5nI2/rQl9eEot
   IAroGJ5j/i74c41kQ83YPbIITuOcBJsuZONU8EOCx8t2mjt9QZzydI3wc
   o6veqYsSPpHjTvQuVbYk4pxlUkA2eSNOOJ1Azh9s6Rg0XMLazYmjd8EzD
   /oz7t4f7vfZ2QoAY9H253JA6WMUeW6fclso5KX42zW3IPiI1eyxH/PjtP
   3yrZpsZFysK6Wekotk2B/UzRUOA5/4lXYxg12MUeEvbjvKWv5PunIm8Ft
   KXcCL8b4NfZZSSLeoBmnpygtXba1iUIsvt0v1B8JO3uvI8VXghAafBYiv
   A==;
X-CSE-ConnectionGUID: klSBbrTaQUa8f2FWakea8w==
X-CSE-MsgGUID: /keANGOqS8qOqSLtsr8YBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112472"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:15 -0700
X-CSE-ConnectionGUID: ejWy7LVIT8i8ykIsqrKsDQ==
X-CSE-MsgGUID: LRBbbz2XQQCOI5hE46/+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955989"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:14 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
Date: Thu,  4 Apr 2024 20:25:05 -0700
Message-Id: <20240405032507.2637311-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405032507.2637311-1-david.e.box@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix errors in the calculation of the start position of the counters and in
the display loop. While here, use a #define for the bundle count and size.

Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

V3 - Use macros for bundle size and count

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index a0711177e1bb..45bc69e6718e 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -394,7 +394,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	printf("MMRC encoding:                %.4s\n", name);
 
 	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
-	if (mc->bundle_length % 8) {
+	if (mc->bundle_length % METER_BUNDLE_SIZE) {
 		fprintf(stderr, "Invalid bundle length\n");
 		return -1;
 	}
@@ -405,15 +405,16 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 		return -1;
 	}
 
-	bec = (void *)(mc) + sizeof(mc);
+	bec = (void *)(mc) + sizeof(*mc);
 
 	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
-	while (count++ < mc->bundle_length / 8) {
+	while (count < BUNDLE_COUNT(mc->bundle_length)) {
 		char feature[5];
 
 		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
 		printf("    %s:          %d\n", feature, bec[count].counter);
+		++count;
 	}
 
 	return 0;
-- 
2.34.1


