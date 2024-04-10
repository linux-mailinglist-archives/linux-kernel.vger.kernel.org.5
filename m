Return-Path: <linux-kernel+bounces-138911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2889FBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535411C21F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363B16F0EF;
	Wed, 10 Apr 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kIZaAumj"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C416F0DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764195; cv=none; b=Kz0QHB/7CRLz86zvSma2WP56IlE7h3uol2YX4KKH+hx7Iq2/5XLHt38J0vjfju3qFdw7RqIH4MEvNwXdacqk6Dkc7dosbpDZfiudSq66lHy5HZg9TYzi7h8vRatPie7JJ1nspyXrPn9oFabBHm7OfsTj05u3hwdgS0U0FwKW4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764195; c=relaxed/simple;
	bh=AxHwz8VF1NhYu3Vp1CovFU8cr9PNL/8I3H9tcZr+m74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc+76Rvny/y6jmrL/PSqiNPHkr3tf4ykwaJvhomGRw53kH9xaJU/dqRwVCEzMS6C5MVLWR6+wEIJNlRiK+/+7WSICaYUsoCBF4yOSdbFod62ZklSmZTJ7ZR48mZYJ3vZXg8+f5nMo9Q3AzaS5z6fWkWEa9jF/rV7gY0ssGNs3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kIZaAumj; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-479f50bcd7bso1080857137.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712764192; x=1713368992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvi4RlGA0eUYMMXxvrO6LGP3KPA96p3DhN0FfsCggYI=;
        b=kIZaAumjpkFRXQoZN4xkEAENcU9uyNJYmy6Nvew4vkoRGLiU+Z5BeXMuHlGVSYo0Gy
         UptRMWObL9UVDOI/MsgfNU+7T6HVqsjkYPYCNhvlSJHleBu+JIfahS8j1Y4cyCP9zvzP
         5Zx32DDPeo1Epu+DRcWyhK8S5MfCKgiKabjoJbejFh325vYbxMXCQHVP3u9PiQDceNQ2
         OCdwNptfM9P+SebNWRcu6KexNrje7lOWZGHwXJSlH7qaoTNkfFDxjaHVlgHbXiO/RMeh
         ScNGlqpbIQdsO0Ao+SqkVHaGcijNf4b79fR+TGB4ImF9Ck2Y3gwFj5nxr8mQQXCu392g
         qXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764192; x=1713368992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvi4RlGA0eUYMMXxvrO6LGP3KPA96p3DhN0FfsCggYI=;
        b=DjQjFRTZGWXw0FDQnYqXTBWpJ1/BiJBExovwzc3E0EdHmL6ZIGXYt68uVxClvF1fBd
         Eh0YKSdx1kGTqDIUmLiMlphg0+JYycr+4QVw1Brc7Gksm4W2qH42cMapqk/ryhpsT7E7
         wWiuA23TWhBidBCRzDUEoQYQNRHSErJmLew2OQ8c1RnjTJVbLrbwM0BjrHRQJBfdTG1D
         ep3Rr6e2dvcbkTcmxYm2nFlruw05NuWdexnh7KkHP7uUgU8QFEH0PsFWItnznTHP5OcR
         SjEcWRH59ec7OA/IbBVxhi562y81EV6hNkqSa2LEu/r+D/220KZV1fl4oJAbUlZNQZuk
         MRKA==
X-Forwarded-Encrypted: i=1; AJvYcCVR1AOq2Z/cSuKNU2obhfNwKyFQmCYBN5WVBuhJS4D3okd4ckOJomUH7SwKNVh/bUHAdpW3aY0vTD9tM+4WZmIpq0YNblf36dtVOJ3e
X-Gm-Message-State: AOJu0Yz0hwMMx5Z0mRYshzYtacmPjA3nm8ukntYyBhjqA6a+xGH8GYLo
	mcjlwsCG1TNTG9cpjFfotdZMV14MzqAZ4qAtrJDJmsKrZxEDbS/AG5qP98gWg1McPBS2f4fgfmM
	+
X-Google-Smtp-Source: AGHT+IG4NexykQhPgIIYvHrAfQVQv1FqWNxA12xQmlbTS3BHAvY4jbcX/T8MwL9NLO8gOHdRAeeO6g==
X-Received: by 2002:a05:6102:38cc:b0:47a:2577:a366 with SMTP id k12-20020a05610238cc00b0047a2577a366mr2319777vst.12.1712764192407;
        Wed, 10 Apr 2024 08:49:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cfb4e000000b0069b17d0f07esm3273815qvq.96.2024.04.10.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:49:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruaCt-008FEK-5Z;
	Wed, 10 Apr 2024 12:49:51 -0300
Date: Wed, 10 Apr 2024 12:49:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
Message-ID: <20240410154951.GH223006@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410020844.253535-13-baolu.lu@linux.intel.com>

On Wed, Apr 10, 2024 at 10:08:44AM +0800, Lu Baolu wrote:
> The struct intel_svm was used for keeping attached devices info for sva
> domain. Since sva domain is a kind of iommu_domain, the struct
> dmar_domain should centralize all info of a sva domain, including the
> info of attached devices. Therefore, retire struct intel_svm to clean up
> the code.
> 
> Besides, allocate sva domain in domain_alloc_sva() callback which allows
> the memory management notifier lifetime to follow the lifetime of the
> iommu_domain.
> 
> Co-developed-by: Tina Zhang <tina.zhang@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 26 ++++------
>  drivers/iommu/intel/iommu.c |  9 +---
>  drivers/iommu/intel/svm.c   | 94 +++++++++----------------------------
>  3 files changed, 32 insertions(+), 97 deletions(-)

Happy to see the pasid xarray in the driver go away.

> @@ -4388,14 +4386,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	WARN_ON_ONCE(!dev_pasid);
>  	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>  
> -	/*
> -	 * The SVA implementation needs to handle its own stuffs like the mm
> -	 * notification. Before consolidating that code into iommu core, let
> -	 * the intel sva code handle it.
> -	 */
>  	if (domain->type == IOMMU_DOMAIN_SVA) {
>  		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
> -		intel_svm_remove_dev_pasid(domain);
>  	} else {
>  		did = domain_id_iommu(dmar_domain, iommu);
>  		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);

It seems very strange that SVA has a different DID scheme, why is
this? PASID and SVA should not be different at this layer.

> @@ -663,7 +596,12 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
>  
>  static void intel_svm_domain_free(struct iommu_domain *domain)
>  {
> -	kfree(to_dmar_domain(domain));
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +
> +	if (dmar_domain->notifier.ops)
> +		mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);

This should really use mmu_notifier_put() and a delayed kfree, see my
part 2 ARM series for how that should look.

Otherwise I think it looks fine

Jason

