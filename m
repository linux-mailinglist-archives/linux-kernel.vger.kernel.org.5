Return-Path: <linux-kernel+bounces-14922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A83822479
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FB1B2419E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A131A599;
	Tue,  2 Jan 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S+xnwffw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0070199DF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28ce6eeb4easo310365a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232909; x=1704837709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntXY1BdgwMpYCVbC/qFvmg3dz3t/ZzKIeqKl93B+ekg=;
        b=S+xnwffwYxZ2FpgRDUEM5aG5lh6apSSIe8QE1YEuvg5HNZl2uvXS5xB3I4h68PXJtp
         gDoasIZL+E6vJDxsAlaAz2qiuZGnidTBKhLbKUVB9MCqyezHINS1vk9XB1P8QhCeQ/Gk
         1F3vkO36JKmC6wu3aDyGwRtHq/T4uIGYQI8W7lwNy99bF6j1+kb6RN8jomX5tdXoDy0z
         vv5Imvd5qeKtPNXykUn7nqE3fbpEknvZSukERFlYHljwch8UPjc169Yq0S62vKZRE1+2
         +sL6iybOEqjROZIlxUaOrgJTurzWQkqGwTWUSYMSkJZ+grzlapuwMTGlafSeAc4TDLZ5
         juuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232909; x=1704837709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntXY1BdgwMpYCVbC/qFvmg3dz3t/ZzKIeqKl93B+ekg=;
        b=wUFzXaOKgPQ6bpVNRdd3sXVSphJIgLT4XAs1Hg6wuk8igZ47iWWsJfoBFkPc2rw7HU
         X6YbehGy/PwEp08QENOlEm7ESgzXRzWS1JJeNE1CZaOwAhGYpB6+bnR7bXzt46K+FwRp
         LjFjU8YANW+/tBaQqBl3m9hziCm5Qn6SZooUnlwIeIiSRqXnIpRwHCaYnVbXv3toXfVv
         mTyRX/e6VWaw2o5Yju0ChSbfl4ZCqIHPoLZgVcO/oI3bta1WQHrxooAabJjpIJNm1bg3
         ADqN3DVVKGxgOJnxIx7nssthW7NIKhsH1Z6AhZeaCqssk69jT27puFZ1AOz2WwKD0tLg
         bENA==
X-Gm-Message-State: AOJu0Yxjvt/cT1av97KCBOP0oJOF7Cfc0U7dZzR3wCqymxwaSWrUni1I
	yuHESkk5hUG5ZAfGWnlSFpzncjCxxtwGQw==
X-Google-Smtp-Source: AGHT+IE6m2P6rWzQ+Gmcf0Ghh7A4crRVy8Bq5ePskuN3Kp4kY6ZC52OLPfUohVtqOdFfc+/yJvJ6pQ==
X-Received: by 2002:a17:90a:bc46:b0:28b:31f5:9668 with SMTP id t6-20020a17090abc4600b0028b31f59668mr5241043pjv.30.1704232909372;
        Tue, 02 Jan 2024 14:01:49 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:49 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 12/12] riscv: mm: Always use an ASID to flush mm contexts
Date: Tue,  2 Jan 2024 14:00:49 -0800
Message-ID: <20240102220134.3229156-13-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if multiple ASIDs are not supported, using the single-ASID variant
of the sfence.vma instruction preserves TLB entries for global (kernel)
pages. So it is always more efficient to use the single-ASID code path.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - There is now only one copy of __flush_tlb_range()

Changes in v2:
 - Update both copies of __flush_tlb_range()

 arch/riscv/include/asm/mmu_context.h | 2 --
 arch/riscv/mm/context.c              | 3 +--
 arch/riscv/mm/tlbflush.c             | 3 +--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..b0659413a080 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
-
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 3ca9b653df7d..20057085ab8a 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -18,8 +18,7 @@
 
 #ifdef CONFIG_MMU
 
-DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
-
+static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 5ec621545c69..39d80f56d292 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -84,8 +84,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		if (cpumask_empty(cmask))
 			return;
 
-		if (static_branch_unlikely(&use_asid_allocator))
-			asid = cntx2asid(atomic_long_read(&mm->context.id));
+		asid = cntx2asid(atomic_long_read(&mm->context.id));
 	} else {
 		cmask = cpu_online_mask;
 	}
-- 
2.42.0


