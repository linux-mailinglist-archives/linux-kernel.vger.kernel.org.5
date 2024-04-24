Return-Path: <linux-kernel+bounces-157410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C838B1136
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E7B22988
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7151816D4CC;
	Wed, 24 Apr 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wagpp5/7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHbcfwKr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115E15821E;
	Wed, 24 Apr 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980276; cv=none; b=GWCy7vPzNHBcEOplbWf43LRo1baPmYXJrr4KXDINaMKxmjqiXh1kFMDNTLbyqYqVeoSGs7uwTE57702AfAAjKv7912r3Cwxik3Wbn0DRXzAYPni6CZAprNahEOW4xPBf/zQnrvq9qehNBBihdoG0kgTVjVoXlgLAOe5J2rDkEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980276; c=relaxed/simple;
	bh=Nfg2Y4SmEDTeFM/e5TfSu/l2NIpcgIhs4FnO8pbGvck=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QotfLIQ6cc45hZ/L/O9bO0U3zrZCmCapct4+Hz+6V0b2o3NfgUZ79EhYITvCWdwXCEcZZdWQ+4YZmzOIrV9zLi2KrBTpWryxEgERPLZQANKKdUeScfOf78K3f2pG41HSTGXIy7odaL9QUynuHu3uKlHIPJFCP0p4DekexvqynWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wagpp5/7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHbcfwKr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 17:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713980273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jwhKVNavcoyb1EKysuNrb+LLqiWdy99Ko+lHf85CJUE=;
	b=wagpp5/7j1QgfzDNbbU5rue15G3p0Qgfy9JqS8V8EDqtlqa+sn0AlXcsqQ7J5DDAJ9OK4T
	K9xplRRBPCli9wFOhal/3Kp7bTI4kfec2lZ6ypvgZle9Tmrsfq2o6kvXcaAtSjyWWycbVk
	/xXVMgiD4aedsJ+7+BKqtlclEtgx7p4CfQZ91JHIaRZW1OsAGjokTu2T7DDvAK4UU5h07W
	7DevUQ0FkngkdlaER/+DB9KpUshdLsECYJQdqwLysVCq9+csXQ6FqFZDB48zUnMAiMt4FS
	l2D4CzB4hAJoc251SQHee8wntz8yeycE1OFBsAXPE/p/lINLOoHmxeP7fXutgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713980273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jwhKVNavcoyb1EKysuNrb+LLqiWdy99Ko+lHf85CJUE=;
	b=bHbcfwKrhR9OM9XvANF1cgdHErgOth6ue1dNtIgu3atBlV2RWCmIy05wFIuzSWFAvzc/Ua
	swW4kSlyUoQLsSCA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Preserve shared bit on mprotect()
Cc: Chris Oo <cho@microsoft.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398027263.10875.3592375840753497804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a0a8d15a798be4b8f20aca2ba91bf6b688c6a640
Gitweb:        https://git.kernel.org/tip/a0a8d15a798be4b8f20aca2ba91bf6b688c6a640
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:20:35 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 24 Apr 2024 08:11:43 -07:00

x86/tdx: Preserve shared bit on mprotect()

The TDX guest platform takes one bit from the physical address to
indicate if the page is shared (accessible by VMM). This bit is not part
of the physical_mask and is not preserved during mprotect(). As a
result, the 'shared' bit is lost during mprotect() on shared mappings.

_COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
during modification. AMD includes 'sme_me_mask' in the define to
preserve the 'encrypt' bit.

To cover both Intel and AMD cases, include 'cc_mask' in
_COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.

Reported-and-tested-by: Chris Oo <cho@microsoft.com>

Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240424082035.4092071-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/coco.h          | 1 +
 arch/x86/include/asm/pgtable_types.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index c086699..aa6c8f8 100644
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
index 0b748ee..9abb8cc 100644
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

