Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74D756B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjGQSPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjGQSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4E19AD;
        Mon, 17 Jul 2023 11:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E80AD611E0;
        Mon, 17 Jul 2023 18:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F0EC433C8;
        Mon, 17 Jul 2023 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617662;
        bh=OqEJx2JXRNQi7GTOKz0fdomqryGSX0xf5Jw92YAE3rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhIlQxIn/csuKBLwhCGfjg2VH7okyoik7gdBg6Qz9PqregdMX+gjgXK7hnFvIpxOJ
         z+68z1h+/90ajCET+LDDRIL5nJMtqgLEegWWEaaLzqtOlrdLfgru/NsXRUM6jHxbqu
         yZJjSVXpwo6G2SeJN4VxLC9/jFOYIAlhCCBZYxb8W6Va5BpKiN0TCK52zI4RydtSYN
         m2uh+rAMcbcdKlanv1tCQQrPglUgyoRCC9dlzW71htcprkTw8qwjn9z2iLdbr3H9hS
         ae8v5xMmH3avB4/3N6w81nF2rKDmKWLGG5xnWs7CtsdV7AGJxn5cM+XMLukkGTFRNe
         v3Pu/qCRt1ybw==
Date:   Mon, 17 Jul 2023 19:14:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
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
Subject: Re: [PATCH v7 0/7] Add PLL clocks driver and syscon for StarFive
 JH7110 SoC
Message-ID: <20230717-easel-pessimist-5b7c4e5bed0a@spud>
References: <20230717023040.78860-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vpxOvJLAUWdBcn/b"
Content-Disposition: inline
In-Reply-To: <20230717023040.78860-1-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vpxOvJLAUWdBcn/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Xingyu,

On Mon, Jul 17, 2023 at 10:30:33AM +0800, Xingyu Wu wrote:
> This patch serises are to add PLL clocks driver and providers by writing
> and reading syscon registers for the StarFive JH7110 RISC-V SoC. And add=
=20
> documentation and nodes to describe StarFive System Controller(syscon)
> Registers. This patch serises are based on Linux 6.4.
>=20
> PLLs are high speed, low jitter frequency synthesizers in JH7110.
> Each PLL clock works in integer mode or fraction mode by some dividers,
> and the dividers are set in several syscon registers.
> The formula for calculating frequency is:=20
> Fvco =3D Fref * (NI + NF) / M / Q1
>=20
> The first patch adds docunmentation to describe PLL clock bindings,
> and the second patch adds documentation to decribe syscon registers.
> The patch 3 modifies the SYSCRG bindings and adds PLL clock inputs.
> The patch 4 adds driver to support PLL clocks for JH7110.
> The patch 5 modifies the system clock driver and can select the PLL clock
> source from PLL clocks driver. And the patch 6 adds the=20
> stg/sys/aon syscon nodes for JH7110 SoC. The last patch modifies the=20
> syscrg node in JH7110 dts file.

Just FYI, I have picked up the binding & clock portions of this series
and your other one adding the stg syscon. I've pushed them out here for
the test robots to have a look:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dcl=
k-starfive

If that passes, my plan is to send Stephen a PR for the lot, later this
week.

Thanks,
Conor.

--vpxOvJLAUWdBcn/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLWE+AAKCRB4tDGHoIJi
0ur7AP4ndXL/qJjXJfNtVyd+3rK8jlf/5ysC8FoHGmNOM6U7AAD/avzW3cVV9fHK
stAX7pFN96sp2rQoJQtgrXNJ9rxKrwI=
=8WbH
-----END PGP SIGNATURE-----

--vpxOvJLAUWdBcn/b--
