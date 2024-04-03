Return-Path: <linux-kernel+bounces-129407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7730896A51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6EDB2C458
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625B70CAD;
	Wed,  3 Apr 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGAjwkYH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4486EB60;
	Wed,  3 Apr 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135726; cv=none; b=l8hOL1ywRTmM9q17jeE6HRLh8JenkZtecdCTJKJIBMHTgD1cYi42WgmNeGBPidbNvRZy5qqBdFORNSDSJq4q3dy/YoSp21JC8uaMCsg3++WeDDOLq5h7kHRRc3p0YvvzZCrJbarR/jamn6nAwAIkbDOEp6Oh2Ymj4KnmYECjqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135726; c=relaxed/simple;
	bh=ZM/3Byxpxed4P8WSswonfevzf2brOiTU9TshRQSMaj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjBen5D7rE5O6A1syZqpYOu33T8hMrMNjI+UU5B7Flhcr7TnHZaWAlVu5QMFDWNHedAjzCxXg4VF/6ECmsJXhirjsljjPaVcQsMJUbkFrqMYgdvx9QBznJpi1HShzbc3CHcAHTTYUUxQw9HRUHOv/6O7eRNUoNeHPskvOvs/Ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGAjwkYH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712135725; x=1743671725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZM/3Byxpxed4P8WSswonfevzf2brOiTU9TshRQSMaj0=;
  b=dGAjwkYH5I0ZQvQufBH62Bhm+DYc5fVK0ul+WcdtHWsPLLg8pvceO2dT
   0f0BJLwfgETlaV24hLp48fLFBPl645fQ1r9TzUJZKMfeKRKPhaMdN8XjQ
   GqFntr4CFo2fG80BKWl6MYQqW9mOLQAS8vGnbc2SmN5K70dWphnAAIlYt
   jHt4XKOW9xpVMgReY6SWkdUpbmkQ5VP5DVZRfRBVeWeeQwmFBbQtGTwi0
   5kMrsAnk8FsAg8za7OGyJXMQn/gLL+3Q+BmQ47GZpmhSvh+pykOrVAURi
   cZkIBr/jhdl+M/vf+T7A/R/2b6W8yC9qW7ltVPi0p0gxhYcroqtkbAW/U
   g==;
X-CSE-ConnectionGUID: rWKwYGhjTtWEeIfcwE9vaA==
X-CSE-MsgGUID: RIsAhhNwT3KNaQTfJ7NIPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7217305"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7217305"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915175371"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915175371"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:15:17 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrwiA-000000014UU-0axT;
	Wed, 03 Apr 2024 12:15:14 +0300
Date: Wed, 3 Apr 2024 12:15:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yinchuan Guo <guoych37@mail2.sysu.edu.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 32/34] ASoC: remove incorrect of_match_ptr/ACPI_PTR
 annotations
Message-ID: <Zg0eIZDS3F_PQLyB@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-33-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-33-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:50AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with CONFIG_OF and/or CONFIG_ACPI disabled but W=1 extra
> warnings enabled, a lot of driver cause a warning about an unused
> ID table:
> 
> sound/soc/atmel/sam9x5_wm8731.c:187:34: error: unused variable 'sam9x5_wm8731_of_match' [-Werror,-Wunused-const-variable]
> sound/soc/codecs/rt5514-spi.c:496:34: error: unused variable 'rt5514_of_match' [-Werror,-Wunused-const-variable]
> sound/soc/samsung/aries_wm8994.c:524:34: error: unused variable 'samsung_wm8994_of_match' [-Werror,-Wunused-const-variable]
> 
> The fix is always to just remove the of_match_ptr() and ACPI_PTR() wrappers
> that remove the reference, rather than adding another #ifdef just for build
> testing for a configuration that doesn't matter in practice.

..

> index d6cdb6d9fdd6..ffc105759994 100644
> --- a/sound/soc/amd/acp3x-rt5682-max9836.c
> +++ b/sound/soc/amd/acp3x-rt5682-max9836.c
> @@ -543,7 +543,7 @@ MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
>  static struct platform_driver acp3x_audio = {
>  	.driver = {
>  		.name = "acp3x-alc5682-max98357",
> -		.acpi_match_table = ACPI_PTR(acp3x_audio_acpi_match),
> +		.acpi_match_table = acp3x_audio_acpi_match,
>  		.pm = &snd_soc_pm_ops,
>  	},
>  	.probe = acp3x_probe,

Replace acpi_match_device() by device_get_match_data() and acpi.h by
mod_devicetable.h + property.h.

I really would like to see agnostic drivers (when they don't need of*.h/acpi.h
to be included as "proxy" headers).

With this, the change probably needs to be separated from this patch.

If you address as suggested,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

..

The rest I haven't checked, it might be possible to do something similar there
as well.

-- 
With Best Regards,
Andy Shevchenko



