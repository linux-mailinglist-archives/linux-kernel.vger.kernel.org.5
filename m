Return-Path: <linux-kernel+bounces-147597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B98A7666
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348D92818B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8731482FE;
	Tue, 16 Apr 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpGD+XKh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C031411F0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302416; cv=none; b=a48mSht/glZCDGxsCkY6gSOQuS9sO9NWF+rayJAmKFiumfXU3VoGtdeGLLeEBlfhpvhvUiteDmxQKV8YDJRGmArkPa5b+FFCYCtM4U5uAiKNqg5+VsaMyf2oU1LNBrWVGmYKt3zAict8vbSu9tv0jHfd4mw0lwzCYBxyr9Mn32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302416; c=relaxed/simple;
	bh=KWWRdUU5f5jfluH+XjQDN6u50z+YdtCCFs2TFHrBnZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5E1ad84fZNme9artSF8cEYC3u+mxLY5ZBCIFr0lLVpfwaFux+kswD7jrNomwIGZSe9JUdROapENsPyon614e5+LL60FBfrMJapw2eahME0TNufE2Qlm9zC82zn91I7l9qghVz4o8EOWxFG28qwcCxadbFPqoiL83YNanfUyUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpGD+XKh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302415; x=1744838415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWWRdUU5f5jfluH+XjQDN6u50z+YdtCCFs2TFHrBnZg=;
  b=IpGD+XKhvd0plb5OMdIEPr9YQIZYiIDYFgtIo4ynPSUfAG+ICd945j43
   VQd5BGiECHbMxZKYnG19sgn0ePfQdE2W+9VOftL8ik6HC8kv8kooaDLNI
   UbdP3xP6vNPPjmgPrkDkfCyhEXuJFn6b6KTKWBZNP5mZZjGvEtWF8XkTN
   f8gqO6xtaR7jH27q50jd6S73MoTvoKIC44eGKnBI12kBSPtpYsCj7OzEE
   TG1FdzZ3YsKeJn9GM4WsYYgye5tt3eTDYTbwNI0zHzomCeDxeYwh6kNSj
   WPWUD+m7VvJlYvFJchy6OxkFQviyNaOc7/cqNzp+yj8BvXBl9aSaHaozr
   g==;
X-CSE-ConnectionGUID: ALIkecJQQVqVb1FC1Z/tFQ==
X-CSE-MsgGUID: bO9PoLZLTASzXDr7nr+bYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914843"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914843"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:03 -0700
X-CSE-ConnectionGUID: D6L1S+hoRXClavCCmEi41Q==
X-CSE-MsgGUID: ftUbrBCPSTaQEDOBp8BqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872059"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 37/74] x86/cpu/vfm: Update arch/x86/platform/atom/punit_atom_debug.c
Date: Tue, 16 Apr 2024 14:19:39 -0700
Message-ID: <20240416211941.9369-38-tony.luck@intel.com>
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
 arch/x86/platform/atom/punit_atom_debug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 6b9c6deca8ba..44c30ce6360a 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -165,14 +165,13 @@ static void punit_s2idle_check_register(struct punit_device *punit_device) {}
 static void punit_s2idle_check_unregister(void) {}
 #endif
 
-#define X86_MATCH(model, data)						 \
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_MWAIT, data)
+#define X86_MATCH(vfm, data)					 \
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_MWAIT, data)
 
 static const struct x86_cpu_id intel_punit_cpu_ids[] = {
-	X86_MATCH(ATOM_SILVERMONT,		&punit_device_byt),
-	X86_MATCH(ATOM_SILVERMONT_MID,		&punit_device_tng),
-	X86_MATCH(ATOM_AIRMONT,			&punit_device_cht),
+	X86_MATCH(INTEL_ATOM_SILVERMONT,	&punit_device_byt),
+	X86_MATCH(INTEL_ATOM_SILVERMONT_MID,	&punit_device_tng),
+	X86_MATCH(INTEL_ATOM_AIRMONT,		&punit_device_cht),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_punit_cpu_ids);
-- 
2.44.0


