Return-Path: <linux-kernel+bounces-138522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5D489F295
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A2C284932
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2FB15B545;
	Wed, 10 Apr 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQ2v6edF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B3158D6B;
	Wed, 10 Apr 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753170; cv=none; b=g4CSDRwD2e18rl7igT31I42XK8ctNburE+GX20B63bNaV5r75bf6/YQxlX8SF9uNdCgN0Ira764qHWXuzoa83tQVRa6MMuvspLzBkUxhCHS7KnLMpyFl1h1EeeaKTJCvIaGgc+A+dFhmPEP5a4qsaRt+p7mMpZq8Q32JDVA3eXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753170; c=relaxed/simple;
	bh=y88MBYlQ9Vn1GxCUH/pBqLSD46qh3QpyvM/4Oz5AzN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n20sw5URfLnDwmh8zi1WjJkQ99iCLIuQsKBxQ3ujo6Lag5KIEW7oOJ9DJ4LZEfXrTLLD7pwI3w6l6vJVmQ9ppbSgnV6pqLomalSlCEe2uFnzYMOEjUCo1huvq+VsKwV9qvV0mCiG3NoAAzk8hVsK1gQSttkObOPrgt9huSDzJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQ2v6edF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712753168; x=1744289168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y88MBYlQ9Vn1GxCUH/pBqLSD46qh3QpyvM/4Oz5AzN0=;
  b=kQ2v6edFXsNCBOcFKOg3d6fycHOwS/3lHKUwehIIkWVubh2Zb6HkSUKI
   UN+8NEvnIgiciGgcWQCg4q4TD5bmjf8VtH3YewqIy0m/wrdnECWB/s60m
   7N6l13WDkIalUgGF9f+c0396Kv3Oi6kT7MCPcKwiznq0QQa2Nrgix1hJ2
   kBx5DGecocdGREomg1Sl2WNqIdAwePN5xnTtWHqCsrAfhtizhnjo5Q6sZ
   AZUkh3G++K/tcO1nEVgIj2l2CNo9WDwVOxb0Y1AfLDIAbQC9G4TYwq19I
   S0YuVr4AFcYMN9L4k1U0F1XEj8c9QSvWbbebCisIdd1WJuboTaqI0tPeN
   g==;
X-CSE-ConnectionGUID: wlH4+A8ETJa0Y8BCQOqEbA==
X-CSE-MsgGUID: WP//m2Y/T9eVn7FlCci5RA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7968057"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7968057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:46:07 -0700
X-CSE-ConnectionGUID: xnH+AlkxQIySdeV9X2oaOg==
X-CSE-MsgGUID: zwecYDiaQt2ShG+9zT12RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51519981"
Received: from lshi12-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.30.130])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:46:03 -0700
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
Subject: [PATCH 1/2] perf/x86/rapl: Add support for Intel Arrow Lake
Date: Wed, 10 Apr 2024 20:45:53 +0800
Message-Id: <20240410124554.448987-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrow Lake RAPL support is the same as previous Sky Lake.
Add Arrow Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index fb2b1961e5a3..6bfb78d5b37e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -808,6 +808,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.34.1


