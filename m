Return-Path: <linux-kernel+bounces-134385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC789B0DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586061C209B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0952BAFD;
	Sun,  7 Apr 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpZsYycC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489F3612C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493930; cv=none; b=ILNvSQuuie6Gckfc1xQ37n/VOB9FVJHcTLB35QGQpIKQ1lNomrGqTrbPDE+0BIFWMChOMetIDRa/Q60J7lIpVXM1RFLm6HSECmkcR1+eDbaCav3fJLDoKPsdYurHa6ndk537CNcS/cWijuySVW2fY5JFWp6nWjtgyjGLR4Pxh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493930; c=relaxed/simple;
	bh=6CCxFfD9nmysEbLLqArr5MWTcAJT2JYjKEhYrHzQWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNJIsle1LUbRoaBkA2B6tki+z+HfJwpj00b4+fdvtyd6kqbpqTlFJeLQnLf3j6kgEmGwndHrpgXZlz+Df5gCDgo5pLF1fcyfjGisRMQRvF3nU+vhOi/5i2IrJ1xePxETI3UNWkt/B54PYRnmHctHBNPfMDGEXUmw8mv1H8qXaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpZsYycC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712493930; x=1744029930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CCxFfD9nmysEbLLqArr5MWTcAJT2JYjKEhYrHzQWT4=;
  b=YpZsYycCMs4FvJeHmeR3Mw9e+0BQ2NxoL9xiq5j4bAenC74ykDJNk3MU
   IiHgvZDdWPzDzv6euVk+uark2eznf7KloNsxq3DLKxoCb5X8U8mW8Qw53
   LkL+styKwB3s77ANmbIx9TCDLteOx4cymC/eXLU0ooPL282tve+MdPU9z
   3WMjI4nX/G00qqR+ItWAx9oCX4kuNc105pY5fpcg4xaT2xQwT45Cw9EeS
   XrzTKdHIMUlN/KK3uqsgc8Os8PnkfmVUEzkQI6pQVcN+bihIluMI8XSJO
   vrDUnVX4mKBGD2sZsgC0K1hCJT3zqwdO5fRhZ42gJx9zhzmkdFxOZ1W02
   g==;
X-CSE-ConnectionGUID: lIp8CeN5TyyocVHup49Jlw==
X-CSE-MsgGUID: D1A/ghMQTlS3W2M8Wfrdow==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11564092"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11564092"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:29 -0700
X-CSE-ConnectionGUID: Hfoa1JAtRr2OaQ87X0HmXw==
X-CSE-MsgGUID: s6rhqW3xQK2nHSH7TBt2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20185730"
Received: from mirtanji-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.14.88])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:25 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v3 4/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Mon,  8 Apr 2024 00:44:57 +1200
Message-ID: <2fc6e5c300d863ba72eac8739c50507cbbfa1712.1712493366.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712493366.git.kai.huang@intel.com>
References: <cover.1712493366.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now TDX host can work with kexec().  Remove the !KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c62db6b853d7..bfafc8a16a07 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1967,7 +1967,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.43.2


