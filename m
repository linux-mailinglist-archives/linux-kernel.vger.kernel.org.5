Return-Path: <linux-kernel+bounces-147619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55DC8A7694
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435EAB219FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA215356C;
	Tue, 16 Apr 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2grWBHp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96661534E1;
	Tue, 16 Apr 2024 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302549; cv=none; b=kzgsvVgnrMhttrjeoLz50PEd7P174AFPhfPDwSLjhb+MOv/zETiUjDo1C+YYkzcdwJX8TBJZ+FDJtvhqsIF/zTo/cCi2WmYspv03ygud6g/DeJMqMsai54N1Fqg5cb2J5PJwKbOJMeySPssbQs6CQBRw8Lk/K1MCfiDZKqxynIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302549; c=relaxed/simple;
	bh=lMiePj5BLeBwTfmhtOWVl7Nr+Y6PBZ2sXOR4c241KGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbCrWpCrFSVbGtu27NM/MJRW1KpnPMVS/iTlBKunNpgD4+K6WUDBwZuATAk87J7ztcN5RMRq01sd8tmE0HkBAySTKN0qKgD7kQsXM22Pr55E0XRUa1JLdIk6GFTf8QdxVjwX60wL4Do1b6HCpB7gMqI8ospkFbITk+dBN9P45o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2grWBHp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302548; x=1744838548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lMiePj5BLeBwTfmhtOWVl7Nr+Y6PBZ2sXOR4c241KGg=;
  b=c2grWBHphFzu8dLHdwda8IFFrj4zB33CD6ITQy3dc5bwmhqWD7NkpRnr
   kaL3iUrFv+FWUun2HOlelCUp4UyMXmGKTukZ3/9BEDYLOjSVmDVvyo69+
   +351YjfawEGhs0SQz1uaxt/F63f/LXNmVvSojkkxltvKV8GyJ7HN+B2Kh
   CTSLgN4/sglZd4qrriGLkOXZSuEX/vf7w0YvzqSwjNAJp0pjaHxUAoE93
   oBS3HypKJbzhjNS/n6OdzFRS5j8Z1ZK0kW+lRRqwJdIg5K9JjfvrQFEdO
   iuXBSvr8HGemCNOx5VzybcUchMqSZwiHDru3jclQBW+r8aU40BfL4S7Ah
   A==;
X-CSE-ConnectionGUID: hiUS/5l8RsanD8We2gDT4Q==
X-CSE-MsgGUID: TsPSvvbnQ4KmaGw28c9PeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234933"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:28 -0700
X-CSE-ConnectionGUID: SytoHrbhQzOyMrJKIVRlJw==
X-CSE-MsgGUID: 9f4soZjFRB2LnYC4Dk+1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267121"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:27 -0700
From: Tony Luck <tony.luck@intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 56/74] x86/cpu/vfm: Update drivers/platform/x86/intel/pmc/core.c
Date: Tue, 16 Apr 2024 14:22:26 -0700
Message-ID: <20240416212226.9719-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/pmc/core.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10c96c1a850a..054a56532e23 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1255,29 +1255,29 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		spt_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		cnp_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_l_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		arl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,         lnl_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		spt_core_init),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		spt_core_init),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	cnp_core_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		icl_core_init),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	icl_core_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		cnp_core_init),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	cnp_core_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		tgl_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	icl_core_init),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		tgl_core_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		adl_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	tgl_l_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		adl_core_init),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
 	{}
 };
 
-- 
2.44.0


