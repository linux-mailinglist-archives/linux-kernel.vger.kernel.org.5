Return-Path: <linux-kernel+bounces-131401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FB898726
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C9B1C23331
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE512C7E3;
	Thu,  4 Apr 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zbcj+kHA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432212BEAB;
	Thu,  4 Apr 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233095; cv=none; b=gJZMubKdTTkvxfaFMTkT3HVdAttNinUOn+ZfIEFhLa1/bTKdz0oDnR7XfV4ktSfny1T5lhozyMDESd0AaQ0n8z8RpbGaCPHUptunLLPUe5TrYmKWg8klRsTHHG/WrvbjeN98HzoYkbqNKFEs0Z2dv3fY53iHKGmwNkWW2eOBg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233095; c=relaxed/simple;
	bh=h6hsG7O4NXXbX7qfTzI/keMC+nHMgVPFXHNpgflytEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEvLr33fJf0bGbQjzy623zJ3fq297t8nVFS2GkSb6Rx5WmE5FoNw+6qtHWB+9u8r1J6fkW+QcwZiZKM62zK7hPjXzUEDBHu246H4rcPPFR76er/H/yL2kkq5iOrbdOv6MonYOmm1SudqvdwM/Oajy6xQqSVvna32hIg8fetkseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zbcj+kHA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712233092; x=1743769092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h6hsG7O4NXXbX7qfTzI/keMC+nHMgVPFXHNpgflytEE=;
  b=Zbcj+kHAjLDkChqfp1G5cRtr9csPV+pndUh/h9BJ2moFNWb77RW8yFOo
   dfrCFcvOwwlj1D2RX4yn342G2OLY7JePpsn6bPrwMWUw1avMtKpI5tA1n
   2DKkLsFw3y6Olaj6oZMqBQh+IKCAa4EfO2A7kGNbSJ81NNb3x8SHcnjo6
   kb54cEPAZ8TiivrmfQld8A8+2Nycj8/72Ee4Oavyg7xErvC//yslYK3Sx
   BoctVP39iBv6XryO9dg7CpAWOBKUm7pQERpe8aVlIoUJ/KJrK68ILaFZP
   87lo35jPS7ANA9h5dpBVx1yMcU94/SlTfk+zUWvNJC5FHGQ78XlJHa2y3
   g==;
X-CSE-ConnectionGUID: UJr/S6X3SgeyFgcRxgF2dw==
X-CSE-MsgGUID: L0//gbp6SIapV7kjG0B7Pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18663198"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18663198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915216538"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915216538"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:18:08 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsM2f-00000001QGk-23S6;
	Thu, 04 Apr 2024 15:18:05 +0300
Date: Thu, 4 Apr 2024 15:18:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: temperature: ltc2983: convert to dev_err_probe()
Message-ID: <Zg6afQe43zlYFC8m@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <20240404-dev-add_dev_errp_probe-v1-2-d18e3eb7ec3f@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-dev-add_dev_errp_probe-v1-2-d18e3eb7ec3f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 01:06:24PM +0200, Nuno Sa wrote:
> Use dev_err_probe() in the probe() path. While at it, made some simple
> improvements:
>  * Declare a struct device *dev helper. This also makes the style more
>    consistent (some places the helper was used and not in other places);
>  * Explicitly included the err.h and errno.h headers;
>  * Removed an useless else if();
>  * Removed some unnecessary line breaks.

..

>  	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
> -	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {

It's better if you leave {} when the body goes after a single line.
This applies to your entire series.

> -		dev_err(&st->spi->dev,
> -			"Invalid chann:%d for differential thermocouple",
> -			sensor->chan);
> -		return ERR_PTR(-EINVAL);
> -	}
> +	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
> +		return dev_errp_probe(dev, -EINVAL,
> +				      "Invalid chann:%d for differential thermocouple",
> +				      sensor->chan);

-- 
With Best Regards,
Andy Shevchenko



