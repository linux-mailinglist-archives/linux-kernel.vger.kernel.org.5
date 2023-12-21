Return-Path: <linux-kernel+bounces-7859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B181AE59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E311F243CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A0AD4B;
	Thu, 21 Dec 2023 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xE4vad++"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C599465
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-357d0d15b29so49835ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703136414; x=1703741214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wCCLZM4JqNp3Y4ApKOQz3CzWtQJL0OzMsUEywq65GM=;
        b=xE4vad++4kebnKgEo/dvjJGYUlHcftwUmACYB9/4CGLsg8VbP3qSPT3xcTer1jQJDD
         s+RYF6CQG0N97vNakOzwAfhwqgiwIZkdeFSN4togjU3JZy8WTvXzNFdcpf9knNYjkRfq
         nYb2goTd+/820VPZie94W0OGANXXqaIIfLoEwvQBS0vFhnul5b20NMXgoL+SQn3NIneh
         51xtM5pPrLZ5QXw13TUxD6UXzQIFgVqI4LkK7oU/UEXpVgbTd7Fq8vj6z+HP2XV2XiE+
         lnq4Inw7fyQyotKBOXoT9IJC8+cLs1UUXwew7pYbrn2/OFpDzc+LfsHsDjHAsHK+TCoZ
         uPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703136414; x=1703741214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wCCLZM4JqNp3Y4ApKOQz3CzWtQJL0OzMsUEywq65GM=;
        b=frUFg9LYxnzo3z0n8LOHNPOs8C+tJM2GGwVKx9TVKOclPXxbSriE9LSmVq2uhW6Tb9
         av4qJjJWADx8BM5/3BwQF44gEarzzBzZlVPNaTmT3DehrfIbqzKPrgr8EvUkpu47UaLq
         F3+dLI5NhTRL+5U1Cj0i4X5ZO8yBBtq5Mjm0hJfPYvU7A5JIrzqU2ezmz13q8BO43fli
         fVzJ8Tn1uCMW0K1oNgy5VdY8Rn47s2N2GZgcubIAlTn146AEabHvvT5N8G1N3gTUkF0a
         2qE41k5hZY/zlACSsr87liLHW5hpJCrfkmQI/+33F9QSLWhTH3Y7oVOySZpcxt006Xnm
         jY5A==
X-Gm-Message-State: AOJu0YxjQfmzyrq8k5g3YXpf3wfY1nf+tREBE5aDpPL+9lxWdAScmE4t
	YIu+xqo9WoipGGTch+xncDaeknANpgBK
X-Google-Smtp-Source: AGHT+IGjNY/faGmARzHzlj2EeW0o1odpyiIHpjdTPytyjny1PI9hn+sKzOiqKGWGZTcSIGOgRvZ9kQ==
X-Received: by 2002:a92:da85:0:b0:35f:cb23:89d2 with SMTP id u5-20020a92da85000000b0035fcb2389d2mr31046iln.5.1703136414063;
        Wed, 20 Dec 2023 21:26:54 -0800 (PST)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id a18-20020a6b6c12000000b007b392f4f3dasm293835ioh.23.2023.12.20.21.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 21:26:53 -0800 (PST)
Date: Wed, 20 Dec 2023 22:26:47 -0700
From: Yu Zhao <yuzhao@google.com>
To: kernel test robot <lkp@intel.com>
Cc: Kinsey Ho <kinseyho@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org,
	Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH mm-unstable v1 4/4] mm/mglru: remove
 CONFIG_TRANSPARENT_HUGEPAGE
Message-ID: <ZYPMl5fZXHp_Xz8w@google.com>
References: <20231220040037.883811-5-kinseyho@google.com>
 <202312210042.xQEiqlEh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312210042.xQEiqlEh-lkp@intel.com>

On Thu, Dec 21, 2023 at 12:47:51AM +0800, kernel test robot wrote:
> Hi Kinsey,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kinsey-Ho/mm-mglru-add-CONFIG_ARCH_HAS_HW_PTE_YOUNG/20231220-120318
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20231220040037.883811-5-kinseyho%40google.com
> patch subject: [PATCH mm-unstable v1 4/4] mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
> config: arm-randconfig-002-20231220 (https://download.01.org/0day-ci/archive/20231221/202312210042.xQEiqlEh-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210042.xQEiqlEh-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312210042.xQEiqlEh-lkp@intel.com/

Thanks for the report.

Kinsey, please make sure you include the above tags (as well as the
Closes tag from the second report in this thread) in the v2.

> All errors (new ones prefixed by >>):
> 
>    mm/vmscan.c: In function 'walk_pmd_range_locked':
> >> mm/vmscan.c:3455:21: error: implicit declaration of function 'pmd_dirty'; did you mean 'pte_dirty'? [-Werror=implicit-function-declaration]
>     3455 |                 if (pmd_dirty(pmd[i]) && !folio_test_dirty(folio) &&
>          |                     ^~~~~~~~~
>          |                     pte_dirty
>    cc1: some warnings being treated as errors

Apparetly we need the following, similar to
commit 6617da8fb565 ("mm: add dummy pmd_young() for architectures not having it")

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
index 57bab91bbf50..ee83a238ac13 100644
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
index af7639c3b0a3..b646c84cc592 100644
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

