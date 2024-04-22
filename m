Return-Path: <linux-kernel+bounces-154040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CA8AD67C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FB4282651
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350F1CABD;
	Mon, 22 Apr 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQp/52cj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507618EA1;
	Mon, 22 Apr 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820972; cv=none; b=Dn8U2UNVOFc9e/n9QRiVmfVXVGSmt8uJ0uemJhzFEb5/TUmhnW5U8gyiSyld97BjmooaKiiGlWj8CL9y5dZWubXMcp4ak9TyWs6LaOR2l+zUB5oXkpL3ASEVH9bg2cSrViy7cNFMguSIvR5ZZ8ruhtv3vgDmICifvBXvOrScB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820972; c=relaxed/simple;
	bh=gcMnYjRxq49Z29IdyKaH3RkNtJ3qnwypqUjyitZsSV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aIWF3QhmyA+I7GAnVoIa7TNOunTsMStjjuc5dL4VJpnQKIzx3aupclBOWJ1/HFH54oURp+OwR9hiffPd+j8GhqJo2pPoLvBjeSwC6bhMv6J2oLVwYUoTR7e5Ugjntgkg0mJB207idQwrIb8HyQNcJTDl/O9/1/key1bxrUvIqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQp/52cj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713820971; x=1745356971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gcMnYjRxq49Z29IdyKaH3RkNtJ3qnwypqUjyitZsSV8=;
  b=BQp/52cjdcIig0AJTWrFfAU4yYWLuOfbGEU38KIAvx8FV4OJpuWTd3LP
   xRldBPpyYtA7gkF2Zfh9jqsE4tPMFEVPodlzKtImvoPzqddUKdgbJH+OO
   jZZYphzVc16elnmFeWUg4yaXOJuJIxOmRXD+nUVB/72qMl4fGApY0yU1d
   u5kV+pfZnFt/ZmQXJdgkFOI5D97PtDzYHxZJcisQSZPvS+EU12qVHoEJM
   8mJdqNjCvGJ+JQWORYkwOauKOYnqBr0V8MDmAZ4owtvQHhGkOlvOnK/Ln
   2GZTOHcBW7++gWDa8IEMGPEfhXpbvQGNTclkfk1ASWe/xj72SKNXnS9JH
   g==;
X-CSE-ConnectionGUID: pQu3l9kpSh+0DjnXWMPTjg==
X-CSE-MsgGUID: R7jSAwibQquKpibVeFu2Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20804895"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20804895"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:22:51 -0700
X-CSE-ConnectionGUID: a/QXbaJDQBiwUjj6yK7IOA==
X-CSE-MsgGUID: dmyoFCJ7SnqATSNVWWwdkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55356728"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa001.fm.intel.com with ESMTP; 22 Apr 2024 14:22:50 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	markgross@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Add Grand Ridge to HPM CPU list
Date: Mon, 22 Apr 2024 14:22:22 -0700
Message-Id: <20240422212222.3881606-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Grand Ridge (ATOM_CRESTMONT) to hpm_cpu_ids, so that MSR 0x54 can be
used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 30951f7131cd..1accdaaf282c 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -721,6 +721,7 @@ static struct miscdevice isst_if_char_driver = {
 static const struct x86_cpu_id hpm_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
 };
-- 
2.40.1


