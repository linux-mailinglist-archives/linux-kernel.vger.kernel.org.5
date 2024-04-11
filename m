Return-Path: <linux-kernel+bounces-139678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110428A0663
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7FE1F2505E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945613C3ED;
	Thu, 11 Apr 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glQ2q8SP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A813BAD9;
	Thu, 11 Apr 2024 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804350; cv=none; b=tT/w2pccb95IcTh0uO6rTwtDQqWYBIhL213llr/y14GdnhjFoE24nw/UsY/hSrCEVmoJ0JkkTjwx33Yipu+t619bJghoYfG6SDHUfAnpTKpGVM/Czs4Xz5G27Zfp7cFcyP61lndlxpmLvYlf6aoX7rJTqXHWFgY1HJMJWVAxnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804350; c=relaxed/simple;
	bh=O4XNoax5yGBMi63llRvcorZdxNz6JIEktGe62dOVXIs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8ohQ3dcufJ69H8rdX5rt9hG9IRR13hW2ArFp3xtXJ/AxmcbtE+4+/2et/SEpfy9L5iLPo8TkWa6KjMei2Ydgd4EcPA1304U5/drtxTo1S+tGD/aoDFV5mgo3bjOo98RhV19dyAN3tlQOQTbO4SlWz1Y7RuWpVGfAU4wKnz2KKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glQ2q8SP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804349; x=1744340349;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=O4XNoax5yGBMi63llRvcorZdxNz6JIEktGe62dOVXIs=;
  b=glQ2q8SP52CrNax5ck7wOhWMUIj5+q3LJCxXOq6lxBhPRkPOcn5uz7+W
   axChXb6o4GPqTEmcfqO00T7elAZl0if5/4Awhq4OdYSsLoFf4tMZdsEjS
   IxE5k9i3qN52ovYmWTlrVeyGhem8UEcj4Bt2FKMJfDK2Le0QAuIPSz9e0
   jLikenLemDO4bR2g9QGaGexqd+bN7k5APcuro+7sBdY4wCNwTWyJ09hAZ
   rsPY8TjNLFv4mWlHCHiCqWpTNsFbrwT7XVRQWrAOWA0Rpq/rEveEhFM+E
   mlR6b+JzwEa61WN9oeEh/Ur5u0OadrvoXJHxwfgRsyLJeqzJ06iNT4OK6
   g==;
X-CSE-ConnectionGUID: tsMgawe0TqSxFVS4j7lK4g==
X-CSE-MsgGUID: acR5lcApQhOdBdCyzFB8gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054674"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054674"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
X-CSE-ConnectionGUID: lx39kQUASTakcBY6nfuv2g==
X-CSE-MsgGUID: Ip0NM+y8RumzZZ3UjHymRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730484"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 6/9] tools/arch/x86/intel_sdsi: Fix meter_show display
Date: Wed, 10 Apr 2024 19:58:53 -0700
Message-Id: <20240411025856.2782476-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411025856.2782476-1-david.e.box@linux.intel.com>
References: <20240411025856.2782476-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes sdsi_meter_cert_show() to correctly decode and display the meter
certificate output. Adds and displays a missing version field, displays the
ASCII name of the signature, and fixes the print alignment.

Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V4 - no changes

V3 - Change patch subject and changelog to clarify changes.
   - Use new BUNDLE_COUNT #def

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 29 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 7eaffcbff788..ae29214da102 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -153,11 +153,12 @@ struct bundle_encoding {
 };
 
 struct meter_certificate {
-	uint32_t block_signature;
+	uint32_t signature;
+	uint32_t version;
+	uint64_t ppin;
 	uint32_t counter_unit;
-	uint64_t ppin;
 	uint32_t bundle_length;
-	uint32_t reserved;
+	uint64_t reserved;
 	uint32_t mmrc_encoding;
 	uint32_t mmrc_counter;
 };
@@ -338,6 +339,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	uint32_t count = 0;
 	FILE *cert_ptr;
 	int ret, size;
+	char name[4];
 
 	ret = sdsi_update_registers(s);
 	if (ret)
@@ -379,12 +381,19 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	printf("\n");
 	printf("Meter certificate for device %s\n", s->dev_name);
 	printf("\n");
-	printf("Block Signature:       0x%x\n", mc->block_signature);
-	printf("Count Unit:            %dms\n", mc->counter_unit);
-	printf("PPIN:                  0x%lx\n", mc->ppin);
-	printf("Feature Bundle Length: %d\n", mc->bundle_length);
-	printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
-	printf("MMRC counter:          %d\n", mc->mmrc_counter);
+
+	get_feature(mc->signature, name);
+	printf("Signature:                    %.4s\n", name);
+
+	printf("Version:                      %d\n", mc->version);
+	printf("Count Unit:                   %dms\n", mc->counter_unit);
+	printf("PPIN:                         0x%lx\n", mc->ppin);
+	printf("Feature Bundle Length:        %d\n", mc->bundle_length);
+
+	get_feature(mc->mmrc_encoding, name);
+	printf("MMRC encoding:                %.4s\n", name);
+
+	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
 	if (mc->bundle_length % 8) {
 		fprintf(stderr, "Invalid bundle length\n");
 		return -1;
@@ -398,7 +407,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	bec = (void *)(mc) + sizeof(mc);
 
-	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
+	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
 	while (count++ < mc->bundle_length / 8) {
 		char feature[5];
 
-- 
2.34.1


