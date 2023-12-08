Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF0280ACEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574654AbjLHT0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHT0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:26:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0331706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:26:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F0C433C8;
        Fri,  8 Dec 2023 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702063576;
        bh=HmU9LMehAw9DeUV8uCa+TBiQ2MWNpmsc6U26C4PITlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0jHp+lrFGrxQQ5fEQ0yYQ4fe+W9y4ZBbiIbF5Fm6XNgANu/LLyFCi7GKBQlImOK1
         zQ5FX411R3rVVBA++4kibVU+Ry2zU52I2LBtZFygSsz/2u+K0JWWcT+JXE2mM3eQa5
         aMaNS4Jl0owLVOpVhyAh5+5NDmpWsy7qBKYlhrzdxgnBQPmrOGOcSpTvp+Y7TY454O
         WxcxrL2t/YvNsOiGxmkthRidpOyy3nyHyi8BYNeIuulbHZ7ApFNEULZz6fP97KusN/
         TGdMkp+mrZygRRBt5EpnO283TOKGmC2DO1viuGwbfey/SpXfK9+mVbEe3SEJjdhIMr
         WKX33bNQlujUg==
Date:   Fri, 8 Dec 2023 19:26:10 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 1/7] dt-bindings: clock: mpfs: add more MSSPLL
 output definitions
Message-ID: <20231208-cauterize-hacker-f63dddf39af0@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-unripe-maximum-fc77f4967561@spud>
 <CAJM55Z_ozf=MwOJCSM154L__TE1Gv7Ec=gM8LFJ31-_eX66OKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="keUDLXTW9SCPY39T"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_ozf=MwOJCSM154L__TE1Gv7Ec=gM8LFJ31-_eX66OKA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--keUDLXTW9SCPY39T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 09:40:00AM -0800, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > There are 3 undocumented outputs of the MSSPLL that are used for the CAN
> > bus, "user crypto" module and eMMC. Add their clock IDs so that they can
> > be hooked up in DT.
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  include/dt-bindings/clock/microchip,mpfs-clock.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/microchip,mpfs-clock.h b/include=
/dt-bindings/clock/microchip,mpfs-clock.h
> > index 79775a5134ca..b52f19a2b480 100644
> > --- a/include/dt-bindings/clock/microchip,mpfs-clock.h
> > +++ b/include/dt-bindings/clock/microchip,mpfs-clock.h
> > @@ -44,6 +44,11 @@
> >
> >  #define CLK_RTCREF	33
> >  #define CLK_MSSPLL	34
> > +#define CLK_MSSPLL0	34
>=20
> You add this new CLK_MSSPLL0 macro with the same value as CLK_MSSPLL, but
> never seem to use it in this series. Did you mean to rename the CLK_MSSPLL
> instances CLK_MSSPLL0?

Yes, that was my intention.

--keUDLXTW9SCPY39T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNt0gAKCRB4tDGHoIJi
0mr/AQDAPWA0oJFGAgd3kwzO+18/rBTPVxEGkrO5J9+fukpyOAEAyrgQk4472IpW
41zAPoXiQ9UbdlNLIljJi2H7VMzCYAw=
=YxhE
-----END PGP SIGNATURE-----

--keUDLXTW9SCPY39T--
