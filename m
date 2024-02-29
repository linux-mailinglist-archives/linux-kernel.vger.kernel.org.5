Return-Path: <linux-kernel+bounces-87097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE086CF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CDC1C219FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CA2A1A5;
	Thu, 29 Feb 2024 16:42:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6652C85D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224946; cv=none; b=sH1lCvPgPM+K6nalDgvWfxBCCzREvc94Ok8HSFq8HsrxLc7Zg0EH+8PKR/kYD3ILV1FhAScVzVcbjMYc3bsjiU4JVeNxIxrrcBgdspMDO5pNsyrVSnjMgpbYaMxs3OYOiakBphkb1CPFoZ+ae1VVjmPcjZqRHexSS7sT10okFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224946; c=relaxed/simple;
	bh=Db9JUvPR6F+eOmkSNzXhFO+CfiJGuNEskJWFH1rRwcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6oWHp88p7amR/bMZlRiAtobKKoK84daHMI/AqqAp6N8eqg5DWw29FqS8b3Wax7JLFQklzjI6943SzGlhO/E1kDDjOJdqqtshWVxXkkBSWtZGFKRZ97tMYhfEekIPC5r3Pg/Yy7YD6nsI4TwC4sgM5zpaKIgQ9cuNXZtoMcHU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfjU9-0003fL-OZ; Thu, 29 Feb 2024 17:42:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfjU8-003cj6-Cj; Thu, 29 Feb 2024 17:42:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfjU8-00E36K-0x;
	Thu, 29 Feb 2024 17:42:16 +0100
Date: Thu, 29 Feb 2024 17:42:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <wwkzprliai3vge53fcveosfkixmri4hoyfjeulbzoezmaayoci@6hor5uwwdag4>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
 <20240212210652.368680-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ork2vse6yp64f2pa"
Content-Disposition: inline
In-Reply-To: <20240212210652.368680-3-fabrizio.castro.jz@renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ork2vse6yp64f2pa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 09:06:50PM +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The RZ/V2{M, MA} PWM Timer supports the following functions:
>=20
>  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
>  * The frequency division ratio for internal counter operation is
>    selectable as PWM_CLK divided by 1, 16, 256, or 2048.
>  * The period as well as the duty cycle is adjustable.
>  * The low-level and high-level order of the PWM signals can be
>    inverted.
>  * The duty cycle of the PWM signal is selectable in the range from
>    0 to 100%.
>  * The minimum resolution is 20.83 ns.
>  * Three interrupt sources: Rising and falling edges of the PWM signal
>    and clearing of the counter
>  * Counter operation and the bus interface are asynchronous and both
>    can operate independently of the magnitude relationship of the
>    respective clock periods.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>=20
> v6->v7:
>  * Addressed the build issue reported by the kernel test robot.
>  * Added include math64.h.
>  * Reworked rzv2m_pwm_mul_u64_u64_div_u64_roundup to make use of
>    div64_u64 and to get rid of % while keeping the same formula.
>  * Added rzv2m_pwm_mul_u64_u64_div_u64_rounddown.
>  * Replaced / with div64_u64 wherever necessary.
> v5->v6:
>  * Added Fab's Signed-off-by.
>  * Updated copyright year to 2024.
>  * Added include of limits.h.
>  * Added variable max_period to rzv2m_pwm_chip.
>  * Simplified the calculations by calculating max_period during probe,
>    based on the numerical limits of the formula and the u64 data type.
>  * Added rzv2m_pwm_mul_u64_u64_div_u64_roundup.
>  * Added rzv2m_pwm_prescale_to_shift to fix the calculation of the
>    frequency divider.
>  * Improved the calculations and the variable names of
>    rzv2m_pwm_get_state.
>  * Improved the calculations of rzv2m_pwm_config.
>  * Removed .owner from rzv2m_pwm_ops.
>  * Improved rzv2m_pwm_pm_runtime_resume and renamed its err variable to
>    ret.
>  * Removed of_match_ptr.
>  * Added Fab as module author.
> v4->v5:
>  * Sorted KConfig file
>  * Sorted Make file
>  * Updated copyright header 2022->2023.
>  * Updated limitation section.
>  * Replaced the variable chip->rzv2m_pwm in rzv2m_pwm_wait_delay()
>  * Replaced polarity logic as per HW manual dutycycle =3D Ton/Ton+Toff, so
>    eventhough native polarity is inverted from period point of view it
>    is correct.
>  * Added logic for supporting 0% , 100% and remaining duty cycle.
>  * On config() replaced
>    pm_runtime_resume_and_get()->pm_runtime_get_sync()
>  * Counter is stopped while updating period/polarity to avoid glitches.
>  * Added error check for clk_prepare_enable()
>  * Introduced is_ch_enabled variable to cache channel enable status.
>  * clk_get_rate is called after enabling the clock and
>    clk_rate_exclusive_get()
>  * Added comment for delay
>  * Replaced 1000000000UL->NSEC_PER_SEC.
>  * Improved error handling in probe().
> v3->v4:
>  * Documented the hardware properties in "Limitations" section
>  * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
>  * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
>  * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i)
>    for calculating divider as it is power of 16.
>  * Reordered the functions to have rzv2m_pwm_config() directly before
>    rzv2m_pwm_apply().
>  * Improved the logic for calculating period and duty cycle in config()
>  * Merged multiple RZV2M_PWMCTR register writes to a single write in
>  * config()
>  * replaced pwm_is_enabled()->pwm->state.enabled
>  * Avoided assigning bit value as enum pwm_polarity instead used enum
>  * constant.
>  * Fixed various issues in probe error path.
>  * Updated the logic for PWM cycle setting register
>  * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So
>    restricting PWMCYC values < 0xffffff
>  * The native polarity of the hardware is inverted (i.e. it starts with
>    the low part). So switched the inversion bit handling.
> v2->v3:
>  * Added return code for rzv2m_pwm_get_state()
>  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> v1->v2:
>  * Replaced
>    devm_reset_control_get_optional_shared->devm_reset_control_get_shared
>=20
>  drivers/pwm/Kconfig     |  11 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-rzv2m.c | 480 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 492 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzv2m.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..55d46e6183a2 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -524,6 +524,17 @@ config PWM_RZ_MTU3
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rz-mtu3.
> =20
> +config PWM_RZV2M
> +       tristate "Renesas RZ/V2M PWM support"
> +       depends on ARCH_R9A09G011 || COMPILE_TEST
> +       depends on HAS_IOMEM
> +       help
> +         This driver exposes the PWM controller found in Renesas
> +         RZ/V2M like chips through the PWM API.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called pwm-rzv2m.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..cf5a4a1c3b1a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> +obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c
> new file mode 100644
> index 000000000000..eb9062293590
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzv2m.c
> @@ -0,0 +1,480 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/V2M PWM Timer (PWM) driver
> + *
> + * Copyright (C) 2024 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardwar=
e?language=3Den
> + *
> + * Limitations:
> + * - Changes to the duty cycle configuration get effective only after th=
e next
> + *   period end.
> +=A0* - The duty cycle can be changed only by modifying the PWMLOW regist=
er
> +=A0* =A0 value and changing the pulse width at low level. The duty cycle=
 becomes
> +=A0* =A0 0% for the low width when the value of the PWMLOW register is 0=
x0h
> +=A0* =A0 and 100% for the low width when the value of the PWMLOW > PWMCY=
C.

If polarity or period is changed, the hardware has to be stopped, to
this yields glitches.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/math64.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
> +#define RZV2M_PWMCTR	0x0
> +#define RZV2M_PWMCYC	0x4
> +#define RZV2M_PWMLOW	0x8
> +#define RZV2M_PWMCNT	0xc
> +
> +#define RZV2M_PWMCTR_PWMPS	GENMASK(17, 16)
> +#define RZV2M_PWMCTR_PWMHL	BIT(3)
> +#define RZV2M_PWMCTR_PWMTM	BIT(2)
> +#define RZV2M_PWMCTR_PWME	BIT(1)
> +
> +#define RZV2M_PWMCYC_PERIOD	GENMASK(23, 0)
> +#define RZV2M_PWMLOW_PERIOD	GENMASK(23, 0)
> +
> +struct rzv2m_pwm_chip {
> +	u64 max_period;
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *apb_clk;
> +	struct clk *pwm_clk;
> +	unsigned long rate;
> +	unsigned long delay;
> +	unsigned long pwm_cyc;
> +	enum pwm_polarity polarity;
> +	bool is_ch_enabled;
> +};
> +
> +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u6=
4 c)
> +{
> +	u64 ab =3D a * b;

a * b might overflow?!

> +	u64 d =3D div64_u64(ab, c);
> +	u64 e =3D d * c;
> +
> +	return d + ((ab - e) ? 1 : 0);
> +}
> +
> +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_rounddown(u64 a, u64 b, =
u64 c)
> +{
> +	return div64_u64(a * b, c);

ditto. This is the same function as mul_u64_u64_div_u64() isn't it?

> +}
> +
> +static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct pwm_chip *=
chip)
> +{
> +	return container_of(chip, struct rzv2m_pwm_chip, chip);
> +}
> +
> +static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	/* delay timer when change the setting register */
> +	ndelay(rzv2m_pwm->delay);
> +}
> +
> +static void rzv2m_pwm_write(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg, u=
32 data)
> +{
> +	writel(data, rzv2m_pwm->mmio + reg);
> +}
> +
> +static u32 rzv2m_pwm_read(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg)
> +{
> +	return readl(rzv2m_pwm->mmio + reg);
> +}
> +
> +static void rzv2m_pwm_modify(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg, =
u32 clr,
> +			     u32 set)
> +{
> +	rzv2m_pwm_write(rzv2m_pwm, reg,
> +			(rzv2m_pwm_read(rzv2m_pwm, reg) & ~clr) | set);
> +}
> +
> +static u8 rzv2m_pwm_calculate_prescale(struct rzv2m_pwm_chip *rzv2m_pwm,
> +				       u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 24;
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 3) / 4;
> +
> +	return prescale;
> +}
> +
> +static inline int rzv2m_pwm_prescale_to_shift(u8 prescale)
> +{
> +	return prescale =3D=3D 3 ? 11 : prescale * 4;
> +}
> +
> +static int rzv2m_pwm_enable(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> +			 RZV2M_PWMCTR_PWME);
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +	rzv2m_pwm->is_ch_enabled =3D true;
> +
> +	return 0;
> +}
> +
> +static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm)
> +{
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
> +	rzv2m_pwm->is_ch_enabled =3D false;
> +}
> +
> +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	u16 frequency_divisor;
> +	u32 ctr, cyc, low;
> +	u8 prescale;
> +
> +	pm_runtime_get_sync(chip->dev);
> +	ctr =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, ctr);
> +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, ctr) ?
> +		PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, ctr);
> +	frequency_divisor =3D 1 << rzv2m_pwm_prescale_to_shift(prescale);

Giving a shift is cheaper than a multiplication, I suggest to do

	frequency_divisor =3D rzv2m_pwm_prescale_to_shift(prescale);

and instead of multiply by frequency_divisor, use a left-shift
operation.

> +	cyc =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> +	state->period =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1,
> +				NSEC_PER_SEC * frequency_divisor,
> +				rzv2m_pwm->rate);
> +
> +	low =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> +	state->duty_cycle =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1 - l=
ow,
> +				NSEC_PER_SEC * frequency_divisor,
> +				rzv2m_pwm->rate);

The register semantic makes me wonder if each period starts with the low
part. In that case the hardware called "normal" what is called inverted
in the pwm framework?!

> +	return pm_runtime_put(chip->dev);

If you evaluate the return value of pm_runtime_put() maybe check
pm_runtime_get_sync() for symmetry, too?

> +}
> +
> +static int rzv2m_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> +	u64 period =3D state->period, duty_cycle =3D state->duty_cycle;
> +	u16 frequency_divisor;
> +	u64 pwm_cyc, pwm_low;
> +	u8 prescale;
> +	u32 pwm_ctr;
> +
> +	/*
> +	 * Clamp period and duty cycle to their maximum values for our current
> +	 * configuration rather than letting our calculations overflow.
> +	 */
> +	if (period > rzv2m_pwm->max_period) {
> +		period =3D rzv2m_pwm->max_period;
> +		if (duty_cycle > rzv2m_pwm->max_period)
> +			duty_cycle =3D period;
> +	}
> +
> +	/*
> +	 * Formula for calculating PWM Cycle Setting Register:
> +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =D7 Div ratio)) =
- 1
> +	 */
> +	pwm_cyc =3D rzv2m_pwm_mul_u64_u64_div_u64_rounddown(period,
> +							  rzv2m_pwm->rate,
> +							  NSEC_PER_SEC);
> +	pwm_cyc =3D pwm_cyc ? pwm_cyc : 1;

if pwm_cyc is 0 here, the period is too short to be realized, right?
That's an error condition.

> +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pwm_cyc - 1);
> +	frequency_divisor =3D 1 << rzv2m_pwm_prescale_to_shift(prescale);
> +	if (frequency_divisor > 1) {
> +		pwm_cyc =3D rzv2m_pwm_mul_u64_u64_div_u64_rounddown(period,
> +				rzv2m_pwm->rate,
> +				NSEC_PER_SEC * frequency_divisor);
> +		pwm_cyc =3D pwm_cyc ? pwm_cyc : 1;
> +	}
> +
> +	if (pwm_cyc && !FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc - 1))
> +		pwm_cyc =3D RZV2M_PWMCYC_PERIOD + 1;

I don't understand the relevance of FIELD_FIT(RZV2M_PWMCYC_PERIOD,
pwm_cyc - 1).

> +
> +	/*
> +	 * Formula for calculating PWMLOW register:
> +	 * PWMLOW register =3D PWM cycle * Low pulse width ratio (%)
> +	 */
> +	pwm_low =3D rzv2m_pwm_mul_u64_u64_div_u64_rounddown(duty_cycle,
> +			rzv2m_pwm->rate, NSEC_PER_SEC * frequency_divisor);
> +
> +	pwm_low =3D pwm_cyc - pwm_low;

Either the old or the new value of pwm_low doesn't match the variable's
name. Please add another variable for the wrong one. The compiler should
optimize that out and the reader can more easily understand the code.

> +	if (!FIELD_FIT(RZV2M_PWMLOW_PERIOD, pwm_low))
> +		pwm_low =3D RZV2M_PWMLOW_PERIOD;
> +
> +	pwm_cyc--;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(rzv2m_pwm->chip.dev);
> +
> +	/*
> +	 * To change the setting value of the PWM cycle setting register
> +	 * (PWMm_PWMCYC) or polarity, set the PWME bit of the PWM control
> +	 * register (PWMm_PWMCTR) to 0b and stop the counter operation.
> +	 */
> +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=3D=
 pwm_cyc) {
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> +		rzv2m_pwm_wait_delay(rzv2m_pwm);
> +	}
> +
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> +
> +	pwm_ctr =3D FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale);
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pwm_ctr |=3D RZV2M_PWMCTR_PWMHL;
> +
> +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM |
> +			 RZV2M_PWMCTR_PWMPS | RZV2M_PWMCTR_PWMHL, pwm_ctr);
> +
> +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=3D=
 pwm_cyc) {
> +		rzv2m_pwm->polarity =3D state->polarity;
> +		rzv2m_pwm->pwm_cyc =3D pwm_cyc;
> +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> +				 RZV2M_PWMCTR_PWME);
> +	}
> +
> +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(rzv2m_pwm->chip.dev);
> +
> +	return 0;
> +}
> [...]
> +static int rzv2m_pwm_probe(struct platform_device *pdev)
> +{
> +	struct rzv2m_pwm_chip *rzv2m_pwm;
> +	unsigned long apb_clk_rate;
> +	int ret;
> +
> +	rzv2m_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2m_pwm), GFP_KERNEL);
> +	if (!rzv2m_pwm)
> +		return -ENOMEM;
> +
> +	rzv2m_pwm->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzv2m_pwm->mmio))
> +		return PTR_ERR(rzv2m_pwm->mmio);
> +
> +	rzv2m_pwm->apb_clk =3D devm_clk_get(&pdev->dev, "apb");
> +	if (IS_ERR(rzv2m_pwm->apb_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->apb_clk),
> +				     "cannot get apb clock\n");
> +
> +	rzv2m_pwm->pwm_clk =3D devm_clk_get(&pdev->dev, "pwm");
> +	if (IS_ERR(rzv2m_pwm->pwm_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->pwm_clk),
> +				     "cannot get pwm clock\n");
> +
> +	rzv2m_pwm->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(rzv2m_pwm->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->rstc),
> +				     "get reset failed\n");
> +
> +	platform_set_drvdata(pdev, rzv2m_pwm);
> +	ret =3D reset_control_deassert(rzv2m_pwm->rstc);
> +	if (ret) {
> +		return dev_err_probe(&pdev->dev, ret,
> +			      "cannot deassert reset control\n");
> +	}
> +
> +	ret =3D clk_prepare_enable(rzv2m_pwm->apb_clk);
> +	if (ret < 0)
> +		goto err_reset;
> +
> +	ret =3D clk_prepare_enable(rzv2m_pwm->pwm_clk);
> +	if (ret < 0)
> +		goto disable_apb_clk;
> +
> +	clk_rate_exclusive_get(rzv2m_pwm->apb_clk);

There is a devm_clk_rate_exclusive_get() in next starting from tomorrow
I hope. Using it should simplify the driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ork2vse6yp64f2pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXgs+cACgkQj4D7WH0S
/k5adggAk72YKVAs/kpMdxZTx4SIFW+N3cyZpyJN3daTXM7X36b3+zTwj4Ler+iW
zvo1nN+7pxyni90yuVJDqNjci4iTepIwbXuhj6OOGTPXBVl98skGTIxaWhdEWkh8
ku3ZseSQfPum0HwrkecL1DwLdqtl9I9ptyDg0rnPOXR8sieHDBKuYOzTfDE+9ybi
pePROYEA4w1y5ndyTeFtpLo8rPh2NqgCBePsAtv17MiAUsFMSfcv7a8edDahYoTz
ZqAPAbgJwUtmjexSclYKGdCqsD0n85sXrLYzWbt4VnglzlEw76O1NX2nKRIpVUjp
f9gPQXYuQEVFnXB/yqTcUKRpOCFrMw==
=Bxjk
-----END PGP SIGNATURE-----

--ork2vse6yp64f2pa--

