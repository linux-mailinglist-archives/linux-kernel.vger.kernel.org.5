Return-Path: <linux-kernel+bounces-32123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF78356C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FF71C21657
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DA381B2;
	Sun, 21 Jan 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYHsLh/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5237710;
	Sun, 21 Jan 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856264; cv=none; b=jnOzUIY92t/llSzVQjgqAt56+FOhgQngzOvBWvD4rMRoKYZHuGfF1fK4unMwvZr8cRbobaQTA2e/eBK70glYt7zW61P9s+Y97zk4iXev9TlIsUg9czaFyANQ+JIu1P4xRwjQepoxTYVgiZHzEJ8wTa92OgqWDXkPwjG2C5weplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856264; c=relaxed/simple;
	bh=xUUsKQdm2DlB30tYaWgBfTBJW/JNnzcZm3pAljhlPUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjXpsC9E+a6nF4+vOWpsD0kbEK0N41UXHKw5InJj1Fg21qbaJ8WjK/1zeSVQQ05lEYDeWV3LpFyR6AArrMdPr2+iJqcS6HZvOJAWhUAPap/d0ux761PLS+22KsU5pji8QnvpxGsJuNrMLSmDN+u1PUwocj8qyeNXLy+bU04wxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYHsLh/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC38C433F1;
	Sun, 21 Jan 2024 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705856263;
	bh=xUUsKQdm2DlB30tYaWgBfTBJW/JNnzcZm3pAljhlPUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qYHsLh/UMbbvCQsscMvS+Iq00Lg1vCjcPBosKItoIyUIFGS3L0+sF6KVrmsdc1gGF
	 IQ3pzXAgiBdI2ocDZJvX4iRs50NNqtvibnwGx9SAZuj0nEQNWQuim/SKbCq+xwVPTP
	 ECa4ilJLs+pv/orTO3eG6coMFflPR41+MLPGcfZPLwrtPWzkoC/b/TBFUm/B9G2JJb
	 LzO/ERQtaZ4PyZjjBoGdhjoTQm5cD6sHMrY2niqVtwpVALpcE4OQMPPnNU1dU9ay6Z
	 mu9izAeua/ZlSXbEz+G/6iR35j3pLcXQYFq3GfMbIxi++6Dl0aAn1OJGNGoTtgdiEC
	 xOb9u6pSKbsFg==
Date: Sun, 21 Jan 2024 16:57:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ceclan Dumitru
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v4 4/5] iio: amplifiers: hmc425a: use pointers in match
 table
Message-ID: <20240121165721.475d35c2@jic23-huawei>
In-Reply-To: <20240117125124.8326-5-mitrutzceclan@gmail.com>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
	<20240117125124.8326-5-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 14:51:13 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> Change the match table to use pointers instead of device ids.
> Alignment of the hmc425a_state was changed because of the const
>  specifier for hmc425a_chip_info.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Hi Dumitru

The remaining use of type in here and deriving from structure offsets is
not nice.  Add a trivial callback for the stuff in write_raw() that needs
to be different and is currently in a switch statement.
Then get rid of the type enum completely if possible.

> ---
>  drivers/iio/amplifiers/hmc425a.c | 39 ++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index e1162a500daf..b116b54e4206 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -37,11 +37,11 @@ struct hmc425a_chip_info {
>  };
>  
>  struct hmc425a_state {
> -	struct	mutex lock; /* protect sensor state */
> -	struct	hmc425a_chip_info *chip_info;
> -	struct	gpio_descs *gpios;
> -	enum	hmc425a_type type;
> -	u32	gain;
> +	struct				mutex lock; /* protect sensor state */
> +	const struct			hmc425a_chip_info *chip_info;
> +	struct				gpio_descs *gpios;
> +	enum				hmc425a_type type;
> +	u32				gain;

This illustrates why I'm not keen on manual alignment like this. Generates 
churn that makes it hard to spot the actual changes.  To avoid this happening
again I'd suggest a single space is fine for all lines and don't align them
at all!

>  };
>  
>  static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> @@ -58,7 +58,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
>  
>  static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
>  {
> -	struct hmc425a_chip_info *inf = st->chip_info;
> +	const struct hmc425a_chip_info *inf = st->chip_info;
>  	int gain, temp;
>  
>  	if (val < 0)
> @@ -187,15 +187,6 @@ static const struct iio_chan_spec hmc425a_channels[] = {
>  	HMC425A_CHAN(0),
>  };
>  
> -/* Match table for of_platform binding */
> -static const struct of_device_id hmc425a_of_match[] = {
> -	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
> -	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
> -	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, hmc425a_of_match);
> -
>  static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
>  	[ID_HMC425A] = {
>  		.name = "hmc425a",
> @@ -226,6 +217,18 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
>  	},
>  };
>  
> +/* Match table for of_platform binding */
> +static const struct of_device_id hmc425a_of_match[] = {
> +	{ .compatible = "adi,hmc425a",
> +	  .data = &hmc425a_chip_info_tbl[ID_HMC425A]},
> +	{ .compatible = "adi,hmc540s",
> +	  .data = &hmc425a_chip_info_tbl[ID_HMC540S]},
> +	{ .compatible = "adi,adrf5740",
> +	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
> +	{},

Nice to drop that trailing comma whilst here.  No need for one on a 'terminator'
of such an array as by definition nothing should ever be added after it.

> +};
> +MODULE_DEVICE_TABLE(of, hmc425a_of_match);
> +
>  static int hmc425a_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -237,14 +240,16 @@ static int hmc425a_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	st->type = (uintptr_t)device_get_match_data(&pdev->dev);
>  
> -	st->chip_info = &hmc425a_chip_info_tbl[st->type];
> +	st->chip_info = device_get_match_data(&pdev->dev);
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->name = st->chip_info->name;
>  	st->gain = st->chip_info->default_gain;
>  
> +	/* Compute index of the acquired chip info in the array */
> +	st->type = st->chip_info - hmc425a_chip_info_tbl;

Definitely not a good idea. If you need a type field, put it in the chip_info_tbl
but you should not need one anyway because type is rarely what matters
but rather data or behavior (via a callback) needed for a given device.
Here it looks like a callback is needed for the few lines in write_raw()
that are fiddly to express as data.

> +
>  	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
>  	if (IS_ERR(st->gpios))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(st->gpios),


