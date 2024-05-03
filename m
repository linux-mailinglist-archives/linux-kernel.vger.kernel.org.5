Return-Path: <linux-kernel+bounces-168186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011858BB4E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DC0B24403
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C141405FB;
	Fri,  3 May 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HalZOfZu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F1266D4
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768419; cv=none; b=M03kBvZvpLlbpsDrWDP/v/NwR2qG+TqosEr6KoU5WliW4XzA7BJdIprqYvTcCR2PAQCY8Ee5UY+2nsqlymR+ah0dkA5NTrzjQFl65tHdHny+M6xM8cEYr/YqplF+kSPfLdO2suIsXH+HYUphrxTNdy8p6dEs1VEGsm+90Hg5RxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768419; c=relaxed/simple;
	bh=L/DVqE53VmBOp8H/5zpv2eGbQKaWYwGvHxBLFSq2aW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGxxtDrcrBhtat0YO07r2ZoRaT+eVwWquJ8fgCDi/b4HNuhb43AMyoTQET8+pevYlhLJSDWlPlFSwmccqGDPbsx0aoeOaWN3uFLVOxPJzqOEK72yB2FkQ+zUA55yw0JJJb+N/spdCd/l0Rwoxki3aXWxJpIE7H25frq0SE4m1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HalZOfZu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768419; x=1746304419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/DVqE53VmBOp8H/5zpv2eGbQKaWYwGvHxBLFSq2aW8=;
  b=HalZOfZu1CUSvGy5J8OaBF7Nl31dJuoX+KAugsR2HihVgLCKnTPExKty
   FEGCFK+umoVsB8EP3Tune1C0DO2efnn1MBEulsPaGuxyxBf6K8ET5DTG8
   BealQJnTFR7Ggmzdlv89fNIg4jNGbl5Iq0TUyPlPfYx1D8gDMsE6P2PT/
   9xfJYPyD9z8FUP3JjQ6JZ7FDrYwvsfidTL1rHDlOSKfzWQ553IvdktRTl
   2d6TNN1PqYt68/nVwRD2Fk6Z0XnTxzvh/w6fnxju/lHHQ+qvULwr5Npu+
   gSCUOtGaPKXZRF7VpgdhzHiVp/xgYx5bdRX0yqUybV+ixhCpU3Az2kNQ8
   w==;
X-CSE-ConnectionGUID: zh/vje9xTW+ORKMI+boRlg==
X-CSE-MsgGUID: szmb7NUEQHCSyOAJKgzJdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21274293"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21274293"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:36 -0700
X-CSE-ConnectionGUID: N+9Grv6GRs2kiKsZnPdf4w==
X-CSE-MsgGUID: S7crYviRSyi/dufDhhxsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27431818"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v17 5/9] x86/resctrl: Add node-scope to the options for feature scope
Date: Fri,  3 May 2024 13:33:21 -0700
Message-ID: <20240503203325.21512-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503203325.21512-1-tony.luck@intel.com>
References: <20240503203325.21512-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently supported resctrl features are all domain scoped the same as the
scope of the L2 or L3 caches.

Add RESCTRL_NODE as a new option for features that are scoped at the
same granularity as NUMA nodes. This is needed for Intel's Sub-NUMA
Cluster (SNC) feature where monitoring features are node scoped.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            | 1 +
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index aa2c22a8e37b..5c7775343c3e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -176,6 +176,7 @@ struct resctrl_schema;
 enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
+	RESCTRL_NODE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cd58c9d4710f..c34ce367c456 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -510,6 +510,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	case RESCTRL_L2_CACHE:
 	case RESCTRL_L3_CACHE:
 		return get_cpu_cacheinfo_id(cpu, scope);
+	case RESCTRL_NODE:
+		return cpu_to_node(cpu);
 	default:
 		break;
 	}
-- 
2.44.0


