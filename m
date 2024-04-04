Return-Path: <linux-kernel+bounces-131561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CD2898990
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B52328E497
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53412BEAC;
	Thu,  4 Apr 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjeqqaFf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D112AAD4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239667; cv=none; b=NlifsdR+i277GElSZt1lJwLTXRulvvMzAjy01/JtZmQ/rn3wj+v9H8PaSYQdsMErIrFbihAlfowBmHxaPy6bxltXbZEaeA2XDQqbPFPmFXVIr3BpQ8bouBlAh8pVO4CYz0vW0yilFYqMzdb9EHsIsNqoVohsKe3mctrP4tGjcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239667; c=relaxed/simple;
	bh=7xYgs9GxqncCnlE/87Zl01PnZ/Uh1W71juU1u48zSQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHD1GrAl7+t2C16w0zx0t1yvHAuWKPhn1LMXwp8uCqtYmEmmz58xxUQYvVaJXFtYgdjqA1i0Y55F6vo0Iz2HbrjALZP/V/nJ4+yIb02sBgpZEhkuS8vNSBhCcwPJyGchAfUhoIvECImb4U80IdS6RjkR+Hrbyhug71qlBGQxddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjeqqaFf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239665; x=1743775665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7xYgs9GxqncCnlE/87Zl01PnZ/Uh1W71juU1u48zSQ0=;
  b=QjeqqaFflMpWaCulAzt94FNCo73OZiq4MTfQDeqMlHLhU4hbRr3OnHI0
   MlW4hHdDRdOcUc8hy0gM9HGJrUoG5qcIMIyHYK8H3B9cKZzyhGfvrH3m+
   Zv/CoXoaaaHW01E2O5u0fK5VGckYy5ZVAV2Ut9algscMok6oo0NuJFn6k
   EssO90gaNoj8NoQiR6NYBaH4Nt7uusgRDrnNyV3c/OknpblmkCdl3kVjM
   1X88fv0Il6dsuhQRPWTWFTNuLVtXq7cG3ZmzPunRSoMtUDWqSvWB5Yk3T
   g+pa4VJsRSbrkoyVn+VYKowt0/Hcb2imL2rU/qnZnn6gUWnENGfm8dada
   w==;
X-CSE-ConnectionGUID: UJOhgi+9SDK8W24L5U19yg==
X-CSE-MsgGUID: Rixr6CVATHujrt+b3+gpkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346533"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346533"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:45 -0700
X-CSE-ConnectionGUID: pHw2c+twRcWx8wLeHCJejQ==
X-CSE-MsgGUID: a/jmsDjTQA6he1kx/iDjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258887"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:45 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 06/12] perf/x86/intel: Support PERFEVTSEL extension
Date: Thu,  4 Apr 2024 07:06:31 -0700
Message-Id: <20240404140637.1232635-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404140637.1232635-1-kan.liang@linux.intel.com>
References: <20240404140637.1232635-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Two new fields (the unit mask2, and the equal flag) are added in the
IA32_PERFEVTSELx MSRs with Arch PerfMon V6. They can be enumerated by
the CPUID.23H.0.EBX.

Update the config_mask in x86_pmu and x86_hybrid_pmu for the true layout
of the PERFEVTSEL.
Expose the new formats into sysfs if they are available. The umask
extension reuses the same format attr name "umask" as the previous
umask. Add umask2_show to determine/display the correct format
for the current machine.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 72 +++++++++++++++++++++++++++++--
 arch/x86/include/asm/perf_event.h |  4 ++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bbb98b4c2a84..f586af9bade1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4632,8 +4632,58 @@ PMU_FORMAT_ATTR(pc,	"config:19"	);
 PMU_FORMAT_ATTR(any,	"config:21"	); /* v3 + */
 PMU_FORMAT_ATTR(inv,	"config:23"	);
 PMU_FORMAT_ATTR(cmask,	"config:24-31"	);
-PMU_FORMAT_ATTR(in_tx,  "config:32");
-PMU_FORMAT_ATTR(in_tx_cp, "config:33");
+PMU_FORMAT_ATTR(in_tx,  "config:32"	);
+PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
+PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
+
+static ssize_t umask2_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *page)
+{
+	u64 mask = hybrid(dev_get_drvdata(dev), config_mask) & ARCH_PERFMON_EVENTSEL_UMASK2;
+
+	if (x86_pmu.version >= 6 && mask == ARCH_PERFMON_EVENTSEL_UMASK2)
+		return sprintf(page, "config:8-15,40-47\n");
+
+	/* Roll back to the old format if umask2 is not supported. */
+	return sprintf(page, "config:8-15\n");
+}
+
+static struct device_attribute format_attr_umask2  =
+		__ATTR(umask, 0444, umask2_show, NULL);
+
+static struct attribute *format_evtsel_ext_attrs[] = {
+	&format_attr_umask2.attr,
+	&format_attr_eq.attr,
+	NULL
+};
+
+static umode_t
+evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	u64 mask;
+
+	/*
+	 * The umask and umask2 have different formats but share the
+	 * same attr name. In update mode, the previous value of the
+	 * umask is unconditionally removed before is_visible. If
+	 * umask2 format is not enumerated, it's impossible to roll
+	 * back to the old format.
+	 * Does the check in umask2_show rather than is_visible.
+	 */
+	if (i == 0)
+		return attr->mode;
+
+	if (x86_pmu.version < 6)
+		return 0;
+
+	mask = hybrid(dev_get_drvdata(dev), config_mask);
+	if (i == 1)
+		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
+
+	return 0;
+}
 
 static struct attribute *intel_arch_formats_attr[] = {
 	&format_attr_event.attr,
@@ -4786,8 +4836,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
 
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
-	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
+
+	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
+
+	if (ebx & ARCH_PERFMON_EXT_UMASK2)
+		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
+	if (ebx & ARCH_PERFMON_EXT_EQ)
+		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
 
 	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF_BIT) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
@@ -5817,6 +5873,12 @@ static struct attribute_group group_format_extra_skl = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_format_evtsel_ext = {
+	.name       = "format",
+	.attrs      = format_evtsel_ext_attrs,
+	.is_visible = evtsel_ext_is_visible,
+};
+
 static struct attribute_group group_default = {
 	.attrs      = intel_pmu_attrs,
 	.is_visible = default_is_visible,
@@ -5830,6 +5892,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_lbr,
 	&group_format_extra,
 	&group_format_extra_skl,
+	&group_format_evtsel_ext,
 	&group_default,
 	NULL,
 };
@@ -6049,6 +6112,7 @@ static const struct attribute_group *hybrid_attr_update[] = {
 	&group_caps_gen,
 	&group_caps_lbr,
 	&hybrid_group_format_extra,
+	&group_format_evtsel_ext,
 	&group_default,
 	&hybrid_group_cpus,
 	NULL,
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0c8e6d585add..8b02df9a2eb2 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -32,6 +32,8 @@
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 #define ARCH_PERFMON_EVENTSEL_BR_CNTR			(1ULL << 35)
+#define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
+#define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
 
 #define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -185,6 +187,8 @@ union cpuid10_edx {
  * detection/enumeration details:
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
+#define ARCH_PERFMON_EXT_UMASK2			0x1
+#define ARCH_PERFMON_EXT_EQ			0x2
 #define ARCH_PERFMON_NUM_COUNTER_LEAF_BIT	0x1
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 
-- 
2.35.1


