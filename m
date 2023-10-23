Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75647D2CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjJWI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjJWI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:26:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E608E0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7716AC433C7;
        Mon, 23 Oct 2023 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698049576;
        bh=QM64lPqdI6BQGLDm91ZW9OBJezFuw8NFSML0z7gI9+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jd/ehic1pBzvp6zxfw6Su5iynYrBleMT4gcJTQK2BMRblhpuvwDLIl4iSqwdnwk8L
         aSExVjyu5gKodRUjg9CmNlgtJqpat6jxUh/laOyFXp2RdVcn66B97M02hJ8is29nq9
         qCzxBN5I+KJVPDvekj6jpQyVCoj5xQyJ7VGRufovW/GtKQWJF9s8NNa21uqe1JBdBc
         dcUIvRmByNsUU9dG8o6B5LSKQeXDQrG4Efqy8ZxwJy88Bu1LDK/qtX4+NZpFmjTdsR
         SVtmfREpU71Of7yv+BeOJLkOTPsXyf8YnOQaM/9RcfbpTqp+MsugvYPgvojnuuCa0e
         mSJhcLMFh7miw==
Date:   Mon, 23 Oct 2023 09:26:09 +0100
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
Message-ID: <20231023-impulse-quickness-4c7076e6eb58@spud>
References: <20231019140119.3659651-1-peterlin@andestech.com>
 <20231019-predator-quartet-e56f43d5aa8d@spud>
 <ZTJAYqk_DnrR9-Sc@APC323>
 <20231020-snippet-diffusive-1a6052d52aae@spud>
 <ZTTmtVnZrioRWpJx@APC323>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hsHv2ICBfypmqCUB"
Content-Disposition: inline
In-Reply-To: <ZTTmtVnZrioRWpJx@APC323>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hsHv2ICBfypmqCUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 05:09:09PM +0800, Yu-Chien Peter Lin wrote:
> On Fri, Oct 20, 2023 at 10:05:20AM +0100, Conor Dooley wrote:
> > On Fri, Oct 20, 2023 at 04:54:58PM +0800, Yu-Chien Peter Lin wrote:
> > > On Thu, Oct 19, 2023 at 05:13:00PM +0100, Conor Dooley wrote:
> > > > On Thu, Oct 19, 2023 at 10:01:19PM +0800, Yu Chien Peter Lin wrote:
> > > >=20
> > > > $subject: perf: RISC-V: Move T-Head PMU to CPU feature alternative =
framework
> > > >=20
> > > > IMO, this should be "RISC-V, perf:" or just "RISC-V" as the changes
> > > > being made to the arch code are far more meaningful than those
> > > > elsewhere.
> > >=20
> > > OK will update the subject to "RISC-V:"
> > >=20
> > > > > The custom PMU extension was developed to support perf event samp=
ling
> > > > > prior to the ratification of Sscofpmf. Instead of utilizing the s=
tandard
> > > > > bits and CSR of Sscofpmf, a set of custom CSRs is added. So we may
> > > > > consider it as a CPU feature rather than an erratum.
> > > > >=20
> > > > > T-Head cores need to append "xtheadpmu" to the riscv,isa-extensio=
ns
> > > > > for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_=
PMU
> > > > > for proper functioning as of this commit.
> > > >=20
> > > > And in doing so, you regress break perf for existing DTs :(
> > > > You didn't add the property to existing DTS in-kernel either, so if=
 this
> > > > series was applied, perf would just entirely stop working, no?
> > >=20
> > > Only `perf record/top` stop working I think.
> > >=20
> > > There are too many users out there, and don't have the boards to
> > > test, so leave those DTS unchanged, it would be great if T-Head
> > > community could help to check/update their DTS.
> >=20
> > So, there are too many users to add xtheadpmu to the devicetrees, but
> > not too many users to make changes that will cause a regression?
> > I'm not following the logic here, sorry.
>=20
> humm, I'll try. I assume that the sun20i-d1s.dtsi is all I need
> to update for T-Head PMU.

I think you can actually add it to all users of T-Head CPUs currently in
mainline since all those cpus report the 0 mimpid and 0 marchid that is
being used as the detection method in the current code.

That said, changing the in-kernel devicetrees doesn't solve the
regression problem. Not every dts lives in the linux codebase, for
example, and just because they don't, doesn't mean we can just not
care about them!

As a result, I don't think that we can just do a conversion here from
one method to another like this, since it's likely to break things for
people. Certainly interested in hearing from those that support the
T-Head IP based SoCs about whether they'd be okay with something like
this.

> > > > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > > > ---
> > > > > Hi All,
> > > > >=20
> > > > > This is in preparation for introducing other PMU alternative.
> > > > > We follow Conor's suggestion [1] to use cpu feature alternative
> > > > > framework rather than errta, if you want to stick with errata
> > > > > alternative or have other issues, please let me know. Thanks.
> > > >=20
> > > > Personally, I like this conversion, but it is going to regress supp=
ort
> > > > for perf on any T-Head cores which may be a bitter pill to get peop=
le to
> > > > actually accept...
> > > > Perhaps we could add this "improved" detection in parallel, and
> > > > eventually remove the m*id based stuff in the future.
> > > >=20
> > > > > [1] https://patchwork.kernel.org/project/linux-riscv/patch/202309=
07021635.1002738-4-peterlin@andestech.com/#25503860
> > > > >=20
> > > > > Changes v1 -> v2:
> > > > >   - New patch
> > > > > ---
> >=20
> > > > > @@ -805,7 +816,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pm=
u *pmu, struct platform_device *pde
> > > > >  	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > > > >  		riscv_pmu_irq_num =3D RV_IRQ_PMU;
> > > > >  		riscv_pmu_use_irq =3D true;
> > > > > -	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> > > > > +	} else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
> > > > > +		   IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU) &&
> > > > >  		   riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
> > > > >  		   riscv_cached_marchid(0) =3D=3D 0 &&
> > > > >  		   riscv_cached_mimpid(0) =3D=3D 0) {
> > > >=20
> > > > Can all of the m*id checks be removed, since the firmware is now
> > > > explicitly telling us that the T-Head PMU is supported?
> > >=20
> > > I can only comfirm that boards with "allwinner,sun20i-d1" compatible
> > > string uses the T-Head PMU device callbacks.
> >=20
> > I'm not sure how that is an answer to my question.
>=20
> Sorry for that unclear answer.
> Yes, I agree we no longer need to check the m*id here.

> In OpenSBI, it appears that allwinner D1 is the only platform that
> has T-Head PMU support, the other T-Head platforms need to ensure
> that the callbacks [1] are registered in order to work with SBI
> PMU driver in kernel.

> [1] https://github.com/riscv-software-src/opensbi/blob/v1.3.1/platform/ge=
neric/allwinner/sun20i-d1.c#L263-L272

There may be forks of OpenSBI, or other SBI providers, in use that
configure this correctly for other SoCs with T-Head cores, so while this
is a good indicator, it can't really be taken as gospel. Although, the
T-Head vendor fork can be ignored, as that doesn't even seem to be
capable of booting mainline kernels, given recent issues with the th1520
systems.

Cheers,
Conor.

--hsHv2ICBfypmqCUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTYuIQAKCRB4tDGHoIJi
0tNXAQDfAMhgJsETy7fO+P8fM3IdnDEk3QtOJjIEpr/vVLa+AAEAnt2g8+h2DAqJ
ghfe/MYLiGfgoqr9D49LM1GCA8RFSAo=
=vkex
-----END PGP SIGNATURE-----

--hsHv2ICBfypmqCUB--
