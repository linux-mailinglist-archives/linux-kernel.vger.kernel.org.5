Return-Path: <linux-kernel+bounces-159094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2F8B2944
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B91C21925
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328F152E1C;
	Thu, 25 Apr 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4dmDCFw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943D15252D;
	Thu, 25 Apr 2024 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075140; cv=none; b=XL483hmwo2ewsO6732aasheWCLs/VL5dGIT/qHVIW7+jP7U4kj+TnYS3BkMrYNfDwDZPNxx58L3X8WUiede3HBXsNANputV0KGXuTFP/0rGS/CFGTNhRV2N2Z51xKEAQv6YBdD7fU6PYlZGoiZbZZ+PyjPGcQW8onVNhFu7lss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075140; c=relaxed/simple;
	bh=K+LnRA9rA0OZfzN254cwx2NMgEMzqaxNC8jXXCB/Mjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUKGJe/ocJJXfeTavz4dbwzno98tGhrw0W+XvYAJ6VLI984l/UpshcrA3Z80Nx2cyqwjLSJH6jMIQ51Okh5Xjo4A+WWmEZCJZZ6N6ECMHvEbF567lT5B0PbNiISth1lTTFDkfa+9ACIMaaLjrKE8bUzsYFetcNUYMET81Sx6Rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4dmDCFw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714075138; x=1745611138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K+LnRA9rA0OZfzN254cwx2NMgEMzqaxNC8jXXCB/Mjo=;
  b=Q4dmDCFwPZOhq6bX1P9VhMXz+xmvNA0/pjSROkjwhCJ1/Cic/C0Vvwy2
   exUmMwuKhvMGj5AFhZJXUXRaAnJ5i7q5ZhJ1sTuUgP72ksZXFcXuDJOgP
   O0kBnFAAOsujk+aEQAgAOfzTfQ+u7Rlly5NCP62TfXJKGgt+gh6Qtz/9t
   VJhhLjN+68Iejvi2MMpDI/pyf5We5FS+giTblLh7cMhVjQU4jr7Sg6bG0
   UbjpDpUhCQWjFB9bVUbaKsmPCp9ItWfS587B7W6UgZIpEm6lfzC9ER7Kt
   O7Nf2xpMLW9FXuzC2hRhTiSB76WpM3n8U/CFfhr2g3Rv+K1fPRMrCpfJs
   Q==;
X-CSE-ConnectionGUID: uEEP4qfhR9WjTnSV687bcg==
X-CSE-MsgGUID: jEt74LQtTLu7BjwyIoUapA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10005947"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="10005947"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:58:57 -0700
X-CSE-ConnectionGUID: kHiGaN+bQ9eNgQed/KhcLg==
X-CSE-MsgGUID: 1CKdV80RSVmEwPdCd3zOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29637700"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:58:57 -0700
Date: Thu, 25 Apr 2024 12:58:56 -0700
From: Tony Luck <tony.luck@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@alien8.de>,
	Jean Delvare <jdelvare@suse.com>
Cc: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
Message-ID: <Ziq2AMcJUyikTtxK@agluck-desk3>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181534.42216-1-tony.luck@intel.com>
 <8b138aec-9565-4847-8c7c-8a1fe6972a04@roeck-us.net>
 <SJ1PR11MB6083E8AFB8E001855DE4162EFC102@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083E8AFB8E001855DE4162EFC102@SJ1PR11MB6083.namprd11.prod.outlook.com>

> Is drivers/peci/device.c: peci_get_cpu_id() specific to Intel CPUs? It seems
> to retrieve a value in the format of CPUID(EAX=1).EAX that would apply to
> both Intel and AMD. Yet I don't see any checking of vendor id before looking
> at the model id.

Some web wearching indicates that PECI is an Intel specific protocol, so
no need for vendor checks.

I've re-worked the peci patches (combining the core and hwmon bits) to
switch from separate "family" and "model" fields and checks to using
the same x86_vfm combined value.

The peci patch is included below. But you can see it in context in:

git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git new_families_v5_wip

The x86 build of these bits works. But I don't have cross-compile
enviroment to check non-X86 builds. Also no way to test.

-Tony

---

From 34cc093cbebaf596a52b123c4f8c3ef2df45a240 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 25 Apr 2024 12:27:39 -0700
Subject: [PATCH] peci, hwmon: Switch to new Intel CPU model defines

Update peci subsystem to use the same vendor-family-model
combined definition that core x86 code uses.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/peci-cpu.h     | 24 ++++++++++++++++++++++++
 include/linux/peci.h         |  3 +--
 drivers/peci/internal.h      |  3 +--
 drivers/hwmon/peci/cputemp.c |  8 ++++----
 drivers/peci/core.c          |  5 ++---
 drivers/peci/cpu.c           | 21 +++++++--------------
 drivers/peci/device.c        |  3 +--
 7 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/include/linux/peci-cpu.h b/include/linux/peci-cpu.h
index ff8ae9c26c80..601cdd086bf6 100644
--- a/include/linux/peci-cpu.h
+++ b/include/linux/peci-cpu.h
@@ -6,6 +6,30 @@
 
 #include <linux/types.h>
 
+/* Copied from x86 <asm/processor.h> */
+#define X86_VENDOR_INTEL       0
+
+/* Copied from x86 <asm/cpu_device_id.h> */
+#define VFM_MODEL_BIT	0
+#define VFM_FAMILY_BIT	8
+#define VFM_VENDOR_BIT	16
+#define VFM_RSVD_BIT	24
+
+#define	VFM_MODEL_MASK	GENMASK(VFM_FAMILY_BIT - 1, VFM_MODEL_BIT)
+#define	VFM_FAMILY_MASK	GENMASK(VFM_VENDOR_BIT - 1, VFM_FAMILY_BIT)
+#define	VFM_VENDOR_MASK	GENMASK(VFM_RSVD_BIT - 1, VFM_VENDOR_BIT)
+
+#define VFM_MODEL(vfm)	(((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
+#define VFM_FAMILY(vfm)	(((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_BIT)
+#define VFM_VENDOR(vfm)	(((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_BIT)
+
+#define	VFM_MAKE(_vendor, _family, _model) (	\
+	((_model) << VFM_MODEL_BIT) |		\
+	((_family) << VFM_FAMILY_BIT) |		\
+	((_vendor) << VFM_VENDOR_BIT)		\
+)
+/* End of copied code */
+
 #include "../../arch/x86/include/asm/intel-family.h"
 
 #define PECI_PCS_PKG_ID			0  /* Package Identifier Read */
diff --git a/include/linux/peci.h b/include/linux/peci.h
index 9b3d36aff431..0db8b5dd09d9 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -74,8 +74,7 @@ static inline struct peci_controller *to_peci_controller(void *d)
 struct peci_device {
 	struct device dev;
 	struct {
-		u16 family;
-		u8 model;
+		u32 x86_vfm;
 		u8 peci_revision;
 		u8 socket_id;
 	} info;
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 9d75ea54504c..7ead53e5598f 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -71,8 +71,7 @@ struct peci_request *peci_xfer_ep_mmio64_readl(struct peci_device *device, u8 ba
  */
 struct peci_device_id {
 	const void *data;
-	u16 family;
-	u8 model;
+	u32 x86_vfm;
 };
 
 extern struct device_type peci_device_type;
diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index a812c15948d9..5a682195b98f 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -360,10 +360,10 @@ static int init_core_mask(struct peci_cputemp *priv)
 	int ret;
 
 	/* Get the RESOLVED_CORES register value */
-	switch (peci_dev->info.model) {
-	case INTEL_FAM6_ICELAKE_X:
-	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	switch (peci_dev->info.x86_vfm) {
+	case INTEL_ICELAKE_X:
+	case INTEL_ICELAKE_D:
+	case INTEL_SAPPHIRERAPIDS_X:
 		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
 					     reg->func, reg->offset + 4, &data);
 		if (ret)
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 0f83a9c6093b..b2d7adf05ba0 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -163,9 +163,8 @@ EXPORT_SYMBOL_NS_GPL(devm_peci_controller_add, PECI);
 static const struct peci_device_id *
 peci_bus_match_device_id(const struct peci_device_id *id, struct peci_device *device)
 {
-	while (id->family != 0) {
-		if (id->family == device->info.family &&
-		    id->model == device->info.model)
+	while (id->x86_vfm != 0) {
+		if (id->x86_vfm == device->info.x86_vfm)
 			return id;
 		id++;
 	}
diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index bd990acd92b8..152bbd8e717a 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -294,38 +294,31 @@ peci_cpu_probe(struct peci_device *device, const struct peci_device_id *id)
 
 static const struct peci_device_id peci_cpu_device_ids[] = {
 	{ /* Haswell Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_HASWELL_X,
+		.x86_vfm = INTEL_HASWELL_X,
 		.data	= "hsx",
 	},
 	{ /* Broadwell Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_BROADWELL_X,
+		.x86_vfm = INTEL_BROADWELL_X,
 		.data	= "bdx",
 	},
 	{ /* Broadwell Xeon D */
-		.family	= 6,
-		.model	= INTEL_FAM6_BROADWELL_D,
+		.x86_vfm = INTEL_BROADWELL_D,
 		.data	= "bdxd",
 	},
 	{ /* Skylake Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_SKYLAKE_X,
+		.x86_vfm = INTEL_SKYLAKE_X,
 		.data	= "skx",
 	},
 	{ /* Icelake Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_ICELAKE_X,
+		.x86_vfm = INTEL_ICELAKE_X,
 		.data	= "icx",
 	},
 	{ /* Icelake Xeon D */
-		.family	= 6,
-		.model	= INTEL_FAM6_ICELAKE_D,
+		.x86_vfm = INTEL_ICELAKE_D,
 		.data	= "icxd",
 	},
 	{ /* Sapphire Rapids Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.x86_vfm = INTEL_SAPPHIRERAPIDS_X,
 		.data	= "spr",
 	},
 	{ }
diff --git a/drivers/peci/device.c b/drivers/peci/device.c
index e6b0bffb14f4..5eb57b503c81 100644
--- a/drivers/peci/device.c
+++ b/drivers/peci/device.c
@@ -100,8 +100,7 @@ static int peci_device_info_init(struct peci_device *device)
 	if (ret)
 		return ret;
 
-	device->info.family = peci_x86_cpu_family(cpu_id);
-	device->info.model = peci_x86_cpu_model(cpu_id);
+	device->info.x86_vfm = IFM(peci_x86_cpu_family(cpu_id), peci_x86_cpu_model(cpu_id));
 
 	ret = peci_get_revision(device, &revision);
 	if (ret)
-- 
2.44.0


