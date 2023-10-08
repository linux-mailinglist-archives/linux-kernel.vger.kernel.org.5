Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F907BCDF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbjJHLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjJHLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:02:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673F0AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:02:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so5997452a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762960; x=1697367760; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2BwMPIdqGU2NqgXy5cot4/7RwrAa6qLkUv4kvr0lFI=;
        b=FG0fFGsy5bXYh3Hix9OvNoIl77cUL7zPwG0OhPrPZmsqcYyOFBs1hF1r7xAMYORIcp
         iS6UTRWTwFsaLTAMpiwGQzYoDr2NxeGxZ6kqETS0T3l+TZj6u1CqNMkiBVSFA2t1cnIE
         Slod4Jw2s4QrZxOQJa0Wp8i9q0gpaKRGBipnwMntG2c5WqnZMemXfo62TwHsgtTGlFV2
         lq3EnSQ6/M7B1TMjHhV99f2njhv8tkgoWKoccVexzSGi5I1S7VXJiwI8al8lf80HLAd/
         D1uZZdEC/TMi2VivllX0XENBs1zTrWWa+AZoNPb+lmq/4OJx6co/U5e937kS98zzhTe5
         IwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762960; x=1697367760;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2BwMPIdqGU2NqgXy5cot4/7RwrAa6qLkUv4kvr0lFI=;
        b=ePyytt6SwIziWI6mamj4YYaFJRdWDHYRkKBSs0oaoJHxMbbgtxYcHRBf1J9kNf+56G
         x2fSwzEiAJiTQxXBODC617W1IQjUZm3M5m+eX2u6EHd/CiK58aBfq70ZKrhBD1kAhNu/
         wpzeCTRqVDFnXItHoQK4QwvGkNdeMkdJiglS/2tYTTAgz54k1vTvv/I/a9sQti8GvKYY
         vNxQyb4t+jVkMiTYn0Qlp6/vYPRhGYik+Vcmf8qLMvxEMmJGr9ZeFzvMlQS/5lDAnG2b
         QDHY0KWzxmOXsxmvQr/ZVgyxLny4zNbqbpjelrR0NJNBV2zVoveks7njHfH0SIMOearL
         CGhw==
X-Gm-Message-State: AOJu0Yw8wXWZBjfj30zb0k17maDK2HG8JJqxRD9exaM+u40gtHvvG3AD
        OQQ1bpstQbVdJWXQ6P43kF+1EjcXL9C4lA==
X-Google-Smtp-Source: AGHT+IHy1m45sSABny17HsA0YPMhRhLbvYZX41pT4wKfbzc5vlhxyd/WQ3jpRgofkFJqcis5pkKN6A==
X-Received: by 2002:aa7:c393:0:b0:533:c55f:582a with SMTP id k19-20020aa7c393000000b00533c55f582amr11125186edq.27.1696762959595;
        Sun, 08 Oct 2023 04:02:39 -0700 (PDT)
Received: from dell.localnet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7d589000000b0052576969ef8sm4832770edq.14.2023.10.08.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 04:02:38 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ASoC: ti: ams-delta: Fix cx81801_receive() argument types
Date:   Sun, 08 Oct 2023 13:02:36 +0200
Message-ID: <4229381.1IzOArtZ34@dell>
In-Reply-To: <8377873.NyiUUSuA9g@dell>
References: <20231007213820.376360-1-jmkrzyszt@gmail.com>
 <2023100811-shakable-derby-0b91@gregkh> <8377873.NyiUUSuA9g@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2707487.BddDVKsqQX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2707487.BddDVKsqQX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 08 Oct 2023 13:02:36 +0200
Message-ID: <4229381.1IzOArtZ34@dell>
In-Reply-To: <8377873.NyiUUSuA9g@dell>
MIME-Version: 1.0

Dnia niedziela, 8 pa=C5=BAdziernika 2023 11:42:50 CEST Janusz Krzysztofik p=
isze:
> Dnia niedziela, 8 pa=C5=BAdziernika 2023 07:04:39 CEST Greg Kroah-Hartman=
 pisze:
> > On Sat, Oct 07, 2023 at 11:38:18PM +0200, Janusz Krzysztofik wrote:
> > > Since types of arguments accepted by tty_ldis_ops::receive_buf() have
> > > changed, the driver no longer builds.
> > >=20
> > > .../linux/sound/soc/ti/ams-delta.c:403:24: error: initialization of '=
void (*)(struct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (=
*)(struct tty_struct *, const unsigned char *, const unsigned char *, unsig=
ned int)'} from incompatible pointer type 'void (*)(struct tty_struct *, co=
nst u8 *, const char *, int)' {aka 'void (*)(struct tty_struct *, const uns=
igned char *, const char *, int)'} [-Werror=3Dincompatible-pointer-types]
> > >   403 |         .receive_buf =3D cx81801_receive,
> > >=20
> > > Fix it.
> > >=20
> > > Fixes: e8161447bb0c ("tty: make tty_ldisc_ops::*buf*() hooks operate =
on size_t")
> > > Fixes: 892bc209f250 ("tty: use u8 for flags")
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > ---
> > >  sound/soc/ti/ams-delta.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > Odd no built-bots caught this, maybe no one normally builds this file?
>=20
> The driver depends on SND, SND_SOC and TTY, but can't be selected=20
> individually, only via its user. =20

Sorry, that was an ASoC board driver, not a CODEC driver, that required the=
=20
fix.

> Then, it usually builds when=20
> CONFIG_SND_SOC_OMAP_AMS_DELTA=3Dy, and that's probably uncommon due to=20
> specific dependencies. =20

In addition to SOUND, SND, SND_SOC and TTY, this ASoC board driver depends=
=20
on MACH_AMS_DELTA, then on ARM, MMU, ARCH_MULTI_V4T, !ARCH_MULTI_V6,=20
!ARCH_MULTI_V7, CPU_LITTLE_ENDIAN, ATAGS, ARCH_OMAP1 and ARCH_OMAP15XX. =20
Let me check if it builds without those machine dependencies, then we can=20
cover it by COMPILE_TEST.

Thanks,
Janusz

> However, cx20442 can also be selected and built=20
> with CONFIG_COMPILE_TEST=3Dy and CONFIG_SND_SOC_ALL_CODECS=3Dy.  Since si=
milar=20
> approach seems to apply to quite a number of ASoC CODECs, maybe build-bot=
s=20
> should pay special attention to select SND_SOC_ALL_CODECS more frequently=
,=20
> like they probably do with COMPILE_TEST.
>=20
> Thanks,
> Janusz
>=20
> > Anyway, I'll pick this up in my tty tree now, thanks!
> >=20
> > greg k-h
> >=20
>=20
>=20


--nextPart2707487.BddDVKsqQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnyr6IsGnTYAeAkHJ2WqSnltsjBoFAmUijEwACgkQ2WqSnlts
jBqpygf/TZYnhnJ79SYUbtDpvKJvQn4573Q7v/l2znOGa1OJTKp7WpamhXlqXOct
rTHSJ4md10EXlw3e7OhmSWwP4fhrMIASzHYYPmlX7LYXZedRkSbaOFC+kOSDhKYW
ZHhJrEfTOpfd968L/0cLd2Sg913OJqYQzThlUXk40v3VQNnkSZMH9Ma/DqasAOWE
j8MmaxtqOEwuQwFNoOnwAHGcHz5fMO2xgijTrhpMrZLx8cWLoY/1DuFk1jUBy9B7
/27avelGo4+IhBSC6ysZa6QueVOrfUWGcFnsXwUG6SCE4AMh11z3mecoSlwO8jcB
hEoZ+9f8JJ3bRxtCUDvAm0mTkc0i0g==
=cxua
-----END PGP SIGNATURE-----

--nextPart2707487.BddDVKsqQX--



