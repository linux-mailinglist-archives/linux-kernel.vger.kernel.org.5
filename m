Return-Path: <linux-kernel+bounces-27511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B482F15F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E5B21DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9A1C280;
	Tue, 16 Jan 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iSfpGGJf"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFD1B941
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68176e698e3so2106336d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705418537; x=1706023337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVNYnSflADKfn6Wa9x8SjlhLp4T/UgcF3P1M8bBqp2w=;
        b=iSfpGGJfQlw98r8dDStLZlxsygLeY+qWn3HGDVaWa03iRiBBoD4aUh6/SCWcSEpQz9
         COoxQCvdX5qeQ695BMSXPtKJX490t7rAFfxrpmi3XETA1nigRV79NzIiRMA3qas68W9S
         85us4DHVhKRoqeUrTX3r+wcoXFCxiEkdJq6DzA1PmWdqccQw5kXRoaDe+Erz2yJOZFOO
         tNiHBpSZes4Mdn8DQ5KhMACZa52gfvO/V0dtyFytj7QBLYS9CnEeCavBMkBNT8ifXdRF
         LKQDM9sc2TCw2TY9G24sqzYWVw+1uh7o6ZBUE4ZE6xPAUmUfIselx4Ao1NNxSRuvxZxp
         LrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418537; x=1706023337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVNYnSflADKfn6Wa9x8SjlhLp4T/UgcF3P1M8bBqp2w=;
        b=BKyyirUHAPi/eviutWs0BrqbWOic5liVdbj7mMg67K9EyT/t3mjXRQGBRnJ6to8Vev
         yBaOxadbhq6k/cYnKMmBSu+Yb1dTvrAE0Hsr0XvfZ7Etq6yp8TVPXBcp13ugRGRsHMA4
         nuf2NS9C/Y8ZsGfSovUtbtiKLK8xcziGvvAjlLWJxodRC3RXMAv5tEU6GRRBMGo/9LmM
         bN11ABHJEDysUOTyLikMEiXiTVsOHhLpJvce/rqL81/Afyz3BGsdt30G+YAprDkE3jYQ
         mX+oYDfdvPbFDK1qcEMwk422blqrWDVOVsO5BCSPX1uiRUJhksl66/jJuNGswt0q7RCQ
         WYpQ==
X-Gm-Message-State: AOJu0Yzqp6ZBqFTGpa2WqwhPKZ75OIm1EgSrVzeQ+QUGCgyd2lLrF2fG
	Jmieqi7tLYPIfIwSsjf/37kv2vY9aSnvLg1Sb2pz2nWIKHQ=
X-Google-Smtp-Source: AGHT+IEueIiMfcoD8DOK4/6L5RoUPXk+O1mWcGM/B2o2NMVvvFcM55yhCNSeNwQe7/xXJ5jt56/QAw==
X-Received: by 2002:a05:6214:dcd:b0:680:a1c:9c46 with SMTP id 13-20020a0562140dcd00b006800a1c9c46mr9465367qvt.33.1705418536859;
        Tue, 16 Jan 2024 07:22:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id i12-20020a056214030c00b0067f812c4a58sm4199799qvu.60.2024.01.16.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:22:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPlGZ-0045lK-Sc;
	Tue, 16 Jan 2024 11:22:15 -0400
Date: Tue, 16 Jan 2024 11:22:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Eric Badger <ebadger@purestorage.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Message-ID: <20240116152215.GE50608@ziepe.ca>
References: <20240113181713.1817855-1-ebadger@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113181713.1817855-1-ebadger@purestorage.com>

On Sat, Jan 13, 2024 at 10:17:13AM -0800, Eric Badger wrote:
> In the kdump kernel, the IOMMU will operate in deferred_attach mode. In
> this mode, info->domain may not yet be assigned by the time the
> release_device function is called, which leads to the following crash in
> the crashkernel:

This never worked right? But why are you getting to release in a crash
kernel in the first place, that seems kinda weird..

>     BUG: kernel NULL pointer dereference, address: 000000000000003c
>     ...
>     RIP: 0010:do_raw_spin_lock+0xa/0xa0
>     ...
>     _raw_spin_lock_irqsave+0x1b/0x30
>     intel_iommu_release_device+0x96/0x170
>     iommu_deinit_device+0x39/0xf0
>     __iommu_group_remove_device+0xa0/0xd0
>     iommu_bus_notifier+0x55/0xb0
>     notifier_call_chain+0x5a/0xd0
>     blocking_notifier_call_chain+0x41/0x60
>     bus_notify+0x34/0x50
>     device_del+0x269/0x3d0
>     pci_remove_bus_device+0x77/0x100
>     p2sb_bar+0xae/0x1d0
>     ...
>     i801_probe+0x423/0x740
> 
> Signed-off-by: Eric Badger <ebadger@purestorage.com>

It should have a fixes line, but I'm not sure what it is..

> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Unfortunately this issue is likely systemic in all the drivers.

Something I've been thinking about for a while now is to have the
option for the core code release to set the driver to a specific
releasing domain (probably a blocking or identity global static)

A lot of drivers are open coding this internally in their release
functions, like Intel. But it really doesn't deserve to be special.

Obviously if we structure things like that then this problem goes away
too. It looks to me like domain_context_clear_one() is doing BLOCKED
to me..

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6fb5f6fceea1..26e450259889 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3750,7 +3750,6 @@ static void domain_context_clear(struct device_domain_info *info)
>  static void dmar_remove_one_dev_info(struct device *dev)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct dmar_domain *domain = info->domain;
>  	struct intel_iommu *iommu = info->iommu;
>  	unsigned long flags;
>  
> @@ -3763,11 +3762,14 @@ static void dmar_remove_one_dev_info(struct device *dev)
>  		domain_context_clear(info);
>  	}
>  
> -	spin_lock_irqsave(&domain->lock, flags);
> +	if (!info->domain)
> +		return;
> +
> +	spin_lock_irqsave(&info->domain->lock, flags);
>  	list_del(&info->link);
> -	spin_unlock_irqrestore(&domain->lock, flags);
> +	spin_unlock_irqrestore(&info->domain->lock, flags);
>  
> -	domain_detach_iommu(domain, iommu);
> +	domain_detach_iommu(info->domain, iommu);
>  	info->domain = NULL;
>  }

This function is almost a copy of device_block_translation(), with
some bugs added :\

Lu can they be made the same? It seems to me BLOCKED could always
clear the domain context, even in scalable mode?

Anyhow, my suggestion is more like:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 15699fe5418e3d..6c683fd4bc05ec 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3747,30 +3747,6 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
-	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
-
-	if (!dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, info->dev,
-					IOMMU_NO_PASID, false);
-
-		iommu_disable_pci_caps(info);
-		domain_context_clear(info);
-	}
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_del(&info->link);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	domain_detach_iommu(domain, iommu);
-	info->domain = NULL;
-}
-
 /*
  * Clear the page table pointer in context or pasid table entries so that
  * all DMA requests without PASID from the device are blocked. If the page
@@ -4284,7 +4260,6 @@ static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
-	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
@@ -4743,6 +4718,7 @@ static const struct iommu_dirty_ops intel_dirty_ops = {
 
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
+	.release_domain		= &blocking_domain,
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 068f6508e57c9b..9fbbd83a82d4e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -442,6 +442,8 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 err_unlink:
 	iommu_device_unlink(iommu_dev, dev);
 err_release:
+	if (ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
 	if (ops->release_device)
 		ops->release_device(dev);
 err_module_put:
@@ -461,6 +463,15 @@ static void iommu_deinit_device(struct device *dev)
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	/*
+	 * If the iommu driver provides release_domain then the core code
+	 * ensures that domain is attached prior to calling release_device.
+	 * Drivers can use this to enforce a translation on the idle iommu.
+	 * Usually the global static blocked_domain is a good choice.
+	 */
+	if (ops->release_domain)
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+
 	/*
 	 * release_device() must stop using any attached domain on the device.
 	 * If there are still other devices in the group they are not effected
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c34d0ef1703d68..1e8be165c878d8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -511,6 +511,7 @@ struct iommu_ops {
 	struct module *owner;
 	struct iommu_domain *identity_domain;
 	struct iommu_domain *blocked_domain;
+	struct iommu_domain *release_domain;
 	struct iommu_domain *default_domain;
 };
 

