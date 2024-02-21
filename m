Return-Path: <linux-kernel+bounces-75003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E985E149
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4162284E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AC80626;
	Wed, 21 Feb 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RHHgZQtD"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1F6994A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529681; cv=none; b=FB4npSVKzm9DESawWlNOBNkXY9pH7/xWxYQ+P61h3fQn7DA67V8Vhg7nRCdBWBSpXJqqiVgNULlomAc+fJ72oIVX+VrHpvTGAmKM9jC5y4f8cY4XQs9hKk6Cypdto4wdjudYVd3mdvkf1L3/6H7xSaDekEXX8QQVBTxJSCGl/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529681; c=relaxed/simple;
	bh=xzTctav8g7TKhopihyy2IToGnTwvpiN27ZeFUg7cgO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im0Fp4zxi9ouzwzJj4PoP/lB11CIg4sfiugT3vGEQoTFWtxjmswWam2pw0UyBbb47TuB1NuUdA3qCgGq37xOvkEdKwcjexeaxvFdHRAUWAto5kuZs4O1ZJSRfmonDDZJ57Fjks+1NQjXefWkWoKdPGiX2AdRkvaO24Ti3MryC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RHHgZQtD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78776c82564so126009185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708529679; x=1709134479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRubVpVSyqj7YKWbIXOAeHuHzuYjiGI0gsbtGXte6ic=;
        b=RHHgZQtDj4MWHXpzEbXK/P/UfBMBJeJdwPPDfEDF+oT6od7MJz5TPvZpSNmQI/a+Zf
         jKh7kEkzFOgvFoHuzH2xsGUwGmLf3flXtcj1CzGpcKBer3YW5yG0taDCw9h6B9p52RBs
         0PZzuSQ2W5Woi9LZQCKo7DEGgbscYwdCfLfEKiLoPcSh9yWb6cyl8zDMC2DvWakrcr9H
         eWlHwzpKJLBquS0Z4PmtRyJZqv0sKcvWkiFvRACvKNK7vSeIwigQFtJWNiRCJ1Zne1um
         ZReKhrwR8Hc4tOPd95EoTBu3V4BkOdeXi4L4MwGMEookZ9oQRH1/KOQz+ftX9HJ9+qcT
         CeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529679; x=1709134479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRubVpVSyqj7YKWbIXOAeHuHzuYjiGI0gsbtGXte6ic=;
        b=F5My1jHB/23nQJMEOrg6MBw2z2cr+TNWDm2P+yh5e4pgg2zFAfUCjeBpO+qfWDeM7m
         BjN4I5pJnPgNTgXNeOFOPYAE1Yk1BTBS8CjctlUYBE2+OeGGSdBJwe8BE02YEZG49hdd
         CMqJc6ffca3d1ZF0iL8vdoI6qp9oSAqDy/1uP6FIaIrvvNi4Lm2/F/+GBO1TpSIOasC/
         Ro/axHsY/pogWKNyu2DxdhQ+E/TcGk3skI5dd8/6b6Q/k0S/9c0qawNqk62F+Xsme1lI
         VOUJ6qRO5evhbHGGxZnmgI2FqE9BZQxh9YpKExoW3q+h6TX20ylVzSJ7VAT00KdsA/pS
         qEEg==
X-Forwarded-Encrypted: i=1; AJvYcCV7YTBYRczuH8mP1Awlkpj+NLoVVRcHMMLADDgrvmAg+6wvISfLOq8+sO1z3RuvpFoEl9w3thTEm4Q4wT24PNSSnwRD5TnzJ/CBaiTT
X-Gm-Message-State: AOJu0YyCZNDPWLegAtONU4ZI/LFhmg8OnladbU0hgjyV8/NyE8lEuZpv
	vDWEOepIzRhffPrpZwAM8FJ1yvkR/YixqgIWMzcXXDA9ZdTkheBXdNf/lW6BO+E=
X-Google-Smtp-Source: AGHT+IESD+XDtO4BG0BhqALqKZjZiigRcR8hGs+7no/hgPB+qm/MZcvqa7Zg/lng5dvTDg9XR/51Fw==
X-Received: by 2002:ad4:5743:0:b0:68f:280f:175a with SMTP id q3-20020ad45743000000b0068f280f175amr21137200qvx.12.1708529678730;
        Wed, 21 Feb 2024 07:34:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id qq3-20020a0562142c0300b0068f9c181fc0sm1307321qvb.113.2024.02.21.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:34:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcocH-00BPeA-Li;
	Wed, 21 Feb 2024 11:34:37 -0400
Date: Wed, 21 Feb 2024 11:34:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Use device rbtree in iopf reporting
 path
Message-ID: <20240221153437.GB13491@ziepe.ca>
References: <20240220065939.121116-1-baolu.lu@linux.intel.com>
 <20240220065939.121116-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220065939.121116-3-baolu.lu@linux.intel.com>

On Tue, Feb 20, 2024 at 02:59:39PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index acfe27bd3448..6743fe6c7a36 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4430,8 +4430,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  static void intel_iommu_release_device(struct device *dev)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
>  
> +	mutex_lock(&iommu->iopf_lock);
>  	device_rbtree_remove(info);
> +	mutex_unlock(&iommu->iopf_lock);

This seems like a pretty reasonable solution, maybe someday it can
become lockless.. This is a fast path right?

> @@ -691,21 +691,22 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
>  			goto prq_advance;
>  
> -		pdev = pci_get_domain_bus_and_slot(iommu->segment,
> -						   PCI_BUS_NUM(req->rid),
> -						   req->rid & 0xff);
>  		/*
>  		 * If prq is to be handled outside iommu driver via receiver of
>  		 * the fault notifiers, we skip the page response here.
>  		 */
> -		if (!pdev)
> +		mutex_lock(&iommu->iopf_lock);
> +		dev = device_rbtree_find(iommu, req->rid);
> +		if (!dev) {
> +			mutex_unlock(&iommu->iopf_lock);
>  			goto bad_req;
> +		}

Though now we have a mutex and a spinlock covering the same data
structure.. It could be optimized some more.

But maybe we should leave micro optimization aside for now.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

