Return-Path: <linux-kernel+bounces-39694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229983D4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF49B21193
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F61B297;
	Fri, 26 Jan 2024 07:20:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E31AAC4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253622; cv=none; b=S8jfYabQdMJvl40Xq/Il8IrdmMtVkusKk1tJuTX+bkbhD6diPBzdB2+jnnhEbEb/dRGUBh56EX/ku0mea3iD40wNNU1/FIEv3LMKRM5mPs67/tBCIsN2WvE/FJqS6JpPAFS1yGFQwb7gqf/S0SXtmJQHN4YMhcQH2gRHIj/5QJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253622; c=relaxed/simple;
	bh=2MlIvEb5ti15ByVLn0Sx8MbSa5UY7PBvuWGN5H1F15g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdbQ3vOgsh+Z6TZB1FikpuHTZLGh7rN8k8+o87NRVz5/dUsBLfleEta5YIFgB5tUEnTF5BG196CsrVUedTwnQAXrxrQkAllhITT1Elusm7M1KboLfVt9QDF4rjTCdbP7NEJABlBEiqXS40tfRblAuwuUtIAA/bmYzmFlQokZPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTGVU-0000h3-J6; Fri, 26 Jan 2024 08:20:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTGVJ-002SaA-Ok; Fri, 26 Jan 2024 08:19:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTGVJ-008SOJ-2A;
	Fri, 26 Jan 2024 08:19:57 +0100
Date: Fri, 26 Jan 2024 08:19:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, zhaochen su <zhaochen.su29@gmail.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH 1/6] pwm: sprd: Add support for UMS9620
Message-ID: <bvnhi4qeczrmlmaog6drlztg4x6ubozjzu57sukpejme7xecqc@724g62vjgxrq>
References: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
 <20240122081754.17058-2-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hmfj7udr3e3yp5w"
Content-Disposition: inline
In-Reply-To: <20240122081754.17058-2-Wenhua.Lin@unisoc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6hmfj7udr3e3yp5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:17:49PM +0800, Wenhua Lin wrote:
> The PMW unit on the current Unisoc's SoCs has 4 channels but has different
> address offsets. On UMS512, they are 0x0, 0x20, 0x40, 0x60 respectively,
> while are 0x0, 0x4000, 0x8000, 0xC000 on UMS9620.
>=20
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/pwm/pwm-sprd.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index 77939e161006..bc1e3ed13528 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -9,6 +9,7 @@
>  #include <linux/math64.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> =20
> @@ -23,7 +24,6 @@
>  #define SPRD_PWM_ENABLE_BIT	BIT(0)
> =20
>  #define SPRD_PWM_CHN_NUM	4
> -#define SPRD_PWM_REGS_SHIFT	5
>  #define SPRD_PWM_CHN_CLKS_NUM	2
>  #define SPRD_PWM_CHN_OUTPUT_CLK	1
> =20
> @@ -32,14 +32,27 @@ struct sprd_pwm_chn {
>  	u32 clk_rate;
>  };
> =20
> +struct sprd_pwm_data {
> +	int reg_shift;
> +};
> +
>  struct sprd_pwm_chip {
>  	void __iomem *base;
>  	struct device *dev;
>  	struct pwm_chip chip;
> +	const struct sprd_pwm_data *pdata;
>  	int num_pwms;
>  	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
>  };
> =20
> +static const struct sprd_pwm_data ums512_data =3D {
> +	.reg_shift =3D 5,
> +};
> +
> +static const struct sprd_pwm_data ums9620_data =3D {
> +	.reg_shift =3D 14,
> +};
> +
>  static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *=
chip)
>  {
>  	return container_of(chip, struct sprd_pwm_chip, chip);
> @@ -58,7 +71,7 @@ static const char * const sprd_pwm_clks[] =3D {
> =20
>  static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32 hwid, u32 reg)
>  {
> -	u32 offset =3D reg + (hwid << SPRD_PWM_REGS_SHIFT);
> +	u32 offset =3D reg + (hwid << spc->pdata->reg_shift);
> =20
>  	return readl_relaxed(spc->base + offset);
>  }
> @@ -66,7 +79,7 @@ static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32=
 hwid, u32 reg)
>  static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
>  			   u32 reg, u32 val)
>  {
> -	u32 offset =3D reg + (hwid << SPRD_PWM_REGS_SHIFT);
> +	u32 offset =3D reg + (hwid << spc->pdata->reg_shift);
> =20
>  	writel_relaxed(val, spc->base + offset);
>  }
> @@ -253,6 +266,7 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *sp=
c)
>  static int sprd_pwm_probe(struct platform_device *pdev)
>  {
>  	struct sprd_pwm_chip *spc;
> +	const void *priv;

This can better be of type struct sprd_pwm_data *. Also pdata would be a
better name.

>  	int ret;
> =20
>  	spc =3D devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
> @@ -263,6 +277,11 @@ static int sprd_pwm_probe(struct platform_device *pd=
ev)
>  	if (IS_ERR(spc->base))
>  		return PTR_ERR(spc->base);
> =20
> +	priv =3D of_device_get_match_data(&pdev->dev);
> +	if (!priv)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "get regs shift failed!\n");
> +	spc->pdata =3D priv;
> +
>  	spc->dev =3D &pdev->dev;
> =20
>  	ret =3D sprd_pwm_clk_init(spc);
> @@ -281,7 +300,8 @@ static int sprd_pwm_probe(struct platform_device *pde=
v)
>  }
> =20
>  static const struct of_device_id sprd_pwm_of_match[] =3D {
> -	{ .compatible =3D "sprd,ums512-pwm", },
> +	{ .compatible =3D "sprd,ums512-pwm",	.data =3D (void *)&ums512_data},
> +	{ .compatible =3D "sprd,ums9620-pwm",	.data =3D (void *)&ums9620_data},

Please use one line per assignment. Do you really need the cast to void
*?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6hmfj7udr3e3yp5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWzXRYACgkQj4D7WH0S
/k4JmwgAkLH4Y8EJskrxYs0xavniF70Hm1Dr48Cp50Of6D25lfLnkXou+9JXjJT1
OaJLTED1r8yDO4rPT58QOeEF1L58RpMtrqjG7FJfA3cBf/NX4cEDT9i81zVL1je+
c2sZj01cx8X1dkeuSZtkKNXcWRI/yQV1PH/r3XDzwxIwNxbpQEwt1PRpu0C1U2qm
ONlTDLpZZSaEJV7HfH24WCnrco/jR6G8n4QImLzyvV8FAOGV6+GqYPvXu7fJ4Aop
zxGGb0keN8BmuCDWP+NfnxrsRg7IReowVY2g1uQtTNAczmh/tqVmJv6RZmB/6kdR
HjRy/yHKEM27bM6tQwnhc6gv/9ZgDw==
=/S+R
-----END PGP SIGNATURE-----

--6hmfj7udr3e3yp5w--

