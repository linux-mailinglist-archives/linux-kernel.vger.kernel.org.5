Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004177CFDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbjJSPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbjJSPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:33:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892F18F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:33:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5FDC433C8;
        Thu, 19 Oct 2023 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729597;
        bh=HwwRNCwT8BYB1JzATrYA1vnmNd3NZ1gsX/BTgIeQxys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N97pbG5eH+rIsR4tEcQlulJ2kgrWW2CryHjiZOTPl5Li7NNuRFr7bLP5lcqz06mb8
         I0yq83Oz7HW3+xQj2QxqHqRZvb7UvfQQJF1JLaAWhqjApWcvYt5CgteXF7OEntP3yB
         e+/sKHHlXiqrMgRmA4oy/muxqBC44EUPh76dQMzwrY0Q2fZCNuCkwhNoGlaDwqFvUj
         sE7xiMKRnN68hE7eoJDiEVZFu6KO0BWkPpeMdESqXx22QsqFKg/vGJYnu+DVeb0iO3
         JQQygDm6uKa9lDbcIXYvBau0PjJay6LR1B6BRuy4WnGAk+j+4F0fAkFEuO55Zb2lfA
         CeA7SsZiSU+9A==
Date:   Thu, 19 Oct 2023 16:33:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, Jerry Shih <jerry.shih@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
Message-ID: <20231019-nuclear-vista-ef3e0b9bef71@spud>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com>
 <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
 <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
 <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VdNzOK6fe6sE2V7+"
Content-Disposition: inline
In-Reply-To: <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VdNzOK6fe6sE2V7+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:35:59AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
>=20
>=20
> On 18/10/2023 19:26, Evan Green wrote:
> > On Wed, Oct 18, 2023 at 5:53=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >>
> >>
> >> On 18/10/2023 03:45, Jerry Shih wrote:
> >>> On Oct 17, 2023, at 21:14, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.c=
om> wrote:
> >>>> @@ -221,6 +261,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[]=
 =3D {
> >>>>      __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> >>>>      __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> >>>>      __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> >>>> +    __RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> >>>> +    __RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> >>>> +    __RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> >>>
> >>> The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bundl=
ed with `Zvbb`.
> >>
> >> Hi Jerry,
> >>
> >> Thanks for catching this, I think some other extensions will fall in
> >> this category as well then (Zvknha/Zvknhb). I will verify that.
> >=20
> > The bundling mechanism works well when an extension is a pure lasso
> > around other extensions. We'd have to tweak that code if we wanted to
> > support cases like this, where the extension is a superset of others,
> > but also contains loose change not present anywhere else (and
> > therefore also needs to stand as a separate bit).
>=20
> For Zvbb and Zvknhb, I used the following code:
>=20
> static const unsigned int riscv_zvbb_bundled_exts[] =3D {
> 	RISCV_ISA_EXT_ZVKB,
> 	RISCV_ISA_EXT_ZVBB
> };
>=20
> static const unsigned int riscv_zvknhb_bundled_exts[] =3D {
> 	RISCV_ISA_EXT_ZVKNHA,
> 	RISCV_ISA_EXT_ZVKNHB
> };
>=20
> Which correctly results in both extension (superset + base set) being
> enabled when only one is set. Is there something that I'm missing ?
>=20
> >=20
> > IMO, decomposing "pure" bundles makes sense since otherwise usermode
> > would have to query multiple distinct bitmaps that meant the same
> > thing (eg check the Zk bit, or maybe check the Zkn/Zkr/Zkt bits, or
> > maybe check the Zbkb/Zbkc... bits, and they're all equivalent). But
> > when an extension is a superset that also contains loose change, there
> > really aren't two equivalent bitmasks, each bit adds something new.
>=20
> Agreed but if a system only report ZVBB for instance and the user wants
> ZVKB, then it is clear that ZVKB should be reported as well I guess. So
> in the end, it works much like "bundle" extension, just that the bundle
> is actually a "real" ISA extension by itself.
>=20
> Cl=C3=A9ment
>=20
> >=20
> > There's an argument to be made for still turning on the containing
> > extensions to cover for silly ISA strings (eg ISA strings that
> > advertise the superset but fail to advertise the containing
> > extensions). We can decide if we want to work that hard to cover
> > hypothetical broken ISA strings now, or wait until they show up.
> > Personally I would wait until something broken shows up. But others
> > may feel differently.

I'm not really sure that those are "silly" ISA strings. People are going
to do it that way because it is much easier than spelling out 5 dozen
sub-components, and it is pretty inevitable that subsets will be
introduced in the future for extensions we currently have.

IMO, it's perfectly valid to say you have the supersets and not spell
out all the subcomponents.

--VdNzOK6fe6sE2V7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTFMOAAKCRB4tDGHoIJi
0jJxAQDXlhaCx8sNyUh8SSBPQepeS21XzSfsPqfo0fiwFpQb7wD/QhyzMzwWfC/1
nl0r8JLAMrkerLCK3Mpf0dfHXirH+Ag=
=NsYQ
-----END PGP SIGNATURE-----

--VdNzOK6fe6sE2V7+--
