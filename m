Return-Path: <linux-kernel+bounces-155492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31E8AEB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C751C21DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764E13C907;
	Tue, 23 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuQ45rdo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94513BACF;
	Tue, 23 Apr 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886895; cv=none; b=usJ3T7HR8hNES8S2yEvy3dah/Xl5CaIR0CI76mqvUP6qtZjg7iw8SH4ENqfmvHzIPPoxx9t2OBY285uLQ8Bg9qvicvgfRKe214yZj/12xNyyG7jrLkeZfSqOUhDhB2ieJM0UATbZnBssnG7k8jC65xbkOJykbLR4euyNkUAAj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886895; c=relaxed/simple;
	bh=2zaohWkr4/ZzVOQ18CabMhpIgO+D+z5wejwVM49hizY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0Bt4CVgRn2cDBUznAgnCuZaHnYv9z340a9ISi0g6pG1gTo34xVxVSww3Mz2tNHPhGirzlNc1hye+wVpehvIoyXyT52mlDLeiarwRrqeXYftySnlWhK7DnPIk+712qUqxflwOp18uETFcIVS3JjF0FdROHdU4GsJe4YiliToRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuQ45rdo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713886894; x=1745422894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2zaohWkr4/ZzVOQ18CabMhpIgO+D+z5wejwVM49hizY=;
  b=UuQ45rdoKNvNYqQS85d/giJl9YJV+RjDf8+DrNB+c/vX3PHFa/46pVaG
   YYxX6t8W+neCClxD4fu8kiMRYx6m7kQlX3hg37kr2deJ3XHFQzO+fzf5F
   YgZOtvNp7qCLlZzldG/8ut6HYgIdKO+Li8Ihg1y+hHy51df0ANvan9Gqv
   ZcAfsTRJfXdwaU8v7TGEDqlY/80XBOhWQYO7vIDzyI+KFc/xe0u1cFhkN
   5Ue1Dr0IvrdZdugpC7NH0bAZl9D+ZV7dC8wB5Jxmg8mJcV+19aCOnqJxt
   GBtrCJ/i0y7jQcFJme4CAbmFjzjx231Mm1++4QvYifz0AGpwl7McD2Uya
   A==;
X-CSE-ConnectionGUID: GnVqRvyfRTWOKHps4alGEA==
X-CSE-MsgGUID: UOhc6jXjTT6a8zCHIQUfoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9353066"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9353066"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:41:25 -0700
X-CSE-ConnectionGUID: q0DIaQ9RQC6k9uzKEUrLqg==
X-CSE-MsgGUID: vL5W4u/1Sp+NCad6M2FZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24381468"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 08:41:22 -0700
Date: Tue, 23 Apr 2024 23:36:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [RFC PATCH v2 9/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Message-ID: <ZifVYiMgssOFjM17@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-10-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233942.828440-10-peter.colberg@intel.com>

On Tue, Apr 09, 2024 at 07:39:42PM -0400, Peter Colberg wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> DFL ports are registered as platform devices in PF mode. The port device
> should be removed from the host when the user wants to configure the
> port as a VF and pass through to a virtual machine. The FME device
> ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are designed for this purpose.
> 
> In the previous implementation, the port platform device is not completely
> destroyed on port release: it is removed from the system by
> platform_device_del(), but the platform device instance is retained.
> When the port assign ioctl is called, the platform device is added back by
> platform_device_add(), which conflicts with this comment of device_add():
> "Do not call this routine more than once for any device structure", and
> will cause a kernel warning at runtime.
> 
> This patch tries to completely unregister the port platform device on
> release and registers a new one on assign. But the main work is to remove
> the dependency on struct dfl_feature_platform_data for many internal DFL
> APIs. This structure holds many DFL enumeration infos for feature devices.
> Many DFL APIs are expected to work with these info even when the port
> platform device is unregistered. But with the change the platform_data will
> be freed in this case. So this patch introduces a new structure
> dfl_feature_dev_data for these APIs, which acts similarly to the previous
> dfl_feature_platform_data. The dfl_feature_platform_data then only needs a
> pointer to dfl_feature_dev_data to make the feature device driver work.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> v2:
> - Split monolithic patch into series at request of maintainer
> - Substitute binfo->type for removed function feature_dev_id_type() in
>   parse_feature_irqs().
> - Return ERR_PTR(-ENOMEM) on !feature->params in
>   binfo_create_feature_dev_data().
> - Reorder cdev as first member of struct dfl_feature_platform_data
>   such that container_of() to obtain pdata evaluates to a no-op.
> - Align kernel-doc function name for __dfl_fpga_cdev_find_port_data().
> ---
>  drivers/fpga/dfl-afu-main.c |   9 +-
>  drivers/fpga/dfl-fme-br.c   |  24 +-
>  drivers/fpga/dfl-fme-main.c |   6 +-
>  drivers/fpga/dfl.c          | 430 +++++++++++++++++-------------------
>  drivers/fpga/dfl.h          |  86 +++++---
>  5 files changed, 281 insertions(+), 274 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 42928cc7e42b..ead03b7aea70 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -143,9 +143,8 @@ static int port_reset(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int port_get_id(struct platform_device *pdev)
> +static int port_get_id(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
>  	void __iomem *base;
>  
>  	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
> @@ -156,7 +155,8 @@ static int port_get_id(struct platform_device *pdev)
>  static ssize_t
>  id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	int id = port_get_id(to_platform_device(dev));
> +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
> +	int id = port_get_id(fdata);

My quick idea is we go with these steps:
1. refactor struct dfl_feature_platform_data then replace all dev/pdev
   arguments with pdata when necessary.
2. factor out fdata from pdata, add fdata helpers.
3. massive pdata->fdata replacement.
4. delete all unused pdata helpers.

Please check if it is possible.

Thanks,
Yilun

