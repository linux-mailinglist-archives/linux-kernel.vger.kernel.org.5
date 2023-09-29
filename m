Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA77B3288
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjI2M04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjI2M0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:26:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C0A1B2;
        Fri, 29 Sep 2023 05:26:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a9f139cd94so1785970866b.2;
        Fri, 29 Sep 2023 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695990410; x=1696595210; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHoAEPMCBmD5aMTuTOMQUGoRQ/DwG8nyjqA0CqFXZA8=;
        b=cBtrGcm1gSW3D5yZpE5S9ipHlov4hMB53uFxSz21NNvUhcpzXoJcP2eKRtCAec0vFY
         pbOrYLi71tM9PabJgDsBb8hX3oInVP3QmRaSoHNLuIp1lezBRLuKLn8sw3WWZqjSvgvB
         TXVR373p8pEra1cWmP/z8KdeS5PJEzvm6jQvByePAiNDiUXxqhyKj3Rm0yMhZpkEvYOx
         I/OXq+h4OJKl3EhzqkLoM4J0FfZmizPkKC7O5AnNQigyjNAMpNPKuu9g3E4FH858xhIR
         /zJaGb0xKMKPc692tPO8UoqtZJdrHqXXEgdvcg5cvkckRBdCy8HYbKDrWs+WNszJ5WxF
         +3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695990410; x=1696595210;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHoAEPMCBmD5aMTuTOMQUGoRQ/DwG8nyjqA0CqFXZA8=;
        b=KnFzxNBXViVncOWqoaAJS/NtSChVZuAqUvr6AlaBIscA7J1Wgxy0hjeWqOrZ61QPs4
         taBD6bIYkxc1e1d0F2opT9n8VUhq1EJi/nxx3s9jVOYXaOUTUBT9xvPb+MoUQKFOphP+
         7w3AOZPvj5ivJaAFoBulx4ymktG4jhYNfg2pp5J7IOjn/eTEa90kjtKIbtU8SntRYWev
         02aslksINq6BAuw2XO2VR59veO90adHLx3k/lvOnuy7H9k1XLOKImLLWVxYIVt/j7yyg
         08twAEFtBBqoC8iZTv9j18dj77KsuylVL97vZEJ0xoDXmJoH6VMnu9+6Ue/K002/kQ1J
         +ZRQ==
X-Gm-Message-State: AOJu0YxnMAzChWCqrzkjRFFQLv/ddY8iWcVHJaeHX2k1pw+luGvwY344
        6EBU+yRjK/Bm+CvXZhCv+i+VRntHgiE=
X-Google-Smtp-Source: AGHT+IELJ/fg2a0kWjkmk34qx0atFZS8m8WxUNXyOz4SEPB51VqWdtBl30UHPjWv3JqCCJWgY9YIwA==
X-Received: by 2002:a17:906:cd1:b0:9ae:5120:5147 with SMTP id l17-20020a1709060cd100b009ae51205147mr3368629ejh.38.1695990410032;
        Fri, 29 Sep 2023 05:26:50 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709061d0800b009a19701e7b5sm12442797ejh.96.2023.09.29.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:26:49 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:26:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Prathamesh Shete <pshete@nvidia.com>, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: tegra: Add support to display pin function
Message-ID: <ZRbCh8F79WYvJ9Ni@orome.fritz.box>
References: <0cf720bf-ae4b-5780-bda4-5c9bbb2d1d67@nvidia.com>
 <20230714113547.15384-1-pshete@nvidia.com>
 <20230925183049.10a40546@booty>
 <CACRpkdbZ0cxA_y=6j_QQpF1SQ1q4hw-qUyeOnEK-+cLBd=gjCg@mail.gmail.com>
 <20230928085319.0b09bf7d@booty>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0gWJLgNcozhyKN9n"
Content-Disposition: inline
In-Reply-To: <20230928085319.0b09bf7d@booty>
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


--0gWJLgNcozhyKN9n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 08:53:19AM +0200, Luca Ceresoli wrote:
> Hello Linus, Prathamesh,
>=20
> On Wed, 27 Sep 2023 10:54:15 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>=20
> > On Mon, Sep 25, 2023 at 6:30=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bo=
otlin.com> wrote:
> >=20
> > > The symptom is that i2c3 is not working anymore, the I2C lines being
> > > always high. No other known issues at the moment. =20
> >=20
> > Hm....
> >=20
> > >> +     {"nvidia,function",             TEGRA_PINCONF_PARAM_FUNCTION},=
 =20
> > >
> > > FYI, I reduced your patch to only this line plus the one in the
> > > pinctrl-tegra.h and the problem appears as well. =20
> >=20
> > I think there is a conflict now, that the pinconf is "stealing" the fun=
ction
> > assignment from the pinmux call.
> >=20
> > It's just a debugprint, I will revert the patch, Luca can investigate a=
nd you
>=20
> Thanks for the quick revert Linus.
>=20
> > can test a new patch then we will merge that.
>=20
> Prathamesh, if you send a new patch it would be great if you can Cc: me s=
o I
> can test it.

I was able to reproduce this on tegra20-trimslice, and it looks indeed
that the "shortcut" of supporting this through the pinconf "framework"
doesn't work. In addition to the pinmux now no longer getting applied
(exactly why that is I don't think I understand), it also leads to weird
things in other parts of the debugfs output. For example the code now
ends up trying to read a u32 from the nvidia,function property, which is
actually a string. That seems to be fine, but obviously it doesn't yield
the value that is expected for a function and messes up the config param
which will then later on fail to properly display.

Anyway, turns out the correct implementation is even shorter. I've sent
out a patch.

Thierry

--0gWJLgNcozhyKN9n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUWwocACgkQ3SOs138+
s6HhARAAmgbAGcjIr0Nac+ExNkH8nKRofmVJD97X/UkmeKRxRjQt5uBp5dl9qxHw
6dcg5lnpYgpPfQPE4zfWIbyUKYoVFPrFCq42SUKp6UrarYL6Y7WTl2Ne/VMaAMpD
Gn/MxecaWUZxKF2EGb7KgXHhoCU/qADJQuklfCYbwFNxvLbSdZKZbj40b2E+SObL
dblvPOQZ2bfPgDg/xafu6iymziEaxL/BKIaKKp/R/R8GMUqormZ/ClqIV1bQfVsR
ITdhhJbZcCBlgaycAc+ud2bkUDtJdSy9pc01bHMAWXCqjQB8apUaWy9yi1hwWWt3
mwo5TMuHkLINXp8H/ZRMw1Y3yyaUy0xAixNbr5Ic0ZqKcABMyvMnWl+Qal9P2KNs
l3KxfBOwGWzfP+49ghTCGiLG6GTRb9UErPmCIhOn9Kb6GlqIQy1u0v+z0Zw2g2YM
CCRhXub7NHfvsgxI/4+3WnV8+lCvyuNZvbQ7Kmnj5w++nroR8Vnz8XlMD7tpNXkB
QfqTC6vjxSQTYCadmLTfOXcl3smI9ghUEAS0pMTNu2gcwmARPfK8e781/N9C3Z+n
mFZy0JHqp93pmpwlmZ1Rmr4UYUBEuUCyIdzWOvB4ze3Nv2LTiAqMKe+gD3qWXOwH
qNOEkX8KDPYA/4msPdcReMemkvRNg/H1cZ04cryh8otPLFawMsg=
=uu/I
-----END PGP SIGNATURE-----

--0gWJLgNcozhyKN9n--
