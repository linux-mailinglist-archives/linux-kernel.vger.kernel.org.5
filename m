Return-Path: <linux-kernel+bounces-133746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB4689A809
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2642283CCB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A11BC39;
	Sat,  6 Apr 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB4PADLG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618261FDA;
	Sat,  6 Apr 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365096; cv=none; b=mU32/180Hs9iA7aVHqXGjhyM8CCnZkUizHNVabvSqyEf0BTL/fD57pnxfU4GSoxjAGNV9mG9IvtaPGn892XVJsY6/7fs06fYbgwTLWFs2vU87lRM/J062WywnR38os3ixpySr26NLRk3nk2iOJitQBR9fbMsl/BiL/XXSyE3sV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365096; c=relaxed/simple;
	bh=M2NpUF0GpEYkCm0hpvAgVNS5+2TcRpN8c57fAIjoOvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=umtZtv9iSwTTMaTZEosxrdlCW+S//Ma+eRYtAH+jxEJ/vpAWUaaCAvXSjRWmC3NjLKdkCKLnLtrLzxr66J2uDqMxTE2UsLZC10WlfwZpDth3P2WMnO8z0Cv4rPRq3oChPLsNo3Omha9J3t7BSVa49orFsaeEazti+pQ6gbS3GFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB4PADLG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712365093; x=1743901093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=M2NpUF0GpEYkCm0hpvAgVNS5+2TcRpN8c57fAIjoOvc=;
  b=dB4PADLGl5ewOfk+9gA7SZFsOBn7QVyyqUxq2X4HcTbhyRBHg7X6jm5v
   kBOgoenZEdy0SuGQuCG/eo4SGOEOTg/PEgY3r4z02tlgCPx1yFfdVOTZ4
   7VIBauvjrbHXy034/xJoLR/UnDeVhttQjubU8N3EaZlJ8nk7IDOmDZUjQ
   lVIp/4YF6G7H7tjByw16JzN+hxv3wBUuLrDF/9TXdrwFaJ+iOrEhsFLnz
   iDq2eblumvZHaLcB/JmnMACCJ/L/nvftpj3t8GQFVnk6KPz3w/GI+9RWs
   tsWbKEIawD3C+Si205pn2DpRS5O3sxo24uCK10YXPs/HNuSSVoMzIlDdD
   w==;
X-CSE-ConnectionGUID: znTeJ8cWSHasj041cU1b5A==
X-CSE-MsgGUID: PUbXdbdIQoS73QY4TQ8DEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25153873"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="25153873"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:58:11 -0700
X-CSE-ConnectionGUID: uC34GYp+QSCYAP2KhqIrcA==
X-CSE-MsgGUID: 3mzLzgSMQuiqh+5MUcc3NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19252363"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 05 Apr 2024 17:58:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 1/3] thermal: intel: intel_tcc: Add model checks for temperature registers
Date: Fri,  5 Apr 2024 18:04:14 -0700
Message-Id: <20240406010416.4821-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The register MSR_TEMPERATURE_TARGET is not architectural. Its fields may be
defined differently for each processor model. TCC_OFFSET is an example of
such case.

Despite being specified as architectural, the registers IA32_[PACKAGE]_
THERM_STATUS have become model-specific: in recent processors, the
digital temperature readout uses bits [23:16] whereas the Intel Software
Developer's manual specifies bits [22:16].

Create an array of processor models and their bitmasks for TCC_OFFSET and
the digital temperature readout fields. Do not include recent processors.
Instead, use the bitmasks of these recent processors as default.

Use these model-specific bitmasks when reading TCC_OFFSET or the
temperature sensors.

Initialize a model-specific data structure during subsys_initcall() to
have it ready when thermal drivers are loaded.

Expose the new interfaces get_tcc_offset_mask() and
intel_tcc_get_temp_mask(). The hwmon/coretemp and the intel_tcc_cooling
drivers need to use model-specific bitmasks. Include stubs that reflect
minimum support for !CONFIG_INTEL_TCC.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v6.7+
---
 drivers/thermal/intel/intel_tcc.c | 177 +++++++++++++++++++++++++++++-
 include/linux/intel_tcc.h         |   8 ++
 2 files changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index 5e8b7f34b395..1f595f174ab0 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -6,8 +6,170 @@
 
 #include <linux/errno.h>
 #include <linux/intel_tcc.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/msr.h>
 
+/**
+ * struct temp_masks - Bitmasks for temperature readings
+ * @tcc_offset:			TCC offset in MSR_TEMPERATURE_TARGET
+ * @digital_readout:		Digital readout in MSR_IA32_THERM_STATUS
+ * @pkg_digital_readout:	Digital readout in MSR_IA32_PACKAGE_THERM_STATUS
+ *
+ * Bitmasks to extract the fields of the MSR_TEMPERATURE and IA32_[PACKAGE]_
+ * THERM_STATUS registers for different processor models.
+ *
+ * The bitmask of TjMax is not included in this structure. It is always 0xff.
+ */
+struct temp_masks {
+	u32 tcc_offset;
+	u32 digital_readout;
+	u32 pkg_digital_readout;
+};
+
+#define TCC_FAM6_MODEL_TEMP_MASKS(model, _tcc_offset, _digital_readout,	\
+			_pkg_digital_readout)				\
+	static const struct temp_masks temp_##model __initconst = {	\
+		.tcc_offset = _tcc_offset,				\
+		.digital_readout = _digital_readout,			\
+		.pkg_digital_readout = _pkg_digital_readout		\
+	}
+
+TCC_FAM6_MODEL_TEMP_MASKS(nehalem, 0, 0x7f, 0x7f);
+TCC_FAM6_MODEL_TEMP_MASKS(haswell_x, 0xf, 0x7f, 0x7f);
+TCC_FAM6_MODEL_TEMP_MASKS(broadwell, 0x3f, 0x7f, 0x7f);
+TCC_FAM6_MODEL_TEMP_MASKS(goldmont, 0x7f, 0x7f, 0x7f);
+TCC_FAM6_MODEL_TEMP_MASKS(tigerlake, 0x3f, 0xff, 0xff);
+TCC_FAM6_MODEL_TEMP_MASKS(sapphirerapids, 0x3f, 0x7f, 0xff);
+
+/* Use these masks for processors not included in @tcc_cpu_ids. */
+static struct temp_masks intel_tcc_temp_masks __ro_after_init = {
+	.tcc_offset = 0x7f,
+	.digital_readout = 0xff,
+	.pkg_digital_readout = 0xff,
+};
+
+static const struct x86_cpu_id intel_tcc_cpu_ids[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL(CORE_YONAH,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(CORE2_MEROM,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(CORE2_MEROM_L,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(CORE2_PENRYN,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(CORE2_DUNNINGTON,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&temp_haswell_x),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&temp_haswell_x),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&temp_haswell_x),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&temp_haswell_x),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&temp_haswell_x),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&temp_sapphirerapids),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&temp_sapphirerapids),
+	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL_MID,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,	&temp_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_NP,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&temp_goldmont),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&temp_goldmont),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&temp_goldmont),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&temp_tigerlake),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&temp_broadwell),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&temp_broadwell),
+	{}
+};
+
+static int __init intel_tcc_init(void)
+{
+	const struct x86_cpu_id *id;
+
+	id = x86_match_cpu(intel_tcc_cpu_ids);
+	if (id)
+		memcpy(&intel_tcc_temp_masks, (const void *)id->driver_data,
+		       sizeof(intel_tcc_temp_masks));
+
+	return 0;
+}
+/*
+ * Use subsys_initcall to ensure temperature bitmasks are initialized before
+ * the drivers that use this library.
+ */
+subsys_initcall(intel_tcc_init);
+
+/**
+ * get_tcc_offset_mask() - Returns the model-specific bitmask for TCC offset
+ *
+ * Get the model-specific bitmask to extract TCC_OFFSET from the MSR_TEMPERATURE_
+ * TARGET register. If the mask is 0, it means the processor does not support TCC offset.
+ *
+ * Return: The model-specific bitmask for TCC offset.
+ */
+u32 get_tcc_offset_mask(void)
+{
+	return intel_tcc_temp_masks.tcc_offset;
+}
+EXPORT_SYMBOL_NS(get_tcc_offset_mask, INTEL_TCC);
+
+/**
+ * intel_tcc_get_temp_mask() - Returns the model-specific bitmask for temperature
+ *
+ * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
+ *
+ * Get the model-specific bitmask to extract the temperature reading from the
+ * MSR_IA32_[PACKAGE]_THERM_STATUS register.
+ *
+ * Callers must check if the thermal status registers are supported.
+ *
+ * Return: The model-specific bitmask for temperature reading
+ */
+u32 intel_tcc_get_temp_mask(bool pkg)
+{
+	return pkg ? intel_tcc_temp_masks.pkg_digital_readout :
+	       intel_tcc_temp_masks.digital_readout;
+}
+EXPORT_SYMBOL_NS(intel_tcc_get_temp_mask, INTEL_TCC);
+
 /**
  * intel_tcc_get_tjmax() - returns the default TCC activation Temperature
  * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
@@ -56,7 +218,7 @@ int intel_tcc_get_offset(int cpu)
 	if (err)
 		return err;
 
-	return (low >> 24) & 0x3f;
+	return (low >> 24) & intel_tcc_temp_masks.tcc_offset;
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
 
@@ -76,7 +238,10 @@ int intel_tcc_set_offset(int cpu, int offset)
 	u32 low, high;
 	int err;
 
-	if (offset < 0 || offset > 0x3f)
+	if (!intel_tcc_temp_masks.tcc_offset)
+		return -ENODEV;
+
+	if (offset < 0 || offset > intel_tcc_temp_masks.tcc_offset)
 		return -EINVAL;
 
 	if (cpu < 0)
@@ -90,7 +255,7 @@ int intel_tcc_set_offset(int cpu, int offset)
 	if (low & BIT(31))
 		return -EPERM;
 
-	low &= ~(0x3f << 24);
+	low &= ~(intel_tcc_temp_masks.tcc_offset << 24);
 	low |= offset << 24;
 
 	if (cpu < 0)
@@ -113,8 +278,8 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
  */
 int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 {
-	u32 low, high;
 	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
+	u32 low, high, mask;
 	int tjmax, err;
 
 	tjmax = intel_tcc_get_tjmax(cpu);
@@ -132,7 +297,9 @@ int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 	if (!(low & BIT(31)))
 		return -ENODATA;
 
-	*temp = tjmax - ((low >> 16) & 0x7f);
+	mask = intel_tcc_get_temp_mask(pkg);
+
+	*temp = tjmax - ((low >> 16) & mask);
 
 	return 0;
 }
diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
index 8ff8eabb4a98..e281cf06aeab 100644
--- a/include/linux/intel_tcc.h
+++ b/include/linux/intel_tcc.h
@@ -14,5 +14,13 @@ int intel_tcc_get_tjmax(int cpu);
 int intel_tcc_get_offset(int cpu);
 int intel_tcc_set_offset(int cpu, int offset);
 int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
+#ifdef CONFIG_INTEL_TCC
+u32 get_tcc_offset_mask(void);
+u32 intel_tcc_get_temp_mask(bool pkg);
+#else
+static inline u32 get_tcc_offset_mask(void) { return 0; }
+/* Use the architectural bitmask of the temperature readout. No model checks. */
+static inline u32 intel_tcc_get_temp_mask(bool pkg) { return 0x7f; }
+#endif
 
 #endif /* __INTEL_TCC_H__ */
-- 
2.34.1


