Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8977E531B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbjKHKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjKHKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:12:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4E1728
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:12:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B69C433C8;
        Wed,  8 Nov 2023 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699438346;
        bh=AbtY/mFze6zgK8MQbZQ6ERWatOJKIZmTR+VQEQ/f2fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpHxRraXzWcp9um51jU45WFFZQyJNdH6TXDUCXJKhrQL3JvgVMthksJk0u5yCegYL
         TwbEkteBlMWLK7d0z7ZzKKtUASfpRPXfOVV2fIHFShKsL5jyH3tzHLg6gt013enPim
         up9rdqE1IgC0AYoDr/XTsJxa4whKZX1fw+xpQulf6g8M8lsXfTvymrL9TqJj4ygRLh
         sv3vTHe3ETfB12VYOwjoQx9d2pyA6q+sKdguWiDBxb42N31V0iP8jZrvuZ1YYJawzc
         +h6+PSfHUahKHR1UEMWyhb22WlnBw1glKLTA3252lERdAHhL3q6Sd0N7erRtrdiNLt
         XMj5+2+Gj1ZPA==
Date:   Wed, 8 Nov 2023 10:12:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Message-ID: <20231108-five-womankind-6ee2462c93b9@spud>
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <20231107-expensive-jitters-92e454f77ea8@spud>
 <8b17622b-de1a-4075-9527-8755f5e4dc14@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G1+2ugXbEtPAn3nK"
Content-Disposition: inline
In-Reply-To: <8b17622b-de1a-4075-9527-8755f5e4dc14@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G1+2ugXbEtPAn3nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 11:06:53AM +0100, Michal Simek wrote:
>=20
>=20
> On 11/7/23 22:18, Conor Dooley wrote:
> > On Tue, Nov 07, 2023 at 12:09:58PM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 11/6/23 18:07, Conor Dooley wrote:
> > > > On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
> > > > > MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor I=
P.
> > > > > It is hardware compatible with classic MicroBlaze processor. Proc=
essor can
> > > > > be used with standard AMD/Xilinx IPs including interrupt controll=
er and
> > > > > timer.
> > > > >=20
> > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > ---
> > > > >=20
> > > > >    .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++=
++++++++
> > > >=20
> > > > Bindings for SoCs (and by extension boards with them) usually go to=
 in
> > > > $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this a=
ny
> > > > different?
> > >=20
> > > I actually found it based on tracking renesas.yaml which describes on=
e of
> > > risc-v board. No problem to move it under bindings/riscv/
> >=20
> > That one is kinda a special case, as it contains arm/arm64/riscv.
>=20
> If they are kinda a special case then what are we?
> All AMD/Xilinx platforms(ZynqMP/Versal/Versal NET) can have
> arm/arm64/riscv/microblaze cpus(riscv/microblaze as soft cores) in the sa=
me
> board (IIRC I have also seen xtensa soft core on our chips too).

That would be an argument iff you had all of those in a single file, not
when you only have a single compatible for a riscv "soc" in it.

--G1+2ugXbEtPAn3nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUtfBQAKCRB4tDGHoIJi
0oGkAQCOlynYcqYzbJW9/y5wv3scanv4SU3OnBIPS1V6IlHuhAD+JMDO7E6DuVN1
D6r49nat9xH3V3kodZUw/6bTGeR/ug4=
=+/Bj
-----END PGP SIGNATURE-----

--G1+2ugXbEtPAn3nK--
