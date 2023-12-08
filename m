Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF280A89F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjLHQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:19:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6722719A8;
        Fri,  8 Dec 2023 08:19:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1e116f2072so483540966b.0;
        Fri, 08 Dec 2023 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702052395; x=1702657195; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5gJtImNxlCwSGryhwwqe0ZjUJP3xRvdUrcpjzHsJYg=;
        b=hiezoSPf0m2V91ZD89/gEND807+4IIhzdu/fBLzGNcwxbB2BCrKzQADdOERzRYReds
         vVR6cRmkjReAFjgMYaiRm1HaHRnxhZfmSPqCgh02/k7svTi/knoQU/P57ZGxBu3T82HM
         RvGR3d38lMUr9wHaO7nrs6hNwMdrXOuBg4hl1V8+jRc/Og4eksx1BbGSnI+aYC8fClMw
         gz6KhTy4SI0yroyBPVI6JNcVwEA2/mFGzd82Zj3LJAlrmAq12i9c3S7ZG5MIsJ2xRgMb
         BhQPXAD8gQEfZFU2ICGM81kyGBxNpB5ICccHvAs7HHOjTTOEVoHzWdwIuBRk8ZjUw7MT
         g+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052395; x=1702657195;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5gJtImNxlCwSGryhwwqe0ZjUJP3xRvdUrcpjzHsJYg=;
        b=IUNat4kKJ3xA0DBJNLrrGt1RfmNcp0Kzoc+JS6qJi4WzGEznzRpoO2mhm0tG5zlJWa
         wwGZALeEaH3DZZPTFk/Avh29J4QxF5W441ZoN/rOBnS+kG4jBeg5A1eD5i5vOvBPrMnK
         KyhMRFMNvjTQS/wO4/W6AJ+OiG5UJaeDd32UBw/NWl9JQbQKO3lV+p9PPPV9UcesMyiy
         9PUpsZ3MUhEH4lDImmSF10QwPph59Zn/Y/4hwTq5CUI/dzfpmJ71PGt7a0eVkVYpK3y5
         zW92TnBqP3HjGSQ6KMOTZjIEUnplIwaz8q9lbxQTe+tGXHycCFsZct8Q+6G1omaHqiWo
         YI5A==
X-Gm-Message-State: AOJu0YxyGt2MxlMc0Co99uB9nWmfSStyJSBlSgZvzqv5Lq61PIc9Ab2J
        a3znecoKETomldHQ29iZmz4bexR+yEo=
X-Google-Smtp-Source: AGHT+IH4ByXWeMk6eIo6kBHITU/eE6N8E3I1JNUhV78wHWbUntI6aTS2EHwbiqN3sUZ44sTj6dvHWA==
X-Received: by 2002:a17:906:2209:b0:a00:ab1a:c81 with SMTP id s9-20020a170906220900b00a00ab1a0c81mr385767ejs.22.1702052394376;
        Fri, 08 Dec 2023 08:19:54 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ub14-20020a170907c80e00b00a1da5d9a602sm1160461ejc.138.2023.12.08.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:19:53 -0800 (PST)
Date:   Fri, 8 Dec 2023 17:19:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZXNCKFZcjFznko89@orome.fritz.box>
References: <cover.1701248996.git.sean@mess.org>
 <734c9985a6f54d34d9ef20203ba7f962b572cb45.1701248996.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JGi/lTkRFNO61mX8"
Content-Disposition: inline
In-Reply-To: <734c9985a6f54d34d9ef20203ba7f962b572cb45.1701248996.git.sean@mess.org>
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


--JGi/lTkRFNO61mX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 09:13:35AM +0000, Sean Young wrote:
> Some pwm devices require sleeping, for example if the pwm device is
> connected over i2c. However, many pwm devices could be used from atomic
> context, e.g. memmory mapped pwm. This is useful for, for example, the
> pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
> with the generated IR signal.
>=20
> Since not all pmw devices can support atomic context, we also add a
> pwm_is_atomic() function to check if it is supported.

s/i2c/I2C/ and s/pwm/PWM/ in the above. Also, s/memmory/memory/

>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  Documentation/driver-api/pwm.rst |  9 +++++
>  drivers/pwm/core.c               | 63 ++++++++++++++++++++++++++------
>  drivers/pwm/pwm-renesas-tpu.c    |  1 -
>  include/linux/pwm.h              | 29 ++++++++++++++-
>  4 files changed, 87 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/=
pwm.rst
> index f1d8197c8c43..1d4536fdf47c 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -43,6 +43,15 @@ After being requested, a PWM has to be configured usin=
g::
> =20
>  	int pwm_apply_might_sleep(struct pwm_device *pwm, struct pwm_state *sta=
te);
> =20
> +Some PWM devices can be used from atomic context. You can check if this =
is
> +supported with::
> +
> +        bool pwm_is_atomic(struct pwm_device *pwm);

This is now going to look a bit odd. I think it'd be best to change this
to pwm_might_sleep() for consistency with the pwm_apply_might_sleep()
function. Fine to keep the actual member variable as atomic, though, so
we don't have to change the default for all drivers.

> +
> +If true, the PWM can be configured from atomic context with::
> +
> +	int pwm_apply_atomic(struct pwm_device *pwm, struct pwm_state *state);
> +
>  This API controls both the PWM period/duty_cycle config and the
>  enable/disable state.
> =20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index fc92ba622e56..63174e207400 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -463,24 +463,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  }
> =20
>  /**
> - * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
> + * pwm_apply_unchecked() - atomically apply a new state to a PWM device
>   * @pwm: PWM device
>   * @state: new state to apply
>   */
> -int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state)
> +static int pwm_apply_unchecked(struct pwm_device *pwm, const struct pwm_=
state *state)
>  {
>  	struct pwm_chip *chip;
>  	int err;
> =20
> -	/*
> -	 * Some lowlevel driver's implementations of .apply() make use of
> -	 * mutexes, also with some drivers only returning when the new
> -	 * configuration is active calling pwm_apply_might_sleep() from atomic =
context
> -	 * is a bad idea. So make it explicit that calling this function might
> -	 * sleep.
> -	 */
> -	might_sleep();
> -
>  	if (!pwm || !state || !state->period ||
>  	    state->duty_cycle > state->period)
>  		return -EINVAL;
> @@ -501,16 +492,64 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, c=
onst struct pwm_state *state)
> =20
>  	pwm->state =3D *state;
> =20
> +	return 0;
> +}
> +
> +/**
> + * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @state: new state to apply
> + */
> +int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state)
> +{
> +	int err;
> +
> +	/*
> +	 * Some lowlevel driver's implementations of .apply() make use of
> +	 * mutexes, also with some drivers only returning when the new
> +	 * configuration is active calling pwm_apply_might_sleep() from atomic =
context
> +	 * is a bad idea. So make it explicit that calling this function might
> +	 * sleep.
> +	 */
> +	might_sleep();
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
> +		/*
> +		 * Catch any sleeping drivers when atomic is set.

I think this is slightly confusing. What we're really trying to catch
here is drivers that are marked as "atomic" but which still end up
sleeping during ->apply(), right? So maybe something like this would be
a bit more explicit:

		/*
		 * Catch any drivers that have been marked as atomic but
		 * that will sleep anyway.
		 */

> +/**
> + * pwm_apply_atomic() - apply a new state to a PWM device from atomic co=
ntext
> + * Not all pwm devices support this function, check with pwm_is_atomic().

s/pwm/PWM/ here...

> + * @pwm: PWM device
> + * @state: new state to apply
> + */
> +int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *sta=
te)
> +{
> +	WARN_ONCE(!pwm->chip->atomic,
> +		  "sleeping pwm driver used in atomic context");

=2E.. and in the warning message as well.

> +
> +	return pwm_apply_unchecked(pwm, state);
> +}
> +EXPORT_SYMBOL_GPL(pwm_apply_atomic);
> +
>  /**
>   * pwm_capture() - capture and report a PWM signal
>   * @pwm: PWM device
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 4239f2c3e8b2..47ea92cd8c67 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 5c5c456948a4..f1fa1243e95a 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -286,6 +286,7 @@ struct pwm_ops {
>   * @npwm: number of PWMs controlled by this chip
>   * @of_xlate: request a PWM device given a device tree PWM specifier
>   * @of_pwm_n_cells: number of cells expected in the device tree PWM spec=
ifier
> + * @atomic: can the driver call pwm_apply_atomic in atomic context

Maybe: "can the driver's ->apply() be called in atomic context"?

>   * @list: list node for internal use
>   * @pwms: array of PWM devices allocated by the framework
>   */
> @@ -299,6 +300,7 @@ struct pwm_chip {
>  	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
>  					const struct of_phandle_args *args);
>  	unsigned int of_pwm_n_cells;
> +	bool atomic;
> =20
>  	/* only used internally by the PWM framework */
>  	struct list_head list;
> @@ -308,6 +310,7 @@ struct pwm_chip {
>  #if IS_ENABLED(CONFIG_PWM)
>  /* PWM user APIs */
>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state);
> +int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *sta=
te);
>  int pwm_adjust_config(struct pwm_device *pwm);
> =20
>  /**
> @@ -378,6 +381,17 @@ static inline void pwm_disable(struct pwm_device *pw=
m)
>  	pwm_apply_might_sleep(pwm, &state);
>  }
> =20
> +/**
> + * pwm_is_atomic() - is pwm_apply_atomic() supported?
> + * @pwm: PWM device
> + *
> + * Returns: true pwm_apply_atomic() can be called from atomic context.
> + */
> +static inline bool pwm_is_atomic(struct pwm_device *pwm)

As I mentioned above, I think it'd be more consistent to call this
pwm_might_sleep().

> +{
> +	return pwm->chip->atomic;
> +}
> +
>  /* PWM provider APIs */
>  int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
>  		unsigned long timeout);
> @@ -406,16 +420,27 @@ struct pwm_device *devm_fwnode_pwm_get(struct devic=
e *dev,
>  				       struct fwnode_handle *fwnode,
>  				       const char *con_id);
>  #else
> +static inline bool pwm_is_atomic(struct pwm_device *pwm)
> +{
> +	return false;
> +}
> +
>  static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
>  					const struct pwm_state *state)
>  {
>  	might_sleep();
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int pwm_apply_atomic(struct pwm_device *pwm,
> +				   const struct pwm_state *state)
> +{
> +	return -EOPNOTSUPP;
>  }
> =20
>  static inline int pwm_adjust_config(struct pwm_device *pwm)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }

What's wrong with ENOTSUPP?

Thierry

--JGi/lTkRFNO61mX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVzQiUACgkQ3SOs138+
s6GA/Q//aHBp0JEL3g+xPxWc5/3iX0Y0IwFJ09ixF4DNZdZ1QWzSmx5Fu86ignHB
kCZLrCXNDYfcOGulaH+hk4WyT008OE9MBuQabKhv598m0q9W57bsjBfWNKlcporK
CcyO0jB49yAsxrNkbVG89jx710IrgjbuEGiFCw4kZ/PNtYVQGEntXTLVWI4xT26/
Pbbb8nQTOtDmQ7LLDZLcYqyRssWBeC+fZUARWgNq1m4CN1n6Zeqy2Eua1MmzsYpg
U/rPcJnTjegLLcPdSqDKgLDA9cIrYd3yCfAKP4PJ76FTq93i2xM4Je9MfaxbiqG/
Gy+oUo6SCR6UIDZ73T+aiFrAvNTQzvqBUAB93/Na2MUsh7kJlcQi0740jgu8oXex
aiwlsmJZi5Ud8l+dciLj+AOTihmdi4BswstPgA37LlwE9QaJJHYF77VROGnA8sjG
q9kVVb3eDPoOE+I0a5bL1mwjvzSVvC1LyFDkzzmtyxEoMiQvIJVu8oj5t+9c1BlZ
w0jrlkyL+1Her35FaSgTIkMmH5OwsvYW90fsTBzFJnoBPg/1aiDowjISmBtUqBqY
Z5H4kxuu/K+B6gYdv+e30t8QLd9a9J5FUrvbjRaMq3TuBtuZwnKm9FFpd2/0jeSb
T/rcthG7Ebid2h5Pxk7gb3vXYsF3BrpajLtPanDqln43vcM3z9Q=
=rqdV
-----END PGP SIGNATURE-----

--JGi/lTkRFNO61mX8--
