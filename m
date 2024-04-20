Return-Path: <linux-kernel+bounces-152266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7338ABBA1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E9D1F2151F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B21CAAC;
	Sat, 20 Apr 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvXFrpqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3F1427B;
	Sat, 20 Apr 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618274; cv=none; b=Fo7uopP6FsffD7hvATaW11h8yp1Jrhc+VyZA6v7KY3Rxh9hDCZlaUNEwPjILBdXMtFszMIJpcL97TvmEcas+vVpalx57uhHp4qYVs/mWtDLf9sa4mip9zT/uGyCbNX0LLovK0Rtnj44QXLgnsr1bZ2gtqP8C4YMlosCNrlEtIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618274; c=relaxed/simple;
	bh=QamFW/4GCuEWWHNTHqdv7yga8qrR6HqDWk864yMcmsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxyYE/OcFF828wYRKA8Z9DPMvvZR7Jj7LmnKBEoKodoAxFoou8W28AzTNV4QswT/W7enV3mA0DBZDMGYNIRMjexZkZvl3pUxU0AM64cV1Epj8y/8jVATza0FdPtup39aIasAuy1M/y1UtNOO7FlYeIVaUkr+HkFHRnWGLXNGeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvXFrpqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3140C072AA;
	Sat, 20 Apr 2024 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713618273;
	bh=QamFW/4GCuEWWHNTHqdv7yga8qrR6HqDWk864yMcmsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvXFrpqTxvJU9pbwvOH+OWJN9vrBF+HIDsJyoxBlEjr7n5b9KRbBQ2gDNNY1hb9so
	 QWSBXudL2KsSBVYN3shgXfLMtqxXDyt3mIRHdAJfOGmH6ME5KUAigMkLGXOwyibBVX
	 k4iMGwES8g/Wyp+Jg29aifJzbysH55a7d0zb5w06fY1QB6v372uYO3ZWi1zz1Sp/yF
	 SZCutEls/IQ+he8fuEawxOG2odfeufK+HFaJQF7GAgFebAot6WfaT9LoMpRtxK+DzH
	 OLaE9pWjWpDQFKD6U6MQDcAmzhdi/zxybx/sapU7mG6UynmQQUEuWSomzjuvvLiVnZ
	 oFSdCRVVkOxgg==
Date: Sat, 20 Apr 2024 14:04:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Andy
 Shevchenko <andy.shevchenko@gmail.com>, Ondrej Jirman <megi@xff.cz>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Willow
 Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH 2/4] iio: light: stk3310: Implement vdd supply and power
 it off during suspend
Message-ID: <20240420140417.12b2bf8e@jic23-huawei>
In-Reply-To: <20240414175716.958831-2-aren@peacevolution.org>
References: <20240414175300.956243-1-aren@peacevolution.org>
	<20240414175716.958831-1-aren@peacevolution.org>
	<20240414175716.958831-2-aren@peacevolution.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 13:57:14 -0400
Aren Moynihan <aren@peacevolution.org> wrote:

> From: Ondrej Jirman <megi@xff.cz>
> 
> VDD power input can be used to completely power off the chip during
> system suspend. Do so if available.
I'd make this non optional (relying on regulator framework providing
us a stub for old DT etc) and pay the minor cost of potentially restoring
registers when it was never powered down.

Simpler code and likely anyone who is doing suspend / resume will have
power control anyway.

Jonathan

> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
>  drivers/iio/light/stk3310.c | 56 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 7b71ad71d78d..bfa090538df7 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -16,6 +16,7 @@
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define STK3310_REG_STATE			0x00
>  #define STK3310_REG_PSCTRL			0x01
> @@ -117,6 +118,7 @@ struct stk3310_data {
>  	struct regmap_field *reg_int_ps;
>  	struct regmap_field *reg_flag_psint;
>  	struct regmap_field *reg_flag_nf;
> +	struct regulator *vdd_reg;
>  };
>  
>  static const struct iio_event_spec stk3310_events[] = {
> @@ -607,6 +609,16 @@ static int stk3310_probe(struct i2c_client *client)
>  
>  	mutex_init(&data->lock);
>  
> +	data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");

This needs a comment on why it is optional.
Generally power supply regulators are not, but I think the point here
is to avoid restoring the registers if the chip wasn't powered down?

This feels like an interesting gap in the regulator framework.
For most cases we can rely on  stub / fake regulator being created
for always on supplies, but that doesn't let us elide the register writes.

My gut feeling is do them unconditionally. Suspend / resume isn't
that common that it will matter much.

That would allow you to have this as devm_regulator_get() and
drop handling of it not being provided.

> +	if (IS_ERR(data->vdd_reg)) {
> +		ret = PTR_ERR(data->vdd_reg);
> +		if (ret == -ENODEV)
> +			data->vdd_reg = NULL;
> +		else
> +			return dev_err_probe(&client->dev, ret,
> +					     "get regulator vdd failed\n");
> +	}
> +
>  	ret = stk3310_regmap_init(data);
>  	if (ret < 0)
>  		return ret;
> @@ -617,9 +629,18 @@ static int stk3310_probe(struct i2c_client *client)
>  	indio_dev->channels = stk3310_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
>  
> +	if (data->vdd_reg) {
> +		ret = regulator_enable(data->vdd_reg);
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "regulator vdd enable failed\n");
> +
> +		usleep_range(1000, 2000);
> +	}
> +
>  	ret = stk3310_init(indio_dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_vdd_disable;
>  
>  	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> @@ -645,32 +666,61 @@ static int stk3310_probe(struct i2c_client *client)
>  
>  err_standby:
>  	stk3310_set_state(data, STK3310_STATE_STANDBY);
> +err_vdd_disable:
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
>  	return ret;
>  }
>  
>  static void stk3310_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct stk3310_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
>  }
>  
>  static int stk3310_suspend(struct device *dev)
>  {
>  	struct stk3310_data *data;
> +	int ret;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>  
> -	return stk3310_set_state(data, STK3310_STATE_STANDBY);
> +	ret = stk3310_set_state(data, STK3310_STATE_STANDBY);
> +	if (ret)
> +		return ret;
> +
> +	if (data->vdd_reg) {

As above, I don't think we care enough about overhead on
boards where there isn't a vdd regulator.   Just do this
unconditionally.

> +		regcache_mark_dirty(data->regmap);
> +		regulator_disable(data->vdd_reg);
> +	}
> +
> +	return 0;
>  }
>  
>  static int stk3310_resume(struct device *dev)
>  {
> -	u8 state = 0;
>  	struct stk3310_data *data;
> +	u8 state = 0;
> +	int ret;
>  
>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +
> +	if (data->vdd_reg) {
> +		ret = regulator_enable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(dev, "Failed to re-enable regulator vdd\n");
> +			return ret;
> +		}
> +
> +		usleep_range(1000, 2000);
> +		regcache_sync(data->regmap);
> +	}
> +
>  	if (data->ps_enabled)
>  		state |= STK3310_STATE_EN_PS;
>  	if (data->als_enabled)


