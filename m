Return-Path: <linux-kernel+bounces-155467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D635B8AEAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD001F226E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D813C3C7;
	Tue, 23 Apr 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERD2tFq9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D425820E;
	Tue, 23 Apr 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885716; cv=none; b=RlVKw1fZLvGs79yn/FSh9V4C8u0nnzXUNEZTtmKiZyTgf9whK9LecdkEsJc5Blc36O/5pIyfVm7G2AUaJ0JKXkCvl9WA0+WA0/cgrhebQcUO2zde68Hbf2jCTSZ+UmRtAqWk04nqw9PZVfVNvEx8haLhCwoBpkjvJ2UyuvQJfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885716; c=relaxed/simple;
	bh=8q+5COullrGgMK603hfx3nS02g/+X5nJrkqKlC5uCik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryXQk8Zz4miBocHsOav4uqJW5Ts9Qmpa7KtZ53nS7JY7egwuldu6U6kpd+7uSanWuih0MlBcJ4t5b9T68iiS97uR/BT9Nc0q8YJJcj9YZOhMR7lDe4Ljfoo2DgB3c/QXTm/l9d0U7cO5vBKOiqaZXeb7JQrokl6dzSUg/E7snNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERD2tFq9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713885715; x=1745421715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8q+5COullrGgMK603hfx3nS02g/+X5nJrkqKlC5uCik=;
  b=ERD2tFq9NGvUyfNBN0HJwMVCssus1a4DKFVYTAn9I+v2NjO4arKSFOR7
   MG1MhuZJ7u1P2mvu6kq4cuxxuZ7ItSjtGdd6LV3jXGQrsiqZgpYp1juX9
   opBxLFSM/rh5ZTDwu692W09ZQ3gtxj0jj//VbYapeKS0q1k9LODTV3x5y
   8F0rbEQnB0aBU3+7ZO+ZSLehsIcibYyG1GEOnxLETs+qbAgMfJe0zsXGI
   3DNqW02DjEq+Mp27eRS0/Edh8d2bYc48YNXbIhqMzfWUQuffD/YamYEoh
   HrCUfdYvF8OHr2/ezryzuTcRijAMgYAogWCHQYNSHSz1B+sw1MbkBuOhv
   g==;
X-CSE-ConnectionGUID: baCd5ciQSJeKZc01o3YAQg==
X-CSE-MsgGUID: WfqL9q+JST+e+kAn+W6Z+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20894090"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20894090"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:21:55 -0700
X-CSE-ConnectionGUID: XBqXt0IKS+6PsV6aoAeJHA==
X-CSE-MsgGUID: ICuqx3peTZ6KDBShrPd67g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24271344"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 23 Apr 2024 08:21:52 -0700
Date: Tue, 23 Apr 2024 23:16:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 8/9] fpga: dfl: migrate dfl_get_feature_by_id() to
 dfl_feature_dev_data
Message-ID: <ZifQz/QJvYpFljMv@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-9-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233942.828440-9-peter.colberg@intel.com>

On Tue, Apr 09, 2024 at 07:39:41PM -0400, Peter Colberg wrote:
> This change separates out most of the symbol name changes required by this
> patch series for the function: dfl_get_feature_by_id(). This is done to
> split a single monolithic change into multiple, smaller patches at the
> request of the maintainer.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> v2:
> - Split monolithic patch into series at request of maintainer
> ---
>  drivers/fpga/dfl-afu-error.c |  59 +++++++------
>  drivers/fpga/dfl-afu-main.c  | 166 ++++++++++++++++++-----------------
>  drivers/fpga/dfl-afu.h       |  26 +++---
>  drivers/fpga/dfl-fme-error.c |  98 +++++++++++----------
>  drivers/fpga/dfl-fme-main.c  |  18 ++--
>  drivers/fpga/dfl-fme-pr.c    |   6 +-
>  drivers/fpga/dfl.c           |   3 +-
>  drivers/fpga/dfl.h           |  13 ++-
>  8 files changed, 203 insertions(+), 186 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index ab7be6217368..0f392d1f6d45 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -28,37 +28,36 @@
>  #define ERROR_MASK		GENMASK_ULL(63, 0)
>  
>  /* mask or unmask port errors by the error mask register. */
> -static void __afu_port_err_mask(struct device *dev, bool mask)
> +static void __afu_port_err_mask(struct dfl_feature_dev_data *fdata, bool mask)

Maybe first replace all "struct device *dev" arguments with "struct
dfl_feature_platform data *pdata", then you could do simple
pdata->fdata replacement the same as other patches.

>  {
>  	void __iomem *base;
>  
> -	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
>  
>  	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
>  }
>  
>  static void afu_port_err_mask(struct device *dev, bool mask)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  
> -	mutex_lock(&pdata->lock);
> -	__afu_port_err_mask(dev, mask);
> -	mutex_unlock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
> +	__afu_port_err_mask(fdata, mask);
> +	mutex_unlock(&fdata->lock);
>  }
>  
>  /* clear port errors. */
>  static int afu_port_err_clear(struct device *dev, u64 err)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> -	struct platform_device *pdev = to_platform_device(dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  	void __iomem *base_err, *base_hdr;
>  	int enable_ret = 0, ret = -EBUSY;
>  	u64 v;
>  
> -	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> -	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +	base_err = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
> +	base_hdr = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
>  
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  
>  	/*
>  	 * clear Port Errors
> @@ -80,12 +79,12 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>  	}
>  
>  	/* Halt Port by keeping Port in reset */
> -	ret = __afu_port_disable(pdev);
> +	ret = __afu_port_disable(fdata);
>  	if (ret)
>  		goto done;
>  
>  	/* Mask all errors */
> -	__afu_port_err_mask(dev, true);
> +	__afu_port_err_mask(fdata, true);
>  
>  	/* Clear errors if err input matches with current port errors.*/
>  	v = readq(base_err + PORT_ERROR);
> @@ -102,28 +101,28 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>  	}
>  
>  	/* Clear mask */
> -	__afu_port_err_mask(dev, false);
> +	__afu_port_err_mask(fdata, false);
>  
>  	/* Enable the Port by clearing the reset */
> -	enable_ret = __afu_port_enable(pdev);
> +	enable_ret = __afu_port_enable(fdata);
>  
>  done:
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  	return enable_ret ? enable_ret : ret;
>  }
>  
>  static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 error;
>  
> -	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
>  
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	error = readq(base + PORT_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
>  }
> @@ -146,15 +145,15 @@ static DEVICE_ATTR_RW(errors);
>  static ssize_t first_error_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 error;
>  
> -	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
>  
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	error = readq(base + PORT_FIRST_ERROR);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  
>  	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
>  }
> @@ -164,16 +163,16 @@ static ssize_t first_malformed_req_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
>  	void __iomem *base;
>  	u64 req0, req1;
>  
> -	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
>  
> -	mutex_lock(&pdata->lock);
> +	mutex_lock(&fdata->lock);
>  	req0 = readq(base + PORT_MALFORMED_REQ0);
>  	req1 = readq(base + PORT_MALFORMED_REQ1);
> -	mutex_unlock(&pdata->lock);
> +	mutex_unlock(&fdata->lock);
>  
>  	return sprintf(buf, "0x%016llx%016llx\n",
>  		       (unsigned long long)req1, (unsigned long long)req0);
> @@ -191,12 +190,14 @@ static umode_t port_err_attrs_visible(struct kobject *kobj,
>  				      struct attribute *attr, int n)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> +	struct dfl_feature_dev_data *fdata;
>  
> +	fdata = to_dfl_feature_dev_data(dev);
>  	/*
>  	 * sysfs entries are visible only if related private feature is
>  	 * enumerated.
>  	 */
> -	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_ERROR))
> +	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_ERROR))
>  		return 0;
>  
>  	return attr->mode;
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 61868cdd5b0b..42928cc7e42b 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -26,7 +26,7 @@
>  
>  /**
>   * __afu_port_enable - enable a port by clear reset
> - * @pdev: port platform device.
> + * @fdata: port feature dev data.
>   *
>   * Enable Port by clear the port soft reset bit, which is set by default.
>   * The AFU is unable to respond to any MMIO access while in reset.
> @@ -35,18 +35,17 @@
>   *
>   * The caller needs to hold lock for protection.
>   */
> -int __afu_port_enable(struct platform_device *pdev)
> +int __afu_port_enable(struct dfl_feature_dev_data *fdata)

Same suggestion. Replace "struct platform_device *pdev" with "struct
dfl_feature_platform_data *pdata" first. Then do massive pdata->fdata
replacement.

Thanks,
Yilun

