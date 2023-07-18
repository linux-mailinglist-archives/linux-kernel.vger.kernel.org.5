Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6A75759E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGRHqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGRHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:45:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27675DD;
        Tue, 18 Jul 2023 00:45:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so7250562a12.1;
        Tue, 18 Jul 2023 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689666354; x=1692258354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgoXCsaS2C8T63iw0Ey5t0C4UKRq0GEpZhQp7ds0RYw=;
        b=f39YUFrJDUhhZxuS6hFWWTKiL58Bl+A9uFWkDZJUSd5vLVCe095S4TzcDAKrSeBFhg
         67QDUoh4u3FfH8Aisz++yS92FBJegkaGbodLy0xIbJNAZh1dO1Ak4d1ago2lB3JBkOUt
         i6F68cVuyixXOxR/FSSliCgDyrbvqbfd8C/FSx3z2llLLC9WxUFbgVe35EI0RZfn5kUZ
         xYCGyejBAoRrgmof3FcfOaYjnQmZOhi+nqjjv8ANYiSdstXckwhD19NqVz+3wc/d7Kfk
         StANGJAJz2j00CsgQzq2j0jEHZ7dL9Drs14R6tDmFmGiJSjWgXYGcT5QVX5fMnLAdlO7
         K9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666354; x=1692258354;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgoXCsaS2C8T63iw0Ey5t0C4UKRq0GEpZhQp7ds0RYw=;
        b=A3YtJDUtc/8JUYjHmhk4WwX8iyA0TKn0ykmoQ8kA3ugYSfN+ue1GyxwwJMk8HpL96f
         VZCr0zGRlIvZFpz1YE0nEn9etXkdakJGaeOGUwQz9jqPTxfnAPwdhQdslIGj1Q+EpkTu
         SK8KuTu3ivHZ3C4fUPRXdakYb8m3Tiq+Sm8/NT9uOCYML2apL7iic8ym1Avv6I8I2gHq
         1ejXcdcxaqzyFL1WmEMKtL205WTN5JFwuZ08RkKuXGUyt8WSXI9P8JOU8q5TOwa9qiT4
         TwQxyxXtKLZj6UYz/iYdCuMGnvPWa2PGHsZl1sR3yOk4UOh3sINv5QPUT+va6aB6FUd+
         kHLg==
X-Gm-Message-State: ABy/qLZEJcqu5kipUxj+49qDul4OqDocr/s5F3T/WAfnXb3fg9AjnSJj
        8ptAHipL+OEeLHaDvDHU8Hk=
X-Google-Smtp-Source: APBJJlHNN+UfI4mMJACRlXNcvMgEJJl7q1fQMpJLNe0EjzLet3w62Y8m4100hJ2OaqQIy1TaCe0Uhw==
X-Received: by 2002:a17:907:3a49:b0:988:f1ec:7400 with SMTP id fc9-20020a1709073a4900b00988f1ec7400mr10816811ejc.36.1689666354374;
        Tue, 18 Jul 2023 00:45:54 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906119a00b00991e2b5a27dsm671067eja.37.2023.07.18.00.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:45:54 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:45:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Message-ID: <ZLZDL27zzDpY4q8E@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
 <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YpHy1Bd1lMbYUgMr"
Content-Disposition: inline
In-Reply-To: <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
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


--YpHy1Bd1lMbYUgMr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 09:14:12PM +0200, Paul Cercueil wrote:
> Hi Andy,
>=20
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > switch the driver to use it instead of open coded variant.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0drivers/pinctrl/tegra/pinctrl-tegra.c | 5 +----
> > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > index 4547cf66d03b..734c71ef005b 100644
> > --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > @@ -747,10 +747,7 @@ static int tegra_pinctrl_resume(struct device
> > *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > =C2=A0
> > -const struct dev_pm_ops tegra_pinctrl_pm =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D &tegra_pi=
nctrl_suspend,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D &tegra_pin=
ctrl_resume
> > -};
> > +DEFINE_NOIRQ_DEV_PM_OPS(tegra_pinctrl_pm, tegra_pinctrl_suspend,
> > tegra_pinctrl_resume);
> > =C2=A0
> > =C2=A0static bool tegra_pinctrl_gpio_node_has_range(struct tegra_pmx *p=
mx)
> > =C2=A0{
>=20
> Another driver where using EXPORT_GPL_DEV_PM_OPS() would make more
> sense.

We don't currently export these PM ops because none of the Tegra pinctrl
drivers can be built as a module.

Thierry

--YpHy1Bd1lMbYUgMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2Qy8ACgkQ3SOs138+
s6E2zA//adgY1czrgMP7ZiR05NoGmst/GDCFMtTNNjoFKJ+5qLILfen7dukvYsaX
thipJMAflV2Dwp6V8qH+E07id61JFjOPdr7/swudmhqZvmXNmCuZpzwHyEDQRnO2
iKg3hMJeAbUBH11v8REz5mKMYLVHrqY3p0CrDENV5fi82reSfhzrl2dPfq4N1kTi
S2oaewVmBniiPcL+3mTwHP95sbvFdku/bazMrqzVXUYdBqqFaoKdTpbGW6znNxCt
UzPqJsINFesWbGNNsEACeurrn5tCCFKxa+mxCFuS4/NkZHflNGS0sofQD8kKIWP+
uuAOIz2OUWmenYbdRe7JauuO7+yotpcyJv7X+HOp1BXwd8hAoD1weqf5RPO71mTc
9PWzSvVMfQMb0s3LFkAEBYebGOpfXS4lwXRDxr1+L/1H0GoHoo1lrubRLsFj8e1G
3GpCXNukxSq5Fqjp+fR31U/r/wF6UhIwUz0466nQGmVYtCbNKDo3jLaHqDpEoRr/
7x/+KOjTuZ0NEFcNIGBPg1aB/YSCLfbh3IWf25KqhzOSUbaRs0TVHC0g3cweZWSi
KzGaKQlaD8MQifTlcdtOUKKvTxZO68BWTqCxElRrDSGUXHIoRVPP9x/+xqLHhlj9
6Zv9zW/zhvy5mWQojaAsrFEbLtMY7QtP/V9rFY9fo3GFMFtEL3k=
=ww71
-----END PGP SIGNATURE-----

--YpHy1Bd1lMbYUgMr--
