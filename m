Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79375B1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGTPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjGTPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:00:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4726B7;
        Thu, 20 Jul 2023 08:00:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-521dd3d93bbso789912a12.1;
        Thu, 20 Jul 2023 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689865220; x=1690470020;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUaf4gWLINZFBA0dqPiheaqiJjRPRICeXKr+4KTVKtI=;
        b=M82Pp31uZyTTn7PdzqKNmJk8gZ3xG/AC56Qz0Nb2apc7PfHib5LJB2ygkOTOekgPSk
         NRTDaPTEZ7h7QzLLd+qnOXta/CofdDclBCmnuOiPJ4IwB0wb4nljhWydy7tYNg+Jo9lv
         K+afpSdH9Ux2O84Y8I8RT+Ldoia2G3KEre46izxnHJokm1oRwpe2v2qOJy/lVTMDb8kT
         JL6i9U998DsAsb661gF1H8D4RKAsYFCmm6LORjVL9UMTSR0nvyueKkIM2pJT3rXQZBMW
         M8zmArRFY/nwkYI6CB0YGvZs4kFI1/covAwzZUVjecj+HNdXyU9M/OZVGOYtrMnwxHC2
         noMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689865220; x=1690470020;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUaf4gWLINZFBA0dqPiheaqiJjRPRICeXKr+4KTVKtI=;
        b=MHFfDHomSLVRwCmCEvNb6XOgQ6iBFuJ25Ld8mfvNr3g/UnkA0W3Bu5ow1YfB7IlWUb
         55Ue684SwDQsWOb86ITY6WpRx60zPbNfLngVHVb+em0sffJpkXbkCuOgAsMVfjBCWzZf
         IDtpg8Z0+1L5zv1BxiG5FSayvuuVI6JCiclAwCtGNGTwprVVkBQcLrj/YPTI1L4FyyTH
         8jbfmzDw8FdLrHtURXsLmJ5mz1KxQZwKSalVwYQW2UhZT/0LpaZLWe0MiYhvrEsM89pv
         1KG96R5346SP80OndLNgiKcVBPwA3taIRBRiVmz/m44/lYYUun5GQqqccEd+NxRFDuNI
         6Nhw==
X-Gm-Message-State: ABy/qLZHvClcO7hLMRXjz+FV8Ol7aqFWRUrpDJBuNulfeQ37Tddf4nFE
        Lz7nOK3NJaJLSCxhVzwy8Pc=
X-Google-Smtp-Source: APBJJlFFRHPquURhC+Xbg2wu19XDlOqWRNysFJVh6NesJvC97yquLrH3/wnsZPcx6ujqVwG5BaIB0w==
X-Received: by 2002:a17:906:95:b0:978:928:3b99 with SMTP id 21-20020a170906009500b0097809283b99mr5459760ejc.46.1689865220270;
        Thu, 20 Jul 2023 08:00:20 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lo19-20020a170906fa1300b00992665694f7sm819845ejb.107.2023.07.20.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:00:19 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:00:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] mfd: rz-mtu3: link time dependencies
Message-ID: <ZLlMAZPzEmSlzlbV@orome>
References: <20230719090430.1925182-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="slp7OkdABcuJ1sYm"
Content-Disposition: inline
In-Reply-To: <20230719090430.1925182-1-arnd@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--slp7OkdABcuJ1sYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 11:02:23AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The new set of drivers for RZ/G2L MTU3a tries to enable compile-testing t=
he
> individual client drivers even when the MFD portion is disabled but gets =
it
> wrong, causing a link failure when the core is in a loadable module but t=
he
> other drivers are built-in:
>=20
> x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_appl=
y':
> pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to `rz_mtu3_8bit_ch_writ=
e'
> x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to `rz_=
mtu3_disable'
>=20
> arm-linux-gnueabi-ld: drivers/counter/rz-mtu3-cnt.o: in function `rz_mtu3=
_cascade_counts_enable_get':
> rz-mtu3-cnt.c:(.text+0xbec): undefined reference to `rz_mtu3_shared_reg_r=
ead'
>=20
> It seems better not to add the extra complexity here but instead just use
> a normal hard dependency, so remove the #else portion in the header along
> with the "|| COMPILE_TEST". This could also be fixed by having slightly m=
ore
> elaborate Kconfig dependencies or using the cursed 'IS_REACHABLE()' helpe=
r,
> but in practice it's already possible to compile-test all these drivers
> by enabling the mtd portion.
>=20
> Fixes: 254d3a727421c ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Fixes: 0be8907359df4 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Fixes: 654c293e1687b ("mfd: Add Renesas RZ/G2L MTU3a core driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/counter/Kconfig     |  2 +-
>  drivers/pwm/Kconfig         |  2 +-
>  include/linux/mfd/rz-mtu3.h | 66 -------------------------------------
>  3 files changed, 2 insertions(+), 68 deletions(-)

Assuming that Lee will pick this up:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--slp7OkdABcuJ1sYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS5S/8ACgkQ3SOs138+
s6EUEg/6Anop3hMP3iGcBnMEcu0SxusT0pTyZCNLPL1doGbdncByqE1q1zdEca0S
3z9U1vwKHKl+tOfx15dDlS+EBz7wQpkYaU3UUeXVoX7rzGuzDNfe9dmYo63LvoRI
/7ikGCZDb6lfzEhFznRBpNnXQhm4k0+9HDVIH5riXgIc/wepTsENaymyCBxg9ocs
PAZTDaDRt+4mdeP3A7JrCihqU6P8LiSTetGwydHp04s9xVrnlhYHpy7AecnkJH3K
CzkhykUji/qjWHUkcOUp2JGOrEWMFwleadLqvMOZwBm6i5d701K5TospTFvIS4WA
b8u61aSXevOqxcU/IZ2HEqk91uTDFIPNwx/KaupITl3q0SBlxPky9YGnsuy3K4Gg
uEYokiYYqVvAAb83B5IijBq7BQnEYmVR7bc6U7wmQaDtstiHsTgDu1+T44glMVxR
FH0vNUGrw/iekN340d7w6/0DKmtm9UxQsoFzLdSbYOSRU+Go3kSHRG+zJYeryamr
w0CRz+YIV0ZuqXEqys+VS4326WQJM78rXHsbhETcCzH/8xEEweX9BPvmCqsMpP9E
s+jt/jzTPiRgi4a4sHy0X+JF9b7qS0LoIiJ5/NZhPCWThmxcTs7iK3Xa3aIcsfhb
d6kRQ9XjgJ5FqfAVU93Epnl0bzaCKIpSFWSl8eKdT1CenRlI6Lc=
=eYIX
-----END PGP SIGNATURE-----

--slp7OkdABcuJ1sYm--
