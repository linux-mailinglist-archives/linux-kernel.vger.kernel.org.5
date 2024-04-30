Return-Path: <linux-kernel+bounces-164456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD08B7DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612161F28D34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24751C65FD;
	Tue, 30 Apr 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDzLU6am"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D471C0DF5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495908; cv=none; b=RMvSGAx8nxafofj5FPQqDo8SLfvUOj9j14R2jqLDd8gCt3tPwryruTOnfq+ifi5D3YvD5hIDXNM8Aot9WqreRDqAO+Ph/Ol8Wki68twGgivGhl1yhfcautP9QesI3l03Xq+6qGGt3r/3u4E8Lb7oXlRfmtzNHxoykCApUkCNbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495908; c=relaxed/simple;
	bh=CwybUVe8crx1l4CZK03c9vCx8DvC8Bgt8uPcKdw9g+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2MXzUzfZEIe65aTy77ErvQG4p3n76R6REwsobSGHDoac+JovyodaqNyRVOpxX9Pds1HmHfCTfvsDBYx7a1CvnSTfP4/vtd4Dnz4jVW1CK+SOBFdnYK7WrM8KO5EbfcHI9ErlT+1KMP+7QO/pDnjULnHfNQu758s+ehKw9yaKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDzLU6am; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495907; x=1746031907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwybUVe8crx1l4CZK03c9vCx8DvC8Bgt8uPcKdw9g+E=;
  b=fDzLU6amLDhtEIsxxyE9BJwfj+oEJpThvYWOaRm1+CkMwmjHFcCUpQ0o
   LSdNgToNnedX+PIpiXckd178xi3XOBAqVo+l3HpDRRD4mxlki4YLmsTDO
   fxRWV6VLMLu2j1O178cBUj8Z4EPvaFlqYkcoehobv+mcddE+MNH7DcLgT
   dq2Sc08uSotgE4sK2sA7PaMLprjN3bGYM+w45BURz3gosxd2zKq5oRdun
   mEOCH9Z2ZSzW91h8NgVlYqhUN+3hiz9Tjz3bm9TNE/qzEMU21YT76D+B5
   GNDQ2WkhAYSJTuQJYDpabE6XNE01zwu7N+dYPivMo5JRRgaglsxaAo8V8
   Q==;
X-CSE-ConnectionGUID: m5ZmpxQ9SC2a4/jQ4apk5A==
X-CSE-MsgGUID: QOITeEqxSsWW8164PAfCzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075761"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075761"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:23 -0700
X-CSE-ConnectionGUID: l22Hf+hSQt6UpTh1JmRqeg==
X-CSE-MsgGUID: S7Wpuq2jRpWwH77gv07HXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515483"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 25/47] crypto: x86/twofish - Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:38 -0700
Message-ID: <20240430165100.73491-25-tony.luck@intel.com>
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
 arch/x86/crypto/twofish_glue_3way.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 90454cf18e0d..82311249048f 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "twofish.h"
 #include "ecb_cbc_helpers.h"
 
@@ -107,10 +109,10 @@ static bool is_blacklisted_cpu(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
 
-	if (boot_cpu_data.x86 == 0x06 &&
-		(boot_cpu_data.x86_model == 0x1c ||
-		 boot_cpu_data.x86_model == 0x26 ||
-		 boot_cpu_data.x86_model == 0x36)) {
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_ATOM_BONNELL:
+	case INTEL_ATOM_BONNELL_MID:
+	case INTEL_ATOM_SALTWELL:
 		/*
 		 * On Atom, twofish-3way is slower than original assembler
 		 * implementation. Twofish-3way trades off some performance in
-- 
2.44.0


