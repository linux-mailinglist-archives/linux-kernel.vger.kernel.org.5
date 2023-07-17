Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCD75617D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGQLY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGQLYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA46E63;
        Mon, 17 Jul 2023 04:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF3D61019;
        Mon, 17 Jul 2023 11:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B85C433C8;
        Mon, 17 Jul 2023 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689593062;
        bh=MZp449NybY0ylW/f6IykuukGlJG11iQlZtoYhYg1+oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAfmgjzxblIswXXJrnJJ+Ixrkix3I6/cQgkYS3jE57I5wBNcyK/mDnnu2rIh27tCf
         a8UjenstlrbQgaSDhOWn5wlZ4hiRu2tnU7mfp6IvEH3YLdQOcNhJ1bh4jaZBi8kVtB
         DtRmrQM5rKyHeRv7HC1IpeEB5/fvalY+ugaHJXbCi+/YYLba0wuz4cRmIC6mFYbi/l
         rQmiT5DG5ie33F4v+vi1sZpWQzTWZmAOXEcFR8BbIrF9UcTmtejwbBETlu5V6JJhGW
         viy3Tl60laVxOe8j9cEwNXtVvilCbKI7e9zCZCMkuauN3csJUfJ1W6fJDfM3VwwMGb
         HcsOMA28mRpMg==
Date:   Mon, 17 Jul 2023 13:24:19 +0200
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
Message-ID: <jxgy2pvns4ri2aj5nmdhb4zbluseuzdejbplh2avwz63df2cfx@grrrdm6ujzi4>
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
 <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
 <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
 <jv6daj2w3pwjtde3m3m26yg4wyxbbio4zqra5yqc4gb32ri5ub@noinbbkjovwm>
 <25724ee3-858a-01eb-352b-3edbfad31c8e@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vj7p56geqtpo6nq4"
Content-Disposition: inline
In-Reply-To: <25724ee3-858a-01eb-352b-3edbfad31c8e@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vj7p56geqtpo6nq4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 11:13:26AM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/07/23 09:48, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Fri, Jul 14, 2023 at 12:19:00PM +0800, Chen-Yu Tsai wrote:
> > > On Thu, Jul 13, 2023 at 9:22=E2=80=AFPM Alexandre Mergnat <amergnat@b=
aylibre.com> wrote:
> > > > On 13/07/2023 09:21, AngeloGioacchino Del Regno wrote:
> > > > > The top_dp and top_edp muxes can be both parented to either TVDPL=
L1
> > > > > or TVDPLL2, two identically specced PLLs for the specific purpose=
 of
> > > > > giving out pixel clock: this becomes a problem when the MediaTek
> > > > > DisplayPort Interface (DPI) driver tries to set the pixel clock r=
ate.
> > > > >=20
> > > > > In the usecase of two simultaneous outputs (using two controllers=
),
> > > > > it was seen that one of the displays would sometimes display garb=
led
> > > > > output (if any at all) and this was because:
> > > > >    - top_edp was set to TVDPLL1, outputting X GHz
> > > > >    - top_dp was set to TVDPLL2, outputting Y GHz
> > > > >      - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
> > > > >        - top_dp is switched to TVDPLL1
> > > > >        - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
> > > > >        - eDP display is garbled
> > > > >=20
> > > > > To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> > > > > all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> > > > > clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> > > > > able to use the right bit index for the new parents list.
> > > > >=20
> > > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delre=
gno@collabora.com>
> > > > > ---
> > > > >    drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 ++++++++++++++=
--------
> > > > >    1 file changed, 14 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers=
/clk/mediatek/clk-mt8195-topckgen.c
> > > > > index 81daa24cadde..abb3721f6e1b 100644
> > > > > --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> > > > > +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> > > > > @@ -417,15 +417,21 @@ static const char * const pwrmcu_parents[] =
=3D {
> > > > >=20
> > > > >    static const char * const dp_parents[] =3D {
> > > > >        "clk26m",
> > > > > -     "tvdpll1_d2",
> > > > >        "tvdpll2_d2",
> > > > > -     "tvdpll1_d4",
> > > > >        "tvdpll2_d4",
> > > > > -     "tvdpll1_d8",
> > > > >        "tvdpll2_d8",
> > > > > -     "tvdpll1_d16",
> > > > >        "tvdpll2_d16"
> > > > >    };
> > > > > +static const u8 dp_parents_idx[] =3D { 0, 2, 4, 6, 8 };
> > > > > +
> > > > > +static const char * const edp_parents[] =3D {
> > > > > +     "clk26m",
> > > > > +     "tvdpll1_d2",
> > > > > +     "tvdpll1_d4",
> > > > > +     "tvdpll1_d8",
> > > > > +     "tvdpll1_d16"
> > > > > +};
> > > > > +static const u8 edp_parents_idx[] =3D { 0, 1, 3, 5, 7 };
> > > >=20
> > > > AFAII your solution is to force a specific TVDPLLX for each display=
, and
> > > > it isn't dynamic.
> > > >=20
> > > > Do you think it's possible to do that using the DTS ? I'm asking
> > > > because, IMHO, this kind of setup is more friendly/readable/flexibl=
e in
> > > > the DTS than hardcoded into the driver.
> > >=20
> > > (CC-ing Maxime, who has some experience in the matter.)
> >=20
> > It's not clear to me what the context is, but I'll try my best :)
> >=20
>=20
> I'll try to explain briefly.
>=20
> On *some* MediaTek platforms, there are two *identical* PLLs for HDMI/(e)=
DP,
> which are internal to the SoC; clocks for HDMI/eDP/DP controller*s* can be
> parented either PLL (as you see from this commit)

So the HDMI controller can be parented either to the first or second PLL
(and same thing for the (e)DP controllers)?

> The PLL's rate can be changed in runtime and you want to use PLL dividers=
 to
> get the final pixel clock (that's to obviously reduce the PLL jitter).
>=20
> > > assigned-parents doesn't prevent your system from reparenting the clo=
cks
> > > back to a conflicting configuration.
> >=20
> > Yep, it's very much a one-off thing. There's no guarantee at the moment,
> > and semantics-wise we could change the whole thing at probe time and it
> > would be fine.
> >=20
>=20
> Would be fine... but more complicated I think?

My point wasn't that you should do it, but that you can't rely on the
parent or rate sticking around.

> > > AFAIK the recommended way to deal with this is to use
> > > clk_set_rate_exclusive() and co. in whatever consumer driver that
> > > needs exclusive control on the clock rate.
> >=20
> > I guess it works, but it looks to me like the issue here is that the
> > provider should disable it entirely? My expectation for
> > clk_set_rate_exclusive() is that one user needs to lock the clock rate
> > to operate properly.
> >=20
> > If the provider expectation is that the rate or parent should never
> > changed, then that needs to be dealt with at the provider level, ie
> > through the clk_ops.
> >=20
> > > However I'm not sure if that works for parents. It should, given the
> > > original use case was for the sunxi platforms, which like the MediaTek
> > > platform here has 2 PLLs for video related consumers, but I couldn't
> > > find code verifying it.
> >=20
> > If you want to prevent clocks from ever being reparented, you can use
> > the new clk_hw_determine_rate_no_reparent() determine_rate
> > implementation.
> >=20
>=20
> We want the clocks to be reparented, as we need them to switch parents as
> explained before... that's more or less how the tree looks:
>=20
> TVDPLL(x) -> PLL Divider (fixed) -> MUX -> Gate -> Controller
>=20
> Besides, I think that forcing *one* parent to the dp/edp mux would produc=
e a
> loss of the flexibility that the clock framework provides.
>=20
> I again want to emphasize on the fact that TVDPLL1 and TVDPLL2 are *ident=
ical*
> in specs, and on that there will never be a MT8195 SoC that has only one =
of
> the two PLLs, for obvious reasons...
>=20
> P.S.: If you need more context, I'll be glad to answer to any other quest=
ion!

Then I have no idea what the question is :)

What are you trying to achieve / fix, and how can I help you ? :)

Maxime

--vj7p56geqtpo6nq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLUk4wAKCRDj7w1vZxhR
xdgoAQDzPA1BpUCPo9t2+uV4aKqjg2t8Kz/dA2dXTl/Jt5W9AAEA4ZU/y2l7WZoZ
17mbzHUJ60I4TKxvgZUiHGqu3keJ5ws=
=ZPM/
-----END PGP SIGNATURE-----

--vj7p56geqtpo6nq4--
