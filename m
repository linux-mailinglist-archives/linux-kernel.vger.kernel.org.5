Return-Path: <linux-kernel+bounces-67452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247B856BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275AC2861C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D013958E;
	Thu, 15 Feb 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B/mF7Ouw"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20867139586
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019737; cv=none; b=ppBG+Fc1J9770bDfgnCOeOXyg04cWAJb1xVfygFZkTaoFizdyK9Xd1CX9m+chBmnRb+kbdNNRXJ4vL3VmnFZDGIpncU0vYBbLNIrKJzx6lFJUMZ4u7yExm29uI4D8LXOpMGCv1CZy/gwztuEksPUmklTudt1pRsiBmTJr5zEakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019737; c=relaxed/simple;
	bh=/SLEGSo/SHbwoeas/K5MCYXMBvqDE3jcVt8yVAVUk0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbSOhansboTZwNia8rwUdwYWmBVo/GMe5e6Nc6mwQCSfnJ7ElnXaK+pZuPJek9qlS4ijBCH7zkDZR7dRz6PkZg5QjnjplibiUkyNuNdTqQWFWWne4oFDrnKoDHMOcXNQ0W58wCpSgogZNz0kvCYqqDzA9GFMSO0ng7jgYMRe1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B/mF7Ouw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68f283daa21so4997276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708019735; x=1708624535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Cfkf/rcH8ZZ55nenqvlzLTt+2joha7tbZ1+3P7cVI=;
        b=B/mF7OuwTwcvYnPI5TEBDZBtRHqPS6dl5scAMBBFzI2RoqYtySgl8X1bk4dF1c/PPD
         2Pt819IjFJxuTX+Hqa+SmlusnlzUBfhQV8x9Lobgc+MR2+rAL18n1rgPn/6BJdbPTmpd
         ByWCdYgOSjMld1rsj4MkaOtoHUAIpKSnEFf5mBc34FsxBO9urC7g/GjUdxQDJh2td+Js
         Teipsua3k/Fe1qZwLUDwxJPq8RDmipfREe66lqyE3K34yb3axfRU2QzS8EqRUjpk80r7
         rcko0qz32117h2m+xMSmRAsXCskU1vbIP5AZbnYUlbZmrq4LruLHUb6+nffTMoWBH8md
         KnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019735; x=1708624535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3Cfkf/rcH8ZZ55nenqvlzLTt+2joha7tbZ1+3P7cVI=;
        b=HRDWLEj3R3i3Pr0fbjWotcrlUwLqTDAWsh+PB6TqsrrX7HhnHyZCkslofPXtHuCAAL
         HrqOiR0bCBvZjHvjQWHsBSq8LGxbRY/aZsBgBnkc43aQzUfFd0lfHlHxLs8CSIeCXCGH
         OgtoDgwRLyuQoeww95etKmY56eYwe7MARRoonUWYdLnOjy0QxG27X3ywHZRT8+UIzZt5
         xNvFKMuWeSbRck0nfUJO9NsGQ40Muv610qlh+5XBCQVzToqmF3WnX0i7g2jCY9XcCWQX
         RvRTV0YW6A4NK/ESZ/aMSc/jhUoYywbAQGTuWlm8f0JzWlaWc3dAHkNozc8nONtpxsGQ
         chag==
X-Forwarded-Encrypted: i=1; AJvYcCUbZ2d5py3ULwSQDVo17YojprtvHehB6/PLZoqiG+2plKtj18e0FC7pjjCBsGWjzurY/PC+FIPKiW8K/Btw+koC0dYyK7itqKwiPt7s
X-Gm-Message-State: AOJu0Yz4SZUfE11qe9D97Xm7xMfa2mUuul/fVqn9usaZACATt3ify6uv
	fnQjK9YLoiPqv7+7YJputvxMBlDn5WGGVeS746NjA4JrIojEbxkrHHrGR7Z7jXc=
X-Google-Smtp-Source: AGHT+IGn1LZhOlvnHNCbJfgG5iiTUX0ZYq//pMkCGfQ2vC9DNSvgr14XQvyYuGMbLuzdjQz0+dF1uA==
X-Received: by 2002:a0c:e247:0:b0:68e:fbbe:2eea with SMTP id x7-20020a0ce247000000b0068efbbe2eeamr3750395qvl.3.1708019735060;
        Thu, 15 Feb 2024 09:55:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lv4-20020a056214578400b0068ee4c74941sm860253qvb.132.2024.02.15.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:55:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rafxO-001Gax-1t;
	Thu, 15 Feb 2024 13:55:34 -0400
Date: Thu, 15 Feb 2024 13:55:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Message-ID: <20240215175534.GD1299735@ziepe.ca>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215072249.4465-3-baolu.lu@linux.intel.com>

On Thu, Feb 15, 2024 at 03:22:49PM +0800, Lu Baolu wrote:
> The existing IO page fault handler currently locates the PCI device by
> calling pci_get_domain_bus_and_slot(). This function searches the list
> of all PCI devices until the desired device is found. To improve lookup
> efficiency, a helper function named device_rbtree_find() is introduced
> to search for the device within the rbtree. Replace
> pci_get_domain_bus_and_slot() in the IO page fault handling path.
> 
> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  1 +
>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>  drivers/iommu/intel/svm.c   | 14 ++++++--------
>  3 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 54eeaa8e35a9..f13c228924f8 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>  void iommu_flush_write_buffer(struct intel_iommu *iommu);
>  struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>  					       const struct iommu_user_data *user_data);
> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 09009d96e553..d92c680bcc96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
>  	return device_rid_cmp_key(&key, rhs);
>  }
>  
> +/*
> + * Looks up an IOMMU-probed device using its source ID.
> + *
> + * If the device is found:
> + *  - Increments its reference count.
> + *  - Returns a pointer to the device.
> + *  - The caller must call put_device() after using the pointer.
> + *
> + * If the device is not found, returns NULL.
> + */
> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
> +{
> +	struct device_domain_info *info;
> +	struct device *dev = NULL;
> +	struct rb_node *node;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> +	node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
> +	if (node) {
> +		info = rb_entry(node, struct device_domain_info, node);
> +		dev = info->dev;
> +		get_device(dev);

This get_device() is a bit troubling. It eventually calls into
iommu_report_device_fault() which does:

	struct dev_iommu *param = dev->iommu;

Which is going to explode if the iomm driver release has already
happened, which is a precondition to getting to a unref'd struct
device.

The driver needs to do something to fence these events during it's
release function.

If we are already doing that then I'd suggest to drop the get_device
and add a big fat comment explaining the special rules about lifetime
that are in effect here.

Otherwise you need to do that barrier rethink the way the locking
works..

Aside from that this looks like a great improvement to me

Thanks,
Jason

