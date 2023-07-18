Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55E757469
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGRGjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGRGjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:39:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45956B2;
        Mon, 17 Jul 2023 23:39:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11020001a12.0;
        Mon, 17 Jul 2023 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689662348; x=1692254348;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY8mkv6Tta1o2JgKQkYOxaVAYeF+Y1zLs9QhRZtEEvw=;
        b=HsOec0qR701vzASUVqbK11uHMBCwGeIExVLBVHU5+h4BjmddWeB1qsTVF7yqqq0MH5
         Ixr2rqm+zONxKZccsz5E3FfhNQuaMGFZJTSB/baeawOPcoSU+MKAdnEknXHeuupQUmMg
         /ssuOWL8Wc5M0EivzeeVsUHiKT9267nAmkNH/I88c3qXeti5w8SBiI9yflzbTTAe71fC
         ewBssw06qSHUGOBtabcgtz/7zYRLHf3h45S12ikr2x1/CHiTTT7YQ2g9D+BcGfY9vMZe
         bjZAqnM/HEUSim75nfYErmn6yrquhREMuN6LiC71St6JRE7ArRdKgAla2iCJxg17AW/y
         BxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662348; x=1692254348;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY8mkv6Tta1o2JgKQkYOxaVAYeF+Y1zLs9QhRZtEEvw=;
        b=Na2DFv+83vaLU/S6jBy4Xvj2NTY/HT3yAThnaRISFNrnf51idXUj4KokeHtZG9wj89
         aaySTS0aKEEoXTMSbNWSjh+LvwYpfmGTI/HLKsn+Hy5ZTTpE/Tjq3WBeAhzHP29JWRVU
         tqrmL9d3dzF8zAdOASpL+HedpilRrctSzgTvLIEz0uQbqeVmNBNWJnLAdvKG0ti+6kML
         i3HdfO+NWAcuOWJXMiyhJbmOGBwKovsK2cRCBG/I2nPUwPj42tbmvEz/m6oplAiyODIa
         /bsKFyaxopow1XMzy08r8liEDwf8TldH5VpFPxSsy23Wct6hs7cNbPPAMeL34XYP49RK
         CQuw==
X-Gm-Message-State: ABy/qLbiEpCnDunJIgU+x3hGrCuEsS6hPq/tbRu23NGD2ayEfWhYKb+z
        SDYdLUctZKcWejhjqrwnV1o=
X-Google-Smtp-Source: APBJJlHyvyAxzWMmSdDheZfwLaIUsEBdPq35pJycwdjBr8gDFrb6A4b9u+g2oZMTR33oVOKD6tDFYw==
X-Received: by 2002:a05:6402:499:b0:51e:1c5c:b97f with SMTP id k25-20020a056402049900b0051e1c5cb97fmr14919584edv.2.1689662347332;
        Mon, 17 Jul 2023 23:39:07 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d5d9000000b0051e0f100c48sm724877eds.22.2023.07.17.23.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:39:06 -0700 (PDT)
Date:   Tue, 18 Jul 2023 08:39:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Message-ID: <ZLYziWcIWcNnzMXR@orome>
References: <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
 <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
 <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
 <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6M5dd0U91g62xbzr"
Content-Disposition: inline
In-Reply-To: <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
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


--6M5dd0U91g62xbzr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 08:04:24AM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2023 06:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> >>
> >> On 17/07/2023 11:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> >>> Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>>>
> >>>> On 7/16/23 09:08, Krzysztof Kozlowski wrote:
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>>>
> >>>>>> This patch serial doesn't use to binding the fan control h/w. It is
> >>>>>> used to binding the two independent h/w blocks.
> >>>>>> One is used to provide pwm output and another is used to monitor t=
he
> >>>>>> speed of the input.
> >>>>>> My patch is used to point out that the pwm and the tach is the
> >>>>>> different function and don't need to
> >>>>>> bind together. You can not only combine them as the fan usage but =
also
> >>>>>> treat them as the individual module for
> >>>>>> use. For example: the pwm can use to be the beeper (pwm-beeper.c),=
 the
> >>>>>> tach can be used to monitor the heart beat signal.
> >>>>>
> >>>>> Isn't this exactly the same as in every other SoC? PWMs can be used=
 in
> >>>>> different ways?
> >>>>>
> >>>>
> >>>> ... and in every fan controller. Not that it really makes sense beca=
use
> >>>> normally the pwm controller part of such chips is tied to the fan in=
put,
> >>>> to enable automatic fan control, but it is technically possible.
> >>>> In many cases this is also the case in SoCs, for example, in ast2500.
> >>>> Apparently this was redesigned in ast2600 where they two blocks are
> >>>> only lightly coupled (there are two pwm status bits in the fan status
> >>>> register, but I have no idea what those mean). If the blocks are tig=
htly
> >>>> coupled, separate drivers don't really make sense.
> >>>>
> >>>> There are multiple ways to separate the pwm controller part from the
> >>>> fan inputs if that is really necessary. One would be to provide a
> >>>> sequence of address mappings, the other would be to pass the memory
> >>>> region from an mfd driver. It is not necessary to have N instances
> >>>> of the fan controller, even if the address space is not continuous.
> >>>>
> >>>
> >>> Hi Guenter,
> >>>
> >>> May I ask about the meaning of the sequence of address mappings? It a=
ppears
> >>> to consist of multiple tuples within the 'reg' property, indicating
> >>> the usage of PWM/Tach
> >>> registers within a single instance. After that I can use the dts like=
 following:
> >>>
> >>> pwm: pwm@1e610000 {
> >>> ...
> >>> reg =3D <0x1e610000 0x8
> >>> 0x1e610010 0x8
> >>> 0x1e610020 0x8
> >>> 0x1e610030 0x8
> >>> 0x1e610040 0x8
> >>> 0x1e610050 0x8
> >>> 0x1e610060 0x8
> >>> 0x1e610070 0x8
> >>> 0x1e610080 0x8
> >>> 0x1e610090 0x8
> >>> 0x1e6100A0 0x8
> >>> 0x1e6100B0 0x8
> >>> 0x1e6100C0 0x8
> >>> 0x1e6100D0 0x8
> >>> 0x1e6100E0 0x8
> >>> 0x1e6100F0 0x8>;
> >>
> >>
> >> Uh, no... I mean, why? We keep pointing out that this should not be do=
ne
> >> differently than any other SoC. Open any other SoC PWM controller and
> >> tell me why this is different? Why this cannot be one address space?
> >=20
> > Hi Krzysztof,
> >=20
> > This is because the register layout for PWM and Tach is not continuous.
> > Each PWM/Tach instance has its own set of controller registers, and they
> > are independent of each other.
>=20
> Register layout is not continuous in many other devices, so again - why
> this must be different?
>=20
> >=20
> > For example:
> > PWM0 uses registers 0x0 and 0x4, while Tach0 uses registers 0x8 and 0xc.
> > PWM1 uses registers 0x10 and 0x14, while Tach1 uses registers 0x18 and =
0x1c.
> > ...
> >=20
> > To separate the PWM controller part from the fan inputs, Guenter has
> > provided two methods.
> > The first method involves passing the memory region from an MFD
> > driver, which was the
>=20
> I have no clue how can you pass memory region
> (Documentation/devicetree/bindings/reserved-memory/) from MFD and why
> does it make sense here.
>=20
> > initial method I intended to use. However, it seems that this method
> > does not make sense to you.
> >=20
> > Therefore, I would like to explore the second method suggested by
> > Guenter, which involves providing
> > a sequence of address mappings.

At the risk of saying what others have said: given that there's a single
reset line and a single clock line controlling all of these channels and
given what I recall of how address demuxers work in chips, everything
indicates that this is a single hardware block/device.

So the way that this should be described in DT is:

	pwm@1e610000 {
		reg =3D <0x1e610000 0x100>;
		clocks =3D ...;
		resets =3D ...
	};

That'd be the most accurate representation of this hardware in DT. It is
then up to the driver to expose this in any way you see fit. For Linux
it may make sense to expose this as 16 PWM channels and 16 hardware
monitoring devices. Other operating systems using the same DT may choose
to expose this differently, depending on their frameworks, etc. A simple
operating system may not expose this as separate resources at all but
instead directly program individual registers from this block.

I'd also like to add that I think trying to split this up into multiple
drivers in Linux is a bit overkill. In my opinion, though I know not
everyone shares this view, it's perfectly fine for one driver to expose
multiple types of resources. There's plenty of use-cases across the
kernel where tightly coupled devices like this have a single driver that
registers with multiple subsystems. Going through MFD only because this
particular hardware doesn't split registers nicely along Linux subsystem
boundaries.

So FWIW, I'm fine carrying hwmon code in a PWM driver and I'm equally
fine if PWM code ends up in a hwmon driver (or any other subsystem
really) if that makes sense for a given hardware.

Thierry

--6M5dd0U91g62xbzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2M4UACgkQ3SOs138+
s6E3Ww//aHUH2t/BbrFylE5Y9kU3zPSvSNLVmsRJQ2LmD5P/cCBBqa3Yaala1Rkf
309YuV8mh0tbmDYZZKBpnHsTyGaa/WpVymOS8LP2n2ugzZWdejoO5XNazB1pvXiY
pTnErP2kiN8yvaVhD5leVgS6YzTF3kkvrtmeQy8s8RecYMpEK0OUOFyTsB+xTWoS
gtSwD7sNTGJvxshf71/Zif3EAn49j8BZzzY967j+Y2UU+tsfiH+9IKU9ErOBDvHr
sWNyrZCrxeGY19DJOrci+zmsSn7VV73Ls0+D14J/kJJunvEl5vXWZvWX3sTpaalB
AETPPmAT3fvvE0nWvG+Aczv8eK5B5vAlt9KYEe/IatMP/vtgPS6fmyY0Zlpw3+S2
qL8cdM6DdJ2sOo0xuOvRWMzpuAvzI/kqM8+3ekm7EZ8YEI3AzjQt+yKOo8R41Ngu
w87tmAS7FKGU8azN3i4BZ9CbGhfovJBouAhpGip9C4+7xemIBhOWQd4+5UAagDlK
dzEDyCCd1WekvHQxIKwCa5D1WySRGo8sKlr7uPlVAdYCNC/E6eB6cv0iTljzlg52
p42NKSy4V8xeV5OvoimXeu2/iD3cBqQ1tn586TqhR9WM3NnzKzQ10rCKIOpBgaEj
EfblswZmP4VH2xT9tEZTTx8mGm/EsmNUzopsGsuoOFmRXEYGh/I=
=iKtB
-----END PGP SIGNATURE-----

--6M5dd0U91g62xbzr--
