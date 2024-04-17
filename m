Return-Path: <linux-kernel+bounces-148023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3108F8A7CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AA61F22237
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23576A335;
	Wed, 17 Apr 2024 07:05:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8131E481
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337508; cv=none; b=ZMEMZk4bWtCfLLyKMnC6eGVN6I7Iq10+khUC45+tGRlZ4nZ62h5SI2J3KiMD17oBieqKx0LVH+TN+Y4Au1OxyRaPksT06CenrTAJSt2P3qNuWZngyZsf3lhJWR5ii+mQcvbikrFlXzmCEWqd3gyfK5K3xFk8UeYRCbG4sDi/HIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337508; c=relaxed/simple;
	bh=S4S6GP8Xt+npcbiiC+cfGjjWDrz20qscxOp/z8yLGFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8K8+vXqRNwkN6sf4pvGNWHk8kZOehWqOMC42kF+2t4YIQqwpJTyzTc27Rkp1Yi60w7CqWfoN4avKW1sNdJDRWMTHDMBdwd2h1O9bQUFLO3WdGcAmPsnH1DCnpp5YnYAkadjHfPWt5oUlF5N+QjnWAlTI4RmC0FMr5XvWLIuCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwzLe-0003VK-Mo; Wed, 17 Apr 2024 09:04:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwzLd-00CkZs-Lc; Wed, 17 Apr 2024 09:04:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwzLd-002cZ3-1r;
	Wed, 17 Apr 2024 09:04:49 +0200
Date: Wed, 17 Apr 2024 09:04:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Guenter Roeck <linux@roeck-us.net>, krzysztof.kozlowski+dt@linaro.org, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
Message-ID: <xu4eo5qnkg6ziahv34od3tgem5cjheraus5cly2kchmpeoo3aw@veuoqgiqps6k>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="32tn4twpqp7oickw"
Content-Disposition: inline
In-Reply-To: <20240416171720.2875916-2-naresh.solanki@9elements.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--32tn4twpqp7oickw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
> Utilise pwm subsystem for fan pwm handling
>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  drivers/hwmon/Kconfig   |   1 +
>  drivers/hwmon/max6639.c | 200 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 191 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 257ec5360e35..c9cc74f8c807 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1224,6 +1224,7 @@ config SENSORS_MAX6639
>  	tristate "Maxim MAX6639 sensor chip"
>  	depends on I2C
>  	select REGMAP_I2C
> +	depends on PWM
>  	help
>  	  If you say yes here you get support for the MAX6639
>  	  sensor chips.
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 1af93fc53cb5..f37fdd161154 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_data/max6639.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
> =20
>  /* Addresses to scan */
> @@ -55,6 +56,9 @@ static const unsigned short normal_i2c[] =3D { 0x2c, 0x=
2e, 0x2f, I2C_CLIENT_END };
>  #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
> =20
>  #define MAX6639_FAN_CONFIG1_PWM			0x80
> +#define MAX6639_REG_FAN_CONFIG2a_PWM_POL	0x02
> +#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
> +#define MAX6639_REG_TARGTDUTY_SLOT		120
> =20
>  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
> =20
> @@ -62,6 +66,10 @@ static const unsigned short normal_i2c[] =3D { 0x2c, 0=
x2e, 0x2f, I2C_CLIENT_END };
> =20
>  static const int rpm_ranges[] =3D { 2000, 4000, 8000, 16000 };
> =20
> +/* Supported PWM frequency */
> +static const unsigned int freq_table[] =3D { 20, 33, 50, 100, 5000, 8333=
, 12500,
> +					   25000 };
> +
>  #define FAN_FROM_REG(val, rpm_range)	((val) =3D=3D 0 || (val) =3D=3D 255=
 ? \
>  				0 : (rpm_ranges[rpm_range] * 30) / (val))
>  #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
> @@ -93,6 +101,9 @@ struct max6639_data {
> =20
>  	/* Optional regulator for FAN supply */
>  	struct regulator *reg;
> +	/* max6639 pwm chip */
> +	struct pwm_chip chip;

That won't work with the recent changes to the pwm framework. Please
test your patch on top of next.

> +	struct pwm_device *pwmd[MAX6639_NDEV]; /* max6639 has two pwm device */

s/device/devices/

>  };
> =20
>  static struct max6639_data *max6639_update_device(struct device *dev)
> @@ -271,8 +282,11 @@ static ssize_t pwm_show(struct device *dev, struct d=
evice_attribute *dev_attr,
>  {
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data =3D dev_get_drvdata(dev);
> +	struct pwm_state state;
> +
> +	pwm_get_state(data->pwmd[attr->index], &state);
> =20
> -	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
> +	return sprintf(buf, "%d\n", pwm_get_relative_duty_cycle(&state, 255));
>  }
> =20
>  static ssize_t pwm_store(struct device *dev,
> @@ -281,6 +295,7 @@ static ssize_t pwm_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data =3D dev_get_drvdata(dev);
> +	struct pwm_state state;
>  	unsigned long val;
>  	int res;
> =20
> @@ -290,10 +305,10 @@ static ssize_t pwm_store(struct device *dev,
> =20
>  	val =3D clamp_val(val, 0, 255);
> =20
> -	mutex_lock(&data->update_lock);
> -	data->pwm[attr->index] =3D (u8)(val * 120 / 255);
> -	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), data->pw=
m[attr->index]);
> -	mutex_unlock(&data->update_lock);
> +	pwm_get_state(data->pwmd[attr->index], &state);
> +	pwm_set_relative_duty_cycle(&state, val, 255);
> +	pwm_apply_state(data->pwmd[attr->index], &state);

I'm not a big fan of that pwm_get_state() + modify duty_cycle +
pwm_apply_state(). IMHO it's better to keep a struct pwm_state around in
the consumer and so have complete control in each step.

> +
>  	return count;
>  }
> =20
> @@ -373,6 +388,158 @@ static struct attribute *max6639_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(max6639);
> =20
> +static struct max6639_data *to_max6639_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct max6639_data, chip);
> +}
> +
> +static int max6639_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct max6639_data *data =3D to_max6639_pwm(chip);
> +	int value, i =3D pwm->hwpwm, x, err;
> +	unsigned int freq;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	err =3D regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG1(i), &value);
> +	if (err < 0)
> +		goto abort;

I don't know if the hwmon maintainers like that, but taking a mutex for
the whole function's runtime can also be expressed by:

	guard(mutex)(&data->update_lock);

then all the goto abort below can be replaced by return err.

> +
> +	if (value & MAX6639_FAN_CONFIG1_PWM) {
> +		state->enabled =3D true;
> +
> +		/* Determine frequency from respective registers */
> +		err =3D regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(i), &value);
> +		if (err < 0)
> +			goto abort;
> +		x =3D value & MAX6639_FAN_CONFIG3_FREQ_MASK;
> +
> +		err =3D regmap_read(data->regmap, MAX6639_REG_GCONFIG, &value);
> +		if (err < 0)
> +			goto abort;
> +		if (value & MAX6639_GCONFIG_PWM_FREQ_HI)
> +			x |=3D 0x4;
> +		x &=3D 0x7;
> +		freq =3D freq_table[x];
> +
> +		state->period =3D DIV_ROUND_UP(NSEC_PER_SEC, freq);
> +
> +		err =3D regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(i), &value);
> +		if (err < 0)
> +			goto abort;
> +		/* max6639 supports 120 slots only */
> +		state->duty_cycle =3D mul_u64_u32_div(state->period, value, 120);

MAX6639_REG_TARGTDUTY_SLOT instead of 120 here.

> +		err =3D regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), &value);
> +		if (err < 0)
> +			goto abort;
> +		value &=3D MAX6639_REG_FAN_CONFIG2a_PWM_POL;
> +		state->polarity =3D (value !=3D 0);

Please don't hardcode PWM_POLARITY_* values here. Please use:

	state->polarity =3D (value !=3D 0) ? PWM_POLARITY_INVERSED : PWM_POLARITY_=
NORMAL;

(or an if statement).

> +	} else {
> +		state->enabled =3D false;
> +	}
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return value;
> +}
> +
> +static int max6639_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct max6639_data *data =3D to_max6639_pwm(chip);
> +	int value, i =3D pwm->hwpwm, x, err;
> +	unsigned int freq;
> +	struct pwm_state cstate;
> +
> +	cstate =3D pwm->state;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (state->period !=3D cstate.period) {
> +		/* Configure frequency */
> +		freq =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, state->period);
> +
> +		/* Chip supports limited number of frequency */
> +		for (x =3D 0; x < sizeof(freq_table); x++)
> +			if (freq <=3D freq_table[x])
> +				break;

If you store the periods instead of the frequencies in the global table
you can save several divisions and so simplify the code.

> +		err =3D regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(i), &value);
> +		if (err < 0)
> +			goto abort;
> +
> +		value &=3D ~MAX6639_FAN_CONFIG3_FREQ_MASK;
> +		value |=3D (x & MAX6639_FAN_CONFIG3_FREQ_MASK);

You're using implicitly that there is no shift involved in
MAX6639_FAN_CONFIG3_FREQ_MASK. Better use FIELD_PREP().

Also MAX6639_FAN_CONFIG3_FREQ_MASK is 3, but x ranges in [0 ... 7].
That's a bug, isn't it?

> +		err =3D regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG3(i), value);
> +		if (err < 0)
> +			goto abort;

How does the hardware behave here? Does it emit the new period already
with the old duty cycle and polarity setting? Please document that,
ideally in a paragraph captured "Limitations:" and a format matching
what several other pwm drivers do, to make that easily greppable.

> +		err =3D regmap_read(data->regmap, MAX6639_REG_GCONFIG, &value);
> +		if (err < 0)
> +			goto abort;
> +
> +		if (x >> 2)
> +			value &=3D ~MAX6639_GCONFIG_PWM_FREQ_HI;
> +		else
> +			value |=3D MAX6639_GCONFIG_PWM_FREQ_HI;
> +		err =3D regmap_write(data->regmap, MAX6639_REG_GCONFIG, value);
> +		if (err < 0)
> +			goto abort;
> +	}
> +
> +	/* Configure dutycycle */
> +	if (state->duty_cycle !=3D cstate.duty_cycle ||
> +	    state->period !=3D cstate.period) {
> +		value =3D DIV_ROUND_DOWN_ULL(state->duty_cycle * MAX6639_REG_TARGTDUTY=
_SLOT,
> +					   state->period);

The multiplication might overflow, better use mul_u64_u64_div_u64()
here. Also you're loosing precision here because the real period might
be lower than state->period. Consider:

	state->period =3D 9999999 [ns]
	state->duty_cycle =3D 123456 [ns]

With the possible frequencies you have to pick freq =3D 5000 [Hz] giving
you a period of 200000 ns. You're then configuring 123456 * 120 / 9999999
=3D 1 as duty_cycle count giving you 1666 ns as duty cycle. However you're
supposed to configure 74 giving 123333 ns.

> +		err =3D regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), value);
> +		if (err < 0)
> +			goto abort;
> +	}
> +
> +	/* Configure polarity */
> +	if (state->polarity !=3D cstate.polarity) {
> +		err =3D regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), &value);
> +		if (err < 0)
> +			goto abort;
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			value |=3D MAX6639_REG_FAN_CONFIG2a_PWM_POL;
> +		else
> +			value &=3D ~MAX6639_REG_FAN_CONFIG2a_PWM_POL;
> +		err =3D regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), value);
> +		if (err < 0)
> +			goto abort;
> +	}
> +
> +	if (state->enabled !=3D cstate.enabled) {
> +		err =3D regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG1(i), &value);
> +		if (err < 0)
> +			goto abort;
> +		if (state->enabled)
> +			value |=3D MAX6639_FAN_CONFIG1_PWM;
> +		else
> +			value &=3D ~MAX6639_FAN_CONFIG1_PWM;
> +
> +		err =3D regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i), value);
> +		if (err < 0)
> +			goto abort;
> +	}
> +	value =3D 0;
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +
> +	return err;
> +}
> +
> +static const struct pwm_ops max6639_pwm_ops =3D {
> +	.apply =3D max6639_pwm_apply,
> +	.get_state =3D max6639_pwm_get_state,
> +};
> +
>  /*
>   *  returns respective index in rpm_ranges table
>   *  1 by default on invalid range
> @@ -396,6 +563,7 @@ static int max6639_init_client(struct i2c_client *cli=
ent,
>  		dev_get_platdata(&client->dev);
>  	int i;
>  	int rpm_range =3D 1; /* default: 4000 RPM */
> +	struct pwm_state state;

state could have a more local scope.

>  	int err;
> =20
>  	/* Reset chip to default values, see below for GCONFIG setup */
> @@ -459,11 +627,15 @@ static int max6639_init_client(struct i2c_client *c=
lient,
>  		if (err)
>  			goto exit;
> =20
> -		/* PWM 120/120 (i.e. 100%) */
> -		data->pwm[i] =3D 120;
> -		err =3D regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), data->pwm=
[i]);
> -		if (err)
> -			goto exit;
> +		dev_dbg(&client->dev, "Using chip default PWM");
> +		data->pwmd[i] =3D pwm_request_from_chip(&data->chip, i, NULL);
> +		if (IS_ERR(data->pwmd[i]))
> +			return PTR_ERR(data->pwmd[i]);
> +		pwm_get_state(data->pwmd[i], &state);

What I said above about the pwm_get_state() + modify + pwm_apply_state()
approach applies still more to the initial configuration. Here you're
keeping some HW state set previously by an earlier incarnation of the
driver, or the boot loader or the reset default value, which might
involve state.enabled =3D false.

> +		state.period =3D DIV_ROUND_UP(NSEC_PER_SEC, 25000);
> +		state.polarity =3D PWM_POLARITY_NORMAL;
> +		pwm_set_relative_duty_cycle(&state, 0, 255);

This involves a division. Using

	state.duty_cycle =3D 0;

would be more efficient here.

> +		pwm_apply_state(data->pwmd[i], &state);
>  	}
>  	/* Start monitoring */
>  	err =3D regmap_write(data->regmap, MAX6639_REG_GCONFIG,
> @@ -540,6 +712,14 @@ static int max6639_probe(struct i2c_client *client)
>  				     PTR_ERR(data->regmap),
>  				     "regmap initialization failed\n");
> =20
> +	/* Add PWM controller of max6639 */
> +	data->chip.dev =3D dev;
> +	data->chip.ops =3D &max6639_pwm_ops;
> +	data->chip.npwm =3D MAX6639_NDEV;
> +	err =3D devm_pwmchip_add(dev, &data->chip);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to add PWM chip\n");
> +
>  	data->reg =3D devm_regulator_get_optional(dev, "fan");
>  	if (IS_ERR(data->reg)) {
>  		if (PTR_ERR(data->reg) !=3D -ENODEV)

Do I understand right that the driver itself is expected to be the only
consumer of this PWM? I'm not sure that using the PWM stuff is a useful
improvement then. You're just gaining some debug possibilies for the
overhead. Probably it's easier to just inspect the device's registers
directly to debug and stick to the old abstraction without a struct
pwm_chip?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--32tn4twpqp7oickw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYfdJAACgkQj4D7WH0S
/k50uggAm1ixmMPchxPconilCb5yr8k8SUAuA+7DjcgUg7t5W0zhtSYcloQcW3BG
oFkT6XLcLJjG+AAiC0GfAw0TpSD2P4KtYENO1Xa8IPWFDGXEIimQd1d4eyrVd66h
ISQjyc+mE7QCn/kZuSsn4AgpOkkGW1DgppsAjzp08GPw7xtPchx1vjrwaZnQHZWa
tTEjyraIu7fzb3+rF8gflqkQJ9drhX68nJXvK5sKrVzqHtes4JgmY4yT1igI9Q8n
7wIhij1p5NoY6tWJgoatMQikuvJB2SWZV/D2SwA0YjorWvf9TfuWCH/HIZlKN0MD
Ua0H8VhEtMtQWPIYHLt7G7H3OhNhrQ==
=gP/z
-----END PGP SIGNATURE-----

--32tn4twpqp7oickw--

