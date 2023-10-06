Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA87BB524
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjJFK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjJFK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:27:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C04F0;
        Fri,  6 Oct 2023 03:27:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso356289366b.1;
        Fri, 06 Oct 2023 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696588074; x=1697192874; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Fc0FVBGB2O2+FJ3vPJiIICpzRP6mifN4XxO0k9PQQ=;
        b=DXXP7DtkTw8LPdj1fBra1hGl34to9q8Fko1IRHvcvo+NSNYRprNlEc+tAcuCeNRL/R
         JxkRtLN+W5/3pErgqQDu6Iq2p2574VkAujFMymo5GeLyxDADfJoI0P/tVhZ1f16ZIwx4
         AuKSl5hGVsdyRNgZgpQojyUN4w6hmkhHTKnwmX3wY/Ct3OuFflqR923dKbw/T6qxR65C
         WEyt8kvLxjHUL1SEsHM8wshjC3ML2iH9ULlatzLg30HSHHtWzlHwJhGOAIm0YQ936V2P
         Eva2b1jfs/ppk8s44l8Vs8PwhJ+BOZVR1wOLfCScwAdzsTcj3LO0s7wzePi8mHXbj+jy
         X+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588074; x=1697192874;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Fc0FVBGB2O2+FJ3vPJiIICpzRP6mifN4XxO0k9PQQ=;
        b=GD2Rx7jaAmBM3M6V52k0IOjM8kgeHRPlnrNE+a4Fr1ZbJBeKTGGVFdPRq2vcVEI788
         gpcis56n5LElg36+JOa+BOoUYsehq+IAyAIfOy5Tch/vQDhfCFgaCtCEV/70dxkFUA3m
         As2nxjPyij2acgjKx9JQl7vzio86X/hsu7IqxsQFOFpa0wWEr2RIxi+dlegDsz8x1xT7
         PL7jmyM7ovTCDVeAfW98FKnr6jQ/fVDnu5meIhXJMKOC+AFM38yCTrnw8kXrHItPy0tu
         htim36pbFLW62Xi0oPTiLR9ENb5dDO9oXbLJL5EOox/IL01KvxKfXl6Sh4OthX6k4jCi
         EqdQ==
X-Gm-Message-State: AOJu0Yy8E3L5kAZGQTO1SPFeU+i4YQ6Q33nUix2FVktSm2to+3J9+eIB
        MIjZvAqjZiBXDYsaXI/ubrA=
X-Google-Smtp-Source: AGHT+IE/s3qAxgyljikxvjg80luFhar2eIhtc4hXlIZiE/53LwAa/wMyWOcQaAwad6HOJwQdJ6c/EQ==
X-Received: by 2002:a17:907:72c1:b0:9ad:7d5b:ba68 with SMTP id du1-20020a17090772c100b009ad7d5bba68mr8214636ejc.32.1696588074415;
        Fri, 06 Oct 2023 03:27:54 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fi10-20020a170906da0a00b009ad8796a6aesm2627941ejb.56.2023.10.06.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:27:54 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:27:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>, Shawn Guo <shawnguo@kernel.org>,
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
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic
 context
Message-ID: <ZR_hJ05h5O6SpM_D@orome.fritz.box>
References: <cover.1696156485.git.sean@mess.org>
 <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
 <20231004095920.ne7yrrthow6tnuvg@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BBvlNbMNXcP/VVb9"
Content-Disposition: inline
In-Reply-To: <20231004095920.ne7yrrthow6tnuvg@pengutronix.de>
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


--BBvlNbMNXcP/VVb9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 11:59:20AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Sean,
>=20
> On Sun, Oct 01, 2023 at 11:40:29AM +0100, Sean Young wrote:
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index dc66e3405bf5..d9679ae5b2be 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -505,7 +505,7 @@ int pwm_apply_state(struct pwm_device *pwm, const s=
truct pwm_state *state)
> >  	 * is a bad idea. So make it explicit that calling this function might
> >  	 * sleep.
> >  	 */
> > -	might_sleep();
> > +	might_sleep_if(pwm_can_sleep(pwm));
> > =20
> >  	if (!pwm || !state || !state->period ||
> >  	    state->duty_cycle > state->period)
>=20
> I'd like to have a mechanism to catch drivers that missed to set
> .can_sleep. The best idea I currently have for that is to disable
> preemption if IS_ENABLED(CONFIG_PWM_DEBUG) && !pwm_can_sleep(pwm) while
> .apply() is running.
>=20
> > diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> > index b7c6045c5d08..b8b9392844e9 100644
> > --- a/drivers/pwm/pwm-fsl-ftm.c
> > +++ b/drivers/pwm/pwm-fsl-ftm.c
> > @@ -405,6 +405,7 @@ static int fsl_pwm_probe(struct platform_device *pd=
ev)
> > =20
> >  	fpc->soc =3D of_device_get_match_data(&pdev->dev);
> >  	fpc->chip.dev =3D &pdev->dev;
> > +	fpc->chip.can_sleep =3D true;
>=20
> As .apply() being callable in non-sleepable context only depends on
> .apply() I think a better place for this property is in struct pwm_ops.

What about drivers for devices that can be either sleeping or not? There
are things like regmap which can abstract those differences away, so you
could have a driver that works on both types of devices, so setting this
in ops wouldn't be correct all the time. I think can_sleep needs to be
per-chip rather than per-driver.

Thierry

--BBvlNbMNXcP/VVb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf4SUACgkQ3SOs138+
s6Hgnw//ccRZMpPdmSrNh4HxesaeJ6IDlrZScm72UvWlvlUAATBRaIcrFiy1VnCC
WRKKcuPsxwg26Zy8KPZ2IijwVz1zNEQtEtOE53pVnCvcF3rcVBdIZlkPqJjO9Zcc
0azGAvZ4E9ExFnxycj1GpI475JXS2UkZ98rObXv53zzOVAxBdsyzhOWj9shXxPh5
d5tQj65dx5EtNFzmuo/lBfG/G8Xpqv5p8gXhWnv80xSdUcWHjhIGoJYVPrqtOXjC
dvedwv/bL55kMiymSn0oKln/X37KXdRxtHVaHXOCbGZ79kNxipW5x/+7Kuz95wTt
+JA5eClBpGErs/qCJ0JQmgo7H/0gG5CtUQPOMnWfbC5qxDO4ZL2eonCyIcV6JBEO
i/Scpl+4A24euVRkE1vyXNpihMm3svCEcbviq9aQ75UHL0cjGz9FHeGb0ACo1c6p
hSA4l+cuSY7dRgNMqcWrxkKDJNE0/hlK1LzcfxskL9jpGgvFfPbrUDKqKOQ0lDFA
fy8gReA/eA6E0jWgnbDpCs5wukqBFSXcodjz/L4POhL2dpE93MfLpFzAOQZipBD6
6FNT5jDjZC27gI000KEp5TTiPYEOiRocARTyBEQ7Rnq8UolMPGDxVEZilhRWhxzL
h8mjM8w60+lKYDG77xjN7M4cLEcOVRzxxVpjaJ0khqMaHxhZdlo=
=bA40
-----END PGP SIGNATURE-----

--BBvlNbMNXcP/VVb9--
