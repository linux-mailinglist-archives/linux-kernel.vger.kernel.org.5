Return-Path: <linux-kernel+bounces-12048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E281EF61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77121C21960
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623834652F;
	Wed, 27 Dec 2023 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbQ5Lg3P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DB46433
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28c05e74e36so5607862a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703686347; x=1704291147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMXZnWGUqNtn7KYJD8Fock0hYei0LYTTlWAZlt2Oe3E=;
        b=DbQ5Lg3PsGtgSH9TOHenyahbFAukf2XmW2LMMzXsUwQjkkM2Ei3ptkUFYh62kJNvXm
         07+QwR4MulxALIv4St8HjVHD0ZGJhPjhkf7k8/3d1Lbn5kHYL1ajib9hDgicaT7Nc25q
         brQ8kvuKcT2HZluLqlvjRVCXyIc15jeqSEf3dFS0dh/hnPhL4knmKQdmRIjLgqkQLczy
         pTGEG02my65XiZXUAU3s/Sf2tNtWf4HrxQfKEfcQBkq2bY0y/3bubCo/UNjcjVZSpxWV
         iA2gArIA/0cG2KAZIEoTdZhjUtqgjgta2ORehMGXDucVllegG+RAJKbAUTEoQdb8Ng7s
         i7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703686347; x=1704291147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMXZnWGUqNtn7KYJD8Fock0hYei0LYTTlWAZlt2Oe3E=;
        b=QbnZ/JjaydJlOU2tdzq29Rggx1ycDoPiciDOCxDpSAkKdDMsxYhsmIHaCyuwa+o+CJ
         ATs3tAbQlolIlr0QZMwphUQwMeovL+2mXAiWPwDvvmFJip2tf2uHhUXwZLta0AdfvABW
         vqESMnQUi2nslx2TAxRNew/8Aq2WhoAGj8GMPEYKEnAKo608OUfqFJP22GdmCMhMGlKv
         XbEeBrz73bTw2FJ4Gpg1Kul56SjyoaS2ME7eTQnBm9ckySM26FNtd+9OuYIkY1B33XL/
         GrS870Jx3iJ3qoMtJZNTDNUZkb+rdjtP1cTEZDPLrVbGs5WuamtHWRQvezNkNYGaCPc8
         y2Vg==
X-Gm-Message-State: AOJu0YyfP0Ae286DDZ4zf9mCM92fhn4sDokGcxP3dT5YghYU8gYIwBtd
	JYOAZ4j7lAu89U6k0zC24AgstqInvv40O85g8zDL
X-Google-Smtp-Source: AGHT+IF2eDDCuAlCygtAnbqycFRCW3q1DgB7SZN9CI2qcZQ8684+/UMXX5/4G0wxhM8EbZWe7UZcpTnFfV3KOw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:90b:4b8f:b0:28b:2844:c35e with SMTP
 id lr15-20020a17090b4b8f00b0028b2844c35emr998089pjb.5.1703686347664; Wed, 27
 Dec 2023 06:12:27 -0800 (PST)
Date: Wed, 27 Dec 2023 14:12:04 +0000
In-Reply-To: <20231227141205.2200125-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231227141205.2200125-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231227141205.2200125-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 4/5] mm/mglru: add dummy pmd_dirty()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add dummy pmd_dirty() for architectures that don't provide it.
This is similar to commit 6617da8fb565 ("mm: add dummy pmd_young()
for architectures not having it").

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312210606.1Etqz3M4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202312210042.xQEiqlEh-lkp@intel.com/
Signed-off-by: Kinsey Ho <kinseyho@google.com>
Suggested-by: Yu Zhao <yuzhao@google.com>
---
 arch/loongarch/include/asm/pgtable.h | 1 +
 arch/mips/include/asm/pgtable.h      | 1 +
 arch/riscv/include/asm/pgtable.h     | 1 +
 arch/s390/include/asm/pgtable.h      | 1 +
 arch/sparc/include/asm/pgtable_64.h  | 1 +
 arch/x86/include/asm/pgtable.h       | 1 +
 include/linux/pgtable.h              | 7 +++++++
 7 files changed, 13 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 29d9b12298bc..8b5df1bbf9e9 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -523,6 +523,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return pmd;
 }
 
+#define pmd_dirty pmd_dirty
 static inline int pmd_dirty(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & (_PAGE_DIRTY | _PAGE_MODIFIED));
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 430b208c0130..e27a4c83c548 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -655,6 +655,7 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pmd;
 }
 
+#define pmd_dirty pmd_dirty
 static inline int pmd_dirty(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & _PAGE_MODIFIED);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab00235b018f..7b4287f36054 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -673,6 +673,7 @@ static inline int pmd_write(pmd_t pmd)
 	return pte_write(pmd_pte(pmd));
 }
 
+#define pmd_dirty pmd_dirty
 static inline int pmd_dirty(pmd_t pmd)
 {
 	return pte_dirty(pmd_pte(pmd));
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 601e87fa8a9a..1299b56e43f6 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -770,6 +770,7 @@ static inline int pud_write(pud_t pud)
 	return (pud_val(pud) & _REGION3_ENTRY_WRITE) != 0;
 }
 
+#define pmd_dirty pmd_dirty
 static inline int pmd_dirty(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY) != 0;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 5e41033bf4ca..a8c871b7d786 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -706,6 +706,7 @@ static inline unsigned long pmd_write(pmd_t pmd)
 #define pud_write(pud)	pte_write(__pte(pud_val(pud)))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_dirty pmd_dirty
 static inline unsigned long pmd_dirty(pmd_t pmd)
 {
 	pte_t pte = __pte(pmd_val(pmd));
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 08b5cb22d9a6..9d077bca6a10 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -141,6 +141,7 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
+#define pmd_dirty pmd_dirty
 static inline bool pmd_dirty(pmd_t pmd)
 {
 	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9ecc20fa6269..466cf477551a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -184,6 +184,13 @@ static inline int pmd_young(pmd_t pmd)
 }
 #endif
 
+#ifndef pmd_dirty
+static inline int pmd_dirty(pmd_t pmd)
+{
+	return 0;
+}
+#endif
+
 /*
  * A facility to provide lazy MMU batching.  This allows PTE updates and
  * page invalidations to be delayed until a call to leave lazy MMU mode
-- 
2.43.0.472.g3155946c3a-goog


