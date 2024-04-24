Return-Path: <linux-kernel+bounces-156533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5D8B0426
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFEE1F25A74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7656158861;
	Wed, 24 Apr 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZhefami"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092C29CA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946845; cv=none; b=AXWUKTGbRBHf5CDAb7OW/CZaqXoqN2gRovo+pxHlPrl80CvgRkQfeyIz77iiEsNfrdMhoCqlgUDDRvoK8u+TGQ5fGaoNVmgv/X/DCvvJJt2l+nxzweV4qk9QF6wv3BkyqBrEZKQ/H8QnNPDx3VePfU38gAqonQyiYykB3VrA4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946845; c=relaxed/simple;
	bh=1QNJYK93FeXMoYrHwvPfTLrJcp1g0jZn3gs7dBziX2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVSd3EY/4cu2OmT8pvQwlSkSqBgLxBMIGz0ORoq8gX1VrS+1+xz8I741O4Ycb1RWybs1e3vySsbcQxMaS96KpEzKmYNWZLglp6QpdFks00xFl8p412mCfsUd7Lt4nVYvdJp0LxQqnz8mjF4gJKkugKYFV+zMA0ta6URHKFDf9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZhefami; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713946844; x=1745482844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1QNJYK93FeXMoYrHwvPfTLrJcp1g0jZn3gs7dBziX2I=;
  b=JZhefamiAzr+wcdQ/eJ2jGxMX1WaOAkit6UpIuZLaMMMY3CAO3J1ylyN
   zoHEvvvptuMzJKw45ERUJWD0WAqB9Pt/30+iHpQlN3MMw8wku8dMGCyR8
   GfmeLD6aEWNxPFQjy+BxaAm7WL2I2YCcen7DLCbRCiuJup5B+nfavAHIZ
   16BGWhCSvLfgbff/Zfazn6Gz2OAcv44gVtcVtizpcEU0Igi3YxawYuWjK
   /8HvujGN2pZyYmK6a3XeJ3U2RO0cYEL3Ye/skHPd+JNHfJrDZRP8DZ3j3
   lcLCfVKnlh3jY/yKyPCy6/aUMvo2hrZml/oWGdLdVSF01kpww5IxU9dZn
   g==;
X-CSE-ConnectionGUID: IK8nQQZZRRe73TJ8h7iuyg==
X-CSE-MsgGUID: ILyU0vxHS6WmRVUZYolGug==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20260703"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20260703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:20:43 -0700
X-CSE-ConnectionGUID: GoCi5O30S86j6WTFUGcX2A==
X-CSE-MsgGUID: FCaPRtp3SKqtDsPBjQrn5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24601473"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Apr 2024 01:20:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4459C28A; Wed, 24 Apr 2024 11:20:38 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Chris Oo <cho@microsoft.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCHv3] x86/tdx: Preserve shared bit on mprotect()
Date: Wed, 24 Apr 2024 11:20:35 +0300
Message-ID: <20240424082035.4092071-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX guest platform takes one bit from the physical address to
indicate if the page is shared (accessible by VMM). This bit is not part
of the physical_mask and is not preserved during mprotect(). As a
result, the 'shared' bit is lost during mprotect() on shared mappings.

_COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
during modification. AMD includes 'sme_me_mask' in the define to
preserve the 'encrypt' bit.

To cover both Intel and AMD cases, include 'cc_mask' in
_COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
Reported-and-tested-by: Chris Oo <cho@microsoft.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dexuan Cui <decui@microsoft.com>

---

 v3:
   - Fix more build issues for !CONFIG_ARCH_HAS_CC_PLATFORM:

     Use "static const u64 cc_mask" instead of #define to fix build of
     tpm2 and ath10k drivers.

 v2:
   - Fix build for !CONFIG_ARCH_HAS_CC_PLATFORM
---
 arch/x86/include/asm/coco.h          | 1 +
 arch/x86/include/asm/pgtable_types.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index c086699b0d0c..aa6c8f8ca958 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -25,6 +25,7 @@ u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
+static const u64 cc_mask = 0;
 
 static inline u64 cc_mkenc(u64 val)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 8857d811fb5d..2f321137736c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -148,7 +148,7 @@
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
 				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
 				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
-				 _PAGE_DEVMAP | _PAGE_ENC | _PAGE_UFFD_WP)
+				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
@@ -173,6 +173,7 @@ enum page_cache_mode {
 };
 #endif
 
+#define _PAGE_CC		(_AT(pteval_t, cc_mask))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
-- 
2.43.0


