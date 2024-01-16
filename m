Return-Path: <linux-kernel+bounces-28372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130082FDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF895290787
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF47154A6;
	Tue, 16 Jan 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wq7RTz8f"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22C5232
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446963; cv=none; b=Y0bNTXZOoEO5+00aIkXzhmLvkF0kKP0oM0j+sN7DLj3AbZ3FAqk7hk59FYJ301u0gjPIaxG5qHWK3qzCAve5Kfso24ZQR0tf29AlsxEV5h+CyNnF/wfZUAR7+i4qtnbfiTQ6ACC+DjjUcgsXwnOJwPRFrLLuZALlomBWd+HkhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446963; c=relaxed/simple;
	bh=Yg7X+Q/Ikx1X6x8I+pCvBiVDNlaGBpA5fecv7Qhv6mg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HnDVIVPvFCRk7GKOuYoUPUWf3bffxf4am6BopPzfTbHtxM7MtQGUXpyXk3Z/pdxn+Ug+bW1/9RIPTtjD7c+efgaIQuTvCJiElBhuUdYr8jJJ0YDd3tCFf9kUbBwpX1Uksvf9IcHlpoY3t6XJye1+M3+JPfClxRj5Xpo+3ml4/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wq7RTz8f; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28e7b2f1988so741298a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705446961; x=1706051761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMlhgs+ZanikuWrLOwWvA6H56fTn9jVJ2lLpIj9nsFQ=;
        b=Wq7RTz8fJf1RhkbR1nPa3qT0+HkWafhkys3eaHvDPXGv0hgV3otky5ALVS5J7PT73w
         Ka7gDnDHFFZwhE4ieunKUeHoCOIZI/FRcr6Pt3m1l+88dduGqEFSB+1JTf+1cWMerTLP
         x1qeEZ5KrmjfdJv+5y+q9GnHgJvVmj82ZW1KBTUB4nsMGaqEcKV1TKW26QfDreIjwWOm
         ylfTwtQ/dbZprJHyGTPhnZJuJSkoU1bCY9554ML3G5Fr1aKuwvx8fzplZJoYzxzWdbRD
         DDDvoMmQBeigN3ArPGfQus21BnGlKOEOIqlAMHUbNi2Cnqzi2m/AnRLOmibvduzbG3gx
         D1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705446961; x=1706051761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMlhgs+ZanikuWrLOwWvA6H56fTn9jVJ2lLpIj9nsFQ=;
        b=t1CX0nEQPcOBF8lnIRrxgo5XMNjVMn4INEK9EwV4OgQF7cQy1dR1/ddG3zRxMnpzSt
         OFR93r5hywSYkXNyjNTPS/qeRQY0cJqFC87um3FPNgW8jzNolNQsm4yJo8cMb0oriBvQ
         DF0jX5Xgw+eMhK4D+gcVTdZNbdh2TSq4JVIevWVJ5QLYV/hINwT4nrJYW5NIK8VsHiwW
         LAJwnhZmxusLsK6ceUSGLRWDAuq7MliVCtfLBvpQ5mm9SV8HOeAtZE+uvM1GcBQ+YayQ
         rUc8DQFrlOC++zw26L737Bp5DTK/WCsOh7PXV1WyzMVy8Khntng3Zvz/94m8jK8uJ/dN
         bsPg==
X-Gm-Message-State: AOJu0YzJar2eL2kenUj/PCQhcsIFvfjxuNUUyUnlTopsSBCIgWyKkK+2
	hfr5D58gDvO4OaQySoMDbGIvZkTOpEvmrg==
X-Google-Smtp-Source: AGHT+IEDCX+rD4Z4h5D8tSyEglqdoZfj6P3qfPrcWbfzfMPZhrydaH0ycc2ufJB32TCk34x+noNOYg==
X-Received: by 2002:a17:90a:9e2:b0:28e:6f44:46d4 with SMTP id 89-20020a17090a09e200b0028e6f4446d4mr1289555pjo.15.1705446960715;
        Tue, 16 Jan 2024 15:16:00 -0800 (PST)
Received: from ebps ([208.88.152.253])
        by smtp.gmail.com with ESMTPSA id qi17-20020a17090b275100b0028e245501e7sm8063892pjb.4.2024.01.16.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 15:16:00 -0800 (PST)
Date: Tue, 16 Jan 2024 15:15:58 -0800
From: Eric Badger <ebadger@purestorage.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Message-ID: <ZacOLhnxGqntWfWN@ebps>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
 <20240116152215.GE50608@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116152215.GE50608@ziepe.ca>

On Tue, Jan 16, 2024 at 11:22:15AM -0400, Jason Gunthorpe wrote:
> On Sat, Jan 13, 2024 at 10:17:13AM -0800, Eric Badger wrote:
> > In the kdump kernel, the IOMMU will operate in deferred_attach mode. In
> > this mode, info->domain may not yet be assigned by the time the
> > release_device function is called, which leads to the following crash in
> > the crashkernel:
> 
> This never worked right? But why are you getting to release in a crash
> kernel in the first place, that seems kinda weird..

I first encountered this crash as part of an upgrade from 5.15.125 to
6.6.0. I'd guess this has not worked since p2sb_bar() was plumbed into
i801_probe(). Prior to that, there was similar code in i801_probe(), but
no call to pci_stop_and_remove_bus_device().

> 
> >     BUG: kernel NULL pointer dereference, address: 000000000000003c
> >     ...
> >     RIP: 0010:do_raw_spin_lock+0xa/0xa0
> >     ...
> >     _raw_spin_lock_irqsave+0x1b/0x30
> >     intel_iommu_release_device+0x96/0x170
> >     iommu_deinit_device+0x39/0xf0
> >     __iommu_group_remove_device+0xa0/0xd0
> >     iommu_bus_notifier+0x55/0xb0
> >     notifier_call_chain+0x5a/0xd0
> >     blocking_notifier_call_chain+0x41/0x60
> >     bus_notify+0x34/0x50
> >     device_del+0x269/0x3d0
> >     pci_remove_bus_device+0x77/0x100
> >     p2sb_bar+0xae/0x1d0
> >     ...
> >     i801_probe+0x423/0x740
> > 
> > Signed-off-by: Eric Badger <ebadger@purestorage.com>
> 
> It should have a fixes line, but I'm not sure what it is..

Starting from my known-working 5.15.125 base, I worked my way forward to
try to find the offenders. I think it's mainly these two:

dd8a25c557e1 ("iommu: Remove deferred attach check from __iommu_detach_device()")
586081d3f6b1 ("iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO")

Prior to the first one, we always end up doing a non-deferred attach on
the device, so it's not possible to have a not-yet-attached device at
release time.

The second one looks to be necessary to get the situation where we have
non-NULL info, but NULL info->domain.

Since there was a lot of refactoring done between 5.15.125 and 6.6.0, I
couldn't just cherry pick those two back to 5.15.125. But I was able to
cherry pick these two sequences with minimal manual massaging and that
reproed the crash in the crashkernel in intel_iommu_release_device() on
5.15.125:

a688b376fa5e iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
c2ed7ea06b6b iommu/vt-d: Remove domain and devinfo mempool
d195dd05b950 iommu/vt-d: Remove iova_cache_get/put()
0822172fa474 iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
443d995073fb iommu/vt-d: Remove intel_iommu::domains

f394cb40eaa7 iommu: Remove deferred attach check from __iommu_detach_device()
09d782454860 iommu: Remove unused argument in is_attach_deferred
35c672b9e7ed iommu: Add DMA ownership management interfaces
6b9638d70dff iommu: Use right way to retrieve iommu_ops

> 
> > ---
> >  drivers/iommu/intel/iommu.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Unfortunately this issue is likely systemic in all the drivers.
> 
> Something I've been thinking about for a while now is to have the
> option for the core code release to set the driver to a specific
> releasing domain (probably a blocking or identity global static)
> 
> A lot of drivers are open coding this internally in their release
> functions, like Intel. But it really doesn't deserve to be special.
> 
> Obviously if we structure things like that then this problem goes away
> too. It looks to me like domain_context_clear_one() is doing BLOCKED
> to me..
> 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 6fb5f6fceea1..26e450259889 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3750,7 +3750,6 @@ static void domain_context_clear(struct device_domain_info *info)
> >  static void dmar_remove_one_dev_info(struct device *dev)
> >  {
> >  	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > -	struct dmar_domain *domain = info->domain;
> >  	struct intel_iommu *iommu = info->iommu;
> >  	unsigned long flags;
> >  
> > @@ -3763,11 +3762,14 @@ static void dmar_remove_one_dev_info(struct device *dev)
> >  		domain_context_clear(info);
> >  	}
> >  
> > -	spin_lock_irqsave(&domain->lock, flags);
> > +	if (!info->domain)
> > +		return;
> > +
> > +	spin_lock_irqsave(&info->domain->lock, flags);
> >  	list_del(&info->link);
> > -	spin_unlock_irqrestore(&domain->lock, flags);
> > +	spin_unlock_irqrestore(&info->domain->lock, flags);
> >  
> > -	domain_detach_iommu(domain, iommu);
> > +	domain_detach_iommu(info->domain, iommu);
> >  	info->domain = NULL;
> >  }
> 
> This function is almost a copy of device_block_translation(), with
> some bugs added :\
> 
> Lu can they be made the same? It seems to me BLOCKED could always
> clear the domain context, even in scalable mode?
> 
> Anyhow, my suggestion is more like:
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 15699fe5418e3d..6c683fd4bc05ec 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3747,30 +3747,6 @@ static void domain_context_clear(struct device_domain_info *info)
>  			       &domain_context_clear_one_cb, info);
>  }
>  
> -static void dmar_remove_one_dev_info(struct device *dev)
> -{
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct dmar_domain *domain = info->domain;
> -	struct intel_iommu *iommu = info->iommu;
> -	unsigned long flags;
> -
> -	if (!dev_is_real_dma_subdevice(info->dev)) {
> -		if (dev_is_pci(info->dev) && sm_supported(iommu))
> -			intel_pasid_tear_down_entry(iommu, info->dev,
> -					IOMMU_NO_PASID, false);
> -
> -		iommu_disable_pci_caps(info);
> -		domain_context_clear(info);
> -	}
> -
> -	spin_lock_irqsave(&domain->lock, flags);
> -	list_del(&info->link);
> -	spin_unlock_irqrestore(&domain->lock, flags);
> -
> -	domain_detach_iommu(domain, iommu);
> -	info->domain = NULL;
> -}
> -
>  /*
>   * Clear the page table pointer in context or pasid table entries so that
>   * all DMA requests without PASID from the device are blocked. If the page
> @@ -4284,7 +4260,6 @@ static void intel_iommu_release_device(struct device *dev)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  
> -	dmar_remove_one_dev_info(dev);
>  	intel_pasid_free_table(dev);
>  	intel_iommu_debugfs_remove_dev(info);
>  	kfree(info);
> @@ -4743,6 +4718,7 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
>  
>  const struct iommu_ops intel_iommu_ops = {
>  	.blocked_domain		= &blocking_domain,
> +	.release_domain		= &blocking_domain,
>  	.capable		= intel_iommu_capable,
>  	.hw_info		= intel_iommu_hw_info,
>  	.domain_alloc		= intel_iommu_domain_alloc,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 068f6508e57c9b..9fbbd83a82d4e9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -442,6 +442,8 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>  err_unlink:
>  	iommu_device_unlink(iommu_dev, dev);
>  err_release:
> +	if (ops->release_domain)
> +		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
>  	if (ops->release_device)
>  		ops->release_device(dev);
>  err_module_put:
> @@ -461,6 +463,15 @@ static void iommu_deinit_device(struct device *dev)
>  
>  	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>  
> +	/*
> +	 * If the iommu driver provides release_domain then the core code
> +	 * ensures that domain is attached prior to calling release_device.
> +	 * Drivers can use this to enforce a translation on the idle iommu.
> +	 * Usually the global static blocked_domain is a good choice.
> +	 */
> +	if (ops->release_domain)
> +		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
> +
>  	/*
>  	 * release_device() must stop using any attached domain on the device.
>  	 * If there are still other devices in the group they are not effected
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c34d0ef1703d68..1e8be165c878d8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -511,6 +511,7 @@ struct iommu_ops {
>  	struct module *owner;
>  	struct iommu_domain *identity_domain;
>  	struct iommu_domain *blocked_domain;
> +	struct iommu_domain *release_domain;
>  	struct iommu_domain *default_domain;
>  };
>  

FWIW, I took this patch for a spin, appears to work fine.

Thanks,
Eric

