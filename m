Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837117BB52E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjJFK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjJFK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:29:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88609F;
        Fri,  6 Oct 2023 03:29:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso363198766b.2;
        Fri, 06 Oct 2023 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696588177; x=1697192977; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FTsAYhfYTssJFz7CdhaD+H1tNbJvHmttIr6I4ZAM+s=;
        b=eROG8gi8Beh95QiLOvY6Bqg3SCSBfM0bg/x4PSHtmt5VzMNa+6dPbHg3h/3UtSF0JR
         QBiHb8aBcMxcLFdFJ6OMufMjisuA8SNyj87VbNF4HLgqPpO0i0085yNzoWrWoCAhJzY5
         DpZ5gFloIv0Beu5Mo8xYuBR8XBjz/XWj9HlSj0OrvMgrJ9CIYBck+zM+p2oY8ff3Ij4u
         y3QBsI/KE3mTCamYazY7HxtjoaqXZ7HN/3hENvWQK9ywo+/HU38oEfdLiyWXHMiObC0U
         JDpvtivOeNostwMI0HxsKGDIKZ4ryqw4RNpVUtmieTzyY64krtx/LoRYxj0yb44nfPeG
         eS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588177; x=1697192977;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FTsAYhfYTssJFz7CdhaD+H1tNbJvHmttIr6I4ZAM+s=;
        b=HZkE8iWlirz1OWF4bF1/wME1BJidkK993sMsjYbp0g1hhq9v6yMePB8yTJyjmMsRk1
         7TlQDLk++Z2V9IymZhF3OQyjQDpgZYgl8Ls99MTqMv5AT3Iol4iHWJifFu5RKPRufVnS
         OnTSOgNmD7t6BEDkMJjXphKjFVxd0Nm3QTEATggTYG5JzjdoYshU5ZMQZLnCw+TYrXC9
         pX8xPiQhdX88SxiByUttHQ5jo9l8y8Rck/LdeDeA7qEXuuJfvGyKN8XXd5F6mNdy4RW8
         PeOv2ba5zBaKyjZQW5ksGXS+NJQdz6PvZJmLkTUAB+yQGd6+3RnD5ESvbDJuup+q6ofc
         YrKg==
X-Gm-Message-State: AOJu0YxrbAuxUzowJ2o/+Hn5QwfttdRhJmtmQ0gz9EjSY9kicF2/FOiI
        VWfGHGjc1US8jSLOmMIhtp4=
X-Google-Smtp-Source: AGHT+IF29lLhqYu1W7nFQy9/ogamXAd4uztCA0mlziEcK+D8YlweNIqxDxKUo5cSzTjeFjEwc2s/Ew==
X-Received: by 2002:a17:907:7857:b0:9b2:b153:925 with SMTP id lb23-20020a170907785700b009b2b1530925mr6657004ejc.21.1696588177046;
        Fri, 06 Oct 2023 03:29:37 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090640cb00b00977eec7b7e8sm2657390ejk.68.2023.10.06.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:29:36 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:29:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic
 context
Message-ID: <ZR_hjjS1VMAPLYVI@orome.fritz.box>
References: <cover.1696156485.git.sean@mess.org>
 <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mL8QfLbOLLpS8F7R"
Content-Disposition: inline
In-Reply-To: <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mL8QfLbOLLpS8F7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 11:40:29AM +0100, Sean Young wrote:
[...]
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d2f9f690a9c1..c94894ffa4c4 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -287,6 +287,7 @@ struct pwm_ops {
>   * @ops: callbacks for this PWM controller
>   * @base: number of first PWM controlled by this chip
>   * @npwm: number of PWMs controlled by this chip
> + * @can_sleep: can the driver sleep in pwm_apply_state
>   * @of_xlate: request a PWM device given a device tree PWM specifier
>   * @of_pwm_n_cells: number of cells expected in the device tree PWM spec=
ifier
>   * @list: list node for internal use
> @@ -297,6 +298,7 @@ struct pwm_chip {
>  	const struct pwm_ops *ops;
>  	int base;
>  	unsigned int npwm;
> +	bool can_sleep;

Can we please call this "might_sleep"?

> =20
>  	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
>  					const struct of_phandle_args *args);
> @@ -380,6 +382,18 @@ static inline void pwm_disable(struct pwm_device *pw=
m)
>  	pwm_apply_state(pwm, &state);
>  }
> =20
> +/**
> + * pwm_can_sleep() - can a pwm driver sleep in pwm_apply_state()
> + * @pwm: PWM device
> + *
> + * Returns: true if the driver may sleep, false if pwm_apply_state()
> + * can be called from atomic context.
> + */
> +static inline bool pwm_can_sleep(struct pwm_device *pwm)

And this one pwm_might_sleep()? I don't see why we need to deviate from
the nomenclature that the core introduced.

Thierry

--mL8QfLbOLLpS8F7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf4Y4ACgkQ3SOs138+
s6E4FBAAg0tEpfYfp9Yw8ogU74h4roxmvYnytJpFXp2sixtyVANVEMQepzR2LQIE
CqWassqeXgYIpkDitSttcCUwtGZ31Klbd+7irCzb1X75W6u6xbsbhAgiQ+edclP2
5+C0wAerMMAavdgn7hYf1JYpupZM9H5/RvZLcSkywvpfHEfzrOFU20ackUlLiXsG
Lc6RTVMwki88bxnA5WerSZuTIOYSVl0Pkg+4djuN6xtdv4zF53Cfkz3o7d7dc5US
lSxjcikOpDealmS75qLW61PWWiDC8AZXxZysVjwuiwP0xnIk52KhHMsQeignaZ2b
G5NdTZZHyLpfF/HV23LdQKCOP3/J/50lkO1pslq8VcccJYqeOFhreG7MaCax2i7b
DZi0KEX/MGGRmA7hZj9014u5Q1KfvClbrWuctt9SLbbcWLeV2YW+MOcb/PSoj82D
DE9u62SJ4/xck9btpwuFXQ47Smxlub8qeOEh941qJsImqskMUJV42BI1mSITOexx
Mnfi9SD5H5+KxEkr39VbAA55ypAS1DNS/BubpmI/kPFXz01tjUxFtqLnQxl1ANVB
QnIUADVzpB0kmmJoUyiLU0FWLaExWqfrJDSzbt/WDeKaS4O5P1VfrCOsPcPelIYs
xP5n3y/MN01SRytptbW9Z7+tJBSJSrP2M8gt2JnmPFQxCe+ISto=
=LVfE
-----END PGP SIGNATURE-----

--mL8QfLbOLLpS8F7R--
