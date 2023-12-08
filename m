Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7180ACEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574670AbjLHTZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012711706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:25:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68266C433C8;
        Fri,  8 Dec 2023 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702063545;
        bh=z3otdfwGLX1f2a+SvSkMwMZKGTLN4cY6uigJoIFO8gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQhKPK3QFPl9Y4y8sbGGByFaxlfrHHBrDeR2t0nRF+ZSY8oHD2YtQlpfSwS0bUcMC
         5cQbG0I+RUkaUbSqsYWyajZrzXiTtDF3inTnntumVRtejuFCXVALMmWg+0cwc1iUpk
         Z+r8QBYBA7qb9jB6svwH93w66rJkBtDOofMbrFrQyPZFuQ6SjeogAahQSRKSzpKReZ
         XW8f3hgrcG3j8RrKzzKnZfymmieb9DV7tyw5upJM6+HL9wL6FFIb4JqzfjNbPHJ3Du
         EaEioV1pHZ4HoRPRU6nZSC8ZpzJibUXbQQDMxwLTvjV/6LSmWW9broVCN4UAwM8MaI
         8ZeKPanJ7KM/A==
Date:   Fri, 8 Dec 2023 19:25:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org,
        Eric Dumazet <edumazet@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231208-contusion-professed-3b2235f7d3df@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <170206026051.2485962.13304186324857333888.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LcNsrkCtTh9NwKDb"
Content-Disposition: inline
In-Reply-To: <170206026051.2485962.13304186324857333888.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LcNsrkCtTh9NwKDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 12:31:00PM -0600, Rob Herring wrote:
>=20
> On Fri, 08 Dec 2023 17:12:24 +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> > CAN bus clock. The bus clock was omitted when the binding was written,
> > but is required for operation. Make up for lost time and add it.
> >=20
> > Cautionary tale in adding bindings without having implemented a real
> > user for them perhaps.
> >=20
> > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN con=
troller")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/can/microchip,mpfs-can.yaml: properties:clocks: {'maxItems': 2, 'items':=
 [{'description': 'AHB peripheral clock'}, {'description': 'CAN bus clock'}=
]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#


Oh dear, me of all people.

--LcNsrkCtTh9NwKDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNtsgAKCRB4tDGHoIJi
0oSOAQCwrHN/7yWhuuIG7o8zyiDD3sQh9O0ObhobDPMiwzstNAEAwZYfqSjCNUqo
PRSO8gA7E/ILMPQQJKcY+VOri+ewwAg=
=IQnv
-----END PGP SIGNATURE-----

--LcNsrkCtTh9NwKDb--
