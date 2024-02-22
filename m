Return-Path: <linux-kernel+bounces-75722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C435A85EDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C74B22BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28AEAE7;
	Thu, 22 Feb 2024 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JnM/2ln7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04846FC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561666; cv=none; b=n4yUntK3RJRO1gRAOk/GTvcZLUwWj5guPdVcSNQz3OpGj/OoWIbCM4xZ0uwT58a14XsehKPw2UotHaPMb2BdJeKj0yi322gKO9Hjt8b/POY1LsLdw6goJeKyf6oZNdkwZ7fGHW7XP7A2C6iRfY/6dlDK92KSwyakWFLsE85bgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561666; c=relaxed/simple;
	bh=KFCl6fU1744flulJCJ4xzKP7ZfOs3jlFHZaEmtavvFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9Zn4bAyRzhArRWehtXrGcDCN4r6ctiafZdjIdwHVvcu3SOLlvn8K+qYRlkcAtX0Mh1MYP/J5LGMK5Z5Ck1nlXvPTskOMYBOUfn498TC0ZRDaI08Q+6ElDyTDVBmVxG3nnE08L1Bjw6CcEyE7ZLmOXeONKLl08Q78SRS5W2Tfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JnM/2ln7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42c7c1cb2e9so42174421cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708561664; x=1709166464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ94+F18kEzvELBZYdN+dTOkgUJXZz4kfGzznQZui6Y=;
        b=JnM/2ln76gYW1tBtjZzIQkXZZJUE+c6Cm8ltv7jcJ66U77pb/zP+cWXHwHGCzYx1pj
         AoUW07ViMUJNcUIfSBYbqU+9N/4sTySG2CFoIJz3cjQDoI4lFOwp/cCl2JxT/Zx/jdoN
         G67hrawA6O4rOF772J87zhoyAole98md4lGz4PJdMY/Zla0wr2/LRzbfxI9EVnSeoa35
         YSQBFriQgFymSJWDJyienlKgiY0sRUhTQ5Jclv1q84kjHjQ6pKN8EiOYPZbGPvKKS3Nv
         3Aq9SR2KTmbbWmkc80rcQOHh4kt6eMAEv08Vgb+Dk6mCONnXwLb9b49YkPxoT7aBDTRz
         BKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561664; x=1709166464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ94+F18kEzvELBZYdN+dTOkgUJXZz4kfGzznQZui6Y=;
        b=hAMlOI9DPr0VgOK6lZNcpXo2XI1INqcG7yEfVFmNDWXkO6WurHUTEST9Vgt1orS1ym
         la1l0ivz6IGZLBJ1ACKdK3fCmAR+5l8p8FnQpVZatPR1Q8TcCCco1Edpg0CunUYTtKkA
         NA1dZHsTS/QAinbhQQe5UIftTS8P4g5Mt9YLDtN3mVZM7IPOKFJ7u8tODeIdn7B/WzHn
         gdByfwyjWdeKnTKoJBfdw35oHW8OdwhTROhuq0qZPntvvZ+pNCeFu3CIFYq+7ZsDqhxk
         Cn/xlBaOs8+zp0eyzB5t+v7CfSn2a5o4DzYhHG7zQJp62SCR1G32K2Kgyksf36w0dBwT
         3dCw==
X-Forwarded-Encrypted: i=1; AJvYcCXyiQ2myJEOzQL5SqT+RO+9nb/UK9fjTgzWsIU/TThJqC2qd7BmdQGbF8aW4o3ycI/5y/l9SlT3FvxjH+rZyJHoMX8IZQsG3sdnQYJx
X-Gm-Message-State: AOJu0Yzrrabj7etr+siGp/U1nDBz76P3txE1aYk2KrXJKdp8Du/lfg8p
	VilclGtpOJlcneWJa69aj9M5n7oh7uNA71M7Dd0Z3LN3al95PbEvk6Wf/7Q/HjRB1Y4MHT+J4di
	7/zBJnt06GtvGPlBjPfRix3rC+YvW51XeL98mMQ==
X-Google-Smtp-Source: AGHT+IGOmZsSpC2Y4SyYnlcRyS9zDA76SD5RvGLDRLTwS53fSOkMzROnT7IsmFNQ2MsELKRVDDNbuO1hZG2u+Llmnq0=
X-Received: by 2002:a05:622a:1391:b0:42c:6fef:90e with SMTP id
 o17-20020a05622a139100b0042c6fef090emr25244584qtk.65.1708561663980; Wed, 21
 Feb 2024 16:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com> <20240213131210.GA28926@willie-the-truck>
 <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
 <20240216175752.GB2374@willie-the-truck> <CA+CK2bDURTkZFo9uE9Bgfrz-NwgXqo4SAzLOW6Jb35M+eqUEaA@mail.gmail.com>
 <20240222002152.GG13491@ziepe.ca>
In-Reply-To: <20240222002152.GG13491@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:27:07 -0500
Message-ID: <CA+CK2bBGzM8Xbfq9A7HHNr40oukvAk7-1RK7AFbW3qFcNstb5g@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, akpm@linux-foundation.org, alim.akhtar@samsung.com, 
	alyssa@rosenzweig.io, asahi@lists.linux.dev, baolu.lu@linux.intel.com, 
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net, 
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
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
	yu-cheng.yu@intel.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> > > > > While I can see the value in this for IOMMU mappings managed by VFIO,
> > > > > doesn't this end up conflating that with the normal case of DMA domains?
> > > > > For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> > > > > wrong to subject that to accounting constraints.
> > > >
> > > > The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
> > > > is passed to the iommu mapping functions. We do that from the vfio,
> > > > iommufd, and vhost. Without this flag, the memory useage is reported
> > > > in /proc/meminfo as part of  SecPageTables field, but not constrained
> > > > in cgroup.
> > >
> > > Thanks, Pasha, that explanation makes sense. I still find it bizarre to
> > > include IOMMU allocations from the DMA API in SecPageTables though, and
> > > I worry that it will confuse people who are using that metric as a way
> > > to get a feeling for how much memory is being used by KVM's secondary
> > > page-tables. As an extreme example, having a non-zero SecPageTables count
> > > without KVM even compiled in is pretty bizarre.
> >
> > I agree; I also prefer a new field in /proc/meminfo named
> > 'IOMMUPageTables'. This is what I proposed at LPC, but I was asked to
> > reuse the existing 'SecPageTables' field instead. The rationale was
> > that 'secondary' implies not only KVM page tables, but any other
> > non-regular page tables.
>
> Right, SeanC mentioned that the purpose of SecPageTables was to
> capture all non-mm page table radix allocations.
>
> > I would appreciate the opinion of IOMMU maintainers on this: is it
> > preferable to bundle the information with 'SecPageTables' or maintain
> > a separate field?
>
> I think you should keep them together. I don't think we should be
> introducing new counters, in general.

Thanks Jason, I will keep it as-is. I will send a new version soon
with your comments addressed.

> Detailed memory profile should come from some kind of more dynamic and
> universal scheme. Hopefully that other giant thread about profiling
> will reach some conclusion.

+1! Memory profiling is going to be a very useful addition to the kernel.

Pasha

