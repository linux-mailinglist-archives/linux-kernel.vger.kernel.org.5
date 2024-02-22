Return-Path: <linux-kernel+bounces-76994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDFE85FFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195A01C250AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417E15B10B;
	Thu, 22 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="QG9Fs4JL"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7D157E86
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623599; cv=none; b=ZNz9AcfUO4Gbeow+Jfu+CYZRvxX99DtxKnPi4nJE78D+ORL9Qy/CfVdGwqp5u7i5rVY0+LefPcimbdCN/A3NFpHUaMLl+hFwP7z8fZu8HQjFtI9URmZp4ntikRM9bAAG+lgRvQzR71EgpH1HHIH1NItT+cfd6LRaQw9mgIvO9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623599; c=relaxed/simple;
	bh=4O/lLtqZ0CSeZX6xhgII8Jva5Jk41VTWtWk38T0JqEg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTSwkofnit+oFgXVqe+9oWQSc3ZNoLvGr3g7P2Q0X3KXYQ/oVsnTPnc5csgX6TFb56rLDJ75p7BRdKIxXL+QAdmhmYdAOtFn4UtKeEsl3qptk3gVct0SNYXX6KBNE+6DeIoJscuDshQ0PT9O2j3PBSS7UywtNrZU6hq5ML/I8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=QG9Fs4JL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c758f075dso10246941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623591; x=1709228391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7w3BmgXmvWecR5SKtsZ1cNA/rDbNvV1OeS7wJNdwTQ=;
        b=QG9Fs4JLtoi2i0cYZgoB+0XW/saYPs7n/iFx7DAFdeCmQrebCvGI1z+1MVbxF4EOnf
         3VomTM0Y8NAQ0uXUWoY7N06kRbyj/WVwzPtIZbyIyo4jMw/jNUB0WEfXAWjWFCy2G44C
         Mba5hthSxpARK8tYcTHMc6D5BjTajCDQZ39EDWxKviSppdUOpTZmGksdy18h1Ad3pPMv
         cyxF0wqV1mvHlxupa4NaLpF1Yd0AaYO97eTO9D40x7De4lBkeJDEZQh10VaCKLmuN8pD
         CksMdHPZxQC4tisVtRKGjtg0UGnJshDdh9bHfnt29DfV7XPGFtybwj9yS82ROwqxDgmC
         3Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623591; x=1709228391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7w3BmgXmvWecR5SKtsZ1cNA/rDbNvV1OeS7wJNdwTQ=;
        b=UKhW5xCzQfU+toeAtlUtbgsUIwbqnUXSvh1TUzl9SAiquRg01+DED9317baYrRE0ZQ
         UckV5vpH6hhjnq6AwkvVYwQhVD23rUdZyZ9JxywKJ9JB08QXe2NPEJOk4jpr+x98Zc53
         QJQfoFiMaezgC1KxtCEkf2F9VDBKCAEAL+PgI8fn8rFC5flV9D+SxDt04AVNQK9xikLh
         E6LQd/TbydhH01HSHTK7tNW1Yll7UcLSRQT5Mdie7wzphIQKSNpbOuyt0Tb4rbGxpSKc
         hvsKSdtO6nw8PwODvbsCAmFxy7TSvu33sDUUNxhSuyZQk5e/vnqwwn7YbFhgtbPCvtCa
         uG3A==
X-Forwarded-Encrypted: i=1; AJvYcCWnnNseWFSzYXZM58oVrHI50FqgWgWGyeEVJuzdfCV0APByztNONg7YRag1iR8EyywY7x8pNDoV7HEfudxnnPWHEClM05WZk4WipruO
X-Gm-Message-State: AOJu0YxjjA2WAtDQiy3VwC4rT6gKwlGw06ofzW451c8pyJPyr95MlqPe
	ZOLUqzLAdIDM3lCOGnc5zW3ak7tfwhWpvV/C/BhoHUu9pZvUx1nABDj825BKoJ8=
X-Google-Smtp-Source: AGHT+IG90zBa6YLMZGIfCYT7Th/1b5UWVffhOhrq9tGqR1mvmgjPkxAiIwv1iDqI+0/4uYQJoXyfRA==
X-Received: by 2002:ac8:4e82:0:b0:42c:8054:8a with SMTP id 2-20020ac84e82000000b0042c8054008amr5212735qtp.27.1708623591384;
        Thu, 22 Feb 2024 09:39:51 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.50
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
Subject: [PATCH v5 06/11] iommu/exynos: use page allocation function provided by iommu-pages.h
Date: Thu, 22 Feb 2024 17:39:32 +0000
Message-ID: <20240222173942.1481394-7-pasha.tatashin@soleen.com>
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

Convert iommu/exynos-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2c6e9094f1e9..3eab0ae65a4f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -22,6 +22,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include "iommu-pages.h"
+
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 static struct iommu_domain exynos_identity_domain;
@@ -900,11 +902,11 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	if (!domain)
 		return NULL;
 
-	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
+	domain->pgtable = iommu_alloc_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
 		goto err_pgtable;
 
-	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	domain->lv2entcnt = iommu_alloc_pages(GFP_KERNEL, 1);
 	if (!domain->lv2entcnt)
 		goto err_counter;
 
@@ -930,9 +932,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	return &domain->domain;
 
 err_lv2ent:
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->lv2entcnt, 1);
 err_counter:
-	free_pages((unsigned long)domain->pgtable, 2);
+	iommu_free_pages(domain->pgtable, 2);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -973,8 +975,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 					phys_to_virt(base));
 		}
 
-	free_pages((unsigned long)domain->pgtable, 2);
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->pgtable, 2);
+	iommu_free_pages(domain->lv2entcnt, 1);
 	kfree(domain);
 }
 
-- 
2.44.0.rc0.258.g7320e95886-goog


