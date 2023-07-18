Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46B757AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGRLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjGRLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:43:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6AD10FE;
        Tue, 18 Jul 2023 04:43:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5216569f9e3so6157795a12.0;
        Tue, 18 Jul 2023 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689680626; x=1692272626;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trXL8e/lwqtV++Zs9uqD1Gu9wHh+J65evfBXtcfp+yA=;
        b=GDYG4LOZ2qE7YG9Glyfm7uLRWc85jvebxYBI5piT/qzB93y9nrXEFAoEfAkeCCyyOr
         PYICI6kWPmKMBgoZ6gvu5ZmN027t8C7Yrus7IKcQPKh7IdN7CABiuQHUj0heXf93JlWe
         tTBBKFsKPj6lun6TUIn9+eb7z4surJaO9my5sdTq0e5/d3QD2Eeki8Ach9CCQ7wHBXAc
         NGa9KKH4V1QzLvMEmVUJWWTby7+YFcxaETFIgNvYM5ZUfmMwsordFei8ayo2CEwTVbR+
         dj+8+3MAFLLMh02DTESQxQvy83+x6vITjJqllZWsvmzNT3SuTbXS9MLWsEN1R2YF+c4Q
         26Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680626; x=1692272626;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trXL8e/lwqtV++Zs9uqD1Gu9wHh+J65evfBXtcfp+yA=;
        b=Vn0OQ6CYUlV8wusf9TXUpLxITsRA/CR8AKlKCjxvtgD2EVj/GhY7595dLby/iRdgTi
         faRwgQox/RxOMimA+jgfB8LYmIUyTaq+L4X80EmZYKIc+VWVJ27cZPRO+lIT1g04R42a
         scV+REHXn1He4IzQV+9wsSmZ3zlUgvumq6ADc1x/tOw7XDfDa/UuqfnqnZ9Tr3M2Y9gw
         vBPv70k64cC7K4eq+UY0odpvGXE+lStNR4i9e3wO7+/cWCb1y7WqcT0m2zRWk7qny2Xj
         mEWFVFF6IzpbYF9fPIeVUavZCuwPOgomgwKbxDtnGrhiNUoxhmIu3Ak6XIcOuVndNHVf
         cANQ==
X-Gm-Message-State: ABy/qLb5y2Q5oe1eEmsIcdgNKcGmcjaX/pJeMkZhUdDUBobKXk15eMvm
        yo6c98aNR0xcL9eauHH1ujrGM8ERc7k=
X-Google-Smtp-Source: APBJJlGVvi0RJtGwTkMeNsK0KOdN+gFWQ9SPwhKnes/9dgPDRxTAvufJv7csFAyhElWIjPR04Y7Gpw==
X-Received: by 2002:a17:906:7a0b:b0:994:4ebe:7a6d with SMTP id d11-20020a1709067a0b00b009944ebe7a6dmr12027850ejo.19.1689680626290;
        Tue, 18 Jul 2023 04:43:46 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090665d400b00997e99a662bsm30358ejn.20.2023.07.18.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:43:45 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:43:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Message-ID: <ZLZ68OUizlOqoZmn@orome>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <OS0PR01MB5922D3163524299B94166B178638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D90jt/TQ2RxVcnZA"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D3163524299B94166B178638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D90jt/TQ2RxVcnZA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 11:26:28AM +0000, Biju Das wrote:
> Hi Randy,
>=20
> > -----Original Message-----
> > From: Randy Dunlap <rd.dunlab@gmail.com>
> > Sent: Tuesday, July 18, 2023 7:41 AM
> > To: linux-kernel@vger.kernel.org; linux-pwm@vger.kernel.org
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Thierry Reding
> > <thierry.reding@gmail.com>; Uwe Kleine-K=C3=B6nig <u.kleine-
> > koenig@pengutronix.de>
> > Subject: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
> >=20
> > From: Randy Dunlap <rd.dunlab@gmail.com>
> >=20
> > When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous build er=
rors:
> >=20
> > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
> > ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to
> > `rz_mtu3_8bit_ch_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to
> > `rz_mtu3_16bit_ch_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to
> > `rz_mtu3_8bit_ch_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to
> > `rz_mtu3_16bit_ch_write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to
> > `rz_mtu3_16bit_ch_write'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> > drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to
> > `rz_mtu3_8bit_ch_write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to
> > `rz_mtu3_disable'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> > drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to
> > `rz_mtu3_8bit_ch_write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to
> > `rz_mtu3_8bit_ch_write'
> > ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enab=
le'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> > drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabl=
ed'
> > ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to
> > `rz_mtu3_8bit_ch_read'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> > drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to
> > `rz_mtu3_16bit_ch_read'
> > ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to
> > `rz_mtu3_16bit_ch_read'
> > ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to
> > `rz_mtu3_16bit_ch_read'
> > ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> > drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to
> > `rz_mtu3_8bit_ch_read'
> >=20
> > Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is still
> > allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built but also
> > allow the latter not to be built.
> >=20
> > Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: linux-pwm@vger.kernel.org
> > ---
> > v2: fix typo in Subject;
> >     correct my email address while infradead.org is down;
> >=20
> >  drivers/pwm/Kconfig |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff -- a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -505,7 +505,8 @@ config PWM_ROCKCHIP
> >=20
> >  config PWM_RZ_MTU3
> >  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > -	depends on RZ_MTU3 || COMPILE_TEST
> > +	depends on COMPILE_TEST
> > +	depends on RZ_MTU3 || RZ_MTU3=3Dn
> >  	depends on HAS_IOMEM
> >  	help
> >  	  This driver exposes the MTU3a PWM Timer controller found in
>=20
>=20
> The below patch also works fine,
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 1c8dbb064ee5..56ab2f4b91fe 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -505,7 +505,7 @@ config PWM_ROCKCHIP
> =20
>  config PWM_RZ_MTU3
>         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> -       depends on RZ_MTU3 || COMPILE_TEST
> +       depends on RZ_MTU3 || (COMPILE_TEST && RZ_MTU3)

That's a bit pointless, isn't it? That effectively reduces to just:

	depends on RZ_MTU3

Thierry

--D90jt/TQ2RxVcnZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2evAACgkQ3SOs138+
s6EJ6BAAm/1a5iFP5YYhXGdTWZAK2fkfqxfSnZjUnPrwkMHgKFZLq+lcL+tvazAA
HFiSRhn3fak7A/itAIOXqEh9dxIisKIsJgdr6PH1wsgpl1h7Otcv0Vo/nD3cntoM
xcJfrXKzsGpGCrMqy8nSEE16i0r47Vn+hDoFBjFAvQQOzwKi6F7C645utYSFx7CB
PnuzfN5qFWGTx9RAeMxaYPAHNwqWCGsZxff+yonrVf1KPdv6eD+r6sWckIF3zmI8
KYlLOT0s6IkWVTqgzJZuzwfw5qmt7upk4+dkZRBTJrxaVaBSMi51b2z3P3eMIgqC
KhsyHIvhQVf6kFVWbbxtRhpKrZSik19hhkEAAQsEpIVad5F3KobcYEitA+zIt3tX
86Vd5AuQuAb28Y/CwfRP/68bb/sTh9Nx+f8aoXOqTl8m/dsovu/yVkkO1VD20xyv
uDrlAtUzLmFyB1ueDXaaIxGS7fEwAxXChidA8ZQiGYD/zCgLJRmsHlyKp0H4H15/
tdcWSFSLzn6xKfH7sWzweZa3TzbHHG4w+9DBMnZt1T4g46jB1CDktIvEUfYZO3rv
xfbZCnJh9PYBOGPEDQYP8DRQu3rfYGP3QiQhOAYGEfXYr4l8wEqXBWB+Gg4HFXgQ
hJhgdp0hvnE3nsBdpd9CIpWQYHBS3C/lboMxbKK74B0Aug4uzu8=
=i0DA
-----END PGP SIGNATURE-----

--D90jt/TQ2RxVcnZA--
