Return-Path: <linux-kernel+bounces-136234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8389D192
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B1C1C238BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE704F887;
	Tue,  9 Apr 2024 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8OZoL1G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404832B2DD;
	Tue,  9 Apr 2024 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637550; cv=none; b=dC9smrkeLLpG1XLZ3B/fGG3zSdatZxBi7CERVNWhBBGRmvpDPyVGq/ZwmTFHXVnwI2LizgnlDBaY1hF6sjccBZgYUcYOxuw1xeT3OCa1d+xC0GNz7lTVUOFiLtSIP0v+P/2w9sYbyTZ6BGHTsbNpwiMHmwvMnBR8VpbnRsJx54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637550; c=relaxed/simple;
	bh=ycA266z9Fu5qQ6+Mf5rcGigwLLcHKxfV9eNB4knjk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khc1v/Ole0tAGiKlEmTqC9l172teR4QrxqldBWPRLbqpLmEp/HQc8F/Kfh0B4ismvdOzd1DSuCP5Iwpymp+qFuma4itxNGitYnyqmsJiKSxcWtLOZwkbKOuyTxv/Q3PfZ2TzBlznQ19B2zpzWHuH9ZAzaOVF/kdHLlMJcjx8Cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8OZoL1G; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712637548; x=1744173548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ycA266z9Fu5qQ6+Mf5rcGigwLLcHKxfV9eNB4knjk4E=;
  b=I8OZoL1GriF4dUxmcTghmabsK7K07/v/SDwpji1anmtERVJHUHx1fvo8
   o7gSV+O7RZLXwKcbM9JamC8l0586oawyKJDEeb+t77zAqvrLfhgJ/uPDX
   8xjrBgWtdGBbYhByYf3W5qBouSolwifOiGibD2zCzy5MTDxzWjl4dGXbg
   OaRYcFnyzV6371kcbcRcFz4IIXSHvBzESYwOh6sWL+sFJM8/VtR5z3Olh
   10b8FVEuJY52Yv3tAN4oZEIX35FLeymNhBFp158430btEHv3rbArfNjm+
   84LQrynMJk+ZU27cbmIhNarSBiN4Lrzxgw+/G4uu1sCzjKkPmoD/Vl/Gb
   Q==;
X-CSE-ConnectionGUID: QGbiNkX7S6imE7Sbrq463A==
X-CSE-MsgGUID: 8L0BK6frQo2JuTgNWJZLeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30430187"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="30430187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 21:39:07 -0700
X-CSE-ConnectionGUID: 71ymz3n5SzSd/6EYIs2T6w==
X-CSE-MsgGUID: g1+UMx4tQG+S1HVAqQW5Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20668754"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 08 Apr 2024 21:39:04 -0700
Date: Tue, 9 Apr 2024 12:34:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fpga: region: add owner module and take its refcount
Message-ID: <ZhTFPLWGkh0oRhL/@yilunxu-OptiPlex-7050>
References: <20240403144611.65507-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403144611.65507-1-marpagan@redhat.com>

On Wed, Apr 03, 2024 at 04:46:09PM +0200, Marco Pagani wrote:
> The current implementation of the fpga region assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the region
> during programming if the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_region
> struct and use it to take the module's refcount. Modify the functions for
> registering a region to take an additional owner module parameter and
> rename them to avoid conflicts. Use the old function names for helper
> macros that automatically set the module that registers the region as the
> owner. This ensures compatibility with existing low-level control modules
> and reduces the chances of registering a region without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga region.
> 
> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
> 
> v4:
> - Split out the swap between put_device() and mutex_unlock() while
>   releasing the region to avoid potential use after release issues
> v3:
> - Add reviewed-by Russ Weight
> v2:
> - Fixed typo in the documentation sets -> set
> - Renamed owner pointer get_br_owner -> br_owner
> ---
>  Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
>  drivers/fpga/fpga-region.c                    | 24 +++++++++++--------
>  include/linux/fpga/fpga-region.h              | 13 +++++++---
>  3 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
> index dc55d60a0b4a..77190a5ef330 100644
> --- a/Documentation/driver-api/fpga/fpga-region.rst
> +++ b/Documentation/driver-api/fpga/fpga-region.rst
> @@ -46,13 +46,16 @@ API to add a new FPGA region
>  ----------------------------
>  
>  * struct fpga_region - The FPGA region struct
> -* struct fpga_region_info - Parameter structure for fpga_region_register_full()
> -* fpga_region_register_full() -  Create and register an FPGA region using the
> +* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
> +* __fpga_region_register_full() -  Create and register an FPGA region using the
>    fpga_region_info structure to provide the full flexibility of options
> -* fpga_region_register() -  Create and register an FPGA region using standard
> +* __fpga_region_register() -  Create and register an FPGA region using standard
>    arguments
>  * fpga_region_unregister() -  Unregister an FPGA region
>  
> +Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
> +automatically set the module that registers the FPGA region as the owner.
> +
>  The FPGA region's probe function will need to get a reference to the FPGA
>  Manager it will be using to do the programming.  This usually would happen
>  during the region's probe function.
> @@ -82,10 +85,10 @@ following APIs to handle building or tearing down that list.
>     :functions: fpga_region_info
>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_register_full
> +   :functions: __fpga_region_register
>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_register
> +   :functions: __fpga_region_register_full

Why you swap the order? You didn't do that for fpga-mgr.

>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
>     :functions: fpga_region_unregister
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b364a929425c..d50ab1509989 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>  	}
>  
>  	get_device(dev);
> -	if (!try_module_get(dev->parent->driver->owner)) {
> +	if (!try_module_get(region->br_owner)) {
>  		put_device(dev);
>  		mutex_unlock(&region->mutex);
>  		return ERR_PTR(-ENODEV);
> @@ -75,7 +75,7 @@ static void fpga_region_put(struct fpga_region *region)
>  
>  	dev_dbg(dev, "put\n");
>  
> -	module_put(dev->parent->driver->owner);
> +	module_put(region->br_owner);
>  	put_device(dev);
>  	mutex_unlock(&region->mutex);
>  }
> @@ -181,14 +181,16 @@ static struct attribute *fpga_region_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_region);
>  
>  /**
> - * fpga_region_register_full - create and register an FPGA Region device
> + * __fpga_region_register_full - create and register an FPGA Region device
>   * @parent: device parent
>   * @info: parameters for FPGA Region
> + * @owner: owner module containing the get_bridges function
>   *
>   * Return: struct fpga_region or ERR_PTR()
>   */
>  struct fpga_region *
> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
> +			    struct module *owner)
>  {
>  	struct fpga_region *region;
>  	int id, ret = 0;
> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  	region->compat_id = info->compat_id;
>  	region->priv = info->priv;
>  	region->get_bridges = info->get_bridges;
> +	region->br_owner = owner;
>  
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
>  
>  /**
> - * fpga_region_register - create and register an FPGA Region device
> + * __fpga_region_register - create and register an FPGA Region device
>   * @parent: device parent
>   * @mgr: manager that programs this region
>   * @get_bridges: optional function to get bridges to a list
> + * @owner: owner module containing get_bridges function
>   *
>   * This simple version of the register function should be sufficient for most users.
>   * The fpga_region_register_full() function is available for users that need to
> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>   * Return: struct fpga_region or ERR_PTR()
>   */
>  struct fpga_region *
> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> -		     int (*get_bridges)(struct fpga_region *))
> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
>  {
>  	struct fpga_region_info info = { 0 };
>  
>  	info.mgr = mgr;
>  	info.get_bridges = get_bridges;
>  
> -	return fpga_region_register_full(parent, &info);
> +	return __fpga_region_register_full(parent, &info, owner);
>  }
> -EXPORT_SYMBOL_GPL(fpga_region_register);
> +EXPORT_SYMBOL_GPL(__fpga_region_register);
>  
>  /**
>   * fpga_region_unregister - unregister an FPGA region
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 9d4d32909340..d175babc3d68 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -36,6 +36,7 @@ struct fpga_region_info {
>   * @mgr: FPGA manager
>   * @info: FPGA image info
>   * @compat_id: FPGA region id for compatibility check.
> + * @br_owner: module containing the get_bridges function

I'm a little confused that you call it br_owner, just because there is
only one get_bridge() callback provided by low-level module. If we
further have another callback, the name & all the doc would be a problem.
And It is really the owner of the region module, not the bridge module.

Maybe just name it owner, or ops_owner?

Thanks,
Yilun

>   * @priv: private data
>   * @get_bridges: optional function to get bridges to a list
>   */
> @@ -46,6 +47,7 @@ struct fpga_region {
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
>  	struct fpga_compat_id *compat_id;
> +	struct module *br_owner;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
>  };
> @@ -58,12 +60,17 @@ fpga_region_class_find(struct device *start, const void *data,
>  
>  int fpga_region_program_fpga(struct fpga_region *region);
>  
> +#define fpga_region_register_full(parent, info) \
> +	__fpga_region_register_full(parent, info, THIS_MODULE)
>  struct fpga_region *
> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info);
> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
> +			    struct module *owner);
>  
> +#define fpga_region_register(parent, mgr, get_bridges) \
> +	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
>  struct fpga_region *
> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> -		     int (*get_bridges)(struct fpga_region *));
> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> +		       int (*get_bridges)(struct fpga_region *), struct module *owner);
>  void fpga_region_unregister(struct fpga_region *region);
>  
>  #endif /* _FPGA_REGION_H */
> 
> base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
> -- 
> 2.44.0
> 
> 

