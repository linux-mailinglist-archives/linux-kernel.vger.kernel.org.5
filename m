Return-Path: <linux-kernel+bounces-131588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1E8989C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24611F2E59C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3212AAE9;
	Thu,  4 Apr 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkObM7iO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A0129E8A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240292; cv=none; b=OXM/j6NERFGLy8o9f3YRzwOht/A8HtvPWVw1fMKdIeDZM/RE92BCqbzWDTsIQUQQiBv/DOpvxzX7QEEpO4EzCG6+m1sQ20Eirn2OpWV1FcNHj8XX5DW5Sn8dY7HNLOw8mio2QW82XLO1g/2XT2gPegM+VThVU8NzMyPLwk2QTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240292; c=relaxed/simple;
	bh=WyGBRp+4Ek1Eean8T0mP193ZzJ1ucRVfqIn46Xxik5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwAw0jjhgJB5t0ep5Hc4vEuUDXQsAf0dwBKVIDNGUf2V+LtABa2p2mf9NZkqlqSq+sCk4rob3fLSR3PYLFtnKbOZhtcoWITHU6i3Ek+bhdOHZF7ed5H5FYAlRCGHX51oETP8591eVFLvCZfxFrHacBIW5bifxINYAzO7Qhur3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkObM7iO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712240292; x=1743776292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WyGBRp+4Ek1Eean8T0mP193ZzJ1ucRVfqIn46Xxik5E=;
  b=nkObM7iO/+YAf0M9hIjBIz8SMSd7DJr3SjLQWHFF1knCPo3wLkL/VgsY
   O+7/uViwObYfT6vLFaU48xS1et+dDtoYsUNhKq4gZGL/itdrWYyvxcAtO
   8n+ChJLAjM2uMp0OBM1q7dER3glmT/U0rnkyEmM86XC4epRmXlgizgK9y
   mh24tLTyO8VVnItbqtqsKXwY7ouvdSzZv2KW2hE75KWdplIOGx/uK6KkV
   2JwJjE2KK078VpUBnN+wqIwLRSu2STrGH1G6+oYcOzCxUcAA0ygzsjzJO
   zV1Jyd3iG5pbg9d/65VLUAo9M9frkHVsn7MJl2LBDvocYHhY6lLiUq8Yw
   A==;
X-CSE-ConnectionGUID: /29ZGWJETeyE0nTVIXz8+g==
X-CSE-MsgGUID: IEzVLLs5SS6azSa6G993SA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7632436"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7632436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:18:10 -0700
X-CSE-ConnectionGUID: /nwTIp+TTm2h0SNFh2ORBA==
X-CSE-MsgGUID: KYFylQmHQvSGQtkiQZOAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23448366"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2024 07:18:08 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/intel/uncore: Use D0:F0 as a default device
Date: Thu,  4 Apr 2024 07:17:06 -0700
Message-Id: <20240404141706.1235531-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404141706.1235531-1-kan.liang@linux.intel.com>
References: <20240404141706.1235531-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenyu Wang <zhenyuw@linux.intel.com>

Some uncore PMON registers are located in the MMIO space of the Host
Bridge and DRAM Controller device, which is located at D0:F0 for
Tiger Lake and later client generation.

Use D0:F0 as a default device. So it doesn't need to keep adding the
complete Device ID list for each generation anymore.

Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 4cab1bf57602..8625d6d279c3 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1488,6 +1488,10 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 		ids++;
 	}
 
+	/* Just try to grab 00:00.0 device */
+	if (!mc_dev)
+		mc_dev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+
 	return mc_dev;
 }
 
-- 
2.35.1


