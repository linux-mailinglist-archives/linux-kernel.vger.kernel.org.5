Return-Path: <linux-kernel+bounces-131542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48789895D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48DB28157E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FD129A6F;
	Thu,  4 Apr 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="bpSxcZ8Z"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242FA56446
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239016; cv=none; b=cYRVn+qvFfPXs3FSvSJMqeXR1pYXj21L67dxWH9DKPeAlmiGx1tFNrAMBfsRTcgghzwSTm1rO8ZnlIjaqTr+O7++lVLAgQ7ZwZCYXNsEMq7oFS9IcdrxL/AiX3WA28HTpVuOiSupGR/W0Tb/V4oRGBUEeSDPi+u8l0nPeQGCsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239016; c=relaxed/simple;
	bh=dyJ8/jg3OEVZu3rV6eRPJgBUaaPW7kEy4ZucbMmQDWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5WJQYN1TsqKw9+WMeAMNzGEdANMH+afy9ZsiMJnYDRXb5MHYhyFE8A5zP7FulhcVhXb4d20um91QNW0U6cL+dnkQpyG/HmkWDqjl0CaUjWlUUlKCpL6YjLVYcrQQ0oPz0tdH74+iKMfsTHLDRxvFet4N24Ou/YmhKvOsPzxv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=bpSxcZ8Z; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430c63d4da9so5707731cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712239013; x=1712843813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msc9tQgMq343nFV4/DBdPcJS7hGm3uD+5fv8GwkMOjA=;
        b=bpSxcZ8ZLk4bpaTCLJg2MyKrmUNAd9lPLsMj9m2uhkhvl5+tze/0OzJhZQu6jksKt0
         hTY1J6BkGqD9g9NawhYR4OBTb8T5PkvAapR7gOCaRMC/OV4vwxAji0uFGxw1PwU+K03g
         5ETEx7lvWaXtXWXpQqny7lqmLNKlSsSaqPsf6l0SxgEWUIG4hXGbeHrMsDMBfu/0XXw6
         eHXGjJ4FMR9bGGs0v4+W2L7FzsOq4YgNz2r2PfEoVxXvjkUemrK3sXUd5gxGWsKzWXxf
         A6Klmrz96svkE/SZJc9/S9ycPkeBfFdkXjsB07aJg/7IB+FH8AQmmGwpCSCaddcXe+jY
         9RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712239013; x=1712843813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msc9tQgMq343nFV4/DBdPcJS7hGm3uD+5fv8GwkMOjA=;
        b=bvJJwbHrA1hn1AQ6Lo5C9gFJe3PnmwlGq5Zq5K6e0gzEGAbYGEiNDO1K9B//SI7bmt
         53WS31vOIdxss28Wo/ibkcvUJbpJbeyQ4TXgmTwTgnur/4ReLiECQ22XMf8zb515JOPO
         qoaRoct7NbTlJQwj46QwxjpxGWUlMsdTrtg40wMfmKX42QXYbk6lfdezCZtPgXTXPY2F
         weTFmSiWTjQTqglkEK5Z8lmXZrGTl4Zp9Tv2G8+pyrU99f9EEFcoMhG3iU5Piej0UKUQ
         PwICIbpaMCiIcAR7HWr3swouS07OEUu/qcdxfrVUeLvNhHxCCIDa1SqLcIvWvx1njNn2
         kjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2cfgXEZ7gYolOwnsoMC93PcO4LHFh+LcdTbIWvSQKu5GqiSQbU9sUILp/drT7kRscvLj2xZnnptrRJndxBQtzJgtot2NWgX72C1vq
X-Gm-Message-State: AOJu0Ywb78ei2be2J+7LNGs8ETOj22mHmcLlSx7a/qmXhyAGBLZghM2n
	OliYW/FkWLRE5azH/fa5PsbPv1UxZwcLraTMl4jBjZTrGEVFrb/nvPIUMJVmZ21k8xRCjPODbAr
	UVGD6V9TCLGU1RvX1BvnlvX/wIEo+OcKQU0+TAA==
X-Google-Smtp-Source: AGHT+IH9S7DU2DIf+z4/lTa3f7DcyJz1Y9kNOGjz2IQr7tohPqSHHhqayAGWHjuk7zhrLKiTZ6wb5Cu4ZzpulPIDrg0=
X-Received: by 2002:a05:622a:2:b0:431:378d:afa with SMTP id
 x2-20020a05622a000200b00431378d0afamr2733138qtw.34.1712239013126; Thu, 04 Apr
 2024 06:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
 <20240222173942.1481394-2-pasha.tatashin@soleen.com> <20240404121625.GB102637@hyd1403.caveonetworks.com>
In-Reply-To: <20240404121625.GB102637@hyd1403.caveonetworks.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 4 Apr 2024 09:56:16 -0400
Message-ID: <CA+CK2bDmya+768tOvF0N-BYq8E+RwBw4xS8vC+MmbU9eoOv_3g@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] iommu/vt-d: add wrapper functions for page allocations
To: Linu Cherian <lcherian@marvell.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> Few minor nits.

Hi Linu,

Thank you for taking a look at this patch, my replies below.

> > +/*
> > + * All page allocations that should be reported to as "iommu-pagetables" to
> > + * userspace must use on of the functions below.  This includes allocations of
> > + * page-tables and other per-iommu_domain configuration structures.
>
> /s/use on/use one/?

I will correct in the next version (if there is going to be one).

> > + *
> > + * This is necessary for the proper accounting as IOMMU state can be rather
> > + * large, i.e. multiple gigabytes in size.
> > + */
> > +
> > +/**
> > + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> > + * @gfp: buddy allocator flags
>
> Shall we keep the comments generic here(avoid reference to allocator
> algo)  ?

There are no references to allocator algorithm. I specify the zero
page because this function adds __GFP_ZERO. The order and gfp
arguments are provided by the caller, therefore, should be mentioned.

> > + * @order: page order
> > + *
> > + * returns the head struct page of the allocated page.
> > + */
> > +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> > +{
> > +     struct page *page;
> > +
> > +     page = alloc_pages(gfp | __GFP_ZERO, order);
> > +     if (unlikely(!page))
> > +             return NULL;
> > +
> > +     return page;
> > +}
> > +
> > +/**
> > + * __iommu_free_pages - free page of a given order
> > + * @page: head struct page of the page
> > + * @order: page order
> > + */
> > +static inline void __iommu_free_pages(struct page *page, int order)
> > +{
> > +     if (!page)
> > +             return;
> > +
> > +     __free_pages(page, order);
> > +}
> > +
> > +/**
> > + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
> > + * specific NUMA node.
> > + * @nid: memory NUMA node id
> > + * @gfp: buddy allocator flags
>
> Same here for this one and other references below.

ditto.

Thank you,
Pasha

