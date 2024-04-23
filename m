Return-Path: <linux-kernel+bounces-155370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A58AE973
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25661C22CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063EC13B58D;
	Tue, 23 Apr 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rc0xEBU+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FE6A03F;
	Tue, 23 Apr 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882505; cv=none; b=Y8fwoWxbgwHGtci5GwkgpkLOLbG0n9oXLY5YlIjjLX8tsvYLX+XHu4VgvWRC3VQj6OF0u6xZnIn8gFwydQDXBZgr+xEOFpD03JeoPjgLlRxgUZn0rC4v+Yd30NTJjCdQkQFmHJGS10QmNfy1c2zrT8PfqpKz+e2anGnekPscd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882505; c=relaxed/simple;
	bh=2HJP6c6rzfMx/DdclA4LGYavBm+vLvCyovqIQ6HeOik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQTY6AYCR9eSt7sycYbVDxUfHDjYTKAgZoYL681fcOyy+YT1DdnvmcjtdH7EaWDD5qOB48m16PwqRqRVe3f60bMEVOOuE/rwe9wBeRk8/E1z/UVLSfHR0EMkBBxVzD87/ivFh3Nquj0rwAxNmeKXlyAMo5r2jX9+ZVLX7of3EfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rc0xEBU+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882503; x=1745418503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2HJP6c6rzfMx/DdclA4LGYavBm+vLvCyovqIQ6HeOik=;
  b=Rc0xEBU+/I2saXQWAAh5RN6Yc2nW5FI/X+rUz99NcXD8zDhEM2qonHkv
   6hJglzKm+2ttS3caQ7C04QEKxA8riYI/ugqVcm8fXWvhQ5QCurknaAvld
   bftKCFQnZzLa6i0AIlA3ADgSbg62AG8ctOU0eBTTIGMQxX/Csgk0lUkBJ
   raB+OgwFK0pSTs+e9VwgmHFvSylvxpO32PiI8UQqana+566kIm4c8i4vu
   0CM/ErluDk8t74ZQ/QPTadkdBXvYjDNawryEGWqp030a5wpRR6jx8x9Aq
   yf1Vpv3yWl9paKtjaC9KtkTXMfM9rj1Ubbrlc8FmeXHratNotMJD3g368
   g==;
X-CSE-ConnectionGUID: lXkiwcy2TyGSZVfjFIGqAg==
X-CSE-MsgGUID: 5MfJwCv1RWCFqusiwwxN6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9634153"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9634153"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:28:23 -0700
X-CSE-ConnectionGUID: BLNHskHlSOeGgWbJr33Y1w==
X-CSE-MsgGUID: Qnfh0flzTVeWCX87DwkaRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24987062"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2024 07:28:20 -0700
Date: Tue, 23 Apr 2024 22:22:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"Xu, Yilun" <yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/9] fpga: dfl: migrate AFU MMIO region management
 driver to dfl_feature_dev_data
Message-ID: <ZifEQ42hMPazjiWd@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-4-peter.colberg@intel.com>
 <1aa50550adfb3917e94dd4f553ee88005133cd15.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1aa50550adfb3917e94dd4f553ee88005133cd15.camel@intel.com>

On Tue, Apr 09, 2024 at 11:56:19PM +0000, Colberg, Peter wrote:
> On Tue, 2024-04-09 at 19:39 -0400, Peter Colberg wrote:
> > This change separates out most of the symbol name changes required by this
> > patch series for the file: drivers/fpga/dfl-afu-region.c. This is done to
> > split a single monolithic change into multiple, smaller patches at the
> > request of the maintainer.
> > 
> > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > ---
> > v2:
> > - Split monolithic patch into series at request of maintainer
> > ---
> >  drivers/fpga/dfl-afu-region.c | 51 ++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
> > index 2e7b41629406..b11a5b21e666 100644
> > --- a/drivers/fpga/dfl-afu-region.c
> > +++ b/drivers/fpga/dfl-afu-region.c
> > @@ -12,11 +12,11 @@
> >  
> >  /**
> >   * afu_mmio_region_init - init function for afu mmio region support
> > - * @pdata: afu platform device's pdata.
> > + * @fdata: afu feature dev data
> >   */
> > -void afu_mmio_region_init(struct dfl_feature_platform_data *pdata)
> > +void afu_mmio_region_init(struct dfl_feature_dev_data *fdata)
> >  {
> > -	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> > +	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
> >  
> >  	INIT_LIST_HEAD(&afu->regions);
> >  }
> > @@ -39,7 +39,7 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
> >  /**
> >   * afu_mmio_region_add - add a mmio region to given feature dev.
> >   *
> > - * @pdata: afu platform device's pdata.
> > + * @fdata: afu feature dev data
> >   * @region_index: region index.
> >   * @region_size: region size.
> >   * @phys: region's physical address of this region.
> > @@ -47,14 +47,15 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
> >   *
> >   * Return: 0 on success, negative error code otherwise.
> >   */
> > -int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
> > +int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
> >  			u32 region_index, u64 region_size, u64 phys, u32 flags)
> >  {
> > +	struct device *dev = &fdata->dev->dev;
> >  	struct dfl_afu_mmio_region *region;
> >  	struct dfl_afu *afu;
> >  	int ret = 0;
> >  
> > -	region = devm_kzalloc(&pdata->dev->dev, sizeof(*region), GFP_KERNEL);
> > +	region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
> >  	if (!region)
> >  		return -ENOMEM;
> >  
> > @@ -63,13 +64,13 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
> >  	region->phys = phys;
> >  	region->flags = flags;
> >  
> > -	mutex_lock(&pdata->lock);
> > +	mutex_lock(&fdata->lock);
> >  
> > -	afu = dfl_fpga_pdata_get_private(pdata);
> > +	afu = dfl_fpga_fdata_get_private(fdata);
> >  
> >  	/* check if @index already exists */
> >  	if (get_region_by_index(afu, region_index)) {
> > -		mutex_unlock(&pdata->lock);
> > +		mutex_unlock(&fdata->lock);
> >  		ret = -EEXIST;
> >  		goto exit;
> >  	}
> > @@ -80,37 +81,37 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
> >  
> >  	afu->region_cur_offset += region_size;
> >  	afu->num_regions++;
> > -	mutex_unlock(&pdata->lock);
> > +	mutex_unlock(&fdata->lock);
> >  
> >  	return 0;
> >  
> >  exit:
> > -	devm_kfree(&pdata->dev->dev, region);
> > +	devm_kfree(dev, region);
> 
> An internal reviewer commented that calling devm_kfree() in almost all
> cases shows a misunderstanding of object lifetime and may unveil bugs.
> They suggested to either drop the explicit devm_kfree(), or move from
> devm_*() to plain allocation.
> 
> I could not find specific documentation on the recommended use cases
> for devm_kfree() to immediately free a resource on error, but the
> description of devres groups advises that explicit freeing using
> devres_release_group() is usually useful in midlayer drivers where
> interface functions should not have side effects [1].
> 
> Which implementation would you prefer and why? Dropping devm_kfree(),
> moving to plain allocation, or leaving everything as is?

Using devm_*() usually means the lifecycle of the allocated object
should be the same as the device. Otherwise use the plain allocation.
Please check which case fits for you.

Thanks,
Yilun

> 
> [1] https://docs.kernel.org/driver-api/driver-model/devres.html#devres-group 
> 
> Thanks,
> Peter
> 
> >  	return ret;
> >  }
> >  
> >  /**
> >   * afu_mmio_region_destroy - destroy all mmio regions under given feature dev.
> > - * @pdata: afu platform device's pdata.
> > + * @fdata: afu feature dev data
> >   */
> > -void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata)
> > +void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata)
> >  {
> > -	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> > +	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
> >  	struct dfl_afu_mmio_region *tmp, *region;
> >  
> >  	list_for_each_entry_safe(region, tmp, &afu->regions, node)
> > -		devm_kfree(&pdata->dev->dev, region);
> > +		devm_kfree(&fdata->dev->dev, region);
> >  }
> >  
> >  /**
> >   * afu_mmio_region_get_by_index - find an afu region by index.
> > - * @pdata: afu platform device's pdata.
> > + * @fdata: afu feature dev data
> >   * @region_index: region index.
> >   * @pregion: ptr to region for result.
> >   *
> >   * Return: 0 on success, negative error code otherwise.
> >   */
> > -int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
> > +int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
> >  				 u32 region_index,
> >  				 struct dfl_afu_mmio_region *pregion)
> >  {
> > @@ -118,8 +119,8 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
> >  	struct dfl_afu *afu;
> >  	int ret = 0;
> >  
> > -	mutex_lock(&pdata->lock);
> > -	afu = dfl_fpga_pdata_get_private(pdata);
> > +	mutex_lock(&fdata->lock);
> > +	afu = dfl_fpga_fdata_get_private(fdata);
> >  	region = get_region_by_index(afu, region_index);
> >  	if (!region) {
> >  		ret = -EINVAL;
> > @@ -127,14 +128,14 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
> >  	}
> >  	*pregion = *region;
> >  exit:
> > -	mutex_unlock(&pdata->lock);
> > +	mutex_unlock(&fdata->lock);
> >  	return ret;
> >  }
> >  
> >  /**
> >   * afu_mmio_region_get_by_offset - find an afu mmio region by offset and size
> >   *
> > - * @pdata: afu platform device's pdata.
> > + * @fdata: afu feature dev data
> >   * @offset: region offset from start of the device fd.
> >   * @size: region size.
> >   * @pregion: ptr to region for result.
> > @@ -144,7 +145,7 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
> >   *
> >   * Return: 0 on success, negative error code otherwise.
> >   */
> > -int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
> > +int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
> >  				  u64 offset, u64 size,
> >  				  struct dfl_afu_mmio_region *pregion)
> >  {
> > @@ -152,8 +153,8 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
> >  	struct dfl_afu *afu;
> >  	int ret = 0;
> >  
> > -	mutex_lock(&pdata->lock);
> > -	afu = dfl_fpga_pdata_get_private(pdata);
> > +	mutex_lock(&fdata->lock);
> > +	afu = dfl_fpga_fdata_get_private(fdata);
> >  	for_each_region(region, afu)
> >  		if (region->offset <= offset &&
> >  		    region->offset + region->size >= offset + size) {
> > @@ -162,6 +163,6 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
> >  		}
> >  	ret = -EINVAL;
> >  exit:
> > -	mutex_unlock(&pdata->lock);
> > +	mutex_unlock(&fdata->lock);
> >  	return ret;
> >  }
> 

