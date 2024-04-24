Return-Path: <linux-kernel+bounces-157503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C28B122E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14308285D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F71C65FB;
	Wed, 24 Apr 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtGrqj2N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE561C230A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982536; cv=none; b=hmeH+IwHpDpVm/Dm0P9r+aTvW86QcNVCuy8zQIS1UKXrm8zd8OFU6GlMln6Scu/YdkOae/yUtfBcR5ZAFk1lrHjLQsceOGHe+MKjBdsrxMF8Tagu9iV+fDkhVJCJ6nPgWSasAo81NhmE7qnn5ZNSK8+gmg8q3PxC0VIjs1H+dXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982536; c=relaxed/simple;
	bh=t/ao4kMQjvb5Oyj2NN7I0cbLAgUqp9G5mS37WgG/glA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOfpXH8Q9T4HUkJ/J2o/EkSuBwblO/8KpPTA6bv84OHU65ZombsjuAEwz3MZ7HeF8v9Xl7E1YmEAOeKPAmDlP5g+HjENetFEF6fk7HfXB7coZavmg7n489bn8hxEE0Z1et5lErWtBGEKWxK87h7xle6tpHTap0KuiIfutBRQ+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtGrqj2N; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982535; x=1745518535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t/ao4kMQjvb5Oyj2NN7I0cbLAgUqp9G5mS37WgG/glA=;
  b=LtGrqj2NRIIMh7qdVB9m2pF8q2LFI+oqTtxlCCbTQEnUr4g5ASCqAqZA
   2wbDDmhZeC+RJL+NKecYNSg8n192yCNJiNyfL+J1I/4zrcI3/i+XTaAio
   xW/FWGyudGnSxHY3g1x8SJYvkHPcdU51hqmdUyDcmDHtKzVWxehi5juf6
   6J/r/EESe0jpiJd7OlcUeYE4NKwpryxBV+JDbVjCqRVQaVSL0PSKyIsBK
   XvUGe1vPTCqxZLvbN03WA7SmllAB/vhSWLhu/vklEGNH3s8kXrfGQtQC2
   XF4IxG+q0YZ3Xw38IcZqFVwx1sAy9FdwB7MDkXGIw8FJDhqObzqWTiuAt
   g==;
X-CSE-ConnectionGUID: SzZQE+XFSVycm7oqR34zjg==
X-CSE-MsgGUID: Qwif9WryRhKBPzxuz+5LFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503647"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503647"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:34 -0700
X-CSE-ConnectionGUID: Pm2usB6YTlyIertnoLSiOg==
X-CSE-MsgGUID: zoV8luwyT2+F/Vz8ck2PuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750223"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:34 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	openbmc@lists.ozlabs.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 54/71] peci: cpu: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:33 -0700
Message-ID: <20240424181533.42197-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

N.B. Copy some macros from x86 <asm/cpu_device_id.h> and the
X86_VENDOR_INTEL define from <asm/processor.h> because this
code can be built for BMC's that are not based on x86 so
accessing those header files is problematic.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/peci-cpu.h | 24 ++++++++++++++++++++++++
 drivers/peci/cpu.c       | 28 ++++++++++++++--------------
 2 files changed, 38 insertions(+), 14 deletions(-)

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
diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index bd990acd92b8..8e8292c05551 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -294,38 +294,38 @@ peci_cpu_probe(struct peci_device *device, const struct peci_device_id *id)
 
 static const struct peci_device_id peci_cpu_device_ids[] = {
 	{ /* Haswell Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_HASWELL_X,
+		.family	= VFM_FAMILY(INTEL_HASWELL_X),
+		.model	= VFM_MODEL(INTEL_HASWELL_X),
 		.data	= "hsx",
 	},
 	{ /* Broadwell Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_BROADWELL_X,
+		.family	= VFM_FAMILY(INTEL_BROADWELL_X),
+		.model	= VFM_MODEL(INTEL_BROADWELL_X),
 		.data	= "bdx",
 	},
 	{ /* Broadwell Xeon D */
-		.family	= 6,
-		.model	= INTEL_FAM6_BROADWELL_D,
+		.family	= VFM_FAMILY(INTEL_BROADWELL_D),
+		.model	= VFM_MODEL(INTEL_BROADWELL_D),
 		.data	= "bdxd",
 	},
 	{ /* Skylake Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_SKYLAKE_X,
+		.family	= VFM_FAMILY(INTEL_SKYLAKE_X),
+		.model	= VFM_MODEL(INTEL_SKYLAKE_X),
 		.data	= "skx",
 	},
 	{ /* Icelake Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_ICELAKE_X,
+		.family	= VFM_FAMILY(INTEL_ICELAKE_X),
+		.model	= VFM_MODEL(INTEL_ICELAKE_X),
 		.data	= "icx",
 	},
 	{ /* Icelake Xeon D */
-		.family	= 6,
-		.model	= INTEL_FAM6_ICELAKE_D,
+		.family	= VFM_FAMILY(INTEL_ICELAKE_D),
+		.model	= VFM_MODEL(INTEL_ICELAKE_D),
 		.data	= "icxd",
 	},
 	{ /* Sapphire Rapids Xeon */
-		.family	= 6,
-		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.family	= VFM_FAMILY(INTEL_SAPPHIRERAPIDS_X),
+		.model	= VFM_MODEL(INTEL_SAPPHIRERAPIDS_X),
 		.data	= "spr",
 	},
 	{ }
-- 
2.44.0


