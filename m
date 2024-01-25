Return-Path: <linux-kernel+bounces-38855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFBC83C74C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D11C21018
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E6745CA;
	Thu, 25 Jan 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="clZzaOqo"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929617318D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197981; cv=none; b=FCi2aZE+DQBwNereViokMC71J+Cs70y9vJOaF5CRpF+XaHtQJhrWkG/JSw9PnAVtr8xMwRfiYGNHhKln+Ze2IoA3Q0jUHWkop0BvQv6m7nA0g44WP62ceprdfX5mY0YrUJ14GYZ5SoyUhNglk/379Psq6rkb9I1t4z7IrJ5l/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197981; c=relaxed/simple;
	bh=H2izjFS9sYNuj0VvmCs+Daj1q9NcisBfDmvoKcdJvHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHoimYMA0JCdrAbUjJJrTDgN1WAmrbsBdwA/GJnWOuXB+MM50vAfTGJjhI85eVgC8f573/OHmXw8wxNwohfH26OStEjMX7A3/P+rtFCqp3XVBsy7U4M2o/yjHYzw16kbASourPNCVOGTqUc3uAnFpf5HEklxcPIs1xDQ6IyVHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=clZzaOqo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783bc26b24aso63617185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706197978; x=1706802778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXkcT03fQJzA7SU2tkYYGBe/1RUS6Vir93r0aF05Hs4=;
        b=clZzaOqoNYx4Yy1lg44/A42ayqTeOFK3t2FRWb6iQJ1y1YMGeKrJsPh11NriAwrCnT
         Qn+O3fOAkE6DfrDNON6+lr2MoIAYGSCOuqfTnkI3Jd3S4Y9t/Et2SuxWoawP9hHY2mri
         UkUA+Ihx+WE+a5sNK0pt9uE4GpLbVmpPVUyIEq4g0Z5i506ixui1gBrGoTJ3zQZLgaha
         EREFfHC/lijnXPpiwBz78tHoq8ZDtpwdTMZWvUPXaWIwJQhq1oW93wpoiI3zPmvlvomE
         Ht6E+ZOaqEgLbrx6Xj0bDtmGRIt9i17hXPHTBHFmIveqOPmHongYBWeegV/w+XsdnLgc
         Sh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197978; x=1706802778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXkcT03fQJzA7SU2tkYYGBe/1RUS6Vir93r0aF05Hs4=;
        b=lvZjvsHGqZkt8BAw4ejFPh/j4kdx7koSGphfYy0jbUul64RoD24ZmMR4/lV3oMEzW+
         Edd5ZaXtU33zmEh68RU6z39rltIpHEhDZGYeGqTzKKXO//HsmgSxQArfojNKRc2v+KAb
         aalO1vj9L5Si9SU6U/GRdD4uL00Hb1yWZRDaoBnQiNdvf2zRWaoCEbtICgeglSznts1n
         XbjCRZJDpfsI6OtjJV9zD4J6MzW85A4O2bSQ30CEKSCousDzh05c7azYz1KJVNyp2CPH
         wJRKcXBz0VeItu5UREJidBj4d7my0qX3MuBWzxHzkRxVu180CEHfAVXqdW5Ufq4DU22j
         WcHw==
X-Gm-Message-State: AOJu0YzM7hAT6UKKjFzz8gSoD8JX+o8+x7uDesbwZE9QDzcua13llHmj
	CXrTPCNXyxxqMr1ObK5809SOvX9zzhbCMw8s6EfVOlvclYRklHNrFI8UWHGl5bc=
X-Google-Smtp-Source: AGHT+IHXajryzJQCCc/lrmBpkvYox8Vi8CCsZcjFR2/aDDSHWFndELKjMTjZNZKUBFCwhwt7YOyYOA==
X-Received: by 2002:a05:620a:2ed:b0:783:9b7c:50c with SMTP id a13-20020a05620a02ed00b007839b7c050cmr1365722qko.119.1706197978503;
        Thu, 25 Jan 2024 07:52:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a0a5c00b007833dbbc07asm5167764qka.0.2024.01.25.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:52:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rT22D-0091ri-E7;
	Thu, 25 Jan 2024 11:52:57 -0400
Date: Thu, 25 Jan 2024 11:52:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com
Subject: Re: [PATCH 2/2] iommu: Fix the domain type checks when
 default_domain is set
Message-ID: <20240125155257.GX50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618452753.3805.4425669653666211728.stgit@ltcd48-lp2.aus.stglab.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170618452753.3805.4425669653666211728.stgit@ltcd48-lp2.aus.stglab.ibm.com>

On Thu, Jan 25, 2024 at 06:08:52AM -0600, Shivaprasad G Bhat wrote:
> On PPC64, the iommu_ops.def_domain_type() is not defined and
> CONFIG_IOMMU_DMA not enabled. With commit 0f6a90436a57 ("iommu: Do not
> use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled"), the
> iommu_get_default_domain_type() return IOMMU_DOMAIN_IDENTITY. With
> commit 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove
> set_platform_dma_ops"), the defaule_domain is set wih the type being
> PLATFORM. With these two changes, iommu_group_alloc_default_domain()
> ends up returning the NULL(with recent changes, ERR_PTR(-EINVAL))
> leading to iommu_probe_device() failure and the device has no
> iommu_group set in effect. Subsequently, the bind to vfio(VFIO_IOMMU)
> fail as the iommu_group is not set for the device.
> 
> Make the iommu_get_default_domain_type() to take default_domain->type
> into consideration along with default_domain_type() and fix
> iommu_group_alloc_default_domain() to not error out if the requested
> type is same as default domain type.
> 
> Fixes: 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
> Fixes: 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled")
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  drivers/iommu/iommu.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Are you OK with this version?

https://lore.kernel.org/linux-iommu/20240123174905.GS50608@ziepe.ca/

?

I think it does the same thing

Jason

