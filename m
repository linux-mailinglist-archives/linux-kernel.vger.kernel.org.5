Return-Path: <linux-kernel+bounces-155495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74F8AEB56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457EEB231AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB1C13C9BE;
	Tue, 23 Apr 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyHdhBkw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3FC13BAFE;
	Tue, 23 Apr 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886981; cv=none; b=gjccHjSwIya5O8T3zOkiB1KxMGxZDkEFzdRx5iO5Jz8GN8vjUES0fLSL3dah2C8fN/NlJIZSzuYGZsNNmEPlC5qA3VmdqbPM0peq2SYeZF214CbBf0nmMKDv0X6pOsQJWk2AvJShSstdzxbG2VADmKzmG9Y5VKz0tfnI93wbzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886981; c=relaxed/simple;
	bh=878iBN1wCLHEB2yRzqkpbitV3mFieot5Pqm94fhfGog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLjlMwQ2BEc9c6ythNnp1Ld+nja1U75KUYYP+zkzJqACQQuBOA97eatszuOz+n/PSuiwR0F0VVROoYTIWnzc7QFdn5oA6wls25LAwkh8IupZBgTDRFlwhaV5yMJ5XvV2aFZkXaEErTOqV4JhWWqH4tf3pyryB67Oa49fY1E9yFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyHdhBkw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713886981; x=1745422981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=878iBN1wCLHEB2yRzqkpbitV3mFieot5Pqm94fhfGog=;
  b=JyHdhBkwB9qjMTKdE9nbt4efQkzKxkJGpexu1QdsXxQHPT8s7TPO0ncg
   g3gmlZ9tRCpAYcE9GeGF8gU5v0Lzr2Hk4D7Iizc9/W6Uk3OmWqYB5HQ+y
   x1+fw34zgG+z8vbChls8CS/WYMjaAM+z0q5aLCwt/fitnSIxl0yrb86Wa
   Gs3pEHJlmUvheGW0+PUFZ2TdUd52l+o6vnfghjLhtFTpxNRBPoAkVQ1Cl
   njWAAC0VoJi4Grc4IgiPRD4Xn/wl0223ZNDQ1Ou9xeYzGJ5RIDunl03qS
   5yDLOehGrzLbzBQ+2Gr5JVERdN3IgKHbPYIHQwfSu6fvDjQ+zfBBlUpb0
   w==;
X-CSE-ConnectionGUID: LnmQdojvSkmqrF2MQBCnig==
X-CSE-MsgGUID: AEnjRQacTrWlPxL3y8Bx+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9329281"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9329281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:43:00 -0700
X-CSE-ConnectionGUID: SVLaXHivTkqKF0jkP1Q+dA==
X-CSE-MsgGUID: R6Ph6u9PTiWUBmYBFUr1vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24274769"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:42:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzIIH-00000000Naj-1sJH;
	Tue, 23 Apr 2024 18:42:53 +0300
Date: Tue, 23 Apr 2024 18:42:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: nuno.sa@analog.com
Cc: Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jyoti Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <ZifW_fUVcdIpfOWO@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
 <20240423-dev-add_dev_errp_probe-v2-2-12f43c5d8b0d@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-dev-add_dev_errp_probe-v2-2-12f43c5d8b0d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 05:20:31PM +0200, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use dev_err_probe() in the probe() path. While at it, made some simple
> improvements:
>  * Declare a struct device *dev helper. This also makes the style more
>    consistent (some places the helper was used and not in other places);
>  * Explicitly included the err.h and errno.h headers;
>  * Removed an useless else if();
>  * Removed some unnecessary line breaks.

..

>  	/* Check space on the table. */
>  	if (st->custom_table_size + new_custom->size >
> -	    (LTC2983_CUST_SENS_TBL_END_REG -
> -	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {

> +	    (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS_TBL_START_REG) + 1)

Semi-unrelated change?

..

> +		return dev_err_ptr_probe(dev, -EINVAL,
> +				      "Invalid chann:%d for differential thermocouple",

While at it, add missing \n.

> +				      sensor->chan);

..

> +		return dev_err_cast_probe(dev, ref,
> +					  "Property adi,rsense-handle missing or invalid");

Ditto.

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid number of wires:%u\n",
> +					      n_wires);

Can be compressed in terms of LoCs?

..

> +				return dev_err_ptr_probe(dev, -EINVAL,
> +						      "Rotation not allowed for 2/3 Wire RTDs");

\n

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid rsense chann:%d to use in kelvin rsense",
> +					      rtd->r_sense_chan);

Ditto.

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid chann:%d for the rtd config",

Ditto.

> +					      sensor->chan);

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid chann:%d for RTD",

Ditto.

> +					      sensor->chan);

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid value for excitation current(%u)",

Ditto.

> +					      excitation_current);

..

> +	if (IS_ERR(ref))
> +		return dev_err_cast_probe(dev, ref,
> +					  "Property adi,rsense-handle missing or invalid");

Ditto.

..

> +		return dev_err_ptr_probe(dev, -EINVAL,
> +				      "Invalid chann:%d for differential thermistor",
> +				      sensor->chan);


Ditto.

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid value for excitation current(%u)",
> +					      excitation_current);

Ditto.

..

> +		return dev_err_ptr_probe(dev, -EINVAL,
> +				      "Invalid chann:%d for differential thermistor",
> +				      sensor->chan);

Ditto.

..

> +			return dev_err_ptr_probe(dev, -EINVAL,
> +					      "Invalid value for excitation current(%u)",
> +					      excitation_current);

Ditto.

..

> +		return dev_err_ptr_probe(dev, -EINVAL,
> +				      "Invalid chann:%d for r_sense",
> +				      sensor->chan);

Ditto.

..

> +	if (!st->num_channels)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "At least one channel must be given!");

Ditto.

..

> +		return dev_err_probe(dev, -EINVAL,
> +				     "EEPROM command failed: 0x%02X\n", val);

One line?

..

> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");

Wondering about Andi's proposal in conjunction with %pe to be in use

		return dev_???(dev, st->regmap, "Failed to initialize regmap\n");

where it returns an int and uses const void * as an error pointer for %pe.



> -	st->iio_chan = devm_kzalloc(&spi->dev,
> +	st->iio_chan = devm_kzalloc(dev,
>  				    st->iio_channels * sizeof(*st->iio_chan),
>  				    GFP_KERNEL);

Separate change to devm_kzalloc() before this patch?
In that patch you may also introduce a temporary struct device *dev.


-- 
With Best Regards,
Andy Shevchenko



