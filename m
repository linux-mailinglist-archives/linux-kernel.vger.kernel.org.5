Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C27E5354
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjKHK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjKHK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CC1FD0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:28:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D9C433C8;
        Wed,  8 Nov 2023 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699439305;
        bh=S0mwz2vFk0a00OtjvktXqTpSJbDd/F0+ds8B8BNIQLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ha7pzUZFM3IHALcAvaQpFUCdphmClKXGDyPPSrcw9srguKtYrypeVgjEGA7z2vsJ8
         Sz5ilqYu85/lezyvybsblVGaylQkV3HW66qL7EQYhDkyytOJyQmTQcJ8o20CssbgRa
         8/MfW0FGA2sNOT1WWxnbEX9/vTudaqYWx6LMNtt8rXhhcbgVtc8IRxwmm2gWcAiEJx
         dYJdpWy5sEdfSWvuvJ4nNn/qbUAF0dUAKyT/aj5In5RPvMqPftLA5QGLfGfVjh4vIJ
         OivBhTzPtOr60JrBMHkm4fu+hwsQiPJV2Uyisu8zsQ4A+KoEP9y6Ng+UbgwfY8zvvP
         Q78ibgx/h8zCg==
Date:   Wed, 8 Nov 2023 10:28:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Message-ID: <20231108-copper-scoff-b4de5febb954@spud>
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <20231107-expensive-jitters-92e454f77ea8@spud>
 <8b17622b-de1a-4075-9527-8755f5e4dc14@amd.com>
 <20231108-five-womankind-6ee2462c93b9@spud>
 <5a26431a-22bd-43f7-a9bc-d167fb8fc32c@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eFxYKD4/Qq+eY5iy"
Content-Disposition: inline
In-Reply-To: <5a26431a-22bd-43f7-a9bc-d167fb8fc32c@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eFxYKD4/Qq+eY5iy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 11:24:20AM +0100, Michal Simek wrote:
>=20
>=20
> On 11/8/23 11:12, Conor Dooley wrote:
> > On Wed, Nov 08, 2023 at 11:06:53AM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 11/7/23 22:18, Conor Dooley wrote:
> > > > On Tue, Nov 07, 2023 at 12:09:58PM +0100, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/6/23 18:07, Conor Dooley wrote:
> > > > > > On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
> > > > > > > MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V process=
or IP.
> > > > > > > It is hardware compatible with classic MicroBlaze processor. =
Processor can
> > > > > > > be used with standard AMD/Xilinx IPs including interrupt cont=
roller and
> > > > > > > timer.
> > > > > > >=20
> > > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > > ---
> > > > > > >=20
> > > > > > >     .../devicetree/bindings/soc/amd/amd.yaml      | 26 ++++++=
+++++++++++++
> > > > > >=20
> > > > > > Bindings for SoCs (and by extension boards with them) usually g=
o to in
> > > > > > $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is th=
is any
> > > > > > different?
> > > > >=20
> > > > > I actually found it based on tracking renesas.yaml which describe=
s one of
> > > > > risc-v board. No problem to move it under bindings/riscv/
> > > >=20
> > > > That one is kinda a special case, as it contains arm/arm64/riscv.
> > >=20
> > > If they are kinda a special case then what are we?
> > > All AMD/Xilinx platforms(ZynqMP/Versal/Versal NET) can have
> > > arm/arm64/riscv/microblaze cpus(riscv/microblaze as soft cores) in th=
e same
> > > board (IIRC I have also seen xtensa soft core on our chips too).
> >=20
> > That would be an argument iff you had all of those in a single file, not
> > when you only have a single compatible for a riscv "soc" in it.
>=20
> But DT (compare to System DT) is all the time describing system from cpu
> point of view. Or are they describing all that 3 different cpus via the s=
ame
> DT?

Please look at the contents of renesas.yaml & the commit that moved it
to its current location. I'm only talking about the binding, not any
users.

--eFxYKD4/Qq+eY5iy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUtixQAKCRB4tDGHoIJi
0rc2AP9ihxjYvK4TYsfzd17YCoxHIQwKb2rMm4QrWzT92UGJAwEA1c6V6UTZs7YN
TKzHzvsTDRAh7B4x1UfP554yE0tqigs=
=iJAi
-----END PGP SIGNATURE-----

--eFxYKD4/Qq+eY5iy--
