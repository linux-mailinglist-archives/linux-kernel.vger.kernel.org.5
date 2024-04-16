Return-Path: <linux-kernel+bounces-147617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED608A7690
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8191C20F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB1152DFD;
	Tue, 16 Apr 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2otpApf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CF152DF7;
	Tue, 16 Apr 2024 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302545; cv=none; b=kHBpdy35l+qxLVyUoxfrQtIsHkwYX1hcPOZTAEV3tUPTBqQ4SeNv5T3ylo75h0UDZZa3dgKFP7gK8wQ72hxoUsESHh+iL6TWHW8/qurCUcIBJm0hBKlp/80LaIzIocTmIuLreFyEhn773nOTSLGjrkAMgY6NLdrRExInvcx8O6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302545; c=relaxed/simple;
	bh=GAJ4tXjEN7lQ2UunRHqVUyKqhAXnTvHjZyO58Eg7pVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYpSqquzL/gUwBidLU56M20P0yJVy+ZO52sDsBfBO7wcqozoEUck+2xANpkW0I4tRPxYI5dBfhGjNFEU6bWxTVgpbIcBhOp6HZcZztqhHsHdvhpdSX7/jG7UNDDRmU+7sSfsW0PqSbig/Kzbgm+klbFoI+/3NkK2ZJKG7ywm5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2otpApf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302545; x=1744838545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GAJ4tXjEN7lQ2UunRHqVUyKqhAXnTvHjZyO58Eg7pVo=;
  b=j2otpApf2XSK1qo4zL48ao81F2uLo/xdUrXNNjH9Uj724vh1NfncuVHY
   h3X9rJ/etCyYMMWoG9abPS5nCi97gplwYtqX75HORCGJU7Zo8VJ7pzUsw
   ex45ADqfhCB2/dyabfx6SCdF4ea3a0cN8MPxkS2oNUMc3QYiLmp5RK7UP
   RjbPXZwDdIsQIbEQ6ZsDO0DPuKn7oi2ni2j0BPPwX4TLQ64jaV1ENcI6C
   2Y7vZGzJkaFhJ4vRXwTKCNd02E2mj4EDh2U+rQMq38IDqtDj5YsO/eR6V
   jqn+PMGiEX948Rg9Sop9osbmv4HDstZXW6Vv5t+DU5OcZDaBqGwlwo9jx
   A==;
X-CSE-ConnectionGUID: K7UAsONjS1S+cZC40rEP3Q==
X-CSE-MsgGUID: Pg8RHgEFQhGH2rtqybB/Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234927"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:25 -0700
X-CSE-ConnectionGUID: 8HuaCAnEQ2+bhEqnjgK5OA==
X-CSE-MsgGUID: lwRgnZ30SsGhA2NCoUwOSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267098"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:24 -0700
From: Tony Luck <tony.luck@intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 54/74] x86/cpu/vfm: Update drivers/platform/x86/intel/ifs/core.c
Date: Tue, 16 Apr 2024 14:22:23 -0700
Message-ID: <20240416212223.9681-1-tony.luck@intel.com>
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
 drivers/platform/x86/intel/ifs/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 7b11198d85a1..33412a584836 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -11,16 +11,15 @@
 
 #include "ifs.h"
 
-#define X86_MATCH(model, array_gen)				\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
-		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, array_gen)
+#define X86_MATCH(vfm, array_gen)				\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_CORE_CAPABILITIES, array_gen)
 
 static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
-	X86_MATCH(SAPPHIRERAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(EMERALDRAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(GRANITERAPIDS_X, ARRAY_GEN0),
-	X86_MATCH(GRANITERAPIDS_D, ARRAY_GEN0),
-	X86_MATCH(ATOM_CRESTMONT_X, ARRAY_GEN1),
+	X86_MATCH(INTEL_SAPPHIRERAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_EMERALDRAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_GRANITERAPIDS_X, ARRAY_GEN0),
+	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
+	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
-- 
2.44.0


