Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABD7D0B17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376559AbjJTJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376539AbjJTJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:05:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C8AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:05:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD4C433C7;
        Fri, 20 Oct 2023 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697792728;
        bh=Q2i9cGMMYMVelZA9jo7bWwCUpM96iBnURwnpSnHzXg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wchl94Qi9hV+Vi4rtCKso9+DojD9vgE2mBuYsml/2HTQuuWqaONwikdibV/L0utDh
         W6e1US1Qu5JgEufPe+Emtd4PAffm3XUuWyL/4rT95jwY3iwbPdDh9m3rUPx67XPWnA
         xVIvSoGT0aBVZiU4KdO94lDZ7MYCO1v2sMB0pp1ViK/HxJdG11ikb6AxRaxdmLUXsB
         Yr7gaptM/hY5iKNqz5+Jjb2238Nrwdta3o7XyczhhEqegkZcKMinWS4Zuk1cgeErzy
         mMF5Js9z7hOATCKn6/uJpXuQGLOo8PKG5JwEhhgR77Zg8Sv5fc1ikxAz8N0bRgrQJ7
         Ka2/s4MKLegQw==
Date:   Fri, 20 Oct 2023 10:05:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, will@kernel.org, mark.rutland@arm.com,
        atishp@atishpatra.org, anup@brainfault.org,
        conor.dooley@microchip.com, evan@rivosinc.com, jszhang@kernel.org,
        ajones@ventanamicro.com, rdunlap@infradead.org, heiko@sntech.de,
        samuel@sholland.org, guoren@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, uwu@icenowy.me,
        sunilvl@ventanamicro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tim609@andestech.com, dylan@andestech.com, locus84@andestech.com,
        dminus@andestech.com
Subject: Re: [RFC PATCH v2 07/10] perf: RISC-V: Move T-Head PMU to CPU
 feature alternative framework
Message-ID: <20231020-snippet-diffusive-1a6052d52aae@spud>
References: <20231019140119.3659651-1-peterlin@andestech.com>
 <20231019-predator-quartet-e56f43d5aa8d@spud>
 <ZTJAYqk_DnrR9-Sc@APC323>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvYVzaew7WL+CCDC"
Content-Disposition: inline
In-Reply-To: <ZTJAYqk_DnrR9-Sc@APC323>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvYVzaew7WL+CCDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:54:58PM +0800, Yu-Chien Peter Lin wrote:
> On Thu, Oct 19, 2023 at 05:13:00PM +0100, Conor Dooley wrote:
> > On Thu, Oct 19, 2023 at 10:01:19PM +0800, Yu Chien Peter Lin wrote:
> >=20
> > $subject: perf: RISC-V: Move T-Head PMU to CPU feature alternative fram=
ework
> >=20
> > IMO, this should be "RISC-V, perf:" or just "RISC-V" as the changes
> > being made to the arch code are far more meaningful than those
> > elsewhere.
>=20
> OK will update the subject to "RISC-V:"
>=20
> > > The custom PMU extension was developed to support perf event sampling
> > > prior to the ratification of Sscofpmf. Instead of utilizing the stand=
ard
> > > bits and CSR of Sscofpmf, a set of custom CSRs is added. So we may
> > > consider it as a CPU feature rather than an erratum.
> > >=20
> > > T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> > > for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> > > for proper functioning as of this commit.
> >=20
> > And in doing so, you regress break perf for existing DTs :(
> > You didn't add the property to existing DTS in-kernel either, so if this
> > series was applied, perf would just entirely stop working, no?
>=20
> Only `perf record/top` stop working I think.
>=20
> There are too many users out there, and don't have the boards to
> test, so leave those DTS unchanged, it would be great if T-Head
> community could help to check/update their DTS.

So, there are too many users to add xtheadpmu to the devicetrees, but
not too many users to make changes that will cause a regression?
I'm not following the logic here, sorry.

> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > ---
> > > Hi All,
> > >=20
> > > This is in preparation for introducing other PMU alternative.
> > > We follow Conor's suggestion [1] to use cpu feature alternative
> > > framework rather than errta, if you want to stick with errata
> > > alternative or have other issues, please let me know. Thanks.
> >=20
> > Personally, I like this conversion, but it is going to regress support
> > for perf on any T-Head cores which may be a bitter pill to get people to
> > actually accept...
> > Perhaps we could add this "improved" detection in parallel, and
> > eventually remove the m*id based stuff in the future.
> >=20
> > > [1] https://patchwork.kernel.org/project/linux-riscv/patch/2023090702=
1635.1002738-4-peterlin@andestech.com/#25503860
> > >=20
> > > Changes v1 -> v2:
> > >   - New patch
> > > ---

> > > @@ -805,7 +816,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *p=
mu, struct platform_device *pde
> > >  	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > >  		riscv_pmu_irq_num =3D RV_IRQ_PMU;
> > >  		riscv_pmu_use_irq =3D true;
> > > -	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> > > +	} else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
> > > +		   IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU) &&
> > >  		   riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
> > >  		   riscv_cached_marchid(0) =3D=3D 0 &&
> > >  		   riscv_cached_mimpid(0) =3D=3D 0) {
> >=20
> > Can all of the m*id checks be removed, since the firmware is now
> > explicitly telling us that the T-Head PMU is supported?
>=20
> I can only comfirm that boards with "allwinner,sun20i-d1" compatible
> string uses the T-Head PMU device callbacks.

I'm not sure how that is an answer to my question.

Thanks,
Conor.

--XvYVzaew7WL+CCDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTJC0AAKCRB4tDGHoIJi
0nHaAP9s0/KCk/++o9jSsTNdeG7318oIWBROwIxsdrZtV6H4SQD7BoW0i5nWJUh4
W9BZgM6pk4vdZ+gv3m1w/T8J/I4KlQQ=
=q6XB
-----END PGP SIGNATURE-----

--XvYVzaew7WL+CCDC--
