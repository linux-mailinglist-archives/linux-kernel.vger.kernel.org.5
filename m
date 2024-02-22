Return-Path: <linux-kernel+bounces-76399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7174585F6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2613E283C32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1441776;
	Thu, 22 Feb 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEt5svfk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7400405D4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601059; cv=none; b=F0aiIEhrFLhontvdxxAeC6uZgIbyg9mYYnSlFp/8KvCf4ws7PFEVG/bSXC+xdBGUCjsE0SQsMd6HPKkZHDGIoHu677guEKGw3pdAr0F+1Sl/75Ussk9a2raVOFlg4TT/Bf3DMiDbyAK3uKaGSKbXQPRcHEyOjGuP5JXURlEqoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601059; c=relaxed/simple;
	bh=inTQdY5SH59sOtE/87PynLBV4T4wuKBQEIAbWFx9vkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyjmePViS4385mSuXAphJk4nuT8qcbQ8EwFBZkYcmJ19ehcUaBT7LCtmKJmAn6Lhgq+joSnOmYwA/5mv0QD3bMLJFIq7KERhcoySBLnuDk7JVkJLdHvX81S+qJiSGdkzAzQUDqG94C74FipG9G5ekO9H3UM7YdQvt6TFbYP4Kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEt5svfk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41276a43dc3so11381765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708601056; x=1709205856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqEeq1wIdA2VonSejspd8tgQGyiApSRfSkr6oRM5U9g=;
        b=gEt5svfkmyqjQ6b5VFWwDTNdxDHVDfFmnKr7kApyGFlosKZ2PTQr0zuPX3EKA2BzXd
         J7yfQ6xgek4Jb4knBZj4A/DJpyQ4702TTlSh5mHi3NE8ciCjmsrvdDI/4u0K/HnZFqrr
         W+EEULS04efwoYSFh6qhNNTclH9S91IYOWRg5ckG2W2Hj23O20DRCnoiJFEesyvNX/bQ
         VmWWj4uH4eZlL9oOXxgiL5ITN6S9UWvFruj93aOKrVSivyGrefQjg/iN1nliC80dT+sP
         i1zlD6uPVaPZ2J65hwHPEd8OrJW9UJh7/fCf43KV7QOEGnIRHxuG8og8eYgEL+BYjpSh
         Az8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601056; x=1709205856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqEeq1wIdA2VonSejspd8tgQGyiApSRfSkr6oRM5U9g=;
        b=T6jt7J4Pv7XE529PXYFrLwkKqIgfk059WSjcu/FsQAWt4SmyqwqKC0MRWrX3oO4tWs
         ejsTFAuyB6PwpkAtbnEiYhTTVmuEZSucSQOc+AdqJ7qe+1sfOOCuUms6Od4DjviFIEuA
         cWCn9EG0dLq4NImlMf2R3tdkMhOOYAAh+YJ9aEJhAA5Gfb9wf5I70VfK8di3ID/0l73z
         C5Vm+v3EKT37dlFcBL5rrO73Az63os4WabIBhKOuz7GjIiB56iOHQ9LiuX+hGHcblClE
         75wRqnzvgqamZRxBB1H2esV91SCmjVQXbmGgrPp76LjpbYjiagtz1GUjtORtu/0rNhk2
         hKFw==
X-Forwarded-Encrypted: i=1; AJvYcCUL/vg7HXbXU/cADn66J0hQfwzH8IF364OOdg01P+cEeAMflRj1T5cVbh0yTv9MTC9eOJ9MeKL4dSFJ/8tlj5+v7rI0j8INEf4uP8Mx
X-Gm-Message-State: AOJu0YxJKQYuG2iTBPCUWwkknQESTyLASx0v4ek7IFx8H/QML8M5B0aM
	TfhtpsHzK50kZjx1SkzLUQWF+3opnGzatyxwYRxtI+dy6UgcGqmNgXpXamBc5Ng=
X-Google-Smtp-Source: AGHT+IFbZl22L3B28jhj398tqBenu+qqj0WScFRUPY/I7QkkGNNZIcDW6FMPAAx8TMuoprcZzNDV7g==
X-Received: by 2002:adf:fd07:0:b0:33d:9231:d1c2 with SMTP id e7-20020adffd07000000b0033d9231d1c2mr919322wrr.25.1708601056009;
        Thu, 22 Feb 2024 03:24:16 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600003cb00b0033d9ac8f356sm745848wrg.93.2024.02.22.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:24:15 -0800 (PST)
Date: Thu, 22 Feb 2024 14:24:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>

I'm sorry, I'm coming into this late and this is the first time I have
reviewed this patch.  I see that we are at v13, and I hate to come in
with picky comments when a patch has already gone through 13
revisions...

On Thu, Feb 22, 2024 at 04:02:51AM -0500, Ethan Zhao wrote:
> Because surprise removal could happen anytime, e.g. user could request safe
> removal to EP(endpoint device) via sysfs and brings its link down to do
> surprise removal cocurrently. such aggressive cases would cause ATS
> invalidation request issued to non-existence target device, then deadly
> loop to retry that request after ITE fault triggered in interrupt context.
> this patch aims to optimize the ITE handling by checking the target device
> presence state to avoid retrying the timeout request blindly, thus avoid
> hard lockup or system hang.
> 
> Devices are valid ATS invalidation request target only when they reside

"valid invalidation" is awkward wording.  Can we instead say:

Devices should only be invalidated when they are in the
iommu->device_rbtree (probed, not released) and present.

> in the iommu->device_rbtre (probed, not released) and present.
                            ^
Missing e in _rbtree.

> 
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>

This patch should have a Fixes tags and be backported to stable kernels.
I think it goes back all the way...

Fixes: 704126ad81b8 ("VT-d: handle Invalidation Queue Error to avoid system hang")

> ---
>  drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d14797aabb7a..d01d68205557 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>  {
>  	u32 fault;
>  	int head, tail;
> +	u64 iqe_err, ite_sid;
> +	struct device *dev = NULL;
> +	struct pci_dev *pdev = NULL;
>  	struct q_inval *qi = iommu->qi;
>  	int shift = qi_shift(iommu);
>  
> @@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>  		tail = readl(iommu->reg + DMAR_IQT_REG);
>  		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>  
> +		/*
> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
> +		 */
> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
> +
>  		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>  		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>  
> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>  			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>  		} while (head != tail);
>  
> +		/*
> +		 * If got ITE, we need to check if the sid of ITE is one of the
> +		 * current valid ATS invalidation target devices, if no, or the
> +		 * target device isn't presnet, don't try this request anymore.
> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> +		 */

This comment is kind of confusing.

/*
 * If we have an ITE, then we need to check whether the sid of the ITE
 * is in the rbtree (meaning it is probed and not released), and that
 * the PCI device is present.
 */

My comment is slightly shorter but I think it has the necessary
information.

> +		if (ite_sid) {
> +			dev = device_rbtree_find(iommu, ite_sid);
> +			if (!dev || !dev_is_pci(dev))
> +				return -ETIMEDOUT;

-ETIMEDOUT is weird.  The callers don't care which error code we return.
Change this to -ENODEV or something

> +			pdev = to_pci_dev(dev);
> +			if (!pci_device_is_present(pdev) &&
> +				ite_sid == pci_dev_id(pci_physfn(pdev)))

The && confused me, but then I realized that probably "ite_sid ==
pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?

		pdev = to_pci_dev(dev);
		if (!pci_device_is_present(pdev))
			return -ENODEV;


> +				return -ETIMEDOUT;

-ENODEV.

> +		}
>  		if (qi->desc_status[wait_index] == QI_ABORT)
>  			return -EAGAIN;
>  	}

Sorry, again for nit picking a v13 patch.  I'm not a domain expert but
this patchset seems reasonable to me.

regards,
dan carpenter

