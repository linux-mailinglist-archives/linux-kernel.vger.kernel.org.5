Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7F75B217
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjGTPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGTPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:12:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B2BB;
        Thu, 20 Jul 2023 08:12:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-992b66e5affso154365766b.3;
        Thu, 20 Jul 2023 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689865953; x=1690470753;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFJEJfVpFk5Mke3XMuIT34mqSQARKV4kKBwK8j2IXu4=;
        b=iq//Lmxn0r2gu7Cu5waSz+pH9vobIOPBQMyTT28JnY5/ZO0l2Qj5h17BHFgbuXGkms
         29t5IZdweRiOTsKkM5PqybqWW2LaKt8Bi8j971lAKEwl0KJzUtzC/7oGrWfa4iTi0J8K
         zfkX5mf3hSSKy4tiAzUUsWLbhIJjtzX5bXrS45S5cDnl5c1TEYybPp7/BkbkBFcfXnoy
         BJNTjM9W7wx0hNAWt2hDjWf3pK52alnl92WiU8HWKeOjEDWXa/MWQJru40vl5ZxaEFnw
         h3g3iUgZahcv4vrK1HvUdTQu5XkMKqCw/Hh6AvQOGfkeX8UN64twJsPXtXVbqYzF/jQr
         9MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865953; x=1690470753;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFJEJfVpFk5Mke3XMuIT34mqSQARKV4kKBwK8j2IXu4=;
        b=GS5rQS9JYcKy0TXkAFW+d5FYB0AAqN4eEWqsNX9R0J96hYxLYn12aC32/ElFAdgmX5
         YZv/lRGx7U09af89jtdH3svDKecn609IicBTP9+hxlZCfT18utyKKPXDerOR33TsJr7E
         A7nbOHvjD28gJdCUrum98jQGb5/2OfHIEctwSG+pz9JxOVeAWpj0VujHKktMVZ0TIlTP
         8chVpOhDuC/Zou6aOzEWogw5ixCJ1ud6QS7tzhb34OmhT8IjQlAjr69X2DbHwDTVeUYi
         iTGrsFJBG2wyU1ntSuoC8xd4FCt842j1lCVsTOacS+qXA2Mq5hS0bjr4d99E5Y7Wvm6t
         bL1A==
X-Gm-Message-State: ABy/qLaCWgHADFZRIjRBxDRE05gn9TzdHZpYYCMbvLReQp4aKGd5uEWo
        LPMiw+DU5jmVAqnRBZr0SNo=
X-Google-Smtp-Source: APBJJlFDh+w+xf9IZzvxaRzdPrj0Y6oiFfDzO7UfaVC8mmJSJpVvkRyLEbSsSDeUi3lSfKUpnkHeTw==
X-Received: by 2002:a17:906:2403:b0:98e:1484:5954 with SMTP id z3-20020a170906240300b0098e14845954mr4747361eja.71.1689865952675;
        Thu, 20 Jul 2023 08:12:32 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b0098e2eaec394sm837966ejq.101.2023.07.20.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:12:32 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:12:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     claudiu.beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <ZLlO3vGr-ECdnmKA@orome>
References: <20230716020652.18557-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="04hiCDAIozMFNoR9"
Content-Disposition: inline
In-Reply-To: <20230716020652.18557-1-aarongt.shen@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--04hiCDAIozMFNoR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 16, 2023 at 10:06:52AM +0800, Guiting Shen wrote:
> The driver would never call clk_enable() if the PWM channel was already
> enabled in bootloader which lead to dump the warning message "the PWM
> clock already disabled" when turning off the PWM channel.
>=20
> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
> the PWM channel was already enabled in bootloader.
>=20
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 47 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index cdbc23649032..fc89282db645 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -36,7 +36,7 @@
>  #define PWM_SR			0x0C
>  #define PWM_ISR			0x1C
>  /* Bit field in SR */
> -#define PWM_SR_ALL_CH_ON	0x0F
> +#define PWM_SR_ALL_CH_MASK	0x0F
> =20
>  /* The following register is PWM channel related registers */
>  #define PWM_CH_REG_OFFSET	0x200
> @@ -464,6 +464,42 @@ static const struct of_device_id atmel_pwm_dt_ids[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
> =20
> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, =
bool on)
> +{
> +	unsigned int i, cnt =3D 0;
> +	int ret =3D 0;
> +	u32 sr;
> +
> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
> +	if (!sr)
> +		return 0;
> +
> +	cnt =3D bitmap_weight((unsigned long *)&sr, atmel_pwm->chip.npwm);

Tiny nit here: not sure if that cast is safe to do. You've got a 32-bit
variable, but if you cast &sr to unsigned long * on a 64-bit machine it
would cause hweight64() to get called and that would then read 64 bits
=66rom a 32-bit variable. This probably works most of the time because we
don't read any of the upper bits, but it is strictly an illegal access
and could be unaligned as well.

Should we just turn sr into an unsigned long to be safe here? No need to
resend, I can make that change when I apply.

Thierry

--04hiCDAIozMFNoR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS5Tt4ACgkQ3SOs138+
s6Eyyg/+IrDQoD75AWJiosESNAMWjiyDEFKB6A6+L49742LeepmeKIDeRBIe/Kmt
xxg6Ysa36q22YLb91dSMHk8fGJiDyYWz29H7WBSM64o9nrDEEr7cBOMEQDCl1pA9
AHbAseMMd3RgGWzWu8WwZUrI8sTUBviqTBRi5uKgKap9+PwUZV1SF4ffVHIXiXxF
M8K763aA7TxtS36IPRJdHO7g+FL0X/IRG7+7CpAk7AIYJCApuTlyQkSEqLJbgkG3
lyT5UK+wCToazgLIAQX2M79zQOqOmyu5xiNUC40XdEZxb1GCmVy/ey47cPp76+JE
m/zhEJurS+kxBZgmHik9wSngo1YU3EbHsyrwDc1FPJcGsCmmA8xA+m1UYujEYUzU
+eOaw8a8zZICXDsWwx/q3P+E0tOPVV9jIqg59gKfLu/l/gaP5tU7VMdTjM1ETVNh
LX9NQtc6wt4w9iryjJKvs4ItQ4oxRVK+PNVwHGn7GM9koeeEozan1QHLcj8u4G3H
mJQTPd6uSKzkw5hgOWY4DRO+38sAZx/9v+1HaGg6hPsufGGYVU7+Q/U77PsHBuJF
c/CCQ4y5zBREWpslBVT/I7hfmULQgC2jMP7A+xbUUy0ymquTXM77vtdkm5QiZ2bL
GTpTK82piENd9PQWFzLbjgYbJ33LhlTdRbLtGqwndFEBpC9myxE=
=DeRZ
-----END PGP SIGNATURE-----

--04hiCDAIozMFNoR9--
