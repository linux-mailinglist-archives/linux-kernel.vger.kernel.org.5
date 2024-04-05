Return-Path: <linux-kernel+bounces-132384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C78993D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AE11C23E78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1152E646;
	Fri,  5 Apr 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdtNvVfU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293522EEF;
	Fri,  5 Apr 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287521; cv=none; b=B00w1mEuWMxeW29Z0lPOhWrdfWyKWb0oPguxbIk5BjegeATIT6cK+o0faaghNt7Wx1Ek0B/kdJfKhL7JLvTLQRXNmLytOy9ovsZHSaI56yhx2SC+oaUsvjOlxyHka5vs4SDLk4xhQoxiR/1lKJNRatzfSiHRH8YF1k9Vck7U47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287521; c=relaxed/simple;
	bh=4+zOGgONv/PHR45HxcG9SdDuhPsuOA8XY6mYEd8/s4w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh7Fr8ncFc1Pnm2GTIpWPBDMQ0GWrjPjdaLA+yoskKYw0MTAnRmULuijjskOk9bWBfoloVNpPCGUO1HqIJH5PoLKYuQ1M/ay68IojwEhplFP/QKebHajoz1uujwQvi+otomf/30lnFedUHDQLvPFim2rh17ETkCQzbsHhzwDlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdtNvVfU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287519; x=1743823519;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4+zOGgONv/PHR45HxcG9SdDuhPsuOA8XY6mYEd8/s4w=;
  b=QdtNvVfUlEgwtCxCqJ7i7fyKYN6ek9NRKaUHt6h3QH7I9tQr0IdJ9Nuy
   Spcy75beiPHGB6iqCphaW9SU1bvrqMLxPvatdBwYHxWPc9KawrHrGmiBZ
   gK8UZ6QOTYuEBs0S84UMS10yyJa4VHi8rLecDCYpzmm9ZU2rYZSqJ/WVR
   PAA+MnB8Rq0dYMvdkFkeUfI+GLSQyudujZhMzW5rny9sUZwh5wz6w69b9
   rw1Z9fTtk23Oxc01Tio7Z6D45ECmhCXSlBFD0JBYNUKUKbWfGQyHk29ri
   2sIG2XK6IvDhr0jrxcnGYwlJUoC0kqyyil8X0mBhIvb8m1cjp5+mrMUkK
   Q==;
X-CSE-ConnectionGUID: pwDRpvLMRSOWubLV1bu5iA==
X-CSE-MsgGUID: LhMTFxxfTS2I5zRXA6IrKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112474"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112474"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:15 -0700
X-CSE-ConnectionGUID: h1XgiHBwSYu9p702Q7pxDw==
X-CSE-MsgGUID: /keb5FYYQFyCuJsICgBbHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955991"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:15 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 8/9] platform/x86/intel/sdsi: Simplify ascii printing
Date: Thu,  4 Apr 2024 20:25:06 -0700
Message-Id: <20240405032507.2637311-9-david.e.box@linux.intel.com>
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

Use printf width specifier to set the display length of encoded feature
names.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

V3 - Add FEAT_LEN #def

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 45bc69e6718e..0c9670ba1f15 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -43,6 +43,7 @@
 #define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
+#define FEAT_LEN		4
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -409,11 +410,10 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
 	while (count < BUNDLE_COUNT(mc->bundle_length)) {
-		char feature[5];
+		char feature[FEAT_LEN];
 
-		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
-		printf("    %s:          %d\n", feature, bec[count].counter);
+		printf("    %.4s:          %d\n", feature, bec[count].counter);
 		++count;
 	}
 
@@ -494,7 +494,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 			sizeof(*lki) +			// size of the license key info
 			offset;				// offset to this blob content
 		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
-		char feature[5];
+		char feature[FEAT_LEN];
 		uint32_t i;
 
 		printf("     Blob %d:\n", count - 1);
@@ -507,11 +507,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 		printf("        Blob revision ID:           %u\n", lbc->rev_id);
 		printf("        Number of Features:         %u\n", lbc->num_bundles);
 
-		feature[4] = '\0';
-
 		for (i = 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); i++) {
 			get_feature(bundle[i].encoding, feature);
-			printf("                 Feature %d:         %s\n", i, feature);
+			printf("                 Feature %d:         %.4s\n", i, feature);
 		}
 
 		if (lbc->num_bundles > STATE_MAX_NUM_IN_BUNDLE)
-- 
2.34.1


