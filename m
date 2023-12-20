Return-Path: <linux-kernel+bounces-6342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E002819778
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA8288570
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4ABD290;
	Wed, 20 Dec 2023 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKsaJcrs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D41BE5B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d3eaaaa5a1so2647365ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703044864; x=1703649664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTWOqyfMsQnqPpUH1dExxKEsGutDkMUJttQEhdAsH5o=;
        b=rKsaJcrs2dUuxSvmCFXLFOs5pp/EKpnYlSytbzq40qviYj5P8OE4xtUbMdScUirWtS
         8cPz3NvuxxGNJ1XvEaF9o8H3HWRK4ZvBtrnqu0qy1VT3aMdCqUBOnYs4MPz30CMKmLjd
         g+xQ9bsoOS5a5ckqIoyV9K1KhTEiCb5ucyNBkDRKTDlUshmj2DwIkcB4yKotYAPMPLzA
         FfWHpt+N/6h9o0pNMWELO2yQNG7lKsOeUUOHKYlvDrJS4Lt1Vf/YQ/EcHwF0Yh7WXQSl
         npgnLR6TuAvicKqcomM3A77Tr1G2ySVVRYkcHzc89JLGgQGMmJANk+kdR38rymlD/kSd
         IOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044864; x=1703649664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTWOqyfMsQnqPpUH1dExxKEsGutDkMUJttQEhdAsH5o=;
        b=QCqPOErpm6udlZuL+zfkiJbNF8Rd2siQ2L9ChPFJIt89+B1TW+1e9b/7LfhSYGyCDZ
         jhLSuoyzNjfSZLEToXBlG7rBcCOEIQMng02OEFXzra8SaDVkkQxH53MoDqhuBKXMOQHl
         DOZPlVjyANPtDmQdzncBdC0RCa6Tg3TFadia3ShG90KiFlptBx52XyD0BtuNjw9nK2Ad
         TXPdstIkCVOhtO1j22GzPME4NabeZD3G2mmHt1rVLnK95d9+pIezuID/R3hwEtL8fp7y
         0CpDFs/wIZdWLNll9NYC/IDOvj6PDJ+DmizkuRllc8i4lhL8hymAk5MsUG9woYjZ6bkY
         17aA==
X-Gm-Message-State: AOJu0YxKVkilAiYReGDbpfcH+tJlT+FaRy4NZ4840Yo5BWiu05qKqrhQ
	C+x/t3ntt0BqOT9oXvqbJj3VYgf8V6dDbw==
X-Google-Smtp-Source: AGHT+IE0XcJ98lkVtn0f7tLx0WtqdkyiYTQiXEVRKmkDPl96y9lZ49HW36To1Qbapl1IP/a6YRSAgo7zXZmaPQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:902:da85:b0:1d0:4246:90b1 with SMTP
 id j5-20020a170902da8500b001d0424690b1mr110279plx.0.1703044864390; Tue, 19
 Dec 2023 20:01:04 -0800 (PST)
Date: Wed, 20 Dec 2023 04:00:34 +0000
In-Reply-To: <20231220040037.883811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220040037.883811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220040037.883811-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 1/4] mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, yuzhao@google.com, 
	Kinsey Ho <kinseyho@google.com>, Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Some architectures are able to set the accessed bit in PTEs when PTEs
are used as part of linear address translations.

Add CONFIG_ARCH_HAS_HW_PTE_YOUNG for such architectures to be able to
override arch_has_hw_pte_young().

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Co-developed-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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


