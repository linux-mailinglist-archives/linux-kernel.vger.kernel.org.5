Return-Path: <linux-kernel+bounces-155500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097258AF292
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E1D1C22CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD113C9C7;
	Tue, 23 Apr 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXUvLLBF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF213C687;
	Tue, 23 Apr 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887466; cv=none; b=pgwpHgTz9/0DavcSukvmO/BDEg+6ahgVMFiMe2yZWMyApNoUFrPkSpFwW1zJyv/JAQb7N4dHE+90et+czJDj6mKILq0nCXtxa7f9Va5vVQhvNPjKlHf340dnyNfqHu1oQVHu8/LH0SUPivGxZrDlowM3j4lPEB129IKrEC0tkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887466; c=relaxed/simple;
	bh=z7DVv/KkP0dGz/VhOP+VvIGaEuWWXNTb5smFe7rSOdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFZTmyDYZ+grEfuvYHAPzQ0W1TpTlMfX+FVarExtCgvDmvclyCR4NGRnuMYZp7swWLziqL9+9INPsl+wzqE4ypaENJtCCv0VT0spSK331C2zKz0Q4HpOFJhFEeaWnnsXOIfUoODjLNlXya6MorNxUDF7fYG4hVuoC0Y0FuEf56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXUvLLBF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713887465; x=1745423465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z7DVv/KkP0dGz/VhOP+VvIGaEuWWXNTb5smFe7rSOdw=;
  b=lXUvLLBFfqs5MNKNuMmwqF/mzIbCkmGGRWngmrCOdlZW3cBRg1bwHu5s
   DcgyQ/GjSdvVZafvK+Ws4t91pHLkahheSDoQA29qh8NOPqiSzSDC0qaMr
   DpMkn7LxoNtF4W4gSrJOLn9KUrVc1TDwRJX0JWED6gOwfLipFrktl0G8s
   VdyQ040SO03vEQUXd6imQGJHkOOzO8QdH/iQxwayP2wX9ct8Tp0WM6bZA
   f8xUgmypsSvZmXQJDYxZaAvyYM1WZ7qFy6dO4Vdie/jcOAAnq544/aaG0
   s5/vKtLSoqL+FYFru6o/b53QtHY1IWJ5/zh0lZzfyxcYe7n6HTKjAf9ms
   g==;
X-CSE-ConnectionGUID: upnJW5JnThmR94M+yRSHLA==
X-CSE-MsgGUID: u1GoaUqSTnW6wszU+FUtpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26996764"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26996764"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:50:33 -0700
X-CSE-ConnectionGUID: dvEBwkTqQ7qEUsgrdlBkGg==
X-CSE-MsgGUID: 1ClGcYjvQLCS3keGPg/Cjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24447401"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:50:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzIPb-00000000Nig-1SkB;
	Tue, 23 Apr 2024 18:50:27 +0300
Date: Tue, 23 Apr 2024 18:50:27 +0300
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
Subject: Re: [PATCH v2 4/4] iio: common: scmi_iio: convert to dev_err_probe()
Message-ID: <ZifYwxjNxfM1LwW7@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
 <20240423-dev-add_dev_errp_probe-v2-4-12f43c5d8b0d@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-dev-add_dev_errp_probe-v2-4-12f43c5d8b0d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 05:20:33PM +0200, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> Make use of dev_err_probe() and dev_err_ptr_probe() to simplify error paths
> during probe.

..

> +		return dev_err_ptr_probe(&iiodev->dev, ret,
> +					 "Error in registering sensor update notifier for sensor %s err %d",

\n

> +					 sensor->sensor_info->name, ret);

..

> +			return dev_err_probe(dev, -EINVAL,
> +					     "SCMI sensor %d has missing info\n", i);

One line? (It's 99 if you use relaxed limit).

..

> +			return dev_err_probe(dev, PTR_ERR(scmi_iio_dev),
> +					     "failed to allocate IIO device for sensor %s: %ld\n",
> +					     sensor_info->name, PTR_ERR(scmi_iio_dev));

Please, be sure you remove double error code printing, dev_err_probe() does it
for you already. (This applies to all places like this, if any, in the entire
series.)

..

> +			return dev_err_probe(dev, err,
> +					     "IIO buffer setup error at sensor %s: %d\n",
> +					     sensor_info->name, err);

Ditto.

..

> +			return dev_err_probe(dev, err,
> +					     "IIO device registration failed at sensor %s: %d\n",
> +					     sensor_info->name, err);

Ditto.

-- 
With Best Regards,
Andy Shevchenko



