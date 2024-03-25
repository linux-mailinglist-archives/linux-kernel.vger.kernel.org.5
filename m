Return-Path: <linux-kernel+bounces-116458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8A889F19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F11C35E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FB159574;
	Mon, 25 Mar 2024 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMsc1e3w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DB178891;
	Mon, 25 Mar 2024 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337099; cv=none; b=rFia1D1Ii2+pYkOZkLCn3hlPc99ll0riCFBBJ/uAiJJhY2SQ/O3W7oS3tnQmH36SKDm6ilj3m9L24oMHsfjK6DD9B6L4fciwP344W0tUMJ/nZ+S7BLCm3GcmozrvYxJVznebx4MFX1tHVZF00dtLUkQhAcIytvhxueTjIQy2nPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337099; c=relaxed/simple;
	bh=GakVguLw7Lf5f5Bnjeick8QQQVW5ZbSnjq4ik2Jrhtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLnvYO6w0Cu9UtuspORNz4l8Fo98Jmhz/WsF2c7WukkF2SOfpnSSQjQuOr+kKLwA8sjr/H4qFnv/ZIluxaVPQ7bh4yruSNFgjCbyr+gy4pqPblVfIyNwJogQR/dR3hPAxRzsd82zFjVP8cwH/+U0TDF4Y30SWNECLQD3+QQfjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMsc1e3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246EBC433F1;
	Mon, 25 Mar 2024 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711337099;
	bh=GakVguLw7Lf5f5Bnjeick8QQQVW5ZbSnjq4ik2Jrhtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMsc1e3wpuTRL3x0WYjsA3UoiisjhwQyJtQPJoqpSZnM+1GvokBtbQ20vuSLEGHlp
	 wh5NZaQE75OEYKu+O0gro1bHzs/CRzer2IWoS9NIV2eVZyGUJHJU3fDX5KUjGVv8xL
	 CgYBD+QQ01bsCyZSXzcETKuv8Sm4fw9wPG9TLp8V0JgA7yAnzILTk6llYbZmdRImsF
	 ZvdOmHxCFy4gUOju0YyYsBc1qMl6f5tmUbIxswIpkfeAumFNZiXg9fVt26FvFvjfQp
	 dvUR2SmtCrcmkt2O+Mxdp8/YoRFwA82eKqUx56+1ku+hnVojIyCKTo2v/AicAUGJu9
	 GZj7Vx7MdZfCg==
Date: Mon, 25 Mar 2024 11:24:56 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/chrome: cros_kbd_led_backlight:
 Automatically enable keyboard backlight control if feature present in EC
Message-ID: <ZgDuiEYcgMTuZAeA@google.com>
References: <20240322102800.1322022-1-s.horvath@outlook.com.au>
 <SY4P282MB306333469B31348E4A25A1A5C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY4P282MB306333469B31348E4A25A1A5C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>

On Fri, Mar 22, 2024 at 08:27:58PM +1000, Stephen Horvath wrote:
> I also fixed a bug that seemed like there was some confusion between
> `cros_ec_dev` and `cros_ec_device`, so I'm not sure if this module even
> worked until now.

If they aren't part of commit message, please put them after "---".  Please
separate to an independent patch if they fix different things.

> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index 793fd3f1015d..06e9a57536af 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -171,12 +171,15 @@ static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
>  {
>  	struct keyboard_led *keyboard_led = platform_get_drvdata(pdev);
>  
> -	keyboard_led->ec = dev_get_drvdata(pdev->dev.parent);
> -	if (!keyboard_led->ec) {
> +	struct cros_ec_dev *parent_ec = dev_get_drvdata(pdev->dev.parent);

I'm not sure if it really fixes anything.  See [1] or [2].

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/platform/chrome/cros_ec_lpc.c#L417
[2]: https://elixir.bootlin.com/linux/v6.8/source/drivers/platform/chrome/cros_ec_spi.c#L759

> @@ -200,8 +203,10 @@ static int keyboard_led_probe(struct platform_device *pdev)
>  	int error;
>  
>  	drvdata = device_get_match_data(&pdev->dev);
> -	if (!drvdata)
> -		return -EINVAL;
> +	if (!drvdata) {
> +		/* Assume EC if no match data is provided */
> +		drvdata = &keyboard_led_drvdata_ec_pwm;
> +	}

By current design, the `drvdata` should be provided by either ACPI or OF match.

> @@ -236,22 +241,10 @@ static const struct acpi_device_id keyboard_led_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
>  #endif
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id keyboard_led_of_match[] = {
> -	{
> -		.compatible = "google,cros-kbd-led-backlight",
> -		.data = &keyboard_led_drvdata_ec_pwm,
> -	},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
> -#endif
> -
>  static struct platform_driver keyboard_led_driver = {
>  	.driver		= {
>  		.name	= "chromeos-keyboard-leds",
>  		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
> -		.of_match_table = of_match_ptr(keyboard_led_of_match),

The patch is ruining the use cases in OF world (e.g. [3]).

[3]: https://elixir.bootlin.com/linux/v6.8/source/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi#L1154

