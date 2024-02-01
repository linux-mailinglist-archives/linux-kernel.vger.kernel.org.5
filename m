Return-Path: <linux-kernel+bounces-47805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5A84531A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6611B284CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BAB15AAB4;
	Thu,  1 Feb 2024 08:49:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9B15AAA3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777385; cv=none; b=t9oSlLSGrRYyGyIT8ajohK86NcvTP+ZVzP+FJXA1A+qH3AGQyFHeVTKGEVF2Rrn5K+LMre+a9LSFdN8l0e8IOpC1DSPDfbkqi7uXaqt0MZwZazv3CZ591qR+1ON2v79vGEKAuayvbB2L3FnNMWG6H0LLYUA9basH7QYqVVX+pq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777385; c=relaxed/simple;
	bh=Y1L6+YQ3zPgekoMtZRbPzpugeBczZCH2errOXEgU/QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boXeFJR0WACjNbPkmH4ghtdj5T52dA8lyvkoSQZW0LhY1/wPCWrwF9+iY505lPwSf2dmk32W5xJu7wK8DXeoCo+R0k1p4GfMy51041QEO3KiBV/fsV/+TNoiHz/N/PCbMW7+8lFgRywonT1rLfRyeQEUK1d7j4kNkYYPp8/wAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVSlB-0001qv-A5; Thu, 01 Feb 2024 09:49:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVSl9-003oeA-0k; Thu, 01 Feb 2024 09:49:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVSl8-00Cthr-2y;
	Thu, 01 Feb 2024 09:49:22 +0100
Date: Thu, 1 Feb 2024 09:49:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Brandon Cheo Fusi <fusibrandon13@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, John Watts <contact@jookia.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Maksim Kiselev <bigunclemax@gmail.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <eynkbikmzcffid2jft3b6pmjfcbvda6mpzu7l5mefrw3za3iwh@ctgn57kb7ard>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
 <20240131125920.2879433-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w56zi5w66btz7pje"
Content-Disposition: inline
In-Reply-To: <20240131125920.2879433-3-privatesub2@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--w56zi5w66btz7pje
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello Aleksandr,

On Wed, Jan 31, 2024 at 03:59:15PM +0300, Aleksandr Shubin wrote:
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Some time ago there was some effort by Rob Herring to detangle the
headers platform_device.h, of_device.h and of.h. See for example commit
87e51b76c9db8c29cde573af0faf5a3e13e23960. I think you should use
linux/of.h instead of linux/of_device.h.

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define SUN20I_PWM_CLK_CFG(chan)		(0x20 + (((chan) >> 1) * 0x4))
> +#define SUN20I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
> +#define SUN20I_PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
> +#define SUN20I_PWM_CLK_DIV_M_MAX		8

SUN20I_PWM_CLK_CFG_DIV_M_MAX?

> +#define SUN20I_PWM_CLK_GATE			0x40
> +#define SUN20I_PWM_CLK_GATE_BYPASS(chan)	BIT((chan) + 16)
> +#define SUN20I_PWM_CLK_GATE_GATING(chan)	BIT(chan)
> +
> +#define SUN20I_PWM_ENABLE			0x80
> +#define SUN20I_PWM_ENABLE_EN(chan)		BIT(chan)
> +
> +#define SUN20I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
> +#define SUN20I_PWM_CTL_ACT_STA			BIT(8)
> +#define UN20I_PWM_CTL_PRESCAL_K		GENMASK(7, 0)
> +#define SUN20I_PWM_CTL_PRESCAL_K_MAX		0xff

This matches the theoretical maximum for GENMASK(7,0), so you could make
use of field_max(SUN20I_PWM_CTL_PRESCAL_K) here.

> +#define SUN20I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
> +#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define SUN20I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define SUN20I_PWM_PCNTR_SIZE			BIT(16)
> +
> +/**
> + * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock d=
ividers
> + * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL=
_K)
> + * without using a loop. These dividers limit the # of cycles in a period
> + * to SUN20I_PWM_PCNTR_SIZE by applying a scaling factor of
> + * 1/(div_m * (prescale_k + 1)) to the clock source.
> + *
> + * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
> + * such that for a given requested period,
> + *
> + * i) div_m is minimized for any prescale_k =E2=89=A4 SUN20I_PWM_CTL_PRE=
SCAL_K_MAX,
> + * ii) prescale_k is minimized.
> + *
> + * The derivation proceeds as follows, with val =3D # of cycles for reqe=
sted

s/reqested/requested/

> + * period:
> + *
> + * for a given value of div_m we want the smallest prescale_k such that
> + *
> + * (val >> div_m) // (prescale_k + 1) =E2=89=A4 65536 (SUN20I_PWM_PCNTR_=
SIZE)
> + *
> + * This is equivalent to:
> + *
> + * (val >> div_m) =E2=89=A4 65536 * (prescale_k + 1) + prescale_k
> + * =E2=9F=BA (val >> div_m) =E2=89=A4 65537 * prescale_k + 65536
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 65537 * prescale_k
> + * =E2=9F=BA ((val >> div_m) - 65536) / 65537 =E2=89=A4 prescale_k
> + *
> + * As prescale_k is integer, this becomes
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 prescale_k
> + *
> + * And is minimized at
> + *
> + * ((val >> div_m) - 65536) // 65537
> + *
> + * Now we pick the smallest div_m that satifies prescale_k =E2=89=A4 255
> + * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 255
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 255 * 65537 + 65536
> + * =E2=9F=BA val >> div_m =E2=89=A4 255 * 65537 + 2 * 65536
> + * =E2=9F=BA val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> + * =E2=9F=BA div_m =3D fls((val) / (255 * 65537 + 2 * 65536 + 1))
> + *
> + * Suggested by Uwe Kleine-K=C3=B6nig

Good man, I assume this is all sane then :-)

> + */
> +#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
> +
> +struct sun20i_pwm_chip {
> +	struct clk *clk_bus, *clk_hosc, *clk_apb0;
> +	struct reset_control *rst;
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	/* Mutex to protect pwm apply state */
> +	struct mutex mutex;
> +};
> +
> +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip=
 *chip)
> +{
> +	return container_of(chip, struct sun20i_pwm_chip, chip);
> +}
> +
> +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u16 ent_cycle, act_cycle, prescale_k;
> +	u64 clk_rate, tmp;
> +	u8 div_m;
> +	u32 val;
> +
> +	mutex_lock(&sun20i_chip->mutex);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
> +	div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
> +	if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +		div_m =3D SUN20I_PWM_CLK_DIV_M_MAX;
> +
> +	if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) =3D=3D 0)
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_apb0);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	state->polarity =3D (SUN20I_PWM_CTL_ACT_STA & val) ?
> +			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> +
> +	prescale_k =3D FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +	state->enabled =3D (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : fa=
lse;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
> +
> +	mutex_unlock(&sun20i_chip->mutex);
> +
> +	act_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> +	ent_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
> +
> +	/*
> +	 * The duration of the active phase should not be longer
> +	 * than the duration of the period
> +	 */
> +	if (act_cycle > ent_cycle)
> +		act_cycle =3D ent_cycle;
> +
> +	tmp =3D ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp =3D ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);

Please add a comment above this block that justifies assuming that the
multiplication doesn't overflow. Something like:

	We have act_cycle <=3D ent_cycle <=3D 0xffff, prescale_k <=3D 0x100,
	div_m <=3D 8. So the multiplication fits into an u64 without
	overflow.

> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +...
> +}

I didn't recheck all the logic in .apply in detail and will assume it is
sane for this round.

> +static const struct pwm_ops sun20i_pwm_ops =3D {
> +	.apply =3D sun20i_pwm_apply,
> +	.get_state =3D sun20i_pwm_get_state,
> +};
> +
> +static const struct of_device_id sun20i_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun20i-d1-pwm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
> +
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	int ret;
> +
> +	sun20i_chip =3D devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERN=
EL);
> +	if (!sun20i_chip)
> +		return -ENOMEM;
> +
> +	sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	sun20i_chip->clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> +	if (IS_ERR(sun20i_chip->clk_bus))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
> +				     "failed to get bus clock\n");
> +
> +	sun20i_chip->clk_hosc =3D devm_clk_get_enabled(&pdev->dev, "hosc");
> +	if (IS_ERR(sun20i_chip->clk_hosc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
> +				     "failed to get hosc clock\n");
> +
> +	sun20i_chip->clk_apb0 =3D devm_clk_get_enabled(&pdev->dev, "apb0");
> +	if (IS_ERR(sun20i_chip->clk_apb0))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
> +				     "failed to get apb0 clock\n");
> +
> +	sun20i_chip->rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(sun20i_chip->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
> +				     "failed to get bus reset\n");
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels=
",
> +				   &sun20i_chip->chip.npwm);
> +	if (ret)
> +		sun20i_chip->chip.npwm =3D 8;
> +
> +	if (sun20i_chip->chip.npwm > 16)
> +		sun20i_chip->chip.npwm =3D 16;

Is it worth to emit an error message here? Something like:

	Limiting number of PWM lines from %u to 16

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w56zi5w66btz7pje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW7WxEACgkQj4D7WH0S
/k7HfAgAn/PEpM3A20iTXqFs73pn5IFzr1kdJaIPSkUT8GkUYe8Qrjamd4VXwoBK
lkLscSz256RA8t2tYfM5dwWO71U6TJBPmS3UfeJQjZVFN4jK7ptPzxwiO2S9xjrt
rJhOHMvlEQT+OvF0/LJwGLYSycTXT2Y5eypA4beDzoqTRSBpmdzzcZ5ft2XbcOD+
0tItrmGiiB7Cj17JacxEoeT2BDpMvwvuu6w7Rx2IeGkKrNcn/11bLeAQl7CKnoUk
xs+tfJpSZ1LE8NZJVYEFb3adpGOV7jCjPEgELogWTTNdxdwuVdBY8PVgnAW+LM3q
+Jh3qobPQ8dXFOxh6J3IHJc/he7Vpw==
=wVat
-----END PGP SIGNATURE-----

--w56zi5w66btz7pje--

