Return-Path: <linux-kernel+bounces-24329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E6B82BB12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60641F259B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019A5D74B;
	Fri, 12 Jan 2024 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcsIPG81"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9E5D73B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f69158f32eso81476217b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038792; x=1705643592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOaEOFbZAWEH5Yjsdlubc01KHjJyWCBCS9BwuOvGQrw=;
        b=RcsIPG81Ilrha4dJO2ocI4bqi/hjF3gm47HEp7RSsSRIBe3B66ePiq/CTf5inG61Qk
         VmiPx+db4Z2hpOf0dcWXJdq30IRAoPXyPyoL1TgMwHQOm8786kV5ufW67wuMVCpYvC2K
         U7IWFKGnRfNF8FOwdWRgfFVBkJ/B6ccTgJT3bUXPri5uEtU7QutMQxVZJhix/XAWSL9f
         B0LW640sUADbfBVV603pXzQONCbL5aMcP+32chS+c/lMdEnJB+A+RIJPUxERXyrmiISG
         ST56WKneWlwUX0r0KkxGw3FFBf7jscncJiu8HJrn1JRiXO3NRZglzLnoCaaXPGVqNrIW
         4TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038792; x=1705643592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOaEOFbZAWEH5Yjsdlubc01KHjJyWCBCS9BwuOvGQrw=;
        b=V8gvZuES1BIV1yC3eIIRhXwNXFWSSCKRfsnlO15gbm2o+xvBUYnxKvyLH6qwSCXh6d
         dddCicq7T0+6sucRPXKK5mXOwyyHnlW0YNalwGe+RnWrWGBZ4v9Kyy5kw1bwpy6nkXD2
         0OU/kyLFLzFzMbNhnq35DHoJlI7jtfIxz0liktNX/7jm53H6h5CzZ35XQ7K4GX3IHb/2
         XTEEgOfmIf/5izbZv09IB/r3+916xOnR9uqVLAGey6SROwOwjVYat9lcIIPgwxE3kzb/
         WjKeKGZgn41Wx12Z/+qzZycLkENxh05Ro+IHlnBc8w5jxGkpNs7SEqIJh5DnqDoz2Iqb
         Yj2A==
X-Gm-Message-State: AOJu0YzIk8yyAK+VjC14Zjyb/pHHlX6hD28FtXa+hOsBvO6vAo6w+JHD
	i6l2trI2k5SLP6X7/hwvyuJicVorv3AQFXuUZGvCj8E=
X-Google-Smtp-Source: AGHT+IGaBbJ5M4pHi7k+543Q/p59waeE7UFHvcz2IdcmC08A81gveyAh20QzVYUNlkq6+5OlavoIfF0F2/qyiJ/k
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a81:7102:0:b0:5fb:914f:207a with SMTP
 id m2-20020a817102000000b005fb914f207amr352561ywc.6.1705038791836; Thu, 11
 Jan 2024 21:53:11 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:50 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-5-vannapurve@google.com>
Subject: [RFC V1 4/5] x86: CVMs: Allow allocating all DMA memory from SWIOTLB
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

Changes include:
1) Allocate all DMA memory from SWIOTLB buffers.
2) Increase the size of SWIOTLB region to accommodate dma_alloc_*
   invocations.
3) Align SWIOLTB regions to 2M size.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kernel/pci-dma.c | 2 +-
 arch/x86/mm/mem_encrypt.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index f323d83e40a7..3dcc3104b2a8 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -61,7 +61,7 @@ static void __init pci_swiotlb_detect(void)
 	 */
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		x86_swiotlb_enable = true;
-		x86_swiotlb_flags |= SWIOTLB_FORCE;
+		x86_swiotlb_flags |= (SWIOTLB_FORCE | SWIOTLB_ALLOC);
 	}
 }
 #else
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..0cf3365b051f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -112,10 +112,14 @@ void __init mem_encrypt_setup_arch(void)
 	 * The percentage of guest memory used here for SWIOTLB buffers
 	 * is more of an approximation of the static adjustment which
 	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 *
+	 * Extra 2% is added to accommodate the requirement of DMA allocations
+	 * done using dma_alloc_* APIs.
 	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	size = total_mem * 8 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, (SZ_1G + SZ_256M));
 	swiotlb_adjust_size(size);
+	swiotlb_adjust_alignment(SZ_2M);
 
 	/* Set restricted memory access for virtio. */
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
-- 
2.43.0.275.g3460e3d667-goog


