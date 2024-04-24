Return-Path: <linux-kernel+bounces-157500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94E8B122A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777111C216AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793271C2313;
	Wed, 24 Apr 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvU8zX4V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079211BF6DB;
	Wed, 24 Apr 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982534; cv=none; b=H1eVT1zuTrspSocWpQWIeThk1zUrNxq5sCbIypF6XXtQc4NAwQ7XIXkkv0CpCUMFisXODRnw17U15JMzSEVzGC4i0fGHZ9aCIdOhA7Jfdqjry5mOyN72/SYnoJousYGdy1/UKeNFQYFOTzZz4jdRoNQgUQC9X6xXyTavdy0P9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982534; c=relaxed/simple;
	bh=K0SMUkbNdaQTs8egvbi/pMmubWEho1P85u2CzO6rIlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU8cyKgwOD5LYMOnfdmJTmbkRNP+D8CTzCempNCwahZVrgyqAqjEedDncTGoYmwYxQsr96hCJabMgMPOrR8rUwTRcOmFo+BuCGatdXZI+8BfITd/rS05iYoR+a3uoiTtE2HKieiSS/6Lv0yAlLCy1yJ/jYxMiaT53E7ZEQ8i2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvU8zX4V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982533; x=1745518533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0SMUkbNdaQTs8egvbi/pMmubWEho1P85u2CzO6rIlk=;
  b=gvU8zX4VVCeFSjBz/8YQMcH+ADHLplw1CW7BOXWF4k3pIOaBGV2Ldx9+
   DNEYyQ7AijIaJuP9B9Qh+LbNya4VV+ZWIpJZlnc3zCQAP2yAC9parTThs
   fvV2KYAqjf8QVx6eh5hC9bvu1jlV7fruXksqTwQyMe7pQ2t1vHbdIV9Bc
   ijxuX3pB9yve31huNBY7i5fxdl1EyezCl5xbZXNNi1xCTCUPEqwUIWuI0
   75lvtwae3eyUHvr568CQdMIrbiJYxOOptJSyodLaVdN4UkgepT3/vCgk4
   uLVkjvtI2FuPOGHPGX503/VYw0Qx0kiy34d92IrVfarnw5EvmPNctKGDP
   g==;
X-CSE-ConnectionGUID: n7I3iF4fSrm7gYjMZC4wvw==
X-CSE-MsgGUID: hSgwgAT5QsCYFD3qTUlqgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503628"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:32 -0700
X-CSE-ConnectionGUID: cgQ6Am4URKWlRgWxPx5IMg==
X-CSE-MsgGUID: BvzoA1NXSPOHzeCI+T9qUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750193"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:31 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 51/71] EDAC/sb_edac: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:30 -0700
Message-ID: <20240424181530.42140-1-tony.luck@intel.com>
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

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/sb_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 26cca5a9322d..cbc92d3683e6 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3546,13 +3546,13 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 }
 
 static const struct x86_cpu_id sbridge_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X, &pci_dev_descr_sbridge_table),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,	  &pci_dev_descr_ibridge_table),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,	  &pci_dev_descr_haswell_table),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	  &pci_dev_descr_broadwell_table),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	  &pci_dev_descr_broadwell_table),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,  &pci_dev_descr_knl_table),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,  &pci_dev_descr_knl_table),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&pci_dev_descr_sbridge_table),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&pci_dev_descr_ibridge_table),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&pci_dev_descr_haswell_table),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&pci_dev_descr_broadwell_table),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&pci_dev_descr_broadwell_table),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&pci_dev_descr_knl_table),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&pci_dev_descr_knl_table),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
-- 
2.44.0


