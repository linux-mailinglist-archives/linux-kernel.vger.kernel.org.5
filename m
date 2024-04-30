Return-Path: <linux-kernel+bounces-164454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E098B7DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513F728676E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C9D1C68AF;
	Tue, 30 Apr 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahS5KRVC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B6190682
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495908; cv=none; b=s8kjkeMdwnx9rLhFkmQtR43gycZ08mmz4bsxkntB0PXu3DUAL/KXj+dQLRlZ6/cLUrTXsnmkEy7Hs+42u1Vg95YZnaxLNDANfNH2S6Ldzwz7KPjO+Zh7TrtUndpEBWYaai4ujCXav5Vd0buLRT+tIK1XuCvb8Lczu4ARpXgp+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495908; c=relaxed/simple;
	bh=zpJumNq7u5KsT133nYF8l88fxW5RaBTIKz2lN9diWJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPPMNQpYLyH6Y49r4jqi7CReChyNhWawMlq50a7XUIp2klewDVtyWUrvHMw3hunRjqt/FfqP4FjJBKHCt2G9pYkQuzJojs5x18D6l1iqlzZLpjbg/4HCPbrdmFYzycmGLAYScoTZb2N10xC9fvUhSttng1pZSlsyzh/Wtou7jW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahS5KRVC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495907; x=1746031907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zpJumNq7u5KsT133nYF8l88fxW5RaBTIKz2lN9diWJs=;
  b=ahS5KRVCwWdQtSKZGqFATWxornnFrCKSa8h2U4I1ddOP8lML2Qzb+yDA
   /5vv6Ar9fqCbg8qDKbaQAKNX3JnwnV2FrALz2F/rWdyp4XEkJMj9CuDbq
   0LrPifvBQDvndj6mEYzzBzeo8jHxxNn3HYd0TYL2IvRb7aePOJJ8AwPdf
   uxa/JoaQymOaO2XZG2qqI0y9KkfXuJAve8yO6pIQAwwN/BLWJ8IDSWAzF
   eDzU9IO9+L7VlMd4tsYygSFZO+NbEkZ2W2y9wbc0bOEreFC/PK4JjbNtN
   zNOQKNinOXwJTVaNPsdQW3AD9uoZnN6fjBuWUX5AmZoFFaerx0QQVTBW5
   g==;
X-CSE-ConnectionGUID: ffOdWST8RkWJJY2h5ggBJQ==
X-CSE-MsgGUID: CqiKpYyXTsy6wRS3b9Spvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075753"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075753"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:23 -0700
X-CSE-ConnectionGUID: kHKJNDQVT56RmmYTZONdHg==
X-CSE-MsgGUID: 0GWIDDisQhOierrHHt5dwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515492"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 28/47] x86/virt/tdx: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:41 -0700
Message-ID: <20240430165100.73491-28-tony.luck@intel.com>
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
 arch/x86/virt/vmx/tdx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..ee9a9273b75a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -34,7 +34,7 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
 #include "tdx.h"
@@ -1427,9 +1427,9 @@ static void __init check_tdx_erratum(void)
 	 * private memory poisons that memory, and a subsequent read of
 	 * that memory triggers #MC.
 	 */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
 	}
 }
-- 
2.44.0


