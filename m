Return-Path: <linux-kernel+bounces-143242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DA18A3636
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A42B22D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B814F9E3;
	Fri, 12 Apr 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv3HvwR1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B914AD37
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949181; cv=none; b=j0LbBFikN4aUhwqxxUmlpq6budDrM4MqyN4MRNn0787kWMRrxOzpCHcTXI9vP2sIqlA/yfamOVTz6dry4RnRlELZSVbcWDryYSAlPci0m2BJiNee9jVMxiOYZA8e1rASl85JjpCxhtj5Oq9OwdhX4cDSbtABaSLfbj0+8JyELmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949181; c=relaxed/simple;
	bh=H8JEpoCZflLA8EFMplPsC53vlbE/L29pBi4hH+AtR0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEjdtTzlEMjtG2yCizeFWFR3gMk4OTZAc8g0uBv4u/Ja9Ql/MLfykh6oPI+Deo/0KAALSppHAy9PO+igT7QJd6hnvkiaM9ETXA5XQyRZwIRigG2+5fB5wAAhXA/79ilJlCHxZQ6s02QF1Z+8bKU+fJe04mNSMbaTEF4qPn7OXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv3HvwR1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712949180; x=1744485180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H8JEpoCZflLA8EFMplPsC53vlbE/L29pBi4hH+AtR0k=;
  b=bv3HvwR1NvvorkC//dsOp5IKwpKHGTTn+uyiRR9ub9VtmRV5T0ekZRxP
   /SO6fI5jBtdf/o4vT//1htmnInEUcQwiDiLbCTHwvHkwQsmPRIAoItAO0
   ksRJZ9kZZGuK9k8Op3HqIuZRcbn9Wma+04AEjzp53of0GA4R9zUJ6mGZZ
   zAxl01SPIrROWGn33diKcL78sYH+3WgiRd+zb8gYvil5MLpTevY8Kno0o
   4blYC/lBaN/r9QQNQG0FwBIvYQ5byjdvoVRZ66jV+ex3iHJd7tr+GZDnd
   +CY3apWaSrO0A6ZBMAxXAI6dlQQmkpNDsvzLQlrFzo8k8NIuF/6vMZoXI
   Q==;
X-CSE-ConnectionGUID: 8/540h1nRmWT2K6vBIfaKQ==
X-CSE-MsgGUID: BQfLfVW2TlaqHBVwZ2z0ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12200212"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="12200212"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 12:12:54 -0700
X-CSE-ConnectionGUID: Xx7g3qi7QZa1/0/zVKOl0A==
X-CSE-MsgGUID: CFH6OVtJRyerXC/HpwifbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="26106796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 12 Apr 2024 12:12:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DE192169; Fri, 12 Apr 2024 22:12:48 +0300 (EEST)
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
	Tom Lendacky <thomas.lendacky@amd.com>,
	Chris Oo <cho@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/tdx: Preserve shared bit on mprotect()
Date: Fri, 12 Apr 2024 22:12:47 +0300
Message-ID: <20240412191247.369841-1-kirill.shutemov@linux.intel.com>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Chris Oo <cho@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/include/asm/pgtable_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 3f648ffdfbe5..7dd2fdfacff3 100644
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


