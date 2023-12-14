Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13F9813938
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjLNR6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjLNR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:58:21 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEAB121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:58:26 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-357d0d15b29so1395ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576706; x=1703181506; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8hhXPzgTkSbGrZlVoxMVSGKEuHWo76SGrFtR2YZpAU=;
        b=xGZbKlpO2u0cKvAWGqFmHSjb3EV1nYmRpMMA6kG0/SCMBMXGAp6bWV8OVzcCkECcty
         LEaQDCIecag6Gccbo/Wzy7bHgsEIo9pJ1ETPxYTw4/+I8DqfAzEbBPmvtGRomXSIegfh
         NYgd2JfxHDyyjvYsA60GReXCQBsyARo2jHJwjckE3bnGD1q+C+TMfttWqB0WqJDaHdho
         TW6zCjF9DFIaKhw3QZk0WK01/VqFIibX0Hq6azcwIWmisqG6jSuKyzZcrDhlQPWt02b+
         DBsSqQZosN7/8xOtx2yBm4qmdAcHyWKBCLG8rOqNkobZ5ttgcZ01J4yJq7W3iWXpJwJD
         TUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576706; x=1703181506;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8hhXPzgTkSbGrZlVoxMVSGKEuHWo76SGrFtR2YZpAU=;
        b=bfWE2d7H94hKAIwiwQl5OKPZKWE/oWUc2ivAdWQFcxrjkeDm5ROIElCM54slGBncit
         TCA/pH3Zd95oGTDudIO1+EmXgAkK7KCpqVam4bNSAqqY8Qt2zf49gCabWbtmn/JQzvLC
         /nfoORrrsNQ7cgP/Ldhz84hcOi6KT9SdVIm1tsavzYGt8X7t3IOgWiqVvBDVbCd6nb9s
         d3D1R/cogxhNJDG74E3gIvekOch/CQu1AaNRhPqe05m8thmvnrw//W0HIzmY3AAMH1hP
         AY8q0/vGhz22qcnYico333V5cNk0xCkChQtJjA0hwAjz6zzQioCFCSlLNkieYy/jNja7
         sYyQ==
X-Gm-Message-State: AOJu0YzPmX2LoiUWpRBSCIUxO/Vf3AN96gt1iICJqcMYrGvNZPBP9l2D
        huQIZNnR5CvkhykajEnT1af/0g==
X-Google-Smtp-Source: AGHT+IHmJZOc6yIjryc1hqs+mSoywAgy/Kw7JX+y+PxO7dXRpBhV7x9zJfpibywCzeGN/8UCDSSJcQ==
X-Received: by 2002:a05:6e02:4a3:b0:35f:7497:181a with SMTP id e3-20020a056e0204a300b0035f7497181amr419773ils.2.1702576705658;
        Thu, 14 Dec 2023 09:58:25 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id ba1-20020a170902720100b001d09c539c95sm12769653plb.90.2023.12.14.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:58:25 -0800 (PST)
Date:   Thu, 14 Dec 2023 09:58:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, alim.akhtar@samsung.com,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        baolu.lu@linux.intel.com, bhelgaas@google.com,
        cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
        iommu@lists.linux.dev, jernej.skrabec@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page
 allocations
In-Reply-To: <20231130201504.2322355-2-pasha.tatashin@soleen.com>
Message-ID: <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> new file mode 100644
> index 000000000000..2332f807d514
> --- /dev/null
> +++ b/drivers/iommu/iommu-pages.h
> @@ -0,0 +1,199 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#ifndef __IOMMU_PAGES_H
> +#define __IOMMU_PAGES_H
> +
> +#include <linux/vmstat.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
> +/*
> + * All page allocation that are performed in the IOMMU subsystem must use one of
> + * the functions below.  This is necessary for the proper accounting as IOMMU
> + * state can be rather large, i.e. multiple gigabytes in size.
> + */
> +
> +/**
> + * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
> + * specific NUMA node.
> + * @nid: memory NUMA node id

NUMA_NO_NODE if no locality requirements?

> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the head struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
> +						    int order)
> +{
> +	struct page *pages;

s/pages/page/ here and later in this file.

> +
> +	pages = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
> +	if (!pages)

unlikely()?

> +		return NULL;
> +
> +	return pages;
> +}
> +
> +/**
> + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the head struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> +{
> +	struct page *pages;
> +
> +	pages = alloc_pages(gfp | __GFP_ZERO, order);
> +	if (!pages)
> +		return NULL;
> +
> +	return pages;
> +}
> +
> +/**
> + * __iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + *
> + * returns the struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_page_node(int nid, gfp_t gfp)
> +{
> +	return __iommu_alloc_pages_node(nid, gfp, 0);
> +}
> +
> +/**
> + * __iommu_alloc_page - allocate a zeroed page
> + * @gfp: buddy allocator flags
> + *
> + * returns the struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_page(gfp_t gfp)
> +{
> +	return __iommu_alloc_pages(gfp, 0);
> +}
> +
> +/**
> + * __iommu_free_pages - free page of a given order
> + * @pages: head struct page of the page

I think "pages" implies more than one page, this is just a (potentially 
compound) page?

> + * @order: page order
> + */
> +static inline void __iommu_free_pages(struct page *pages, int order)
> +{
> +	if (!pages)
> +		return;
> +
> +	__free_pages(pages, order);
> +}
> +
> +/**
> + * __iommu_free_page - free page
> + * @page: struct page of the page
> + */
> +static inline void __iommu_free_page(struct page *page)
> +{
> +	__iommu_free_pages(page, 0);
> +}
> +
> +/**
> + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
> + * specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
> +{
> +	struct page *pages = __iommu_alloc_pages_node(nid, gfp, order);
> +
> +	if (!pages)
> +		return NULL;
> +
> +	return page_address(pages);
> +}
> +
> +/**
> + * iommu_alloc_pages - allocate a zeroed page of a given order
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_pages(gfp_t gfp, int order)
> +{
> +	struct page *pages = __iommu_alloc_pages(gfp, order);
> +
> +	if (!pages)
> +		return NULL;
> +
> +	return page_address(pages);
> +}
> +
> +/**
> + * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
> +{
> +	return iommu_alloc_pages_node(nid, gfp, 0);
> +}
> +
> +/**
> + * iommu_alloc_page - allocate a zeroed page
> + * @gfp: buddy allocator flags
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_page(gfp_t gfp)
> +{
> +	return iommu_alloc_pages(gfp, 0);
> +}
> +
> +/**
> + * iommu_free_pages - free page of a given order
> + * @virt: virtual address of the page to be freed.
> + * @order: page order
> + */
> +static inline void iommu_free_pages(void *virt, int order)
> +{
> +	if (!virt)
> +		return;
> +
> +	__iommu_free_pages(virt_to_page(virt), order);
> +}
> +
> +/**
> + * iommu_free_page - free page
> + * @virt: virtual address of the page to be freed.
> + */
> +static inline void iommu_free_page(void *virt)
> +{
> +	iommu_free_pages(virt, 0);
> +}
> +
> +/**
> + * iommu_free_pages_list - free a list of pages.
> + * @pages: the head of the lru list to be freed.

Document the locking requirements for this?

> + */
> +static inline void iommu_free_pages_list(struct list_head *pages)
> +{
> +	while (!list_empty(pages)) {
> +		struct page *p = list_entry(pages->prev, struct page, lru);
> +
> +		list_del(&p->lru);
> +		put_page(p);
> +	}
> +}
> +
> +#endif	/* __IOMMU_PAGES_H */
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 
> 
