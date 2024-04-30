Return-Path: <linux-kernel+bounces-164471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049FC8B7DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AB31C227DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA220FAB9;
	Tue, 30 Apr 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaJMI+pB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DA1CB306
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495916; cv=none; b=ujxNxymfcnIbCPzVA2k0hupMDVasLI1ZjLC9EGp9O0CsGNJrjzZc1JqkJkHEQofgs6pfjtVFSnPSqyZBPLQntQpzUSO9qMu4y1QmOk66G7p5qa2QGGCsoVBhgqleerCcMJQn5W7cc5FwKtX4khw3fvwC5pXKr/wLuZKnRB0Bt9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495916; c=relaxed/simple;
	bh=QaWcTVRcpxoRVfUDh2a7OQ2I4NG/dIdQ4QTyqcgZgdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5dFq/bOJkwaWXgGE0PciB08Fbp465YeEju7a8VOHTY6eNcSNE9tz5jVpZccOq7jufkgEpOhpIzM6ehajGyogY/EwaG02D1tU25z5BzNQrGKCDiADlRxwlPaYDznyubf+2cFe1E10tdgNuA0B1TCVL7O/0WDi9jA9RLLhMuBEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaJMI+pB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495915; x=1746031915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QaWcTVRcpxoRVfUDh2a7OQ2I4NG/dIdQ4QTyqcgZgdE=;
  b=JaJMI+pBLok/mwv8txHF3Ydx+vF7N4RzTnSEqWoY4Fe0UEJ1ifeLHweD
   IEcR7fBa5DUISwohcmbhiSowL0Z9zpYlTaP/T0f4AoTNUHjodNiRAIsri
   NoFgZysUeTiZZ+Qi1MUjlLpy6x40CXSy+sDsrRcNyTMPsgVttp0hxbZaq
   vJ+vXbBVjKClAf7Kv9KWwpGcFBUVqfb5y9868ZedrkUJG/k00VcQPWWRj
   eiMThze72uXm1y3mK51QUG6OMSv/XtHVC9lqhPlcLYDi7VLtqcap/LqPz
   Ve7kAVlLbn35z5Y4dfw+Us5AZBZ9qSjFrKxwmpGTdTxY1VlVs4/Ma3ype
   A==;
X-CSE-ConnectionGUID: hBvKMUbmSsWKJsAYiYNnTg==
X-CSE-MsgGUID: DtskiJHgSsKgsamCa1hKTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075819"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075819"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: yA+rXPdJQVuUNZPS51ZopQ==
X-CSE-MsgGUID: wlL151Z/RIO2ibkqJWyvkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515527"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 44/47] peci, hwmon: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:57 -0700
Message-ID: <20240430165100.73491-44-tony.luck@intel.com>
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

Update peci subsystem to use the same vendor-family-model
combined definition that core x86 code uses.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/peci-cpu.h     | 24 ++++++++++++++++++++++++
 include/linux/peci.h         |  6 ++----
 drivers/peci/internal.h      |  6 ++----
 drivers/hwmon/peci/cputemp.c |  8 ++++----
 drivers/peci/core.c          |  5 ++---
 drivers/peci/cpu.c           | 21 +++++++--------------
 drivers/peci/device.c        |  3 +--
 7 files changed, 42 insertions(+), 31 deletions(-)

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
index 9b3d36aff431..7e1107039702 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -60,8 +60,7 @@ static inline struct peci_controller *to_peci_controller(void *d)
  * @dev: device object to register PECI device to the device model
  * @controller: manages the bus segment hosting this PECI device
  * @info: PECI device characteristics
- * @info.family: device family
- * @info.model: device model
+ * @info.x86_vfm: device vendor-family-model
  * @info.peci_revision: PECI revision supported by the PECI device
  * @info.socket_id: the socket ID represented by the PECI device
  * @addr: address used on the PECI bus connected to the parent controller
@@ -74,8 +73,7 @@ static inline struct peci_controller *to_peci_controller(void *d)
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
index 9d75ea54504c..b9d45483cabe 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -66,13 +66,11 @@ struct peci_request *peci_xfer_ep_mmio64_readl(struct peci_device *device, u8 ba
 /**
  * struct peci_device_id - PECI device data to match
  * @data: pointer to driver private data specific to device
- * @family: device family
- * @model: device model
+ * @x86_vfm: device vendor-family-model
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


