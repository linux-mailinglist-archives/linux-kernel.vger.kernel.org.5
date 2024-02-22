Return-Path: <linux-kernel+bounces-76995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2D85FFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADA21C250AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E915B111;
	Thu, 22 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YxIKI/u/"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CB157E89
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623600; cv=none; b=qR1Fl4CJl04pp5wG+tW+0DW8PzhgOziNBsSYd+IdfJYQiZm+ANdw9pE7BStUltvaMG/p1Y38FgHxk5mrrI4dV+ZVdwyieuBUrr55wJwOUet02DsrDoVsmM0ySKhCWZg2vBv9p3MsMTdDTBApQyKTdNkSaBpLzSxZlHmACpghVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623600; c=relaxed/simple;
	bh=E19FlXPLCClmGxfE1jT8maBicxS4I8yL0jj4j6R5o34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXxHckfcQVjbQY0DyZlG0ief+lIaAv0h7K9e69gG8mkZaMKRLJ9lbMxR5OUtNKf3DnMbdIsUGpRMylQBsIiZTvf3sX8SxsYq4zc1I4O2KFfIAAH6HsthHedRIcoZBbeiSaZRWetitCVDuZgrPEM59TvKVf15oytiode1jrPBeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YxIKI/u/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a4516ec5dso62209381cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623592; x=1709228392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VAat8TBDVTapf/cNKrpWJJOpQ7pgkQwxbfklHwcriQ=;
        b=YxIKI/u/FnNY2yGsO7x8rd7KzMAAB7rzLOGhhUWKY2sgrtuMfakKrbP3Kz+sAxSYyM
         WTBXOsf39VIyMTbtyXpEjPBR+DhY+gNDYRHK/T4K3UEyp3gYneoZEhUDKuW5hH4a6/Wn
         NeIAR00QT2+9rQZ5AXPhdHZW2TvK+zS7sK385Of4+oVLnjFO6my8L2cOLZZgco+UHcTS
         1e2EijFry3OAIpizHEJSvvYG3hEyd/QxJlgChonQJfvNS9356fs7H+D2HvxWRtIRp1lh
         tGgGaHPceE60ya4ueEzDTTfxHKCdZ0cbYiPtPtk22tRxzv/o84Qc2OCUiyklEUmqaLc/
         mpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623592; x=1709228392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VAat8TBDVTapf/cNKrpWJJOpQ7pgkQwxbfklHwcriQ=;
        b=Kt6kiOXj2RdiCAZHNSxBWoy74qa8lsqXT5j8aJorltokuTeKW2SCwzQsZieGu4LeTO
         1tltfYdb4sz9OZ5yPgTQLCwN8bZnTA8TkWuj0DikBhC6yIxk/v0zNqTWSv/6EUX99tDp
         6rsS43sroaHuZ9iucO0CGX3ezUjbJ1hNXzlsncMO2ivM8+d89Qrn4EBzTqBq8DaGrA8x
         zGpZrgJHOnDr9D313x/kY5wyqZokofkkMXR/qVNO+1O6JXCT4gEipop7MzcbWpR0WZ3z
         UK0t3IMH9OpoyHqlK/HI9TayRT4rPO7xmaD/MZu49IMjq5T8coyHSoKQUV6JN9nOQDhm
         z1DA==
X-Forwarded-Encrypted: i=1; AJvYcCVuqeYNUzdLIF+hHmRwCFU02CKuZkgBJR5xGKjetcw0rs/szpL03kdtwJAvOxb/1WZXYhy3S6s+GV6n3HVPYLXQjZgJB3uH1OYhn0Yi
X-Gm-Message-State: AOJu0YzEZ03V2ZKMZgTY4xP+p5DzvnIgwPztXvxwkf3fSaVAtNPstELH
	+k7X9jW+3hOA3r2MMboMs2MLtzTiq38/hJf5bWUfTGLHkqJo6eDkcYc+ks70vLI=
X-Google-Smtp-Source: AGHT+IHz4D/tAkiJUKSEKYTo9KdtwALGRXWZMTTOk9WSdUZLPjcPPGovrQbnMAx6QcYLnGz/9iyYUQ==
X-Received: by 2002:ac8:5f4c:0:b0:42c:7b12:70eb with SMTP id y12-20020ac85f4c000000b0042c7b1270ebmr25812453qta.3.1708623592225;
        Thu, 22 Feb 2024 09:39:52 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:51 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v5 07/11] iommu/rockchip: use page allocation function provided by iommu-pages.h
Date: Thu, 22 Feb 2024 17:39:33 +0000
Message-ID: <20240222173942.1481394-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/rockchip-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a12..e04f22d481d0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include "iommu-pages.h"
+
 /** MMU register offsets */
 #define RK_MMU_DTE_ADDR		0x00	/* Directory table address */
 #define RK_MMU_STATUS		0x04
@@ -727,14 +729,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | rk_ops->gfp_flags);
+	page_table = iommu_alloc_page(GFP_ATOMIC | rk_ops->gfp_flags);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
 	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, pt_dma)) {
 		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
-		free_page((unsigned long)page_table);
+		iommu_free_page(page_table);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1061,7 +1063,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | rk_ops->gfp_flags);
+	rk_domain->dt = iommu_alloc_page(GFP_KERNEL | rk_ops->gfp_flags);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
@@ -1083,7 +1085,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	return &rk_domain->domain;
 
 err_free_dt:
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 err_free_domain:
 	kfree(rk_domain);
 
@@ -1104,13 +1106,13 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 			u32 *page_table = phys_to_virt(pt_phys);
 			dma_unmap_single(dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
-			free_page((unsigned long)page_table);
+			iommu_free_page(page_table);
 		}
 	}
 
 	dma_unmap_single(dma_dev, rk_domain->dt_dma,
 			 SPAGE_SIZE, DMA_TO_DEVICE);
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 
 	kfree(rk_domain);
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


