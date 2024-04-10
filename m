Return-Path: <linux-kernel+bounces-138523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EBA89F296
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459CCB24DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBD15D5AB;
	Wed, 10 Apr 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fseM5cRc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49715B562;
	Wed, 10 Apr 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753173; cv=none; b=itQdzBai1KBGw5wgFhvaREwCAkY5v4+q0O01AG6C5AyrpmxpFHECmsfjttrGuiYsxPpV+eH671M3vs0ErKkIvqErPDX5R+FRzUjnSXaLb0gJS/n0A7jggINEWO8MZwVhexxRVAoEP1rpA7dw3Hg6DQ8BLvRK+YHUniu4zo2E63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753173; c=relaxed/simple;
	bh=5sQHADXLkIIMbLFoVKLPfpa7qaAIVHxpySa1ePAhRI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwHiCmJmcBUSpJMp/JUXbgej6++iISbgFd7ALaBxjdizML7q9rdN40mtVZvRvSgsyI/FtrCwdllvK22SXyD/lZCxe7he+64zLdVSB21yhfMXTA/+tppAtngEA8Dq3Wr90NJeNlPfMUSFHKm+6Fk+5Bkw58A/EG53pbs+7o+uQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fseM5cRc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712753172; x=1744289172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sQHADXLkIIMbLFoVKLPfpa7qaAIVHxpySa1ePAhRI8=;
  b=fseM5cRcTu5JQwSr0ckK0LjvWRug7kAx6FLG9A+UZw1Gel637Ob/8mM6
   XK7xxJLG798lSoWLLbS/2FN5FQurU9IrgZw/EIrDFmds9z4/B5lZhomH+
   AmPRE1mLPjq5Nw78zGl+uGAbp0l801vmjPHQOWxfj/Uw8hT06KwUYvg2q
   gfW3Bm303svdkMj5gXZZ1jXCOmuYx6rQyOyx7Vh4y3e249629ZxzTDHrO
   NPyuDJnIDtN30/dlivA9WuMNouU7wseoabY0SP+/AdMzBoaPrGd/v2P+R
   +CQ19yWbwcPpB+Z2CiEJUDkCq+EsUNdZOoi1BpSgvPwehyWbARZkSFLMq
   w==;
X-CSE-ConnectionGUID: Nr7UnPlURX2mjY3jS3yq+A==
X-CSE-MsgGUID: EFOgjwqOSq+X1pm/VHDHYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7968074"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7968074"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:46:12 -0700
X-CSE-ConnectionGUID: 1uwoZZlsRkiOoMbuFuLk0Q==
X-CSE-MsgGUID: 7qG8WBj5TtSDOx7Te1CvHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51520016"
Received: from lshi12-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.30.130])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:46:08 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH 2/2] perf/x86/rapl: Add support for Intel Lunar Lake
Date: Wed, 10 Apr 2024 20:45:54 +0800
Message-Id: <20240410124554.448987-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410124554.448987-1-rui.zhang@intel.com>
References: <20240410124554.448987-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lunar Lake RAPL support is the same as previous Sky Lake.
Add Lunar Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6bfb78d5b37e..ebb67a243f0f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -810,6 +810,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.34.1


