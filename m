Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12C97BCD98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbjJHJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjJHJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:42:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375DB9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:42:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a6190af24aso629330666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696758173; x=1697362973; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lP/7ULAM9+WQiUpJUWU4z8ftc3NIktylhbgnBvh3NrQ=;
        b=kFpr/MyRuh+MJ/4A2LdS2tIongq60+El5/bMQ3cuuETeBi9sBtLK5JgspT8z3jDjXY
         kg+Ke6amPwyo7hUhFBRDi9cgMOmklBmCzrqBr1f0HfSqZDyH5fkmTaB70hI3TWEm17yl
         rVkFv83KEXFpj+D/BYS1JlLSrDzODnEOhtbPigkuetSXLCAF1LPHkGEebraJFqUyViDE
         TH3lPi1Pk2qQET0x6Ht+hLzAO+BFf5f3yeaiNDuRgMd+RijtFh95AM1BUbB8Ag2AHDo5
         atYN5eX6gb5ArF56ws99cx5BAxCv35M+WNbcR6gDUddAM/bO1LtZ2y94DhEff4tyb02Q
         TAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696758173; x=1697362973;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lP/7ULAM9+WQiUpJUWU4z8ftc3NIktylhbgnBvh3NrQ=;
        b=tZy77Gtnx/zHJteUX0lklumCVeNbeL9Wcvpr2Qsv+wGvuyi7WJDIUHPxx3B6BijstF
         nQj3bDUpyMPnzXj3yTrQXkNuvQmrga7JDIDw7Z15K+c4VUVitrv6g2rWYSmbnIdS7pCP
         Y4k3G48d9M8wlM5mFLUDXkh7j1U1d+jOtrqzyqBVE51MWazzAF02pMiznq63O00YBP9q
         MzLS3BrgXbmE4D10V63YXhwAnP7GFfznnp2Rs9z5L3C+r5Rc/ihBLfRPN/KqbFUmmo+v
         tYX4nWyV7Wx+imWFnxbH2Uo/8kHq9KFTTc38D+C5dgRLjjqN0owEbipQ2e5wzPGYbmG2
         HclQ==
X-Gm-Message-State: AOJu0YyW5IqfttZkaVcaLuJ1e+RcWpeWf1xH3wkUdsCfSIJudkOH7bk2
        3jrbsOciHEW+0CR/crbgxfU=
X-Google-Smtp-Source: AGHT+IEe2fggWDSeVlV9pKWqnZBGnikPolHgDSe8Af4up5YpfSy3vb0xw1nNuPvKeglzxm0UKs91dA==
X-Received: by 2002:a17:907:762d:b0:9ad:99a8:7c53 with SMTP id jy13-20020a170907762d00b009ad99a87c53mr10757802ejc.60.1696758173361;
        Sun, 08 Oct 2023 02:42:53 -0700 (PDT)
Received: from dell.localnet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090628d000b009b654ba498csm5344816ejd.90.2023.10.08.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:42:52 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Fix cx81801_receive() argument types
Date:   Sun, 08 Oct 2023 11:42:50 +0200
Message-ID: <8377873.NyiUUSuA9g@dell>
In-Reply-To: <2023100811-shakable-derby-0b91@gregkh>
References: <20231007213820.376360-1-jmkrzyszt@gmail.com>
 <2023100811-shakable-derby-0b91@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2022001.usQuhbGJ8B";
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

--nextPart2022001.usQuhbGJ8B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 08 Oct 2023 11:42:50 +0200
Message-ID: <8377873.NyiUUSuA9g@dell>
In-Reply-To: <2023100811-shakable-derby-0b91@gregkh>
MIME-Version: 1.0

Dnia niedziela, 8 pa=C5=BAdziernika 2023 07:04:39 CEST Greg Kroah-Hartman p=
isze:
> On Sat, Oct 07, 2023 at 11:38:18PM +0200, Janusz Krzysztofik wrote:
> > Since types of arguments accepted by tty_ldis_ops::receive_buf() have
> > changed, the driver no longer builds.
> >=20
> > .../linux/sound/soc/ti/ams-delta.c:403:24: error: initialization of 'vo=
id (*)(struct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (*)=
(struct tty_struct *, const unsigned char *, const unsigned char *, unsigne=
d int)'} from incompatible pointer type 'void (*)(struct tty_struct *, cons=
t u8 *, const char *, int)' {aka 'void (*)(struct tty_struct *, const unsig=
ned char *, const char *, int)'} [-Werror=3Dincompatible-pointer-types]
> >   403 |         .receive_buf =3D cx81801_receive,
> >=20
> > Fix it.
> >=20
> > Fixes: e8161447bb0c ("tty: make tty_ldisc_ops::*buf*() hooks operate on=
 size_t")
> > Fixes: 892bc209f250 ("tty: use u8 for flags")
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> >  sound/soc/ti/ams-delta.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Odd no built-bots caught this, maybe no one normally builds this file?

The driver depends on SND, SND_SOC and TTY, but can't be selected=20
individually, only via its user.  Then, it usually builds when=20
CONFIG_SND_SOC_OMAP_AMS_DELTA=3Dy, and that's probably uncommon due to=20
specific dependencies.  However, cx20442 can also be selected and built=20
with CONFIG_COMPILE_TEST=3Dy and CONFIG_SND_SOC_ALL_CODECS=3Dy.  Since simi=
lar=20
approach seems to apply to quite a number of ASoC CODECs, maybe build-bots=
=20
should pay special attention to select SND_SOC_ALL_CODECS more frequently,=
=20
like they probably do with COMPILE_TEST.

Thanks,
Janusz

> Anyway, I'll pick this up in my tty tree now, thanks!
>=20
> greg k-h
>=20


--nextPart2022001.usQuhbGJ8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnyr6IsGnTYAeAkHJ2WqSnltsjBoFAmUieZoACgkQ2WqSnlts
jBob6wgAl3S4Ml9Wnt+xOL4qHEP1vxoT24Jwx7U1lkOXtuc2CLAj2fn+kNsywAKq
YC2lcIjbRJQU9sK7NYKMry/UfLjxGiIFCRh88aui1P67uN+1DrmNESYrZEXWwIVr
BF5X7jrx/kF+3XKNk1lg9q1vis/xMV/32U3heVpAo0G4j4WXcHHVED6FZytRIo/y
m+UMfxMxW7GSWY+RnRV8aD182r42+o+alewScrEMdBhaJdze5eM6rP+1Wqrx535f
+xPNfd+nlgoqexzG6T/OUOKQ9h34f3tjXmpCqQt4E2HJfeNDNudUbbRlSj72dHEq
zPdob4yMG6yCsuo8WTgp1CMkPoQ4PQ==
=XqZT
-----END PGP SIGNATURE-----

--nextPart2022001.usQuhbGJ8B--



