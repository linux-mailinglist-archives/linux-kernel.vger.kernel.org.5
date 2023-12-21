Return-Path: <linux-kernel+bounces-8713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198D81BB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806931C25EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2355E47;
	Thu, 21 Dec 2023 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vrg8DmDP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A353A0B;
	Thu, 21 Dec 2023 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703174029; x=1734710029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVtewtkz6EOj6TSXtWGXaouXRMVl9+AZbrv/E4+5Cbc=;
  b=Vrg8DmDPGtMmAFcs7LALj08y1PsIahnduRjnNDrW+HpZU0tnjpo4vUEP
   1ShjnMHgDoR52HU/VYLLtYOHtvE4+DAhDT6Xmjq0OKv21R/Bg0/Pu1lsm
   DNk6T33U1bULjPQF1wpTVg0F45qhV8G7tPiu3r2V2aS4NAyekNobO7UzQ
   9D477N0fYs2cETgmL3jHX0jf6a07RojUTd7iEXjifxxAt2aqLlI6FVFwA
   eQIMyXTMs7YUS4/hX7pU9seYR48ugb/+dnt+XpRzRp5CrCQs7amZs0TxU
   0qD9DQveK+QOTak+C1E5yrClF7fQhtM93CiJLaEkfXJGK0yOTke1Kzp3/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393157619"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="393157619"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="949960682"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="949960682"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:53:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLMe-00000007t5J-1mQ8;
	Thu, 21 Dec 2023 17:53:36 +0200
Date: Thu, 21 Dec 2023 17:53:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de,
	peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v2 3/5] ASoC: tas2781: Add tas2563 into header file for
 dsp mode
Message-ID: <ZYRfgCL393O7FEYJ@smile.fi.intel.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <20231221101346.429-3-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221101346.429-3-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 06:13:43PM +0800, Shenghao Ding wrote:
> Support dsp mode for tas2563.

DSP

...

> +// ALSA SoC Texas Instruments TAS2781/TAS2563 Audio Smart Amplifier

Why not ordered?

...

> +// The TAS2781/TAS2563 driver implements a flexible and configurable

Ditto.

...

> +// TAS2781/TAS2563 chips.

Ditto.

...

>  enum audio_device {
>  	TAS2781	= 0,
> +	TAS2563

Missing comma as this is not a terminator.

>  };

Ditto.

...

I would expect here

enum audio_device {
	TAS2563,
	TAS2781,
};

-- 
With Best Regards,
Andy Shevchenko



