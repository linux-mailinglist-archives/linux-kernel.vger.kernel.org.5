Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCF755D69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGQHsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGQHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F210D5;
        Mon, 17 Jul 2023 00:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 780E560F9B;
        Mon, 17 Jul 2023 07:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D184C433C9;
        Mon, 17 Jul 2023 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689580128;
        bh=m+bGBZrS1lDGOHNa7b+hG+gRi77nkTrb6lLGgxVmoYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc71VvLupE2MVR5St9xy0kvM9+8+V8AqYxNp7WXqP7VEykPEE9WBRCdQRwK+H5lzk
         A8JIKg87oWLk3jM3o3u3+Hjy/cVoZIQ14yqXg0LCQgMkK25VCZMT5wlGGpgxmP69mT
         8YStn41+v1A1sn/uCJqIXtJ5MCwOFPq+58Qif9US7C7O9okAn0HiAqcFL0e6JVmmkw
         C/QxZ5SwA93y+vBvj8QnNXCMHJv7aVpTNzGynBanFSdJjao1pqRrytwBnEzqAJfQzt
         hQeo5JWAvwdGAVzxOQzwTQgpQpDF4Ory/aHLbu7ZsL7GArKX/zI1XhtkGs0gK/sy8u
         reo5WJbeXlU5w==
Date:   Mon, 17 Jul 2023 09:48:46 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com, msp@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
Message-ID: <jv6daj2w3pwjtde3m3m26yg4wyxbbio4zqra5yqc4gb32ri5ub@noinbbkjovwm>
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
 <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
 <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnm62w2pu2hihd2p"
Content-Disposition: inline
In-Reply-To: <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnm62w2pu2hihd2p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 14, 2023 at 12:19:00PM +0800, Chen-Yu Tsai wrote:
> On Thu, Jul 13, 2023 at 9:22=E2=80=AFPM Alexandre Mergnat <amergnat@bayli=
bre.com> wrote:
> > On 13/07/2023 09:21, AngeloGioacchino Del Regno wrote:
> > > The top_dp and top_edp muxes can be both parented to either TVDPLL1
> > > or TVDPLL2, two identically specced PLLs for the specific purpose of
> > > giving out pixel clock: this becomes a problem when the MediaTek
> > > DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
> > >
> > > In the usecase of two simultaneous outputs (using two controllers),
> > > it was seen that one of the displays would sometimes display garbled
> > > output (if any at all) and this was because:
> > >   - top_edp was set to TVDPLL1, outputting X GHz
> > >   - top_dp was set to TVDPLL2, outputting Y GHz
> > >     - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
> > >       - top_dp is switched to TVDPLL1
> > >       - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
> > >       - eDP display is garbled
> > >
> > > To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> > > all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> > > clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> > > able to use the right bit index for the new parents list.
> > >
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > ---
> > >   drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 ++++++++++++++-----=
---
> > >   1 file changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk=
/mediatek/clk-mt8195-topckgen.c
> > > index 81daa24cadde..abb3721f6e1b 100644
> > > --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> > > +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> > > @@ -417,15 +417,21 @@ static const char * const pwrmcu_parents[] =3D {
> > >
> > >   static const char * const dp_parents[] =3D {
> > >       "clk26m",
> > > -     "tvdpll1_d2",
> > >       "tvdpll2_d2",
> > > -     "tvdpll1_d4",
> > >       "tvdpll2_d4",
> > > -     "tvdpll1_d8",
> > >       "tvdpll2_d8",
> > > -     "tvdpll1_d16",
> > >       "tvdpll2_d16"
> > >   };
> > > +static const u8 dp_parents_idx[] =3D { 0, 2, 4, 6, 8 };
> > > +
> > > +static const char * const edp_parents[] =3D {
> > > +     "clk26m",
> > > +     "tvdpll1_d2",
> > > +     "tvdpll1_d4",
> > > +     "tvdpll1_d8",
> > > +     "tvdpll1_d16"
> > > +};
> > > +static const u8 edp_parents_idx[] =3D { 0, 1, 3, 5, 7 };
> >
> > AFAII your solution is to force a specific TVDPLLX for each display, and
> > it isn't dynamic.
> >
> > Do you think it's possible to do that using the DTS ? I'm asking
> > because, IMHO, this kind of setup is more friendly/readable/flexible in
> > the DTS than hardcoded into the driver.
>=20
> (CC-ing Maxime, who has some experience in the matter.)

It's not clear to me what the context is, but I'll try my best :)

> assigned-parents doesn't prevent your system from reparenting the clocks
> back to a conflicting configuration.

Yep, it's very much a one-off thing. There's no guarantee at the moment,
and semantics-wise we could change the whole thing at probe time and it
would be fine.

> AFAIK the recommended way to deal with this is to use
> clk_set_rate_exclusive() and co. in whatever consumer driver that
> needs exclusive control on the clock rate.

I guess it works, but it looks to me like the issue here is that the
provider should disable it entirely? My expectation for
clk_set_rate_exclusive() is that one user needs to lock the clock rate
to operate properly.

If the provider expectation is that the rate or parent should never
changed, then that needs to be dealt with at the provider level, ie
through the clk_ops.

> However I'm not sure if that works for parents. It should, given the
> original use case was for the sunxi platforms, which like the MediaTek
> platform here has 2 PLLs for video related consumers, but I couldn't
> find code verifying it.

If you want to prevent clocks from ever being reparented, you can use
the new clk_hw_determine_rate_no_reparent() determine_rate
implementation.

Maxime

--pnm62w2pu2hihd2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLTyVAAKCRDj7w1vZxhR
xXw4AP0Ty/OWNJLgn+fLyMmNGKPM9qnI7RTYAK+pr90b8DkpXAEAktwYMnIZi2Tb
QCzSP3n9UARQeQqEP4FOhX7MS7S1TA0=
=WUaC
-----END PGP SIGNATURE-----

--pnm62w2pu2hihd2p--
