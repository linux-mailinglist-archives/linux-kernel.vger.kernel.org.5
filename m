Return-Path: <linux-kernel+bounces-117938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E088B187
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B883320A15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8C52F6A;
	Mon, 25 Mar 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZJISpcc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6028C0B;
	Mon, 25 Mar 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398809; cv=none; b=NPJEFOMmygm8QzrzfBYhCmkdCSv2ocv3iC00WGN13AbU20rV3ZRZwFm9kBJ7X8rrZERtmlIGEqAwLXqAgOK/HXjBg45c4ETrilC6WhCK+o9idkmZklD5PQshMCHnHGDoEY3PItS2mRSVokrNEJTrD4HFDQy8hCztOtmSyQLSDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398809; c=relaxed/simple;
	bh=LoJZZc8lLg4OzXpkA2ycYXgYtXUDNWL6Odll9mD4tWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ny10/KAzSOdl0fSlFvGNuckFTONoaJ/5doGbviWiim31Fbt2+OzhnxQNIeyJprkbac9CRSVBiFrz8NYoz5IPn61AV17jxCl1asg8DZ4YdJ5JzEiEq1CbXP6wUXq4R5EmpM8tPaF6WlX1vm/0aDUU5vu8XzzA3FP9ai2mBoO6DIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZJISpcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C4C433F1;
	Mon, 25 Mar 2024 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398808;
	bh=LoJZZc8lLg4OzXpkA2ycYXgYtXUDNWL6Odll9mD4tWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZJISpccY6df5u2Uv/LE6GqQMtLlRwfa6SLj4YMnCutsQM4DPgpOmtIGjI7v0ILei
	 AoEeY/hEUVpEXF0Sy+pMcd2J9iX0MWoHZWnErny+F9YT9hvpx3g0uGEoOXDRTAv4/E
	 ai6zHjRI1d6IL0BaJESWdp6FUfCM9yDvrquaY20c43O9J2XEJzREKxz9jmoRJBpDi1
	 T4Re4A/xDaiFH4gFLae4/bBi25NmS4xaro7egK5tnH9JeB9WF64yIXsg2p1y9pcDKF
	 CJzkY/G++XdakCxibW3c26aDPBgyuAaF5GUiE2puIVb4VMSREGKaXVTWoqV3bvYfIJ
	 aBwz4NGYEs5Bg==
Date: Mon, 25 Mar 2024 20:33:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v4 2/7] iio: accel: adxl345: Group bus configuration
Message-ID: <20240325203312.684391ef@jic23-huawei>
In-Reply-To: <20240325153356.46112-3-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
	<20240325153356.46112-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 15:33:51 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> In the probe function group bus configuration and the
> indio_dev initialization to improve readability.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index be6758015..469015e9c 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -218,22 +218,23 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
> -	/* Enable full-resolution mode */
The naming of the written value gives this comment away + it's obviously misplaced
after previous patch. I'd just drop the comment in patch 1.

> +
>  	data->info = device_get_match_data(dev);
>  	if (!data->info)
>  		return -ENODEV;
>  
> -	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> -				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to set data range\n");
> -
>  	indio_dev->name = data->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  
> +	/* Enable full-resolution mode */
> +	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set data range\n");
> +
>  	/* Enable measurement mode */
>  	ret = adxl345_powerup(data->regmap);
>  	if (ret < 0)


