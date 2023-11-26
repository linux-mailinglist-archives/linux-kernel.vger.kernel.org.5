Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4F7F9280
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 12:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjKZLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 06:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 06:36:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1E101
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 03:36:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF45C433C7;
        Sun, 26 Nov 2023 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700998589;
        bh=P2P43SYXv6u+aOpsTU/RQ6/+rVreClZ6o7li0KxB/6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjrmWqk1+DbOryXclrK/r7SZdXk3DcsNeTRgHuGdTKdF3l0JVVjN1uOZhuOVwYkcS
         +a+GVTrx+nGWEd5hLUoG39sYZ6vb6tegM1zNPhkuiNasLtvwbo6GqbUkiEjJJ2y0tl
         qWySar4H2sguCPv+IDwdPeNPEbqwtyhIe3Al4YF9vHTZ2bgmyYCsZ9a8hFgnuiIsDM
         zZ9QrD3BDbxiRXKDuzD/6J6eThmgezkopACfr29woOfkXX6jKwlyc8e0Y4rsdQVyBk
         idLuBpoDOEwkW2K5RnBYWAZvd3//Zi9WOsfThc3N0Um/XX6j3mcDqL6QRNkupsGa0F
         7XfwrU9fm3UJw==
Date:   Sun, 26 Nov 2023 11:36:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: add Milkv Mars board device tree
Message-ID: <20231126-attractor-swampland-b1b95bd1322b@spud>
References: <20231126100055.1595-1-jszhang@kernel.org>
 <ef4eda2a-4be5-4992-a315-d02e1a36b656@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gYJgPLPFWEYyFUMA"
Content-Disposition: inline
In-Reply-To: <ef4eda2a-4be5-4992-a315-d02e1a36b656@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gYJgPLPFWEYyFUMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 11:27:20AM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2023 11:00, Jisheng Zhang wrote:
> > +	cpus {
>=20
> Board should not bring new CPU nodes. Override by label instead.
>=20
>=20
> > +		timebase-frequency =3D <4000000>;
> > +	};

This particular one is widespread, but I am not sure why it is being set
on the board level in any of the individual cases. On the platforms
where I do know where the frequency for this comes from it is set by the
SoC, not the board and so should really be fixed by moving this into
$soc.dtsi. I suspect the same is true for the jh7110 and
timebase-frequency is not a board-level setting and probably needs the
same treatment. Those with more insight into how the clocks on the
jh7110 are routed can hopefully advise us here.

--gYJgPLPFWEYyFUMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWMttwAKCRB4tDGHoIJi
0pICAPoCeTCnmr5Ffb8M9OFyuV+MeSGUq3QE+0enkLN9i+3KygEAqJ0V62Uifzg9
9r6wcYvE7wwFGV7sgZr3x+gCUKUyPgc=
=a9J5
-----END PGP SIGNATURE-----

--gYJgPLPFWEYyFUMA--
