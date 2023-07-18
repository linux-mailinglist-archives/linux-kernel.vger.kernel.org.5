Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE58757D35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGRNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGRNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:20:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C26F0;
        Tue, 18 Jul 2023 06:20:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so8146565a12.1;
        Tue, 18 Jul 2023 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689686426; x=1692278426;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6bMFs3dhJn8nNDuRaeyVuYgLqQef3PoJkMgo84MWzg=;
        b=VeIyGT+CNlTrpnm5CuMZu8qUpTBS1Y22zH+Q9/OyXCw3g9jVbAxgOxy77L3s+ewAeY
         WmrZ73UK5s+gVYPYrGDRUgpW+mm6BDfB/xCNvfZ9QNgi8nEWCjQeDolc/5UE3hTFr9Ec
         OJnutotesC6zxC4/6T9nrieBezPZp0zL24PuodGIxWzggke7CcD4tXIYdCwSJwVNooRV
         f34cZoa00JbECIiLlGgzjBWeWvSG1LDhewHA1//rXBp7BWk+Jb7hD+B0en2jp9qabIkh
         m/ZOtljpfMCr1SOFb/L0qOU+PLiFvcNNGW/Z2osFM4OT2EPISTtf2Y3En5sI/q4/xFHh
         +p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686426; x=1692278426;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6bMFs3dhJn8nNDuRaeyVuYgLqQef3PoJkMgo84MWzg=;
        b=DZMEz6LrxdI626TzzIkZAOi7JrUSPvXJF7/re3dYs3Q1NkB5Pyt5hRMFqK0O8wXv1d
         hQMvJZp0I45DLoJJSe3j3Eg2Z4A9Oh9ba9JviNnQqo71H3ZfOA6M07sujq7vkhankhwI
         r4we6N8fLCbNLRrp3KDofPmOGOn5Qx6B6Kn+oy4c9taKxx5GPt+IAc1FkWkiTxzCvgXC
         gpQg7m3kWxj88pmdKVUXQWyxNezfEA71yKAE7zYQqWD+JsiTa6sRBGFQJIM/OcyNPByZ
         YJ4pvwVQ5amUPQvdy6K42zg1F/YRbmCTWXMThKfU3UuQ9y4PRIBnFt6AFnoxsjvVX6ll
         ZfsQ==
X-Gm-Message-State: ABy/qLZHpUPniQwSLEYpVCrW3IrWeJ9mOWsbrdLVGWwEyZ2pqy5BwQc+
        hgfA/AroI6cyccTFc58yd9S4QlJlQLw=
X-Google-Smtp-Source: APBJJlFdWnkfLFRDytz3siL9gZwOqzq3nojzvKygMkdop/GIQIx+J12ZgrKGLYzkRmLKHsW6XjOrBA==
X-Received: by 2002:a17:906:109b:b0:988:6526:beaa with SMTP id u27-20020a170906109b00b009886526beaamr15645302eju.40.1689686425590;
        Tue, 18 Jul 2023 06:20:25 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m23-20020aa7c2d7000000b0051def9be785sm1214188edp.85.2023.07.18.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:20:25 -0700 (PDT)
Date:   Tue, 18 Jul 2023 15:20:23 +0200
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
Message-ID: <ZLaRlyzkqRLSqjQc@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
 <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
 <ZLZDL27zzDpY4q8E@orome>
 <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
 <ZLZ6amp5HKUbm5w3@orome>
 <8f32cb8377808a073b043e0adf3ccf5ae5a84c92.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aHHyfbgV8z9OlP4F"
Content-Disposition: inline
In-Reply-To: <8f32cb8377808a073b043e0adf3ccf5ae5a84c92.camel@crapouillou.net>
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


--aHHyfbgV8z9OlP4F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 01:55:05PM +0200, Paul Cercueil wrote:
> Le mardi 18 juillet 2023 =C3=A0 13:41 +0200, Thierry Reding a =C3=A9crit=
=C2=A0:
> > On Tue, Jul 18, 2023 at 10:42:47AM +0200, Paul Cercueil wrote:
> > > Hi Thierry,
> > >=20
> > > Le mardi 18 juillet 2023 =C3=A0 09:45 +0200, Thierry Reding a =C3=A9c=
rit=C2=A0:
> > > > On Mon, Jul 17, 2023 at 09:14:12PM +0200, Paul Cercueil wrote:
> > > > > Hi Andy,
> > > > >=20
> > > > > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a
> > > > > =C3=A9crit=C2=A0:
> > > > > > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > > > > > switch the driver to use it instead of open coded variant.
> > > > > >=20
> > > > > > Signed-off-by: Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com>
> > > > > > ---
> > > > > > =C2=A0drivers/pinctrl/tegra/pinctrl-tegra.c | 5 +----
> > > > > > =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > index 4547cf66d03b..734c71ef005b 100644
> > > > > > --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> > > > > > @@ -747,10 +747,7 @@ static int tegra_pinctrl_resume(struct
> > > > > > device
> > > > > > *dev)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > =C2=A0}
> > > > > > =C2=A0
> > > > > > -const struct dev_pm_ops tegra_pinctrl_pm =3D {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D &=
tegra_pinctrl_suspend,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D &t=
egra_pinctrl_resume
> > > > > > -};
> > > > > > +DEFINE_NOIRQ_DEV_PM_OPS(tegra_pinctrl_pm,
> > > > > > tegra_pinctrl_suspend,
> > > > > > tegra_pinctrl_resume);
> > > > > > =C2=A0
> > > > > > =C2=A0static bool tegra_pinctrl_gpio_node_has_range(struct
> > > > > > tegra_pmx
> > > > > > *pmx)
> > > > > > =C2=A0{
> > > > >=20
> > > > > Another driver where using EXPORT_GPL_DEV_PM_OPS() would make
> > > > > more
> > > > > sense.
> > > >=20
> > > > We don't currently export these PM ops because none of the Tegra
> > > > pinctrl
> > > > drivers can be built as a module.
> > >=20
> > > This doesn't change anything. You'd want to use
> > > EXPORT_GPL_DEV_PM_OPS
> > > (or better, the namespaced version) so that the PM ops can be
> > > defined
> > > in one file and referenced in another, while still having them
> > > garbage-
> > > collected when CONFIG_PM is disabled.
> >=20
> > Looking at the definition of EXPORT_GPL_DEV_PM_OPS(), it will cause
> > an
> > EXPORT_SYMBOL_GPL() to be added. So there very well is a change. And
> > it's a completely bogus change because no module is ever going to use
> > that symbol. If we were to ever support building the pinctrl driver
> > as
> > a module, then this would perhaps make sense, but we don't.
>=20
> In this particular case the EXPORT_SYMBOL_GPL() isn't really important,
> the rest of EXPORT_GPL_DEV_PM_OPS() is.
>=20
> I don't think having a symbol exported it is a big deal, TBH, if you
> use the namespaced version. If you really don't want that, we need a
> version of EXPORT_GPL_DEV_PM_OPS() that doesn't export the symbol.

I do think it's a big deal to export a symbol if there's no reason to do
so.

And please, can we stop adding these macros for every possible scenario?
Maybe I'm just getting old, but I find it increasingly difficult to
understand what all of these are supposed to be. I get that people want
to get rid of boilerplate, but I think we need to more carefully balance
boilerplate vs. simplicity.

I'm seeing the same thing with stuff like those mass conversions to
atrocities like devm_platform_ioremap_resource() and
devm_platform_get_and_ioremap_resource(). There's so much churn involved
in getting those merged for usually saving a single line of code. And
it's not even mass conversions, but people tend to send these as one
patch per driver, which doesn't exactly help (except perhaps for patch
statistics).

Thierry

--aHHyfbgV8z9OlP4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS2kZQACgkQ3SOs138+
s6HgBhAAhwAuon633pi8BN94xr1dLYcAne5Jv2QcWubv151gBKj5trk8auLuyQWD
WQdoJQaGLTpDrNMimkynGjao7RiohRGBdQ1ZkEwP1wr8GtZOv3o6FS+WJ7ZI2rbt
FlzEB+YQb07OV9nHuz7mijpAsqJ3AafUGeorGVof2v/8E/1x1O7alAz1jlgcW7Pv
Imqk9ZyufK/JUkaQEBMPKdPPdi65gHBhl/Zk1Cf4IXgy+W7kClmSQn8lZxwubUHT
EMMnLIZVBtcC49ovLz6EFRnSd9GjScemPO8n4JfyBr1y9Np65ykjTdd4LyVb+mKu
IzrExYTE0sxA2DWWUIaDAHbOgbnEs5P0R8SAZVo9rT85pypwM+fMBpZd0tyin3bB
wzQ0haUdoNeCMH7BOgiRFqSlNNS2hVzOYRs6G7heyPqzfLpxrgU6pJfUpzhlgMlF
C3a2VaiGoytFcSWUGbsmESvasICDB0zouJAiFiQamTNVf87hJQRzDgaE4Q6/MRdr
Nj9KpT1meTP8tgjxZIFVX7jmqMM9WoIotZYuHA91fOokFjNRvVPauurSplm9eHDO
kMTRHmyEGOi7J3aDkD0fGCBXIR+GBWd0CQOAnzemWo35fbXnyjuZFxcdJwfLni8c
TUkJEBMdHRY8gWSAnrQJUtGu7/7iUJKnnCvSU4N1YWEzVPJljsE=
=31l4
-----END PGP SIGNATURE-----

--aHHyfbgV8z9OlP4F--
