Return-Path: <linux-kernel+bounces-139680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5178A0668
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E100CB260FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B013C839;
	Thu, 11 Apr 2024 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWe0mJgz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF013BC12;
	Thu, 11 Apr 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804351; cv=none; b=lLJ/RIfppr649LWR6vcEIEIajn1IgHnh6VEUALqF8i2rAkkAdAIqwL/QJv1bsZrLTd827NoTpbshitxWUUDwMnmp2uhD5roerFdjCe7x+DzPQnX0LLxXt4OuSUlX1phPE6xMdAXGOach0RJA7nCmK8P/J6kCxNP+AhszKITO6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804351; c=relaxed/simple;
	bh=jmf3IAkWLAWR637X/f4ivoH7dTW9tbL15b93YGP5Vp8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrNYfQZw1TbKN1Cle9JT+hUzDr9EQ4PdactMQDLfw5qD3xVQgFW0EsGrWnfvfpFmiqa8RKWt0X1iLQbLt+6ndXMaUlYf+ApMV6JjFnYmejLWr14SrbnHbPaGD2KL8TWJVvoLeS0b6tCxOkDahDPhe87ZmbobfvtNlVLuT3YbADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWe0mJgz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804350; x=1744340350;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jmf3IAkWLAWR637X/f4ivoH7dTW9tbL15b93YGP5Vp8=;
  b=AWe0mJgzvgQdCr0SN7+l1QvxX6VYP384mo4VfT8QRs7kDIJMrOw4L2C0
   KupLUUGi43Nn9KAaKT8f5jjMdZGdK6Rp5OiQdY7KjN30vDPGwE3BgZBEV
   M6iQqQjWujR+pT2WA2Ua+9UA/J+LGvGo+72Ww3gHEhx1jIdrapLlGUakk
   poRMvgAv7Mrjsk/NBL/2jVebY/w9jl4p1yZM44b7n0MjTX046uJcAY/Gh
   6vwKCzBQ6Ch1/+2+iYhN8xm8PjQG7EaexrWrr62+EfrbbC4++iftfc14i
   xZlpwdA0yKB1r9MeGHtwbcMSzyfeA8H2CxC7nHl6TdR6yAJ0pf/WXChtL
   g==;
X-CSE-ConnectionGUID: OzOaoBmzSNew4f/T3Z7MAw==
X-CSE-MsgGUID: P/oCicaJTe+FqW7GlgOBcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054678"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054678"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:05 -0700
X-CSE-ConnectionGUID: iUIgguF0QWqlLgsY7aunrA==
X-CSE-MsgGUID: HYxl7nxUSPevsItPI5Tu3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730489"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:05 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 8/9] platform/x86/intel/sdsi: Simplify ascii printing
Date: Wed, 10 Apr 2024 19:58:55 -0700
Message-Id: <20240411025856.2782476-9-david.e.box@linux.intel.com>
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

Add #define for feature length and move NUL assignment from callers to
get_feature().

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
V4 - Move NUL assignment to get_feature() and increment FEAT_LEN.

V3 - Add FEAT_LEN #def

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index ba2a6b6645ae..301213370740 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -43,6 +43,7 @@
 #define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
+#define FEAT_LEN		5	/* 4 plus NUL terminator */
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -321,10 +322,11 @@ static char *content_type(uint32_t type)
 	}
 }
 
-static void get_feature(uint32_t encoding, char *feature)
+static void get_feature(uint32_t encoding, char feature[5])
 {
 	char *name = (char *)&encoding;
 
+	feature[4] = '\0';
 	feature[3] = name[0];
 	feature[2] = name[1];
 	feature[1] = name[2];
@@ -339,7 +341,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	uint32_t count = 0;
 	FILE *cert_ptr;
 	int ret, size;
-	char name[4];
+	char name[FEAT_LEN];
 
 	ret = sdsi_update_registers(s);
 	if (ret)
@@ -383,7 +385,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	printf("\n");
 
 	get_feature(mc->signature, name);
-	printf("Signature:                    %.4s\n", name);
+	printf("Signature:                    %s\n", name);
 
 	printf("Version:                      %d\n", mc->version);
 	printf("Count Unit:                   %dms\n", mc->counter_unit);
@@ -391,7 +393,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	printf("Feature Bundle Length:        %d\n", mc->bundle_length);
 
 	get_feature(mc->mmrc_encoding, name);
-	printf("MMRC encoding:                %.4s\n", name);
+	printf("MMRC encoding:                %s\n", name);
 
 	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
 	if (mc->bundle_length % METER_BUNDLE_SIZE) {
@@ -409,9 +411,8 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
 	while (count < BUNDLE_COUNT(mc->bundle_length)) {
-		char feature[5];
+		char feature[FEAT_LEN];
 
-		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
 		printf("    %s:          %d\n", feature, bec[count].counter);
 		++count;
@@ -494,7 +495,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 			sizeof(*lki) +			// size of the license key info
 			offset;				// offset to this blob content
 		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
-		char feature[5];
+		char feature[FEAT_LEN];
 		uint32_t i;
 
 		printf("     Blob %d:\n", count - 1);
@@ -507,8 +508,6 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 		printf("        Blob revision ID:           %u\n", lbc->rev_id);
 		printf("        Number of Features:         %u\n", lbc->num_bundles);
 
-		feature[4] = '\0';
-
 		for (i = 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); i++) {
 			get_feature(bundle[i].encoding, feature);
 			printf("                 Feature %d:         %s\n", i, feature);
-- 
2.34.1


