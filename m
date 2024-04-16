Return-Path: <linux-kernel+bounces-147592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109608A7661
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DA51C22A19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DBF142919;
	Tue, 16 Apr 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KblMXtHf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF513CF9C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302413; cv=none; b=tJm+oKRYtQUW2XVzKAFYygNzEackon5mTeUEIBP2fbDqiz7LYAOW09w6EJJhIMKvWbtNUAoz+erRwBWWTZ9u46F1veN6aJ/PSDMMJPeIy7BpOMHRD9L/RrVgsF585wEtNwGIO9SfLjb9VkmKGd4n9/9oxap2N3pnO/CGbDJUUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302413; c=relaxed/simple;
	bh=jXmS4EM7r0+kvBUQwZF9aW8g88ra9fhGJ+GNpy2xvRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHRLZzepafUd4qcPc6tzdO6Jcv/mBPNUJrR9fz0PkJPH2ju0Y/JJTDUuJa8IQe18DBTRs+3LgUJ0ZiMbp00UEWVeLEZyfvxdyP96GKv6afd+lWuQjneAGj3iGDAkTCR1bxEoytFNXOUO1ssnYSBoJCfdku0ym+wOR6X6REK+vbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KblMXtHf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302412; x=1744838412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXmS4EM7r0+kvBUQwZF9aW8g88ra9fhGJ+GNpy2xvRo=;
  b=KblMXtHfAWlACWaet4PB8B+xQ9qtBP9zYjg08Brwm+uMMmYlcaUGZDUB
   rauYSC7rm4gQFs7H9+BMGfMU1Co/6knVCybfbKo0uLJYKMSxiYLRSfi9F
   rPbHGDsk3GCqoNEjNEhGzZ85dJAHAsK1Hm7ydEW+2dYq8WfRL1NhtNOT8
   BfBDi2noj8omVTfH44i2+p39o0vuyPJ7Y1S9shWepxXx7h57iH3E9JcK5
   J3X3MCGSvIr8ApDv5ACtf7sTzd+zri4ocoCTMftAJt1d7+KiHyduS8uOe
   4ji3L1IM2aS8yx/wKRU3h4gQuTS52112kr1nRbS+hUt5/W6DMhOuz4jYC
   g==;
X-CSE-ConnectionGUID: J1WbHP1GS7WCk3qnsjAydQ==
X-CSE-MsgGUID: 3v8cIdzDS42mQTm54Qcr3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914812"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914812"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
X-CSE-ConnectionGUID: YmLKKXS8Q+OVBrgG9Hcdmw==
X-CSE-MsgGUID: dQvrz27wSuOHxJq6KYgSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872010"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 31/74] x86/cpu/vfm: Update arch/x86/kvm/vmx/vmx.c
Date: Tue, 16 Apr 2024 14:19:33 -0700
Message-ID: <20240416211941.9369-32-tony.luck@intel.com>
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
 arch/x86/kvm/vmx/vmx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c37a89eda90f..2c747f2642c6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2518,17 +2518,15 @@ static bool cpu_has_sgx(void)
  */
 static bool cpu_has_perf_global_ctrl_bug(void)
 {
-	if (boot_cpu_data.x86 == 0x6) {
-		switch (boot_cpu_data.x86_model) {
-		case INTEL_FAM6_NEHALEM_EP:	/* AAK155 */
-		case INTEL_FAM6_NEHALEM:	/* AAP115 */
-		case INTEL_FAM6_WESTMERE:	/* AAT100 */
-		case INTEL_FAM6_WESTMERE_EP:	/* BC86,AAY89,BD102 */
-		case INTEL_FAM6_NEHALEM_EX:	/* BA97 */
-			return true;
-		default:
-			break;
-		}
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_NEHALEM_EP:	/* AAK155 */
+	case INTEL_NEHALEM:	/* AAP115 */
+	case INTEL_WESTMERE:	/* AAT100 */
+	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
+	case INTEL_NEHALEM_EX:	/* BA97 */
+		return true;
+	default:
+		break;
 	}
 
 	return false;
-- 
2.44.0


