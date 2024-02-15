Return-Path: <linux-kernel+bounces-67435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960A856B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2643C285D70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23551386CD;
	Thu, 15 Feb 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N6MkM24f"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED41386C5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019232; cv=none; b=hw2irPFAUKczz5cdUsCW/1dqHphqImxFFBcEnqhxZndB6FuOrMfVl58xgAWC7aGJK9j1leGjYJjr2PEHc1tZ1HcFVozy0xOgRlzVPM5X8xOOQ7KiCWcKYad6I3WoPXDfIUHG0fPHYkxI2skZ6k978Bs6YwRUEwKhi0lFkOODFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019232; c=relaxed/simple;
	bh=+dXm83v4lzGGGWoMkrAhpsoKvqPYYTZkbg+SCOnXjxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6pGrOBdLy+L7Zt0tADy7UGkQ34UgFCF3amxEtCMs6gK/I0KyHzUT9SWYxs2e7JlKVbp3VLihOcZ0aotJ+1AugEgkf9DHt5PpZO5paUjIvCm0K8bJUhbUlzoLiuTZONHUq5eja+gpP7qrwK53IgIhWiWKE/JZDBtkJy0gR15VR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N6MkM24f; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783f553fdabso75486685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708019230; x=1708624030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwxKYOTTfsVxRUkOMJlptUV0ZFZUoBorwA6GkU+MTmM=;
        b=N6MkM24fIlXRxa3OTszGz5z1eTHNELNLwud5JwW4/R8XpbeAdBp1Ur/9uU97Dy2W7D
         +amqpJWJrvWf8SaDTy/0VUPYz+eWv0tG0DlA67QC0LxOeBjzgVAoWD1U24JvrluLtI1X
         H9f8k0Bhb/fF0tsfInxHFANscZzf+w4GfgKJgfME9NYy4bPRDZ8NfKC4+fgraqNhHrgS
         tRCTej7KduBp51W4F1tNThAUpEduFCcxBtUnQfgZ2EqT2gPXqJCJ12yIJwTDAZzNscHt
         KlJdCAbUofoMgmHnUFt3rZIaXR/ZzYPs8K8+GFrWK6Has6zZNqNkPxgdpcCUPqZBYsU0
         LrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019230; x=1708624030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwxKYOTTfsVxRUkOMJlptUV0ZFZUoBorwA6GkU+MTmM=;
        b=rawvDZLvCheAwst5L1BOXz2fkJO+rMtL/PsgbmrJovuOetcdF3M396eCvL+31kFra6
         7mrqg9bjNxF4rZqacdrsLLaxtoAAvfrwDVvuWx1cx3VQKgQclr8124ZuZWkSPsso6gCT
         +FKGvzqE1QGzAeBiCOBhU3L3OzNBGt+YiEWripa5khprg0mRrdYSsxCrBuVqnlzauUxa
         cVRDCaGHB0rbVCeMrFh1TH1L/99OfXHXbOzE93PRL5xykTy0zA8A3Hlc2xyeYVy0ERK5
         qiVk73xkn0sPcmVtXJQo94sOqAO4dp6uCD2COa4naTj2Gzfm1+e8HAuJh+RqHkCOBPT3
         rtQg==
X-Forwarded-Encrypted: i=1; AJvYcCUk0Z4SSOrOLJ2GB/Nabsb+7XM3Asc0IKRDFLsrEDejql+esBIrTHRH9S0GANuNLTXbdCBmy2L2m1TLzxOP9VsP0t2woB2SAsXvxECv
X-Gm-Message-State: AOJu0YxdZhcBupkG4odQ039DLIj6lFQYlOJSGpbIjNn8g1oJB7Zi1riP
	9H5VFy1U9eCcfXN7kIKvUnrNnL052O/S/XCLsMDcMzjhkdZmcC37nnpnOyVAz2Y=
X-Google-Smtp-Source: AGHT+IEPzBiyamH8HajiIAanCfaYKrF4d6zvsj2pCYaxgpaQcWPNs2s/mky4ykJihrWfUqWYewBaKQ==
X-Received: by 2002:a05:620a:372a:b0:787:2d4a:e91 with SMTP id de42-20020a05620a372a00b007872d4a0e91mr9362184qkb.12.1708019229933;
        Thu, 15 Feb 2024 09:47:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bj27-20020a05620a191b00b007873df5a625sm182249qkb.97.2024.02.15.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:47:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rafpE-001DT3-Rz;
	Thu, 15 Feb 2024 13:47:08 -0400
Date: Thu, 15 Feb 2024 13:47:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
Message-ID: <20240215174708.GC1299735@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215072249.4465-2-baolu.lu@linux.intel.com>

On Thu, Feb 15, 2024 at 03:22:48PM +0800, Lu Baolu wrote:
> Use a red-black tree(rbtree) to track devices probed by the driver's
> probe_device callback. These devices need to be looked up quickly by
> a source ID when the hardware reports a fault, either recoverable or
> unrecoverable.
> 
> Fault reporting paths are critical. Searching a list in this scenario
> is inefficient, with an algorithm complexity of O(n). An rbtree is a
> self-balancing binary search tree, offering an average search time
> complexity of O(log(n)). This significant performance improvement
> makes rbtrees a better choice.
> 
> Furthermore, rbtrees are implemented on a per-iommu basis, eliminating
> the need for global searches and further enhancing efficiency in
> critical fault paths. The rbtree is protected by a spin lock with
> interrupts disabled to ensure thread-safe access even within interrupt
> contexts.
> 
> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  7 +++++
>  drivers/iommu/intel/dmar.c  |  3 +-
>  drivers/iommu/intel/iommu.c | 62 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 69 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int device_rbtree_insert(struct intel_iommu *iommu,
> +				struct device_domain_info *info)
> +{
> +	struct rb_node *curr;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> +	curr = rb_find_add(&info->node, &iommu->device_rbtree, device_rid_cmp);
> +	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
> +	if (curr)
> +		dev_warn(info->dev, "device already in rbtree\n");

I would suggest

WARN_ON(curr);

Something has gone really wonky at this point, right?

Jason

