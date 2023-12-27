Return-Path: <linux-kernel+bounces-12045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E881EF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFE283198
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A145BE4;
	Wed, 27 Dec 2023 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYDT9L3e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3D45964
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e9de9795dfso80037157b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703686342; x=1704291142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxNY2VrPCY3idyTMpJR/1ttR0VD4PODSyqOS/F6YoNY=;
        b=pYDT9L3egtaAW9QVwLXGv03P80FZ2ysXWZm7wOwS6F+/LqqNiGA8gEYN30kFmHvXpt
         KDuFcoInc99nV2BT0BPR4Fpjk1dqxKthORvld1/XdBkPKTkXWguZaooSCEidBDk2hS2n
         H0SBffFPFBhGGfxYloKLfeXIfYRhgPeWD77GswRI1XbHxPA3GmwlTuyCzW9ivbl+sWqW
         OHA6IHlj8CBYrW1vMvXRsjmlDHHjw83ZEa4jHmt/hboIsl2E9ckRpiFj6gde95MvChZm
         v1x+03xBNIGpwqJcTgR8LoKcD6Kh/I0nMK/Dcbt5B2WZewRPbRP1hqanZtCHgBDMg7GO
         BY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703686342; x=1704291142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxNY2VrPCY3idyTMpJR/1ttR0VD4PODSyqOS/F6YoNY=;
        b=QWPLqf4juEyqitirqGuNY9AViq7vO5OfwlSVQM6cqaswT8LIZY3fv3nYk3EiI7RPgK
         FZ2Xpb1EVQ1dsV1dddHt85xOM/P9gNdftdUkhlJUS7w4X+Ron54GHShQf8zonxEOI6D8
         sh/FngTHp6XJdvyYD7xFcUKDpRIy6VzoRNrlP/Mu/X1fqjTX4h2kDJLWA1mGVHqVeMJo
         g7Cr8Jm6ZDcelaI9/3UuYqQ31JltKK9ybOwThLISXErTwHN3uEAjOKfSHv2goX+ECE+/
         see1n+il2+cAMPyaWpGdBzCZxip9DEC9QHkjuodHb/PVQz/4WcGDj985p4Hri/+IZ4HR
         YpLA==
X-Gm-Message-State: AOJu0YwD8mSe1JQg87qyNyHpffpG1+fVUjKJAPqy7SzsRs2NPgMK/3MK
	tA+JmnI56Usr8xpwd4ug1YMuHo5jMmWOinrcg9Yn
X-Google-Smtp-Source: AGHT+IE8RZKKQ6O+mMRizNvr6qVSWpnv3WsoTuWDou54DQMqnSDnrrx19+W2dXLZBRg+Aq6wz1/HHo13u5Bc1A==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a25:8201:0:b0:db5:4a39:feb8 with SMTP id
 q1-20020a258201000000b00db54a39feb8mr3392529ybk.8.1703686342353; Wed, 27 Dec
 2023 06:12:22 -0800 (PST)
Date: Wed, 27 Dec 2023 14:12:01 +0000
In-Reply-To: <20231227141205.2200125-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231227141205.2200125-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231227141205.2200125-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 1/5] mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Some architectures are able to set the accessed bit in PTEs when PTEs
are used as part of linear address translations.

Add CONFIG_ARCH_HAS_HW_PTE_YOUNG for such architectures to be able to
override arch_has_hw_pte_young().

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Tested-by: Donet Tom <donettom@linux.vnet.ibm.com>
Acked-by: Yu Zhao <yuzhao@google.com>
---
 arch/Kconfig                   | 8 ++++++++
 arch/arm64/Kconfig             | 1 +
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/pgtable.h | 6 ------
 include/linux/pgtable.h        | 2 +-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..8c8901f80586 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1470,6 +1470,14 @@ config DYNAMIC_SIGFRAME
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
 
+config ARCH_HAS_HW_PTE_YOUNG
+	bool
+	help
+	  Architectures that select this option are capable of setting the
+	  accessed bit in PTE entries when using them as part of linear address
+	  translations. Architectures that require runtime check should select
+	  this option and override arch_has_hw_pte_young().
+
 config ARCH_HAS_NONLEAF_PMD_YOUNG
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..12d611f3da5d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -36,6 +36,7 @@ config ARM64
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1566748f16c4..04941a1ffc0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -88,6 +88,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 57bab91bbf50..08b5cb22d9a6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1679,12 +1679,6 @@ static inline bool arch_has_pfn_modify_check(void)
 	return boot_cpu_has_bug(X86_BUG_L1TF);
 }
 
-#define arch_has_hw_pte_young arch_has_hw_pte_young
-static inline bool arch_has_hw_pte_young(void)
-{
-	return true;
-}
-
 #define arch_check_zapped_pte arch_check_zapped_pte
 void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..9ecc20fa6269 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -375,7 +375,7 @@ static inline bool arch_has_hw_nonleaf_pmd_young(void)
  */
 static inline bool arch_has_hw_pte_young(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_ARCH_HAS_HW_PTE_YOUNG);
 }
 #endif
 
-- 
2.43.0.472.g3155946c3a-goog


