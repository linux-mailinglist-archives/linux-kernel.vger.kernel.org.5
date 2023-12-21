Return-Path: <linux-kernel+bounces-8715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCE81BB61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E942D1F2205C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0755E4B;
	Thu, 21 Dec 2023 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksB7Kv4O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431653A0C;
	Thu, 21 Dec 2023 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703174083; x=1734710083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8sUmaLWEzhxtfb969BEgIIWnnBvvR5mB/bVW9ecI7o=;
  b=ksB7Kv4OXf+WEWUDMxcoyDYJZ3D4ONa+cFw4NJi5IIhF3Sn2x4NWSET0
   n7uixeyYyibkA+v7sowHDdyomfWLWWRBSbPgikkbyeFC4UELBMSoP+EHD
   /ycMSVPXyDqpXM4qtSBzyamkp3T66y9g15s1ZqutiobNuEDslQiu3dkxE
   l2F9njrT6d1BQr1PQAAB+Df+1mb4Gt5+7QJk3e6woUBCbsJfy41cJengo
   AKsYk6kYdY36YCxFE+J0ImK5/R3APUIVb/a6Z1Xonej335VUXDjCm0iZK
   0weW8ZkWgZXkUechY0wd4BJBlU4WF+Dwl2+e3KUGsd6pUzn+EuGLOhkNK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393157746"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="393157746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="867349971"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="867349971"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:54:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLNb-00000007t63-1g7A;
	Thu, 21 Dec 2023 17:54:35 +0200
Date: Thu, 21 Dec 2023 17:54:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de,
	peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v2 4/5] ASoC: tas2781: Add tas2563 into driver
Message-ID: <ZYRfu7RjUNpLZCSB@smile.fi.intel.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <20231221101346.429-4-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221101346.429-4-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 06:13:44PM +0800, Shenghao Ding wrote:
> Add tas2563 to better support dsp mode.

DSP

...

> +// The TAS2781/TAS2563 driver implements a flexible and configurable

Ordered?

...

> +// TAS2781/TAS2563 chips.

Ditto.

...

>  static const struct i2c_device_id tasdevice_id[] = {
>  	{ "tas2781", TAS2781 },
> +	{ "tas2563", TAS2563 },

Ditto

>  	{}
>  };

...

>  static const struct of_device_id tasdevice_of_match[] = {
>  	{ .compatible = "ti,tas2781" },
> +	{ .compatible = "ti,tas2563" },

Ditto.

>  	{},
>  };

-- 
With Best Regards,
Andy Shevchenko



