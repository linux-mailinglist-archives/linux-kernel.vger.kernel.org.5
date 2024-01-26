Return-Path: <linux-kernel+bounces-40658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17183E3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D1C1C22DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9E24A0D;
	Fri, 26 Jan 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJW1y4oi"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC15249EA;
	Fri, 26 Jan 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303687; cv=none; b=a1F5ThIUHUiGVafjDibEpCl4JWh7dQChXWq4GstEvNoYnSWWaA90ls/P+w9opyx/2I+xLN+bpyajZ9+1hgo8dM5c4GoejSy/pP07ZspLlr31SpssCduq7ucCbkggkpcHuv/1bslEymaoY+yRXjwf2/UMCQsJzbdesnr9EMe5eBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303687; c=relaxed/simple;
	bh=bqOAFirl4XtgWEUGnrqW5ioCbAdx3ANcQrwde5HfmII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8M7ltTRWo/fZpHgI42wNIcZ9gvGWOecAaSnBVhG/wpJJHDSj0Nl0rahX9h2yTMtkGC/fpuX90CMn7ukkU5pONxHsvz+4+jnUTnsRtDBgBfivfk9DsRFMiSC387Ua2UPeXcUM4YEaEDbwQXIIMlfsRPcUCQvIOqb7Cp5BBb0OPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJW1y4oi; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706303686; x=1737839686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqOAFirl4XtgWEUGnrqW5ioCbAdx3ANcQrwde5HfmII=;
  b=mJW1y4oi60k/+UXuHUMI+wznBIT0lERBROG5PRIGsb34Nys3zYNe/85o
   +CCj8gELssgacHamtlO+FXIZZUGuTYDk7fFiYZeJxq75AAYchzQt7/F/j
   7LpL8DzcPLd68WXSliOypS6m5gXzW5p7FPYr9avsrpguxnppcS3mBw5hF
   xZ0SYK0rR4hhmgcMG6lNVRHxoeXQI2o1WBZn+7m6n2Y35hBigaZKRqlZ7
   N37LvZ2RHjS3oFRRrd092OzS2PUZC/N93eQZAEjIANBJt6eZbwl1IhxS+
   w59y3Tu58eY4YZ0uOz1bmlMbVVVO8eOMrIcMODsc54RHHAROHJsj8KLPc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466853098"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466853098"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21486061"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.37.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:14:43 -0800
Date: Fri, 26 Jan 2024 13:14:42 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/5] dax/bus.c: replace several sprintf() with
 sysfs_emit()
Message-ID: <ZbQgwt/Wc3uWvXXK@aschofie-mobl2>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
 <20240124-vv-dax_abi-v7-2-20d16cb8d23d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-vv-dax_abi-v7-2-20d16cb8d23d@intel.com>

On Wed, Jan 24, 2024 at 12:03:47PM -0800, Vishal Verma wrote:
> There were several places where drivers/dax/bus.c uses 'sprintf' to
> print sysfs data. Since a sysfs_emit() helper is available specifically
> for this purpose, replace all the sprintf() usage for sysfs with
> sysfs_emit() in this file.
>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index cb148f74ceda..0fd948a4443e 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -269,7 +269,7 @@ static ssize_t id_show(struct device *dev,
>  {
>  	struct dax_region *dax_region = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", dax_region->id);
> +	return sysfs_emit(buf, "%d\n", dax_region->id);
>  }
>  static DEVICE_ATTR_RO(id);
>  
> @@ -278,8 +278,8 @@ static ssize_t region_size_show(struct device *dev,
>  {
>  	struct dax_region *dax_region = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%llu\n", (unsigned long long)
> -			resource_size(&dax_region->res));
> +	return sysfs_emit(buf, "%llu\n",
> +			  (unsigned long long)resource_size(&dax_region->res));
>  }
>  static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
>  		region_size_show, NULL);
> @@ -289,7 +289,7 @@ static ssize_t region_align_show(struct device *dev,
>  {
>  	struct dax_region *dax_region = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%u\n", dax_region->align);
> +	return sysfs_emit(buf, "%u\n", dax_region->align);
>  }
>  static struct device_attribute dev_attr_region_align =
>  		__ATTR(align, 0400, region_align_show, NULL);
> @@ -322,7 +322,7 @@ static ssize_t available_size_show(struct device *dev,
>  	size = dax_region_avail_size(dax_region);
>  	up_read(&dax_region_rwsem);
>  
> -	return sprintf(buf, "%llu\n", size);
> +	return sysfs_emit(buf, "%llu\n", size);
>  }
>  static DEVICE_ATTR_RO(available_size);
>  
> @@ -340,7 +340,7 @@ static ssize_t seed_show(struct device *dev,
>  	if (rc)
>  		return rc;
>  	seed = dax_region->seed;
> -	rc = sprintf(buf, "%s\n", seed ? dev_name(seed) : "");
> +	rc = sysfs_emit(buf, "%s\n", seed ? dev_name(seed) : "");
>  	up_read(&dax_region_rwsem);
>  
>  	return rc;
> @@ -361,7 +361,7 @@ static ssize_t create_show(struct device *dev,
>  	if (rc)
>  		return rc;
>  	youngest = dax_region->youngest;
> -	rc = sprintf(buf, "%s\n", youngest ? dev_name(youngest) : "");
> +	rc = sysfs_emit(buf, "%s\n", youngest ? dev_name(youngest) : "");
>  	up_read(&dax_region_rwsem);
>  
>  	return rc;
> @@ -763,7 +763,7 @@ static ssize_t start_show(struct device *dev,
>  	dax_range = get_dax_range(dev);
>  	if (!dax_range)
>  		return -ENXIO;
> -	rc = sprintf(buf, "%#llx\n", dax_range->range.start);
> +	rc = sysfs_emit(buf, "%#llx\n", dax_range->range.start);
>  	put_dax_range();
>  
>  	return rc;
> @@ -779,7 +779,7 @@ static ssize_t end_show(struct device *dev,
>  	dax_range = get_dax_range(dev);
>  	if (!dax_range)
>  		return -ENXIO;
> -	rc = sprintf(buf, "%#llx\n", dax_range->range.end);
> +	rc = sysfs_emit(buf, "%#llx\n", dax_range->range.end);
>  	put_dax_range();
>  
>  	return rc;
> @@ -795,7 +795,7 @@ static ssize_t pgoff_show(struct device *dev,
>  	dax_range = get_dax_range(dev);
>  	if (!dax_range)
>  		return -ENXIO;
> -	rc = sprintf(buf, "%#lx\n", dax_range->pgoff);
> +	rc = sysfs_emit(buf, "%#lx\n", dax_range->pgoff);
>  	put_dax_range();
>  
>  	return rc;
> @@ -969,7 +969,7 @@ static ssize_t size_show(struct device *dev,
>  	size = dev_dax_size(dev_dax);
>  	up_write(&dax_dev_rwsem);
>  
> -	return sprintf(buf, "%llu\n", size);
> +	return sysfs_emit(buf, "%llu\n", size);
>  }
>  
>  static bool alloc_is_aligned(struct dev_dax *dev_dax, resource_size_t size)
> @@ -1233,7 +1233,7 @@ static ssize_t align_show(struct device *dev,
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
> -	return sprintf(buf, "%d\n", dev_dax->align);
> +	return sysfs_emit(buf, "%d\n", dev_dax->align);
>  }
>  
>  static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
> @@ -1311,7 +1311,7 @@ static ssize_t target_node_show(struct device *dev,
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
> -	return sprintf(buf, "%d\n", dev_dax_target_node(dev_dax));
> +	return sysfs_emit(buf, "%d\n", dev_dax_target_node(dev_dax));
>  }
>  static DEVICE_ATTR_RO(target_node);
>  
> @@ -1327,7 +1327,7 @@ static ssize_t resource_show(struct device *dev,
>  	else
>  		start = dev_dax->ranges[0].range.start;
>  
> -	return sprintf(buf, "%#llx\n", start);
> +	return sysfs_emit(buf, "%#llx\n", start);
>  }
>  static DEVICE_ATTR(resource, 0400, resource_show, NULL);
>  
> @@ -1338,14 +1338,14 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  	 * We only ever expect to handle device-dax instances, i.e. the
>  	 * @type argument to MODULE_ALIAS_DAX_DEVICE() is always zero
>  	 */
> -	return sprintf(buf, DAX_DEVICE_MODALIAS_FMT "\n", 0);
> +	return sysfs_emit(buf, DAX_DEVICE_MODALIAS_FMT "\n", 0);
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
>  static ssize_t numa_node_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_node(dev));
> +	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> 
> -- 
> 2.43.0
> 
> 

