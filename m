Return-Path: <linux-kernel+bounces-112701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DA887D23
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA631F213D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B518041;
	Sun, 24 Mar 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iocRzubY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DE17BCA;
	Sun, 24 Mar 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288971; cv=none; b=LpWqt5UWEM61Na/WMCtUIgXqJq2np2iH0j1sbZ+6zi3NYIoLMvFCzFILYoHzf32naoMjjNHCFXUJq5fQ0EWw/f88XZ17EQyfjI0rryc+tCt2udlNFGK0Lh1oZdYRkfpBWHr1wZ/9ePh7AXoG3hRLk3BM7+g3JY8sXb+/lmBaWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288971; c=relaxed/simple;
	bh=UfZd2p5tNkBkFrZRa5tr3fGEBwV6K/YpHB/x3kzX/JU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhx1NuM1RnV3Y+hQon8tMhpr3jQXTbnQxwK3KI9I0MsSVH01Kymso3Ub2cpYUMdTa7WmjwejXap825nTsPEYHl24ZnVV/lJvlqXmwHhsUm+uK8zRXK13+tO9svQ64EFb6fN5RVd6gpAPgPacgGw104i7Ff8Cvjf2Uo0RHot7nTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iocRzubY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8804BC433F1;
	Sun, 24 Mar 2024 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711288970;
	bh=UfZd2p5tNkBkFrZRa5tr3fGEBwV6K/YpHB/x3kzX/JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iocRzubYwZ1OKfJwCTRaiPcqD0ndkLQteZlweRalKFBdE4gF/jQ8ZmrHdRaaEzJo5
	 XKx2HU6830nWboScE/PnKfwoIeyVytaOnoyc6aO6qOI5gBog/r7nkMnNMAx6TE38ow
	 BBWrRDNjz3VY5UDKohpimzkH+6P57Wh7Xxd7XDAJpxdrYoEOnUlzwLDw53HMOVopaa
	 ZjZLnmHx21JVQdXmrw8JM5mR8Sy18ayzxivy+RiA/E8b5mtHjbTVfR5X0I/9/rFvSx
	 /pA7+MZEiQ4a+h2FLOaOMY/kYZU6vYMIh5r4EgZ5ZAsb5CSaL7Nyt/78ub3BE0QLrL
	 gBjTiExMm0v0A==
Date: Sun, 24 Mar 2024 14:02:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: haibo.chen@nxp.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] iio: adc: imx93: Make calibration properties
 configurable
Message-ID: <20240324140233.577ec7d3@jic23-huawei>
In-Reply-To: <20240320100407.1639082-2-andrej.picej@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
	<20240320100407.1639082-2-andrej.picej@norik.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 11:04:05 +0100
Andrej Picej <andrej.picej@norik.com> wrote:

> Make calibration properties:
>  - AVGEN: allow averaging of calibration time,

Confused. How do you average time?   Or is this enabling averaging of
ADC readings at calibration time?

>  - NRSMPL: select the number of averaging samples during calibration and

Assuming I read AVGEN right, just have a value of 1 in here mean AVGEN is
disabled.

>  - TSAMP: specifies the sample time of calibration conversions

Not sure what this means.  Is it acquisition time? Is it time after a mux
changes?  Anyhow, more info needed.
This is the only one I can see being possibly board related.  But if it
is and is needed for calibration, why not for normal read out?

> 
> configurable with device tree properties:
>  - nxp,calib-avg-en,
>  - nxp,calib-nr-samples and
>  - nxp,calib-t-samples.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  drivers/iio/adc/imx93_adc.c | 66 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index 4ccf4819f1f1..ad24105761ab 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/property.h>
>  
>  #define IMX93_ADC_DRIVER_NAME	"imx93-adc"
>  
> @@ -43,6 +44,9 @@
>  #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
>  #define IMX93_ADC_MCR_NSTART_MASK		BIT(24)
>  #define IMX93_ADC_MCR_CALSTART_MASK		BIT(14)
> +#define IMX93_ADC_MCR_AVGEN_MASK		BIT(13)
> +#define IMX93_ADC_MCR_NRSMPL_MASK		GENMASK(12, 11)
> +#define IMX93_ADC_MCR_TSAMP_MASK		GENMASK(10, 9)
>  #define IMX93_ADC_MCR_ADCLKSE_MASK		BIT(8)
>  #define IMX93_ADC_MCR_PWDN_MASK			BIT(0)
>  #define IMX93_ADC_MSR_CALFAIL_MASK		BIT(30)
> @@ -145,7 +149,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
>  
>  static int imx93_adc_calibration(struct imx93_adc *adc)
>  {
> -	u32 mcr, msr;
> +	u32 mcr, msr, value;
>  	int ret;
>  
>  	/* make sure ADC in power down mode */
> @@ -156,12 +160,64 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
>  	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
>  	writel(mcr, adc->regs + IMX93_ADC_MCR);
>  
> -	imx93_adc_power_up(adc);
> -
>  	/*
> -	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> -	 * can add the setting of these bit if need in future.
> +	 * Set calibration settings:
> +	 * - AVGEN: allow averaging of calibration time,
> +	 * - NRSMPL: select the number of averaging samples during calibration,
> +	 * - TSAMP: specifies the sample time of calibration conversions.
>  	 */
> +	if (!device_property_read_u32(adc->dev, "nxp,calib-avg-en", &value)) {
> +		mcr &= ~IMX93_ADC_MCR_AVGEN_MASK;
> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_AVGEN_MASK, value);
> +	}
> +
> +	if (!device_property_read_u32(adc->dev, "nxp,calib-nr-samples", &value)) {
Handle error for not present different from a failure to read or similar.
Not present isn't an error, just a fall back to defaults.
For other error codes we should fail the probe.
> +		switch (value) {
> +		case 16:
> +			value = 0x0;
Don't do this in place, meaning of value before this point different to what
you have in it going forwards. Use a different variable name to make that clear.
reg_val vs nr_samples perhaps?
> +			break;
> +		case 32:
> +			value = 0x1;
> +			break;
> +		case 128:
> +			value = 0x2;
> +			break;
> +		case 512:
> +			value = 0x3;
> +			break;
> +		default:
> +			dev_warn(adc->dev, "NRSMPL: wrong value, using default: 512\n");

Fail the probe rather than papering over a wrong value. I'd rather we got the DT fixed
quickly and if someone wanted another value, they really did want it.

We probably do want a default though for the property not being present (given it is new).
so take setting of this variable outside the if(!device_property_read_u32);
> +			value = 0x3;
> +		}
> +		mcr &= ~IMX93_ADC_MCR_NRSMPL_MASK;
> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_NRSMPL_MASK, value);
> +	}
> +
> +	if (!device_property_read_u32(adc->dev, "nxp,calib-t-samples", &value)) {
> +		switch (value) {
> +		case 8:
> +			value = 0x1;
> +			break;
> +		case 16:
> +			value = 0x2;
> +			break;
> +		case 22:
> +			value = 0x0;
> +			break;
> +		case 32:
> +			value = 0x3;
> +			break;
> +		default:
> +			dev_warn(adc->dev, "TSAMP: wrong value, using default: 22\n");
> +			value = 0x0;
> +		}
> +		mcr &= ~IMX93_ADC_MCR_TSAMP_MASK;
> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_TSAMP_MASK, value);
> +	}
> +
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	imx93_adc_power_up(adc);
>  
>  	/* run calibration */
>  	mcr = readl(adc->regs + IMX93_ADC_MCR);


