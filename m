Return-Path: <linux-kernel+bounces-46522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4F8440E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97672840B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1697F498;
	Wed, 31 Jan 2024 13:42:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72576762CD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708539; cv=none; b=ZDuBFqlQ57+it5I59XIghNAYBxzTtp4WLh7bnSOfuPADJePxZtE4umyBk58LWd8iiSU/Q5KD8H+4pAmUx02k63rz5+nDRn7W4whkHkLj5qsx+taQx627cj4wJquoZ/HSEWykfo2aRfxEfYwcN9O7q6RT8ZD+jEpB4KmBFbLAEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708539; c=relaxed/simple;
	bh=8FInsLgoFCZG8DOXI+LB/CtHOBA/FQrXnVs/H9H+9L0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EshjbVcOF9wVdikWuOdTKHPFqV4MuTv9VSGwHXkL57nyRVOtzfJfP9rY8F7/x3fLrzBwpM/cAMVOenGuuE5OkbaGnGH0vbRvmLXCjXihwQb9JBAIlq5s1lAEcx3odnm6BKAWtiIo/tmg5V1c29QnrqUAsC9vTYGs2mmYV+1mr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rVAqb-0003wn-BI; Wed, 31 Jan 2024 14:41:49 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rVAqY-003e3x-Ln; Wed, 31 Jan 2024 14:41:46 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rVAqT-0008vC-1l;
	Wed, 31 Jan 2024 14:41:41 +0100
Message-ID: <8dd1fe2d040db3e79ef94a5b2c70c51108e56c39.camel@pengutronix.de>
Subject: Re: [PATCH v8 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rob
 Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>,  John Watts <contact@jookia.org>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-riscv@lists.infradead.org
Date: Wed, 31 Jan 2024 14:41:41 +0100
In-Reply-To: <20240131125920.2879433-3-privatesub2@gmail.com>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
	 <20240131125920.2879433-3-privatesub2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-01-31 at 15:59 +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
>=20
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.
>=20
> Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 380 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 391 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
>=20
[...]
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..19bf3f495155
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,380 @@
[...]
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	sun20i_chip->rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL)=
;
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
> +
> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(sun20i_chip->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");

Consider using devm_add_action_or_reset() to automatically assert the
reset control again on error or driver unbind ...

> +
> +	sun20i_chip->chip.dev =3D &pdev->dev;
> +	sun20i_chip->chip.ops =3D &sun20i_pwm_ops;
> +
> +	mutex_init(&sun20i_chip->mutex);
> +
> +	ret =3D pwmchip_add(&sun20i_chip->chip);

.. and devm_pwmchip_add() here. Together, this would allow to drop
sun20i_pwm_remove().


regards
Philipp

