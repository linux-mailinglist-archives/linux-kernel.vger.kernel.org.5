Return-Path: <linux-kernel+bounces-147574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32148A764D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FFF1F21FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4C13BC2A;
	Tue, 16 Apr 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iV2QxvFa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72713792A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302406; cv=none; b=SPLW/+GWZZwlFdkYkkIagGbtmfKiNhD+RnF++PKjFgfdvmq+uQse97gquqGJ5oOsYiKYbOAj2WYF03BRPuAYLFIn9RGJQsiHHCoFvHVSwKIs99OJR6IQ0NbUJlFX2QTJrQahH1tcW/uDJP/9+c0orzAnh8Df4OTni/zD6/Gfw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302406; c=relaxed/simple;
	bh=9rMjpqoCOgRty8mRKqjOBHEBAP+bItOsOB0U8/8T0P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL2FZMLkO297kb6kBvGf6qZKbN68/sJnPbh2L4ZkLcTHkw4P6dcsry4RhJTQhFB4LyBgLumKnYv0d6aORirEhJd1qL3lP5V5Z9LVcnj6jwyd7pTIXR9erNHED7GMenbm+ldIrn7WGPwaUgnL0rD9NVWSitrDa+qZXDT1jZ7ClsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iV2QxvFa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302405; x=1744838405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rMjpqoCOgRty8mRKqjOBHEBAP+bItOsOB0U8/8T0P4=;
  b=iV2QxvFapwmZUwPaX95tOlW7ckBP553azep7pymHT31vZ6+vstkHZKFP
   0xWLKpLRD0LUk74eTZ7ZSKfBaB2U1ILN8K1pK/qGOwXsSIJx2RA4PdQeP
   ygf32q3RVMXd/m1X+nyaydh/tT6fWjqx299fIFpUKSfP8B134Gq1RYvC5
   v+rbrvBtiD26CZ6t9F6BAVjV3BL8My+to7c3o8U3pYBnNLd7qYn8LBvMa
   S11Fn4klFVcnegoECa0NpPo7M92FDcU7lcVG6lb6LIsTY/1QxQL+LY2D4
   GDC8lFiYX5PXLT7Vyd2Bo7tHQpCzxqqMp1paDikhe9hNEA0eiSDBILNBT
   Q==;
X-CSE-ConnectionGUID: iwB49Z5KS5C8FkumH/IhKw==
X-CSE-MsgGUID: VO/wbKMQSMailo7iJwvNyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914731"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914731"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:59 -0700
X-CSE-ConnectionGUID: YUK96iGlSaKHEjtCOTElvQ==
X-CSE-MsgGUID: ta7dmJMkQ2y2WixUX0MqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871926"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 15/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/aperfmperf.c
Date: Tue, 16 Apr 2024 14:19:17 -0700
Message-ID: <20240416211941.9369-16-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/aperfmperf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index fdbb5f07448f..f9a8c7b7943f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -124,25 +124,24 @@ static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#define X86_MATCH(model)					\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
-		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
+#define X86_MATCH(vfm)						\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_APERFMPERF, NULL)
 
 static const struct x86_cpu_id has_knl_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(XEON_PHI_KNL),
-	X86_MATCH(XEON_PHI_KNM),
+	X86_MATCH(INTEL_XEON_PHI_KNL),
+	X86_MATCH(INTEL_XEON_PHI_KNM),
 	{}
 };
 
 static const struct x86_cpu_id has_skx_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(SKYLAKE_X),
+	X86_MATCH(INTEL_SKYLAKE_X),
 	{}
 };
 
 static const struct x86_cpu_id has_glm_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(ATOM_GOLDMONT),
-	X86_MATCH(ATOM_GOLDMONT_D),
-	X86_MATCH(ATOM_GOLDMONT_PLUS),
+	X86_MATCH(INTEL_ATOM_GOLDMONT),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_D),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_PLUS),
 	{}
 };
 
-- 
2.44.0


