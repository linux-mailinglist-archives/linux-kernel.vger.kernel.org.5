Return-Path: <linux-kernel+bounces-151084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF518AA8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B478F1F223DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A693E49C;
	Fri, 19 Apr 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZuKtkSW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1182F5A;
	Fri, 19 Apr 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510634; cv=none; b=jnRDiVp3S8qQLZvByijuZDPBMCqeOAQWcYiWn2E7hg6DOqgIRxJDZBEK0Z1U8Pl0lKxpop8Ge4Cv51QvTCcQ/K72WSlu/zZUTwy82Sg6VSRmx/CNBSV2G8GKey0awbapZCx9vVdMWcGdw7/zrAO/2wcqpVkC+uVmynlUAwDvtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510634; c=relaxed/simple;
	bh=Kqn7LNaN5JHoWAHbn+aM97vUX0p0GiFCyO+Q9MrQ76k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QzaG61P5vWCECTJWGtUiY5wD2TmDUQAieaDIYkWJxfm5by2jE9nGcACSuQF/tp3vhsOWZJwvkyy/ekhEqN/H+Iak3PSxIXxJQJLcHQ4ocm7tsgfv1pGs9DGI9+VgxBAC4Q+80JbIrBqeDW0w8J8WKtHmeucHiCdGNXsQqcJCJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZuKtkSW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713510633; x=1745046633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kqn7LNaN5JHoWAHbn+aM97vUX0p0GiFCyO+Q9MrQ76k=;
  b=WZuKtkSWuncy1f9aWnpNHwn+sNoVU0zXtbCN+LvSx4fwlccZDSY9YajJ
   +W4+iabxEyPc+3U/2sCW8lknKIlECrR8DeIyBvOj6DQaI6lkpWXyH562s
   DifpWWlK24+cErIwfDOwWiMHudWssW4gE6Am0OzNBKanchm8ztgjWXfLM
   wcbeg1SrMFmQWgpN2CgEbz4mnxPli91x6MpbGvbw2S0Ay9iFJXixH3JY6
   kBj2WcSTsqIMb0Tapazgxj5UjsHKCrfSR6R3Iq+cDGNxJrOueZTWqUgS+
   HDePBPLJ2fD+8GvOb13b5NpGH18zBrsyl2InQCoSpkbmT6oXKHzHZJr9K
   A==;
X-CSE-ConnectionGUID: H2Viq3FkQnCL7EEBECWOUg==
X-CSE-MsgGUID: HfmShP1HSnmUUixg3EKRjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26611854"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="26611854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:10:31 -0700
X-CSE-ConnectionGUID: a5B9ZiWgTmGGIRbVtofWkw==
X-CSE-MsgGUID: orzIaouMSdaYjc/egMLKOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54451860"
Received: from lxia1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:10:27 -0700
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
Subject: [PATCH 1/3] perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake
Date: Fri, 19 Apr 2024 15:10:17 +0800
Message-Id: <20240419071019.1103953-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spec changes after the patch submitted and PC7/PC9 are removed from
Alderlake and later client platforms.

Remove PC7/PC9 support in cstate PMU.

Fixes: d0ca946bcf84 ("perf/x86/cstate: Add Alder Lake CPU support")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 326c8cd5aa2d..b304430ba64a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -81,7 +81,7 @@
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL,ADL,RPL,MTL
+ *						KBL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
@@ -90,8 +90,7 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL,MTL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
@@ -642,9 +641,7 @@ static const struct cstate_model adl_cstates __initconst = {
 	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
 				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
-				  BIT(PERF_CSTATE_PKG_C7_RES) |
 				  BIT(PERF_CSTATE_PKG_C8_RES) |
-				  BIT(PERF_CSTATE_PKG_C9_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
-- 
2.34.1


