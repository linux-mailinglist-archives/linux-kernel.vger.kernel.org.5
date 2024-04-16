Return-Path: <linux-kernel+bounces-147600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 095528A7669
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F096B23E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397531494C2;
	Tue, 16 Apr 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqS+TDp7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD314199C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302418; cv=none; b=C5nuF0jONg28X1xq1x+X80pGn/DMa7b3kZLptTtkSSqCFCy9XnGk9V6cFKu7sQK4zPsVVfaWnoTY7kGdBmgFUORhp8n+4qgtvHpN2NMQvD7Z7jlfP2o40y8NzCa+k5qrDb4z269uNOKxOoNexOpwc+O6Tp1INceJKRnN+OHgyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302418; c=relaxed/simple;
	bh=Zt4IxOPcAoeZhOMeI9zMvpasMGVesn87hcB0YKloDhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trY7TGDEuOU+32q8+Ad6rH/PCvhePuoVmxOrv5+oDfUFWOFRLP2o1IN1Us76ix/MV6livUwEIU32laUtCmTmvkptEDUR5QYCvtv+pl5QlSC9/ASOyyCOzh9ZzkrqQd/rbJIfFgHN8xTza2vK10sVDIb2Vyynrj6zDKAPSLKFRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LqS+TDp7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302415; x=1744838415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zt4IxOPcAoeZhOMeI9zMvpasMGVesn87hcB0YKloDhE=;
  b=LqS+TDp7IfEAf2h4/1xUXrffNqb8j42CP4Wwth5nZ0rFMyN7ZhPft8A4
   cYjU6thxP/ZHCX828g6ZZ3hnPc9KytsonhOQFPms9qj1HLPw6Dpttxbo/
   Hu/sOizA5d2MF9E/WjuorSiek2IFcUQxs26liJkwx85BLNPitbqipwt4z
   N1cZHZdBRbTsWuHANWZRjjbUj5o39hpxinbcsWLQhg6npcyGGqzATe+NW
   Kjp6WVRA3lZyyqqPc5gi17iosvPaKIJX0kcqtAG3DKMQOYgd7w6qkMTvX
   W9A/JjClg4jciz/IkUeeC9Y7Y2swBfT00nyUpWRZtF+k/nezSAw86FGpv
   g==;
X-CSE-ConnectionGUID: 3QzWX/TyTCyOaixw4PZ3Dg==
X-CSE-MsgGUID: 9hjtrCB0RKmlpd4IYS+UJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914848"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914848"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:03 -0700
X-CSE-ConnectionGUID: R9CXNqEjSoqw5Qk7cp7sxQ==
X-CSE-MsgGUID: 0iCZEHAtTOuDpj0zn+Gplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872069"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 38/74] x86/cpu/vfm: Update arch/x86/events/intel/core.c
Date: Tue, 16 Apr 2024 14:19:40 -0700
Message-ID: <20240416211941.9369-39-tony.luck@intel.com>
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

Update INTEL_CPU_DESC() to work with vendor/family/model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu_device_id.h |  8 ++--
 arch/x86/events/intel/core.c         | 64 ++++++++++++++--------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 833f230aeafc..71bda84c20c3 100644
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


