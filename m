Return-Path: <linux-kernel+bounces-147630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932EB8A76AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47311C21C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B5155356;
	Tue, 16 Apr 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tq6EbqcG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BA15534A;
	Tue, 16 Apr 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302568; cv=none; b=YpfjDf4aVX7CwLu4mbiqcVYd97MvY6bThKXsH8fQZ3X1qMExUO1lwrW0GIZF0kxi7fqlcnF+vzNYZXRNUAvDWGNdG96hCm+E8cZlnD36oH45HatEYL06qvvWGecDXDLprJx3K97n3zNju4jWIx16BuQoJg4katj5E6b778/BtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302568; c=relaxed/simple;
	bh=9BhqAi51AVfIYErDEjqL8B6KCNTQRdQRVBtL2GkhI2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMGCwcUs+IM/5a9CTzbGVGIvpcVwvTWQv4qGnSsVEI5zPmW+Ro3Br/HaXCtH5DUO10S6MgF/yYDVAggiyxD3iRYmY/CjjLUk4Jctpys62PodGc2CzjE6eKj7CAJzZrR/VyCw23g/TURnuIO4giFNd6qGIAt1LLTXStNn/n321f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tq6EbqcG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302567; x=1744838567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9BhqAi51AVfIYErDEjqL8B6KCNTQRdQRVBtL2GkhI2U=;
  b=Tq6EbqcGsz3llQn7GxvEfoBEDhXPDmigXN0DvCAVf7XXgUSEizzTHyhp
   Q6SkuYHCtJsrlqGEqrGFWif5xswZ6wa4wJ1OvfW4+Yam7ZHaWrH9KRPtm
   3CvqAs8BT8IXpHWsxuElreH740AEv9kg0xuTuqgERc5+BOGm3w1nalU6p
   BPgAvwL2uTCWWqjoZAJ/ChzvTNU+s7oUg6TRcVve0ahYWC3iJ9m4kcFWI
   ZLvGu5892d6Bt3Q28hqSRUdr6X26oejvSOOKy4A4uRZ8WDFceeehftWk5
   +X0IS+ZeC4ezDE3FyA2qOVAZL+glnOsPLG+iAdoZUMvOJF7h5N/0wvnx2
   Q==;
X-CSE-ConnectionGUID: /HXZlwP8Q0218hMgQPqxQQ==
X-CSE-MsgGUID: OswGd13kTpm5woMu0qme8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12548604"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12548604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:47 -0700
X-CSE-ConnectionGUID: 2t4VxFSIQX6wB24VKd16iw==
X-CSE-MsgGUID: AKYTwcstTs6rcaOYj/EZrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22453822"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:46 -0700
From: Tony Luck <tony.luck@intel.com>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 67/74] x86/cpu/vfm: Update drivers/powercap/intel_rapl_msr.c
Date: Tue, 16 Apr 2024 14:22:45 -0700
Message-ID: <20240416212245.9929-1-tony.luck@intel.com>
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
 drivers/powercap/intel_rapl_msr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 35cb152fa9aa..733a36f67fbc 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -139,14 +139,14 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
 	{}
 };
 
-- 
2.44.0


