Return-Path: <linux-kernel+bounces-164458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B18B7DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D61F28D48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940E1C8FBD;
	Tue, 30 Apr 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNxnJj8m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F01C2333
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495910; cv=none; b=cNqEC7eXJA589QN6JoxeT1Z9EWto54BnF4jCcT/fFQn+zEz/eRHZzQC0mLpIJZw6HeYVzyHJIKOy5KZP5G8tjFYG2iFm4R50m1TokcBqoy/V00sUJUI89calo07g1Bfh4fFhWtKdyoHKCLzV4bwbqanKVaFux/jGuCVfuxPfcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495910; c=relaxed/simple;
	bh=iSDmP+MytJ7eLJmAn34fXLBZm0qQmXA1YWZNK0YVPgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGfnOGU77wT4a6b0v+lH64WbiNN7j5Wd1sgB3Xe96tVEyyk0dvUM8ZbXDbY5nMjOOSQVC9N4KFGaDRdmdn3Lpj4M05NtxmL9Z+zSuAmdBt3qJFySbgGk3VN/9B/XPiFdq0qhheNqqZ/b3vMjAmwtbOASwx9rzHAPHY3qKD8pmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNxnJj8m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495909; x=1746031909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSDmP+MytJ7eLJmAn34fXLBZm0qQmXA1YWZNK0YVPgs=;
  b=ZNxnJj8mDpeOSyS7KNiEnuXT7M4wwZ5PQXz2iZEYYzm6kB8DVKkZ/KNk
   Kvqp6irJEXwCa3xhYWAqs9H7CuNJolDpYmnK3WEuxJeCwZL1QbAoz3rIe
   +P7k3iyNFyQFnLocpFr9vyqByRr7QJQMKOxA5FpT8qN9cHeqdY+YE19PA
   Gz6mF+WFl3jcFVKd5yTBHUueB7HI8Ok2Rzw2cK1+bF1DwtqP+P4ckknrQ
   rIgQahPaAeuZj9H+RfKLsKQSJCX4PmSOAWkgSmUl6PMB++LPq9xPKGSZv
   9woUenAjCkHLDQKlN4u8xmK30LpZ9lEKrnf+HaLKK2OBPbb3VSzA7VprX
   Q==;
X-CSE-ConnectionGUID: ta3ktkekTqSLMugqMNg7+g==
X-CSE-MsgGUID: bXuPgsrNTYSXgOLF92m/GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075785"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075785"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:23 -0700
X-CSE-ConnectionGUID: PSw1h8I9TtS6017p4wSaLA==
X-CSE-MsgGUID: fKBdME2VTEGjvJ5j/ORw6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515498"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 31/47] x86/cpu: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:44 -0700
Message-ID: <20240430165100.73491-31-tony.luck@intel.com>
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

Update INTEL_CPU_DESC() to work with vendor/family/model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu_device_id.h |  8 ++--
 arch/x86/events/intel/core.c         | 64 ++++++++++++++--------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 970a232009c3..cac33812c609 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -275,10 +275,10 @@ struct x86_cpu_desc {
 	u32	x86_microcode_rev;
 };
 
-#define INTEL_CPU_DESC(model, stepping, revision) {		\
-	.x86_family		= 6,				\
-	.x86_vendor		= X86_VENDOR_INTEL,		\
-	.x86_model		= (model),			\
+#define INTEL_CPU_DESC(vfm, stepping, revision) {		\
+	.x86_family		= VFM_FAMILY(vfm),		\
+	.x86_vendor		= VFM_VENDOR(vfm),		\
+	.x86_model		= VFM_MODEL(vfm),		\
 	.x86_stepping		= (stepping),			\
 	.x86_microcode_rev	= (revision),			\
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 94206f8cd371..d3294ef18aef 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5187,35 +5187,35 @@ static __init void intel_clovertown_quirk(void)
 }
 
 static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_G,		 1, 0x00000015),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
-	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_G,		 1, 0x00000014),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 2, 0x00000010),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 3, 0x07000009),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 4, 0x0f000009),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 1, 0x0b000014),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 5, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 6, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 7, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		11, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_L,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_L,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		13, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_HASWELL,		 3, 0x0000001f),
+	INTEL_CPU_DESC(INTEL_HASWELL_L,		 1, 0x0000001e),
+	INTEL_CPU_DESC(INTEL_HASWELL_G,		 1, 0x00000015),
+	INTEL_CPU_DESC(INTEL_HASWELL_X,		 2, 0x00000037),
+	INTEL_CPU_DESC(INTEL_HASWELL_X,		 4, 0x0000000a),
+	INTEL_CPU_DESC(INTEL_BROADWELL,		 4, 0x00000023),
+	INTEL_CPU_DESC(INTEL_BROADWELL_G,	 1, 0x00000014),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 2, 0x00000010),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 3, 0x07000009),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 4, 0x0f000009),
+	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 5, 0x0e000002),
+	INTEL_CPU_DESC(INTEL_BROADWELL_X,	 1, 0x0b000014),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 3, 0x00000021),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 4, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 5, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 6, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 7, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		11, 0x00000000),
+	INTEL_CPU_DESC(INTEL_SKYLAKE_L,		 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_SKYLAKE,		 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_KABYLAKE,		13, 0x0000004e),
 	{}
 };
 
@@ -5232,9 +5232,9 @@ static __init void intel_pebs_isolation_quirk(void)
 }
 
 static const struct x86_cpu_desc pebs_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE,		7, 0x00000028),
-	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	6, 0x00000618),
-	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	7, 0x0000070c),
+	INTEL_CPU_DESC(INTEL_SANDYBRIDGE,	7, 0x00000028),
+	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
+	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
 	{}
 };
 
-- 
2.44.0


