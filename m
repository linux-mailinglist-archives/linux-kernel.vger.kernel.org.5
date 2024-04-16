Return-Path: <linux-kernel+bounces-147595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCE8A7664
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB50B2358F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4B146593;
	Tue, 16 Apr 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kD68KyHC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8013D632
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302415; cv=none; b=Bf3KfgD8m+r9mrYYYrjiGzdDZ/6szjFfdg8a/S7EpF5B4ClNJ1DH9UrWmpRsfXwt6w3SG5UMPd956RR5GxYS6aPLKFIkv6kOm4pVxdKxDHgfzkUwH3bQIKOljHO7qfyQpV4sUzWGlcq05lDJUz8q6lFdn/ixwM04jhibHH6svg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302415; c=relaxed/simple;
	bh=7admVmhZ4o2F2ASVUVilv4irbHkYcisALjnpaLiV9rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deg8Cc9nwS3JOIB4Yw7aknJSYu7ACS8vZfq70OlgnNf1PsTaiTzTnEaIXV5JAEdeIww02QNn1t1teF5g0AE//iCziRrGuI3gsKuu7ot6Z9vNlWDRjRq1XiJaokWVJYL1NwJegX+mspK9SO2Q7MyRaA7Dp7926z7EcxFZF8YDv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kD68KyHC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302413; x=1744838413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7admVmhZ4o2F2ASVUVilv4irbHkYcisALjnpaLiV9rc=;
  b=kD68KyHCKY7NKcXSgR9recBGNXbYrhdrsTlwQqWkdw0TeeygAkPElAm7
   ovPuUMFX5rBEV0Z4ELepsL+Wl5sJCy4gLO3jp0QUzZFYOAx5+4vlsAcyc
   gcwraLVd3xgTsIHpOJXFTOl5gxCOdHKLWt+1Ijje6Q1VlzwH4U7mcNUWV
   /Y0Fhaq/A2dNiJgsvTTKoJx6Q9jBBhBat2nLFxUfactKSAGeFVECRKYBw
   UigRF/I621r/Jn/oi619loYmXRFbfwTr39XUcF7AsJt4ZieF5zOCvPDN0
   cE33ZUrnNv9ZN8rZxVGiI+WOyj8QdZSRGsKrEKvNNHhPMbasgP4x4Ga1Z
   Q==;
X-CSE-ConnectionGUID: 7Iz66vq5TTqVYHBzsCHYaA==
X-CSE-MsgGUID: +FzpJvCHSXq9/VE5iqXBpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914830"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914830"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
X-CSE-ConnectionGUID: ExIjNerlR+WsiyfRutxmZA==
X-CSE-MsgGUID: gN5YpAZITBeT08TkUuVuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872036"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 34/74] x86/cpu/vfm: Update arch/x86/virt/vmx/tdx/tdx.c
Date: Tue, 16 Apr 2024 14:19:36 -0700
Message-ID: <20240416211941.9369-35-tony.luck@intel.com>
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
 arch/x86/virt/vmx/tdx/tdx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 49a1c6890b55..3d22566c9b55 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -33,6 +33,7 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
@@ -1426,9 +1427,9 @@ static void __init check_tdx_erratum(void)
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


