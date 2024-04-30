Return-Path: <linux-kernel+bounces-164453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39038B7DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C961F28D45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C51C2327;
	Tue, 30 Apr 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZgXjPiK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845417BB16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495908; cv=none; b=oOjrZwStRR+vvy+P1Do3L+TRq2K2XGtZUYtAxYIE2SfxXmTl4OBUNNfu+fFV9kgvyAzlltBG1zrU2h+OW8y7bWXbe9ypNWE4icUzAYQsMLv6wryQtzxioHLW4DWarCz9s9jq3Reb9NR1kx2UOQRs9oqwo4LSDLsZUYVnVdhDG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495908; c=relaxed/simple;
	bh=J3/S5BDaJa8W6a3KT1KDi2bLZ8czh8Tc2c5pQvZ+hqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSMOP62/yoswCqTJbWjxVxYVrplQvFtAsE0+72jn2c+vJ/f0TIEZ9lrsPaxjcJyqeH2ssRLhXWXm984Y0URvGy3NByhPobU6DC8vUyvJVEanleYYkzx+mWX+vjh+5iVBDjMXpu7vn2NxtY5nN47kqxBGHvZH813kVRsARkWRQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZgXjPiK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495906; x=1746031906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3/S5BDaJa8W6a3KT1KDi2bLZ8czh8Tc2c5pQvZ+hqQ=;
  b=TZgXjPiKDXjd0D6XZIKomYYHxuH1oamErIyftWu9BPAB/gQYJ9njHDA3
   bybsaZDzCYwX3lhG/Db+YNF5kRygk6CzJwoDCPSmwCHOo8y1sx/abYAoU
   eKf0ZgegEjY7J837gYGJq1ktYFSntfJtLWwYP4C3J0r7qO6aqU1MwVDe1
   2BA4wDRQr5Bdl+jrzUPhBm9cZ7386NXy2ZgSfdpJb/SxgR/KPujeCHsK8
   ixEloD7Lc4oYFeNqtqFXDLDJJYvQz/GYkohpAWy63DtqEkrQGN/8loS1j
   qLjD7NMWkDHuX+LypY+/1lwdNHYETy3CHd7xQ3kilclprk5MHgFkOI25L
   Q==;
X-CSE-ConnectionGUID: jbzqpBZrQtWQmCdHR4SHVA==
X-CSE-MsgGUID: 2+UyARXFTU63+P/ih7xbbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075731"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075731"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:22 -0700
X-CSE-ConnectionGUID: 14aDnfPrS9WcC5YxWZUgnA==
X-CSE-MsgGUID: gyj4EATrS0OufzG26f4VAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515480"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 24/47] crypto: x86/poly1305 - Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:37 -0700
Message-ID: <20240430165100.73491-24-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
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
 arch/x86/crypto/poly1305_glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 1dfb8af48a3c..08ff4b489f7e 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 asmlinkage void poly1305_init_x86_64(void *ctx,
@@ -269,7 +269,7 @@ static int __init poly1305_simd_mod_init(void)
 	    boot_cpu_has(X86_FEATURE_AVX2) && boot_cpu_has(X86_FEATURE_AVX512F) &&
 	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512, NULL) &&
 	    /* Skylake downclocks unacceptably much when using zmm, but later generations are fast. */
-	    boot_cpu_data.x86_model != INTEL_FAM6_SKYLAKE_X)
+	    boot_cpu_data.x86_vfm != INTEL_SKYLAKE_X)
 		static_branch_enable(&poly1305_use_avx512);
 	return IS_REACHABLE(CONFIG_CRYPTO_HASH) ? crypto_register_shash(&alg) : 0;
 }
-- 
2.44.0


