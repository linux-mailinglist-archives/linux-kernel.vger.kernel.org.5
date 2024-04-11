Return-Path: <linux-kernel+bounces-140483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEB8A154C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AC31C21442
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569D14B065;
	Thu, 11 Apr 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Brq9PYI7"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266A149E10
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840883; cv=none; b=HuVDAu4TBph69wZ/tNK41RoMT2Jum6yyqJUNcZeNYyX0+eo+2P1t74d7VU2bf5bjlBDs2/HiQvgDe+IErDfC/u8RF46x/EGvlSFH1ZRb0AqP6Cjb6nlYZ/77/7c2JT68aFxBIDogW9uGSgnxs4J01yVuMktk/v2jDI1MRtIFNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840883; c=relaxed/simple;
	bh=LmTO+KxDlHRhBPWCiz60VVAyqvQ0G4Y3rwwGGUqxSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ+pzi5vQqcXiVhJxQZHClwka20Kpk8aMI4q2Ywfp4WeOl1qlnz2F2Lc6JmzUiEaoVtNTxy1m9VV85KWVOx2/7U1B9fBkfma0rVrX9vIZpaLemhw81b3xZlJzn9Ywkf7i4eNk/FUwKJjCVKeWZtiLVs7NcAF6kTgUcpLwnZAy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Brq9PYI7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b137d09e3so26401386d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712840881; x=1713445681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZz8mg6eRHraKg0plKxBZ6VZYCeo2xoi8/P4hFIe9J8=;
        b=Brq9PYI7YIKhjsbqHHXsJXZNZtAA8gDhtQOdnZNCY5sUgfzeU1aTjEy6QTfUHxVif9
         ITIxCCF/x3V+pxnVCXkejCOklm66RKoLH/cYt1OTA5Hhp3lkPhs+OKhFriggemat1McR
         I6AsHXsAlv6OOduLQsoFHiBiD+daaCywKmaF86gwPwbz1gNdaVnMQkB0aAPzHwgzyJTn
         LTqwvXaZ/pbydTF9xF8SYZG0tffNxJZHWOtoARt0SSBNAycA4b+jOJLzNT+Kylz/qhlE
         LbSszi9zjW0zyqtT+aagzwiwS8ifNL4kOilkYD7jZOwuAnwut/NewSCdsbD0lKjQJfqS
         KqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712840881; x=1713445681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZz8mg6eRHraKg0plKxBZ6VZYCeo2xoi8/P4hFIe9J8=;
        b=W7l6k35VsxmGPB79svhL7ViGndkc1ie735K5mHwjP/Y4hcrAJ7LatiJ+oxMZWdC6GY
         st9rjk+k+IFGlO8CxQkzOjPaiiY/ksiQKNza2QVhd8Bqjg4FXI7yXFq9kUYl0CYpenFc
         rT1COlxSlOER2S9CUDPLlcN0O30L9SQYJz4i/oPzPcurciv4ogVl4kUKIb0yFGNipdxB
         sz0sj0R3Z+TxPeQLSaX+op492Jhin1dwke2qpmj4/1qawiVgZ0hoBnqdM6TVxyBCjR0N
         fpitg0fYlmrTl+xq5AgX+F068jLN4TCFJcYSAcfKj7VvsbcPe5i9nBmyPCHi6AyvIxBM
         2c6w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Pm1LjZ+S7DP3TCxS6IH7H5VZatCiLbSTb5/mFXIx3NK3BD9x3RW93B6ecEs6aCKuRe+RY+P4KjtHbV+6/ArC6rjwtvlLCPP7T59J
X-Gm-Message-State: AOJu0YxMCVDtosqQwKiFOm0qMTnvyH1bJHPuQ27mj6KyxB/7f57PL1bD
	jeKlAKOtWgqiRbAJrGW61aJ3qjRjVtkP2XmvD6BxRf9+ziBwRRVZoMTbt3CwXuA=
X-Google-Smtp-Source: AGHT+IH4+qVUSOa2pmGIwOYUtFulDJSO4P5hIKc5/szMKl/OWfradbdDHKtYAcK9NUmzYNoPFQMmFw==
X-Received: by 2002:ad4:5ecf:0:b0:69b:1f8b:2e71 with SMTP id jm15-20020ad45ecf000000b0069b1f8b2e71mr6482575qvb.47.1712840880726;
        Thu, 11 Apr 2024 06:08:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g6-20020ad45106000000b0069b439190c8sm905262qvp.64.2024.04.11.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:07:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruu9n-00AgEt-5q;
	Thu, 11 Apr 2024 10:07:59 -0300
Date: Thu, 11 Apr 2024 10:07:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
Message-ID: <20240411130759.GJ223006@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
 <20240410154951.GH223006@ziepe.ca>
 <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>

On Thu, Apr 11, 2024 at 03:55:50PM +0800, Baolu Lu wrote:
> > > @@ -4388,14 +4386,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> > >   	WARN_ON_ONCE(!dev_pasid);
> > >   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> > > -	/*
> > > -	 * The SVA implementation needs to handle its own stuffs like the mm
> > > -	 * notification. Before consolidating that code into iommu core, let
> > > -	 * the intel sva code handle it.
> > > -	 */
> > >   	if (domain->type == IOMMU_DOMAIN_SVA) {
> > >   		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
> > > -		intel_svm_remove_dev_pasid(domain);
> > >   	} else {
> > >   		did = domain_id_iommu(dmar_domain, iommu);
> > >   		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
> > 
> > It seems very strange that SVA has a different DID scheme, why is
> > this? PASID and SVA should not be different at this layer.
> 
> The VT-d spec recommends that all SVA domains share a single domain ID.
> The PASID is unique to each SVA domain, hence the cache tags are unique.
> Currently, the Intel IOMMU driver assigns different domain IDs for all
> domains except the SVA type.
> 
> Sharing a domain ID is not specific to SVA. In general, for devices
> under a single IOMMU, domains with unique PASIDs can share the same
> domain ID.
> 
> In the long term (also on my task list), we will extend the cache tag
> code to support sharing domain IDs and remove the domain type check from
> the main code. This will also benefit the nesting case, where user
> domains nested on the same parent could share a domain ID.

Okay, that makes sense

> +static void intel_mm_free_notifier(struct mmu_notifier *mn)
> +{
> +       kfree(container_of(mn, struct dmar_domain, notifier));
> +}
> +
>  static const struct mmu_notifier_ops intel_mmuops = {
>         .release = intel_mm_release,
>         .arch_invalidate_secondary_tlbs =
> intel_arch_invalidate_secondary_tlbs,
> +       .free_notifier = intel_mm_free_notifier,
>  };
> 
>  static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
> @@ -598,10 +604,8 @@ static void intel_svm_domain_free(struct iommu_domain
> *domain)
>  {
>         struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> 
> -       if (dmar_domain->notifier.ops)
> -               mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
> -
> -       kfree(dmar_domain);
> +       /* dmar_domain free is defered to the mmu free_notifier callback. */
> +       mmu_notifier_put(&dmar_domain->notifier);
>  }

Yeah, that is better.

Also you need to have mmu notifier call on module unload when using
this scheme.

Jason

