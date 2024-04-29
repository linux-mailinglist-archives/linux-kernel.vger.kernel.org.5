Return-Path: <linux-kernel+bounces-162501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80E8B5C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F58E1C21FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224BC8060A;
	Mon, 29 Apr 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R+8Z798H"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352777F10
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402594; cv=none; b=JhuzrBhdEaNPdVWWn6qCbvM1GJNRJCWINCooWIKCCtMH5f3L5wDs2j5Aa8+tEvWvaLAZc8BuhutP8dKa2BRtz1psLep6el7XD8CLd+EdRFZhWFt6DisVyRIRQBrjhM4qJgTohNOpWPBZPZYb2s5soiFF5/8JEF7T/8wzE9QEZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402594; c=relaxed/simple;
	bh=DaJQZCDIDOH7FlCCzFmzVcn1pnb5oiVg8UdCJ06JAo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AedOhejGRXxHmM3NWlvkRqBxVv8rxubjxx3a/tl2aziFDMpowWmPkjFgw+OU1+x6vrfunPsOpfCPpIZYraXb+SLMsNpL0V+GV8ySK2gvL6sloJ0oCUc/IYW+Q9cfzbM27jR/qlmtn54RtZwR+LXhMdMAiGbwtz03hBt5Za2OfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R+8Z798H; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-790f4650f93so114217585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714402590; x=1715007390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyfECjGT2cPe5HE/2z0fDQqdazh8yGo98dGumX8os9Y=;
        b=R+8Z798HatwnIzy4kNxr6v+xygvR3lCftmADUUFSbwDy57KRD+6xyzBN562GJNHOgl
         w8x1Y80uasv/PbtCy/fS2rmXibv6wzPgZf6X8BpUu2fHheyAuAcXJLfj4ZtkRZ1LG/Yt
         FTJ9D++q8nzRFutLte4Bp1MtKevBraFEXItGT7S2vXxn8UL03IEUjzqDMdIPr2liZAP0
         Vu6+PJ04sr9pnmlA8UcQJUknPEgo52OjH9lhOA8nkgggMPWmUoiR3DBXPmnf35lEcPlY
         Ei0fkg1QUedndRI6WCra+OZv7Oj6GX2oF19F/KRGXpb9+hHZNpX8b+6ThPhz2r4iOXo/
         ER5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402590; x=1715007390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyfECjGT2cPe5HE/2z0fDQqdazh8yGo98dGumX8os9Y=;
        b=qRFKUxNtpcFlD8hHpypxY4XfP0aTm9RP7hKUi8wi2fYAFm2bGLcYGOHR+9JRLYjrKY
         rpBq4cXd3GyCdDgXqwnjEU/Cz1P6w9nj9UAOGCtebLR4u2raFNtsJtjepBnGBvCqEXXd
         lnDXR0LbvHsQcam/pfGgm1yYuP6hCvkPusGSlPVTv/kJO7B2rAgWYiDGLf+PjaUWjmvR
         IFZYVxwhBorxLDDj+jboWRQbMPgrBl/rZD4D7RXBX0cDIA2sXMMmwJC9G2iCxtHtwj4Z
         i+pxRT3yeQxKznCJiyoelCfxJeGmfETNcMS8xqdzR2MYN3cyfiI/l03rv5Q1wll29GZs
         riqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7NAWhI6coObpDrNw2q962E9AOXTg4OKUXIs/WrnrsU6ReK/pGSSrbLGLPevNvWmkre4t8a1lWt0GrsYavCJjjmrJ/rlCNwwqTDhYM
X-Gm-Message-State: AOJu0YyyuuN7rA2RgTxeOmMlEngtGUG/gN5HWWgvPGsI39xLiaIuW3Xy
	8/cbdMnFunwDDWG1/65+CFpTfQq7jmGaIwn6l9IBhpOj3gGNGHUUWFzOFuDKljM=
X-Google-Smtp-Source: AGHT+IGVwrWen1NFJQXMe84L+uew1vCbsRt/8eFOs7aaXjU9TsngFFpgUz3SkXHgLUIQ5SMhLpHX/w==
X-Received: by 2002:a05:620a:47c2:b0:788:31a1:4a16 with SMTP id du2-20020a05620a47c200b0078831a14a16mr12178748qkb.43.1714402590105;
        Mon, 29 Apr 2024 07:56:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id op53-20020a05620a537500b0078d67d40c49sm10499522qkn.70.2024.04.29.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:56:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1SQf-001WJH-1Y;
	Mon, 29 Apr 2024 11:56:29 -0300
Date: Mon, 29 Apr 2024 11:56:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rientjes@google.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC v2 2/3] iommu/intel: synchronize page table map and unmap
 operations
Message-ID: <20240429145629.GO231144@ziepe.ca>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
 <20240426034323.417219-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426034323.417219-3-pasha.tatashin@soleen.com>

On Fri, Apr 26, 2024 at 03:43:22AM +0000, Pasha Tatashin wrote:
> Since, we are going to update  parent page table entries when lower
> level page tables become emtpy and we add them to the free list.
> We need a way to synchronize the operation.
> 
> Use domain->pgd_lock to protect all map and unmap operations.
> This is reader/writer lock. At the beginning everything is going to be
> read only mode, however, later, when free page table on unmap is added
> we will add a writer section as well.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
>  drivers/iommu/intel/iommu.h |  3 +++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1bfb6eccad05..8c7e596728b5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -995,11 +995,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
>  				   unsigned long last_pfn,
>  				   int retain_level)
>  {
> +	read_lock(&domain->pgd_lock);

I think no to this.

This is a very performance sensitive path for the DMA API, we really
do want to see a lockless RCU scheme to manage this overhead here.

This would be fine for a VFIO user, which I guess is your use case.

IMHO it is not a good idea to fiddle around the edges like this. We
need to get the iommu code to having shared algorithms for the radix
tree so we can actually implement something good here and share
it. Every driver has the same problem and needs the same complicated
fix.

I keep threatening to work on that but have yet to start..

Jason

