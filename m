Return-Path: <linux-kernel+bounces-139676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136008A0660
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40EB28853E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1E13BC28;
	Thu, 11 Apr 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e11saj+e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746113B7AA;
	Thu, 11 Apr 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804349; cv=none; b=uszAZt+tFg66CKCFiIUjCRnN0DfRFtBbBUf2SUKbizb2StQj/Eb4BuJUnEPdqX/E7Q4fSbAoGoW8TMlVL21w4wK3zCVT32JZUOruKVHCrtq1wm5MQtNx9v3mYmthznJI/WeP8WuNmSmoIl5P05rnJpDRsCNjogXlHjNXl3MXOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804349; c=relaxed/simple;
	bh=N5YyQr+SpoyAGMoUDepvfy4mN+zQVnEZhQ7GiJS8+lE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHjQRqm0wDMBEATBE+kAZAe4vFXgcq1shwI8L0j8PP1frcKWKzYqmDUaEtALTjxEaNNuS4MPAVKtmltT14EDhUOrpHIUP4U9hzfyP8I4iOBNRr4Ih76J3Qqn8vJtH6Eau8Pi6ssqr7MRbL0wEuqgLFYNHWceX5GpTKfoMPwxrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e11saj+e; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804348; x=1744340348;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=N5YyQr+SpoyAGMoUDepvfy4mN+zQVnEZhQ7GiJS8+lE=;
  b=e11saj+ef3+VXawYS1IvY4b8IsE498xNN5zTUZ9E4qLBFYhnaR08AQJs
   Z4CRN5/1P76fYfAh+e3c9xdZpyRKNfQvLppzJDL0nDDjayjnq57bkLXUf
   OV732G5O997FXkF9vjjL2ytZUGKua93eV0c+dC4FtlXgJv19rRHAhfut+
   cV+oh5X7ksr/66Ca0nXsAU+QRKFq62IKJoccwW2i9wjExd5MqhHO8fV0v
   YDnK2H79YCyp6fribp6Cgt0RXvcVbMGSvUmj3IMS4sV6L8nzYa61bLva1
   bwgbdTnpv+AI9uWcPhv5M7UUH0tCc8RgJUbGoCumZLAqpguxGz6ayv3O9
   g==;
X-CSE-ConnectionGUID: XierezlJQsiB5yswm+woCQ==
X-CSE-MsgGUID: zu8ftlmDR9uF2q0fCfb2RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054672"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054672"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
X-CSE-ConnectionGUID: TDKCqAfqSaabgWXR7fUPDg==
X-CSE-MsgGUID: NnlyAoVCR7+kc+n+LV5KTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730481"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:04 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 5/9] tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
Date: Wed, 10 Apr 2024 19:58:52 -0700
Message-Id: <20240411025856.2782476-6-david.e.box@linux.intel.com>
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

The maximum number of bundles in the meter certificate was set to 8 which
is much less than the maximum. Instead, since the bundles appear at the end
of the file, set it based on the remaining file size from the bundle start
position.

Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V4 - no changes

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


