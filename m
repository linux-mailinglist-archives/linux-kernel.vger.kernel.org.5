Return-Path: <linux-kernel+bounces-131589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56648989C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AB4B26220
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAE12AAF9;
	Thu,  4 Apr 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHrV4L4j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C1129E66
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240293; cv=none; b=VwMmehCyKChOJMWxSw49fA3WDPkjeMxi70rXM2a6hGxGrFMUPT6KeFMSkc1R6aT7Tfzwmq3+qFb/4Jetn/1TBGlOqudX/zfv33nwEQmbrvQdVh4+6TR94Tfc59T/UgD5WB0Ecz47acdClxRTyyz8tAqTrvOasZeTYCIHDIFI0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240293; c=relaxed/simple;
	bh=UfiWHQntsDELmxpRPZhQhCJyp7xGl/T/JwBE4GvxKho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y43KV9XmWw0FdbfqJzmrCqxjWxtkgbo0AYi3oJgNg/hiGI4Q9hEs+aF88kw4LAMTlzzk/GHC+HDSBSwSr5N0/duqOeIZK0fTykIISxkfyzqS4imNJZoZBd5qNrCL9r3r4uHlRqLMiKH7JyI2GzGjZ/YQjVYEVMzglkFmo6Ha/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHrV4L4j; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712240292; x=1743776292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfiWHQntsDELmxpRPZhQhCJyp7xGl/T/JwBE4GvxKho=;
  b=IHrV4L4jv7GlcORx6SkSXo+UPtPuARLtk20nUsrXJM+EhpdXonwD7oyu
   +ENM6iDDZXmMgHzhZHqeSmbH0eVhxCpxvdvNhQRlSS/b2OlfO5LrsY+p0
   fcYUCNcBwgmAPfZphNGZ5u5pwb51VY+thTkZIOHkQkBO1m6H/mwSORR2I
   chr4p2EXGP2frx5wJk+dYLGcb1wKi1Qk2MRxcmM3JSc6dlUoUXOPNC1ah
   uvOQkW8F5fMIOJ3OX2nf1ceSUnhrF6g5WnhAJdFAmmB+Zn3LNqevXHsds
   sLkURT4h1qDg0g8AoUgiNaqpVWY4X37Mbtg2FhaXwAhWkAdkPxn+dUhm4
   w==;
X-CSE-ConnectionGUID: WDJTDwP9TaCJaQQ/eS9cQQ==
X-CSE-MsgGUID: tRaMkDiFRfC2c38vtLCGyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7632431"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7632431"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:18:09 -0700
X-CSE-ConnectionGUID: PY3Ds2H5R7CHjzZfCzU4qg==
X-CSE-MsgGUID: EuzSERffSGKMSmCLV2Rc4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23448360"
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
Subject: [PATCH 3/4] perf/x86/intel/uncore: Add LNL uncore iMC freerunning support
Date: Thu,  4 Apr 2024 07:17:05 -0700
Message-Id: <20240404141706.1235531-4-kan.liang@linux.intel.com>
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

LNL uncore imc freerunning counters keep same as previous HW.

Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index d1605163f11e..4cab1bf57602 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1824,6 +1824,7 @@ static struct intel_uncore_type *lnl_mmio_uncores[] = {
 	&adl_uncore_imc,
 	&lnl_uncore_hbo,
 	&lnl_uncore_sncu,
+	&adl_uncore_imc_free_running,
 	NULL
 };
 
-- 
2.35.1


