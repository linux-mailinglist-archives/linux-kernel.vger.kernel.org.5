Return-Path: <linux-kernel+bounces-43009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBABA840A34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BC1C21EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422F154443;
	Mon, 29 Jan 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="owqHGQGq"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53800154426
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542677; cv=none; b=kXj8POOVtc5o7tQEEJ5VEVuRTJwpAVHfRHB4i2uF9WbzkMEQ70DV4Caihmaw42vIIGNvjfZWcJv//c5sI5QkwXYbGXoTidiwLVkYHh647hXYhBRj2zmFI8S7DhRGIxKNF9Jsd6ztVvd9uYl63FBS66Ph4zRy4DeQvm4inxRkKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542677; c=relaxed/simple;
	bh=dv7rvRTXCssC2Ucy3ETYL9O+pACUSn657yVE+v0ZMSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8lxoPu4h3RygMEB7uxjDv6SAPG+EQ4NuMMCQ4uu6tint/Km0BLeYbLTlxXS5xMX8QsZ36NYhN805m794p/DwwbEVtqLvJ0CY+3Rpp+/fDcXgbE+PuDfg8ag/jg3kjLxJVSrRxoLWUM/MW5vfGkfQsDfZrKJwLoOvf9J9KPsL7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=owqHGQGq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e11faeb125so581929a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706542674; x=1707147474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u6y5RGZUaOEJts7DaeBk/aybPKOo63QfRuk7QPhhAo=;
        b=owqHGQGqtbUf8a/Ho4QsD2/LPQhfOhR7WY0o2qDk6nIl1pmaEem9f3jleLmuH9xL+R
         r2pIqwgrc3RnyvlTrYurSDufJwdm8Doy70TvefYh+MlAgihzO81X6C/yfhyqbvcZLf61
         Vx+LAkc01OZE96jEO7j0v88l7iYeZagJpC9cDl8akCmP0knyd6cMu/Rqa5yRcGbI4zCY
         zSZB6FOR1hkDkwwizyDk3VqXRUEe4q9JaE32HLZsPClYudxswxp0a/hyLIWUAoYoDRJ7
         Hx73ANqu63r6vfK44l/t2fBSc/OQv+kIVYceWfAobtZp6tYXQBfOB5ut0GrooD2w54BK
         vW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706542674; x=1707147474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u6y5RGZUaOEJts7DaeBk/aybPKOo63QfRuk7QPhhAo=;
        b=lyCOV1vdcqIrTmCDlMmV5Z/ofIQUPIDSa7ZoCxXjNZR86bK3b/0rHd35BkC2J6JOBD
         gRRkLWdX0++pSROKnlrstoQDGCPlEvumZ/nbbny83E9RYFEIsrkioCW1Rm+tNvBn+/VS
         AtGxuDP7yy5tubayxUkXGC9Kb3ShPyY0oWrCciHUennqEehLgJ7khdd8HDo6nM9WqIor
         lz7PE4YaZo0ow2e/9UYpFp7/bdamRpi1j+PuSGS9jyF1lfth4ayqfREuh8ydk2dyp+mV
         m0Y9vvMKscxSGuqY2dmGuemZCltVYmDFsFPxyirqnd4wg+0SrsZh/2V4JkHYhh52St7S
         OBQQ==
X-Gm-Message-State: AOJu0Yw+MFkdwT5tjQ3JwVWOyobO8Y/oyIWNHTN02WddldETJZ0R6uxO
	SeLjD962Q9+juL6E2QFgpSnDKsJFD0PduSWsBYx7h9LDJAu0oWCdc5TUwbwbyYk=
X-Google-Smtp-Source: AGHT+IFioboZVLN9aAQFM+uMw6SK0ubssSHwws7ioYqVN5+2ra53qkjqKoRzZcZNHc4r/BPxL4LaUg==
X-Received: by 2002:a9d:685a:0:b0:6e0:ba7c:4203 with SMTP id c26-20020a9d685a000000b006e0ba7c4203mr5515941oto.1.1706542674389;
        Mon, 29 Jan 2024 07:37:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z21-20020a05683008d500b006e12266433csm750687otg.27.2024.01.29.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:37:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rUTho-00A9vk-Ij;
	Mon, 29 Jan 2024 11:37:52 -0400
Date: Mon, 29 Jan 2024 11:37:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu: Probe right iommu_ops for device
Message-ID: <20240129153752.GE50608@ziepe.ca>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126105341.78086-3-baolu.lu@linux.intel.com>

On Fri, Jan 26, 2024 at 06:53:41PM +0800, Lu Baolu wrote:
> Previously, in the iommu probe device path, __iommu_probe_device() gets
> the iommu_ops for the device from dev->iommu->fwspec if this field has
> been initialized before probing. Otherwise, it is assumed that only one
> of Intel, AMD, s390, PAMU or legacy SMMUv2 can be present, hence it's
> feasible to lookup the global iommu device list and use the iommu_ops of
> the first iommu device which has no dev->iommu->fwspec.
> 
> The assumption mentioned above is no longer correct with the introduction
> of the IOMMUFD mock device on x86 platforms. There might be multiple
> instances of iommu drivers, none of which have the dev->iommu->fwspec
> field populated.
> 
> Probe the right iommu_ops for device by iterating over all the global
> drivers and call their probe function to find a match.
> 
> Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0af0b5544072..2cdb01e411fa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -396,30 +396,69 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
>  }
>  EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
>  
> +static struct iommu_device *
> +__iommu_do_probe_device(struct device *dev, const struct iommu_ops *ops)
> +{
> +	struct iommu_device *iommu_dev;
> +
> +	if (!try_module_get(ops->owner))
> +		return ERR_PTR(-EINVAL);
> +
> +	iommu_dev = ops->probe_device(dev);
> +	if (IS_ERR(iommu_dev))
> +		module_put(ops->owner);

This doesn't really do enough to protect against races, to do that
fully we need to have iommu_device_unregister() do some better
locking, and fix fwspec->ops lifecycle somehow.. Remember that module
ref counts don't prevent iommu_device_unregister_bus() concurrency.

So, it would be simpler to leave the try_module_get in the
iommu_init_device(), just move it after the probe_device call.

> +static struct iommu_device *iommu_probe_device_ops(struct device *dev)
> +{
> +	struct iommu_device *iter, *iommu_dev = ERR_PTR(-ENODEV);
> +	struct iommu_fwspec *fwspec;
> +
> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> +	 * instances with non-NULL fwnodes, and client devices should have been
> +	 * identified with a fwspec by this point. Otherwise, we will iterate
> +	 * over all the global drivers and call their probe function to find a
> +	 * match.
> +	 */
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (fwspec && fwspec->ops)
> +		return __iommu_do_probe_device(dev, fwspec->ops);
> +
> +	mutex_lock(&iommu_device_lock);
> +	list_for_each_entry(iter, &iommu_device_list, list) {
> +		iommu_dev = __iommu_do_probe_device(dev, iter->ops);
> +		if (!IS_ERR(iommu_dev))
> +			break;

This does need to skip duplicate ops though (see my version), we don't
want to call the same driver many times. And Kevin and Robin are
right, since we recently removed a bunch of fwpsec checks from drivers
the core code must now never call a fwspec expecting driver without a
fwspec. (check for !iommu->fwnode)

Otherwise this looks fine for me, thanks

Jason

