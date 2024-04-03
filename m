Return-Path: <linux-kernel+bounces-129693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD7896E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D131C25FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542F145333;
	Wed,  3 Apr 2024 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b2TRnMxX"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20171420A2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145557; cv=none; b=H0V7Q4y3BB8oMT5eI7VQHk01aksdl1jFgcG5QjMnda7GDLa5g6LaxGgCZ5CH2NSz2wXpgZk64pXwQCxTbM65ZsHTlayb6d/06H27ksHtkQIg3ZtPMEVwBE4UVNw+N2hltQU/bvzPPMHvI1EEYR1s2Ui26ENGMjLG+cmMpxgNAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145557; c=relaxed/simple;
	bh=XFcCHGaOu8ShUjCIksZfpjmaj4CJ7be6Fa9HhQO/fo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMy57T/YFNo0SHsdy6/BztwfWikEIN6Hgk3qENPDUdnvLA2I/BR9BdlozU5DfRp4/OCHjh08C07GjvD2DzQfvwaE8sDeLJiR2Igbna+x0xUmOFMuRR1M0YfhiAKVBS+F6Y3qp4JsUU1t2Gy0RzPt/MvWU8C6HtDzgJ0giyJf0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b2TRnMxX; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-229bd1776dcso2821895fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712145555; x=1712750355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKnBqN3AR3ILG1kqJKOi7mh33arGTjn/cFRm8lVOtNo=;
        b=b2TRnMxXdaEhon4WsjuhIMbWRZCE/KZ2j754uPWNad59b/5j6q8JLx/vJdWt8ddiQ8
         kBY/tY9uiGToQCESUwXN89T5SrWdqGB3JHJNKackg2GZVFAiK92wI3MCxezYcGwTzsmm
         YVoknTjqD1eyxverWCewEV5m+CHrQZP9wgKsZ5jfq9E25J8pVI0RrJNV1e8UwWCCHV/U
         gTqwdyatTOa3aFbeHI5P7qSR95or2Q4qdp/o8/P4fp7ZL+o2SWKtaedWC8vU7E95OFND
         9PJ9d9h7WgyZaphxe0R69uZFZeRbs5+jzv9sO1OXjkBrpfrt1F8RWSbfXNx+5omp0M9J
         K5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712145555; x=1712750355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKnBqN3AR3ILG1kqJKOi7mh33arGTjn/cFRm8lVOtNo=;
        b=nlzd42tOVo5EsCWh2bv2vHLqC+ibFCHM71W0CxcQKDIZMaA/G0aXGUse2VkRkSvF2c
         jgwxOTPnrR2+sK5zO/ZY2e32dOae7Lg3sd+0bbUdPqFJLWXEdKzxdxEEeIXUych/vl8B
         A1Xbnp+l8rOUMm/2WV+W/uCOdKmf/mnlAehXoy2Ccycujgu1TJ0zW7FIzQDWYememhxP
         +yaTAC7xjepcZHfRP3RWwPOSr4mDz6888wlNlfRCLQArsIRB2YEQEl6PpiRGYVOa991d
         auIVYKj1hgk+dgu5AVRVVDuHZkdUs5rwsjnbe8nVuKjecBooBQn6PMfWR4gyi9Z/ZP7J
         S2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUZyUdz15QR/sh5yEroq13XqIqsJ2VhNEKJwYXpK4cSZbkT2I/JM2xkZlnbUQN/rm3rJeK9AoexWtmNx3zFBoCwylEYbug60BKIcfCf
X-Gm-Message-State: AOJu0YzQbWuGRbbaO1lzs8fMRU/Ww+hUZh0grG5vGAdQGnFA5JPTkDBl
	LHvplKE2qPqkG4Uwmcwslcl01njs6r8aAUmzubX7ASSowpyt48CQbUZaT4jMCOI=
X-Google-Smtp-Source: AGHT+IEcrh3sfjtdruqsJXaJuUdnZAhAWtheqUdpYYQNj/BaEl7xqFHk1YKUrYVoGspTRvSJh+dkig==
X-Received: by 2002:a05:6870:414a:b0:222:8943:df2b with SMTP id r10-20020a056870414a00b002228943df2bmr16943300oad.16.1712145555075;
        Wed, 03 Apr 2024 04:59:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lk8-20020a0568703e0800b0022e9af4f5a8sm199096oab.34.2024.04.03.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rrzGr-007GCe-4l;
	Wed, 03 Apr 2024 08:59:13 -0300
Date: Wed, 3 Apr 2024 08:59:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240403115913.GC1363414@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403011519.78512-3-baolu.lu@linux.intel.com>

On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> +	/* A bond already exists, just take a reference`. */
> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> +	if (handle) {
> +		mutex_unlock(&iommu_sva_lock);
> +		return handle;
>  	}

At least in this context this is not enough we need to ensure that the
domain on the PASID is actually an SVA domain and it was installed by
this mechanism, not an iommufd domain for instance.

ie you probably need a type field in the iommu_attach_handle to tell
what the priv is.

Otherwise this seems like a great idea!

> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> -	if (--domain->users == 0) {
> -		list_del(&domain->next);
> -		iommu_domain_free(domain);
> +	iommu_attach_handle_put(handle);
> +	if (refcount_read(&handle->users) == 1) {
> +		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
> +		if (--domain->users == 0) {
> +			list_del(&domain->next);
> +			iommu_domain_free(domain);
> +		}
>  	}

Though I'm not convinced the refcount should be elevated into the core
structure. The prior patch I showed you where the caller can provide
the memory for the handle and we don't have a priv would make it easy
to put the refcount in a SVA dervied handle struct without more
allocation. Then we don't need this weirdness.

>  	mutex_unlock(&iommu_sva_lock);
> -	kfree(handle);

Also do we need iommu_sva_lock here anymore? I wonder if the group
mutex would be sufficient..

Jason

