Return-Path: <linux-kernel+bounces-143526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DE8A3A87
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A371C214C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA71804F;
	Sat, 13 Apr 2024 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df2AIMIR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3C8C1A;
	Sat, 13 Apr 2024 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712976067; cv=none; b=gsEkCAMLDbtvp/TGZ1nAkglV/YD7qmm2pmNw5u+1YuegjW94BUJEtHCuZVfwl4vn54sEVmnNjstiSZZmgo5MwcTvg07ubaUs7+gPLycyELTFmZBvsqny/R38dZVofxol5frYEAi1upX5I1x0R6CV9hvyMsOJ7cRaV+u2mnxWGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712976067; c=relaxed/simple;
	bh=axMJ7bTjXsx72XR3DZUHb3cgP4ohIiTGFHZNUvsGHSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ3KojnobEVlPE/jXwFAM04Yjdrsc9N8UjA0mwtCS4KS2A2cQj5N125qEVAuArx/5YVAmEj4SIC8nguboe5eZnQ2Qc9CAE0hzqzhOKwpo1uWbAQrT49W1vXdgjaYBpPQc+DqHJehqvjOsS+tEOMUdDjGOA3BgpFvh1QRmzP0cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df2AIMIR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712976064; x=1744512064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axMJ7bTjXsx72XR3DZUHb3cgP4ohIiTGFHZNUvsGHSM=;
  b=Df2AIMIRIZeaVZ5zzK2Z2mwbcHaiFDBbzztL7XAMOZ2B0MMmMeDsMuOb
   LrG6awYWZ/6YJCEiTSZsMdxUqyjAkdG9y4rTgwZhS0+NIT9oH7XB9jziK
   1o+Aekr8Ebf/fNKXRA/oA8juDwDSD1n4FQY1KzHssYzBjkwXBeTkQtTE1
   +anrLRBq7wooqymQNdZWLqU9xsXbidCrPlF3zGPWjuCpOR64Xn1ra5vmc
   TGOrhlL5JduN93dL0xVtlxZ1O01RNRTYZqBRsfIgkII/uymcPWqEttKc2
   v9j5KnZmsBBnxxi7Vl5kqHNUarBUT7rkijDdS0I0HJjbVZ6vC9wYvkoqK
   Q==;
X-CSE-ConnectionGUID: Q1dPpqK0QRKuJoogrKWZ3A==
X-CSE-MsgGUID: ImpDt05nSNKTELzT+qECAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19839619"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="19839619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 19:41:03 -0700
X-CSE-ConnectionGUID: NNm7cw+nRwaDjs5oPjLO2Q==
X-CSE-MsgGUID: y5xzLG7qRymsgK360LjoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="52353158"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 12 Apr 2024 19:40:59 -0700
Date: Sat, 13 Apr 2024 10:35:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] fpga: region: add owner module and take its refcount
Message-ID: <ZhnviXAgnTdzUyV4@yilunxu-OptiPlex-7050>
References: <20240411144811.121500-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411144811.121500-1-marpagan@redhat.com>

>  /**
> - * fpga_region_register_full - create and register an FPGA Region device
> + * __fpga_region_register_full - create and register an FPGA Region device
>   * @parent: device parent
>   * @info: parameters for FPGA Region
> + * @owner: owner module containing the get_bridges function

This is too specific and easily get unaligned if we add another
callback. How about "module containing the region ops"?

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
> +	region->ops_owner = owner;
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

ditto

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
> index 9d4d32909340..5fbc05fe70a6 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -36,6 +36,7 @@ struct fpga_region_info {
>   * @mgr: FPGA manager
>   * @info: FPGA image info
>   * @compat_id: FPGA region id for compatibility check.
> + * @ops_owner: module containing the get_bridges function

ditto

Thanks,
Yilun

>   * @priv: private data
>   * @get_bridges: optional function to get bridges to a list
>   */
> @@ -46,6 +47,7 @@ struct fpga_region {
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
>  	struct fpga_compat_id *compat_id;
> +	struct module *ops_owner;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
>  };

