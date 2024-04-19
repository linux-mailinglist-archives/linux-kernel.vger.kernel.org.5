Return-Path: <linux-kernel+bounces-151138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9678AA999
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36499B228E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8947F5F;
	Fri, 19 Apr 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK1SK2+X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EE52F63;
	Fri, 19 Apr 2024 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513445; cv=none; b=JYmdts0n/T55BpxfSi+RedNr6t+CGnAnGrKty0mluC3Puy0Mww9vz6r3gQFmwfBY8Vwds6iKAr0n45QGD9Rv8Z5DEmbK0o+toQI2UlV8Up3HwppknhJmx1AO30HjAj7UVKnbYlMEs1ZDGYjpoAsEZSpKhPR+Srz8zVHw4uXtXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513445; c=relaxed/simple;
	bh=/azgN9fac9eSB9GDOVwcavx6OAd95Ef5uZBSpwv/e8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoIoY+W/rDw1chI0gOjtEQsi+i+i82d2Vgq4tpXRHuWfdiJT2qYTlcXHBEgu8rweI1O4ENrlW+hdSDD8dIgFtYRmDTmSWYLDXR0Z8L+RLsoZfSL0AEQe++RsAhgegS8v91oQ0gpIxDGeXo8vh6nvGkC/Ug2BATaNkAvkDzN34cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK1SK2+X; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713513444; x=1745049444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/azgN9fac9eSB9GDOVwcavx6OAd95Ef5uZBSpwv/e8g=;
  b=mK1SK2+XrnbruwTav+3uwYvU1fYeX/c4ASSCDjf7heFk04zxykT+0v4m
   VexlknCu3z8TVQ3IOHD1g1j5YDEeCmfluVkARXl1t1Bvuj1dW78poTqUv
   7e56TI0I5q6oLrX79FA+Bw9gCIzyIF6kfMA6bckw3ki8xIfYH/P3BSReY
   rbQaMLzbhNpNYFNFWkRmnD5G9+h4aoJfovBKtPOTXgXZA9vRZ20s1HuqU
   DWpoR7mFnmVnOFcNLEJWvMMwXYiE6jZ9l6QkJnzo6VJ6Gr+BAysmOi3Sw
   H5DdqX/lncqcfFUy9ODr5AmCyjKzY+bk1ZH3q4sNUX1q4DMgWex22dtUq
   w==;
X-CSE-ConnectionGUID: bRjAzBujRpaG4D3ROVuCcQ==
X-CSE-MsgGUID: syFEHzbtTDOgoyiV/zChHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="34501527"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34501527"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:57:23 -0700
X-CSE-ConnectionGUID: uZpu/pNASeeRbeBwLJk6gA==
X-CSE-MsgGUID: A9VbWiRERTquWs18JfEGlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23319101"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 19 Apr 2024 00:57:20 -0700
Date: Fri, 19 Apr 2024 15:52:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v2] fpga: dfl: remove unused function
 is_dfl_feature_present
Message-ID: <ZiIipqA6PdZIslfR@yilunxu-OptiPlex-7050>
References: <20240415235743.3045-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415235743.3045-1-peter.colberg@intel.com>

On Mon, Apr 15, 2024 at 07:57:43PM -0400, Peter Colberg wrote:
> The function is_dfl_feature_present was added but never used.
                                    ^

Function reference should use the format "function_name()", I fixed it
in place.

Applied to for-next.

> 
> Fixes: 5b57d02a2f94 ("fpga: dfl: add feature device infrastructure")
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2:
> - Do not wrap commit reference and move to Fixes: tag.
> ---
>  drivers/fpga/dfl.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 1d724a28f00a..5063d73b0d82 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -437,11 +437,6 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>  	return NULL;
>  }
>  
> -static inline bool is_dfl_feature_present(struct device *dev, u16 id)
> -{
> -	return !!dfl_get_feature_ioaddr_by_id(dev, id);
> -}
> -
>  static inline
>  struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
>  {
> -- 
> 2.44.0
> 
> 

