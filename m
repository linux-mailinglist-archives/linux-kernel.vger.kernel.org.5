Return-Path: <linux-kernel+bounces-132379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A38993CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E1289BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19018C3D;
	Fri,  5 Apr 2024 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8f+v4H9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A820315;
	Fri,  5 Apr 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287518; cv=none; b=YtuY5j2Edm9Y1N8OaKGrT5mrCLvZhe2XdZWUms4v9uWHHAZkI8lvyDwsYzAfO6TJ5kCE9ymSnORhYzlj5lde8P2CNpdFh7p+ZnkoESnrJp/OKzHz2mFQsoy7DbIl1FGz/+boElBUQ/fYzO8ktrwlIJKlNOCeYTsvB/7wR9rKSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287518; c=relaxed/simple;
	bh=+tUDCWL1q5is4QDbUXhISRqIdD1VBiU4F1CnNHxWxOU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fa2L24YlxZ97Y9qO0C5oX0zNj4InKFU9EvEnB0RAB2bKcY2gXx7vqFLT7ptdirXNv8LRnr0DcLOLAdlC8MG5a9WKYt4s1WmQLtUrfvkCJdgGWdd4PPXUCq/6uTR484orw1PKtjvL0Ept2zQ1UDfr916hIzUfwgdn/Ave+4mLTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8f+v4H9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287517; x=1743823517;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+tUDCWL1q5is4QDbUXhISRqIdD1VBiU4F1CnNHxWxOU=;
  b=Z8f+v4H9zZx06ktpq6teDZFo9aUD2lJ4/jRl5/z1kX+BMlJjySEQNBjb
   srssLtg9hrxzfapGNvFP/mwSOxcyEIoGNpaido4VbmD6XRzzC5JKzK7uX
   PEm4XoFk/EnA1NiRp59eCs5QP9v7r/KhPwhgcFMJ/yGLtmmd9KXdLDUp6
   DwWsjoZJiDlBAUQrJSmGUmdJvjJwdzN4lEDK9CHLAg0Ox1PAIEaDo7wB9
   baSxw7cSwT3sHO8o7j8l/nFJP8nhczBhQDEMIWi11uBkcpiSE2aOySU+U
   x2ELsMPydiHXQggzZS6odzym4IR9eguSulN94fL02dmrrQuZF6U0hbBIT
   A==;
X-CSE-ConnectionGUID: r4dxoA1mR+q81Bp06ZKc7A==
X-CSE-MsgGUID: kj/QVVWDSEenOREZtP2aAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112466"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:14 -0700
X-CSE-ConnectionGUID: Fmp0Hy+DTwGHODdivii5eQ==
X-CSE-MsgGUID: RNqwb6DIT1uRBtpXMuY6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955985"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:13 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 5/9] tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
Date: Thu,  4 Apr 2024 20:25:03 -0700
Message-Id: <20240405032507.2637311-6-david.e.box@linux.intel.com>
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

The maximum number of bundles in the meter certificate was set to 8 which
is much less than the maximum. Instead, since the bundles appear at the end
of the file, set it based on the remaining file size from the bundle start
position.

Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V3 - Add suggested macros for the number of bundles and bundle size.

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..7eaffcbff788 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -43,7 +43,6 @@
 #define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
-#define METER_MAX_NUM_BUNDLES	8
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -167,6 +166,11 @@ struct bundle_encoding_counter {
 	uint32_t encoding;
 	uint32_t counter;
 };
+#define METER_BUNDLE_SIZE sizeof(struct bundle_encoding_counter)
+#define BUNDLE_COUNT(length) ((length) / METER_BUNDLE_SIZE)
+#define METER_MAX_NUM_BUNDLES							\
+		((METER_CERT_MAX_SIZE - sizeof(struct meter_certificate)) /	\
+		 sizeof(struct bundle_encoding_counter))
 
 struct sdsi_dev {
 	struct sdsi_regs regs;
@@ -386,9 +390,9 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 		return -1;
 	}
 
-	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
-		fprintf(stderr, "More than %d bundles: %d\n",
-			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
+	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * METER_BUNDLE_SIZE)  {
+		fprintf(stderr, "More than %ld bundles: actual %ld\n",
+			METER_MAX_NUM_BUNDLES, BUNDLE_COUNT(mc->bundle_length));
 		return -1;
 	}
 
-- 
2.34.1


