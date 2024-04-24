Return-Path: <linux-kernel+bounces-157501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CCB8B122C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B51E1F219CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3E1C232D;
	Wed, 24 Apr 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgpnTUTc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD511C0DD1;
	Wed, 24 Apr 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982535; cv=none; b=aWi0zQ8qlWRe/W+vdp7pkCRLdmdTMM4VghF9YKkDxVnkGO/8FuJ+NvgiImXo/GvtZTpFY55nwuFpHoKGsDBdcrw2a35FSBp3cNKwnQazDZEGvN8x/F2YOqF9G0pS/Hnm4wYxlT/ykCC3cTM/jSSlLO5H2653sHPnvOLa3ntDIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982535; c=relaxed/simple;
	bh=WV3qnx6+50b42Jf/GqLJUpAXvV6x1yHw3SQJ/gD5Xpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoocJeqbLTxEpljHCMu20IuuIeyig5kKMVmDwz/Gp5iDGrobPRSfg/XItD/W6FtRNRl7cgNHy6ZGnrOGr7jweNdkoE27PQjUcEo9fi3M+m183Tvrc2bOrUVlj+pgrYUdLYoLBR43dr+ZasZOy+uWQuRlS8bDTck2pgQerI2kY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgpnTUTc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982534; x=1745518534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WV3qnx6+50b42Jf/GqLJUpAXvV6x1yHw3SQJ/gD5Xpk=;
  b=NgpnTUTcFCFSh1wJucmzh/BQFCSoG/YEJGj0ieJdH2J7x9CVVkq1K8L3
   17LBVlZ41rj1E4F5m3FPvKgM/QUqQz7PG5eUHm7/VY/AV2hB9iZPgEUMF
   xPJNhMAjE15llGlVoQS9U3vDZ0+mcCfh3ErDN6WYRTGEsRN1wUL37Ydec
   bBkk43u1l2YsLqsrDtbWK8Zh5L2ruYvmHoJWbgDwoQFjuL3Es+f5QzkqR
   RJVZf1UJ3hnURCS81GvVrdf1rVfxstcR8H8l8DkAXGxck8XLI3TE4S6vK
   oWQ++D+dWpMdodXWcdR85Jf30CuI8gWP+6m5Eqt/9PEdDIcHsGpEErl8/
   A==;
X-CSE-ConnectionGUID: OpOERJQmSc2CGmdAH+xT0g==
X-CSE-MsgGUID: 1e+/rAqxQDSHuVz2Wg7Ymg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503637"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503637"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:32 -0700
X-CSE-ConnectionGUID: /kp9bVCaR8upNewIGuN+zQ==
X-CSE-MsgGUID: YH0aH2rbSli9v2tjJwTT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750205"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:32 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 52/71] EDAC/skx: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:31 -0700
Message-ID: <20240424181531.42159-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
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
 drivers/edac/skx_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 0a862336a7ce..af3fa807acdb 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -164,7 +164,7 @@ static struct res_config skx_cfg = {
 };
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
-- 
2.44.0


