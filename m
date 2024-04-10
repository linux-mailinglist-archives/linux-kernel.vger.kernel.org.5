Return-Path: <linux-kernel+bounces-138906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C81F89FBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7E31F21908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3DF16F0D2;
	Wed, 10 Apr 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XXEJSmds"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC981E878
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763699; cv=none; b=Rwy7ZOscK8TFWkUPneP5S0dipvr6oCyE59xdq5oaB5YiBsGaZ9jCdNRyVEsOuiw3/rKfTIzplB6ZN8MW8r8qMW9NR6AROP6OkXctOc5ucVQCYCa7Ih9rZiH6tfVBzoVGdVRZGlk3Jpp5N7BcBHTyNcROsQqG7LSoyLN6FzAP1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763699; c=relaxed/simple;
	bh=sBaAau9xEeJf8roh6msHFnyACVS56UGKbvbAsQ86sAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWyEJ3lxrc3wwfEDwCtb9RDEVosWAI0lbHkCBPI6L0wEoYfFkzYvEoJc+0YOzlr+4QaH1J+qbomx4Q6AqeqAq/oJkdQtSIqgD0oYLg3uv4Fgf/2ZBz3BqUE0XQ+GMeG6Z6rWC1ybKIbrCFISEL2HvYUp2LHOEoqgCmBmyooBtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XXEJSmds; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea22016864so1347644a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712763695; x=1713368495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1uyVIcyqxPJmYh56tL6RiRYduMPkQf65GN7JkcsbVE=;
        b=XXEJSmdsUj8uJo5QAro0DqsTUN7Qn1bxoiCR1vVp520UtGWY9RDq5p1FjGi1tpGOs9
         56SIqW9LfN4chahhU9pj6XMSjrcGol5udklgg9hY8ee58q3ewAw5uQeVCReCPrisXfuX
         27Rbev+nI5xyIHQQOwp0PR8aZrFAHKwoBuShVh5hgeWg5RvX7jvvvV2wP1qnmW+Ie1Em
         +fChfYOjj75EfdAEAOu2b1frFLMJorU+Mpj+Aag78O9bF1HYWKNun4bMOwHMa+siXWix
         9FOyObTJPeCmmSDKktlx5rb00ZrDNLv//1Y3RQHtkJ2ODOYeFNQKVktDlIytbGzjL3bO
         5WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763695; x=1713368495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1uyVIcyqxPJmYh56tL6RiRYduMPkQf65GN7JkcsbVE=;
        b=Q0XSpQuqptAoiVskruAx3G5SI7PTPGVUPgyIzgKwKXEP5LSIcj9mlhJTgVNM+qsDcT
         7HHWWG0vm+CSeIQ72WycKbh3/5IBu9q4vBCjVqcTgE4jg5qzVEhPg3MJZ7h/xEhMUlmy
         xx6dUu9D4ud07xibgx6rJ+XyG+gIB1WeAITmYSq3KQ7GLmF572S88RTSvouUwx6eHN3V
         Wiw1znGhWqnfDAI89dcjcuMrNmrIY/t94YIXCxazr9hpZbTQPFe7NAa8aO5ddiCyslwE
         8HQxO2fWvzBh16EyJDhw7EvL+c6/0WIneGsdGbTfy4LG4zYNF/HyobUVIhlKKgkaCdla
         q0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxsThlFJDNbbvnsDSxxVsxc1WiD293MJHAbxUt8WAyzQSnXdIIs0vrb+tx9L6J2l4HS4V/DiREC3rQrIaQz3l0qEJl/o2PdtHPIP/S
X-Gm-Message-State: AOJu0YzZDY741MIX1dTcIW45LXdkHRmyh7G2JwHe5TU739fPAzO41pBv
	JzBXt/4h1RJ+z6JsY2A3kuuWMUmSt1F5tthuCMBpHmxyFNMkP+pzyzd65po2aco=
X-Google-Smtp-Source: AGHT+IGjvgHPzlbtSke1df6CNZVMzhBHqQLj0GdDl9JuvwsX6FiQ77sduSoLZ+Gt//YtFRjLu30GfQ==
X-Received: by 2002:a9d:7415:0:b0:6ea:177b:f08b with SMTP id n21-20020a9d7415000000b006ea177bf08bmr3062635otk.36.1712763695506;
        Wed, 10 Apr 2024 08:41:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u4-20020a0562140b0400b006990c05f0ccsm5171664qvj.110.2024.04.10.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:41:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rua4s-008Eh1-7t;
	Wed, 10 Apr 2024 12:41:34 -0300
Date: Wed, 10 Apr 2024 12:41:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Message-ID: <20240410154134.GG223006@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325021705.249769-2-baolu.lu@linux.intel.com>

On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
> Caching tag is a combination of tags used by the hardware to cache various
> translations. Whenever a mapping in a domain is changed, the IOMMU driver
> should invalidate the caches with the caching tags. The VT-d specification
> describes caching tags in section 6.2.1, Tagging of Cached Translations.
> 
> Add interface to assign caching tags to an IOMMU domain when attached to a
> RID or PASID, and unassign caching tags when a domain is detached from a
> RID or PASID. All caching tags are listed in the per-domain tag list and
> are protected by a dedicated lock.
> 
> In addition to the basic IOTLB and devTLB caching tag types, PARENT_IOTLB
> and PARENT_DEVTLB tag types are also introduced. These tags are used for
> caches that store translations for DMA accesses through a nested user
> domain. They are affected by changes to mappings in the parent domain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h  |  25 +++++
>  drivers/iommu/intel/cache.c  | 192 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c  |  31 +++++-
>  drivers/iommu/intel/nested.c |  21 +++-
>  drivers/iommu/intel/svm.c    |  12 ++-
>  drivers/iommu/intel/Makefile |   2 +-
>  6 files changed, 274 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/iommu/intel/cache.c
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 404d2476a877..e3723b7a0b31 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -607,6 +607,9 @@ struct dmar_domain {
>  	struct list_head devices;	/* all devices' list */
>  	struct list_head dev_pasids;	/* all attached pasids */
>  
> +	spinlock_t cache_lock;		/* Protect the cache tag list */
> +	struct list_head cache_tags;	/* Cache tag list */

That is quite a neat trick - though building a dedicated invalidation
list duplicates data stored in the attached devices list?

You didn't try to make it RCU safe for invalidation?

> +struct cache_tag {
> +	struct list_head node;
> +	enum cache_tag_type type;
> +	struct intel_iommu *iommu;
> +	struct device *dev;

iommu and dev probably don't both need to be stored together. We have
iommu_get_iommu_dev() now.. I suppose this is probably a union of the
two pointers depending on tag. DEVTLB needs the dev and IOTLB needs
the iommu.

> +	u16 domain_id;
> +	ioasid_t pasid;
> +	int users;

unsigned int

> +static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	int ret;
> +
> +	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_TYPE_PARENT_IOTLB);
> +	if (ret || !info->ats_enabled)
> +		return ret;

I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
different implementation?

Isn't this backwards though? Each domain should have a list of things
to invalidate if the domain itself changes.

So the nesting parent should have a list of CHILD_DEVTLB's that need
cleaning. That list is changed when the nesting domains are attached
to something.

And a list of CHILD_IOTLBs, but the HW doesn't seem to need that?

Jason

