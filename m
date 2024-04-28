Return-Path: <linux-kernel+bounces-161506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0858B4CED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03560B21093
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B773163;
	Sun, 28 Apr 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjR61GuM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2110F1;
	Sun, 28 Apr 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323231; cv=none; b=VsQ4pxQ1a8AC6kh0BueKaKqqtjAxFDYxcBhQDS+BV5dnP8m51emS9J5PB/yvbfxgwKKscEpEZDDt1KrDUUiF8aeOuq7T6KRiDQUUlA3Yr1ZWtJ597+Tv/Y4G4BlXBYkYId8i3Y1ifbIIb8tY9wjGS6AKogekhZBGxPIpRNzcdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323231; c=relaxed/simple;
	bh=vKlq852Mkt2LdjN+6R/Og0QA2JGqOCAcs1MaQ4RQDnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iq9N/Ne1ywXDDTybXZqiX1MuUj2jg3uKbOtoyn2f58ICtJHnLKGTo5whViKxenyAvqRMb5gSVkhsuLwoB8L6Jr53kfpwEPSHicf1jXrvTQM/M1nwvQNvJ43lxaxy1kN2DTUQfKPolD6j4DLAomzavLdQGYEHKBy7WlkmWQHgck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjR61GuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A048C113CC;
	Sun, 28 Apr 2024 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714323231;
	bh=vKlq852Mkt2LdjN+6R/Og0QA2JGqOCAcs1MaQ4RQDnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LjR61GuMEFGAu419qGiabMclqWpfYwDouS36biVw7/fRhxjf2g4HgGKM8NUteeSZz
	 JLeRT6vNf70R+Uvx7Ke8EzX01G8z5BwsfRDVnblc2Mx5uH/GhL/g+6QK0bVoasYoa3
	 scxwyecrhm9CLsnpZsVtalzmmNDr0HTP/vpeT8iyiq/cYnKgFfpRj5RF0zdL3LKtty
	 aLWyMXoNDTbCC3DUBkJE3wHHgSX5AlhrwS8J1q3m72uJYJpEbDBFTXJWG93QS0JvDp
	 LcU0xG+a1b0MM8xJepL9Fdlj50PP8nSrQzI1C5o8MtP7Uwg9/CdG78Pmxx5L8YvIau
	 aM85Mca+qEjzw==
Date: Sun, 28 Apr 2024 17:53:37 +0100
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
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <20240428175337.61850e2a@jic23-huawei>
In-Reply-To: <20240423223309.1468198-4-aren@peacevolution.org>
References: <20240423223309.1468198-2-aren@peacevolution.org>
	<20240423223309.1468198-4-aren@peacevolution.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 18:33:05 -0400
Aren Moynihan <aren@peacevolution.org> wrote:

> From: Ondrej Jirman <megi@xff.cz>
> 
> VDD power input can be used to completely power off the chip during
> system suspend. Do so if available.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

Suggestions inline.  Key thing is take the whole thing devm_ managed
and your life gets much easier.  It is mixing the two approaches that
causes problems and often the best plan is to do everything in probe/remove
with devm_ calls to do the cleanup for you.

> ---
> 
> Notes:
>     Changes in v2:
>      - always enable / disable regulators and rely on a dummy regulator if
>        one isn't specified
>      - replace usleep_range with fsleep
>      - reorder includes so iio headers are last
>      - add missing error handling to resume
> 
>  drivers/iio/light/stk3310.c | 49 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 7b71ad71d78d..a0547eeca3e3 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -13,6 +13,8 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -117,6 +119,7 @@ struct stk3310_data {
>  	struct regmap_field *reg_int_ps;
>  	struct regmap_field *reg_flag_psint;
>  	struct regmap_field *reg_flag_nf;
> +	struct regulator *vdd_reg;
>  };
>  
>  static const struct iio_event_spec stk3310_events[] = {
> @@ -607,6 +610,10 @@ static int stk3310_probe(struct i2c_client *client)
>  
>  	mutex_init(&data->lock);
>  
> +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_reg))
> +		return dev_err_probe(&client->dev, ret, "get regulator vdd failed\n");
> +
>  	ret = stk3310_regmap_init(data);
>  	if (ret < 0)
>  		return ret;
> @@ -617,9 +624,17 @@ static int stk3310_probe(struct i2c_client *client)
>  	indio_dev->channels = stk3310_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
>  
> +	ret = regulator_enable(data->vdd_reg);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "regulator vdd enable failed\n");
> +
> +	/* we need a short delay to allow the chip time to power on */
> +	fsleep(1000);
> +
>  	ret = stk3310_init(indio_dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_vdd_disable;
>  
>  	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> @@ -645,32 +660,60 @@ static int stk3310_probe(struct i2c_client *client)
>  
>  err_standby:
>  	stk3310_set_state(data, STK3310_STATE_STANDBY);

Move this handling to a devm_add_action_or_reset() callback in a precursor patch.
That will fix the current ordering issue wrt to the irq registration.

Then use devm_iio_device_register() in that precursor patch.

> +err_vdd_disable:
> +	regulator_disable(data->vdd_reg);

Add a devm_add_action_or_reset() callback to disable this regulator in this patch.
Register that just after the enable.

That way the ordering will be maintained for all calls.
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
> +	regulator_disable(data->vdd_reg);

With above suggested changes, you can drop the remove function entirely.

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
> +	regcache_mark_dirty(data->regmap);
> +	regulator_disable(data->vdd_reg);
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
> +	ret = regulator_enable(data->vdd_reg);
> +	if (ret) {
> +		dev_err(dev, "Failed to re-enable regulator vdd\n");
> +		return ret;
> +	}
> +
> +	fsleep(1000);
> +
> +	ret = regcache_sync(data->regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to restore registers: %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (data->ps_enabled)
>  		state |= STK3310_STATE_EN_PS;
>  	if (data->als_enabled)


