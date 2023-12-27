Return-Path: <linux-kernel+bounces-12150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA881F09A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EABB217AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806DE45027;
	Wed, 27 Dec 2023 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILT0Vugd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF945026;
	Wed, 27 Dec 2023 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703695914; x=1735231914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FN+0gAIWs30kH3qVNH2Jeq1+0ZvjeMAd9cEPUVtsfM=;
  b=ILT0VugdjGKaTLALinKgug5wZdpiSp4so/PBCX4kDsR4l9DBezkEq7FX
   0qqOsKhlco4GLBCVgJdfOSYaUDJdKhw9glxOk+fZ+wxmaIGcaLUoE1Kjp
   P6X+rSH4rUPImqqRN6tJEXBvKp4YdtM7a0OodNZKzoqkGsHqrUdbdJ44a
   9EONgfiL20JsUjnzavoiZhc7yyMeGX/c05WQfKGWc9grX3znLTl/Hykyt
   XCPpQLvv2OLFAEmroiP6k7hQvsgRqgBGxdEqUme8k1dOg5nIUV/REBbCh
   qRzU9Cj5wB0SSNTb/nHE7RliGo66jd7Tp3tGie4av+r/D/pyVsrhFTtf3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="381435525"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="381435525"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868899368"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="868899368"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:51:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIX8E-00000009T2x-0TQX;
	Wed, 27 Dec 2023 18:51:46 +0200
Date: Wed, 27 Dec 2023 18:51:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de,
	peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v3 4/5] ASoC: tas2781: Add tas2563 into driver
Message-ID: <ZYxWIcnfNWyTJ9Tz@smile.fi.intel.com>
References: <20231225053932.1138-1-shenghao-ding@ti.com>
 <20231225053932.1138-4-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225053932.1138-4-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 25, 2023 at 01:39:30PM +0800, Shenghao Ding wrote:
> Move tas2563 from tas2562 driver to tas2781 driver, because tas2563 only
> work in bypass-DSP mode with tas2562 driver. In oder to enable DSP mode
> for tas2563, it has been moved to tas2781 driver. As to the hardware part,
> such as register setting and DSP firmware, all these are stored in the
> binary firmware. What tas2781 drivder dooes is to parse the firmware and
> download them to the tas2781 or tas2563, then power on tas2781 or tas2563.
> So, tas2781 driver can be resued as tas2563 driver. Only attention will be
> paid to downloading corresponding firmware.

> -// The TAS2781 driver implements a flexible and configurable
> +// The TAS2781/TAS2563 driver implements a flexible and configurable

> -// TAS2781 chips.
> +// TAS2781/TAS2563 chips.

>  static const struct i2c_device_id tasdevice_id[] = {
>  	{ "tas2781", TAS2781 },
> +	{ "tas2563", TAS2563 },
>  	{}
>  };

>  static const struct of_device_id tasdevice_of_match[] = {
>  	{ .compatible = "ti,tas2781" },
> +	{ .compatible = "ti,tas2563" },
>  	{},
>  };

In all cases make the lists ordered by a chip model.

-- 
With Best Regards,
Andy Shevchenko



