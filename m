Return-Path: <linux-kernel+bounces-147611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D68A7684
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A0C1F21988
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD814C584;
	Tue, 16 Apr 2024 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AG9OwzL/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFC14A62B;
	Tue, 16 Apr 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302536; cv=none; b=C77NUpQif9PGWFrTcWd6+gGqepHyAFENl7JdYwbBiYQfiI7OY/G+yTYUrsETLAZJvkhOStZP/acUx5Y7yzm2E4u2NMGDfzRwN7rKgVSXW2OcTNNuD+6JS0a4Plb0DLv2nZiyWecLciUyxL7QGZL9oZHz2jXJqdXkw6xQwgyfiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302536; c=relaxed/simple;
	bh=WV3qnx6+50b42Jf/GqLJUpAXvV6x1yHw3SQJ/gD5Xpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2xrxsflVXBJ2qzqdsPpQfiRZfLEhM8Oqzkjl+GWuGI/ADY7hOgO7IptmzqyBJgh+EHc1nh7ahEFPNI+jlXGND0QAeyGdmNCz2yoN4Il9senOPjN3v8h0JiV0EvSiRDgc4oVPIH/lMygszB0Vl66EoBFLE7mj4+tLFldLjgfTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AG9OwzL/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302535; x=1744838535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WV3qnx6+50b42Jf/GqLJUpAXvV6x1yHw3SQJ/gD5Xpk=;
  b=AG9OwzL/IGdBiRPs3k94jplQTII21/j7zyev7TsfpoAsUmALxXrl3iCl
   LA0lmoNDOcstlk7MXDM+gU/h/+TQcHN42jZItZrjy1tyKWJxRBvmm3Ovo
   8sIrUPK4bSd2xgQs+PHVrBu5wljINFpqlxETm4GTqDuIAcj+AoKGkZa93
   Q9pj0WYoRfltqeRJObs9i/MZ8tnkv3vK1sZHy97TwA/WMpCOWSeu9xAtw
   idZbahJvKDovSS5JBCDj9GoTpJVXDxm3XR97QzqqgVWWzxJDV5PcnCCVv
   XOeE5d2Wx1TrBWjuH6r+PtMHg4yM+JCVD+41T0KPFy4qTCfkMm02rn+nz
   w==;
X-CSE-ConnectionGUID: XadBR0vDTc6gjCHexsYSgA==
X-CSE-MsgGUID: 325MtwwjQ3GksKpC5u5AjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234898"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234898"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:15 -0700
X-CSE-ConnectionGUID: rEikiT2HSWuwA6Nm64yzNA==
X-CSE-MsgGUID: j5VILjF3Q42S4TskNU+j6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267075"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:14 -0700
From: Tony Luck <tony.luck@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 48/74] x86/cpu/vfm: Update drivers/edac/skx_base.c
Date: Tue, 16 Apr 2024 14:22:13 -0700
Message-ID: <20240416212213.9567-1-tony.luck@intel.com>
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


