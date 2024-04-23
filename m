Return-Path: <linux-kernel+bounces-155383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F66E8AE9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536071C22C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106784052;
	Tue, 23 Apr 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+J+XJu4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236311B815;
	Tue, 23 Apr 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882989; cv=none; b=uXqaDUOSh0mwZ0JidqtEwi8Tr3WUQbo/HXdvzSRiofcrmc6GYI9wKD2DyWFROXhjpyUFOtl/hR3HgeZfqM89q/DYf+c58tCVZDgIE9wA/KNJ86tEhe9xgbQezum5MRN3KyuTUDlbYpyMckUj5LZiefNDIxRQJo0WB+zMfHP92ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882989; c=relaxed/simple;
	bh=Gwm8ZPo1SC6T+uOpmJJVq6I3CmfxZWOiFLlPUuq9jY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFNomsdMlYDIgOXSJ9/BtZ83V/6dTRyAg+xm6hNk7lzWaQYuQKMiJQe7po2ijBMWfB7150HSyAhbGxJXSTvc05ei0u1lxUY/d/8jmQvYYMbjvSPZVeI95SPq96UGhKh82Ik1T5Swrl6tVLLnEC7165KJD3oefwQQR8FNVf/weB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+J+XJu4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882988; x=1745418988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gwm8ZPo1SC6T+uOpmJJVq6I3CmfxZWOiFLlPUuq9jY4=;
  b=X+J+XJu48VoJhS+jUvXZxldvgTD6fB8f6adH0tslE18M0GdsAFClW+b5
   5evd/qm/tjNIW7pHzwvCFaeB7hU9HEJt5GKfnfOIl/0b3t82fyWK7IKDk
   wE/nDAM7W18cx1Pemk54AL3OVTBIfubkau5HGjtMHSFeiUJPt1GxZ8SR1
   8mFr8m3nGseYydDciPkDDDMnc2SUAcYS+5cKxBTQmm4VUNKV1SOCglEJ1
   tppH7T1yb+waN+G772Ly4Awac7nMA402tkBNQZCPgizQhZvPS0zf6eJf4
   vk0cGu6HMd+9k6n66aNhEHt1mZrJzGnA/cGzRWNBUkH2fCR3tpH9tDJsI
   A==;
X-CSE-ConnectionGUID: bCeg287MSjOsYFIQMSp4OQ==
X-CSE-MsgGUID: WVHO0kw6T/WmW6fedzy4+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20871052"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20871052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:36:28 -0700
X-CSE-ConnectionGUID: IqM/G6yDRIKZaPaxlYhcNg==
X-CSE-MsgGUID: ydM3K6KcSk+vC3Soa6GxHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24843567"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 23 Apr 2024 07:36:25 -0700
Date: Tue, 23 Apr 2024 22:31:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 6/9] fpga: dfl: migrate Accelerated Function Unit
 driver to dfl_feature_dev_data
Message-ID: <ZifGKL65IDARHHN/@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-7-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233942.828440-7-peter.colberg@intel.com>

On Tue, Apr 09, 2024 at 07:39:39PM -0400, Peter Colberg wrote:
> This change separates out most of the symbol name changes required by this
> patch series for the file: drivers/fpga/dfl-afu-main.c. This is done to
> split a single monolithic change into multiple, smaller patches at the
> request of the maintainer.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> v2:
> - Split monolithic patch into series at request of maintainer
> - Change afu_ioctl_*() to receive dfl_feature_dev_data instead of
>   dfl_feature_platform_data.
> - Replace local variable pdata with fdata in afu_mmap().
> - Remove unused local variable pdata in afu_dev_{init,destroy}().
> ---
>  drivers/fpga/dfl-afu-main.c | 110 ++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 6b97c073849e..61868cdd5b0b 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -504,9 +504,11 @@ static const struct attribute_group port_afu_group = {
>  static int port_afu_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
>  {
> +	struct dfl_feature_dev_data *fdata =
> +					to_dfl_feature_dev_data(&pdev->dev);
>  	struct resource *res = &pdev->resource[feature->resource_index];
>  
> -	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> +	return afu_mmio_region_add(fdata,

Again, please keep the change simple for massive replacement. If you
want other adjustments, do it in another patch.

Thanks,
Yilun

