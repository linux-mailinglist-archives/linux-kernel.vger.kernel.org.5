Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3337DE409
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjKAPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKAPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:44:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A47DA;
        Wed,  1 Nov 2023 08:44:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C094C433C7;
        Wed,  1 Nov 2023 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698853448;
        bh=LOLkdWyXlUPi/tob8rtWu6/QnkwJBoUQig0d19hPCiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHjhLGZMNagQaCEQr1O10zzYkGsfgf6rUpdIGSRGxKXH+Vt/5ksjNTwaXmIPDnmsS
         7uaTUYRtDweNgA+ES41AfY8FJ0bz3eN0sVL61ZAv8BauQ1t5VezztjphJVmqbb5V2g
         jZVruTyNu4+XN+PWPCLXM9ZDV0+aiFNR/jyIx1Hfw4pAvGid4qGUgAIwueanxEvciP
         kLc4jfhJpWcRQZ7mAzXb01z1da+hoorKTFBT9DI9SNh6/F6+XJIIY7a29usYYUiXiw
         0+Zwi36lNjukjpEgnw4HCP42VzDTTXG9Yh8YcIhBeDJBj812vrqyxms2SPbh3Q9t3C
         Re1Y91O4r2gJA==
Date:   Wed, 1 Nov 2023 15:44:02 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        michael.riesch@wolfvision.net
Subject: Re: [PATCH v9 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <20231101-ergonomic-grafted-2edc0290c569@spud>
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <5f83d60031320c4c7b0f0727604903f50ee49058.1698666612.git.mehdi.djait@bootlin.com>
 <20231030193236.GA1995060-robh@kernel.org>
 <ZUDOCywnEqJSuQMM@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YVNaohhmDitCSSUU"
Content-Disposition: inline
In-Reply-To: <ZUDOCywnEqJSuQMM@aptenodytes>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YVNaohhmDitCSSUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:51:07AM +0100, Paul Kocialkowski wrote:
> Hi Rob,
>=20
> On Mon 30 Oct 23, 14:32, Rob Herring wrote:
> > On Mon, Oct 30, 2023 at 01:25:12PM +0100, Mehdi Djait wrote:
> > > Add a documentation for the Rockchip Camera Interface
> > > binding.
> > >=20
> > > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > > ---
> > > v8=3D>v9:
> > > dropped the "Reviewed-by: Rob Herring <robh@kernel.org>"
> > > because of the following changes:
> > > - changed the compatible to rk3066-cif: rk3066 is the earliest Rockch=
ip SoC
> > >   that uses cif and it is the first model starting the RK30 lineup.
> >=20
> > Is px30 compatible with rk3066? It's not clear because you didn't add=
=20
> > rk3066 support. If not compatible, then add rk3066 when you have a user=
=2E=20
> > If it is compatible, then you should have a fallback for px30.
>=20
> Just to clarify here: we haven't checked that rk3066 uses the exact same
> programming model as px30 (so there should be no fallback compatible), bu=
t it
> is definitely the same unit (in a different version).

If you aren't sure about the programming model, are you sure about the
number of clocks, resets etc that it has? Same IP in a different SoC
could be integrated differently, right?

> Since the yaml binding document will apply to all generations of the unit,
> the name of the file should be the first generation (rk3066) instead of t=
he
> px30 which is just one of the many iterations of the unit.
>=20
> It would be both confusing and irrelevant to pick px30 just because it ha=
ppens
> to be the first generation supported in the Linux driver (and described in
> the binding).

--YVNaohhmDitCSSUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJyQgAKCRB4tDGHoIJi
0pV9AQDsS4rK+O+lkq42s0pL/LUf5QyGJvaIOVrOuMKXzAV0rAD+MZO7nnkc94mm
0HlriAIiiWtAbTY06WCROSeGC0sFEg8=
=M5oH
-----END PGP SIGNATURE-----

--YVNaohhmDitCSSUU--
