Return-Path: <linux-kernel+bounces-102465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0441287B27C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F87E1F2612F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA6E4CE04;
	Wed, 13 Mar 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IykUHfmR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54950261;
	Wed, 13 Mar 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360253; cv=none; b=EUPSZAShhjZBdBXze+sLfPCilmsVCjW9SHuQJIzJGoOD1Vn37L5rx8A5mwmT66EAFPaI3/icwdVFjJ1cBKkgV9z7xO0yg2x3w/2ug/nl9+83piu/GRGQrq1dfa8Y6/XzpddgyQd8fbHipZCElXvW6090Xr86X8XoqslXNBwXrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360253; c=relaxed/simple;
	bh=1isCJ/HiRQqsOQID7hdC+OE/BFsB1DwZ8Ioqspcdcsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UshDd1En+1z3YNPMECa9Kt2Op7Y+oA9cKWn39xL3Rnw98bZ6g99lAcN5XmFbvDQDHnnbpTJzckRJ40B3PGCVBVzoVrCmNeRTnHCYfjBvAaHbpA87MP1oIxCVHZbPAJfQTuhBlaaHrxOa9wtV5KsWfmUCdTFFTupqo2mF0ZXmyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IykUHfmR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710360252; x=1741896252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1isCJ/HiRQqsOQID7hdC+OE/BFsB1DwZ8Ioqspcdcsk=;
  b=IykUHfmRmQZuQEI0EKY2o/GdzjDbmuzVJRzoifaCUlBrpo5HjgYVxDrA
   39b14ya611PcooA6D/PCVxbFCIrDiwRbq/B/iu1NPH5j4Btm0J8u5O5Xq
   1qZz+WQw/W4Ra6VilQwkqpMNwMXoCHW6D0Oa5QiO4s29r6ndBhPMtdFBp
   kM9D87gHreoalgQsi6RW9k+Pmj1eg1TCw9fsbRnx8Ppn1kWQYoRx6fhvn
   cDUUkBXwP+FYjR0zJ5TFYbh7ZmoOEs+eIJUMRBs0gQEVpPbwUj7CU/bI5
   NW2+OOTuOrlP9u0+Fuqw0tOSkeD8bDPCu91URkoVgeP0t5NK7zhIz4J3o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15880485"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15880485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 13:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914440421"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914440421"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 13:04:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkUpa-0000000CJiw-0kRb;
	Wed, 13 Mar 2024 22:04:06 +0200
Date: Wed, 13 Mar 2024 22:04:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: add SCALE and RAW values for
 channels
Message-ID: <ZfIGtUPZpyDBnWwz@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-4-vassilisamir@gmail.com>
 <ZfH4bET-HX0e3PO_@smile.fi.intel.com>
 <20240313195110.GB1938985@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313195110.GB1938985@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 08:51:10PM +0100, Vasileios Amoiridis wrote:
> On Wed, Mar 13, 2024 at 09:03:08PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 13, 2024 at 06:40:04PM +0100, Vasileios Amoiridis wrote:
> > > Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW in order to be
> > > able to calculate the processed value with standard userspace IIO
> > > tools. Can be used for triggered buffers as well.

..

> > > +	case IIO_CHAN_INFO_RAW:
> > > +		switch (chan->type) {
> > > +		case IIO_HUMIDITYRELATIVE:
> > > +			*val = data->chip_info->read_humid(data);
> > > +			ret = IIO_VAL_INT;
> > > +			break;
> > > +		case IIO_PRESSURE:
> > > +			*val = data->chip_info->read_press(data);
> > > +			ret = IIO_VAL_INT;
> > > +			break;
> > > +		case IIO_TEMP:
> > > +			*val = data->chip_info->read_temp(data);
> > > +			ret = IIO_VAL_INT;
> > > +			break;
> > > +		default:
> > > +			ret = -EINVAL;
> > > +			break;
> > 
> > Is it mutex that prevents us from returning here?
> > If so, perhaps switching to use cleanup.h first?
> 
> I haven't seen cleanup.h used in any file and now that I searched,
> only 5-6 are including it.

Hmm... Which repository you are checking with?

$ git grep -lw cleanup.h -- drivers/ | wc -l
47

(Today's Linux Next)

> I am currently thinking if the mutex
> that already exists is really needed since most of the drivers
> don't have it + I feel like this is something that should be done
> by IIO, thus maybe it's not even needed here.

> > > +		}
> > > +		break;

-- 
With Best Regards,
Andy Shevchenko



