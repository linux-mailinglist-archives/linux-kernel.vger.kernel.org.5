Return-Path: <linux-kernel+bounces-139679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC328A0666
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4F61C22BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA813C814;
	Thu, 11 Apr 2024 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1siPBkK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02713BAFE;
	Thu, 11 Apr 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804351; cv=none; b=heUJNPW0CWemCvmMrn7Cy8xVQCMoqgEDh4vEQ26LEoojLIwslmpclGLwuT8R0smMsZUZ8+9+QyTVK2jhHjWmm3OjCeuU4X4F55sLYmscuQoa9959sNZ2mGpD1jzYgLtPAc+kfguyOzj7rsQdGtqi1TrHvKPUr0GOIcmwIdDOUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804351; c=relaxed/simple;
	bh=eM4WasRih/4X/yvMkpDWf9CwRC6cUMzwOjwfJBps6bE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8l9NpoCObnnJxZVMfjD2G076eTKVuPv2p740jAwZIcCz9biHWIDhHdHcqQGuW72ARrWEG2YNKhTH2irYGIwJsptK8FDjgNtixM6c4ASQ8+x7Y8+LaJSEl3vi7vjF3cyf3SyfXLJMDNrCT/+nIwUC9BHr+iP2oeHMEAY7EUmJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1siPBkK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804350; x=1744340350;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eM4WasRih/4X/yvMkpDWf9CwRC6cUMzwOjwfJBps6bE=;
  b=c1siPBkKQAvjIwIbNvWQ06m415OJjFD3BWSvZyzylBRRDBkWVXWsaW+F
   iNYE8dUa4LcWpPn53lJO86tEfIwQBkVqUZIK593IqlXr//QkfNwUsyz8R
   YGpBirEfYrqioPyOPvinoX/5yUOWd5hQJ8bM2EGfUn1FjmBKtJXE+8rBo
   36gUeOL6lyeJbBWIGmRCriNsvc9OXfRxGz9WCSNoLrkTFQJRhrwxZlhLj
   L+So/6fuCgO9f8vJ69u/1yDuwyPGnzdzbySUve6GLJczuoUWMKVPKdzeC
   9DIrvGmfQ5jjsngr03nVxIlgIgt7yo50YDWMtcvIFiNZeJSXOiLDxqH6c
   g==;
X-CSE-ConnectionGUID: GVjimXfrQveqO8xlASAqdg==
X-CSE-MsgGUID: ymVeCykJRFyezCxjp5qzzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054676"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054676"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
X-CSE-ConnectionGUID: N53n9HacTmGdeqK+lJGpUg==
X-CSE-MsgGUID: d5rzbgEJR1WpBb6UUOptzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730486"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
Date: Wed, 10 Apr 2024 19:58:54 -0700
Message-Id: <20240411025856.2782476-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411025856.2782476-1-david.e.box@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com>
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
V4 - Use suggested struct bundle_encoding_counter cast

V3 - Use macros for bundle size and count

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index ae29214da102..ba2a6b6645ae 100644
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
+	bec = (struct bundle_encoding_counter *)(mc + 1);
 
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


