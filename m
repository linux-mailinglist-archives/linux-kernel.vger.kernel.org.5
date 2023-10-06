Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB57BB4C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjJFKFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjJFKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:05:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAAA9F;
        Fri,  6 Oct 2023 03:05:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8316C433C8;
        Fri,  6 Oct 2023 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696586748;
        bh=8PFHT//NMbMZR23rMrKHsrDEG54VwQXT1ipKQX/aKUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzIpDAmqqmws/MQtX+6LJJuiOg9b8f3tG0FT9Af2tBkJwJGO3laO4Qxy2YepUrrQL
         JKXpxd3UUFR6oBsLy/pVb7ODa2f6Nj+mGwgtkXwmPdlMaxiHZLCEezOBWeZdUYshHH
         Z7r0l+pBPJNVF6H5lNSxlnYpEiCIdRRHmsRsMRI78jOR8P4NHUL6FKcSi2t2CBJeh5
         af4NQJ9uTc/uHsPuX7xfEsUOIkCNJILryGvygHnWL3LpZrpreh1EogQ4iKjiSfOmlr
         wHWWveFozv+Bsn/VUCKour1nCUWDhkmLDGth92Jvhc3W19jdp/daR6uxjYehzXFS/e
         i5ah4xIyn6OSw==
Date:   Fri, 6 Oct 2023 12:05:45 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com, msp@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
Message-ID: <jgfb66mjw6nfdypfazpjyhdprackhgdpwyx2moohpj7kzz3rii@lvvkt4upxo4e>
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
 <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
 <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
 <jv6daj2w3pwjtde3m3m26yg4wyxbbio4zqra5yqc4gb32ri5ub@noinbbkjovwm>
 <25724ee3-858a-01eb-352b-3edbfad31c8e@collabora.com>
 <jxgy2pvns4ri2aj5nmdhb4zbluseuzdejbplh2avwz63df2cfx@grrrdm6ujzi4>
 <24d17b07-1e8d-05f6-46b7-9da1ff1bed7a@collabora.com>
 <hd2ydj33vp3dsri4czx6frxxvir6vxnovc27n6rrgs4qqbtrjz@whhyt2iinq5k>
 <d88b72f1-6a60-dc7d-6922-1dde278a61db@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75xqvzb34y2tmjoa"
Content-Disposition: inline
In-Reply-To: <d88b72f1-6a60-dc7d-6922-1dde278a61db@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75xqvzb34y2tmjoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 06:29:41PM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/07/23 11:03, Maxime Ripard ha scritto:
> > On Mon, Jul 17, 2023 at 04:30:48PM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > > > > > AFAIK the recommended way to deal with this is to use
> > > > > > > clk_set_rate_exclusive() and co. in whatever consumer driver =
that
> > > > > > > needs exclusive control on the clock rate.
> > > > > >=20
> > > > > > I guess it works, but it looks to me like the issue here is tha=
t the
> > > > > > provider should disable it entirely? My expectation for
> > > > > > clk_set_rate_exclusive() is that one user needs to lock the clo=
ck rate
> > > > > > to operate properly.
> > > > > >=20
> > > > > > If the provider expectation is that the rate or parent should n=
ever
> > > > > > changed, then that needs to be dealt with at the provider level=
, ie
> > > > > > through the clk_ops.
> > > > > >=20
> > > > > > > However I'm not sure if that works for parents. It should, gi=
ven the
> > > > > > > original use case was for the sunxi platforms, which like the=
 MediaTek
> > > > > > > platform here has 2 PLLs for video related consumers, but I c=
ouldn't
> > > > > > > find code verifying it.
> > > > > >=20
> > > > > > If you want to prevent clocks from ever being reparented, you c=
an use
> > > > > > the new clk_hw_determine_rate_no_reparent() determine_rate
> > > > > > implementation.
> > > > > >=20
> > > > >=20
> > > > > We want the clocks to be reparented, as we need them to switch pa=
rents as
> > > > > explained before... that's more or less how the tree looks:
> > > > >=20
> > > > > TVDPLL(x) -> PLL Divider (fixed) -> MUX -> Gate -> Controller
> > > > >=20
> > > > > Besides, I think that forcing *one* parent to the dp/edp mux woul=
d produce a
> > > > > loss of the flexibility that the clock framework provides.
> > > > >=20
> > > > > I again want to emphasize on the fact that TVDPLL1 and TVDPLL2 ar=
e *identical*
> > > > > in specs, and on that there will never be a MT8195 SoC that has o=
nly one of
> > > > > the two PLLs, for obvious reasons...
> > > > >=20
> > > > > P.S.: If you need more context, I'll be glad to answer to any oth=
er question!
> > > >=20
> > > > Then I have no idea what the question is :)
> > > >=20
> > > > What are you trying to achieve / fix, and how can I help you ? :)
> > >=20
> > > Chen-Yu, Alexandre had/have questions about if there was any other so=
lution instead
> > > of using the solution of *this* commit, so, if there's any other bett=
er solution
> > > than the one that I've sent as this commit.
> > >=20
> > > I'm the one saying that this commit is the best solution :-P
> >=20
> > I went back to the original patch, and my understanding is that, when
> > running two output in parallel, the modeset of one can affect the second
> > one, and that's bad, right?
> >=20
> > If so, then you usually have multiple ways to fix this:
> >=20
> >   - This patch
> >   - Using clk_set_rate_exclusive like Chen-Yu suggested
> >   - Using a notifier to react to a rate change and adjust
> >=20
> > I'm not aware of any "official" guidelines at the clock framework level
> > regarding which to pick and all are fine.
> >=20
> > My opinion though would be to use clk_set_rate_exclusive(), for multiple
> > reasons.
> >=20
> > The first one is that it models correctly what you consumer expects:
> > that the rate is left untouched. This can happen in virtually any
> > situation where you have one clock in the same subtree changing rate,
> > while the patch above will only fix that particular interference.
> >=20
> > The second one is that, especially with DP, you only have a handful of
> > rates you'll need to reach. 148MHz, 297MHz, 594MHz, and possibly a bunch
> > of others for eDP panels. It's thus likely to have both controllers
> > having the same frequency requirement, and thus it makes it possible to
> > run from only one PLL and shut the other down.
> >=20
> > This patch will introduce orphan clocks issues that are always a bit
> > bothersome. A notifier would be troublesome to use and will probably
> > introduce glitches plus some weird interaction with scrambling if you
> > ever support it.
> >=20
> > So, yeah, using clk_set_rate_exclusive() seems like the best option to =
me :)
> >=20
> > Maxime
>=20
> Sorry for resurrecting a very old thread, I was able to come back to this=
 issue
> right now: there's an issue that I can't really think about how to solve =
with
> just the usage of clk_set_rate_exclusive().
>=20
> Remembering that the clock tree is as following:
> TVDPLL(x) -> PLL Divider (fixed) ->
> -> MUX (can choose any of TVDPLL(1/2)_d(2/4/6/8/16)) -> Gate -> Controller
>=20
> The DPI driver is doing:
> 1. Check the best factor for setting rate of a TVDPLL
> 2. Set rate of one TVDPLL (specified in DT): clk_set_rate(dpi->tvd_clk, r=
ate);
>    2a. Read the rate of that PLL again to know the precise clock output
> 3. Set rate on the Gate clock (forwards to MUX, selecting TVDPLL(x)_d(y)):
>    clk_set_rate(dpi->pixel_clk, rate);
>=20
>=20
> Now, the issue is: if I change the final pixel_clk rate setting to _exclu=
sive(),
> nothing still guarantees that we will be selecting the TVDPLL that we have
> manipulated in step 2, look at the following example.
>=20
> tvd_clk =3D=3D TVDPLL1
> pixel_clk =3D=3D TOP_DP (can be muxed to any tvdpll1/2 dividers!)
>=20
> clk_set_rate(tvdpll1, something); new_rate =3D clk_get_rate(tvdpll1)
>=20
> ...calculations... new_rate =3D pixclk * factor;
> ...more calculations....
>=20
> clk_set_rate(pixel_clk, calculated_something)
>        ^^^^^^
>=20
> There is still no guarantee that pixel_clk is getting parented to one of =
the
> TVDPLL1 dividers, as it could still get parented to a TVDPLL2 divider ins=
tead
> if the other controller has set TVDPLL2 to "an acceptable rate": it's tru=
e that
> this would work - yes but suboptimally! - because we want to set a specif=
ic
> factor to reduce jitter on the final pixel clock.

If your clock ends up with a suboptimal set of parameters, you have a
problem with determine_rate.

> ....And I came back to this commit being again the best solution for me b=
ecause....
>=20
> 1. You also seem to agree with me that a notifier would be troublesome an=
d would
>    probably introduce glitches; and
> 2. clk_set_rate_exclusive() doesn't give me any guarantee about selecting=
 the same
>    PLL that the driver was manipulating before.
>=20
>=20
> Am I underestimating and/or ignoring anything else in all of that?

I guess I'm still confused about why you want to allow reparenting in
the first place, but still don't want to reparent to the other PLL?

Anyway, it's not a big deal. Whatever works for you I guess :)

Maxime

--75xqvzb34y2tmjoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZR/b+QAKCRDj7w1vZxhR
xSmtAQDmKsVFm7LxpronCns/ubhF36eZSB4LCFVSHzfsHkN5/AEAgl17iNbKTAIp
0jl5NxH23VLajNx8vwlPUJ4rZOd0vQ4=
=Iz1c
-----END PGP SIGNATURE-----

--75xqvzb34y2tmjoa--
