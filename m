Return-Path: <linux-kernel+bounces-98251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD76877771
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365391C208EE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3692D381B9;
	Sun, 10 Mar 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAv52yyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA0374C3;
	Sun, 10 Mar 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710083828; cv=none; b=s97bcaD1iSkVH2TuWa2jNjMTmDPQTB4fQFd5v0CQ52rrkLDmChBJp/h0n8T+yFn71zmJDCKV6iwuomkiWJwgweQ/ShSac3g50u6WVn4PzWHwYs3MqEkoGXdTJS5PPHQf9uxl8Ct6kZCR9JDCe6LfKiX7umjAkM9GX/Lae1+sNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710083828; c=relaxed/simple;
	bh=rIUrM1eqzy59I4K5wq1eEGWnue1gxNqb95RwtlVisTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0pbG9OaeVnVmPy1ZcuRZsL5p34A3LOekkPI6jNIAjeOQdPXqORCg2vhgsk2PORp0xEnKwpjduMQYJmgj6cLgaLsWmbH4Pib6/zpAQEJIfwMo8+YvGkcH0eh2k5FOk0heSw0Q94vyNC4QXOsbSDNQkt2rjP+sILf1v1ASbUK9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAv52yyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5738C433C7;
	Sun, 10 Mar 2024 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710083828;
	bh=rIUrM1eqzy59I4K5wq1eEGWnue1gxNqb95RwtlVisTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hAv52yyIPsDx6Tpr1n0tlteWz1lKsJ3y9Fbz1aT+TgV2RKOwoejhpgb9IcnaGd092
	 csRYF3YN+ui+HPyByVgaAdwcvKJWMr+xD+yRGTY5Xj/qgSHYtau8Kn2zGKifT7B0j8
	 jiGdM3o4m2YQ7HwnSHkkXD/cJSIx75mqsF5AzaORMknVgrPHRfsCt7WlKqI5q/h0sB
	 IarZKiRUJYO7P5XW6Bvu7M00j8MI40/tUiX+soJXeiW0qeVubzMiLTBcf5qAxLALu7
	 ZQvM7wpcB6hlOtKopbaKWaHrTx6g9FfleRrUC+yrLuHtuUcmn1HyuScsMJeya+fl6o
	 riDfc8Uf1zN5A==
Date: Sun, 10 Mar 2024 15:16:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/1] iio: adc: twl4030-madc: Make use of device
 properties
Message-ID: <20240310151654.754c5da0@jic23-huawei>
In-Reply-To: <20240304144037.1036390-1-andriy.shevchenko@linux.intel.com>
References: <20240304144037.1036390-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:40:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks Andy,

Applied this to the togreg-cleanup branch of iio.git.

I wondered whether there were any users of the platform_data /
board file path left. Seems that the support for the parent mfd
platform data was ripped out by Uwe in 2022 but not the sub drivers.

Anyone want to do the work to drop it from here and the other sub drivers?

Jonathan

> ---
> v2: converted leftover (Jonathan)
>  drivers/iio/adc/twl4030-madc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 4a247ca25a44..0253064fadec 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -19,10 +19,12 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/mfd/twl.h>
> -#include <linux/module.h>
>  #include <linux/stddef.h>
>  #include <linux/mutex.h>
>  #include <linux/bitops.h>
> @@ -30,7 +32,6 @@
>  #include <linux/types.h>
>  #include <linux/gfp.h>
>  #include <linux/err.h>
> -#include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
> @@ -744,14 +745,14 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
>   */
>  static int twl4030_madc_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
> +	struct twl4030_madc_platform_data *pdata = dev_get_platdata(dev);
>  	struct twl4030_madc_data *madc;
> -	struct twl4030_madc_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	struct device_node *np = pdev->dev.of_node;
>  	int irq, ret;
>  	u8 regval;
>  	struct iio_dev *iio_dev = NULL;
>  
> -	if (!pdata && !np) {
> +	if (!pdata && !dev_fwnode(dev)) {
>  		dev_err(&pdev->dev, "neither platform data nor Device Tree node available\n");
>  		return -EINVAL;
>  	}
> @@ -779,7 +780,7 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>  	if (pdata)
>  		madc->use_second_irq = (pdata->irq_line != 1);
>  	else
> -		madc->use_second_irq = of_property_read_bool(np,
> +		madc->use_second_irq = device_property_read_bool(dev,
>  				       "ti,system-uses-second-madc-irq");
>  
>  	madc->imr = madc->use_second_irq ? TWL4030_MADC_IMR2 :
> @@ -905,20 +906,18 @@ static void twl4030_madc_remove(struct platform_device *pdev)
>  	regulator_disable(madc->usb3v1);
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id twl_madc_of_match[] = {
>  	{ .compatible = "ti,twl4030-madc", },
> -	{ },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, twl_madc_of_match);
> -#endif
>  
>  static struct platform_driver twl4030_madc_driver = {
>  	.probe = twl4030_madc_probe,
>  	.remove_new = twl4030_madc_remove,
>  	.driver = {
>  		   .name = "twl4030_madc",
> -		   .of_match_table = of_match_ptr(twl_madc_of_match),
> +		   .of_match_table = twl_madc_of_match,
>  	},
>  };
>  


