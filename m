Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03B75751C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjGRHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGRHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:15:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4040110C0;
        Tue, 18 Jul 2023 00:14:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9928abc11deso740849966b.1;
        Tue, 18 Jul 2023 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689664498; x=1692256498;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnpKtK98eWniw+QQGcMqsflbYqKRBaBydeIwxyFDILE=;
        b=m4pH/zT+DKmOFoZoscmxaV7Kdwy0B56Own15J7zC2TckUE3LwuJfmdhuJPnIslZbNk
         7t9u4a0+d+6hrlL50FGYrB+0YveI0/c2V7NfwXI8KBlPcNdsDoZ+NqMaGH9hg6dtgGQ/
         axztbKrCGM+exVVaE+gbeoNJArl4lLiFX61Zl+WknPL3hZg5itfKhBNH1i2PEP7Ziyrw
         zzrxg9drOottfyMomEOuStRyatZNhJzRC4lnHnGSV/qmSJON9eui2FUOhFjWtOVSqL8S
         Z+YuCVFt40nFwknNjlz134SJc/4UXWJe8R+fZk8uSvZ0rUUslPdhEnWIsOUp8ORGLTGd
         gPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664498; x=1692256498;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnpKtK98eWniw+QQGcMqsflbYqKRBaBydeIwxyFDILE=;
        b=Wlgh79aL6I/S1ph3MptkJ8S16Kujl4ysVHKUsny5I4AhQS8kPGsjy3pRbiBebvW3kq
         Ux7HbbFLO4WX0cS6m3GrOA+OdhOYIBaRhYPYM3EXWexWjbIRs0Nymia7DFQf/N8W0yd+
         qR8Xma3d8wl/4lnx/UuDm7t7yzHwYtB3rXaBMuEzJ1fBwmjs8xOAutlw9hHCWfZg7rPY
         AjnxQIBMpGt7sgMyksifXJjpGc+cEE3gNWDgtE4N6dbZxBL+p9zBsF2ozN92EI2hVWgY
         cEI/9kp2dV+OJcQoIVLi+z0/BWQe93gg3960iU6i2+KvuHxGdRq9GMgLT1in93TUv+L8
         vkPQ==
X-Gm-Message-State: ABy/qLYIHEsUkrkiR24Pdhl5V04+b7FT/LSxhrPy3mrSi8SBteE8FybI
        fYNyKdS2JSuJEU31Y2H1AbA=
X-Google-Smtp-Source: APBJJlEFdG8t3DQ8rUQtaucSoGPQ0mmVmKRdvJBEzO82biA1GmtF1Tw0+jTZYmZ3o1WzDT+DMDILmA==
X-Received: by 2002:a17:906:150:b0:979:dad9:4e9 with SMTP id 16-20020a170906015000b00979dad904e9mr13385553ejh.50.1689664497376;
        Tue, 18 Jul 2023 00:14:57 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906141400b00992b2c55c67sm618032ejc.156.2023.07.18.00.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:14:57 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:14:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?utf-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Message-ID: <ZLY779Bc4LpJ0TER@orome>
References: <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
 <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
 <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
 <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
 <ZLYziWcIWcNnzMXR@orome>
 <709d738c-3bf3-d808-4172-468d7ad947d7@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qrzPy44n6zH1YQcM"
Content-Disposition: inline
In-Reply-To: <709d738c-3bf3-d808-4172-468d7ad947d7@roeck-us.net>
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


--qrzPy44n6zH1YQcM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 11:54:26PM -0700, Guenter Roeck wrote:
> On 7/17/23 23:39, Thierry Reding wrote:
> > On Tue, Jul 18, 2023 at 08:04:24AM +0200, Krzysztof Kozlowski wrote:
> > > On 18/07/2023 06:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> > > > >=20
> > > > > On 17/07/2023 11:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> > > > > > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=E6=
=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:00=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > > > > >=20
> > > > > > > On 7/16/23 09:08, Krzysztof Kozlowski wrote:
> > > > > > >=20
> > > > > > > [ ... ]
> > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > This patch serial doesn't use to binding the fan control =
h/w. It is
> > > > > > > > > used to binding the two independent h/w blocks.
> > > > > > > > > One is used to provide pwm output and another is used to =
monitor the
> > > > > > > > > speed of the input.
> > > > > > > > > My patch is used to point out that the pwm and the tach i=
s the
> > > > > > > > > different function and don't need to
> > > > > > > > > bind together. You can not only combine them as the fan u=
sage but also
> > > > > > > > > treat them as the individual module for
> > > > > > > > > use. For example: the pwm can use to be the beeper (pwm-b=
eeper.c), the
> > > > > > > > > tach can be used to monitor the heart beat signal.
> > > > > > > >=20
> > > > > > > > Isn't this exactly the same as in every other SoC? PWMs can=
 be used in
> > > > > > > > different ways?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > ... and in every fan controller. Not that it really makes sen=
se because
> > > > > > > normally the pwm controller part of such chips is tied to the=
 fan input,
> > > > > > > to enable automatic fan control, but it is technically possib=
le.
> > > > > > > In many cases this is also the case in SoCs, for example, in =
ast2500.
> > > > > > > Apparently this was redesigned in ast2600 where they two bloc=
ks are
> > > > > > > only lightly coupled (there are two pwm status bits in the fa=
n status
> > > > > > > register, but I have no idea what those mean). If the blocks =
are tightly
> > > > > > > coupled, separate drivers don't really make sense.
> > > > > > >=20
> > > > > > > There are multiple ways to separate the pwm controller part f=
rom the
> > > > > > > fan inputs if that is really necessary. One would be to provi=
de a
> > > > > > > sequence of address mappings, the other would be to pass the =
memory
> > > > > > > region from an mfd driver. It is not necessary to have N inst=
ances
> > > > > > > of the fan controller, even if the address space is not conti=
nuous.
> > > > > > >=20
> > > > > >=20
> > > > > > Hi Guenter,
> > > > > >=20
> > > > > > May I ask about the meaning of the sequence of address mappings=
? It appears
> > > > > > to consist of multiple tuples within the 'reg' property, indica=
ting
> > > > > > the usage of PWM/Tach
> > > > > > registers within a single instance. After that I can use the dt=
s like following:
> > > > > >=20
> > > > > > pwm: pwm@1e610000 {
> > > > > > ...
> > > > > > reg =3D <0x1e610000 0x8
> > > > > > 0x1e610010 0x8
> > > > > > 0x1e610020 0x8
> > > > > > 0x1e610030 0x8
> > > > > > 0x1e610040 0x8
> > > > > > 0x1e610050 0x8
> > > > > > 0x1e610060 0x8
> > > > > > 0x1e610070 0x8
> > > > > > 0x1e610080 0x8
> > > > > > 0x1e610090 0x8
> > > > > > 0x1e6100A0 0x8
> > > > > > 0x1e6100B0 0x8
> > > > > > 0x1e6100C0 0x8
> > > > > > 0x1e6100D0 0x8
> > > > > > 0x1e6100E0 0x8
> > > > > > 0x1e6100F0 0x8>;
> > > > >=20
> > > > >=20
> > > > > Uh, no... I mean, why? We keep pointing out that this should not =
be done
> > > > > differently than any other SoC. Open any other SoC PWM controller=
 and
> > > > > tell me why this is different? Why this cannot be one address spa=
ce?
> > > >=20
> > > > Hi Krzysztof,
> > > >=20
> > > > This is because the register layout for PWM and Tach is not continu=
ous.
> > > > Each PWM/Tach instance has its own set of controller registers, and=
 they
> > > > are independent of each other.
> > >=20
> > > Register layout is not continuous in many other devices, so again - w=
hy
> > > this must be different?
> > >=20
> > > >=20
> > > > For example:
> > > > PWM0 uses registers 0x0 and 0x4, while Tach0 uses registers 0x8 and=
 0xc.
> > > > PWM1 uses registers 0x10 and 0x14, while Tach1 uses registers 0x18 =
and 0x1c.
> > > > ...
> > > >=20
> > > > To separate the PWM controller part from the fan inputs, Guenter has
> > > > provided two methods.
> > > > The first method involves passing the memory region from an MFD
> > > > driver, which was the
> > >=20
> > > I have no clue how can you pass memory region
> > > (Documentation/devicetree/bindings/reserved-memory/) from MFD and why
> > > does it make sense here.
> > >=20
> > > > initial method I intended to use. However, it seems that this method
> > > > does not make sense to you.
> > > >=20
> > > > Therefore, I would like to explore the second method suggested by
> > > > Guenter, which involves providing
> > > > a sequence of address mappings.
> >=20
> > At the risk of saying what others have said: given that there's a single
> > reset line and a single clock line controlling all of these channels and
> > given what I recall of how address demuxers work in chips, everything
> > indicates that this is a single hardware block/device.
> >=20
> > So the way that this should be described in DT is:
> >=20
> > 	pwm@1e610000 {
> > 		reg =3D <0x1e610000 0x100>;
> > 		clocks =3D ...;
> > 		resets =3D ...
> > 	};
> >=20
> > That'd be the most accurate representation of this hardware in DT. It is
> > then up to the driver to expose this in any way you see fit. For Linux
> > it may make sense to expose this as 16 PWM channels and 16 hardware
> > monitoring devices. Other operating systems using the same DT may choose
>=20
> It is single chip. It should be a single hardware monitoring device with
> 16 channels. I don't even want to think about the mess we'd get if people
> start modeling a single chip as N hardware monitoring devices, one for
> each monitoring channel supported by that chip. It would be even more mes=
sy
> if the driver supporting those N devices would be marked for asynchronous
> probe, which would result in random hwmon device assignments.

Sorry, I badly worded it. What I meant to say was: one hardware
monitoring device with 16 channels.

> > to expose this differently, depending on their frameworks, etc. A simple
> > operating system may not expose this as separate resources at all but
> > instead directly program individual registers from this block.
> >=20
> > I'd also like to add that I think trying to split this up into multiple
> > drivers in Linux is a bit overkill. In my opinion, though I know not
> > everyone shares this view, it's perfectly fine for one driver to expose
> > multiple types of resources. There's plenty of use-cases across the
> > kernel where tightly coupled devices like this have a single driver that
> > registers with multiple subsystems. Going through MFD only because this
> > particular hardware doesn't split registers nicely along Linux subsystem
> > boundaries.
> >=20
> > So FWIW, I'm fine carrying hwmon code in a PWM driver and I'm equally
> > fine if PWM code ends up in a hwmon driver (or any other subsystem
> > really) if that makes sense for a given hardware.
> >=20
>=20
> I am fine either way as well, as long as we are talking about a single
> hwmon device and not 16 of them.

Excellent. Should make it pretty clear in which direction this should
go.

Thierry

--qrzPy44n6zH1YQcM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2O+8ACgkQ3SOs138+
s6EYWw/9HhCW64NMvU75PTpx/u+bWywB+D2iZNRyQKlXNPl1hO5Hx16z+74eOLN3
QUqscREyVwjIi2XciYXmgj7uGZMhTC6WxAbXAYlwtFyyxzrd+jbWlb55DV52EJZT
SGhnxKBQx3WaFyEwPn2BhUXiGA3YFLpzTJ33DC+ErkSEA+JKl6q2bn6QPshKHq1R
1NtTOmj5HmuViALp7H1XZnhbig5CkVSIkqSQ3DQmqW9AXHqjEYY4jm0DO6Q6IXGs
Yu5ipEZU7wGGEnHntx/02luCyXL41yPdQee4S8d7Qq1M2qA3DrGmT54nByS7xoFb
yy76xt4JJJJS97js3d/e9paggU0wCdM+S+0KJvKaN4XU8RVxhEjtvAoLBZ3i1dPs
uD+MKXb/ZULQCwtpRWdlAgaORwbVomz8X3pjFDMGpy41qky70KjudQKVfhsgqXKg
bIdoN3whD0L5zIhsVmoX10utrhI9a/VTkHza/f/CTVuapxCdEZC9crk0/OZfsBQY
ZCGzHvFyeyTwXtNJuajTDl4QufBvlXoHaTeY2xi93jxCGjiq9MN5+FRQYnfU5fhe
P3vKLCBiRvJEFR1IDYWCT0K+4DNzP9hjElVUvwxfbocBCOyO02EQuaqXM8cfOFZz
Qb++3fMiMRwFR2s56NOIi0189sAxvUwUCVVpEeHDBgAqX2QawRM=
=nqHD
-----END PGP SIGNATURE-----

--qrzPy44n6zH1YQcM--
