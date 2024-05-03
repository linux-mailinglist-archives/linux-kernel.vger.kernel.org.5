Return-Path: <linux-kernel+bounces-167857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508A8BB064
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B51C2869F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DC1552FC;
	Fri,  3 May 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGn43vEQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1D8495
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751590; cv=none; b=QHjUYj/Sm/jjO+KhwSR8sHpsOvE5y6cR5cJsnB7aGqCYArRXNnOaD8d952EkW0Srbijm54WKi1Kz+OzbQiROh/BkYbjybLKTw9MYn4yz1DeVOp3HoAHMBzQlmLi6jdcc2NRY/ee7jkCFKyY7/ofXLdFyHpmOHPvj/JaE7jE7Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751590; c=relaxed/simple;
	bh=sc4C0K4F3XTmWdl75AnpnLYNRwZvYCekBch4PLnPnEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGlZA22tZimZPuoAqz3+3PkOHebVIDlebkA0px8QK3jeL37RJ9h1Z84XzmxtrRv6Iu5e2dso6UJhoIGsaQbUOm1ZpZJxuUKebHT78BQs4IL4XelpREgB0ijX5nTpHSv/GAmc6CNYr1PzvN5RSYxjymvNv9vtH1ZTD/DPMWwJdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGn43vEQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714751590; x=1746287590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sc4C0K4F3XTmWdl75AnpnLYNRwZvYCekBch4PLnPnEk=;
  b=ZGn43vEQ5FT2AQ++4zXtkwXHD2QdvofjoYCuxNbuBFkDqduoGmpcOzLz
   tbXIX0jUstdZbq/Z/fGA83+Z/f44bVUDG3GFvwhxtqXhYOjRcw90A2rev
   jgAqPJTGpjTlnYEOx3UlvLvD56GyhNYx3cf04PkvKv9bTtPgjB0t93hO7
   mpgMsqHmEdzn59+kcmouSy43MBQLE7mrFoF/JlqzZCIDSDTabrTOm5FAs
   sGhU/skbShs9D06HAqJbh5YnorpFIE/RnrMEMe0ys4eadEuAQ+duvL7fS
   SdxoWGMSWHnsTubdyjGfFKQ2gW1PG3BR0DT7esJwl91zi0sBNbHw/kCjL
   A==;
X-CSE-ConnectionGUID: 6X6UZEuXSJGRUUE62Jn9sg==
X-CSE-MsgGUID: cZSRXkukTrmvbD7A+cRmig==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14380755"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14380755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:53:08 -0700
X-CSE-ConnectionGUID: NxmVgb00QnylCsGnoo2E3w==
X-CSE-MsgGUID: pIEK1+KDQQup5ePDCpig+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27511938"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:53:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2vDX-00000003h8U-3nrd;
	Fri, 03 May 2024 18:52:59 +0300
Date: Fri, 3 May 2024 18:52:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v3] ALSA: ASoc/tas2781: Fix wrong loading calibrated data
 sequence
Message-ID: <ZjUIW3wMtib9KIKv@smile.fi.intel.com>
References: <20240502232450.484-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502232450.484-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 07:24:49AM +0800, Shenghao Ding wrote:
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.

..

> +static void tasdev_load_calibrated_data(struct tasdevice_priv *priv, int i)
> +{

> +	struct tasdevice_fw *cal_fmw = priv->tasdevice[i].cali_data_fmw;
> +
> +	if (cal_fmw) {

Better variant is

	struct tasdevice_calibration *cal;
	struct tasdevice_fw *cal_fmw;

	cal_fmw = priv->tasdevice[i].cali_data_fmw;
	if (!cal_fmw)
		return;

> +		struct tasdevice_calibration *cal = cal_fmw->calibrations;
> +
> +		if (cal)
> +			load_calib_data(priv, &cal->dev_data);
> +	}

In the similar way

	cal = cal_fmw->calibrations;
	if (!cal)
		return;

	load_calib_data(priv, &cal->dev_data);

> +}

The result is much easier to read and understand and maintain, as it makes
harder to squeeze the code between initialization and use and breaking things.

..

> +			if (tas_priv->tasdevice[i].is_loaderr == false
> +				&& tas_priv->tasdevice[i].is_loading == true)
>  				tas_priv->tasdevice[i].cur_prog = prm_no;

While at it, make it better (fix the indentation and move operator to
the previous line):

			if (tas_priv->tasdevice[i].is_loaderr == false &&
			    tas_priv->tasdevice[i].is_loading == true)
				tas_priv->tasdevice[i].cur_prog = prm_no;

..

>  			if (tas_priv->tasdevice[i].is_loaderr == true) {
>  				status |= 1 << (i + 4);

Side note: Use BIT()

>  				continue;

..

> +			if (tas_priv->tasdevice[i].is_loaderr == false
> +				&& tas_priv->tasdevice[i].is_loading == true) {

As per above.

> +				tasdev_load_calibrated_data(tas_priv, i);
>  				tas_priv->tasdevice[i].cur_conf = cfg_no;
> +			}

-- 
With Best Regards,
Andy Shevchenko



