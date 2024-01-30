Return-Path: <linux-kernel+bounces-45383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF68842F85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318F51C22238
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45F71B39;
	Tue, 30 Jan 2024 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGmizMIL"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A214F61;
	Tue, 30 Jan 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653245; cv=none; b=npd/A6rzCGLGaQSD0kn+IOOML+P27XhH7DhrKyMbMfBZByYJFOmMpgtiKoooqD+sWLI2TwlHUdOje7aUxDWejHlWn84hZA00uccZ5i8oPEXQld2IqDF/nRLiNCnP8SgMeWKh8cbCFZotoZSgJNegvz5DTLMnDA9hORDpYWryocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653245; c=relaxed/simple;
	bh=Guvd+5pJ0YBYfgZsiLxWsFaZxzZmc/F6dpcN4WmiJN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvIv+xkXMV24ckQMJqTX3eiZQHkoZkRF2Htnp20R7uH/n6sBVzJlzcZWV816HkkmrBkqSlAXMIrdSPC4O6vsVdblH+fletQe96KCzUBgtevemM7/W0FjR3NjWkqVUK+zZHeBtM52G1/KC/CeeN5LBLFxNxjjWEjJBsxV0ckBEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGmizMIL; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706653244; x=1738189244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Guvd+5pJ0YBYfgZsiLxWsFaZxzZmc/F6dpcN4WmiJN4=;
  b=NGmizMILShvq+vq78Cz7loholRhv8bmubMPoGOGcJyya2OV2EjMprCWg
   9F3+u1V4WtMSFK9lB11ZXcHiGXmb3C6ZuOaB5uSgvuHVutbS9cIna72SD
   WfReg9XtRCFZN5jTlSrnvu8OaUoWuO4mDdtyuGnqn+/d3fPnF6FRfKsUi
   Z8ic+f+Dnb3T0kCVZJYPsEl+jZviwwtfkyHYD/zrtx72+cbQMmnk6oBhf
   8VJlund6Ta+teidvB0TVZtjgUDRJqG/BGBg/uQnoIvXW/36Q9i3YeSWXU
   abIOtlrzqkM2lbh+X26yCxyXPIxWNR6Q8thYRtg/vB2mp/pvIY+/zWWNM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403041696"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="403041696"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119412835"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119412835"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:42 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC) systems
Date: Tue, 30 Jan 2024 14:20:26 -0800
Message-ID: <20240130222034.37181-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223837.21835-1-tony.luck@intel.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the re-worked version of this series that I promised to post
yesterday. Check that e-mail for the arguments for this alternate
approach.

https://lore.kernel.org/all/ZbhLRDvZrxBZDv2j@agluck-desk3/

Apologies to Drew Fustini who I'd somehow dropped from later versions
of this series. Drew: you had made a comment at one point that having
different scopes within a single resource may be useful on RISC-V.
Version 14 included that, but it's gone here. Maybe multiple resctrl
"struct resource" for a single h/w entity like L3 as I'm doing in this
version could work for you too?

Patches 1-5 are almost completely rewritten based around the new
idea to give CMT and MBM their own "resource" instead of sharing
one with L3 CAT. This removes the need for separate domain lists,
and thus most of the churn of the previous version of this series.

Patches 6-8 are largely unchanged. But I removed all the Reviewed
and Tested tags since they are now built on a completely different
base.

Patches are against tip x86/cache:

  fc747eebef73 ("x86/resctrl: Remove redundant variable in mbm_config_write_domain()")

Re-work doesn't affect the v14 cover letter, so pasting it here:

The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
that share an L3 cache into two or more sets. This plays havoc with the
Resource Director Technology (RDT) monitoring features.  Prior to this
patch Intel has advised that SNC and RDT are incompatible.

Some of these CPU support an MSR that can partition the RMID counters in
the same way. This allows monitoring features to be used. With the caveat
that users must be aware that Linux may migrate tasks more frequently
between SNC nodes than between "regular" NUMA nodes, so reading counters
from all SNC nodes may be needed to get a complete picture of activity
for tasks.

Cache and memory bandwidth allocation features continue to operate at
the scope of the L3 cache.

Signed-off-by: Tony Luck <tony.luck@intel.com>

Tony Luck (8):
  x86/resctrl: Split the RDT_RESOURCE_L3 resource
  x86/resctrl: Move all monitoring functions to RDT_RESOURCE_L3_MON
  x86/resctrl: Prepare for non-cache-scoped resources
  x86/resctrl: Add helper function to look up domain_id from scope
  x86/resctrl: Add "NODE" as an option for resource scope
  x86/resctrl: Introduce snc_nodes_per_l3_cache
  x86/resctrl: Sub NUMA Cluster detection and enable
  x86/resctrl: Update documentation with Sub-NUMA cluster changes

 Documentation/arch/x86/resctrl.rst        |  25 ++-
 include/linux/resctrl.h                   |  10 +-
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |   3 +
 arch/x86/kernel/cpu/resctrl/core.c        | 181 +++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c     |  28 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   6 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  12 +-
 8 files changed, 236 insertions(+), 30 deletions(-)


base-commit: fc747eebef734563cf68a512f57937c8f231834a
-- 
2.43.0


