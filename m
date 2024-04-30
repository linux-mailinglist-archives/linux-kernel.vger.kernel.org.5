Return-Path: <linux-kernel+bounces-164429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC38B7DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A435B1F256A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10717B4EB;
	Tue, 30 Apr 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUiyby7j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790763E478
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495892; cv=none; b=kwJCN344Kd6/9syYlErOa4n1E4OcPizQwp5+A5xVn+mjhtWap2R1T1AxoiwuWy0UALIALtVd3P2gvcCusxYYodXLDeR4DjNNkmU7ZUEOGzPnj/lRHFsfLGpebWeNiZmv4zRyRP6W0mXT6MFqp6HLGqKReAzfEhu7BGJMFrjoNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495892; c=relaxed/simple;
	bh=87KOavhDhX411TrRX1K9/1DFXE3gMTK1YvOMoRFJCZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcEz+FbpgibfIVKrLgxHsRbF5oqNujo3GYdszr2MSzOZJrx14XmFRZUAIpiWfI8bNB8DzqVSwRuTpvIV1m8FWiEt/VO76p6Mme3m37Za6ehMs0SgoDd3nIVeuZ2GbMgJrYQawzE99CL0Ukk3cmGAt9mRhaCtgaqTrh4LJoDs/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUiyby7j; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495892; x=1746031892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87KOavhDhX411TrRX1K9/1DFXE3gMTK1YvOMoRFJCZ4=;
  b=NUiyby7j/xl7tN419P9vv8D8q+m7CzJRQuojPMzaUxv1g3lSgHc5xEod
   /RGGDsrp7tX617QlxMkShhFkHnUYstrwUwrLbiFqoolS6S2hIG4BD7D+X
   ULktBoAvrYn0J6v9O5ueRJKtieP38JSvppeol9YSwIeMCbdt6RgGMC5AG
   MRxw1QAZDdaZx+r0EaZiK6LvrAoF3/DILduTofdrWZTiFhkxK4IchoV9G
   QrOErhId5xbY50EJjnEpLWmcULzveeQxQ4oFhqvmhH3MDtRLDPzObgAnZ
   X2gvQEjAn0bWRH8x95EYNfVVcaidKIyKvvxXqdMZx2WKuYKT7+I5zErC1
   w==;
X-CSE-ConnectionGUID: o32xdttyQl6e6zt7G+3YMQ==
X-CSE-MsgGUID: 9FHXravxT7WPxXTVYVqcPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075590"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075590"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
X-CSE-ConnectionGUID: 8zRbP+gSQNa1oAhpk7SJSw==
X-CSE-MsgGUID: OToypoliSbeVGWSk7C+7NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515411"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 03/47] media: atomisp: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:16 -0700
Message-ID: <20240430165100.73491-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../atomisp/include/linux/atomisp_platform.h  | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
index 487ef5846c24..70bab3d1bc2f 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -18,7 +18,7 @@
 #ifndef ATOMISP_PLATFORM_H_
 #define ATOMISP_PLATFORM_H_
 
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 
 #include <linux/i2c.h>
@@ -217,22 +217,17 @@ void atomisp_unregister_subdev(struct v4l2_subdev *subdev);
 int v4l2_get_acpi_sensor_info(struct device *dev, char **module_id_str);
 
 /* API from old platform_camera.h, new CPUID implementation */
-#define __IS_SOC(x) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
-		     boot_cpu_data.x86 == 6 &&                       \
-		     boot_cpu_data.x86_model == (x))
-#define __IS_SOCS(x,y) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
-		        boot_cpu_data.x86 == 6 &&                       \
-		        (boot_cpu_data.x86_model == (x) || \
-		         boot_cpu_data.x86_model == (y)))
-
-#define IS_MFLD	__IS_SOC(INTEL_FAM6_ATOM_SALTWELL_MID)
-#define IS_BYT	__IS_SOC(INTEL_FAM6_ATOM_SILVERMONT)
-#define IS_CHT	__IS_SOC(INTEL_FAM6_ATOM_AIRMONT)
-#define IS_MRFD	__IS_SOC(INTEL_FAM6_ATOM_SILVERMONT_MID)
-#define IS_MOFD	__IS_SOC(INTEL_FAM6_ATOM_AIRMONT_MID)
+#define __IS_SOC(x) (boot_cpu_data.x86_vfm == x)
+#define __IS_SOCS(x, y) (boot_cpu_data.x86_vfm == x || boot_cpu_data.x86_vfm == y)
+
+#define IS_MFLD	__IS_SOC(INTEL_ATOM_SALTWELL_MID)
+#define IS_BYT	__IS_SOC(INTEL_ATOM_SILVERMONT)
+#define IS_CHT	__IS_SOC(INTEL_ATOM_AIRMONT)
+#define IS_MRFD	__IS_SOC(INTEL_ATOM_SILVERMONT_MID)
+#define IS_MOFD	__IS_SOC(INTEL_ATOM_AIRMONT_MID)
 
 /* Both CHT and MOFD come with ISP2401 */
-#define IS_ISP2401 __IS_SOCS(INTEL_FAM6_ATOM_AIRMONT, \
-			     INTEL_FAM6_ATOM_AIRMONT_MID)
+#define IS_ISP2401 __IS_SOCS(INTEL_ATOM_AIRMONT, \
+			     INTEL_ATOM_AIRMONT_MID)
 
 #endif /* ATOMISP_PLATFORM_H_ */
-- 
2.44.0


