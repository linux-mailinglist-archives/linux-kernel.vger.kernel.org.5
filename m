Return-Path: <linux-kernel+bounces-155518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB338AF378
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1168828175B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704FB13D28F;
	Tue, 23 Apr 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EP+86W9q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0713CAAC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888401; cv=none; b=BwEEKlcxzAP6NHmdTbs8GLXy9AQi7vRpcui/4oPBMxg4/KqOcc3aC0Em2W7kGPSskj5HhvHyodFdThcNABQSswTJAkb2jgADzLyK/qEWGzLvijJYAD/pNMOlUX4PsBObcvuf3PfJ9sn6hTtMpjHFhonsKjw5BT95/DK0fmW8ioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888401; c=relaxed/simple;
	bh=1KbQ3vEPHuEHL7jdGIhBNK02puDlnCsB/SSG9+Sn7e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMusUVH9yB93w+O44+98YEt2hKOMRG6WftoHfr/9kwnsToArvU0HcAnJ5YDbzA/+mF599g+iFsygwFThJBKpWdK1UQNDzyxxsDs8P9Y3QfQwt9XsyrHMqtHbLPzlsbxiq3B9HQReb7vJEY0VVxauA+wDGT05XZDSb7SsuEVQpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EP+86W9q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888400; x=1745424400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KbQ3vEPHuEHL7jdGIhBNK02puDlnCsB/SSG9+Sn7e0=;
  b=EP+86W9qmr+tFObZ5HTceqMoa/Gqn+wSu9Xyn9lWIt4+cPm3OK28dhYc
   S5JWryjSxZgn4JgHI6Sc5PBTnQ06azePC9wFf58t4OyyaSExiQw15cG0n
   jGuuGjah12jUslN4LxzEIQmMf4iZEWvcBzUqOJoyU4xCUXA0G+CSStqrk
   f7/mOk+Z3ZNA1dJIeciz55oPa1iyI/qci7rFMRfT28NoFx+1ZoO8gI6Fg
   zFDWjDsflHl4qTuG5opEFo0R1+rgjpcertmticgJN8gHch2A+NfVF/Mt/
   skBeOHBLjLDm5FMx0bL2n2+5/oWh1dxS/IjtAN0HO4VlI69lx310LryKY
   A==;
X-CSE-ConnectionGUID: zEflPHqGRWmp6yjvLNHEpg==
X-CSE-MsgGUID: +BDQMi9FSMOnNn8Dsr4Pew==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26998825"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26998825"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:06:39 -0700
X-CSE-ConnectionGUID: UPSmH8G1TQmJhTo+dZUvqw==
X-CSE-MsgGUID: vxFZxWyvQgaHMMkK9xzYvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24462369"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:06:37 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH CI 3/3] drm/xe: Add INSTDONE registers to devcoredump
Date: Tue, 23 Apr 2024 09:05:50 -0700
Message-ID: <20240423160626.77110-3-jose.souza@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423160626.77110-1-jose.souza@intel.com>
References: <20240423160626.77110-1-jose.souza@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This registers contains important information that can help with debug
of GPU hangs.

While at it also fixing the double line jump at the end of engine
registers for CCS engines.

v2:
- print other INSTDONE registers

v3:
- add for_each_geometry/compute_dss()

v4:
- print one slice_common_instdone per glice in DG2+

v5:
- rename registers prefix from DG2 to XEHPG (Zhanjun)

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_engine_regs.h |   1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h     |  13 +++
 drivers/gpu/drm/xe/xe_hw_engine.c        | 128 +++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_hw_engine_types.h  |  16 +++
 4 files changed, 158 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
index af71b87d80301..97d2aed63e01c 100644
--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -65,6 +65,7 @@
 #define RING_ACTHD_UDW(base)			XE_REG((base) + 0x5c)
 #define RING_DMA_FADD_UDW(base)			XE_REG((base) + 0x60)
 #define RING_IPEHR(base)			XE_REG((base) + 0x68)
+#define RING_INSTDONE(base)			XE_REG((base) + 0x6c)
 #define RING_ACTHD(base)			XE_REG((base) + 0x74)
 #define RING_DMA_FADD(base)			XE_REG((base) + 0x78)
 #define RING_HWS_PGA(base)			XE_REG((base) + 0x80)
diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 94445810ccc93..c7fbea46bb75e 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -98,6 +98,8 @@
 #define   FF_MODE2_TDS_TIMER_MASK		REG_GENMASK(23, 16)
 #define   FF_MODE2_TDS_TIMER_128		REG_FIELD_PREP(FF_MODE2_TDS_TIMER_MASK, 4)
 
+#define XEHPG_INSTDONE_GEOM_SVGUNIT		XE_REG_MCR(0x666c)
+
 #define CACHE_MODE_1				XE_REG(0x7004, XE_REG_OPTION_MASKED)
 #define   MSAA_OPTIMIZATION_REDUC_DISABLE	REG_BIT(11)
 
@@ -115,6 +117,14 @@
 #define   FLSH_IGNORES_PSD			REG_BIT(10)
 #define   FD_END_COLLECT			REG_BIT(5)
 
+#define SC_INSTDONE				XE_REG(0x7100)
+#define SC_INSTDONE_EXTRA			XE_REG(0x7104)
+#define SC_INSTDONE_EXTRA2			XE_REG(0x7108)
+
+#define XEHPG_SC_INSTDONE			XE_REG_MCR(0x7100)
+#define XEHPG_SC_INSTDONE_EXTRA			XE_REG_MCR(0x7104)
+#define XEHPG_SC_INSTDONE_EXTRA2		XE_REG_MCR(0x7108)
+
 #define COMMON_SLICE_CHICKEN4			XE_REG(0x7300, XE_REG_OPTION_MASKED)
 #define   DISABLE_TDC_LOAD_BALANCING_CALC	REG_BIT(6)
 
@@ -342,6 +352,9 @@
 #define HALF_SLICE_CHICKEN5			XE_REG_MCR(0xe188, XE_REG_OPTION_MASKED)
 #define   DISABLE_SAMPLE_G_PERFORMANCE		REG_BIT(0)
 
+#define SAMPLER_INSTDONE			XE_REG_MCR(0xe160)
+#define ROW_INSTDONE				XE_REG_MCR(0xe164)
+
 #define SAMPLER_MODE				XE_REG_MCR(0xe18c, XE_REG_OPTION_MASKED)
 #define   ENABLE_SMALLPL			REG_BIT(15)
 #define   SC_DISABLE_POWER_OPTIMIZATION_EBB	REG_BIT(9)
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index c84dbe8a8ed1d..5d4a8f7b903e4 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -18,6 +18,7 @@
 #include "xe_gt.h"
 #include "xe_gt_ccs_mode.h"
 #include "xe_gt_printk.h"
+#include "xe_gt_mcr.h"
 #include "xe_gt_topology.h"
 #include "xe_hw_fence.h"
 #include "xe_irq.h"
@@ -766,6 +767,57 @@ void xe_hw_engine_handle_irq(struct xe_hw_engine *hwe, u16 intr_vec)
 		xe_hw_fence_irq_run(hwe->fence_irq);
 }
 
+static bool
+is_slice_common_per_gslice(struct xe_device *xe)
+{
+	return GRAPHICS_VERx100(xe) >= 1255;
+}
+
+static void
+xe_he_engine_snapshot_instdone_capture(struct xe_hw_engine *hwe,
+				       struct xe_hw_engine_snapshot *snapshot)
+{
+	struct xe_gt *gt = hwe->gt;
+	struct xe_device *xe = gt_to_xe(gt);
+	unsigned int dss;
+	u16 group, instance;
+
+	snapshot->reg.instdone.ring = hw_engine_mmio_read32(hwe, RING_INSTDONE(0));
+
+	if (snapshot->hwe->class != XE_ENGINE_CLASS_RENDER)
+		return;
+
+	if (is_slice_common_per_gslice(xe) == false) {
+		snapshot->reg.instdone.slice_common[0] =
+			xe_mmio_read32(gt, SC_INSTDONE);
+		snapshot->reg.instdone.slice_common_extra[0] =
+			xe_mmio_read32(gt, SC_INSTDONE_EXTRA);
+		snapshot->reg.instdone.slice_common_extra2[0] =
+			xe_mmio_read32(gt, SC_INSTDONE_EXTRA2);
+	} else {
+		for_each_geometry_dss(dss, gt, group, instance) {
+			snapshot->reg.instdone.slice_common[dss] =
+				xe_gt_mcr_unicast_read(gt, XEHPG_SC_INSTDONE, group, instance);
+			snapshot->reg.instdone.slice_common_extra[dss] =
+				xe_gt_mcr_unicast_read(gt, XEHPG_SC_INSTDONE_EXTRA, group, instance);
+			snapshot->reg.instdone.slice_common_extra2[dss] =
+				xe_gt_mcr_unicast_read(gt, XEHPG_SC_INSTDONE_EXTRA2, group, instance);
+		}
+	}
+
+	for_each_geometry_dss(dss, gt, group, instance) {
+		snapshot->reg.instdone.sampler[dss] =
+			xe_gt_mcr_unicast_read(gt, SAMPLER_INSTDONE, group, instance);
+		snapshot->reg.instdone.row[dss] =
+			xe_gt_mcr_unicast_read(gt, ROW_INSTDONE, group, instance);
+
+		if (GRAPHICS_VERx100(xe) >= 1255)
+			snapshot->reg.instdone.geom_svg[dss] =
+				xe_gt_mcr_unicast_read(gt, XEHPG_INSTDONE_GEOM_SVGUNIT,
+						       group, instance);
+	}
+}
+
 /**
  * xe_hw_engine_snapshot_capture - Take a quick snapshot of the HW Engine.
  * @hwe: Xe HW Engine.
@@ -780,6 +832,7 @@ struct xe_hw_engine_snapshot *
 xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
 {
 	struct xe_hw_engine_snapshot *snapshot;
+	size_t len;
 	u64 val;
 
 	if (!xe_hw_engine_is_valid(hwe))
@@ -790,6 +843,28 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
 	if (!snapshot)
 		return NULL;
 
+	/* Because XE_MAX_DSS_FUSE_BITS is defined in xe_gt_types.h and it
+	 * includes xe_hw_engine_types.h the length of this 3 registers can't be
+	 * set in struct xe_hw_engine_snapshot, so here doing additional
+	 * allocations.
+	 */
+	len = (XE_MAX_DSS_FUSE_BITS * sizeof(u32));
+	snapshot->reg.instdone.slice_common = kzalloc(len, GFP_ATOMIC);
+	snapshot->reg.instdone.slice_common_extra = kzalloc(len, GFP_ATOMIC);
+	snapshot->reg.instdone.slice_common_extra2 = kzalloc(len, GFP_ATOMIC);
+	snapshot->reg.instdone.sampler = kzalloc(len, GFP_ATOMIC);
+	snapshot->reg.instdone.row = kzalloc(len, GFP_ATOMIC);
+	snapshot->reg.instdone.geom_svg = kzalloc(len, GFP_ATOMIC);
+	if (!snapshot->reg.instdone.slice_common ||
+	    !snapshot->reg.instdone.slice_common_extra ||
+	    !snapshot->reg.instdone.slice_common_extra2 ||
+	    !snapshot->reg.instdone.sampler ||
+	    !snapshot->reg.instdone.row ||
+	    !snapshot->reg.instdone.geom_svg) {
+		xe_hw_engine_snapshot_free(snapshot);
+		return NULL;
+	}
+
 	snapshot->name = kstrdup(hwe->name, GFP_ATOMIC);
 	snapshot->hwe = hwe;
 	snapshot->logical_instance = hwe->logical_instance;
@@ -841,6 +916,7 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
 	snapshot->reg.ring_emr = hw_engine_mmio_read32(hwe, RING_EMR(0));
 	snapshot->reg.ring_eir = hw_engine_mmio_read32(hwe, RING_EIR(0));
 	snapshot->reg.ipehr = hw_engine_mmio_read32(hwe, RING_IPEHR(0));
+	xe_he_engine_snapshot_instdone_capture(hwe, snapshot);
 
 	if (snapshot->hwe->class == XE_ENGINE_CLASS_COMPUTE)
 		snapshot->reg.rcu_mode = xe_mmio_read32(hwe->gt, RCU_MODE);
@@ -848,6 +924,49 @@ xe_hw_engine_snapshot_capture(struct xe_hw_engine *hwe)
 	return snapshot;
 }
 
+static void
+xe_hw_engine_snapshot_instdone_print(struct xe_hw_engine_snapshot *snapshot, struct drm_printer *p)
+{
+	struct xe_gt *gt = snapshot->hwe->gt;
+	struct xe_device *xe = gt_to_xe(gt);
+	u16 group, instance;
+	unsigned int dss;
+
+	drm_printf(p, "\tRING_INSTDONE: 0x%08x\n", snapshot->reg.instdone.ring);
+
+	if (snapshot->hwe->class != XE_ENGINE_CLASS_RENDER)
+		return;
+
+	if (is_slice_common_per_gslice(xe) == false) {
+		drm_printf(p, "\tSC_INSTDONE[0]: 0x%08x\n",
+			   snapshot->reg.instdone.slice_common[0]);
+		drm_printf(p, "\tSC_INSTDONE_EXTRA[0]: 0x%08x\n",
+			   snapshot->reg.instdone.slice_common_extra[0]);
+		drm_printf(p, "\tSC_INSTDONE_EXTRA2[0]: 0x%08x\n",
+			   snapshot->reg.instdone.slice_common_extra2[0]);
+	} else {
+		for_each_geometry_dss(dss, gt, group, instance) {
+			drm_printf(p, "\tSC_INSTDONE[%u]: 0x%08x\n", dss,
+				   snapshot->reg.instdone.slice_common[dss]);
+			drm_printf(p, "\tSC_INSTDONE_EXTRA[%u]: 0x%08x\n", dss,
+				   snapshot->reg.instdone.slice_common_extra[dss]);
+			drm_printf(p, "\tSC_INSTDONE_EXTRA2[%u]: 0x%08x\n", dss,
+				   snapshot->reg.instdone.slice_common_extra2[dss]);
+		}
+	}
+
+	for_each_geometry_dss(dss, gt, group, instance) {
+		drm_printf(p, "\tSAMPLER_INSTDONE[%u]: 0x%08x\n", dss,
+			   snapshot->reg.instdone.sampler[dss]);
+		drm_printf(p, "\tROW_INSTDONE[%u]: 0x%08x\n", dss,
+			   snapshot->reg.instdone.row[dss]);
+
+		if (GRAPHICS_VERx100(xe) >= 1255)
+			drm_printf(p, "\tINSTDONE_GEOM_SVGUNIT[%u]: 0x%08x\n",
+				   dss, snapshot->reg.instdone.geom_svg[dss]);
+	}
+}
+
 /**
  * xe_hw_engine_snapshot_print - Print out a given Xe HW Engine snapshot.
  * @snapshot: Xe HW Engine snapshot object.
@@ -887,9 +1006,12 @@ void xe_hw_engine_snapshot_print(struct xe_hw_engine_snapshot *snapshot,
 	drm_printf(p, "\tBBADDR: 0x%016llx\n", snapshot->reg.ring_bbaddr);
 	drm_printf(p, "\tDMA_FADDR: 0x%016llx\n", snapshot->reg.ring_dma_fadd);
 	drm_printf(p, "\tIPEHR: 0x%08x\n", snapshot->reg.ipehr);
+	xe_hw_engine_snapshot_instdone_print(snapshot, p);
+
 	if (snapshot->hwe->class == XE_ENGINE_CLASS_COMPUTE)
 		drm_printf(p, "\tRCU_MODE: 0x%08x\n",
 			   snapshot->reg.rcu_mode);
+	drm_puts(p, "\n");
 }
 
 /**
@@ -904,6 +1026,12 @@ void xe_hw_engine_snapshot_free(struct xe_hw_engine_snapshot *snapshot)
 	if (!snapshot)
 		return;
 
+	kfree(snapshot->reg.instdone.slice_common);
+	kfree(snapshot->reg.instdone.slice_common_extra);
+	kfree(snapshot->reg.instdone.slice_common_extra2);
+	kfree(snapshot->reg.instdone.sampler);
+	kfree(snapshot->reg.instdone.row);
+	kfree(snapshot->reg.instdone.geom_svg);
 	kfree(snapshot->name);
 	kfree(snapshot);
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index 27deaa31efd31..9f9755e31b9fe 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_types.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_types.h
@@ -211,6 +211,22 @@ struct xe_hw_engine_snapshot {
 		u32 ipehr;
 		/** @reg.rcu_mode: RCU_MODE */
 		u32 rcu_mode;
+		struct {
+			/** @reg.instdone.ring: RING_INSTDONE */
+			u32 ring;
+			/** @reg.instdone.slice_common: SC_INSTDONE */
+			u32 *slice_common;
+			/** @reg.instdone.slice_common_extra: SC_INSTDONE_EXTRA */
+			u32 *slice_common_extra;
+			/** @reg.instdone.slice_common_extra2: SC_INSTDONE_EXTRA2 */
+			u32 *slice_common_extra2;
+			/** @reg.instdone.sampler: SAMPLER_INSTDONE */
+			u32 *sampler;
+			/** @reg.instdone.row: ROW_INSTDONE */
+			u32 *row;
+			/** @reg.instdone.geom_svg: INSTDONE_GEOM_SVGUNIT */
+			u32 *geom_svg;
+		} instdone;
 	} reg;
 };
 
-- 
2.44.0


