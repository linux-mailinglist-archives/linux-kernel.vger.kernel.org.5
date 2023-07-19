Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FD758F51
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGSHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjGSHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:40:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F326A4;
        Wed, 19 Jul 2023 00:40:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so9039837a12.3;
        Wed, 19 Jul 2023 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689752425; x=1692344425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVV1G6IdV2ixGcP1Fi5HyBcxXokhJGCldaW9wzE2340=;
        b=JcXOS4qYz1VgymG89hJeoLhZtVnCFs69lesPjY+4dLkzC4OSUcE0dYhCkpCrVczC4j
         q9l3mI+HJUA4hWgmdH9uxDOp8/WT+N9rfDBb1krFoEbkNlnXSDJsUMfAr6k8bAuKsk0g
         BFV+1c/l3++fJnP9CF6V4ypZb3p9Q+73px+9bBbknVI8ZutAW19Lk7uApnQbYNm07ccU
         VaAhYi7ZSxiY/70XccdHo+wL8HyY5AQbMjqt0VnmDxjJKIJd9Y77+Ohx8VTJ1KGh0Vzo
         ugukeEjjqPJeRBKqQhgcWNlj4dbhU1pGgyQQjGuITDjQ9rxIOiRVY/9K17xBrMH9PyOt
         dHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752425; x=1692344425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVV1G6IdV2ixGcP1Fi5HyBcxXokhJGCldaW9wzE2340=;
        b=k/rtj5SBYoeyjT7tWx//H5SmkJkAu2E3xMDcINyDVoDBLP5wulNRCGDaXE/OkvtbpL
         8eIpG7ybXepMiuByCMQJHgwxT91ciKXDJsTNT21G9NKUc7nhpCUuzD4rg3bsBviJZle2
         k0WyM87jxDPM+Sfijg6z0PJrjtZNMgkaDUnRDjjxQHyCFYT9bDA3ULGGhrqYMBc6GsJ1
         qVdtOj421ntbGTWzPzJDOaSYbY1Sa7kfCoJqKbJj8G+Zf/s/wW4NoDHWhx6X5wIK3Rqc
         WPYoTC+epc9YtbsNWxVlcmjYeUbqNbb4AX+f6gsbO1gc6JNm11lPvKXSSbHTEJ8qfDgx
         ADSw==
X-Gm-Message-State: ABy/qLZdVup4vwgWAIAhHC+XCthOR24xBcl62JXRAvu3ywsYO6HthpmF
        rPOH3BBwKfxUqnat4JfYbh2X1D4dDBY=
X-Google-Smtp-Source: APBJJlGcP6m/9KHiym3XsCckeFkVzFHaMq678Si12CQ8ExyqwZH0AF6F2hzT5JLwaShcdOLY9DHNHg==
X-Received: by 2002:aa7:c944:0:b0:51d:f3b2:87b8 with SMTP id h4-20020aa7c944000000b0051df3b287b8mr1582404edt.0.1689752424558;
        Wed, 19 Jul 2023 00:40:24 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q27-20020a056402033b00b0051ff2b6139esm2342957edw.5.2023.07.19.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:40:24 -0700 (PDT)
Date:   Wed, 19 Jul 2023 09:40:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Message-ID: <ZLeTZtQ_WVzuUqeM@orome>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <CAMuHMdV-wu_XHy_qYGM+_UOAXN8etip731WxmgEmbQdv+SPwbw@mail.gmail.com>
 <ZLaSqhsJr2qH5Y6E@orome>
 <20230718165716.77hllvxiwia542fu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zHr/BWMh2IAS2KMK"
Content-Disposition: inline
In-Reply-To: <20230718165716.77hllvxiwia542fu@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zHr/BWMh2IAS2KMK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 06:57:16PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jul 18, 2023 at 03:24:58PM +0200, Thierry Reding wrote:
> > On Tue, Jul 18, 2023 at 02:05:42PM +0200, Geert Uytterhoeven wrote:
> > > Hi Randy,
> > >=20
> > > On Tue, Jul 18, 2023 at 8:44=E2=80=AFAM Randy Dunlap <rd.dunlab@gmail=
=2Ecom> wrote:
> > > > From: Randy Dunlap <rd.dunlab@gmail.com>
> > > >
> > > > When (MFD) RZ_MTU3=3Dm and PWM_RZ_MTU3=3Dy, there are numerous buil=
d errors:
> > > >
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > > > drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disa=
ble'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_=
8bit_ch_write'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > > > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bi=
t_ch_write'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > > > drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit=
_ch_write'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
> > > > drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bi=
t_ch_write'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_=
16bit_ch_write'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_config':
> > > > drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enab=
le'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
> > > > drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit=
_ch_write'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_=
disable'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
> > > > drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit=
_ch_write'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_=
8bit_ch_write'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_=
enable'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
> > > > drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_e=
nabled'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_=
8bit_ch_read'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
> > > > drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bi=
t_ch_read'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_=
16bit_ch_read'
> > > > ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_=
16bit_ch_read'
> > > > ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
> > > > drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit=
_ch_read'
> > > >
> > > > Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
> > > > still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being bui=
lt
> > > > but also allow the latter not to be built.
> > > >
> > > > Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > > > Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com
> > >=20
> > > Thanks for your patch!
> > >=20
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -505,7 +505,8 @@ config PWM_ROCKCHIP
> > > >
> > > >  config PWM_RZ_MTU3
> > > >         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > > > -       depends on RZ_MTU3 || COMPILE_TEST
> > > > +       depends on COMPILE_TEST
> > >=20
> > > This makes the driver always depend on COMPILE_TEST,
> > > which is definitely not what we want.
> >=20
> > Honestly, do we really need all of this complexity? I have specific
> > configurations to test all of the PWM drivers to make sure they build.
> > There's probably edge cases that don't get tested, but sooner or later I
> > expect some build bot will encounter those and then we can rectify
> > things. But in many cases that I've seen COMPILE_TEST just happens to do
> > more harm than good.
>=20
> Without COMPILE_TEST you'd need to build at least for the following
> archs to build all pwm drivers:
>=20
> 	armv4+5
> 	armv7
> 	armv7m
> 	arm64
> 	mips
> 	riscv
> 	shmobile

This one is actually ARCH_RENESAS and is armv7.

> 	x86

But yeah, those are the platforms that I build for. It's not terribly
complicated to do since all of the above have publicly available cross-
compilers that are easy to install. Also, most of the time I do
incremental builds, so these are quite quick.

> I personally like COMPILE_TEST as it reduces the number of needed test
> builds to 1 (I think).

Anyway, I wasn't arguing that we should get rid of COMPILE_TEST
altogether, just that for cases like this it doesn't seem worth the
extra complexity. RZ_MTU3 is an MFD and already || COMPILE_TEST, so
we can easily always enable it.

Thierry

--zHr/BWMh2IAS2KMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS3k2YACgkQ3SOs138+
s6H+9RAAiswm3IoP4UuS0e8EScnFcGR5KIYthzr6ETnW2f69AQW01RY9hdvuOh2D
Zi00Om6vWaKZw7wRokMS3WDaqr5+Af3tc1h8EE4BPxY8a5blrjV6O471VJwMOIKe
OF20AgzSzsuFwDxFNNDOZtU2hJs/zk+Nj0VPORI8N7CgxDS4a3ttuw4/TYLPwrii
98nzWpS3zu978KHoVBm96t4fYpK0bkDxfM3QKK2i4zR2rp9EHLu26Ds4bTv1QEXI
h0wLcdhZBAmRl0UFOt/Trto9HNKpbjAdqD+1dLDNLVcOeajjmNqO++73UOGWMpTO
QKOGNvs5B/EjUncuSFLNHCKfrvN2ddVZnB76BbyPqB+/Q650xS31OXXxOmYBvCpM
Qeejd0GO1IKB+odgkAWIkx2141VVUUBAdh+gnuYjpJOuobdPOLLuq1Yy25J6Jpg9
1ojpNpwdWi3OYenzMsQU7lqn2SbjXfe2Sp4KvIljIGT8FASyF+7ojLNHOnPah73i
6uetm5wQCq+n4I2/VPRMZJS5tRKLuRj1POEVHEDQPF+fapq/xSZaHg6pcB4hWzkJ
U9xc3WhwNkRc5auyv14zKEzD685PDdjINAPJiMmgvcENMqXZxMaqdx+PjVSDyc0c
IERjKf/QHliAs1QT5dPNalnVH4RjubbPhbYjIayvSEHrRm20M9I=
=fIt7
-----END PGP SIGNATURE-----

--zHr/BWMh2IAS2KMK--
