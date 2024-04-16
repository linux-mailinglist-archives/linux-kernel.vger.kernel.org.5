Return-Path: <linux-kernel+bounces-147593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A98A7662
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DC91C22ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1299144D07;
	Tue, 16 Apr 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1/RFlHL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64A13D2A9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302414; cv=none; b=JTbuF+yrpuVVTXfRISdvLMNGtUPP85tlfIeyxIldQabKB8GJQ52uTZYdAsLlie/AyhQEJT7AC19sK6juoWFwnbWCUs48ypScHWDp0+GKRkJOGeH+bxr0uxnE6Xr6NaOqB5Coml25FHDZvcibyReHlswrM2HDpoANWUoIceUhYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302414; c=relaxed/simple;
	bh=FfXHVVXxAXvXhf26U3fzvKJ4+8iaBCg597mpHe5hnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV7UXogO4+YFDOHOPcAwzbPfuaWqpADqBXffosBiH2yBAYdPkAp9UKpnzxUBYl5GKYzjjPd7C5INBlx5FS2p9UgPSTf0lamxx15/5IEhDNh+rja5KILiR1zLet3RBo2nhO9wIE+l9GgSy7jqK0pDw/GfUqaVfDNohYoNPKi+67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1/RFlHL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302413; x=1744838413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfXHVVXxAXvXhf26U3fzvKJ4+8iaBCg597mpHe5hnu0=;
  b=O1/RFlHLJvlg5PkxcoB8bUZHNu/XvZeo63dXXNwNU4xUjyAZKRxyCE81
   SXwSG1H9/HWxs51GnSsPUxpV3/E3niZfDYHwKb13sauB95dMG6ZqH6z+A
   6yyzXtyJ553A2bui4ry88eOii9V4ZA329xhhhKq5TbMhZwlbqKHdQGxKV
   UdKUQjW45V8DhIYPLyk51xSHXxfH1jSOwVyKon/kJZFpuxGi5xxEGahFi
   ps95lG02FJ6roE4MMt4Z6MUDrC8NffwDe8/fmy6uaXbpORgJDcjGoSS+r
   7BTYTwNIMWlQm2ogOROB5R6w8lwIMaxMcjW+i+SPjSHXr55pu7/EmFj4b
   A==;
X-CSE-ConnectionGUID: bwMvWqMDRiiZ5fzIFsJ53g==
X-CSE-MsgGUID: HxwY5bpOS2OjEV5oT7Hzwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914818"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914818"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
X-CSE-ConnectionGUID: Si1VIfi7S3G9qCcDXwEhNg==
X-CSE-MsgGUID: wokfdItaTSyixIfeJLTpdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872018"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 32/74] x86/cpu/vfm: Update arch/x86/mm/init.c
Date: Tue, 16 Apr 2024 14:19:34 -0700
Message-ID: <20240416211941.9369-33-tony.luck@intel.com>
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
 arch/x86/mm/init.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..fadc3fc3ee41 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,21 +261,17 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, 0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, 0),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, 0),
 	{}
 };
 
-- 
2.44.0


