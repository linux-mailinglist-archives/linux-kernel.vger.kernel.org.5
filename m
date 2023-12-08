Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0615C80A8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574053AbjLHQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjLHQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:29:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CADE199D;
        Fri,  8 Dec 2023 08:29:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1e7971db2aso257360566b.3;
        Fri, 08 Dec 2023 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702052997; x=1702657797; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiBsF6D5ZYEUJwOeHckOEGR0L5lUF+YuBZzP+zur5mg=;
        b=lPMDMsjNcTSdeIGtAER/fJm4b0PF/8S+ZE0jlHOR+60Fds/WynQlx2FYpqD/LU0CCC
         HkRVTTiX3n+o4cI0UrrqlEYp/q2pxxwoFidzL9/Omr2HMymtrwzBaVjEnQcCymsgDspz
         1uDSRR/BpcSbGsHx6TqTFJU/7JtXBxL0/B3SVyjI0kT/5t+t57wxv2OZ3+zG1FIi+a2p
         ST3kX2o6OK8FEfajNZa9j2HD0CbDLDO0PW+qF/RaIOQPE9AjrSYmxJfw8zeSZknKUnE/
         zhU6vfFVViL9WueJgqX4inOSZswN0+NZApMa2O4+WGEYM3ovJzuYbfsF2Z6HGf61qEwP
         6npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052997; x=1702657797;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiBsF6D5ZYEUJwOeHckOEGR0L5lUF+YuBZzP+zur5mg=;
        b=PfYZtWQIJ31JLBa8o4XBOFb9YNO4BST4R+uyr+W0YEineWuDnzUEshmuYuCuUwpy1B
         Wh3NWOGDdtKvi1rK2As9GeCV0zW3R3Ys2nwEHd5pfX1YdprFqsOEJzyU1MNXDQ7IJp9T
         kY1EJ3b5co2nrADDewCif5+dQcysBEyIxG4R7T/OoC0PaUgUct89Vcw2rFONrUs6yAE9
         kQ+JJM/0WJi6s3m+L2ZoEqOrWK1VYYqiVqHmiNh6VzosU33IPXS54wj1azGOneJONLkK
         MWF8sgjIdxAUihiNHVf9RqjJy+y1gGDKWwdSvNBrXe3N26P6xGtfQGLZ8Ppzg08z4y+z
         SaUw==
X-Gm-Message-State: AOJu0Yyv2l6ScosUps+rDWlhs7v0ANNrr46FARlSmwRnakOqKxeimpb8
        xPPzAWoBsS4wBArC7bn6RT8=
X-Google-Smtp-Source: AGHT+IE+njVM1fF9X7EOT+apf46J2+vGmRje/1dygbwe7z0iC14XcXfA48VWpabUKLdviP1zXhn8Og==
X-Received: by 2002:a17:906:7484:b0:9d4:2080:61dc with SMTP id e4-20020a170906748400b009d4208061dcmr97639ejl.22.1702052997275;
        Fri, 08 Dec 2023 08:29:57 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1ca6f5f189sm1191269ejc.179.2023.12.08.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:29:56 -0800 (PST)
Date:   Fri, 8 Dec 2023 17:29:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZXNEg3ax4MChSJ5A@orome.fritz.box>
References: <cover.1701248996.git.sean@mess.org>
 <88fdb3a200989458c6f95c26fa9bb84c1e864798.1701248996.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yblp1b8ERDinDWmD"
Content-Disposition: inline
In-Reply-To: <88fdb3a200989458c6f95c26fa9bb84c1e864798.1701248996.git.sean@mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yblp1b8ERDinDWmD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 09:13:37AM +0000, Sean Young wrote:
> This makes the generated IR much more precise. Before this change, the
> driver is unreliable and many users opted to use gpio-ir-tx instead.
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index cf51e2760975..8575c4596d7b 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -10,6 +10,8 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/hrtimer.h>
> +#include <linux/completion.h>
>  #include <media/rc-core.h>
> =20
>  #define DRIVER_NAME	"pwm-ir-tx"
> @@ -17,8 +19,14 @@
> =20
>  struct pwm_ir {
>  	struct pwm_device *pwm;
> -	unsigned int carrier;
> -	unsigned int duty_cycle;
> +	struct hrtimer timer;
> +	struct completion tx_done;
> +	struct pwm_state *state;
> +	u32 carrier;
> +	u32 duty_cycle;
> +	uint *txbuf;

Maybe mark this as const to signal that it's not going to get modified?

> +	uint txbuf_len;
> +	uint txbuf_index;

uint is rather rare. Or so I thought. There seem to be quite a few
occurrences throughout the kernel. I'd still prefer unsigned int over
this abbreviated form, but ultimately up to you and Mauro to decide.

>  };
> =20
>  static const struct of_device_id pwm_ir_of_match[] =3D {
> @@ -82,6 +90,62 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int =
*txbuf,
>  	return count;
>  }
> =20
> +static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned int *txbuf,
> +			    unsigned int count)
> +{
> +	struct pwm_ir *pwm_ir =3D dev->priv;
> +	struct pwm_device *pwm =3D pwm_ir->pwm;
> +	struct pwm_state state;
> +
> +	pwm_init_state(pwm, &state);
> +
> +	state.period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> +	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> +
> +	pwm_ir->txbuf =3D txbuf;
> +	pwm_ir->txbuf_len =3D count;
> +	pwm_ir->txbuf_index =3D 0;
> +	pwm_ir->state =3D &state;
> +
> +	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
> +
> +	wait_for_completion(&pwm_ir->tx_done);
> +
> +	return count;
> +}
> +
> +static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
> +{
> +	struct pwm_ir *pwm_ir =3D container_of(timer, struct pwm_ir, timer);
> +	ktime_t now;
> +
> +	/*
> +	 * If we happen to hit an odd latency spike, loop through the
> +	 * pulses until we catch up.
> +	 */
> +	do {
> +		u64 ns;
> +
> +		pwm_ir->state->enabled =3D !(pwm_ir->txbuf_index % 2);
> +		pwm_apply_atomic(pwm_ir->pwm, pwm_ir->state);
> +
> +		if (pwm_ir->txbuf_index >=3D pwm_ir->txbuf_len) {
> +			complete(&pwm_ir->tx_done);
> +
> +			return HRTIMER_NORESTART;
> +		}
> +
> +		ns =3D US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
> +		hrtimer_add_expires_ns(timer, ns);
> +
> +		pwm_ir->txbuf_index++;
> +
> +		now =3D timer->base->get_time();
> +	} while (hrtimer_get_expires_tv64(timer) < now);
> +
> +	return HRTIMER_RESTART;
> +}
> +
>  static int pwm_ir_probe(struct platform_device *pdev)
>  {
>  	struct pwm_ir *pwm_ir;
> @@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pde=
v)
>  	if (!rcdev)
>  		return -ENOMEM;
> =20
> +	if (pwm_is_atomic(pwm_ir->pwm)) {
> +		init_completion(&pwm_ir->tx_done);
> +		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		pwm_ir->timer.function =3D pwm_ir_timer;
> +		rcdev->tx_ir =3D pwm_ir_tx_atomic;
> +	} else {
> +		dev_info(&pdev->dev, "tx will not be accurate as pwm device does not s=
upport atomic mode");

s/tx/TX and s/pwm/PWM/? Also, I'm a bit unhappy about "atomic mode" here
because the term is overloaded in PWM. If you call pwm_appy_*() then by
definition it's going to be "atomic" in the "atomic state" sense. So
maybe switch to something like:

	"TX will not be accurate as PWM device might sleep"

?

Thierry

--Yblp1b8ERDinDWmD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVzRIMACgkQ3SOs138+
s6Hm9A//Xk/Ax5Tr6GG4g93ovKwf9aILijyg9sraVXVqaJD55fZ0ObhBlY7xSvMv
t0+DWflHIYFCgFIlsxtScqG0PrpGkoQI4valJzuyR+dKn3TSD8tCrLeVAP5pOTLL
X88YQXo7Qu/J4F58/mSE5YPB5ut9cBtC2ViDpoNB3rPnfpvl1CQ5QnTKdr8iRnYB
GiJCRKQkG8v0c69a0nNftVF9ujE0fMhysW+ULc8d7U8iSU7CMcQrr8nPKj+K2UR8
3qvyLxd/0Irzkvn5Fu8ziWW2aFEsldfWZ9bYyBYGbpDJ2h4a6tRs4s7YJGWIOBM1
+DkOzkY5ZJnBjIUMHBQ6zyD31PklKxDAVNcvD1rpruRXooHDpWWh/wavvK7JInxa
/bTcvjKl88+dQFrXzGM6Yt5cdB/iuvZ/QvN1dc1oyZEOPK2k0SaEX5S1X8QsrK4+
f4q2BrkDViyK2PP6q/wCZTTQAOtNVwN/3nWRDEKd/FeJ7KzU75f5qzOFJTMHBio3
v26mVcr4cx2woBxfW7pBL6wM+Vt86uRWvdGhQf6vQQcZw3G2DQLOg/QZM13bR41f
gNH6FMeDKV4gPSMMLybID/60mGUC6movGKjaiHUfUDUiUlzHi7o7nJByiIw+GEQh
t+DDJ3KmHMXJJFjxbJB6rqW4L9sj2ie+QuO3cyiJ294Hdbpu87c=
=UtpU
-----END PGP SIGNATURE-----

--Yblp1b8ERDinDWmD--
