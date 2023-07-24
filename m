Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42275F817
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGXNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGXNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DF0FA;
        Mon, 24 Jul 2023 06:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65D16117C;
        Mon, 24 Jul 2023 13:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D76AC433C7;
        Mon, 24 Jul 2023 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690204781;
        bh=zTYrYfuIhDLccrN9QL20ThimI4OI5TmqW3BW1i0cnkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdaPaJlDzf6l99eaSnCCkx6Q1+VMDLk6XZVYtVQAP9OPUm7ZTYhl0+FfuYFZjUsDe
         HPil2p68YsKZgexov5c8FRpmuwlF07N7x5FVIZPUSd9iZ2OpAuJGuxP7b6lE5oGjz/
         QZuPHhAd3QFq1U7NlfiBYLAVUuqFNYyPWGT07FWNPv4K4tha90HglRPc/lTWTZLHPI
         r6LjBgfsJQ8Evzk+1ts/e/tyNm+SQQA68q3Iulb4t7gTBb5nHdZrnS2Fv+hxDVCroN
         vXUlunbUQQwb1SYBYfl7RFJJ9nqeurLiiJxDLzOyivr7NeZM5KQg/tXdvDpecHfdKt
         7bPpMo2uvG90Q==
Date:   Mon, 24 Jul 2023 15:19:38 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] clk: sunxi-ng: nkm: Support finding closest rate
Message-ID: <walqtnf2dektptg4uimfmyth5e4l5xod4kavx3bwzmndyekfmd@l5mb2ukuhvza>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-8-04acf1d39765@oltmanns.dev>
 <ho2bblo2hzizst74hfqog3ga4cjf7eead2ntbl4e7xi5c32bhq@qpttu7ayv7vy>
 <87ilabqecp.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdha6ty5qkdyadob"
Content-Disposition: inline
In-Reply-To: <87ilabqecp.fsf@oltmanns.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zdha6ty5qkdyadob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 23, 2023 at 09:25:10AM +0200, Frank Oltmanns wrote:
> On 2023-07-17 at 16:14:58 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Jul 17, 2023 at 03:34:32PM +0200, Frank Oltmanns wrote:
> >> When finding the best rate for a NKM clock, consider rates that are
> >> higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
> >> set by using the helper function ccu_is_better_rate().
> >>
> >> Accommodate ccu_mux_helper_determine_rate to this change.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 18 ++++++++----------
> >>  2 files changed, 9 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu=
_mux.c
> >> index 1d557e323169..3ca695439620 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> >> @@ -139,7 +139,7 @@ int ccu_mux_helper_determine_rate(struct ccu_commo=
n *common,
> >>  			goto out;
> >>  		}
> >>
> >> -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> >> +		if (ccu_is_better_rate(common, req->rate, tmp_rate, best_rate)) {
> >>  			best_rate =3D tmp_rate;
> >>  			best_parent_rate =3D parent_rate;
> >>  			best_parent =3D parent;
> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu=
_nkm.c
> >> index 793160bc2d47..5439b9351cd7 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> >> @@ -39,6 +39,7 @@ static unsigned long ccu_nkm_optimal_parent_rate(uns=
igned long rate, unsigned lo
> >>  }
> >>
> >>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw =
*phw, struct _ccu_nkm *nkm,
> >> +						       struct ccu_common *common,
> >>  						       unsigned long *parent, unsigned long rate)
> >>  {
> >>  	unsigned long best_rate =3D 0, best_parent_rate =3D *parent, tmp_par=
ent =3D *parent;
> >> @@ -54,10 +55,8 @@ static unsigned long ccu_nkm_find_best_with_parent_=
adj(struct clk_hw *phw, struc
> >>  				tmp_parent =3D clk_hw_round_rate(phw, tmp_parent);
> >>
> >>  				tmp_rate =3D tmp_parent * _n * _k / _m;
> >> -				if (tmp_rate > rate)
> >> -					continue;
> >>
> >> -				if ((rate - tmp_rate) < (rate - best_rate)) {
> >> +				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
> >>  					best_rate =3D tmp_rate;
> >>  					best_parent_rate =3D tmp_parent;
> >>  					best_n =3D _n;
> >> @@ -78,7 +77,7 @@ static unsigned long ccu_nkm_find_best_with_parent_a=
dj(struct clk_hw *phw, struc
> >>  }
> >>
> >>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned=
 long rate,
> >> -				       struct _ccu_nkm *nkm)
> >> +				       struct _ccu_nkm *nkm, struct ccu_common *common)
> >
> > Same comment than on patch 7, common should be first in those two funct=
ions.
> >
>=20
> Ok, I wasn't sure what your expectation is for existing functions. For
> ccu_find_best_with_parent_adj the order is:
>   1. *phw
>   2. *nkm
>   3. *common
>   4. *parent
>   5. rate

Arguments are generally ordered by putting first what the function will
act upon, and then from generic to specific, and output last.

Which I guess would make the ideal one something like:
*common
*parent_hw
*parent
rate
nkm

> We don't have the parent hw in ccu_nkm_find_best. The order prior to
> this patch is:
>   1. parent
>   2. rate
>   3. *nkm
>=20
> We need to add *common to that, so I could add it to the beginning as
> per your suggestion:
>   1. *common
>   2. parent
>   3. rate
>   4. *nkm

Those two make sense to me

> I could also pull *nkm to the beginning (similar to the parent_adj
> version):
>   4. *nkm
>   1. *common
>   2. parent
>   3. rate

nkm is an output, it needs to be last.

Maxime

--zdha6ty5qkdyadob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZL56ZQAKCRDj7w1vZxhR
xfD6AQD86VqzwQL+X8K+LWwG3JTQsowVtUM7Izo4LH6eAGEXgQD/dBlKWVEEWFJ8
Ok8JkQvJuavPFcF9gyIMwt1OzExLTA0=
=+YIW
-----END PGP SIGNATURE-----

--zdha6ty5qkdyadob--
