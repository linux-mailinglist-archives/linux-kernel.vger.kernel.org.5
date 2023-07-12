Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91126750D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGLQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGLQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FE134;
        Wed, 12 Jul 2023 09:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F7D61828;
        Wed, 12 Jul 2023 16:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC31C433C7;
        Wed, 12 Jul 2023 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689178164;
        bh=pqoyJFSea9dYoiGMmVTXAZYeslRJ01DFgztLa+1r6uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYwvzwmVoK4zO33qkodjGeDcHExTd2f2cckvHPQJp4lZkntvj76fCveDvwcbUKc1/
         w5l9o0Vz27YQ/fo8W7jySKoLDXOMFFgFZ5h8cMNx0Vubyup3QMCoL3KTle9xXnVGdg
         Hq0N8AyeUi/lB0o5BLNTgFujbN3ZCsmba3VAQUWlzAqC4PpLktPyR7SvWDJVwo+XLq
         ygW9fIAXdNLsKdzqTBd/YLifVKTMYbD/J4ybDxrZIYXlbF9f8xDs4Cg3CI7eurf8vQ
         ZgpG59EGzbn80ZvFRnJCNqYZad4L5OcCyk6ok0f36pRV9niwLO93K6m96J5elWdVQq
         UlVXVWohAbuaw==
Date:   Wed, 12 Jul 2023 17:09:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH v6 0/7] Add PLL clocks driver and syscon for
 StarFive JH7110 SoC
Message-ID: <20230712-footage-smokiness-8f3d224073ce@spud>
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
 <20230704-driven-desecrate-75075ebc11a3@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ONIhm+iBQBpVs2F5"
Content-Disposition: inline
In-Reply-To: <20230704-driven-desecrate-75075ebc11a3@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ONIhm+iBQBpVs2F5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen,

On Tue, Jul 04, 2023 at 11:29:15PM +0100, Conor Dooley wrote:
> On Tue, Jul 04, 2023 at 02:46:03PM +0800, Xingyu Wu wrote:
> > [Resending because it has a error about examples in syscon bingdings
> > and has to be fixed.]
> >=20
> > This patch serises are to add PLL clocks driver and providers by writing
> > and reading syscon registers for the StarFive JH7110 RISC-V SoC. And ad=
d=20
> > documentation and nodes to describe StarFive System Controller(syscon)
> > Registers. This patch serises are based on Linux 6.4.
>=20
> Could you take a look at this series when you get a chance, please?
> Would be good to finally get it merged since the syscon bits are a dep
> for a few other things :)

When Emil has had a chance to look at this, my plan was to send you a PR
for the bindings & clock bits, like I did for the last round of StarFive
changes. Would that be okay with you?

Thanks,
Conor.

> > William Qiu (2):
> >   dt-bindings: soc: starfive: Add StarFive syscon module
> >   riscv: dts: starfive: jh7110: Add syscon nodes
> >=20
> > Xingyu Wu (5):
> >   dt-bindings: clock: Add StarFive JH7110 PLL clock generator
> >   dt-bindings: clock: jh7110-syscrg: Add PLL clock inputs
> >   clk: starfive: Add StarFive JH7110 PLL clock driver
> >   clk: starfive: jh7110-sys: Add PLL clocks source from DTS
> >   riscv: dts: starfive: jh7110: Add PLL clocks source in SYSCRG node
> >=20
> >  .../bindings/clock/starfive,jh7110-pll.yaml   |  46 ++
> >  .../clock/starfive,jh7110-syscrg.yaml         |  18 +-
> >  .../soc/starfive/starfive,jh7110-syscon.yaml  |  93 ++++
> >  MAINTAINERS                                   |  13 +
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  30 +-
> >  drivers/clk/starfive/Kconfig                  |   9 +
> >  drivers/clk/starfive/Makefile                 |   1 +
> >  .../clk/starfive/clk-starfive-jh7110-pll.c    | 507 ++++++++++++++++++
> >  .../clk/starfive/clk-starfive-jh7110-sys.c    |  45 +-
> >  .../dt-bindings/clock/starfive,jh7110-crg.h   |   6 +
> >  10 files changed, 746 insertions(+), 22 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh=
7110-pll.yaml
> >  create mode 100644 Documentation/devicetree/bindings/soc/starfive/star=
five,jh7110-syscon.yaml
> >  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.c
> >=20
> > --=20
> > 2.25.1
> >=20



--ONIhm+iBQBpVs2F5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7QLgAKCRB4tDGHoIJi
0gmyAP9FrTz4QgVF0rHn9VPS4zyrnwkwh/i4NsTcANNBws7PgwD+OjKReHA9p0VA
SHvBgCynEq9+47lPl+pclaCFSv+nLgY=
=53hT
-----END PGP SIGNATURE-----

--ONIhm+iBQBpVs2F5--
