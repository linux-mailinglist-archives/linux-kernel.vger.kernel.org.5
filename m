Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7847756623
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGQOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjGQOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209F172C;
        Mon, 17 Jul 2023 07:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C1B6109E;
        Mon, 17 Jul 2023 14:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65AFC433C9;
        Mon, 17 Jul 2023 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689603301;
        bh=nsWvvpLCGQi1ccr8r5WQcrvwg055b3qqd0VTtJE2RIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlSQ9lmB+krwPk+ZP5rB8v7kqNrBCr14yNsqm4MJmIDBXpmnVjkdNVKERsuUtv8Nf
         I27gHAYJvvKbd9xQgZMVB+n0nEXn6SUobobjXeGEdgh7Li2ogPo92qJh0d13FyI2LS
         DjGCgIj1VLqfJFXytbRMFxWPfx63ugap6czTLhUPDdH8BcsjuVxfhD5Xdwi8Mu7Zdc
         nLOzOTCFn2vywaNJqmgnlIpFzi6pLOQZRUxQqOLAPstM8JzHoWfgvPga26xqz6XeA1
         cMDPagw9cdi16sKdzigKtdSsWBOWjWR6Y9fNMz86+mgJlzr7f9pjKYHOa2E/XxDoO2
         43IHcK746lPrA==
Date:   Mon, 17 Jul 2023 16:14:58 +0200
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
Message-ID: <ho2bblo2hzizst74hfqog3ga4cjf7eead2ntbl4e7xi5c32bhq@qpttu7ayv7vy>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-8-04acf1d39765@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltjkxvuoqd4wy6uu"
Content-Disposition: inline
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-8-04acf1d39765@oltmanns.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltjkxvuoqd4wy6uu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 03:34:32PM +0200, Frank Oltmanns wrote:
> When finding the best rate for a NKM clock, consider rates that are
> higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
> set by using the helper function ccu_is_better_rate().
>=20
> Accommodate ccu_mux_helper_determine_rate to this change.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
>  drivers/clk/sunxi-ng/ccu_nkm.c | 18 ++++++++----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index 1d557e323169..3ca695439620 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -139,7 +139,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *=
common,
>  			goto out;
>  		}
> =20
> -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> +		if (ccu_is_better_rate(common, req->rate, tmp_rate, best_rate)) {
>  			best_rate =3D tmp_rate;
>  			best_parent_rate =3D parent_rate;
>  			best_parent =3D parent;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nk=
m.c
> index 793160bc2d47..5439b9351cd7 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -39,6 +39,7 @@ static unsigned long ccu_nkm_optimal_parent_rate(unsign=
ed long rate, unsigned lo
>  }
> =20
>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *ph=
w, struct _ccu_nkm *nkm,
> +						       struct ccu_common *common,
>  						       unsigned long *parent, unsigned long rate)
>  {
>  	unsigned long best_rate =3D 0, best_parent_rate =3D *parent, tmp_parent=
 =3D *parent;
> @@ -54,10 +55,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj=
(struct clk_hw *phw, struc
>  				tmp_parent =3D clk_hw_round_rate(phw, tmp_parent);
> =20
>  				tmp_rate =3D tmp_parent * _n * _k / _m;
> -				if (tmp_rate > rate)
> -					continue;
> =20
> -				if ((rate - tmp_rate) < (rate - best_rate)) {
> +				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
>  					best_rate =3D tmp_rate;
>  					best_parent_rate =3D tmp_parent;
>  					best_n =3D _n;
> @@ -78,7 +77,7 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(=
struct clk_hw *phw, struc
>  }
> =20
>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned lo=
ng rate,
> -				       struct _ccu_nkm *nkm)
> +				       struct _ccu_nkm *nkm, struct ccu_common *common)

Same comment than on patch 7, common should be first in those two functions.

Once fixed,
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ltjkxvuoqd4wy6uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLVM4gAKCRDj7w1vZxhR
xe3MAP91I0ZzxUancNCs7HLzHo0db7XK9PtoglojJhbl4zmzfwD/TGAZwQgTuyQC
ZRkmfnDku6BwZjl8MM3AwBNJxpC6rAs=
=/klU
-----END PGP SIGNATURE-----

--ltjkxvuoqd4wy6uu--
