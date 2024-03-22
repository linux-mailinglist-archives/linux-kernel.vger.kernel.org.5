Return-Path: <linux-kernel+bounces-111839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF4887185
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68421283B69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0725E3AF;
	Fri, 22 Mar 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PcmiYUZr"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A75D752
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127054; cv=none; b=b6FO0QLZz9Os/C5k/7A0WxJkgaLi8nWKqexyxHhFZ2/S+svirv/trMmVuulWW6/BaSElrhyht/mq52DtpuCxMMRrG+QWYpDSrLv4XyBOThklfmki9UycFHRSLZDNhPrt5mTe+IOrr+X5eFgF5tR68eTX/xoqajS3kfml9JYNk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127054; c=relaxed/simple;
	bh=F2cON8G466CEiB2xctEBotK4ZUZCOX8kUGGaoxBRHl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjICyPaKqMfskdYH8mi3DirNH12fM8UAsr4zqW1XmV1B6AP2mAWkapjRmTqXdMT/Lr91/nsOmAM/D2AyX57y4GDm6jvZM/hHB3kEj/RCVneam9I0DONqm8qClmSHCW60GCQUNVTRYYNqDK7ANXQyMmn75NWowjAoXFJO/+nApmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PcmiYUZr; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690e2d194f6so16772266d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127052; x=1711731852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bmTLjYhpzrW7g0IUEWDDdCG7VehUoT56RlgrSoKr94=;
        b=PcmiYUZrxYG5dOtd4ASPJlgfv3jsdIcMl6TtTxMMboImHzjDeq0sg8QzUx/aD76uhI
         BbSd6N1logm6ciWGkvJj3Ght0gDlYJIJBctvGM9t7X+FuwR8Jfp0E45TJXmyCMMZhlH1
         kRuYoLPwdSOiAjdC7ultxdpVJTl90ce7BVVs6g3BOlqnXaRlffv5LT6j+97mAxA9T4p0
         m6jfT3EI7u+K2uh0GjkWNPOPgCtsw3kfaUKv3BeqWQP5+i0ljV6tgdOkBaPllJ4FGSTQ
         kA4yfL7Yj7sqtyn+Js/D0H8BI2Aq8NIu5biCkx/l56XalByFtITSa5w6TZpMIG8+JOeZ
         gUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127052; x=1711731852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bmTLjYhpzrW7g0IUEWDDdCG7VehUoT56RlgrSoKr94=;
        b=ovfYXqFkr9iH0gh9WiixyYaCr85DCOdPbIwTnLlDFcTaFdJKKjxUTk3a0j/CnR3FwY
         bcCLjzJjekL9KNLj96lPnAX2gK+sNoOfRfpw2ewKw0Dws/10+/bFsQhYdaMrXnz0LtXi
         gMX86eY897PEcmYBMkF/zUYne3cGqjA+FJeApmLXAgtkRxTpdnCfbCzQjjfMeL7ThdnU
         isuX+QmU220QFoJNWW9Ow2UH5k18E4kozNVPomlu8PKIcEDhCaHl0Moq19FREFUFUFX+
         iw7mSQQ+Yfgc0E9zxXdnaudSQiJuJH1T7NdLKUIECCf85aE2A/zAou38duKpSZ5ZwlNm
         86sg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrUMubkU44v8XN4EJd1t+dLGZ3fv+TAAJchN/Nb5tBnZJ6GbHjGFl18UGnKCZowlKvqUdLmZKaVd0Y7HwORtpg7tcIDEzcVwPOPH9
X-Gm-Message-State: AOJu0YxGEQgfHNB6QtJaGbYtiJRrhjWV3hHdrE+jucaedwnVOTRbxETe
	gzMpkjlNSSxxcxHZ3Gkc5PsgTtoaRqmsk8c4P2swpz86+O23fPH9igs0PyH8/WE=
X-Google-Smtp-Source: AGHT+IGCuCLf0r0lAOyGbCQQgecN3nqXlLc/lQ8IcmAc2LgzDweXJnwWqJ+Euwk9ABhKAExpPSSADA==
X-Received: by 2002:a05:6214:1250:b0:696:47ea:df2e with SMTP id r16-20020a056214125000b0069647eadf2emr2633333qvv.23.1711127051828;
        Fri, 22 Mar 2024 10:04:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q15-20020ad45caf000000b0069124066c2fsm1223742qvh.140.2024.03.22.10.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:04:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniJO-00CS0w-OK;
	Fri, 22 Mar 2024 14:04:10 -0300
Date: Fri, 22 Mar 2024 14:04:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Message-ID: <20240322170410.GH66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
 <20240308175007.GW9225@ziepe.ca>
 <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>

On Thu, Mar 14, 2024 at 09:41:45PM +0800, Baolu Lu wrote:
> On 2024/3/9 1:50, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:38:58PM +0800, Lu Baolu wrote:
> > 
> > > +/**
> > > + * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
> > > + * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
> > > + *                                   valid.
> > > + * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
> > > + */
> > > +enum iommu_hwpt_pgfault_flags {
> > > +	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
> > > +	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
> > > +};
> > > +
> > > +/**
> > > + * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
> > > + * @IOMMU_PGFAULT_PERM_READ: request for read permission
> > > + * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
> > > + * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
> > > + * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission
> > 
> > You are going to have to elaborate what PRIV is for.. We don't have
> > any concept of this in the UAPI for iommufd so what is a userspace
> > supposed to do if it hits this? EXEC is similar, we can't actually
> > enable exec permissions from userspace IIRC..
> 
> The PCIe spec, section "10.4.1 Page Request Message" and "6.20.2 PASID
> Information Layout":
> 
> The PCI PASID TLP Prefix defines "Execute Requested" and "Privileged
> Mode Requested" bits.
> 
> PERM_EXEC indicates a page request with a PASID that has the "Execute
> Requested" bit set. Similarly, PERM_PRIV indicates a page request with a
>  PASID that has "Privileged Mode Requested" bit set.

Oh, I see! OK Maybe just add a note that it follows PCIE 10.4.1

> > > +struct iommu_hwpt_pgfault {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 pasid;
> > > +	__u32 grpid;
> > > +	__u32 perm;
> > > +	__u64 addr;
> > > +};
> > 
> > Do we need an addr + size here? I've seen a few things where I wonder
> > if that might become an enhancment someday.
> 
> I am not sure. The page size is not part of ATS/PRI. Can you please
> elaborate a bit about how the size could be used? Perhaps I
> misunderstood here?

size would be an advice how much data the requestor is expecting to
fetch. Eg of the PRI initiator knows it is going to do a 10MB transfer
it could fill in 10MB and the OS could pre-fault in 10MB of IOVA.

It is not in the spec, it may never be in the spec, but it seems like
it would be good to consider it, at least make sure we have
compatability to add it later.

> > > + * @addr: The fault address. Must match the addr field of the
> > > + *        last iommu_hwpt_pgfault of a reported iopf group.
> > > + */
> > > +struct iommu_hwpt_page_response {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 pasid;
> > > +	__u32 grpid;
> > > +	__u32 code;
> > > +	__u64 addr;
> > > +};
> > 
> > Do we want some kind of opaque ID value from the kernel here to match
> > request with response exactly? Or is the plan to search on the addr?
> 
> I am using the "addr" as the opaque data to search request in this
> series. Is it enough?

I'm not sure, the other discussion about grpid seems to be the main
question so lets see there.

Jason

