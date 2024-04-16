Return-Path: <linux-kernel+bounces-147564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBE8A7642
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7E1F237D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982B6EB5A;
	Tue, 16 Apr 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="machQB9/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDF6BB4B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302400; cv=none; b=YrEsmx5b4ORtXkUGrQREYJkTeqsKPr/ShZ3UxMCwucl6gFeOHvRGwHBAJRv5SkJF3x62ujQKckTkLSlHRN/ubs4FuTEB6GG0pgpV482oLFx8t44AEyLqySXF8KWdjuFOq2bIjfUcmk3weZJKetm56zP/f1RdxAuSpYcNwkBognA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302400; c=relaxed/simple;
	bh=AAxq3Dn0QuXe2vl7CnrIifkDHLAbXL8hnyPhGpmPU4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m04YWW+a7Alvy+q+R/kf1YEi27L0vuBGV/0TQzPCzvR16o4lPwNYeiVk7qXyaeU3kziyHWtE4ym/vHpNpq3dBDLqFQd58bgw8O+d7aACEKmbDnAZ6TwResKEwYOrvd1rYeAVWwXHkjgwa6jRAfNR8qNOdzrcLauZKLNu8ni5u0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=machQB9/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302400; x=1744838400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAxq3Dn0QuXe2vl7CnrIifkDHLAbXL8hnyPhGpmPU4g=;
  b=machQB9/kGMqfoXA0qXu7wioxaectU29Qk0NrgF6rFYLOnLK1VvBs4az
   v65ItCuxI6+CNcDJPlOhCfC247kQv2wAinI1T7HMJat6hfK2gc3vLd4fa
   YGb8pj/xNzhwEA7YpJPsVmhH6hEXu9+mdqHTD/L5s155C2KRsJwvCoNU9
   hr1z1dwQ0ZH6Hptp5x+ykTPx9u/MNuqbRzBzqBuXb4B6L2HUnqaea1Fip
   9Z5SLi+Z/vr4QcczbEZWlBU37ynxGiWDtgxKYbJnvFakhLkZEmGBtK4Bc
   Lx8LNvFrNbPJRWE3WBzqFZJ0tBkstkt1ePbOicrzOK4JTRYJpdi5CYxPR
   w==;
X-CSE-ConnectionGUID: zvx/EmShSwef3CktVEi4gQ==
X-CSE-MsgGUID: dz/A6AtPT3axC9IdiFqhIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914683"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
X-CSE-ConnectionGUID: lfmOZzp3QUakIJxXmm9qBg==
X-CSE-MsgGUID: OAv0MYosRCOYhnnAWgnwkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871883"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 04/74] x86/cpu/vfm: Update arch/x86/crypto/poly1305_glue.c
Date: Tue, 16 Apr 2024 14:19:06 -0700
Message-ID: <20240416211941.9369-5-tony.luck@intel.com>
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
 arch/x86/crypto/poly1305_glue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 1dfb8af48a3c..9738995080bc 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/simd.h>
 
@@ -269,7 +270,7 @@ static int __init poly1305_simd_mod_init(void)
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


