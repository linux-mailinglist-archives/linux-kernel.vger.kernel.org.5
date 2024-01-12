Return-Path: <linux-kernel+bounces-24326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4182BB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECAAB224FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAFB5C8FD;
	Fri, 12 Jan 2024 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zX9g2kAv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8485C8F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbedc37d66cso6534239276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038782; x=1705643582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCgv2gQcPlkrLlc5vy0/ee6RBdfFJuXbxv5Hj/nh1sY=;
        b=zX9g2kAvzWZXADJe9boZamxxhp6dBhkhuJ8ZSdlh38ErrYYCLGkuSKa8ADra2aggDB
         3h2sgFqHCA/Lczrwp9ecoGisncrHQfkuA4icFWzw3vzVOMn8zd6WlDYGcFpSI7JzdSQf
         00vMvHfUgvuH+vLWxNVr/qBAz/ZoK/K4Zso6M4FkNtYRnZ8qIniXgO/ZChGK3kGSX6Ix
         cYxphXayCC7BYydACazVDiWPiI5Pi5adzHCVPqfdgsinBdJIRqzIND5mSPQDjoAAPb3X
         75jl7OPkkniX108TmxiZ/DdC2voXvPRviwYNLUxS4r5nvt3+1XaPtIWpftrobXRpEhRo
         0fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038782; x=1705643582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCgv2gQcPlkrLlc5vy0/ee6RBdfFJuXbxv5Hj/nh1sY=;
        b=DP8S07vet4iQUe6A+0xbB4nfM0JIsfKeFRkvPwW8My+L24UNDQOgkp5sOdcXCB+bu/
         kbInftNv5hviKjU/xE+IiFZpwn+iy7v2J9FzlrGuMi7ae0k8t8QEGSZMRYU4Ot0RQYKR
         xiXnwkcfeikRO3do+k+Hlk+wwQP42jPXpvEf7wVbQZrIzMTbkIADLHu7bVyDkxEAhr0b
         A4KfOOyix6kTJ8Tk7HhmN0+p5sUViZIE7oLb0knvuhIlxiMPtV84pyH9/EBLJrRy0qGH
         cQcBpkqp6JDyEtGCnle/zQ6e421eJunTy178zzdasxeQ5ZZI+d8xVt8CFXNBSq6xJBCT
         Sv5Q==
X-Gm-Message-State: AOJu0YzslIh9DubvqKedeMFqckrRKY+M0nbZT4/TuHQw+47mGZZKhgYt
	hwonjo9FKvWMAEIyIMnPm5rbwEsobr9VT34hzqq2jJM=
X-Google-Smtp-Source: AGHT+IHzIdxRbUN3uUh2p4li/usVrD1CGbdlJlgyLfKsoH/zMy1VbGZJ/Dfi9+WcQoQmfD7YSqjGuTsHmLd/HH/O
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a05:6902:1b81:b0:dbe:d426:c456 with
 SMTP id ei1-20020a0569021b8100b00dbed426c456mr10589ybb.4.1705038782481; Thu,
 11 Jan 2024 21:53:02 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:47 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-2-vannapurve@google.com>
Subject: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify SWIOTLB framework to allocate DMA memory always from SWIOTLB.

CVMs use SWIOTLB buffers for bouncing memory when using dma_map_* APIs
to setup memory for IO operations. SWIOTLB buffers are marked as shared
once during early boot.

Buffers allocated using dma_alloc_* APIs are allocated from kernel memory
and then converted to shared during each API invocation. This patch ensures
that such buffers are also allocated from already shared SWIOTLB
regions. This allows enforcing alignment requirements on regions marked
as shared.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 include/linux/swiotlb.h | 17 +----------------
 kernel/dma/direct.c     |  4 ++--
 kernel/dma/swiotlb.c    |  5 +++--
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ecde0312dd52..058901313405 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -17,6 +17,7 @@ struct scatterlist;
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
 #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
+#define SWIOTLB_ALLOC	(1 << 4) /* force dma allocation through swiotlb */
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -259,7 +260,6 @@ static inline phys_addr_t default_swiotlb_limit(void)
 
 extern void swiotlb_print_info(void);
 
-#ifdef CONFIG_DMA_RESTRICTED_POOL
 struct page *swiotlb_alloc(struct device *dev, size_t size);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
 
@@ -267,20 +267,5 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
 	return dev->dma_io_tlb_mem->for_alloc;
 }
-#else
-static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
-{
-	return NULL;
-}
-static inline bool swiotlb_free(struct device *dev, struct page *page,
-				size_t size)
-{
-	return false;
-}
-static inline bool is_swiotlb_for_alloc(struct device *dev)
-{
-	return false;
-}
-#endif /* CONFIG_DMA_RESTRICTED_POOL */
 
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 73c95815789a..a7d3266d3d83 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -78,7 +78,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
+	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
 		return 0;
 	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
 }
@@ -87,7 +87,7 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
+	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
 		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 33d942615be5..a056d2f8b9ee 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -363,6 +363,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	io_tlb_default_mem.force_bounce =
 		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.for_alloc = (flags & SWIOTLB_ALLOC);
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
@@ -1601,8 +1602,6 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 
 #endif	/* CONFIG_DEBUG_FS */
 
-#ifdef CONFIG_DMA_RESTRICTED_POOL
-
 struct page *swiotlb_alloc(struct device *dev, size_t size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -1634,6 +1633,8 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 	return true;
 }
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.43.0.275.g3460e3d667-goog


