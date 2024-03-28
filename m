Return-Path: <linux-kernel+bounces-123062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B531189019D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF682975F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3812BEAA;
	Thu, 28 Mar 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZGw97JH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7812A157;
	Thu, 28 Mar 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635657; cv=none; b=q/3+jeD74MQleA3o3sijF7enck89dOvvjLY/tMMrBNbszuox5SM7JSMJL8Yz7Tjw8dxLrXNfDJcCUzgLFvuh1r/pmnka0LRS+VAi/ZgBCDGzgHhW70btKhAUuN5xWl/F9D8t5OyxE0beIGVjSl9NAGHlZM7arQxmk2a3MoJ7FVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635657; c=relaxed/simple;
	bh=/mzKcAcVee2eDwo7xSaEAAot3AENIEbBi8tazumkqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olpUBa1c1kLdSWQ8mRcwmQ3J3qxhuPwDPoWRsjwlHP0M0oJMZNyRr91BlsjIHwy2RqEf+LSc6Oj6UvK3bQ2xnApOnWyd75Rz/C+WhzGdZgw04zWYyZvIh1SHHSarHSFN+Set+aFarCGTP0spkXhUorJTho2M9m1lVdF2rwA7WqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZGw97JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07FAC433F1;
	Thu, 28 Mar 2024 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711635656;
	bh=/mzKcAcVee2eDwo7xSaEAAot3AENIEbBi8tazumkqxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZGw97JHpv2rPipXEAsc3DpK4QsdoAqKyqoFPu3f9fMs2GYquXDrM9QwWUGKem+Gv
	 teYRiV8pcY3RtLVO4rIVxoHtSK5G0WdW8tujyxd/nZtKoKO/utXKpkiE2cFTSTmgn0
	 nVXtrG4+iH4CGFQ6RM/tR/H9YwlpktlfW2cwJyendK1+V2Z20gGF3ysd1y0MOZLD/r
	 pW1XLdPX9cbT6edtiZY1CFDMkw/M4HMLCOh6dXJjWfN5WTR6mYquAJLbP5pSz+/a1Y
	 RZjt+8VyzXSHGxhhRB8q8UHLz4s8G5MapjJL84wBv6Kcfyp35NXjbxTDTCIOD+ub1R
	 uDzbZk7mzN6XA==
Date: Thu, 28 Mar 2024 14:20:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Support Opensource
 <support.opensource@diasemi.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] hwmon: (da9052) Use
 devm_regulator_get_enable_get_voltage()
Message-ID: <20240328142038.33ad68bc@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-3-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-3-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:52 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code by using
> devm_regulator_get_enable_get_voltage().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

A few comments inline, but nothing substantial.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/hwmon/da9052-hwmon.c | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> index 2bd7ae8100d7..70e7bc72e980 100644
> --- a/drivers/hwmon/da9052-hwmon.c
> +++ b/drivers/hwmon/da9052-hwmon.c
> @@ -26,7 +26,6 @@ struct da9052_hwmon {
>  	struct mutex		hwmon_lock;
>  	bool			tsi_as_adc;
>  	int			tsiref_mv;
> -	struct regulator	*tsiref;
>  	struct completion	tsidone;
>  };
>  
> @@ -414,32 +413,19 @@ static int da9052_hwmon_probe(struct platform_device *pdev)
>  		device_property_read_bool(pdev->dev.parent, "dlg,tsi-as-adc");
>  
>  	if (hwmon->tsi_as_adc) {
> -		hwmon->tsiref = devm_regulator_get(pdev->dev.parent, "tsiref");
> -		if (IS_ERR(hwmon->tsiref)) {
> -			err = PTR_ERR(hwmon->tsiref);
> -			dev_err(&pdev->dev, "failed to get tsiref: %d", err);
> +		err = devm_regulator_get_enable_get_voltage(pdev->dev.parent,
> +							    "tsiref");
> +		if (err < 0)
>  			return err;
> -		}
> -
> -		err = regulator_enable(hwmon->tsiref);
> -		if (err)
> -			return err;
> -
> -		hwmon->tsiref_mv = regulator_get_voltage(hwmon->tsiref);
> -		if (hwmon->tsiref_mv < 0) {
> -			err = hwmon->tsiref_mv;
> -			goto exit_regulator;
> -		}
>  
>  		/* convert from microvolt (DT) to millivolt (hwmon) */
> -		hwmon->tsiref_mv /= 1000;
> +		hwmon->tsiref_mv = err / 1000;
>

Using a variable called err for a good value is a bit ugly but fair enough if that
is precedence in this driver.

>  }
> @@ -483,10 +466,8 @@ static void da9052_hwmon_remove(struct platform_device *pdev)
>  {
>  	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
>  
> -	if (hwmon->tsi_as_adc) {
> +	if (hwmon->tsi_as_adc)
>  		da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);
Superficially looks like devm_da9052_request_irq could be added that
uses devm_request_threaded_irq() to allow dropping this remaining handling.

Thanks,

Jonathan

> -		regulator_disable(hwmon->tsiref);
> -	}
>  }
>  
>  static struct platform_driver da9052_hwmon_driver = {
> 


