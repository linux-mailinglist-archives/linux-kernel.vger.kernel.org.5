Return-Path: <linux-kernel+bounces-164432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99398B7DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54AD28817D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029A1802CE;
	Tue, 30 Apr 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cByqTXih"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA817B4F7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495895; cv=none; b=g8cgv7igs6iFZKC1Bk+wsBYC4N08tCOOy5fojxYKwyspeb0UUfw02cnIK0eNrOx3D2ygyJre2QlJQ2ASbGFdbuLuNpFv9TJSXz65NeMgD+rzO9Sul1hlIkyMjtMHbwTgNGfX/NwXeq3bV6fsFDGBcYda4ulZBmc/w12c32jSbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495895; c=relaxed/simple;
	bh=DeoNg6vE2dUVTJ0VP57n/7LnvyNJiz2+PFZomKP9EJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuaTpr/MvnQTDQf78kJJQWdYLw63VGO0gmunJjZjCuFZ5Rm2uWEG/utw021+sYRywyXdXkPo5ig7Mb1TLNtQRDfjhJSRqTeO3cPlmBSRXJVzXtE9o+oeOIjveb3sZVTH7Zft5oQ4McX89gPS7oZBm0gQ69ej8bWtnyId16n4RIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cByqTXih; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495894; x=1746031894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeoNg6vE2dUVTJ0VP57n/7LnvyNJiz2+PFZomKP9EJU=;
  b=cByqTXih51oxk6CqxZ3+zy17fua8df+Mp7RacxtRkVhNuvP117CXPkFc
   hVNqmYTJ/jhugbEgMJv21H25ph10MHvPQKj8H6h9ychsYxu0TAGpsw8wK
   UHmxhpfgISJKx61HdDrbr4RuRwNeysXr2RSomtLlGZyxVIpcHuHqny5EO
   EzUsKPrAIyrzov4iESvA0flQvbgl3e5chGKYT/sOyDLVDkZshAuuLgZqh
   YJoBkP85RzPgZIwG3mN6LeOXxcXsjTkgX1jKUAnamazjevKRCJndTnxso
   hAfsRzfvFTXAIV99dZajO+Ncl+kPRPgjyZ73PGT/nq8Au0wY+OBdMi+Ci
   w==;
X-CSE-ConnectionGUID: 2cf6oYQlRX+CHVtTHx66mQ==
X-CSE-MsgGUID: llRwTsqyQmmAKqULhn80qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075616"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075616"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
X-CSE-ConnectionGUID: n/yqzZ3GS+SyJsc0nM/bng==
X-CSE-MsgGUID: qE3u1aXnQZ67KmhvfgNQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515422"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 08/47] cpufreq: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:21 -0700
Message-ID: <20240430165100.73491-8-tony.luck@intel.com>
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

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/speedstep-centrino.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 75b10ecdb60f..ddd6f53bfd2a 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,10 +520,10 @@ static struct cpufreq_driver centrino_driver = {
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6,  9), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6, 13), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  3), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  4), X86_FEATURE_EST, NULL),
 	{}
 };
 
-- 
2.44.0


